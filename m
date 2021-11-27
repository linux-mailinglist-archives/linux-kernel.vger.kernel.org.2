Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C323F460190
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Nov 2021 22:01:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356289AbhK0VEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Nov 2021 16:04:23 -0500
Received: from mga14.intel.com ([192.55.52.115]:33953 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229634AbhK0VCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Nov 2021 16:02:22 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="236024796"
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="236024796"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2021 12:59:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,269,1631602800"; 
   d="scan'208";a="608245982"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 27 Nov 2021 12:59:06 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mr4mn-0009zV-T0; Sat, 27 Nov 2021 20:59:05 +0000
Date:   Sun, 28 Nov 2021 04:58:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [rostedt-trace:for-next 2/3] kernel/trace/trace_events.c:2681:25:
 warning: variable 'no_pid_list' set but not used
Message-ID: <202111280401.qC0z99JB-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git for-next
head:   a55f224ff5f238013de8762c4287117e47b86e22
commit: 6cb206508b621a9a0a2c35b60540e399225c8243 [2/3] tracing: Check pid filtering when creating events
config: hexagon-randconfig-r045-20211128 (https://download.01.org/0day-ci/archive/20211128/202111280401.qC0z99JB-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5162b558d8c0b542e752b037e72a69d5fd51eb1e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git/commit/?id=6cb206508b621a9a0a2c35b60540e399225c8243
        git remote add rostedt-trace https://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
        git fetch --no-tags rostedt-trace for-next
        git checkout 6cb206508b621a9a0a2c35b60540e399225c8243
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/trace/trace_events.c:2681:25: warning: variable 'no_pid_list' set but not used [-Wunused-but-set-variable]
           struct trace_pid_list *no_pid_list;
                                  ^
   1 warning generated.


vim +/no_pid_list +2681 kernel/trace/trace_events.c

  2676	
  2677	static struct trace_event_file *
  2678	trace_create_new_event(struct trace_event_call *call,
  2679			       struct trace_array *tr)
  2680	{
> 2681		struct trace_pid_list *no_pid_list;
  2682		struct trace_pid_list *pid_list;
  2683		struct trace_event_file *file;
  2684		unsigned int first;
  2685	
  2686		file = kmem_cache_alloc(file_cachep, GFP_TRACE);
  2687		if (!file)
  2688			return NULL;
  2689	
  2690		pid_list = rcu_dereference_protected(tr->filtered_pids,
  2691						     lockdep_is_held(&event_mutex));
  2692		no_pid_list = rcu_dereference_protected(tr->filtered_no_pids,
  2693						     lockdep_is_held(&event_mutex));
  2694	
  2695		if (!trace_pid_list_first(pid_list, &first) ||
  2696		    !trace_pid_list_first(pid_list, &first))
  2697			file->flags |= EVENT_FILE_FL_PID_FILTER;
  2698	
  2699		file->event_call = call;
  2700		file->tr = tr;
  2701		atomic_set(&file->sm_ref, 0);
  2702		atomic_set(&file->tm_ref, 0);
  2703		INIT_LIST_HEAD(&file->triggers);
  2704		list_add(&file->list, &tr->events);
  2705	
  2706		return file;
  2707	}
  2708	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
