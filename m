Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3792B3385EA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 07:33:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhCLGdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 01:33:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:8357 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231640AbhCLGcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 01:32:52 -0500
IronPort-SDR: gL6wrPiIZ9nCfEGTka0U/RhqsRlIMT0K02mbfrT6nmvJ2+8klalaPVeTZ7wJRKAjMO3QDFBs3L
 xGtn1zvOFipA==
X-IronPort-AV: E=McAfee;i="6000,8403,9920"; a="250155898"
X-IronPort-AV: E=Sophos;i="5.81,242,1610438400"; 
   d="gz'50?scan'50,208,50";a="250155898"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2021 22:32:51 -0800
IronPort-SDR: f+UdHj6wTHwbSQyJctHQX7YjOzNFv5t8z+YDjBYmyrfq1Ea5leaI3v73VMtJdFMSfDlfoKUGda
 bBpSrJD3dZWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.81,242,1610438400"; 
   d="gz'50?scan'50,208,50";a="510243807"
Received: from lkp-server02.sh.intel.com (HELO ce64c092ff93) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 11 Mar 2021 22:32:49 -0800
Received: from kbuild by ce64c092ff93 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1lKbLs-0001CQ-Cb; Fri, 12 Mar 2021 06:32:48 +0000
Date:   Fri, 12 Mar 2021 14:32:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     qiang.zhang@windriver.com, linux@armlinux.org.uk
Cc:     kbuild-all@lists.01.org, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] ARM: Fix incorrect use of smp_processor_id() by syzbot
 report
Message-ID: <202103121444.xPO5E9gh-lkp@intel.com>
References: <20210312041246.15113-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline
In-Reply-To: <20210312041246.15113-1-qiang.zhang@windriver.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linux/master]
[also build test WARNING on linus/master hnaz-linux-mm/master v5.12-rc2 next-20210311]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/qiang-zhang-windriver-com/ARM-Fix-incorrect-use-of-smp_processor_id-by-syzbot-report/20210312-121529
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git a74e6a014c9d4d4161061f770c9b4f98372ac778
config: arm-pxa168_defconfig (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b31b47976c6f81426cc00c99cc1452a60e89d972
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review qiang-zhang-windriver-com/ARM-Fix-incorrect-use-of-smp_processor_id-by-syzbot-report/20210312-121529
        git checkout b31b47976c6f81426cc00c99cc1452a60e89d972
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from arch/arm/mm/fault.c:21:
   arch/arm/include/asm/system_misc.h: In function 'harden_branch_predictor':
>> arch/arm/include/asm/system_misc.h:25:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      25 |  harden_branch_predictor_fn_t fn = per_cpu(harden_branch_predictor_fn,
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mm/fault.c: At top level:
   arch/arm/mm/fault.c:518:1: warning: no previous prototype for 'do_DataAbort' [-Wmissing-prototypes]
     518 | do_DataAbort(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
         | ^~~~~~~~~~~~
   arch/arm/mm/fault.c:548:1: warning: no previous prototype for 'do_PrefetchAbort' [-Wmissing-prototypes]
     548 | do_PrefetchAbort(unsigned long addr, unsigned int ifsr, struct pt_regs *regs)
         | ^~~~~~~~~~~~~~~~
--
   In file included from arch/arm/mm/proc-v7-bugs.c:9:
   arch/arm/include/asm/system_misc.h: In function 'harden_branch_predictor':
>> arch/arm/include/asm/system_misc.h:25:2: warning: ISO C90 forbids mixed declarations and code [-Wdeclaration-after-statement]
      25 |  harden_branch_predictor_fn_t fn = per_cpu(harden_branch_predictor_fn,
         |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm/mm/proc-v7-bugs.c: At top level:
   arch/arm/mm/proc-v7-bugs.c:142:6: warning: no previous prototype for 'cpu_v7_ca8_ibe' [-Wmissing-prototypes]
     142 | void cpu_v7_ca8_ibe(void)
         |      ^~~~~~~~~~~~~~
   arch/arm/mm/proc-v7-bugs.c:148:6: warning: no previous prototype for 'cpu_v7_ca15_ibe' [-Wmissing-prototypes]
     148 | void cpu_v7_ca15_ibe(void)
         |      ^~~~~~~~~~~~~~~
   arch/arm/mm/proc-v7-bugs.c:154:6: warning: no previous prototype for 'cpu_v7_bugs_init' [-Wmissing-prototypes]
     154 | void cpu_v7_bugs_init(void)
         |      ^~~~~~~~~~~~~~~~


vim +25 arch/arm/include/asm/system_misc.h

9f97da78bf0182 David Howells 2012-03-28  18  
f5fe12b1eaee22 Russell King  2018-05-14  19  #ifdef CONFIG_HARDEN_BRANCH_PREDICTOR
f5fe12b1eaee22 Russell King  2018-05-14  20  typedef void (*harden_branch_predictor_fn_t)(void);
f5fe12b1eaee22 Russell King  2018-05-14  21  DECLARE_PER_CPU(harden_branch_predictor_fn_t, harden_branch_predictor_fn);
f5fe12b1eaee22 Russell King  2018-05-14  22  static inline void harden_branch_predictor(void)
f5fe12b1eaee22 Russell King  2018-05-14  23  {
b31b47976c6f81 Zqiang        2021-03-12  24  	preempt_disable();
f5fe12b1eaee22 Russell King  2018-05-14 @25  	harden_branch_predictor_fn_t fn = per_cpu(harden_branch_predictor_fn,
f5fe12b1eaee22 Russell King  2018-05-14  26  						  smp_processor_id());
b31b47976c6f81 Zqiang        2021-03-12  27  	preempt_enable();
f5fe12b1eaee22 Russell King  2018-05-14  28  	if (fn)
f5fe12b1eaee22 Russell King  2018-05-14  29  		fn();
f5fe12b1eaee22 Russell King  2018-05-14  30  }
f5fe12b1eaee22 Russell King  2018-05-14  31  #else
f5fe12b1eaee22 Russell King  2018-05-14  32  #define harden_branch_predictor() do { } while (0)
f5fe12b1eaee22 Russell King  2018-05-14  33  #endif
f5fe12b1eaee22 Russell King  2018-05-14  34  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--IJpNTDwzlM2Ie8A6
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--IJpNTDwzlM2Ie8A6--
