Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB937445982
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 19:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234134AbhKDSVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 14:21:54 -0400
Received: from mga02.intel.com ([134.134.136.20]:29681 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231956AbhKDSVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 14:21:46 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10158"; a="218963050"
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="gz'50?scan'50,208,50";a="218963050"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2021 11:19:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,209,1631602800"; 
   d="gz'50?scan'50,208,50";a="600365015"
Received: from lkp-server02.sh.intel.com (HELO c20d8bc80006) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 04 Nov 2021 11:19:04 -0700
Received: from kbuild by c20d8bc80006 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mihKJ-0006en-VL; Thu, 04 Nov 2021 18:19:03 +0000
Date:   Fri, 5 Nov 2021 02:18:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petr Machata <petrm@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:petrm_leftovers 31/33] net/sched/act_dpxfer.c:13:13:
 warning: 'struct tcf_result' declared inside parameter list will not be
 visible outside of this definition or declaration
Message-ID: <202111050205.mcL8o14X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/jpirko/linux_mlxsw petrm_leftovers
head:   99db5530c934193451b2a6d90792f37ac803ea93
commit: 82da66831b70737dfca05d0da5318181965b56c0 [31/33] dpxfer xxx
config: i386-randconfig-s032-20211104 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/jpirko/linux_mlxsw/commit/82da66831b70737dfca05d0da5318181965b56c0
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw petrm_leftovers
        git checkout 82da66831b70737dfca05d0da5318181965b56c0
        # save the attached .config to linux build tree
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash net/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/sched/act_dpxfer.c:13:13: warning: 'struct tcf_result' declared inside parameter list will not be visible outside of this definition or declaration
      13 |      struct tcf_result *res)
         |             ^~~~~~~~~~
