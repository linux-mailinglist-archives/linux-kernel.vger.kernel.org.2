Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9C341E910
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 10:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352712AbhJAI0F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 04:26:05 -0400
Received: from mga05.intel.com ([192.55.52.43]:54884 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231305AbhJAI0E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 04:26:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10123"; a="310916500"
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="gz'50?scan'50,208,50";a="310916500"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2021 01:24:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,337,1624345200"; 
   d="gz'50?scan'50,208,50";a="480333199"
Received: from lkp-server01.sh.intel.com (HELO 72c3bd3cf19c) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 01 Oct 2021 01:24:17 -0700
Received: from kbuild by 72c3bd3cf19c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mWDq5-0000wu-4E; Fri, 01 Oct 2021 08:24:17 +0000
Date:   Fri, 1 Oct 2021 16:23:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Petr Machata <petrm@nvidia.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [jpirko-mlxsw:petrm_leftovers 47/50] net/sched/act_dpxfer.c:13:34:
 warning: 'struct tcf_result' declared inside parameter list will not be
 visible outside of this definition or declaration
Message-ID: <202110011647.9UsspZwk-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/jpirko/linux_mlxsw petrm_leftovers
head:   2b442e043022670cc0d74d76db2cbcf1ba7b0d89
commit: 07498c92e13674912b77d77a0879449a4541b224 [47/50] dpxfer xxx
config: sparc-randconfig-r005-20211001 (attached as .config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/jpirko/linux_mlxsw/commit/07498c92e13674912b77d77a0879449a4541b224
        git remote add jpirko-mlxsw https://github.com/jpirko/linux_mlxsw
        git fetch --no-tags jpirko-mlxsw petrm_leftovers
        git checkout 07498c92e13674912b77d77a0879449a4541b224
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash net/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> net/sched/act_dpxfer.c:13:34: warning: 'struct tcf_result' declared inside parameter list will not be visible outside of this definition or declaration
      13 |                           struct tcf_result *res)
         |                                  ^~~~~~~~~~
>> net/sched/act_dpxfer.c:12:61: warning: 'struct tc_action' declared inside parameter list will not be visible outside of this definition or declaration
      12 | static int tcf_dpxfer_act(struct sk_buff *skb, const struct tc_action *a,
         |                                                             ^~~~~~~~~
>> net/sched/act_dpxfer.c:12:34: warning: 'struct sk_buff' declared inside parameter list will not be visible outside of this definition or declaration
      12 | static int tcf_dpxfer_act(struct sk_buff *skb, const struct tc_action *a,
         |                                  ^~~~~~~
   net/sched/act_dpxfer.c: In function 'tcf_dpxfer_act':
   net/sched/act_dpxfer.c:15:16: error: 'TC_ACT_OK' undeclared (first use in this function)
      15 |         return TC_ACT_OK;
         |                ^~~~~~~~~
   net/sched/act_dpxfer.c:15:16: note: each undeclared identifier is reported only once for each function it appears in
   net/sched/act_dpxfer.c: At top level:
   net/sched/act_dpxfer.c:18:56: warning: 'struct tc_action' declared inside parameter list will not be visible outside of this definition or declaration
      18 | static int tcf_dpxfer_dump(struct sk_buff *skb, struct tc_action *a, int bind,
         |                                                        ^~~~~~~~~
   net/sched/act_dpxfer.c:18:35: warning: 'struct sk_buff' declared inside parameter list will not be visible outside of this definition or declaration
      18 | static int tcf_dpxfer_dump(struct sk_buff *skb, struct tc_action *a, int bind,
         |                                   ^~~~~~~
   net/sched/act_dpxfer.c: In function 'tcf_dpxfer_dump':
   net/sched/act_dpxfer.c:21:28: error: implicit declaration of function 'skb_tail_pointer' [-Werror=implicit-function-declaration]
      21 |         unsigned char *b = skb_tail_pointer(skb);
         |                            ^~~~~~~~~~~~~~~~
>> net/sched/act_dpxfer.c:21:28: warning: initialization of 'unsigned char *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   net/sched/act_dpxfer.c:22:32: error: implicit declaration of function 'to_dpxfer' [-Werror=implicit-function-declaration]
      22 |         struct tcf_dpxfer *s = to_dpxfer(a);
         |                                ^~~~~~~~~
>> net/sched/act_dpxfer.c:22:32: warning: initialization of 'struct tcf_dpxfer *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   net/sched/act_dpxfer.c:23:16: error: variable 'opt' has initializer but incomplete type
      23 |         struct tc_dpxfer opt = {
         |                ^~~~~~~~~
   net/sched/act_dpxfer.c:24:18: error: 'struct tc_dpxfer' has no member named 'index'
      24 |                 .index      = s->tcf_index,
         |                  ^~~~~
   net/sched/act_dpxfer.c:24:32: error: invalid use of undefined type 'struct tcf_dpxfer'
      24 |                 .index      = s->tcf_index,
         |                                ^~
>> net/sched/act_dpxfer.c:24:31: warning: excess elements in struct initializer
      24 |                 .index      = s->tcf_index,
         |                               ^
   net/sched/act_dpxfer.c:24:31: note: (near initialization for 'opt')
   net/sched/act_dpxfer.c:25:18: error: 'struct tc_dpxfer' has no member named 'refcnt'
      25 |                 .refcnt     = refcount_read(&s->tcf_refcnt) - ref,
         |                  ^~~~~~
   net/sched/act_dpxfer.c:25:31: error: implicit declaration of function 'refcount_read' [-Werror=implicit-function-declaration]
      25 |                 .refcnt     = refcount_read(&s->tcf_refcnt) - ref,
         |                               ^~~~~~~~~~~~~
   net/sched/act_dpxfer.c:25:47: error: invalid use of undefined type 'struct tcf_dpxfer'
      25 |                 .refcnt     = refcount_read(&s->tcf_refcnt) - ref,
         |                                               ^~
   net/sched/act_dpxfer.c:25:31: warning: excess elements in struct initializer
      25 |                 .refcnt     = refcount_read(&s->tcf_refcnt) - ref,
         |                               ^~~~~~~~~~~~~
   net/sched/act_dpxfer.c:25:31: note: (near initialization for 'opt')
   net/sched/act_dpxfer.c:26:18: error: 'struct tc_dpxfer' has no member named 'bindcnt'
      26 |                 .bindcnt    = atomic_read(&s->tcf_bindcnt) - bind,
         |                  ^~~~~~~
   net/sched/act_dpxfer.c:26:31: error: implicit declaration of function 'atomic_read' [-Werror=implicit-function-declaration]
      26 |                 .bindcnt    = atomic_read(&s->tcf_bindcnt) - bind,
         |                               ^~~~~~~~~~~
   net/sched/act_dpxfer.c:26:45: error: invalid use of undefined type 'struct tcf_dpxfer'
      26 |                 .bindcnt    = atomic_read(&s->tcf_bindcnt) - bind,
         |                                             ^~
   net/sched/act_dpxfer.c:26:31: warning: excess elements in struct initializer
      26 |                 .bindcnt    = atomic_read(&s->tcf_bindcnt) - bind,
         |                               ^~~~~~~~~~~
   net/sched/act_dpxfer.c:26:31: note: (near initialization for 'opt')
   net/sched/act_dpxfer.c:23:26: error: storage size of 'opt' isn't known
      23 |         struct tc_dpxfer opt = {
         |                          ^~~
   net/sched/act_dpxfer.c:28:22: error: storage size of 't' isn't known
      28 |         struct tcf_t t;
         |                      ^
   net/sched/act_dpxfer.c:30:9: error: implicit declaration of function 'spin_lock_bh' [-Werror=implicit-function-declaration]
      30 |         spin_lock_bh(&s->tcf_lock);
         |         ^~~~~~~~~~~~
   net/sched/act_dpxfer.c:30:24: error: invalid use of undefined type 'struct tcf_dpxfer'
      30 |         spin_lock_bh(&s->tcf_lock);
         |                        ^~
   net/sched/act_dpxfer.c:32:23: error: invalid use of undefined type 'struct tcf_dpxfer'
      32 |         opt.action = s->tcf_action;
         |                       ^~
   net/sched/act_dpxfer.c:33:13: error: implicit declaration of function 'nla_put' [-Werror=implicit-function-declaration]
      33 |         if (nla_put(skb, TCA_DPXFER_PARMS, sizeof(opt), &opt))
         |             ^~~~~~~
   net/sched/act_dpxfer.c:33:26: error: 'TCA_DPXFER_PARMS' undeclared (first use in this function)
      33 |         if (nla_put(skb, TCA_DPXFER_PARMS, sizeof(opt), &opt))
         |                          ^~~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:36:9: error: implicit declaration of function 'tcf_tm_dump' [-Werror=implicit-function-declaration]
      36 |         tcf_tm_dump(&t, &s->tcf_tm);
         |         ^~~~~~~~~~~
   net/sched/act_dpxfer.c:36:27: error: invalid use of undefined type 'struct tcf_dpxfer'
      36 |         tcf_tm_dump(&t, &s->tcf_tm);
         |                           ^~
   net/sched/act_dpxfer.c:37:13: error: implicit declaration of function 'nla_put_64bit' [-Werror=implicit-function-declaration]
      37 |         if (nla_put_64bit(skb, TCA_DPXFER_TM, sizeof(t), &t, TCA_DPXFER_PAD))
         |             ^~~~~~~~~~~~~
   net/sched/act_dpxfer.c:37:32: error: 'TCA_DPXFER_TM' undeclared (first use in this function)
      37 |         if (nla_put_64bit(skb, TCA_DPXFER_TM, sizeof(t), &t, TCA_DPXFER_PAD))
         |                                ^~~~~~~~~~~~~
   net/sched/act_dpxfer.c:37:62: error: 'TCA_DPXFER_PAD' undeclared (first use in this function)
      37 |         if (nla_put_64bit(skb, TCA_DPXFER_TM, sizeof(t), &t, TCA_DPXFER_PAD))
         |                                                              ^~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:40:9: error: implicit declaration of function 'spin_unlock_bh' [-Werror=implicit-function-declaration]
      40 |         spin_unlock_bh(&s->tcf_lock);
         |         ^~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:40:26: error: invalid use of undefined type 'struct tcf_dpxfer'
      40 |         spin_unlock_bh(&s->tcf_lock);
         |                          ^~
   net/sched/act_dpxfer.c:42:19: error: invalid use of undefined type 'struct sk_buff'
      42 |         return skb->len;
         |                   ^~
   net/sched/act_dpxfer.c:45:26: error: invalid use of undefined type 'struct tcf_dpxfer'
      45 |         spin_unlock_bh(&s->tcf_lock);
         |                          ^~
   net/sched/act_dpxfer.c:46:9: error: implicit declaration of function 'nlmsg_trim' [-Werror=implicit-function-declaration]
      46 |         nlmsg_trim(skb, b);
         |         ^~~~~~~~~~
   net/sched/act_dpxfer.c:28:22: warning: unused variable 't' [-Wunused-variable]
      28 |         struct tcf_t t;
         |                      ^
   net/sched/act_dpxfer.c:23:26: warning: unused variable 'opt' [-Wunused-variable]
      23 |         struct tc_dpxfer opt = {
         |                          ^~~
   net/sched/act_dpxfer.c: At top level:
   net/sched/act_dpxfer.c:52:38: error: unknown type name 'bool'
      52 |                            int bind, bool rtnl_held, struct tcf_proto *tp,
         |                                      ^~~~
   net/sched/act_dpxfer.c:53:28: error: unknown type name 'u32'
      53 |                            u32 flags, struct netlink_ext_ack *extack)
         |                            ^~~
   net/sched/act_dpxfer.c:193:15: error: variable 'act_dpxfer_ops' has initializer but incomplete type
     193 | static struct tc_action_ops act_dpxfer_ops = {
         |               ^~~~~~~~~~~~~
   net/sched/act_dpxfer.c:194:10: error: 'struct tc_action_ops' has no member named 'kind'
     194 |         .kind           =       "dpxfer",
         |          ^~~~
   net/sched/act_dpxfer.c:194:33: warning: excess elements in struct initializer
     194 |         .kind           =       "dpxfer",
         |                                 ^~~~~~~~
   net/sched/act_dpxfer.c:194:33: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:195:10: error: 'struct tc_action_ops' has no member named 'id'
     195 |         .id             =       TCA_ID_DPXFER,
         |          ^~
   net/sched/act_dpxfer.c:195:33: error: 'TCA_ID_DPXFER' undeclared here (not in a function)
     195 |         .id             =       TCA_ID_DPXFER,
         |                                 ^~~~~~~~~~~~~
   net/sched/act_dpxfer.c:195:33: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:195:33: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:196:10: error: 'struct tc_action_ops' has no member named 'owner'
     196 |         .owner          =       THIS_MODULE,
         |          ^~~~~
   net/sched/act_dpxfer.c:196:33: error: 'THIS_MODULE' undeclared here (not in a function); did you mean 'IS_MODULE'?
     196 |         .owner          =       THIS_MODULE,
         |                                 ^~~~~~~~~~~
         |                                 IS_MODULE
   net/sched/act_dpxfer.c:196:33: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:196:33: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:197:10: error: 'struct tc_action_ops' has no member named 'act'
     197 |         .act            =       tcf_dpxfer_act,
         |          ^~~
   net/sched/act_dpxfer.c:197:33: warning: excess elements in struct initializer
     197 |         .act            =       tcf_dpxfer_act,
         |                                 ^~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:197:33: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:198:10: error: 'struct tc_action_ops' has no member named 'stats_update'
     198 |         .stats_update   =       tcf_stats_update,
         |          ^~~~~~~~~~~~
   net/sched/act_dpxfer.c:198:33: error: 'tcf_stats_update' undeclared here (not in a function)
     198 |         .stats_update   =       tcf_stats_update,
         |                                 ^~~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:198:33: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:198:33: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:199:10: error: 'struct tc_action_ops' has no member named 'dump'
     199 |         .dump           =       tcf_dpxfer_dump,
         |          ^~~~
   net/sched/act_dpxfer.c:199:33: warning: excess elements in struct initializer
     199 |         .dump           =       tcf_dpxfer_dump,
         |                                 ^~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:199:33: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:200:10: error: 'struct tc_action_ops' has no member named 'init'
     200 |         .init           =       tcf_dpxfer_init,
         |          ^~~~
   net/sched/act_dpxfer.c:200:33: error: 'tcf_dpxfer_init' undeclared here (not in a function); did you mean 'tcf_dpxfer_act'?
     200 |         .init           =       tcf_dpxfer_init,
         |                                 ^~~~~~~~~~~~~~~
         |                                 tcf_dpxfer_act
   net/sched/act_dpxfer.c:200:33: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:200:33: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:201:10: error: 'struct tc_action_ops' has no member named 'walk'
     201 |         .walk           =       tcf_dpxfer_walker,
         |          ^~~~
   net/sched/act_dpxfer.c:201:33: error: 'tcf_dpxfer_walker' undeclared here (not in a function); did you mean 'tcf_dpxfer_act'?
     201 |         .walk           =       tcf_dpxfer_walker,
         |                                 ^~~~~~~~~~~~~~~~~
         |                                 tcf_dpxfer_act
   net/sched/act_dpxfer.c:201:33: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:201:33: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:202:10: error: 'struct tc_action_ops' has no member named 'lookup'
     202 |         .lookup         =       tcf_dpxfer_search,
         |          ^~~~~~
   net/sched/act_dpxfer.c:202:33: error: 'tcf_dpxfer_search' undeclared here (not in a function); did you mean 'tcf_dpxfer_act'?
     202 |         .lookup         =       tcf_dpxfer_search,
         |                                 ^~~~~~~~~~~~~~~~~
         |                                 tcf_dpxfer_act
   net/sched/act_dpxfer.c:202:33: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:202:33: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:203:10: error: 'struct tc_action_ops' has no member named 'get_fill_size'
     203 |         .get_fill_size  =       tcf_dpxfer_get_fill_size,
         |          ^~~~~~~~~~~~~
   net/sched/act_dpxfer.c:203:33: error: 'tcf_dpxfer_get_fill_size' undeclared here (not in a function)
     203 |         .get_fill_size  =       tcf_dpxfer_get_fill_size,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:203:33: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:203:33: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:204:10: error: 'struct tc_action_ops' has no member named 'size'
     204 |         .size           =       sizeof(struct tcf_dpxfer),
         |          ^~~~
   net/sched/act_dpxfer.c:204:40: error: invalid application of 'sizeof' to incomplete type 'struct tcf_dpxfer'
     204 |         .size           =       sizeof(struct tcf_dpxfer),
         |                                        ^~~~~~
   net/sched/act_dpxfer.c:204:33: warning: excess elements in struct initializer
     204 |         .size           =       sizeof(struct tcf_dpxfer),
         |                                 ^~~~~~
   net/sched/act_dpxfer.c:204:33: note: (near initialization for 'act_dpxfer_ops')
   net/sched/act_dpxfer.c:205:10: error: 'struct tc_action_ops' has no member named 'get_dev'
     205 |         .get_dev        =       tcf_dpxfer_get_dev,
         |          ^~~~~~~
   net/sched/act_dpxfer.c:205:33: error: 'tcf_dpxfer_get_dev' undeclared here (not in a function); did you mean 'tcf_dpxfer_act'?
     205 |         .get_dev        =       tcf_dpxfer_get_dev,
         |                                 ^~~~~~~~~~~~~~~~~~
         |                                 tcf_dpxfer_act
   net/sched/act_dpxfer.c:205:33: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:205:33: note: (near initialization for 'act_dpxfer_ops')
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
   net/sched/act_dpxfer.c:210:36: error: implicit declaration of function 'net_generic' [-Werror=implicit-function-declaration]
     210 |         struct tc_action_net *tn = net_generic(net, dpxfer_net_id);
         |                                    ^~~~~~~~~~~
>> net/sched/act_dpxfer.c:210:36: warning: initialization of 'struct tc_action_net *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   net/sched/act_dpxfer.c:212:16: error: implicit declaration of function 'tc_action_net_init' [-Werror=implicit-function-declaration]
     212 |         return tc_action_net_init(net, tn, &act_dpxfer_ops);
         |                ^~~~~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c: At top level:
   net/sched/act_dpxfer.c:215:24: error: expected '=', ',', ';', 'asm' or '__attribute__' before 'dpxfer_exit_net'
     215 | static void __net_exit dpxfer_exit_net(struct list_head *net_list)
         |                        ^~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:220:15: error: variable 'dpxfer_net_ops' has initializer but incomplete type
     220 | static struct pernet_operations dpxfer_net_ops = {
         |               ^~~~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:221:10: error: 'struct pernet_operations' has no member named 'init'
     221 |         .init = dpxfer_init_net,
         |          ^~~~
   net/sched/act_dpxfer.c:221:17: warning: excess elements in struct initializer
     221 |         .init = dpxfer_init_net,
         |                 ^~~~~~~~~~~~~~~
   net/sched/act_dpxfer.c:221:17: note: (near initialization for 'dpxfer_net_ops')
   net/sched/act_dpxfer.c:222:10: error: 'struct pernet_operations' has no member named 'exit_batch'
     222 |         .exit_batch = dpxfer_exit_net,
         |          ^~~~~~~~~~
   net/sched/act_dpxfer.c:222:23: error: 'dpxfer_exit_net' undeclared here (not in a function); did you mean 'dpxfer_init_net'?
     222 |         .exit_batch = dpxfer_exit_net,
         |                       ^~~~~~~~~~~~~~~
         |                       dpxfer_init_net
   net/sched/act_dpxfer.c:222:23: warning: excess elements in struct initializer
   net/sched/act_dpxfer.c:222:23: note: (near initialization for 'dpxfer_net_ops')
   net/sched/act_dpxfer.c:223:10: error: 'struct pernet_operations' has no member named 'id'
     223 |         .id   = &dpxfer_net_id,
         |          ^~
   net/sched/act_dpxfer.c:223:17: warning: excess elements in struct initializer
     223 |         .id   = &dpxfer_net_id,
         |                 ^
   net/sched/act_dpxfer.c:223:17: note: (near initialization for 'dpxfer_net_ops')
   net/sched/act_dpxfer.c:224:10: error: 'struct pernet_operations' has no member named 'size'
     224 |         .size = sizeof(struct tc_action_net),
         |          ^~~~
   net/sched/act_dpxfer.c:224:24: error: invalid application of 'sizeof' to incomplete type 'struct tc_action_net'
     224 |         .size = sizeof(struct tc_action_net),
         |                        ^~~~~~
   net/sched/act_dpxfer.c:224:17: warning: excess elements in struct initializer
     224 |         .size = sizeof(struct tc_action_net),
         |                 ^~~~~~
   net/sched/act_dpxfer.c:224:17: note: (near initialization for 'dpxfer_net_ops')
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

--mP3DRpeJDSE+ciuQ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICLLCVmEAAy5jb25maWcAlDzLduM2svv5Cp7OJlkkY8l2P849XoAgKCEiCRoAZbk3PIpb
nfiM2+6R5Mzk728V+ALIom/uYiatqgJQKBTqhaJ/+McPEXs9v3zbnx8f9k9Pf0W/H54Px/35
8CX6+vh0+J8oUVGhbCQSaX8B4uzx+fW//zx93x8foutfFte/XPx8fFhEm8Px+fAU8Zfnr4+/
v8L4x5fnf/zwD66KVK5qzuut0EaqorZiZ2/eufHvr35+wtl+/v3hIfpxxflP0WLxy/KXi3fe
OGlqwNz81YFWw1w3i8XF8uKiJ85YsepxPZgZN0dRDXMAqCNbXn4YZsgSJI3TZCAFEE3qIS48
dtcwNzN5vVJWDbOMELWqbFlZEi+LTBZigipUXWqVykzUaVEza/VAIvVtfaf0BiAg8h+ilTvB
p+h0OL9+Hw4h1mojihrOwOSlN7qQthbFtmYatiVzaW8ul/3qKi9xTSsMsvtD1MLvhNZKR4+n
6PnljAv1clGcZZ1g3vUHGVcSBGZYZj1gIlJWZdZxQIDXytiC5eLm3Y/PL8+Hn94Ny5s7VvqL
D4h7s5UlJxgrlZG7Or+tRCWCnTDL17UDkzNyrYypc5ErfY9yZ3xN0lVGZDImUayCu0OwtGZb
AVKH5R0F8A6yy7pThFONTq+/nf46nQ/fhlNciUJoyd2hm7W6826Gh5HFr4JbPINASxKVMzmC
GZkPAFMybQTC6XkTEVer1DgBHp6/RC9fR3z2Vwy3xUEbNkZVmos6YZZN57QyF/V22PkI7SYQ
W1FYMyDdmE2FatuqpZOXffx2OJ4okVnJN6D2AsTl3Tm4UevPqOC5k1J/WgAsYXGVSEqNmlEy
ycRopuHnWq7WtRbGMaoDWU147O9HmXoToF4IANW/yn578DPYW88v0rUCDLWvXTMcOIwrtRB5
aYH7gtb8jmCrsqqwTN9Tt6qhGXjvBnEFYybgRiEb7svqn3Z/+ld0BplEe+D1dN6fT9H+4eHl
9fn8+Pz76ABhQM24m1cWK//EtlLbERo1iNxUbBI0pFzApQZySxJZZjbGMmuoHRvpbcvI3lwl
0rA4E4l/3n9jk72lBf6lURnzhaR5FRlCoUGaNeCmYg+A8KMWO1Bm7yBMQOEmGoFw725oewkJ
1ARUJYKCW824mPIEos2y4eZ5mEII8BJixeNMGhviUlaA27x5fzUF1plg6c3SR8RKjSdwIDiu
jN3fXIMn74/brax4jGdAnPhoL3C1WVLnsX/O4Tn11nXT/MPXVblZw3AwC/5C7qzNwx+HL69P
h2P09bA/vx4PJwduVyCwowhBFnax/OgFDiutqtKzmyVbieZeCu2zBL6Nr+jLkm3aaWjX6FC1
4WuRvEVQyoS6SS1WJznz2WnBKajmZ0GFGC3BuloJm8XjDcMBbyUXxIxwurM3vuNU6HR+xVwa
TszrfCIxyii+6Wka79cPxbgGfC2YIWq5teCbUsGBohuxSge7ceKGiMGq+ZMBf5AaYAzMAmc2
PJ1O6d096IWHRw2Sc7GY9uJf95vlMFvjx704TSf16rMsfd4AFANoSa2X1Nnn8KQBtPs8R+pF
z+73VfD7s7Eek3Cz0eO0d224Fgo8Ti4/Q8istDtbpXNWjJRjRGbgH3OxWiWTxXvPloLXtRmY
WC6ca2tsxIDvbe8QJOIExOw5OBAJEaQX1BvQ7hwsTz0JjprDnYDTNSuCsKSJeL0gpPcVoFkb
+sJXM4aAQVCYVmGE0a1bQUrnsYE/4cr7K4pSjYOTbi9yVbAspRTUMe6nYi4OTJPgLqzBeNEx
t1QkXKq6gv1T95UlWwnbbAVrRiYyZlpL0h5tkPo+9yxtB6mDA+qhTpp4/6zcBrqIGuCCCVIg
G+6nbcCRSBLhycepKGp5PY6YHRAmr7c58KACI1byxcXVxBm16Xx5OH59OX7bPz8cIvHn4RlC
Fwb+iGPwAoHsEJGQyzrDSC/eerW/uYwX6uXNKp0fM7Q1h6yVWUh4aS03GaMTNZNVMWXIM+W5
GRwNCqHBmbahX6iRVZpCwuycrdsvs2SiDGpmRe4cAxYSZCo5CxO2Jt9vYt0+XgMD4zxDkFaE
CX9H/P4qln7kB6kdH/1871lVl7FhaAyKBi6nKdQM1hTC0xjVrkgkK0ajmPUiPIju+KaJlkxV
lsqPPjGdA680Rbhp1jIWunBSQONlZOybM5cjO8KRyhthG9fd5AAQnnmpGQaUHcpdmTqVGsJA
vq6KzQydOzuSLM/9mHtlMeCH4HMrwFxcBXtpd2jqCkQaC9NF9OXx5eFwOr0co/Nf35uUIAj3
OiHmJeWEPteLi4tRsrq8viCVGVCXF7MomOeCXOFmMRS5mlBjrTH/mibn6zsBma6dIsB8ylhD
3NEG2+Ep5+y+NVW8TpPAFgmms/s0nlgjjMvT4+Hfr4fnh7+i08P+KUgP8cwgXLwNtRUh9Upt
XbEMlWQGPa0A9GjMAWkD01F0yR9O5AUY/49B6g6sGIjj7w9BL+FiRyp0pAaoIhHAVkLu0ScE
HMy9dX7prclHuyXnnd0cRdhvaeaMvB3QRzjw7dUXoq9jnYm+HB//bByXz3EjCKpE56wksHfZ
kY0MKKCWwsP1s94qLW87BFmXoZW6mx2XzPno6jTVOQhGwAyz0DiG6MExdVGZwhpcznb1Z1UI
pSEDvVlcelEAHUXxPMFqNAbYdHHpLXPWlK1eT9HLd3wNOEU/llxGh/PDLz8Nd9fElRcx4C++
Zn4YXBV1lig/ukKQKkUBhjUPS5Ezi/U648KCTkHyx9ND+5rhjtLTDWIhqfzTVTEkqBkzaypu
ZQmEu+A/zeJiWVfcai8GVOAXMyyG7ny+Z1kJyvn748Mfj+fDA0r35y+H7zAYQqVuwx7bwtZp
EL7+WuVlDWGLoOJ3Z4tdrADxCoTjmFxyrI+N3Oymd2QBVAtLIorcq5M14YDUtyC0lZm6/6ES
7ijXShH+BnyiK7zWdo0lmPFok9e5StqnhzE3WsCyYECa6KTdYM1KOeW6eRFI1Ipib5DkOHbp
RhuWgkHIyx1fr0Y0dwwCVwlurymyd68kBFEbwP4tWpUlHj3FtBEcCbwbNAZkVrk68Gg0/Buj
QHcomyAQdWgrUxgVlL4RPFOOnTntAjUeI3qs52Dk5UVbKqkyYVzyILLUpUzj2E+lFt8lIGJU
d0VzuiMSscOHgpHKqCSpgUtIP9nomQTFCWBTGbj5vsNpRNyix6Na7OUSrxFmrqGnKlQtUojw
JW40TT3txIjYT2nM6Ij7OLJNpkBAXRbVGAeutj//tj8dvkT/apKp78eXr49tgNRbACSrNxBd
C9qOvznNOM34PwxRX6axdY7FAN80uNTXYCJ4s/DS6+agqcJIqwKuUJ2BWag8rY1ReNMSVmxW
k+Kyh4PYlCp7WbHS0pIVsRZV20UQe3cE6FHp+idS3MVUXNGMxRP1lQGhBuyvKlkWQptXYXD7
XN93zyjBMhOCOgUhx3AdJtF0uT+eH/GoIgs+O4iF4Cpa6UazZIuhHVWHyE2izEAaOmYCLFIZ
gIfgYcRIcK6Dt/Z2md866+KccfNIqobKuOcCgU6qJntJ4N6HL+oecnMf+zW3Dhyntz6f4SL9
9TTFYhhaFe0JmFIW8CtUzfAqMwvxBK91fjeiQEPnXqITN417PZ0n0XcdgROF+O/h4fW8/+3p
4Bo3IldROQfHG8sizS3aUlpdG7ThWpZ03tNSYCF8pvCiRVLlJWlj5hhsorHDt5fjX1G+f97/
fvhGxzVdeBvG4G1AvAMT4ZvdAbWF/8tZOcTMQ5Y9pqG0vXn595/m+tEZGPvSNtpaVl4JwOku
H99TV1fQApWArkDmcqXZ2LGAA13Vnc3vZlrfgxolia7tuMyzMZ58uuTO7T+XhRtzc3Xx6b0X
mVEeeHgKJfDAzR27p8w1SZ03hdWZYssmD9LHTIDZYXALqZRx9FCUs9m3lx7nm1cEuuJ5CMKK
kbn5MEz8uZykOx3GNDVM6l0Yt+rCU4xxfT4d0KG7OIoaLjRKw706+4NXVem6HKh6dRN3gim2
aHYEl6xvHkn2533EHjA3i/KX58fzyzEomSQscI/uZ9hTEWC2Tm88tjywN4xgsiFM4lWYkXjg
mfG92ZjbSp88zVqOQd/8tg+Br2qJ1IL3qWBxOP/n5fgvLBBMrA7c440/vvldJzI8ZNjDjn5w
gAWpPhJhsWULQ/Gc6U3IX2lL7GYzRqb3AcYNgcvvQkzQlbwMonKgSGVmfZfWg3qP7jkUG9w9
+AmpTUHdPGP9sEvLJDQSDaTONWVAWyRPg8W2sFL98WK5uCWllghOyy3Lgooh/FySEzDLsg0x
fre89oJvVsa+UVWBpkghBHJ4fRXc5h5aF1n7D/fQBydSwKK0EgyD8FWY3FnOeL+apwsuIukU
9fb18HoANf1nG48Ed7qlrnl8O5miXtvY30UPTg3Z5dSiGw0ZAUst1RTqnjBvqTU0GUV2WJPG
08lMSs5kxS0t354gpp7vB8GY6VJwP6ZAy9pNTlZYvb2bxExvM8LhvyKn5ks09TjUC/WWFrbZ
xDSCr9VGTMG3KaESXCV+GaMDp7dzGM42gtpDevvGFtZrQr6lJJiEhRv4ZAEwcloYKuDoJ8yq
FTVSkD1cvfDHZdIuXuoE4NmjBtEJZ8Zo9USwkTdJTDpn9xp8mcpUQQpH+9SWqN3GzbvvXx+/
vtRf96fzu7b4/bQ/nR6/Pj6M+rBxBM9GtwAAmJf7nV4d2HJZJP7rfodI78bSRmh1SXV+dFht
tiU1CuFUU0S/VuZ3uXbQprGG2EmZEuxm+BJBLZ5jsY+RjQ1IIhw+nLCBtbWmy2U4Z4vk5Pud
R1DE91aQ84IQSXguRi1EAwqLdG8vx1khk6lcGB9FRgCoS5VJLqbwVUM9hKaOWCvqybwbk0ut
RTJmGzEGgpeMijU6goJZalwpRs3U05nlrPAdehPjFNP9AT9mCsVAheID22rfXCRXyXQ2mRKC
tVVRiKzeiHtqoRWzb4kpKXfpVLVhHccD01QQ5FFM3UiLGK5+MLHliKznFc5ZcjBenlHlnodP
CoNNbQq/EQhCSAg1mCs7kWe7bcImut0Dls1ksXExORVYlWEzD3KJsHpl6B4hJCgM3ea/NpS/
vtX+9xj4qzZ5oPYOBgc9313oAv/gNDxEkw2MFErv6rgy93hh/XLhbZ8FtnlNdD6czl1BuM2a
JqgRws+FvN2zXLMkbK3qmA2vCfysNbujCeuYe3ElAlZ34e9fF58uP4UgaZTLQhoHx4ooOfz5
+HCIkvGzHRJvCXa2OxxFlq0Aa7IR1sMlYhvywlnG61ha7BsMe9ERy+ynxcxMaSZ23O+fcZvX
BLemKq7kLLc7bAwa78dnsJ6s4kAQKDGL7/YjHP/w4WLMgQOC2NncGg7vTRiMlqnE/5KdbIjP
pxzmYw5DbeJMz8oDkW8uZ35l2PISLtgCcY80gpaWe3SaHntTz2/aj0eGqnvyn2ptf2sDZxdj
85pIKFMTY7f7iDYTZIM1YHKTtn1cPj1TpqQteGyDT3wGqBFZOi3RDPhUMFtpMS3INV0AT6+H
88vL+Y/oS7P9yVt7bN1Di2/HbH3LWfB7zWVsTeLbyAZaMf81eYAB2zq4vB5qfTXaYoeIuSHr
GAMFs+vLDTlpls1MenknNeXGPZJu/zRP+duDCVE1rK7e73YkJtdbYrUt/G9GlRr6EFBPTiO3
GwrWnpC/2i1XOXjJOY1qHnrIezSrTt6TIrfUIeIpZEFvA09XWHbxnnKass7CVSQhiAvbm1pq
vOYiU1jEvmO6AGsw04na0XMBu+l6PGtVVGTjf0etxW0FnLr2aHzpEasknrLsHoOaR92GBENI
YmtDVkkjJ/d94FonrHu3ent/d7Q9aYtannQ7iKtc+w2pPUJzfKowVvvWwMf2rxp/h+rm3bfH
59P5eHiq/zh7n5D2pLkg23h6PBpXXzg9ohXcW2NhbtMV/oNKbTgJ0PmfJ/fIQo2/Bu5RED7H
yrT2lmQvz3LCHI+pIIvt55ickJ1F4ddSczgZGzOLLOdRNsnmkcgnaMza9bDhNxo3/gdc6UbO
pvCfRkWCT+XwhhyCJ7LkTJJJXhrUoOEnpB4rOSr+etiCe31GLaAeW0SEj4xvG8Tvj1H6eHjC
hvhv316f26pO9COM+Km1gMEzL86EW6xYhivNMJUm5Xh5ANVySRaEAVsW15eX4T4cCIdMwcs6
dMoID11IByEl4RAjXgICY50U59ktdiUh+AbYshxOeJne6eL67UUdzcdmb6Rr+pun1fFUNmWQ
SQbuM5fdNQWCGf0GT4TZ7zCFe2rEJ8wBlDKZqVHGLezaAlGXPU/0bi69anu3gw98Sk6nKiWH
uDyZTO0aiR4f2rkj1b+5Dc9pTUvUWmQl+c0NbNrmZRp8bNJA6jz88hgMR5GwrGluGxjTzQKp
1Dk4cNH8gYIJo+nj8dt/9sdD9PSy/3I4DkJI7+pM4Xecnow7kDuABGb0CpHYnsD61byP6IZR
2APdbtjnlCQgm3smA7ALQTfBTq+f4x31gRG2EmI3U9fC4fOAb953AXameO0SIC23M2fW5kda
BOeGUIy12pEQyuQq/C6qzOtbNf9Q3M3UDC/F2y/SECnlzPMJze/QiLWwu8UElOe+4+jG+n8u
oYUZ7pe9OsJLb5EE2xHWoA5OV1JflxCVioKL/pPCsAlvenf6ZmvCHzCdt11s+C1SndG93rFd
1KykP4xyuB19x9fSyEzCjzoracvpEpta7sqr3a4W9AqYDABO0q+5+VpiqYtOBrxN98GtAoPJ
YbPhnVe8/UaNUItV4WcF+AuTx6alYih5IxiymRZF8toMlToliHySKt4RK+SWqmCo1KdRKd7I
OrExtRHAYsM6dkwO+wHgRsW/BoDkvmC5/+oDsOYB3F8J3UbGyL/9wHTYxd0CsHQVl+UUznYf
P3749D44kxa1WH68ml8CAmFIXjxO29bLIKFsuzGLCkQTZzPft7ZEdJkoAbFN1sCu05KGuo6q
5g9dfJyu4RoxFdJNXauOk+jL4wl74b5Evx0e9q+nQ+T0E/KJl2PkmkaaIU+Hh/PhS9DF1+00
pnbRYTUj9gLAluHFewrnAmu/PczJpC43lidbvxnaB7fWy/hCCAnu5jq68ONHVDAMRjyXXRXb
xDvtJlxHRvvC9jYXkXn9/v3lePZeNwHqPJQXTiHItSaUzF/CwVMWa8nNGMpHAMv0KrwWHhhU
1Bi71tQfjvDJWi0ip0g5HUr6mxw+WRkMfCfE5Hp5vauT0v/rNh5wHOyC/87v0WcRLIM4Pl0u
zdXFIvD/NgcDbshWEfBSmTJY+sNPsLD06Y90Zp1DGsvFzBfgjgIfuvWM92BlYj5BEsgyytpJ
ky0/XVx4eUkDWXqlXiMKo7SpLWCur4M6d4eK14sPH+iPJTsSx8enix3BxDrn7y+vl4GQzeL9
R9qZGbhpVGeSK+nXJkmFp4F82drYpsdXoGmPTmPNb+BwTkuve6gF/i9nX9bcuLGk+35/hZ7u
nIkYx8FCLHzwQxEASVjYGgAX9QtDRy3biqOWOiT1jD2//mZWYaklC1RcR7i7mfmh9iUzKyur
yHYsuTPIoEeHcRQY9LWfnEODmqf9JV7vm6xTTgQHbpa5jnqJfHb6VUssIjU9/nX/fpOjVebn
d37b+/1PEEm/3Xy83b+8I+7m+enlEVfIh6cf+E95+evzi8VT8P8jXbObi7zzrTogQ086hjpF
Q4/mLNnTZ4oYesQSZunYsCqnlwBlwosoMUmXj1ZPYxgg86KcO7csT/kFWPn+HKL0CxJI1CAi
Lsuc65CduOn3D2jEf//Xzcf9j8f/uknSX6CTpVt9457SyXvGvhW03tyXOkVQm5CU5Uq6yUF+
k1DGPF6faaVSFgDRGBWqiZbjZQ4p6t2O9tzl7I6f+3V3VaI0WT8OvHetk7omn7pFzWibCIa9
KDn/0wApyWMwQaLXkV7kG/iLYCgB2iYqRuFTAwYKVttIFRiDFGl1/j9qC574TXm5xqIqPHwL
d8y2Vxq1DCyPrcaHbbdPUq2QgkieKI58kFSqbkIspH5JTwl6PywmhqW01wERsHr9FnkuvRRM
qE1Hx2GZANn5rqoXmovXjAugy5i9ReHjgC8w6POk6ReqZI19xMfIocq6xmgo82BHSXGvL0P7
S5uyxKTuQck+meSsJLCsODBjpGrLqCSUSgmgiLpXYokNETu4+Z2HwVRZ/Kq1UmmkNqWpBiSv
Lx9vr894q+jmf54+/gTuyy/ddnvzcv8Byv3NE0Y/+f3+4VFaPDAttk9ychxyRl7SjuicmWRH
6jif8/iVdaPguwy0HMqGjEwo7LTeQbkf9Ao9/Hz/eP1+AzuJUhlJsGSXTcnZWts0ef3L68vz
33q66m01+HwwKySUoZ4DqIbiDFSUiXmvWCh/v39+/tf9w79v/nnz/PjH/cPfVASBkgxfJGR7
VR3pExCltGuLSMO4rrJdCWmNuiWjAoEWv1kdERfgsiy7cf316uYf26e3xxP8/5+SYDCbEfM2
04+g5wtuS4lItubBt0E6nsll+7pRXa5pSLLklwMrQMOUb9zp3t99xkqTgkJNhgFsWZqwrrcB
WlBtQfHcyCFONQSr0tpwxJ75eGnrmGE7WyKrqXA0tG5YoYf8GFuHJbr3IJC6zOJxj1JIXegO
0AN1tNbQn6oeYNyTrOYhFqu+hX/ILd4fqsuRdxUPbCufPRwVLXzQujWLUFWA2EivL305mGCp
TRqSxoNqw6XzmEGHtBdxWY60y7WiVORXBUvavM9ImW+Q1ftOO10Zvy3Z17qysGRB4lAVepAT
xJ4xLIF1iHDu5Whzhx4zgglR9TmjS9EmJF3MAnUQb1YrsiibpFytnRhE38ziuZOUOztzB8OV
XCPnLYJHsdLdA8xCJyzNtEaEtGnZgw9OVpyzlEE7Auxa0sf8UJJNleRte1A9G7p4/ZezXKes
WftoqO6pUSWnzu9xKj7ZYrOcBjt9TFGu6dhLqX16ZF+TfW5zah4wW9aylN2RDYHBNDGqndIB
24xWcrddcdmWFldJZDZfYMuzxNdDPu80O2SXs2pr8eXDz3E8JpccJCzr8BiqtavrndWHfMBM
xxNy1ff5Odin3kUfXcqhBjSQnd04K32EzFzQKNKO0ZeskanPOKLUB3bKcsto4Ocpy9/DTgHL
e71VBtQtCHgVu9aoBSyolJFLTp21oMip5xZHa3+XuN3Q2ZbHpqGNZM2ZuWF8fRKWUA5W1ZKL
W1mcu9MoiMw5TdQLTs6SPJcRIOUkUJBwVpdyTAYgq1dggLDZwtDeXRmO2DGyx9JtF8cBOusU
ls7mPXl99osOz8qcnP8V6wcelQX8s62rurRvZyOQ9CWZ+bG/Vqyrw4EPmWzRJPZtCbqdvGQt
5dVkVYfCnKVOKGqijWs5kRZKIIwh8462t87rlh1td13G9PCWgnEZY2B2rARhglbsZViW2e7T
jYi6YO22YC0t2XSlGqa4K5O1S+uEnGXldQaTKksCgpvmYtzBHmgLaYc8+N4qBU8J93xIS4JY
X+K2op4UCZrppp2ekI4mG3Qc0CRIwRzCStF7NEewirW5RdoViLyCVBbTyJsvsRPSLSwQMBHc
+LyEKLM0Z31GH2mOkG6xoPW5YrS5SPDF8Xu//2IxKgkUDm99KdIgMB62zY5e7QeExZ40ckuf
3hEG/qGy+CFM/HiJn5fneLFD0VUBx9MC6Jh3qFnR2chD+EB3iQy5q+qmI2NpSKhjbtz8Gzin
/OtVWUIcLMkJDEdNKN7gbm8/jGLnnKPmiTUwQLnsVUazv9Pc0JAgx809AUWyZ2TppW/z3Q5d
dmTGNj9jeBCZ1G2niz9lnt8Az7xHMG86Jf+aljdwmlx250JHjN+meTVkPac3KGnWRIddbmNJ
c9TX9HRB9QpW7sqxpguAEBURS7JJGZ0FVzpPScp4FceuSY0IqDAUjN0060g5aGtGdUemUHrU
tFJQwYga5klTHDpr/Ypzb+WJeXg+sTtLOQo80Oldx3UTtSyDbEoTXWenF3JkxfHZg/8s2ZXs
jI7YDHQONeFhab6gy6XC4HKeSeOinI3cuwQHBTej0HVftyjeWBtQhFFmtoGOfrDJKrj0vzHY
4rWhwfrY8c96nl/GgtCyUYb2lltLdoOcpWYz7ibaXAexQ6P0meuclXMEtOzA4M0TY3SNI7KJ
/Vj0pjRMgdgnseuaZJg1BDGMKOJaJR5hBe26TG+uYaHcwYLltfgnNapAZZrfq5CJSlTU7alC
Y2OpXKuptxphTKxVPTA42X6ZkLPttizOZl2T0ZHgeFHzfsPU23CCjrZu9GmyfgiAA+pViVYJ
3aLDibvGqOyspGsMVYNDCgwqvFWSl0Yxy/rMSOsV59ZJn8lWQpF882XluGsjKSHrmcH0uWZc
/nz+ePrx/PiXGqhu6OxLeTibLSjo467lehYlWsbyTSOkRRwdeKV7BiDR8FPBuGNVkZ21B2UU
TJmD0m1eCWySznoZEHiXc5MoZ8sEfoIXuext2Kg/8MknNdopEtMMFKhe9TIGsoiVRB0lAbNs
GuMD3gS6/7yMqFlPKaHIydQije4DEgkpl16OStkpde2KvarqAXdy+yanLEdgkJpeTVOcZ+C/
wlHU2r++f/zy/vTt8ebQbSbvD0zy8fEbPg/5+sY541Vy9u3+x8fjm+mWcirkm774a7JxpyVs
GvLOszc8UxS8qsgh3DiBlrlruluAE95SBiBguI5aHvh9kZfngTTccZST5OSKnFADV7vcJFPV
C3hjak2W9C1pqhoQ88Wy6dtTUvnhmVLb8RtXq507l0rJ3Z3SJhJSu6RUfTpk5ij7kr0gAxNU
qa7kZNyP1Zltl9NeWTJwkPeu4wilm4KNwputYNB92upAgYT0JMlG/SmO6TnQdoodD35e1qSV
Rv5Ifb0zObkeeQQhf9Lncv6uF7hqFZHCpwGZjuvJ147hd6z+Vg+KxW9jUp34yjqZd/hjKVdK
/fUulZ2bZBbX47JKPbGZLzueupwepzye9SnfUhLcST3e3acFbQzCSHP8VIhIQwoON5yfKkrU
zN2y26ygLJAShldjXMHxIP8Z4yZCMWUV+XTST3eGTVb5QDYlSBfIxjy7tFJ/gdymPvtUItXY
+POXHz8/rC6MeaU8jMt/jldwFdp2i6FZi/F6k8ITcV1v6YCuAlKyvs3Pt+ImEC/X4f3x7Rkf
MJg8VRSzwvBZfYB9NTta0/2tvlMCDghqdtRuK4xkKliCaCDj+p327W12t6m1y3VmUSXBDX9e
mk7xUp6IF1Y0tOVvhmzuSB1g4qO3GPwti18zEyQZ1vSKtz3BBMlE0XxmSHI3XmUzWDyqKn8U
ieJmBc76ZE9Xe+SKjBer12W4/+QJnVBfH5L9rSUy1Qzb4vPIFocFKauhFbQEFi4dCUByxxpq
gRRcrKt+F0DlWG7TaiCyj47d+XxmzEwb1QdrmnPHa+WaJlOHbw9ZTEQI4U8w0a0+ALBjuqTN
MipWzjBVtIcdBTWOmzIOnfOlrmCyLWTBgRROQbE0cldnfWUQVFVjHTh94k25m0y8kQELLq+e
zt2UzA0cYxHyzw6oZX2vvAo9rIbnKArX/mXPu4Ngx2svmIqiL4rIXkfDxwsNVZYsXgWU4CH4
OFYumyxrlI1mZqUZBl+keUd8csos2+25/21tzRAU00PBL0XSFe+bLgw8N740p3ZqOX2AnYqV
4zszxJrbiByLqjAP5M7XsKJEu5mUvcpPtoET+v6lkV8mm3hxEK0M8qmc21irC/J46ewtdhs7
AZaHGJS8H9oan4pGZ3uqq1IWebEztDaxc6ds7QTBlZmEoNCnJ8apjH0XJ4050c6FT80/TqYm
YP6l88K10VFADr3QICcl85UAUwqZTD/NYLlOUekGFYwR3ZG2R74EDM1lbxDEhYHUrAQ7src6
N6Txx7qWF7qWP7nS0ENdl8ESD88clkdT1zegQLl6V7ZlvtJcSTlJ2yQ4DXYjyuCMrK18LWyk
8F201uheOtz/0fFy5JqB4ukU3zEoK4PCdEpgYIJgsrzcv33jl/Tzf9Y3+vURtfjiST18h296
VE9D8J+XPHZWiugnyPCnNbaPQIAofUteNBXsIt8ImVKhtuykkwZ3TAIMpFJ/RVN80ibItOYN
OpUmzwp6jb4lrOksbyOLiqNFfDF1vppp6R84i/hkx8pMvQw9Ui5VFwSxnMjEKegrc1TvT57a
lPIklIM/79/uH9D+ZlwQVQyIR/kdxMG3mD/bIJ63UFaHYz9CiCrvTyNTTlwi42shqWacwjD5
a9hOe/LIW1xV5Nw5zZk4XF32glBSrFOQ3fhr2OiLbehS3ePb0/0z8bQbF6XFg5OJuqsPrFh7
V1PcO359+YUz3kW63CJKeNsPabByg/cPHNd2s1SgUJZbAtidOwZAAspbZPXjEZgl76MBwiNE
XAVc+uSwBLLdP5nZU7Nb5h4TIYHQNUFdKySGOfZ0QNXyf3e/uhoCmkHdW2b617yod8RgGFnU
dCCwezqI7QgAbdMSL2dA7Dv0CvI90oo79jlVBW5FS8x7BONA6ixe3IJ97OPA8mLsgKhpk8pY
sXyrPWitMD7TeKiO53Ro9DGtJKnO9pWdI9ww7yKLS9U4lPNyk7UpI5e2ATM4YBAVGl0z7Kvj
ANy1sEHCip93BT7B0WzUoFhLKOsIH3bS33q20yNn0YjrxRw+IAsn8VDT409YzS8dEaANO6T4
+u+vrht40mPCJnJhpJ47WNSNIFsqaDhibzoiHJeWHFpVroHw4U1rC6FjetFY2ntmfmaMJ+gv
ycMt5bs8gX2LdoUfRzPoKJbXtqbtobp8df1gMZWmpQNtTrnY3O7GTI7Z5nC1CevT4kYG820x
j7zYZAx14Y6+HzqsEbC6kyN1ZPAYgWKcuuYKM4LInhqvh6pig5FIJS6Mp8zSqtVlZ1lqeXga
EMjok4aEGoH7YzIcDBg15hfhVVOhxMGnZzEvq4QPPAw5XvXU+RRnyHkWDTVhm4Y2hw/Xx4xF
LAeND1SVKlVupXEqnvPwMx6djvERROQmRXedeV3f0ieVHCM8bMQR4VZ5ZJqz5VuWggD7lUYy
34QVuaPOXG+V6EzCW+Zyi0ZNxGxKSzzBhnvwXQcOCWKEZAI2F2ezUFGQys2rjxORPycFik2Z
Ua4KM2zDVr5Lp1B5LdkBM0Jc1KW/tl4Jlz4HuRGySIg6idWLYnDJmWT0txRZXKunONhbFB0j
7vbqy7kTL4EJqDyaO3HOebPPVHMl9B3d/H0C/ze2jrM83M0/yskn+gSHW/KTVrYSyxzjVF9m
5kCpMlJ8l2HV4VhrFlNk29Ud5B6hRhi/7EyZ/8bUu973vzZyrBudo5uKQFQo7ugTHpaq5+lD
w7YH2HkxMoUIpkhuE6bOLQ7wvIQ42FQMgNA8/PQOmlI58ea9wh8+pU1ryN6z1nICCVzhRybc
zmaPM16k5M+nH2S5QPLZCHMHfwonq9TX3YZkbSc5M1vkrZGLPln5TmgymoStg5VrY/xFFaHJ
K9zUrG2DGM3ZTOKmmZQGlXxZnJOmSMm+XmxNOZchQieaJNS6aedmvOGLXa283jkSm2SKvYOZ
TSYhDHZI2Bt4vuJOo3mcjKPx7/ePx+83/8JQiUKmufnH99f3j+e/bx6//+vxG7pz/XNA/fL6
8ssDVO4/9QyE5G5te9NLVGVrj2KozPM5t6cM2pYXW+TbgW+6MhqI27oiDdHIbpOyUx/I4zMN
fRj1Ua8g0PG9sujyYsRhBHceYHbxyjHHLmoDiMjK7EgL6ZzL9y57Ky1WZJ/v9qB7GwudArHE
tuFbQklblgQPVoHGFlKLI+rGt6jryP7t6yqKabsEsosm8SxHxN7SzSjO7cNgIeeyj0LPPmzL
YwgizcLnZ9qngu+OQvyzjMgaLTmdPiB184vKPFF+gsiBxYSMgsJ5lb34zdk+J0Vgv4Wh3+a5
vcPbW9+ebecn3spiMuX8/aWEVZO0Z3B+XvZZolfUqgFzpn275bLllg6vMPMjO/9QhaAoeCd7
U3V31ZcDiOv2uWe3zE7cy6axhGVGyKECiTNfyGEEXOhb6whBzzTW5xbjBiJOpb0dhbHGzi7s
ZTsXzXphlukPAw2voYNY9gI6PCD+CTsv7Hz3g3+ycRjAx/oUzFZtWobXR49mgKD6408hCAyJ
S1urvm+SUoXcrvaHTqx7vzLeC3bMNFEDSUN0RoqDobExRrZeXRGMG9eehS0NISijWKUsBIxW
CakiRtnlYNg8DBtQLiXrFKtDelLJs6HjmEgcojBl3uQcsVeD1XeNxfgO2jWlgsr2gT0PVzcL
7uK4FjZGNUTVTH5+wkCUUvR8DDe4Z1IFm0ZZ55vxhQxjyAFnTI+SAfHDpMgxqv0t1+cpm86M
4QdnSilGjhnXeeYNl0Gm8vyBcbLuP17f5CIJbt9AaV8f/m2qHPi8tRvEMSSqRMJS6Ze6EVfY
rIBUPh/SeEYwM7y7FZq3LemvQb3trEnnaR97DX8KY258A5KU5Iw2m2XKZdJLBsJwQX1kXPhr
gHKx8krRuCQ8KjPbQ5WMJ7pSFvAvOguFISYxoSqNhUFxHsYCvS9OIMvrTiN/U7qxRbAbISmL
A+i0Q0O5IMygtRN6VDGJy/Uaokwaz++cWFXQdS6VNnUbXoN0ebWTjZ8T/ewGzplKtMnxXdk9
qWlPX/fl9mwmKnzFqESXwhRMtUHHrkVEnWRFTW/wU3NNV1k7q7oxJWc5K5gGjzB77q4MsQG1
XPQRRYcimYYj6pmuRdJQQBZlVMKEvktfwlMw3icwwScwoSWIjoL5THmugLiWbdckR1hyt6vE
9b9FWEVrRzO7uZ5V1XmfyKe5imGdb4n/PTVQ1oIEe9nsVsnyJCA0O3Oan5kXXIdEyxDbef7I
50pa121A/yivTP8C49ijmm6IHS1s8e/37zc/nl4ePt6eKSl3WkPENe/lam2XDBkyqo1ZFK3X
y1NtBi6vE1KCy908AaP1JxP8ZHrr4NNA2uJglnB5ss4J+p/EfTLfdfjZPgk/W+Xws1l/dthc
EStm4JVZPwPZJ4Grz+F8tjxg269suU0AsNwY7dedt7zFzmX+bCusPtnzq0/20+qTQ9MS39LE
JZ+tSPbJEbe60g0zcHOtv6rrKXX7yHOutwnCwutNwmHXlzGAQa6fg13vV4T5nypbFNBmMx0W
Xx90HLYs3Q0w/xPzmNf0U70QeZ+p6VlLa9AFbTurmcxCuPdJKUCr6RWpAzDhVUzTppcuWcdX
1u7BLuotD68BdWUQDjbU1XIHDqjPpLW/trBwVNnYvKZ02JWB2ueXvE4zyzNZA2i0sFIK2mR9
LdLl8TQBQRD/JLIr0mU5QU5zuTlm5LlbXgikCoV0GFcC6S6vjxLyymoll1MZB+Jc/PHb033/
+G9Coh3SyfKqV11EJombE01BvPciZ7n0/ChpeVByyPLoLvv42phFiLc8XrG47nIHln0YXRHz
EHJFSEbI+lpZoNLXyhK74bVUYje61rqxG1+HXJEwOeRqB/hXmy4O3HBhsYCG89eRbEG3jlr9
06JO9hXbKSbmMVX0ZGEmPelWUeEGFoZvY6xJk1tfNscosviRTxval0Ne5Js2P1AuT6j1K7ED
BwJ/JwwfcrsUeZn3vwauNyLqrRaoaPwkb7/o4TmEcdPizsL9YPhjNGpal0S51z+RLkdXow5G
VY2KV2x9Z3bOefz++vb3zff7Hz8ev93wshjLEP8uwtct1FdHOV14Yyj3ihoyVhfFXzDPCVS/
t8xscccTUtlkbXvX5CCa0KeO4i4v4XdhIs67bsF/Q8CEh4atv4jw8oK+dDFGXCk+2d485ews
Xzg5FgjaBMN52x7/0q7/EEOFCGAr2O0wptVkdU8MhVecUuODvF7oI/7Iz3Gh7ZcC1I4A/a6K
Cig3cdhFlBVesLPqK2xZRrHLJolt7hUCYHfPEPzzQrVszhni3l+JHsdXO9/mISFmSWIJci+4
Fl/44RK19WhBrE+sZEHqwXJabw5Gu4nrNvbUuwoP9DQ/OQ2yWG1YhHlszoXlM1EdPznZ7sUw
s12LFicQ3Sq2bCycv+jlMEQJWAjdyxHi5Y5uYU1Y8GQQ/MLabxibdqvGIhETNO19b6X7xEw7
v3WrmBz8OPXxrx/3L98026zIN22CIKbVgAFQWQu9O8H6lJLbmWPOWaR7C63DvTst3j8zILIu
mSKqwVkrTt/kiRe7ZnlgyKz1ISP5JGjtJrbmbfqp9vSsZdykkRN4sVGYTQo1c8sT5bwrdiMe
/kCrW9H465VvEOPIPxs5IDmwCJ9D/6QZeSFfNK5xhDisZEEfWGRnMeELL9Z9XNTuEXE0zO5B
xtq+QQ58T+/uL+U5Ds3URIANW2IiNoTxFZJ12/w49cyhwMfC8ent4+f985LcxnY7WGFZL8cU
ED1Q4+NSGlH4AMnyPpnF+I38MP3JvYjFlpfM/eV/ngZfofL+/UMpFyCFs8wl7bxVrEjvM0/b
NIlv3VOpZD8wVPl7pne7XK4YUUK55N3z/X+rkbcgpcFrCR/uoMsmAF2ZqSUTZKytE9gYsdYM
MgsD86X4Ghg59BWwS08PNUF6b1Mwqo2AQMTWqsiBKFSGa62jfy27lR/TqQoHBoIRxZZyRLG1
HHGmvh9MQtyIGEfDeJFUTLyTBR3XkXHxBbc7NE2hRDKS6dZXLRsMi45A04OGpcllw3oY70rY
cRE3SftmiFEjXplTWkQwOJxqDb5QTalNn6E3n/nRxB6KNcWzIlJGjzQMxI/7mhNKi8v4LUv6
eL0KmMlJTp7DTQdGftjjFiOyDImp9VoBEOXhdI/Ktch2oJQdqWE9QrqN+ibYUHkgEx+VrGID
1yzG5gsGuTlbGapTkc7cp1+oGozstL8cYMRB7+Jr8UuNBFKD71BVAo5LxtuSPlUihY10GLlu
5KzsHM/C8VyiNcbAVyB8yC6fQyHHGFbmd+1ZDTo6fsHnleWYbMTYZYERgbKSqnWOHKtxZC4A
HxRLifd+GLhmZfE6lBt6haVa7iqIaEvn1KVZnyV9PaDDgN5SpCR5YLeFkg7R28yilo0Xemuy
oH3oW2b2CBGuJ+WGMtmMGBjoKzc4mzlzxpoc0cjyLMcxMiayWMklTOAGS2shIuK1Q5YuWMcW
RqhecZ3WlnLjr5ZLzUVdZ700W3fssMtwCHnrFbEo7uoi3ebdnphIfeCoDqtjrm0Py/pyU2Ek
L5+2smwPWTGUSsT7WkzokHSu41ARl6YWTNfrNY+MNX3cVkEfYgQ+6/62P5X0XVTxzpuyUwoS
hrS1xmwfMV3P+ryzxF0bQVmZQcErjE80XAW/8HPAS9n96ujgekuV5dTmPIglvoZjicE6QtNs
yw5FDx19xFcxmssp76hbMBR+y3LoSmjnjCqEjMQgVxhCl3zTdvzASJLgT0WkckQAvhvB/1is
tb1M8whrDgvP+qXZcdtmX5YGRFYeRPyrhSqrRngeM49IEW+7EUWR+XFZLkJu/UU2d21fRHQN
vlSziMBnshYR0+ssi6DkSj4cABNkuUa3eXt7qut0EZTWR/LtxgnAgAMC+mIa3FF86QXI/lbq
1CEc88fj8w1e9/muRBLjTJY0+U1e9f4K5GoTMykry7g5uhuVFU9n8/Z6/+3h9TuZybjaJ6UX
ue5iCwzuy8sYcdhyLZ1L1V2FdJbhMVTYWiterf7xr/t3aJT3j7ef3/m1l4XK9zm+PbeY2/X0
RMy4++/vP1/+WMpM+OMsZmZLRcSRO+ZpzqBAf7zdL1aK3+yDehmmDw2Cl/8WO4PDQATvRZxL
ssiLpZKMZpLKS2TJy//l5/0z9Cs9XIfsrJg5q8mRY3m1a8mVY9SajdAtI0WLoTaRq/rE7mo5
GO/EEoFreFyIS1bhtp0SqLrJKh5TBRNxDLZ2ujwn3vJ7W5emzcaPx0D+9x8Pf357/eOmeXv8
ePr++Prz42b3Co318qoOmCmtOQ3cP43+mRK0h5nH14On9CihFI3Z5/KwlVtYWWkDj/xexQTX
MaH/CcyVvISldwlRZtXWczdlslRpPKp0wjVZ5cF6s5jJYMJZxAxhzRZK8TXPeShec2iPEXqp
8o1G+uXch13Ux9BEy8CuXHvhlbrgNbEWcM4ncB0r11fyFOeeq6W2GVwByBbY9qe0d9wrZRnu
n18Zc6dl/vCI/CIGr/MvI5rqvHKc+Nrw50EolkEgU8LqsowZVa3l1sEHWJchY2SrhV4aLULk
OO1LDAdxhgLTc3He1Ph58DVM5C2XpWTnUO4ruSzCfuJdyQNkelh+Usvl9/IcHYrGyhcP0FnZ
Xc+fyl6uI5cBFiHcHmMtwvAs6mZzbYlE3BXI8CDm8pAdY50swwbPkyujdnhb0la5kd9+ZTbI
4BS1PO6HUOWLoEleWS5xn7ru1aUOpZpFxOjLcKVDusR3/exKZkmAY9zSPCDIr/h8tvO5TrHA
515gS4DI8eOFKbRrQNi0Dt8Gi2+Uf96yL8xzkUvIXBgHXHmZ51AWS4tF120uTd11+UaLW9pR
lk6oGCPhyDCEMh5i6vefLw8fT68v1scRy22qCa5IkQ5o5nYBuohzvmtAWKfbDr/t/Mjiez2y
Pcpqx52kBlcIPV/Gei+OHHssCQ6CXf9y6GxBRQUEHzrZFtlZe0bOwOyLRD5dQAY+sbx25PMZ
Th29MIwynxvPOdsewQGA7j8707QnR7GLdJ/aiegHesacbLnlMvFJy/DM9YzadHlC2f15r/Ej
o7P+ySC02xtA908ZaaGRu5Db7cmIUyflE/S7ut34a58+WeAQoXfzy6pW0A72n1Pd3naXnSVw
Lu+3xPWHEzpbbxvnH5x6hvzbpekEwkAAYocGkQD7PFzBgoQdoacOrCA426/r7nsMVWPpWWRC
dRRnLUyUv1hidPZtVtIeO8gUTxoZXSTIwdJHoXPWJ4g41TIachCt7O3IAeTx5cyOQyM3fuBF
5havbCNSnChGRlp4fE8Q11RtgBzbkucHZlpCs4u/TB21UEtKVX/OjFEDuv7BgpcOV2etYnw0
iB6iE1t3PubplbpLrlyOfhX7rlrN6ehJpgl/Mo14GzuxRhIKiUrssmTc/9SdLl9F4Xl5w1nw
U+PsMnC04nOS/gYy0m/vYhjWyrrHNufAubLloXJDnasMezWGCmvlSLOcbrjTIhUEP1b6PqwW
fZfYFxvde1DQ4ijWmhWSK+Q3pHhnG+6AeEjpOuS5qTi/VF0wBc0SxYDnygExdRVmZq+NdWjw
J4xsn+Wzf6RJDkJtSlPeiRM9Dm2jffRdJBJTPBZlqvH+nuDBUquesI7tN6jJprw3cthBezMV
GKGzMkeh9C2+zhr5RKJF6Qe+sXT2iR/Ea2srjK6YcjrSFSRVJmnzr6gI2IJB8tKV8Yp8nHZg
+q7WrYPdzZDAhK2NolG9AJy1JYaEmLenVWy5SMKXqnpfot+vJdqQDNFdg9XPPdseMkAGo6ux
+uFNVRjeRuQvAsUxpK8Th3A9V1uB1IhDQujmzxOSRKp9b/csBS28tDweI3QYdEHDJTSzDw9u
yODCCdVQo/3THNttVx6mcskxfW0K15Tk+Eag4pUwPRxo8xWcEdv8nKWXY130bCe/aDYB0Pn3
IB6G6A6l7Ck4Y/AAnJ9/L6JAAtvBgkWXdJDpLEYSBRU61NI6g1DbjMOAzmdURZdTSAN/HVsS
qOAv6jqCBNFH38wylT6JJ6l+NFOfW1JHc5VpsVS6eqRyQs/CcT3XwvHk3UXjkN9sWRX4AV0G
zotjMkVVwJGexeSqCt0ggncMSCe7GZZ3Bah0ZImAFXqRy+j0YTcKLRdFJNC41VzDgRgU0TYO
DURZOmRIHHmWCSZkjqt5gARCq/oaKKT0LBUjC3ESR+zYlkICM4wogWvGSCobyQvUuxcK067T
6TBSs1NAcbhaW8oQhyE5kJEVr30bS9HxNJZHjlHOCsipy1mRPa+1LS9Nb9V51uKDBuvYSgI8
j04zaVxoa/q7Jli59FdNHAeWIYQ8UiqWIV+itWoVlJig+VrsjSqIvAuhQgLLHsJ59BVmFRRe
GYWjlm5wTOVI4m1yRglYEiJhsEeSQ9j0h5Z42/js0F9tD18z18I7wrJPzxfOovcEzlpb+rA5
0e4oM4ILam1T7j+D02Pv2nCHbnM50u94zEj5err0/DcIDX1e3VFVnQ0SRMbcMHGlcIOlYrlY
/Sp2LHupsJxcy4SbUq6CQvfKmAaItyIXu7b/4rnK67USqzzaJjR8FkYBHThjRnVe2TBLlBQV
1bmUMixhgjKOwogujOmubEJm443JK3aB6ziWmgoFalPXesxpK/bYZtvNgY6qrmObE3WlQEaN
uhmZBNdQL8eSNB5KQKi8Iz9grbBib2URbzgzojxkZ0zfdIEb+mTLog3EE2ZQInVh6rmy4o/2
JFvyg62I5rn2Yg3WH5q3dpeKvHaXBcbBUEOnsHhhXVIQMWbKFYywgnwCZAlDqS20BdvkG/oS
fJvYjEvJbJqVKFXd59tcVliR2uSKRXMgXWDZRsWg+o08yU1zxpF4T08JUc5z3ke+5+mJCp8F
ZrnPMwF2rsc0lITRLeG8DOJBXViM6OAaHGOJNCB4ticXkWvESlDawKi/Qr5s80ILlj/yN2l7
5E8TdVmRqXFs59hYoyXk4+8f8jPSQ/OzEs875xJoeYDyjg/l9scRQltyOBbdQHp8jJUEK9CW
pfzVbrreaWsv0Bhb5RPl4RcpSZgchEltnrEkxzzN6osSI2hosLrq27oQzx0Ot8e/Pb6uiqeX
n3/dvP5A25PUyiKd46qQFquZplo5JTp2bQZd2yhPHQgAS49WM5VACBNVmVdceqp2cvR7nvy2
YN3+UgAogX8Z3FNVp5lGZN1dpVjbqGpLg25+QUFqFK3lCYw8bFXf/MGn9eb3p+ePx7fHbzf3
71Dz58eHD/z3x81/bDnj5rv88X/ILrBi0LGUNT1tMOWtB7u7py17M53oSE4vs7KWg/lLX5Ss
KGrVTqlUT6rx/cvD0/Pz/dvfxr2En9+eXmGgPrxi0IL/uvnx9vrw+P6O7zTcQ5rfn/5SfErE
KOiP42mCSk5ZtPKN4QjkdSzfEB3IGQtXbmCMUk73DHjZNf7KMchJ5/vyaeBIDXxZcJ2phe8x
I8fi6HsOyxPP3+i8Q8pAzjXqBPtjFBkZINVfm/Pq2HhRVzb0pisgsLXcXTb99mLAxoshn+oo
EYg77SagPEqHnBgLjRAvY6BR+ct5CVpIDZaMyLXEUJYRtDYyI1YxZSeY+aGz0lt7IOMuSLHi
lUeucMjAbxYKtMHYfdbiADcIzaSBHNJ3bAX/tnO0cIvq+C7iEOoTRnpdoL8iV5UsZYa92bhx
L5KPdFU61XD9sQnc1ZkkB0QZgBHRNzUH/smLzZ7rT+u14xOpIZ2yOM5s11gBjs0ZpDlzvWDn
tceNZ9I4xplyr0wkfWnjjRqdzbIlZy+I9ZDd8oZFTpzHl4Vs1DvlEiOmDLrSbIqInhAM2l48
I3zSsUXir4luQUZgscONiLUfr2ktYEDcxrZT0aFz913sWQIwaW0pte/Td1gH//sRL2nd4FuU
xAp1aNIQFCuXEpJlxGDVUbI0k583zX8KyMMrYGAhxoNBSwlwxY0Cb9/ZF3ZrYuKiWdrefPx8
ARHEyAElWhjqntH14+0y7VMhEzy9PzyCOPDy+Prz/ebPx+cfVNJTv0S+JYTCMNMCLyJ9DgVb
O+IdmqTnr26ljkeLz/YCihLef398u4dvXmADnN7U1eYYCGN5hWJ9oa8N+zygVnD0zicPi2e2
a6xlnLqmqKrFeaZHtPPADFhqzPLsu4SEgXSfCowjsQ1xBakBRV25xNZZHx2PWV5bHBFeuLKX
HdkBUXakk7FdJHZAfhYt5haEptDJqUaVOdXYeOtjGFJ7HqLJsHMSm8xiTVAjT41cMtEjz76z
A5usWxRGFDWisDEpxNRH2DTt2zmwyYzXloZaRwuDsj66fhwYsvuxC0PPmGZlvy4dh2gqzvDt
RUa+K5+BT+TG8en0esehzMIz33UNhQDIR8el0zs6FvvNjHBJQ/awVraO7zSJb7R7VdeV444s
Y1Uu68KqigrxKHIvSvRkwWpTlpQekaRg2Ava/hasKqOlu+A2ZIbOxamErAH0VZbs7GMfAMGG
bc0vEzL+huBlfZzdxvL+Tu8gfHMpgGbephgFnSCmmobdRn5kl9rS0zoytw6khsb4B2rsRJdj
UsrlVQrFi7l9vn//07r3pXiWS7Qveu6Rpz4TO1yFcsZqNkIcaXJTaBjlDZ2n2rj6QzWbt5Kf
7x+v35/+9/GmPwohxTAicjw+1NvIr+PJvB4U9NjTLgmo/JjeUQ2UKvabmUTU0Ndg6ziOLAXN
WBCFrjULzqYj/8i4svcc2nNQA4XWJuFc0sFdBXlhSFcFeK7ivi3xvvSu5tsrc8+J59COiwoo
0M7VVO7Kod0+5RKeC0gj6KxNwPnRoo1XAJPVqost8q8CRCHcElDVHEqWN/9k4DaBbchy2UqH
UdufAfKXJpDihyxxs5UjG93UREHEtfDKOG67ED41TPBDpge2dhzLEOpyzw0ssyjv167iri3x
WliaLflBf/uO224tY7Z0UxeaSLUYGYgN1EeT3cfdhFrJVKOsaYHla+Du7f7Hn08P5EO9GCEo
bw5H335TIG3NF6cZ0OZtYdYzJbLYQN5gD7z518/ff4fFOtX3ke3mkpRpkVfSugs0fkZ3J5Pk
JtvmbXlibXaBpqPuTmCi8P82L4o2S3olZWQkdXMHnzODkZdsl22KXP2ku+votJBBpoUMOa25
5FAqaOR8V12yCvqdOr0ec1Ts8UBMs23Wtll6kU3iQMe4nUW+2+sZlXWaXfZZ0WhnBTIGn0/H
MoIKaz7wrPTcn+Oz30RYGEho1x53dCx1bNqlZw94s1tZrKUtqLwX+UGWjX04Zp21RLsNPdCx
7TV3Hpl3PrauY3FZBnZzbKklEjgYgQVnl9qjHcx2/6xG6MM64/1RWx6nMg4sD+NiCc7MtbyZ
it+69rJ3exgwGxgOF7y3ah0vpSUSJabgU34eyBiuMSldvikvu3O/CuwlGsMH2vggS1kC/AFz
8GGnC1RmMHCqusy0Qm3amqXdPiMj9WJFNAERSR10oRNpCWEkDVoXK8vmkuZdQ67v5FIpwm3d
P/z7+emPPz9u/u8N9M945Eus5sAVZ6J49puTMfOmBUMBztWa+bd96gU+xTGv5sw8zRfP4JuX
fWfe4Pm6+L2IHaGEOpqZ+p2/maPf1Zk5851xihXHqoyrMUkbzYyRLqFSTTX4VpJjRWnt0Hco
07KGWZN91cRBYCmA8NpeTLhhVVq3jEqZunU4c61ha6Xsj9DuUUF7rMywTRq6Dq20SL3RJuek
qq6ghhs518qlv1k0BohbnodjC+3TMp/Uz1fQ/Z9h33x6//F8P8pl0tQdZaxDWd7x2zS1vMYo
ZPi7OJRV92vs0Py2PnW/eoG0GLWszDaHLYgOI4gWLZdLOeZW1DtJ+MBfF5DdDmfYOyrFI0li
gWBAvi0mQZLiAHrgSku5O1QSZyqqIcuOH3X1oZLWhE77Ie6ZqaRGvtuKhC77YqyHSG/ZqcxT
xZkFyXXXYahOcjQN6V/sV+AQMQRZs/LTu4phhATuDEMLJrzcg6sV7JnodEM0N6KOWbupu+zS
tHmlvhzIs7L45AztcsA4Vi3RXDgCTTI21yU7ZlVP80wq7NkmI21zKHWnEc0sWVHXjUoi0yv7
hh11Uheu9OK0OSsuB1C1VZsPxzeHFWm65T0OvVCyyjuvxgVgn/7CD99kLWmiyZ/uMZw/qBLo
bgOyxtfs13ClFKqBJU4rJ0wRVqbRWjbbjoykW3nyVjjS001rDOTO8trZ0I69upKLeoHuZaxi
QJSThp9zmPu+zapdvycaDmAwweaSHkQyUiLzI3bCNvjj8eHp/pmXwbChIp6t+kx92IhTk/ZA
GbU4r2nUmDiceMD+IFuGVy0rbnN6x0F2skevf0t+yT6HX3dqNZP6oLyUiLSSJTAk7vSiNW2d
5rfZHWWO5klxw4KW/B2ML9ldDonQ9Lu6arW4yDP1sqW9xfHbrOw0tswsMpDU9HJnX6HQ1gR3
WbnJLW99cf7WEneUM4u6zWvyNgayj/mRFeoajmQoDr+VYfnq9s4YFSdW9JYn7EQ+2amrq9wS
MgULetfaojsjO8eggWon5b1G+I1t1OcWkdif8mpPGhVERasO9Pyex26Q6EWiPQjCiVmqE6r6
WOs54mt9ONMsWZZslycldEmmj+kCVTCdeMf9OvU82kwMRlseedLWGB1US62uYNnJtAkGm3Wf
8+7Wc9FeYZM4sKJnt2oyIBNjhFcYb1IrSUSYFNoHWc+K/8fZlTQ3jivpv+J4p+6IedMStR/e
AQIpiW1uJihZrguj2qV2O9plVbhcMd3z6wcJgBSWTMo9l3Ip8yP2JQHk8lAcPSp4neMxSvTu
vGxOL6eSA6xDyl6kZkOVMbg/kcNUBPlk7EG5myfbXAoQ8qTmfyeYHAu3xCdGP92tq5Se0qBx
lfc78IfvkZuE5QEpyWCvTrw1TeZUZXuPWOepS9iCGRYT9irZk3QPutXLWd38Wj5AykQlm/RQ
unnIhUIk/lxqdnIeenXZwxbYVmLiZ3ufpnnZYAd54B7TIvey/JTUpVv7jhIMy08PsdwTXWcu
ul/AK3O722Ne5NTGmFXCFsqxDbmPBuhKCpeL54jr+YVtIBdmuy3lTne0c/MT9T/q/fF04haC
BdO9csfTFq4/5dFJ38faDQGIATuA3FE4qu5rkGETz9rJ54tYnrcx9cyO779B5rxdS3nwFiGZ
M8F/lr2AB+rhe+YYJORcmRE4Lw6SxuuHqgllOsn6RcS/QEI3u/P3dzgXdhruceD5T6ajzgxu
diKWrYqQWtBd51zKH6Utz1/4VdZscowhxwCrmWAFxWxWY7+CPTOB/xF3cRYsvue5+AgQpPAj
6nKsRyHhfy1mISZUFNkLSpWavBi/4CAKwRUIHeb0gvHubhFEdWQH4nnSwVDXnn1OEAviCmYw
TPMFtoG/qLeHCyZPs3XC9sH4NyOSjPIMmM4N7RVAfmwHh5h2qHutWWiAcsu8I/wLXioqcLlY
TVLtkZlO4Wrvk/F31fpCPQqY7+mMB+0NVcnv6YR38CfF9g6VNGQ8r8tsFHQ9eIwmvuJ3eu1y
PtiJO7IUxtcskVzuXrJc2vMohWn83GitNbLfB8c2y+dubCI1Wu7ROCLyoNak3C2NoYX3PlZE
ePH+/Pgn4vS1+3ZfCLZJILzh3n1OyeWQKfU+hZVH9LtakNnVfadI7pVga10Xyl++JdiF1gan
CounDgTK9zPaHQq5rkHYLuTO1e7uIThUsXXvh7VCV4LcRajvQ0eUisyKySiarVhQMiYFWqwX
NRMCHE68pOQwnE+iJUad+VT1dDPCiFFQEv3MQ7eMUuTC3jx77iryq609aQRZKTf3xL6o+6tc
y1Nje7cn3m5tUM3uqELJ6b9JbeM4RdVhoCOcGtjbKqb/vOHUHLwcTsPmlOQZ3VzVzPET1RFn
R3Ajmef2ebnn2b6aLkR/fABx7tcO3oVG4efGjY9fcngGo9tdtdRsoPcAMEf9VSm2cZoHp869
P4l7x3luiqQDLJ3ffR580duUUx+t40h7tPEq30xmaMxCPSH910NFLYTf3EXSHNfp1qM2nIEL
AZ+a8dlq7GoG6MmjHfkMzsjZ7C+aXzYRqtammKmYjDfZZLwKMzasyJ2h3sJ38/v57ea3l+fX
P38a/3wjz0839XZ9Yx7TfkDAauygePPT5Uz8s/OWrfoEbgJw2UbPZ+WNlKpRnh1lrwe1Afd1
1Cfa8+hlxoUr3pX2n1O2F7ohK8KhtP58G2paad1YMCprzm+PfwxsNIw142jlD0Um5CJtx8pV
VHjbn6+CNUEWfzQOlmzEi7GeUaDBgUk/hrucubF4dY9t88nYtanox1Hz9vz0FFaskTvw1nkG
ssn+y57DK+W+vSuboBQdP04FJqE4mJ08szTyHEGnMnwl50B5hTlHdiCMN+khbR7I7Mindbdq
JoqiOz1UWz9/e//828vp+827bvDLBC1O79pCHazbf39+uvkJ+uX989vT6f1nvFvkX1aI1Hnq
c6usnDQQzIoVKSd4cs10XBh4H8LDkr8p9m3oe6J1S9zgbxD6giJdp1naYC83EAPGMWYAQs7H
0/lyvAw5nUzapw/EHW9Kgb7bAFdymnLH3XQMsXua/tfb++PoX26qgRTvcGXJ2lt53GrUbRCR
dXHQAeu1eXcjD4Wvchz8/tnR2ARgWjQbP2xYT9cd5uTe0dt9mrT+g7ldh/rQ3Vb1l4dQDkTn
sINjUcRxEBppvEOw9Xr2KRETtz6ak5SfVhj9uHTVejqOiVc4kFssfKUxl9NyOZf26NOhDVxM
w2JpuhtdxOLNFxGW7e4hX85QZf0OEbh3NHSIVrRy3LxdGJ57Q5vhODe0GSv8C99FoeF0TtqD
CtVixie470yDSEU2jvCPNQuNMeJBkCIdJR2pXMU3S0cudxijOcWZkJz5BCu7YhF+EPr2nI4b
1BSyH8F3k+g2zBbzHdVlq7wPDk3rwDt531WIszuLNR8TbhMNRsgT6grVjesQGylu4KWu5RQm
bE0tyGyJum+z0sBGc5LL0z0ymOuDpCMTCeiOR7CevlyOkDEgZjlCjOXqseyWT7CScpdPe02O
eMuUVklq40HMDJfdYCGRJ3ikrHLwRZ6/AafaKz40p+rjXHugUIWpXj6/y+PE1+GS8LwU6EIX
YcuFpM9c60mbMxta/2DtXM7aDctTVxfDBQyOJQUZHs0SsohQxww2YupaKtus5fWPkY6LRTQd
YbuJ70HaouPrj2hux4uGoa4n++Vn2WC9A/QJti9I+gzZgXORzyOsNuu7qeuYthtg1YyP0O6H
wTm0IPq6wzZ9hi4tYfx5HwAPIegUCgKkdLxPD8VdjjoiN4AuGouaQOfXf8NR44r8ZMJmDg/K
gfeDHtOF0BtEbUTWbpq8ZRkj9Hj6zoW3leuI9qDk1AGYf42ObCDDCejQmYOQQz0dX4FcIo9e
hUHg0UGQUYYbLpI8e6MXPX21/UhzFmM+3NfUC8plDWC1uWMNe+0wXH8V7nWCumnq1/zwebUf
X43837UtHWLeDAJ+/TRd+D54AnGYvq22MP59WSg3BfGLAgj9ftu36XF4LEh+SzzM9m1SHPAX
xj4N+hWzhzTRYjycjXZffQWymEfDqRxhAgwJEosJvszTPi77T3UszOExqhSUgisVuNEU2tD/
ypo7aNkUQwQ/OOWLIAfJAte9gY9G8GwIFoq2zvp9a/wdGsJef3wh6N+yXw/JxdzSLgVwKZVw
wxZJtoHzugiS3SWsCqnqykBd8gskM/WNuupIvL3BqPF49e8SZ/sjmFRlzNL14ztWu5p18XS6
WI6ChxRDt4uT5hCClacpGFOhfbRrxvPbCfoiwOPIqnfFaqWWX7EiyWyy/NkxLxHZDbkuVV9a
VhyaoR8eYd8TbIv6u9WVbtdZW7rqazYH31UthHouRZLvKtF/s0cfwA4bx2ej/CXHVyqbfW9/
q+idL1QilTZ3Lv9ADz20B9Da6U7SigKh67CL1kNc2W5C5C9QugopcPfopNrRgzdtF0I8LRx2
pWjatGwy2xOKItZp4bxQaKpffONS6/Ht/P38+/vN7u9vp7d/H26efpy+vzvadb1zq2FoV4Zt
nTys7Tc3OUMS22pC//Y1vXqqvmJWszv9BBEz/xONpssBWM6ONnLkQfNU8LCXDXNdFo59gSET
d5qG282z8DshpOBaYBK1AaSCkWWpeLawPf5YZNuUySbPUbJ7N3FhLFGHCzZ/Tn2IHb96fj7B
CsjyKpMNn5YQuljWG0laQ6TkM5kDAl9HPOh8cg0qJysVBspGDLRFzLj7atvT5YE7xy5vLoDR
0lQW+RRP8kph4cvrkPnU90nnQZpoScQmsBCoOyebP8WqAAzsksDmL4gPI1w06hC5lK/YwFTc
ZDPbBUg3WEAzNC3HUbvERp3kpmldtqgVYTdRYWCn0eiWB6nz+REOp2XAyCs+xyZCfDeO1gG5
kJwGInfPsOlquKjDdguRe37bXdZ4josbF1jG1hW/NqHkDGeYW4wLO2ZjbL5ITo5u6Rf+Hq2A
UqK6w+ShbqGdIWvfMpqFrS+JMyQHILcCu+U1gFv913mBQ1Y2bKLbjp0vTd0gI0aS63LfpEW4
EXpisE1tkyPLPeMyh2+STbD7cyksbz35oORNUhZtAsYmRRI6zU9lH35///z0/PoU+OF+fDy9
nN7OX0/v3dmk89vicjT69fPL+enm/Xzz5fnp+f3zCzwJy+SCb4dwdkod+7fnf395fjvpOIdO
mp1IHzeLiR0JyhD8iIkfTNd48/z2+VHCXsFXPlGlPrfFwvVPdv1jfUJTucs/mi3+fn3/4/T9
2WktEqNAxen9f85vf6qa/f2/p7f/ukm/fjt9URlztKiz1cTxKfvBFMx4eJfjQ355env6+0b1
PYyalNsZJIulPVENIegKMin9nHz6fn4BFaGro+kasjcCQYa5N2vazgbSOhsoz6zK9AmX4Tvv
pPrbAYy5f4wHfXzD7eOQI9ZaniX4Lq2upRNcufV8dT0EnwfrAHv98nZ+/uLOVE3qhX/Rbqot
W5eugsy+SOUxHCwd8AVXnqBbnt22x6wA4/3b+0+2HVwOxxeJqsoiKexFUTG8Y5WiqTqitVPs
OM0JswJ1piKC996KBXUTaM48EDhJjgP8IrrD7FJ8U+74tNZPjyixK5QLt6xAe+jSTB3Hs8rs
yNpSOsjlkK5rQrexr26dxtskbqvdQ5isr+Pa0anm7UuJenvpuCLGU91Tl4kdgNV8hzqv4bke
Ln7MdaOJ3x7kdML19cGWHdHX92YardF/TLOWHVNwBraxXXClSRZDkT3Fl10OKt5QGdnyqMXg
/cbRHxm8FuQ7OVCT/saEMAdJsowV5RG9WLnID5mUIY/lGPUkugP/KHJKWzdkhgK+CeSKkDhC
jlkJMNrl0Uxvvy/n3pJA6YnCC1B9+v30doKd6YvcAp/sS82Uu1ZrkKKolv6M7vbnj6XuJrcT
Mab6Z1Uh1DxxmSv9EhvyAsUUi7dL55SqtIUSnAhB6GBQVx82Ip1NpmOiIMCcEUdICzOeolWU
nCnJWfiHpI63zsdLIpCHheIxTxZojAYP5CgS2Twhhf1RyyuiGOohMkuOorrayAAV7Cpsm+Rp
cRUVvh0gzadDDqL1kusP/N0mhT837sqaWPeAm4nxKFoqN/XyMHytlMEDCwYaDnVsAUPdIBRF
RPC0IOWxQHWMLMiB+6fHfrbmVaSVQq92uI4+RVm1qW7gYBxP1AlGOUtvIZAYcYMDCLnNLMbj
Nj4Q4doMhtqsDL+dU2/TNqDdsoboT4MizS07AH/YFoRjxA6yq4krLcMvCLdbF/7w94IYabDc
XkKsXuvdXSrXvDk/TOg7OgeKP8V7qNmKvJGxYHNCz8JDLT6CWqyW/EBpE7ibTUQGwBZJIwEC
bzPR7NfXkrAwH6ndWsrrlN3jEbSl8XcV+FSeyJY5sUJ0bOJlq2PTo0+xncVTX6S8Pp1enx9v
xJl/x95z5QkzKVJZ7u1+SGfAh0UzPISNjyPa04cRw8WHEZuuDTuSzk1d1JKwYOlQDd+Hfdmd
2rE2RQcL+DaSowVft5rUGP74GeGypnKO3Jz+hGztHrT3hyZa0DfuNorQcXBQ8wXhpNtDLa4u
L4AiVCYcFKk14aM+kONyTO06LopwJO+hFrg2socidJY91OoDdVzOxnN07A0PC2vkmDdSfZD4
+nJ+kgP2m9FHde6qPgK31jhQjJL/8sl40uZSFLsqE6XyC3mevSqygEtUcnVTvU5LIrWU9cR1
+cz478G3AbDdHY8s+AAs+hAMAscNw/RJY5MSDjDUul40SQa+7eCSC8+rqmMiIzsbuH2z5PGO
JP9X8luBcaoaJBZQpRviLge5K9dNn86R76/1VANvWOToym6H3S4o0X6bw1KP34GkxVGK2XtC
zA51VC8XIvfytFX42hPWtBPnH2+PqIfx7nKH9pXZCbEDEKPGOoTolFiHMPctq9YDgE3T5PVI
zgYakh6rqZTKaYC6W54PAMr7bIBbx0PtAJqfQ60g+bO03Qkaoe+cab5WPh0AFBXPF4MtYJQ8
26bhAyijvTyUTnYrat7G6yOUCGYWMX+Mj/qhTjmKoSrJwV0nQ51eqGaDkOasul7iK2u/BimF
xpbwn8zq/LDIlUJdSmgsKVfzMiv8LlZzCdc0XQlM2HHq+N5pfA8MZTjVt3U11Lh5czs0YGER
v9qgv8KNMVlXsdMptDy/AsibPaFDqjfSVh5y8Lbok2iIQZiYdqIDtZuxccR3s52UzOVkyGs8
BEDP9uUjl1/hhdMlg5cxFfeiGWxsAa7F8YcD1nDZCePB9aE/SVxFyLKUxAjtIBRfOY5Uj2+y
PPOpdyhzJDxvZ+oftFiarUvnEl+9HEoasnf2kd/znbN7ap33dgILYn0v54r//WWEda+FRA4s
axK5MOdemfThnE5WH/BpvqlmoGbXA6oy0xr/IGt1cBSpfPezioMfBHx4wEZexZwujV7z5OeE
0yq5VPA8vhtIAKQyKYZvSQCsJ+Tnqgp+9l3vg5qr/PdgaZRpGqtSn2R8C3YPJFt4OpcnB8W8
qT4/nZSJ/o1APCeabNpq27A1xOyoGC4FB0i1KeAhYq8VwC290gfdOHrcHUPresY5A5/PKSdm
ZwDO2CfM4tkFVkyIZleX++3u0p7lpg0UjJXbNF2VwalEQ0AOGqUDgLSCkh1yQh1LeZSWUifx
0il7ohVk3pOVPE7x+6HiAWSwjjAVBr6HUR6wjbLG1/P7CWK/o2YMCfgjDV3n9fobwcc60W9f
vz8hlpyVnImOsQYQlD463nGKXaC2xoql5ufW9R/rc4AQ5hk6Or9Uyil8r2YCEQfutaWTtqA9
/3j9cv/8drIiXWmGbKyfxN/f309fb8rXG/7H87efb76DL5zf5YyLPS0tc4cgzqgZiVY84aw4
EKd2A4Cjf8LEngjq1bk3hDU7LTaE/kXv4hADdVolSHl1RfRrF1EPzQU5AaQJ/LhqYURREk63
DaiK2NWEBqsRltaWWlZjtbsR6iA9X2zqYD6t386fvzyev1It0R1vlcYHPllLrt25Ea89ih/6
nXB31RwXcdDSaWW0Y/XL5u10+v74We4Dd+e39I6qwt0+5bxNim2KmmbFFWNw8dNFN7loq13J
Qnur+e/8SGWs+gTu79G6BV/qi315/v7rLypFczq/y7eDp/eiwkOpIImr1JNXtZtmz+8nXaT1
j+cX8LjTLwOhU6e0SWxfTPBTVVgSIPZZpvSD+pw/noNxuni5/UTXGSNJkXtLnBwYIcWprafY
1Ixv8CtDAFQQ2OS+JuxzASF45XnKcdh5HnDtaIh+3VTl7n58fpGDnZyLepOQB4dW4OumBog1
fkJT3CxDpUPFu8vTLiqfvQMpntyGcO0fxRV5DAgacM8LIegl0MjeNdpgaLO4s2zoorgXp7Y1
Hi3CkrdiKZoRUTPUAjp00VxyffkkjyuHMmvYFmIi7aWcRS+bCj/5B3i8Y/fqAincAdTYOT6/
PL+GC4ppW4zbO07/kGDQHyFzmHSbOrnrJA7z82Z7lsDXs716GFa7LQ/Gr3hbFnGSMzswkg2S
YxLOp6ywox85ANifBDsQbDB9ExUjv5aie3pI/JLHiGQgRePk+FCUSnOuS4SUouHM/RGcvrZE
UEHr9oGLLte+NqMrXFFyfO1C0VVFSOIuup8p8QZT7kqODVcGrHpT+ev98fxqpE2sKTW8ZfJE
/StDffEaxEaw1dQOtGvoRi/UJebsOJ7OFguMMZm4FhwXjvIhSJcg8P9k6Fp/CEmyaorZeIa/
RRuIXjjlRqPsCum862a5WkwYkonIZzPU+MzwIUqArzt7YcnlRP47IdQncnmSQr18pXabyx+t
DuGG0Vq+RsnyRE3RtZSGcsG/sRTS9rmf2S0ovbaOBTmQjT89KVljJdT/tb3EWd8EUJWrgFWo
h0Q2RNwHodkM+ZLiRUhzCqdmVrBqB9Yw3VoRH7PJwrJTMwRj8tCJ1Dmb2gZF+ndvFtFTuRyi
yq8g5vUuZpFrfB6zCWrVJ7utjkeOSaImrSiw7Wtrc8zEcjWP2AajufVSbdroErcTUHgmeOBB
quP3hbo9ihgr0u2R/3o71p6rL+OfTyJClyTP2WI6m5Hq58CnNI4kbzlF/SxLzmo2G7dGedyl
+gQ7krkKB+8sa5I0j2a4moRobpcTQk0EeGvmr1r/fyusfoguRqtxPbMH7SJajZ3f89Hc/92m
G7lhg400k8cJx7xfAlYr9JoZjOqO8MrsDHVzxGZE+GB1Qh5kSsmPzeKIBMEhVoVsIBGcgwpT
kE0/t1YwF7eVV/CkOCRZWSVyeWkS3hA+jMwujie9Ozq24GnBInlE9PLpHiSo0ks5ZkG3n/bA
OMDm46XOk+JPoiF+w6PpAlt6FMf1OKZIKyyODUgGjs9C0JKfu07Xcl5Npqh7RWVz1SRK62ky
H/kNaLOl9AGeP/DuyJOi/TTWreUmANdZQg52/LMqmkcr85GhFWy/8JyCw+s12Y5aWtGDDD8J
cVZDBLiSGEp1AU4Pg6L3YmFY+gvm0zbKyJJpl2Q0GxyS0Vw1MCGofOhC3XuaARwssAOQeCPi
/GMgvJGUjgsfLcdWTymakHuMtQgal5VyFNp9KqlzoHYrgSEfNvPxyO19o+9y7Drjn1q8bt7O
r+83yesX94ZJbqN1IjgjovGGH5t74W8v8ljoBrvM+TSaOWW7oD5s92qv+YFE/c9MYPkfp6/P
j2DYqnwh2VtUk8mJUe1MdDFn61Cs5FNpeEiPr/NkvnTELfjtii6ci6W71KTsjhxlVS4WoxF2
IBE8noxa38JMUz2BxOHpsLHONxBzsU5h0dlWaKwiBzG1w7hW/8fas+02jiv5K8E87QIzGEu+
xH6YB1qSbXV0a0l2nLwImcTdMaYTZxMH5/T5+q0iKYmXotwLLDCYtKtKvBbJKrIu1dj8qXdX
gLpKWy6+ny+0bGnWjIhwVcenNlwVetIGp5eX06uWo5YkUCXBtJLTVcl2de7n3HmpZwDNZ1fD
iceRqmhrspthIw1hVG8CjZNTKX20BeMCDz+IdeZaCtPRbELMGCDGKifC78lEE6ym04WPMeHV
tJccOi41gOZZhr8XM70bYZHXGN5EE/urycR3JBiQMgB8QQvGM388Js9dtp96iuaNv+e+eWij
6frQfu2oteYRWqZTUrgQe27bxc5FfmCKOiZ7+nx5aTOVm7urvO/iiaLpW3qzAJFq4f3wP5+H
18efnVv+fzBBRRhWfxZJ0r7PCZsQ/lz+cD69/xkeP87vx78/MeyAbR3soBNBbp8fPg5/JEB2
eLpKTqe3q/+Cev776lvXjg+lHWrZ/9cv2+8u9FBbId9/vp8+Hk9vBxg6Yy9fpmtvpu3G+NtU
fld7Vvkgkbt0uGI7Hk1dW6pcwlxSotVQjiK10Lhejy3nGIO57N6JffHw8OP8rGxeLfT9fFU+
nA9X6en1eNYPtlU0EeFz+66x/XjkkQE4JcpXGZ4sXkGqLRLt+Xw5Ph3PP5WZ6Teu1B+TAX7C
Ta0qKZsQtaW9BvBH6rXBpq58NcGQ+G3O8qbe+mQ69Pja0JkRYl6FtZ00OyQ9cGDRY7qYl8PD
x+f74eUAAtEnDJD+fJrGkvmIVqz2eTW/HmmXIQKib7U36X6maXC7Jg7SiT9TP1Wh5jAgDjh6
dpGjkyqdhdXeYmcJJw+yDjcmcYuwGrngZqCOgTEVaViO35/P9opn4ZewqcaedqOw3QMjq0dh
MtYYCH7DOtSuVVkRVguX8x1HLmbUsmHV9djXhbvlxrt2XP8iigxxH8BJ5c1V59pUj2UOv8dq
nP4AM+LoTqUAmZF+0+vCZ8VIVxYFDAZhNCLz3H6tZrCkWKJsb51EUyX+YuTNXRg1jDyHeL7W
0C8V83wyiFxZlCMtdVhbsEj41sOTutRzhO1gfieBGtSD7WHzG+lpFgWMugfMcuaN1QQJeVED
NyhVFNBofyRhytbheWTETURMlPKq+mY8VnkQVsJ2F1f+lACZa7gOqvHEo4Q+jlHvhNsRq2Hg
jVwMHDSnGssx6qUcAq7VYgEwmY61rm+rqTf3KafxXZAl5tgLGBnAYhelXO/VyDnM4UO4S2Ye
uYruYdZgkjx1X9H3DWFh8PD99XAWt5nEjnIzX6gpTPhvjYHZzWix8GjXJXmxnrJ15thuATUW
CQWUm+FgPPUnVJfkpsnLo8WNtioT3XICqOLT+WTsRJjM1qLLdOyNXGfGHUvZhsGfaionrrVw
oMZWjPrnj/Px7cfh36ZdC6ps2z15/GrfyKP38cfx1Zo75Rgh8OqIobVww9+TOxPXNrvX1R8Y
uen1CUT714MS8gO+2pTSRJ5+0kEnirLcFnVLQF+k8gkTrhFacReonbRqtzDeDwbtod+xRIhj
tfVyvOi+yxP3FeQ/nnrj4fX75w/499vp48ijmFmrhh8Yk6bIK33xXS5Ck+3fTmc4949qJLhe
D/U88gQOp766VYUY6HJs7PvTCa1ggvYoTjJNoYSdjtoli8QUkB3NJrsEw3tWjajSYuG1m6Sj
OPGJUMneDx8oFpGS9bIYzUYpFc5pmRa+fj2Fvw1tPtnAXqsFsA0LEKmowd4U+tDGQeGZCoWi
SCWeZ72V9UjYBpXTL62m5oU8h7i+B+T42toNizKq7D2SQ/Ve19OJ3pVN4Y9mVE33BQNRTLkS
kQBTgrWmqJdbXzEaHLFb2Ug52ad/H19Q7cCV83T8ENeb9qJD6WqqSyRJHLKS2+QZwfXbcVt6
mmBZaGEjyxXGGFSzlFTlSk3BUu0XY/3wAsjUwQD4LRXzF4WBsSah75LpOBnt7SEdHIj/3xB+
4iw4vLzhvYhjqfFtbsQwX53DnTRN9ovRjBTWBErPZ1ynIJnTfk8cRT1mAcJTr8Vq2N11JuAQ
PyTPVKqHHTPcKiHH4YeZTQ9BbcTt/sIagNwnj7JdanHNJgnCwK5AIGtuLaKV2L2q0pfkksIZ
IEYSOAPVcHxUJg6LP44eMFxGfOub6SQYSNGCaOmD6MRv4uXO4dh0i9ZltC2iwO1p6VQifTpA
gsTCQedulPBdN/LBqnixQMzZHIhDguibKEqXjDI5QixPWz02i2xvlSuHJ4+kceY6EXg4Fgaj
0iGVO+kPx6LJcewIIiQ+F8/DboI95TaCmDZzkkbOXYjC1HJCVEh4Wmv9bZyDHQ6aiFNiFYEU
53iaQrrA4QHDkdLX1OWsyWnki7GTYMjSluPd0RU4OvHnQZHQ/hCcAF+UB7DlwKcOK1yBc2Vx
6bAul2hOgO7vTqw72w7HxlHgMFeX6E1JB8Tk6NtE35MBgGlpTe7ZxRjZZmAE7OROQmUrv149
Ph/ftHQQregKW2BMa8kh+ozCt9rVEXeWZrHDzkByH+xRAX5ZODb3jq78OlxQec88N1XLaLw+
+gSvJnNUoUva+FcNTOSiaZuymVfueuDjLnoGjE4YOXwbYW8H0qqOXConEmS1pY1LtDQ1wtqC
PF3GmaMYUEOzNVq0FMEG5EvHKwvGyDU73SrxJsd0Am/BgptGywsi3pkBkwe1+t4swoghwyoe
KRqO1RtHnCOJ31eeK4MvJ+CeTxNHckVB4ZYwJMGAjKFRSMOMAUIzbKiBRiuuITQ/19e3AyQ3
viuDGUcnDPYGFxNzAnFgD1CkwaZoML7zfmhQB3Lw9XgRU7Fh5dDYosXUAHo41oWgEd4reeXw
P+lpCpdxFCcRJlLballs7tyuMoLWGYJVovkb8xDBQOAhSeHKpMexXZAze0kNhvDRSZp1sh1q
JUbsIdEyqk8bJvBSgL+WzgwWKBTtzd1V9fn3B3d06fVqmcnQiEjdA5s0BikpFOj+CAREK5Si
+X1eO2QYoOtYCymdVK6McpxJWCYS3AcRJgIyGyKjCbTtdFYhvcnRG8BJI11yPR/TSC0dMo5F
N8bUJw4xrSNm+/WvkvG+IG3DMmYELx/6ZLD70nkV20u7uPGh5kFGh9spIoE6Z7OLA4UD2Fxo
UZNVwwPd07gnLav84RYjAbJp6JJ3sSIe8ovVDtGzpRjiYTkwZlM0TpYxlfKyFO5NBDLU1qKK
qWAzKZkDx5JdrqNQ6xaBNbHZOi6N93AIOhe3DEgy1FsZ0+QSyfUlEjzxUcYa4hQMkQrndpYP
M4s4l5tduccUWoMsIUlLkEedRcpUqNdT7keUbEGaLIcZmstAF7hI0Bhjos7MLlpuG6gWurCt
09icmhY/3/MUDxvyKgH33T1r/HmWgrQUB2YhHXJwPJFqaPLStBhfJsD63RT1TbNd0SJFi9+E
DimgJRBs7Iiiy7d+LmihAB2SOX6QJg+iJK8ljTleXIAe7KoMSvN1MvJ+gRB50z3u0k3ZoeZ2
BINzx0lw06uyompWUVrnrhS0Gvmm4ozxC+W6J60di/loth/mDx4YE0fDSVIyHi5kqBRhzx9l
4+Fjonfr5L/2jjs6lZJvOYPsp5MGVTx4BuvU4a9SD+5kHVV9Vzgy2CCZ1GjDYiDXi0LHl9Qv
UQ42rg1ON7TEO5ohdu5k6V+mcjNCRzVwUvd3DJvA2oLRrhlv1ryxN8KRGhI6O9LJZdJ4Mxld
D7K6uFsTypN7rvkVmreYNIXvuJwEopBJ6d1JwdLZdEJsmh0Rv56V9w7OgxF0qCIuIvd0CH1c
3os3UZq6O6aTDrW9u7znsoWbiXu6wYqlFwoVW7V9v9P0q46V0F8/YFoSjNB4dJDgVHUjhh+o
YLVmG8XhHUMZ8xfBF2GeSl4xltBdRxB2xIVpMAOpzvKCb7swUEunF3M/cCu7VVtJFpa5GZ/H
kfkqiZfZLoxT5ZVsmfCQJtDASAsOhWmDyNDAgAgSpiYPRtJaEay1H/mqLbql5g3ggc4VIwG2
lylnNZg2hdBIAFEt2hkVwM/uabHvEAfzO8iYPmp7ijzIa1oSEEHlm2i1dQRKEYW0inqEEcOG
amsJXfUJKgzC6m4TimOXGpThosvC3FmREG9WzuZ2R567po5kuDOosrk7I2eP77mY/IluTXdU
XOq38LQYGLs21NelgqpsV8FsrQvqUazEbFFVIadbM18Q7ofu0nlAukuVl65xkCOKWnK2K5lG
JEzmb6/O7w+P3AbE3rxcMVvFDl1vyE2FKLL/0nn1t3KoCnVEiQM8t2qRRHu+IZgGfnbMqHSL
Lp7r64WvqOoI1AN5ICRt09HaRoBWqLsCOLXQDpIqdoXPTOJ06cgVw+334N9Z5HhMDvItklAD
kVd25sAA9kKamxFbZfRhYIRLEa4/xx+HK3F+KqO5Y2jmU0cwaegjX6m7MoBilEF6SLSv/UY1
45CAZs/qurTBRV7FMFtBYqOqKNiWcX2nYcbNyoyDMtbKIYeipWqLJMYWSCZmwyfuFk6MFqpV
TYTdiquSG9ivajNb7pdl6Ou/zHTzUF+6DFiwUTzqyiiG+QCMPigdGIjJgDfKd+bEqCii6yra
nqAvVlO+uOZGwVPDiHDXKPJvalbHGNVbq23P6yc+Wa8qnS2XdTdsBkTrdX+p2mL5kMpI5jQn
daTlFq+iYLLvzNkWJMYECyCrYHxrsuoyWjUgFMUrqtYsTsw+rnxrOjgIx44eJvlFxxP6dxem
sqWx2YJjxMDZ7eMxbePsS8QTilGV4i0bGlXGjqc4Thfn2C2qWY4ljIGH9fUuICDpgugCW70+
cDHGGAZEnFEsCZ9FWVDeFbIPFLhhybpy4eIM9Juo4b81GpxwfWl0QHuBEDTLbQynJzBivM5Y
vS3J67dVleU18JUib5uAWAB4hDOtNUwgaDlymztuYjkGM+HyyyV+JmIUFqJtnDKo9bgs2zpf
VZPGcakh0C4silc0++cwZgm7M9ZMD4UVGMYlMGoDfwa/7ylZcsvuoC15kuS3jmLjLIxoQUIh
2sMM8J5dIkwjGK+80GZEhkF4fD4oJzuMPi7XLgZ3xwzGKSMBtjUmB+PKoCNQyvpE3eEfIAz/
Ge5CLmb0UkYvF1X5At8zHLO2DVcWqq2HLltYxufVnytW/xnt8f9ZbdTeMXGt7UxpBd9pkJ1J
gr/biNxBHkYFW0d/TcbXFD7OMZZzFdV//Xb8OM3n08Uf3m8U4bZezfUqemFB3anMxggIUd3n
+du8qymrrfOAg9zbCEeXt9RxAxhTFhOw2WQJLZavNc5Sx01yv2/2fF8fKN44jFvhdWhSxX3N
x+Hz6XT1jWY1HkCJ3AE4BtTWJCwjZR+/icpMHW/DVHmzXcNGtiRADWeLnq+idBXCJh+BPN1D
MdFzs8GIOfEaX8UC4yvxp5+79rbI7qMi/MdVwA8tzH0SpeQYR/VtXt6oVMq9SaL/aJlL4+B+
RpOqWwQNLAKqNpXkWvWm0DHXUwdmPh05Mb4To9mlGjjaRkknchh8GESUC49B4myiGinKwEzc
jZ9R3o0GyWzgc9IxVSVZjN2fL6aUv47xuavDi8nC3a5rOqoHEsH5gHzXUE4eWiGe7+QUQHk6
ilVBHOugtiKPBvs0eEyDJzR4SoOtIW8RrhXV4heOLjha5Tma5RntusnjeVMSsK3Z0JQFeEPH
aAm9pQgikEXpS/6eBGTBbUlLOR1RmYP6d6myuzJOkgvVrVl0kaSMIvLuW+Jj6JUWULhDZNu4
tsF8mKDxNgbE85u42ugIXSYAcQC52QI0GbqZJvE94+pEFSUrKTT0cU/U6x0Rdejw+PmOHk+n
N3STVAQieSHfjQX+Bpn26xY9WrnYRx2eUVmBTo4RfIG+BE1JK6MuUSQIeVnU3YhQhiSBUXkT
bkAji0pmJZ1uT2SpdDZhGlXcro/nXdFu64jLHwvpkD75dUPAlZ8URltELyea0YpgfXOY4geY
VOlfv/14eH3CqDi/4/+eTv96/f3nw8sD/Hp4eju+/v7x8O0ABR6ffj++ng/fcXp+//vt229i
xm4O76+HH1fPD+9PB+7L18+cDGj/cnr/eXV8PWJ8i+N/HmRAnk6JA9EMrQFvgF8yLbQXR3El
FbTcrh+6xm2QrmBhKJSKwBJwceY+KnNglgSNTWFay0jnBwJNiveOPrVo95B08bNMNm/buc9L
oe2r+SuRCfP2njl4//l2Pl09nt4PV6f3q+fDjzceaUkjRsVeS26kgX0bHrGQBNqk1U0QFxv1
ytVA2J/AyG9IoE1aqu6YPYwk7ARAq+HOljBX42+Kwqa+KQq7BLz6sUlh/2RrolwJ15weJQpX
LsHK+ofoW8VTRBnXdZJqvfL8ebpNLES2TWig3XT+h5j9bb2BDdCC64qfBHbBq4Wq8/n3j+Pj
H/8cfl49cm79/v7w9vzTYtKyYsS4hBv3qESB3aAoCG3uAmDFCGhJgauUmh/YLneRPzWSzYtn
7s/zM7qoPz6cD09X0SvvJXr1/+t4fr5iHx+nxyNHhQ/nB6vbQZDaE0nAQGWG//xRkSd3MjyL
2UYWreMKWMA9YlX0Nd4RA7FhsGfu2hlb8qBoL6cn9TKmbcbSHvNgtbRhtc3+AcGzke7tKqFJ
STtfSHS+omwjJbKgmrgnqoZjGzOb2Atjo4yxMcIhyEX11p4dvP3txm/z8PHsGr6U2Y3bUMA9
1Y2doGxjKhw+znYNZTD2iTniYG7nGMwmNNpuw57crJcJu4l8e84F3B5oKLz2RmG8shmdLN85
/GlotzwNqaUA0LavA7tqDIzPjZwDoogyDT0yzFW7ljbMIz5D8OWqgcqfzqzOCLBzlgA99YhD
mIOHvhrbwJSA1SAwLXP7zL0tRLVC5Di+PWvP2d3uUxHDAVAjXYuN7xtufg3Cz+0KNA739wFL
I1Ci7G28RbhZnqGqwB1jSBzFVgifuRsj7IItmLMJK+M5xdjq7QmKykLzCugm0y67vs1XMbG4
JLzvuZjU08sbhuxow2OafVglrKZUqna/vs+tiuYT6hxN7gdWBSA39tZ1X3GBRAS4AOXk9HKV
fb78fXhv43ZqKkTLV1kVN0FBSZBhueThx7c0Ru7G1hhwHBviRU5CHXyIsIBf4rqO0MmjzIs7
C4vyYEMJ7S2ClqM7rFMw7yiooVGRwOw7+3DsKKSSQMmxHB9lXFLNl5hOboh3sB+YiMzUaX4c
/35/AL3q/fR5Pr4SZ2kSL+WmQ8DLwF4SiJBnVOvBNkRD4sTaHPxckFC8j0hSjrTpqK0E4e3Z
COJyfB/95Q2RDDVyQIzs+9BLm8ONdZxmHEVsTZtban1FO9Ttb+MsG9KEkCyL2ZqVjNpeEC3N
zktH2ASFsprSdnZqk3hMFuawb7YIa5cltEUJYzbcS0FmBKSz8BGZxo6qzR9NSAULaL4GtD2f
RoLJ7y4PaZyu6yiwNkqKVNhK/8rY2llfiblkq2gfRLaei8ggAMnG0XnuOlZFl4YxTfJ1HDTr
PV2DgifeodVm+lvaBkwhau3X86ASAlJKPzs4PtkEW6IzrLpL0whvHfmFJTqD9D1RkMV2mUia
arvUyfbT0aIJIpiNVRygzZ1pcFfcBNW8Kcp4h1gsg6K4RkvWCh88Omz/9snxPDIhfE7dpMbr
DFPJRsLmhRscYWNiRZrB8LnfuEL+cfUNjdSP319FlKfH58PjP8fX7/1pIp4W1dvfUgsDZuOr
v35T3hYlPtrXJVPHhr4EzrOQlXcXa4MjKLhJ4qr+BQp+gOK/qGaV0S4Xg8NJaPuEXxiutvZl
nGH7YYazetWOd+I8qksWh7Om+No3v4U0yygLQNYqlRzQaGLESiDJ1urxh4EutCFYxqCpwMSr
wftbl3RQYrKguGtWJXdDU1lPJUmizIHN0DG/jhNdm8nLMKa2CBiINGqybboU2UK7XuKQqzE4
Opf5IDZtUkE/hh0qrjXBPvBmOoWtQgdNXG8b/auxcSoCoHtsIXc4TgALPlrezYlPBca1/XAS
Vt4a7G5QwHTRVesqkS6xBdcqXyzta41AeXUyLyqAg8I8Vbreo0At6Qz2dGgY2fB7lGFAOE00
g4h7IaEZUFCCiJIRSpXMdR2SfkK3BLQggpyDKfr9PYLVGRWQZj+nNFiJ5O5IBfVZzMj7DIll
ZUp8A9B6s02pyzpJwTVjs9HNMvhiwfRZ7HvcrO/jgkQk92p+RQ2RO+ATEi4V0LY9rCzhoOVG
/+oBinnLYdXvooYT9Ch8aopzzetHgNCsrdF2AoRrWSHhh7T0lICMp0gXCNjD1vXGwCECve7w
RdC04UEcC8OyqYUVlDplHIde0k5jq7bkbuOmTrh1Il7o+pqh6+lW5lNWOvZV3RuTfKn/IhZu
luiG4EFy39RMuz3GaEygsVDGv2kRw6Ltv85j/qIHR2KpTFWFDnm50jKYNaRSr4gqGLhUd9gr
MBAA/difL7+w9Zo8dq1TU39BbcUUDn17P76e/xGRP18OH/9b2ZHtto0Df6WPu8Bu4RRFty95
oCXKFiyJrijZ6ZOQTY0g2G0bxMmin79z6OAxdNqHIAlnxHM4F2fI+/hEPOOH2wdQQyuQjdV8
HvZXEuNTX+ru+v0yVtbJohreu1pFvTaoHuq2bVQtv42V7Ozsanr49/Tn88PXUb84E+odlz/F
QytaaGk4qra5BiPm47wQoK6C+WAxfa4O8gtUTt4HAAq0sNV4oRqGtcImcU/GiPZRSyN9qS5t
rbrM2WAhhPo0mKby4p+5lsK0GaiofZONsdWgtuKuk6KbaXx7Q1HGS2uHGvQhzAFS+7CLXPlR
qx29xZrtOd5l0ud+doZpPciJ9nA3EV5++vvl/h7Pqctv5+enF3x7ws1dUmjlgHLZOjqdUzif
t7P/53r148oJ+nPw+K4yMUSBRmijMVviLMeBlyycbkuHo4RQY4KSzML8mjDGQKIPRUwc1ne3
yT0Gg/8LH/Rrq+LwAiod1tCZ3BnMpVKkpATIbsuiCwvz8kBRCm4XGdI3sAeyLS6BHK089sJI
K8BA3fSexII5AdMMACgXy8q/Ov2niMhfT4xZ1dHmw7jQyawYAyvmyhYqpGA5sLjwYTaXN3Md
CA2EUACYvJNLzIDDy6Fqc5SdUASEjWpN4xkkS/WYBBOWgwzQfPYZEOIIuKSg+4hF4MbwoXQL
quxM8RExrPbVtvDmm60XCeLDgfEA35myAVNYwURfefQ0EgII2QpYWVjFa+UonElcD+wK/bBa
rcIRz7hzGFBRXJigGR3zGAabKSm8aJQSFKXUWy8S2mZbVM8IpDH3HHOK4gU7yIms4w6gF8cp
iEmympi37BTuxNjBy1BcX6BP4G+U3gWzQ2of2wdh3NKyvYIBbvnCUT5sRqQ35vvj+Y83+KLZ
yyOLlO3tt/uzuy/xDk8Qd8ZTWr1iTNjsHc81A5F2Td9dr2Y7yGS7fj+/9+vMsSm6GLhkoxnT
4VPJtYtIbUipcEnksZerZU6wqWGL95B0ynpEyZQ1g+axXL1bSf1aEF/vVoAb9ur4CVQQUERy
s3FX9vJqcWgl6AVfXlAZcNnrEpImgH3ywEHutB6vzA9oGOwmXe/j59yxM45w+O38+PANg02g
n19fnk8/TvDH6fnu7du3vzuvQ2C6G9W7QaJe8oHcfImDmP02Y1AdiQQ87jKaYn2nb3SkeFgY
I34fiSoZ/XhkyGBBxdgrMtCC6WmPVk55YDB1NhBgWJbrfVQwgCbqqrBTcVYC/65UC0q+7jW6
YCzQY9wO1xn0T3WmRkWtgvW92EtcDzptHAWYJ+NoGLA7MalvCMXbjLVMV1oI2qzwKnIYns25
naMqO8fxPplYv0BvU5Vdi6+tA+8rKrWJVjcuJ25PHy1lZBdQ5GhjwSjH6FHySMVTvWNBmdJC
GQl+DrpdG6t9fvwPa1tfbp9v36CadYc+Wy+TaFyq8oJusSfXcdQxm3ACEJBSKsuUskHyH7RT
1Sl0nOJbQFFqrMepEuMIW81amMqmA7PBRpwFqF1SFGWqQdWGnnYWyoMvFpsSYJjgvHwnzCgi
oVJEduUsB95d+dUQsSS+1p+ivGvqLUWLDxuiTdC8SpO7dO6PPpw3kBJsMLZkKkqpAvRWEtTt
yFmiv9l+vQyFfu23Mk7+uVHITIpgi3AFvNlqUiJhetHNHqDg9bo0mYhJNrINMLLxQ65lAXJ3
8MWjIWibW818po6nLEC6ReEOQR8wWwDxPX0ffgHL6gZ7LNENEA7cqWq0NO3RNeJH8YjuKnFY
UXvT4UHY0Igo5MgGI0aNAskxrjpe4Zl6xOWV+EhiiefvQT4XZXDvOCvJyTp5icaJgk252VRO
zXhzO2jy0XzM+NFYWDOPm5sRtsdKden+GNuA2afjFUCba/kyXIGJfG1ElrZRe7s1Mb1OgMmz
E9DOGiQJXiXPUxqlSUzlqgEerfCIkT9IHLLP6LDDJMSp0fHeLXxcbVzjxZUAdaw17xRRpxmp
gxGiCUrsfR+KGfHpTY47wHOS2c9Nt40axJtkp2ffwvUYNzpf8+CObtmfst97YezOnr+MOTWo
KnKn4/xLTkFG41Hjr771fR0JhNEYfvdRYkZCbctuHwm2UyAA90kJ59TmosrMb76bh3hPrqtO
WXGZkMMF9XjLFcdUWIVXu8eKwPnx9ukuMGo8aZhnRdWLYXwzbc1yNazM9dB3p/MzKpVoWGXf
/zs93d47DyVSXrznOqREeepCIodrSaUX+sZAfUOjjpQThpKYRC1clPCssaHj3rTefSYThyuI
PNLYzlGM7igOK4G1kJR/d0ranWGB85jDxPQds6eFBSGxBcOibc5hm4uNscsTt4JRBAnFR1iQ
jGmUumzQzSXZOQS3nlylorw8+NHK68kCICMmuXXWGF8dK5Z0omcqgzf0J80kOhtAljHXIYX4
kN324b1wekYd3+qbvK9dRtnRbvWyMb3BM5wP72SqnfBstpeidTiQB+CduYmq5yiS5MxnqimC
Ecxnb25h35d5VDcf06bqxutICr7wxC1uMYygo4OLYOa88AIqAsbm0XqJN0uWCTHhfliUbQ0G
oidE4UPYSVXOO1kiHm1Njzq8dOEGKhldJYI4hkgEOLE2oVVd53Tbj/QdehJCjj8Gu4j4vELA
+t0jcd55us5AcQpXkxTDsinDOgBdKKUcT3S8e67NSyzacT2glV6X1iKN5ybr61CF8VHVumRW
J+eBBie3/wPSLPGYKCMCAA==

--mP3DRpeJDSE+ciuQ--
