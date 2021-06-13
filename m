Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279CA3A5A72
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Jun 2021 22:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbhFMUwl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 16:52:41 -0400
Received: from mga14.intel.com ([192.55.52.115]:33285 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231840AbhFMUwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 16:52:39 -0400
IronPort-SDR: L1QaqOa3bnJYIBXKb8sX9/4NNLO3obmWDDySDOLfrCkemED4jYJm6gx64BTut7HwzMDB/Bk/m/
 jEXpxSPjPzIA==
X-IronPort-AV: E=McAfee;i="6200,9189,10014"; a="205556706"
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="gz'50?scan'50,208,50";a="205556706"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2021 13:50:37 -0700
IronPort-SDR: S57OlCFub/VpMybywiVWcCtSE1zXus2eL485pbQw7MQSVBffG0NBIyBpVR+nB0Qr98UhMXfwW/
 U5UNTXZM0HLA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,271,1616482800"; 
   d="gz'50?scan'50,208,50";a="403715905"
Received: from lkp-server02.sh.intel.com (HELO 3cb98b298c7e) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 13 Jun 2021 13:50:36 -0700
Received: from kbuild by 3cb98b298c7e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lsX41-0001VP-5u; Sun, 13 Jun 2021 20:50:37 +0000
Date:   Mon, 14 Jun 2021 04:49:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: [tip:tmp.tmp2 176/364] include/linux/coredump.h:37:45: warning:
 'struct kernel_siginfo' declared inside parameter list will not be visible
 outside of this definition or declaration
Message-ID: <202106140441.qO5PdKhx-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tmp.tmp2
head:   adcceb5eb7aee38e4a9c15bdf599655f0e1b1324
commit: be65473fb5b77d57d8955beffd5aa370cfdae467 [176/364] sched/headers, rcu: Remove <linux/sched/signal.h> dependency from <linux/rcuwait.h>
config: i386-tinyconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git/commit/?id=be65473fb5b77d57d8955beffd5aa370cfdae467
        git remote add tip https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git
        git fetch --no-tags tip tmp.tmp2
        git checkout be65473fb5b77d57d8955beffd5aa370cfdae467
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/x86/events/intel/bts.c:16:
>> include/linux/coredump.h:37:45: warning: 'struct kernel_siginfo' declared inside parameter list will not be visible outside of this definition or declaration
      37 | static inline void do_coredump(const struct kernel_siginfo *siginfo) {}
         |                                             ^~~~~~~~~~~~~~


vim +37 include/linux/coredump.h

    19	
    20	/*
    21	 * These are the only things you should do on a core-file: use only these
    22	 * functions to write out all the necessary info.
    23	 */
    24	struct coredump_params;
    25	struct kernel_siginfo;
    26	extern void dump_skip_to(struct coredump_params *cprm, unsigned long to);
    27	extern void dump_skip(struct coredump_params *cprm, size_t nr);
    28	extern int dump_emit(struct coredump_params *cprm, const void *addr, int nr);
    29	extern int dump_align(struct coredump_params *cprm, int align);
    30	int dump_user_range(struct coredump_params *cprm, unsigned long start,
    31			    unsigned long len);
    32	int dump_vma_snapshot(struct coredump_params *cprm, int *vma_count,
    33			      struct core_vma_metadata **vma_meta,
    34			      size_t *vma_data_size_ptr);
    35	extern void do_coredump(const struct kernel_siginfo *siginfo);
    36	#else
  > 37	static inline void do_coredump(const struct kernel_siginfo *siginfo) {}
    38	#endif
    39	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--SUOF0GtieIMvvwua
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
oIMN0tvk1xtz/wEJCbIQQ2sAAA==

--SUOF0GtieIMvvwua--