>> net/sched/act_dpxfer.c:12:61: warning: 'struct tc_action' declared inside parameter list will not be visible outside of this definition or declaration
      12 | static int tcf_dpxfer_act(struct sk_buff *skb, const struct tc_action *a,
         |                                                             ^~~~~~~~~
>> net/sched/act_dpxfer.c:12:34: warning: 'struct sk_buff' declared inside parameter list will not be visible outside of this definition or declaration
      12 | static int tcf_dpxfer_act(struct sk_buff *skb, const struct tc_action *a,
         |                                  ^~~~~~~
   net/sched/act_dpxfer.c: In function 'tcf_dpxfer_act':
   net/sched/act_dpxfer.c:15:9: error: 'TC_ACT_OK' undeclared (first use in this function)
      15 |  return TC_ACT_OK;
         |         ^~~~~~~~~
   net/sched/act_dpxfer.c:15:9: note: each undeclared identifier is reported only once for each function it appears in
   net/sched/act_dpxfer.c: At top level:
   net/sched/act_dpxfer.c:18:56: warning: 'struct tc_action' declared inside parameter list will not be visible outside of this definition or declaration
      18 | static int tcf_dpxfer_dump(struct sk_buff *skb, struct tc_action *a, int bind,
         |                                                        ^~~~~~~~~
   net/sched/act_dpxfer.c:18:35: warning: 'struct sk_buff' declared inside parameter list will not be visible outside of this definition or declaration
      18 | static int tcf_dpxfer_dump(struct sk_buff *skb, struct tc_action *a, int bind,
         |                                   ^~~~~~~
   net/sched/act_dpxfer.c: In function 'tcf_dpxfer_dump':
   net/sched/act_dpxfer.c:21:21: error: implicit declaration of function 'skb_tail_pointer' [-Werror=implicit-function-declaration]
      21 |  unsigned char *b = skb_tail_pointer(skb);
         |                     ^~~~~~~~~~~~~~~~
>> net/sched/act_dpxfer.c:21:21: warning: initialization of 'unsigned char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   net/sched/act_dpxfer.c:22:25: error: implicit declaration of function 'to_dpxfer' [-Werror=implicit-function-declaration]
      22 |  struct tcf_dpxfer *s = to_dpxfer(a);
         |                         ^~~~~~~~~
>> net/sched/act_dpxfer.c:22:25: warning: initialization of 'struct tcf_dpxfer *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   net/sched/act_dpxfer.c:23:9: error: variable 'opt' has initializer but incomplete type
      23 |  struct tc_dpxfer opt = {
         |         ^~~~~~~~~
   net/sched/act_dpxfer.c:24:4: error: 'struct tc_dpxfer' has no member named 'index'
      24 |   .index      = s->tcf_index,
         |    ^~~~~
   net/sched/act_dpxfer.c:24:18: error: dereferencing pointer to incomplete type 'struct tcf_dpxfer'
      24 |   .index      = s->tcf_index,
         |                  ^~
>> net/sched/act_dpxfer.c:24:17: warning: excess elements in struct initializer
      24 |   .index      = s->tcf_index,
         |                 ^
   net/sched/act_dpxfer.c:24:17: note: (near initialization for 'opt')
   net/sched/act_dpxfer.c:25:4: error: 'struct tc_dpxfer' has no member named 'refcnt'
      25 |   .refcnt     = refcount_read(&s->tcf_refcnt) - ref,
         |    ^~~~~~
   net/sched/act_dpxfer.c:25:17: error: implicit declaration of function 'refcount_read' [-Werror=implicit-function-declaration]
      25 |   .refcnt     = refcount_read(&s->tcf_refcnt) - ref,
         |                 ^~~~~~~~~~~~~
   net/sched/act_dpxfer.c:25:17: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:25:17: note: (near initialization for 'opt')
   net/sched/act_dpxfer.c:26:4: error: 'struct tc_dpxfer' has no member named 'bindcnt'
      26 |   .bindcnt    = atomic_read(&s->tcf_bindcnt) - bind,
         |    ^~~~~~~
   net/sched/act_dpxfer.c:26:17: error: implicit declaration of function 'atomic_read' [-Werror=implicit-function-declaration]
      26 |   .bindcnt    = atomic_read(&s->tcf_bindcnt) - bind,
         |                 ^~~~~~~~~~~
   net/sched/act_dpxfer.c:26:17: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:26:17: note: (near initialization for 'opt')
   net/sched/act_dpxfer.c:23:19: error: storage size of 'opt' isn't known
      23 |  struct tc_dpxfer opt = {
         |                   ^~~
   net/sched/act_dpxfer.c:28:15: error: storage size of 't' isn't known
      28 |  struct tcf_t t;
         |               ^
   net/sched/act_dpxfer.c:30:2: error: implicit declaration of function 'spin_lock_bh' [-Werror=implicit-function-declaration]
      30 |  spin_lock_bh(&s->tcf_lock);
         |  ^~~~~~~~~~~~
   net/sched/act_dpxfer.c:33:6: error: implicit declaration of function 'nla_put' [-Werror=implicit-function-declaration]
      33 |  if (nla_put(skb, TCA_DPXFER_PARMS, sizeof(opt), &opt))
         |      ^~~~~~~
   net/sched/act_dpxfer.c:33:19: error: 'TCA_DPXFER_PARMS' undeclared (first use in this function)
      33 |  if (nla_put(skb, TCA_DPXFER_PARMS, sizeof(opt), &opt))
         |                   ^~~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:36:2: error: implicit declaration of function 'tcf_tm_dump' [-Werror=implicit-function-declaration]
      36 |  tcf_tm_dump(&t, &s->tcf_tm);
         |  ^~~~~~~~~~~
   net/sched/act_dpxfer.c:37:6: error: implicit declaration of function 'nla_put_64bit' [-Werror=implicit-function-declaration]
      37 |  if (nla_put_64bit(skb, TCA_DPXFER_TM, sizeof(t), &t, TCA_DPXFER_PAD))
         |      ^~~~~~~~~~~~~
   net/sched/act_dpxfer.c:37:25: error: 'TCA_DPXFER_TM' undeclared (first use in this function)
      37 |  if (nla_put_64bit(skb, TCA_DPXFER_TM, sizeof(t), &t, TCA_DPXFER_PAD))
         |                         ^~~~~~~~~~~~~
   net/sched/act_dpxfer.c:37:55: error: 'TCA_DPXFER_PAD' undeclared (first use in this function)
      37 |  if (nla_put_64bit(skb, TCA_DPXFER_TM, sizeof(t), &t, TCA_DPXFER_PAD))
         |                                                       ^~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:40:2: error: implicit declaration of function 'spin_unlock_bh' [-Werror=implicit-function-declaration]
      40 |  spin_unlock_bh(&s->tcf_lock);
         |  ^~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:42:12: error: dereferencing pointer to incomplete type 'struct sk_buff'
      42 |  return skb->len;
         |            ^~
   net/sched/act_dpxfer.c:46:2: error: implicit declaration of function 'nlmsg_trim' [-Werror=implicit-function-declaration]
      46 |  nlmsg_trim(skb, b);
         |  ^~~~~~~~~~
   net/sched/act_dpxfer.c:28:15: warning: unused variable 't' [-Wunused-variable]
      28 |  struct tcf_t t;
         |               ^
   net/sched/act_dpxfer.c:23:19: warning: unused variable 'opt' [-Wunused-variable]
      23 |  struct tc_dpxfer opt = {
         |                   ^~~
   net/sched/act_dpxfer.c: At top level:
   net/sched/act_dpxfer.c:52:17: error: unknown type name 'bool'
      52 |       int bind, bool rtnl_held, struct tcf_proto *tp,
         |                 ^~~~
   net/sched/act_dpxfer.c:53:7: error: unknown type name 'u32'
      53 |       u32 flags, struct netlink_ext_ack *extack)
         |       ^~~
   net/sched/act_dpxfer.c:193:15: error: variable 'act_dpxfer_ops' has initializer but incomplete type
     193 | static struct tc_action_ops act_dpxfer_ops = {
         |               ^~~~~~~~~~~~~
   net/sched/act_dpxfer.c:194:3: error: 'struct tc_action_ops' has no member named 'kind'
     194 |  .kind  = "dpxfer",
         |   ^~~~
   net/sched/act_dpxfer.c:194:11: warning: excess elements in struct initializer
     194 |  .kind  = "dpxfer",
         |           ^~~~~~~~
   net/sched/act_dpxfer.c:194:11: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:195:3: error: 'struct tc_action_ops' has no member named 'id'
     195 |  .id  = TCA_ID_DPXFER,
         |   ^~
   net/sched/act_dpxfer.c:195:9: error: 'TCA_ID_DPXFER' undeclared here (not in a function)
     195 |  .id  = TCA_ID_DPXFER,
         |         ^~~~~~~~~~~~~
   net/sched/act_dpxfer.c:195:9: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:195:9: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:196:3: error: 'struct tc_action_ops' has no member named 'owner'
     196 |  .owner  = THIS_MODULE,
         |   ^~~~~
   net/sched/act_dpxfer.c:196:12: error: 'THIS_MODULE' undeclared here (not in a function); did you mean 'IS_MODULE'?
     196 |  .owner  = THIS_MODULE,
         |            ^~~~~~~~~~~
         |            IS_MODULE
   net/sched/act_dpxfer.c:196:12: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:196:12: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:197:3: error: 'struct tc_action_ops' has no member named 'act'
     197 |  .act  = tcf_dpxfer_act,
         |   ^~~
   net/sched/act_dpxfer.c:197:10: warning: excess elements in struct initializer
     197 |  .act  = tcf_dpxfer_act,
         |          ^~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:197:10: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:198:3: error: 'struct tc_action_ops' has no member named 'stats_update'
     198 |  .stats_update = tcf_stats_update,
         |   ^~~~~~~~~~~~
   net/sched/act_dpxfer.c:198:18: error: 'tcf_stats_update' undeclared here (not in a function)
     198 |  .stats_update = tcf_stats_update,
         |                  ^~~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:198:18: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:198:18: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:199:3: error: 'struct tc_action_ops' has no member named 'dump'
     199 |  .dump  = tcf_dpxfer_dump,
         |   ^~~~
   net/sched/act_dpxfer.c:199:11: warning: excess elements in struct initializer
     199 |  .dump  = tcf_dpxfer_dump,
         |           ^~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:199:11: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:200:3: error: 'struct tc_action_ops' has no member named 'init'
     200 |  .init  = tcf_dpxfer_init,
         |   ^~~~
   net/sched/act_dpxfer.c:200:11: error: 'tcf_dpxfer_init' undeclared here (not in a function); did you mean 'tcf_dpxfer_act'?
     200 |  .init  = tcf_dpxfer_init,
         |           ^~~~~~~~~~~~~~~
         |           tcf_dpxfer_act
   net/sched/act_dpxfer.c:200:11: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:200:11: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:201:3: error: 'struct tc_action_ops' has no member named 'walk'
     201 |  .walk  = tcf_dpxfer_walker,
         |   ^~~~
   net/sched/act_dpxfer.c:201:11: error: 'tcf_dpxfer_walker' undeclared here (not in a function); did you mean 'tcf_dpxfer_act'?
     201 |  .walk  = tcf_dpxfer_walker,
         |           ^~~~~~~~~~~~~~~~~
         |           tcf_dpxfer_act
   net/sched/act_dpxfer.c:201:11: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:201:11: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:202:3: error: 'struct tc_action_ops' has no member named 'lookup'
     202 |  .lookup  = tcf_dpxfer_search,
         |   ^~~~~~
   net/sched/act_dpxfer.c:202:13: error: 'tcf_dpxfer_search' undeclared here (not in a function); did you mean 'tcf_dpxfer_act'?
     202 |  .lookup  = tcf_dpxfer_search,
         |             ^~~~~~~~~~~~~~~~~
         |             tcf_dpxfer_act
   net/sched/act_dpxfer.c:202:13: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:202:13: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:203:3: error: 'struct tc_action_ops' has no member named 'get_fill_size'
     203 |  .get_fill_size = tcf_dpxfer_get_fill_size,
         |   ^~~~~~~~~~~~~
   net/sched/act_dpxfer.c:203:19: error: 'tcf_dpxfer_get_fill_size' undeclared here (not in a function)
     203 |  .get_fill_size = tcf_dpxfer_get_fill_size,
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:203:19: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:203:19: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:204:3: error: 'struct tc_action_ops' has no member named 'size'
     204 |  .size  = sizeof(struct tcf_dpxfer),
         |   ^~~~
   net/sched/act_dpxfer.c:204:18: error: invalid application of 'sizeof' to incomplete type 'struct tcf_dpxfer'
     204 |  .size  = sizeof(struct tcf_dpxfer),
         |                  ^~~~~~
   net/sched/act_dpxfer.c:204:11: warning: excess elements in struct initializer
     204 |  .size  = sizeof(struct tcf_dpxfer),
         |           ^~~~~~
   net/sched/act_dpxfer.c:204:11: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:205:3: error: 'struct tc_action_ops' has no member named 'get_dev'
     205 |  .get_dev = tcf_dpxfer_get_dev,
         |   ^~~~~~~
   net/sched/act_dpxfer.c:205:13: error: 'tcf_dpxfer_get_dev' undeclared here (not in a function); did you mean 'tcf_dpxfer_act'?
     205 |  .get_dev = tcf_dpxfer_get_dev,
         |             ^~~~~~~~~~~~~~~~~~
         |             tcf_dpxfer_act
   net/sched/act_dpxfer.c:205:13: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:205:13: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:208:18: error: expected ';' before 'int'
     208 | static __net_init int dpxfer_init_net(struct net *net)
         |                  ^~~~
         |                  ;
>> net/sched/act_dpxfer.c:208:46: warning: 'struct net' declared inside parameter list will not be visible outside of this definition or declaration
     208 | static __net_init int dpxfer_init_net(struct net *net)
         |                                              ^~~
>> net/sched/act_dpxfer.c:208:23: warning: no previous prototype for 'dpxfer_init_net' [-Wmissing-prototypes]
     208 | static __net_init int dpxfer_init_net(struct net *net)
         |                       ^~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c: In function 'dpxfer_init_net':
   net/sched/act_dpxfer.c:210:29: error: implicit declaration of function 'net_generic' [-Werror=implicit-function-declaration]
     210 |  struct tc_action_net *tn = net_generic(net, dpxfer_net_id);
         |                             ^~~~~~~~~~~
>> net/sched/act_dpxfer.c:210:29: warning: initialization of 'struct tc_action_net *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   net/sched/act_dpxfer.c:212:9: error: implicit declaration of function 'tc_action_net_init' [-Werror=implicit-function-declaration]
     212 |  return tc_action_net_init(net, tn, &act_dpxfer_ops);
         |         ^~~~~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c: At top level:
   net/sched/act_dpxfer.c:215:24: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'dpxfer_exit_net'
     215 | static void __net_exit dpxfer_exit_net(struct list_head *net_list)
         |                        ^~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:220:15: error: variable 'dpxfer_net_ops' has initializer but incomplete type
     220 | static struct pernet_operations dpxfer_net_ops = {
         |               ^~~~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:221:3: error: 'struct pernet_operations' has no member named 'init'
     221 |  .init = dpxfer_init_net,
         |   ^~~~
   net/sched/act_dpxfer.c:221:10: warning: excess elements in struct initializer
     221 |  .init = dpxfer_init_net,
         |          ^~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:221:10: note: (near initialization for 'dpxfer_net_ops')
   net/sched/act_dpxfer.c:222:3: error: 'struct pernet_operations' has no member named 'exit_batch'
     222 |  .exit_batch = dpxfer_exit_net,
         |   ^~~~~~~~~~
   net/sched/act_dpxfer.c:222:16: error: 'dpxfer_exit_net' undeclared here (not in a function); did you mean 'dpxfer_init_net'?
     222 |  .exit_batch = dpxfer_exit_net,
         |                ^~~~~~~~~~~~~~~
         |                dpxfer_init_net
   net/sched/act_dpxfer.c:222:16: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:222:16: note: (near initialization for 'dpxfer_net_ops')
   net/sched/act_dpxfer.c:223:3: error: 'struct pernet_operations' has no member named 'id'
     223 |  .id   = &dpxfer_net_id,
         |   ^~
   net/sched/act_dpxfer.c:223:10: warning: excess elements in struct initializer
     223 |  .id   = &dpxfer_net_id,
         |          ^
   net/sched/act_dpxfer.c:223:10: note: (near initialization for 'dpxfer_net_ops')
   net/sched/act_dpxfer.c:224:3: error: 'struct pernet_operations' has no member named 'size'
     224 |  .size = sizeof(struct tc_action_net),
         |   ^~~~
   net/sched/act_dpxfer.c:224:17: error: invalid application of 'sizeof' to incomplete type 'struct tc_action_net'
     224 |  .size = sizeof(struct tc_action_net),
         |                 ^~~~~~
   net/sched/act_dpxfer.c:224:10: warning: excess elements in struct initializer
     224 |  .size = sizeof(struct tc_action_net),
         |          ^~~~~~
   net/sched/act_dpxfer.c:224:10: note: (near initialization for 'dpxfer_net_ops')
   net/sched/act_dpxfer.c:227:20: error: expected declaration specifiers or '...' before string constant
     227 | MODULE_DESCRIPTION("Datapath transfer actions");
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:228:16: error: expected declaration specifiers or '...' before string constant
     228 | MODULE_LICENSE("GPL");
         |                ^~~~~
   net/sched/act_dpxfer.c:230:19: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'dpxfer_init_module'
     230 | static int __init dpxfer_init_module(void)
         |                   ^~~~~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:235:20: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'dpxfer_cleanup_module'
     235 | static void __exit dpxfer_cleanup_module(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~
>> net/sched/act_dpxfer.c:240:1: warning: data definition has no type or storage class
     240 | module_init(dpxfer_init_module);
         | ^~~~~~~~~~~
   net/sched/act_dpxfer.c:240:1: error: type defaults to 'int' in declaration of 'module_init' [-Werror=implicit-int]
>> net/sched/act_dpxfer.c:240:1: warning: parameter names (without types) in function declaration
   net/sched/act_dpxfer.c:241:1: warning: data definition has no type or storage class
     241 | module_exit(dpxfer_cleanup_module);
         | ^~~~~~~~~~~
   net/sched/act_dpxfer.c:241:1: error: type defaults to 'int' in declaration of 'module_exit' [-Werror=implicit-int]
   net/sched/act_dpxfer.c:241:1: warning: parameter names (without types) in function declaration
   net/sched/act_dpxfer.c:193:29: error: storage size of 'act_dpxfer_ops' isn't known
     193 | static struct tc_action_ops act_dpxfer_ops = {
         |                             ^~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:220:33: error: storage size of 'dpxfer_net_ops' isn't known
     220 | static struct pernet_operations dpxfer_net_ops = {
         |                                 ^~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:220:33: warning: 'dpxfer_net_ops' defined but not used [-Wunused-variable]
   cc1: some warnings being treated as errors


vim +13 net/sched/act_dpxfer.c

    11	
  > 12	static int tcf_dpxfer_act(struct sk_buff *skb, const struct tc_action *a,
  > 13				  struct tcf_result *res)
    14	{
    15		return TC_ACT_OK;
    16	}
    17	
    18	static int tcf_dpxfer_dump(struct sk_buff *skb, struct tc_action *a, int bind,
    19				   int ref)
    20	{
  > 21		unsigned char *b = skb_tail_pointer(skb);
  > 22		struct tcf_dpxfer *s = to_dpxfer(a);
    23		struct tc_dpxfer opt = {
  > 24			.index      = s->tcf_index,
    25			.refcnt     = refcount_read(&s->tcf_refcnt) - ref,
    26			.bindcnt    = atomic_read(&s->tcf_bindcnt) - bind,
    27		};
    28		struct tcf_t t;
    29	
    30		spin_lock_bh(&s->tcf_lock);
    31	
    32		opt.action = s->tcf_action;
    33		if (nla_put(skb, TCA_DPXFER_PARMS, sizeof(opt), &opt))
    34			goto nla_put_failure;
    35	
    36		tcf_tm_dump(&t, &s->tcf_tm);
    37		if (nla_put_64bit(skb, TCA_DPXFER_TM, sizeof(t), &t, TCA_DPXFER_PAD))
    38			goto nla_put_failure;
    39	
    40		spin_unlock_bh(&s->tcf_lock);
    41	
    42		return skb->len;
    43	
    44	nla_put_failure:
    45		spin_unlock_bh(&s->tcf_lock);
    46		nlmsg_trim(skb, b);
    47		return -1;
    48	}
    49	
    50	static int tcf_dpxfer_init(struct net *net, struct nlattr *nla,
    51				   struct nlattr *est, struct tc_action **a, int ovr,
    52				   int bind, bool rtnl_held, struct tcf_proto *tp,
    53				   u32 flags, struct netlink_ext_ack *extack)
    54	{
    55		struct tc_action_net *tn = net_generic(net, gate_net_id);
    56		enum tk_offsets tk_offset = TK_OFFS_TAI;
    57		struct nlattr *tb[TCA_GATE_MAX + 1];
    58		struct tcf_chain *goto_ch = NULL;
    59		u64 cycletime = 0, basetime = 0;
    60		struct tcf_gate_params *p;
    61		s32 clockid = CLOCK_TAI;
    62		struct tcf_gate *gact;
    63		struct tc_gate *parm;
    64		int ret = 0, err;
    65		u32 gflags = 0;
    66		s32 prio = -1;
    67		ktime_t start;
    68		bool exists;
    69		u32 index;
    70	
    71		if (!nla)
    72			return -EINVAL;
    73	
    74		err = nla_parse_nested(tb, TCA_DPXFER_MAX, nla, dpxfer_policy, extack);
    75		if (err < 0)
    76			return err;
    77	
    78		if (!tb[TCA_DPXFER_PARMS])
    79			return -EINVAL;
    80	
    81		parm = nla_data(tb[TCA_GATE_PARMS]);
    82		index = parm->index;
    83	
    84		err = tcf_idr_check_alloc(tn, &index, a, bind);
    85		if (err < 0)
    86			return err;
    87	
    88		exists = err;
    89		if (exists && bind)
    90			return 0;
    91	
    92		if (!exists) {
    93			ret = tcf_idr_create(tn, index, est, a,
    94					     &act_gate_ops, bind, false, 0);
    95			if (ret) {
    96				tcf_idr_cleanup(tn, index);
    97				return ret;
    98			}
    99	
   100			ret = ACT_P_CREATED;
   101		} else if (!ovr) {
   102			tcf_idr_release(*a, bind);
   103			return -EEXIST;
   104		}
   105	
   106		if (tb[TCA_GATE_PRIORITY])
   107			prio = nla_get_s32(tb[TCA_GATE_PRIORITY]);
   108	
   109		if (tb[TCA_GATE_BASE_TIME])
   110			basetime = nla_get_u64(tb[TCA_GATE_BASE_TIME]);
   111	
   112		if (tb[TCA_GATE_FLAGS])
   113			gflags = nla_get_u32(tb[TCA_GATE_FLAGS]);
   114	
   115		gact = to_gate(*a);
   116		if (ret == ACT_P_CREATED)
   117			INIT_LIST_HEAD(&gact->param.entries);
   118	
   119		err = tcf_action_check_ctrlact(parm->action, tp, &goto_ch, extack);
   120		if (err < 0)
   121			goto release_idr;
   122	
   123		spin_lock_bh(&gact->tcf_lock);
   124		p = &gact->param;
   125	
   126		if (tb[TCA_GATE_CYCLE_TIME])
   127			cycletime = nla_get_u64(tb[TCA_GATE_CYCLE_TIME]);
   128	
   129		if (tb[TCA_GATE_ENTRY_LIST]) {
   130			err = parse_gate_list(tb[TCA_GATE_ENTRY_LIST], p, extack);
   131			if (err < 0)
   132				goto chain_put;
   133		}
   134	
   135		if (!cycletime) {
   136			struct tcfg_gate_entry *entry;
   137			ktime_t cycle = 0;
   138	
   139			list_for_each_entry(entry, &p->entries, list)
   140				cycle = ktime_add_ns(cycle, entry->interval);
   141			cycletime = cycle;
   142			if (!cycletime) {
   143				err = -EINVAL;
   144				goto chain_put;
   145			}
   146		}
   147		p->tcfg_cycletime = cycletime;
   148	
   149		if (tb[TCA_GATE_CYCLE_TIME_EXT])
   150			p->tcfg_cycletime_ext =
   151				nla_get_u64(tb[TCA_GATE_CYCLE_TIME_EXT]);
   152	
   153		gate_setup_timer(gact, basetime, tk_offset, clockid,
   154				 ret == ACT_P_CREATED);
   155		p->tcfg_priority = prio;
   156		p->tcfg_flags = gflags;
   157		gate_get_start_time(gact, &start);
   158	
   159		gact->current_close_time = start;
   160		gact->current_gate_status = GATE_ACT_GATE_OPEN | GATE_ACT_PENDING;
   161	
   162		gact->next_entry = list_first_entry(&p->entries,
   163						    struct tcfg_gate_entry, list);
   164	
   165		goto_ch = tcf_action_set_ctrlact(*a, parm->action, goto_ch);
   166	
   167		gate_start_timer(gact, start);
   168	
   169		spin_unlock_bh(&gact->tcf_lock);
   170	
   171		if (goto_ch)
   172			tcf_chain_put_by_act(goto_ch);
   173	
   174		return ret;
   175	
   176	chain_put:
   177		spin_unlock_bh(&gact->tcf_lock);
   178	
   179		if (goto_ch)
   180			tcf_chain_put_by_act(goto_ch);
   181	release_idr:
   182		/* action is not inserted in any list: it's safe to init hitimer
   183		 * without taking tcf_lock.
   184		 */
   185		if (ret == ACT_P_CREATED)
   186			gate_setup_timer(gact, gact->param.tcfg_basetime,
   187					 gact->tk_offset, gact->param.tcfg_clockid,
   188					 true);
   189		tcf_idr_release(*a, bind);
   190		return err;
   191	}
   192	
   193	static struct tc_action_ops act_dpxfer_ops = {
   194		.kind		=	"dpxfer",
   195		.id		=	TCA_ID_DPXFER,
   196		.owner		=	THIS_MODULE,
   197		.act		=	tcf_dpxfer_act,
   198		.stats_update	=	tcf_stats_update,
   199		.dump		=	tcf_dpxfer_dump,
   200		.init		=	tcf_dpxfer_init,
   201		.walk		=	tcf_dpxfer_walker,
   202		.lookup		=	tcf_dpxfer_search,
   203		.get_fill_size	=	tcf_dpxfer_get_fill_size,
   204		.size		=	sizeof(struct tcf_dpxfer),
   205		.get_dev	=	tcf_dpxfer_get_dev,
   206	};
   207	
 > 208	static __net_init int dpxfer_init_net(struct net *net)
   209	{
 > 210		struct tc_action_net *tn = net_generic(net, dpxfer_net_id);
   211	
   212		return tc_action_net_init(net, tn, &act_dpxfer_ops);
   213	}
   214	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--bg08WKrSYDhXBjb5
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
vBeEgATyKEeoBZze8xeaZclnBk8CAA==

--bg08WKrSYDhXBjb5--
