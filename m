Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ED03424EFC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 10:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240564AbhJGISc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 04:18:32 -0400
Received: from mga06.intel.com ([134.134.136.31]:39870 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233489AbhJGISa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 04:18:30 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10129"; a="287078258"
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="gz'50?scan'50,208,50";a="287078258"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2021 01:16:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,354,1624345200"; 
   d="gz'50?scan'50,208,50";a="478469698"
Received: from lkp-server01.sh.intel.com (HELO 72c3bd3cf19c) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Oct 2021 01:16:35 -0700
Received: from kbuild by 72c3bd3cf19c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mYOZu-0007Co-Qn; Thu, 07 Oct 2021 08:16:34 +0000
Date:   Thu, 7 Oct 2021 16:15:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [peterz-queue:sched/wchan 7/7] arch/nds32/kernel/stacktrace.c:13:13:
 error: 'savesched' redeclared as different kind of symbol
Message-ID: <202110071625.7H4ETQGm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git sched/wchan
head:   48f17ab32afc56a67359efc5b8889cb8cb42ec80
commit: 48f17ab32afc56a67359efc5b8889cb8cb42ec80 [7/7] arch: Fix STACKTRACE_SUPPORT
config: nds32-defconfig (attached as .config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=48f17ab32afc56a67359efc5b8889cb8cb42ec80
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue sched/wchan
        git checkout 48f17ab32afc56a67359efc5b8889cb8cb42ec80
        # save the attached .config to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/nds32/kernel/stacktrace.c: In function '__save_stack_trace_tsk':
>> arch/nds32/kernel/stacktrace.c:13:13: error: 'savesched' redeclared as different kind of symbol
      13 |         int savesched;
         |             ^~~~~~~~~
   arch/nds32/kernel/stacktrace.c:9:93: note: previous definition of 'savesched' with type 'bool' {aka '_Bool'}
       9 | static void __save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace, bool savesched)
         |                                                                                        ~~~~~^~~~~~~~~


vim +/savesched +13 arch/nds32/kernel/stacktrace.c

2923f5ea7738cb9 Greentime Hu   2017-10-24   8  
48f17ab32afc56a Peter Zijlstra 2021-09-30   9  static void __save_stack_trace_tsk(struct task_struct *tsk, struct stack_trace *trace, bool savesched)
2923f5ea7738cb9 Greentime Hu   2017-10-24  10  {
2923f5ea7738cb9 Greentime Hu   2017-10-24  11  	unsigned long *fpn;
2923f5ea7738cb9 Greentime Hu   2017-10-24  12  	int skip = trace->skip;
2923f5ea7738cb9 Greentime Hu   2017-10-24 @13  	int savesched;
1e377ae9b04aef4 Zong Li        2018-08-15  14  	int graph_idx = 0;
2923f5ea7738cb9 Greentime Hu   2017-10-24  15  
2923f5ea7738cb9 Greentime Hu   2017-10-24  16  	if (tsk == current) {
2923f5ea7738cb9 Greentime Hu   2017-10-24  17  		__asm__ __volatile__("\tori\t%0, $fp, #0\n":"=r"(fpn));
2923f5ea7738cb9 Greentime Hu   2017-10-24  18  	} else {
2923f5ea7738cb9 Greentime Hu   2017-10-24  19  		fpn = (unsigned long *)thread_saved_fp(tsk);
2923f5ea7738cb9 Greentime Hu   2017-10-24  20  	}
2923f5ea7738cb9 Greentime Hu   2017-10-24  21  
2923f5ea7738cb9 Greentime Hu   2017-10-24  22  	while (!kstack_end(fpn) && !((unsigned long)fpn & 0x3)
2923f5ea7738cb9 Greentime Hu   2017-10-24  23  	       && (fpn >= (unsigned long *)TASK_SIZE)) {
2923f5ea7738cb9 Greentime Hu   2017-10-24  24  		unsigned long lpp, fpp;
2923f5ea7738cb9 Greentime Hu   2017-10-24  25  
95f93ed7fe92c16 Zong Li        2018-08-20  26  		lpp = fpn[LP_OFFSET];
2923f5ea7738cb9 Greentime Hu   2017-10-24  27  		fpp = fpn[FP_OFFSET];
2923f5ea7738cb9 Greentime Hu   2017-10-24  28  		if (!__kernel_text_address(lpp))
2923f5ea7738cb9 Greentime Hu   2017-10-24  29  			break;
1e377ae9b04aef4 Zong Li        2018-08-15  30  		else
1e377ae9b04aef4 Zong Li        2018-08-15  31  			lpp = ftrace_graph_ret_addr(tsk, &graph_idx, lpp, NULL);
2923f5ea7738cb9 Greentime Hu   2017-10-24  32  
2923f5ea7738cb9 Greentime Hu   2017-10-24  33  		if (savesched || !in_sched_functions(lpp)) {
2923f5ea7738cb9 Greentime Hu   2017-10-24  34  			if (skip) {
2923f5ea7738cb9 Greentime Hu   2017-10-24  35  				skip--;
2923f5ea7738cb9 Greentime Hu   2017-10-24  36  			} else {
2923f5ea7738cb9 Greentime Hu   2017-10-24  37  				trace->entries[trace->nr_entries++] = lpp;
2923f5ea7738cb9 Greentime Hu   2017-10-24  38  				if (trace->nr_entries >= trace->max_entries)
2923f5ea7738cb9 Greentime Hu   2017-10-24  39  					break;
2923f5ea7738cb9 Greentime Hu   2017-10-24  40  			}
2923f5ea7738cb9 Greentime Hu   2017-10-24  41  		}
2923f5ea7738cb9 Greentime Hu   2017-10-24  42  		fpn = (unsigned long *)fpp;
2923f5ea7738cb9 Greentime Hu   2017-10-24  43  	}
2923f5ea7738cb9 Greentime Hu   2017-10-24  44  }
48f17ab32afc56a Peter Zijlstra 2021-09-30  45  void save_stack_trace(struct stack_trace *trace)
48f17ab32afc56a Peter Zijlstra 2021-09-30  46  {
48f17ab32afc56a Peter Zijlstra 2021-09-30  47  	__save_stack_trace_tsk(current, trace, true);
48f17ab32afc56a Peter Zijlstra 2021-09-30  48  }
48f17ab32afc56a Peter Zijlstra 2021-09-30  49  EXPORT_SYMBOL_GPL(save_stack_trace);
48f17ab32afc56a Peter Zijlstra 2021-09-30  50  

:::::: The code at line 13 was first introduced by commit
:::::: 2923f5ea7738cb9f5372bb9d7ac9886cf4193003 nds32: Exception handling

:::::: TO: Greentime Hu <greentime@andestech.com>
:::::: CC: Greentime Hu <greentime@andestech.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--fdj2RfSjLxBAspz7
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
rpZQ+KsAAA==

--fdj2RfSjLxBAspz7--
