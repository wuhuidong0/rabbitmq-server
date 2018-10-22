%% The contents of this file are subject to the Mozilla Public License
%% Version 1.1 (the "License"); you may not use this file except in
%% compliance with the License. You may obtain a copy of the License
%% at http://www.mozilla.org/MPL/
%%
%% Software distributed under the License is distributed on an "AS IS"
%% basis, WITHOUT WARRANTY OF ANY KIND, either express or implied. See
%% the License for the specific language governing rights and
%% limitations under the License.
%%
%% The Original Code is RabbitMQ.
%%
%% The Initial Developer of the Original Code is GoPivotal, Inc.
%% Copyright (c) 2007-2018 Pivotal Software, Inc.  All rights reserved.
%%

-include("amqqueue_v1.hrl").
-include("amqqueue_v2.hrl").

-define(is_amqqueue(Q),
        (?is_amqqueue_v2(Q) orelse
         ?is_amqqueue_v1(Q))).

-define(amqqueue_is_auto_delete(Q),
        ((?is_amqqueue_v2(Q) andalso
          ?amqqueue_v2_field_auto_delete(Q) =:= true) orelse
         (?is_amqqueue_v1(Q) andalso
          ?amqqueue_v1_field_auto_delete(Q) =:= true))).

-define(amqqueue_is_durable(Q),
        ((?is_amqqueue_v2(Q) andalso
          ?amqqueue_v2_field_durable(Q) =:= true) orelse
         (?is_amqqueue_v1(Q) andalso
          ?amqqueue_v1_field_durable(Q) =:= true))).

-define(amqqueue_exclusive_owner_is(Q, Owner),
        ((?is_amqqueue_v2(Q) andalso
          ?amqqueue_v2_field_exclusive_owner(Q) =:= Owner) orelse
         (?is_amqqueue_v1(Q) andalso
          ?amqqueue_v1_field_exclusive_owner(Q) =:= Owner))).

-define(amqqueue_exclusive_owner_is_pid(Q),
        ((?is_amqqueue_v2(Q) andalso
          is_pid(?amqqueue_v2_field_exclusive_owner(Q))) orelse
         (?is_amqqueue_v1(Q) andalso
          is_pid(?amqqueue_v1_field_exclusive_owner(Q))))).

-define(amqqueue_state_is(Q, State),
        ((?is_amqqueue_v2(Q) andalso
          ?amqqueue_v2_field_state(Q) =:= State) orelse
         (?is_amqqueue_v1(Q) andalso
          ?amqqueue_v1_field_state(Q) =:= State))).

-define(amqqueue_v1_type, classic).

-define(amqqueue_is_classic(Q),
        ((?is_amqqueue_v2(Q) andalso
          ?amqqueue_v2_field_type(Q) =:= classic) orelse
         ?is_amqqueue_v1(Q))).

-define(amqqueue_is_quorum(Q),
        (?is_amqqueue_v2(Q) andalso
         ?amqqueue_v2_field_type(Q) =:= quorum) orelse
        false).

-define(amqqueue_has_valid_pid(Q),
        ((?is_amqqueue_v2(Q) andalso
         is_pid(?amqqueue_v2_field_pid(Q))) orelse
        (?is_amqqueue_v1(Q) andalso
         is_pid(?amqqueue_v1_field_pid(Q))))).

-define(amqqueue_pid_runs_on_local_node(Q),
        ((?is_amqqueue_v2(Q) andalso
         node(?amqqueue_v2_field_pid(Q)) =:= node()) orelse
        (?is_amqqueue_v1(Q) andalso
         node(?amqqueue_v1_field_pid(Q)) =:= node()))).

-define(amqqueue_pid_equals(Q, Pid),
        ((?is_amqqueue_v2(Q) andalso
          ?amqqueue_v2_field_pid(Q) =:= Pid) orelse
         (?is_amqqueue_v1(Q) andalso
          ?amqqueue_v1_field_pid(Q) =:= Pid))).

-define(amqqueue_pids_are_equal(Q0, Q1),
        ((?is_amqqueue_v2(Q0) andalso ?is_amqqueue_v2(Q1) andalso
          ?amqqueue_v2_field_pid(Q0) =:= ?amqqueue_v2_field_pid(Q1)) orelse
         (?is_amqqueue_v1(Q0) andalso ?is_amqqueue_v1(Q1) andalso
          ?amqqueue_v1_field_pid(Q0) =:= ?amqqueue_v1_field_pid(Q1)))).

-define(amqqueue_v1_vhost(Q), element(2, ?amqqueue_v1_field_name(Q))).
-define(amqqueue_v2_vhost(Q), element(2, ?amqqueue_v2_field_name(Q))).

-define(amqqueue_vhost_equals(Q, VHost),
        ((?is_amqqueue_v2(Q) andalso
         ?amqqueue_v2_vhost(Q) =:= VHost) orelse
        (?is_amqqueue_v1(Q) andalso
         ?amqqueue_v1_vhost(Q) =:= VHost))).
