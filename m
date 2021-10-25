Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8CC439BB9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 18:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbhJYQki (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 12:40:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:46244 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233932AbhJYQkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 12:40:37 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="216609305"
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="gz'50?scan'50,208,50";a="216609305"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 09:38:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="gz'50?scan'50,208,50";a="596548497"
Received: from lkp-server01.sh.intel.com (HELO 0352ec6b4cf1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 25 Oct 2021 09:38:10 -0700
Received: from kbuild by 0352ec6b4cf1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mf2zC-00002g-60; Mon, 25 Oct 2021 16:38:10 +0000
Date:   Tue, 26 Oct 2021 00:37:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bharat Bhushan <bbhushan2@marvell.com>, will@kernel.org,
        mark.rutland@arm.com, robh+dt@kernel.org, bbudiredla@marvell.com,
        sgoutham@marvell.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Bharat Bhushan <bbhushan2@marvell.com>
Subject: Re: [PATCH v5 2/4] perf/marvell: CN10k DDR performance monitor
 support
Message-ID: <202110260025.iRmRCwpb-lkp@intel.com>
References: <20211018042015.25151-3-bbhushan2@marvell.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
In-Reply-To: <20211018042015.25151-3-bbhushan2@marvell.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Bharat,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on linus/master v5.15-rc6 next-20211025]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Bharat-Bhushan/cn10k-DDR-Performance-monitor-support/20211018-122220
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: hexagon-randconfig-r045-20211025 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project a461fa64bb37cffd73f683c74f6b0780379fc2ca)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c165c120469cac5c73b7a7e9d027c284eb09c6d1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Bharat-Bhushan/cn10k-DDR-Performance-monitor-support/20211018-122220
        git checkout c165c120469cac5c73b7a7e9d027c284eb09c6d1
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=hexagon 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/perf/marvell_cn10k_ddr_pmu.c:352:9: error: implicit declaration of function 'readq_relaxed' [-Werror,-Wimplicit-function-declaration]
                   val = readq_relaxed(pmu->base + reg);
                         ^
>> drivers/perf/marvell_cn10k_ddr_pmu.c:359:3: error: implicit declaration of function 'writeq_relaxed' [-Werror,-Wimplicit-function-declaration]
                   writeq_relaxed(val, pmu->base + reg);
                   ^
   drivers/perf/marvell_cn10k_ddr_pmu.c:359:3: note: did you mean 'readq_relaxed'?
   drivers/perf/marvell_cn10k_ddr_pmu.c:352:9: note: 'readq_relaxed' declared here
                   val = readq_relaxed(pmu->base + reg);
                         ^
   drivers/perf/marvell_cn10k_ddr_pmu.c:361:9: error: implicit declaration of function 'readq_relaxed' [-Werror,-Wimplicit-function-declaration]
                   val = readq_relaxed(pmu->base + DDRC_PERF_CNT_FREERUN_EN);
                         ^
   drivers/perf/marvell_cn10k_ddr_pmu.c:373:3: error: implicit declaration of function 'writeq_relaxed' [-Werror,-Wimplicit-function-declaration]
                   writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_EN);
                   ^
   drivers/perf/marvell_cn10k_ddr_pmu.c:382:10: error: implicit declaration of function 'readq_relaxed' [-Werror,-Wimplicit-function-declaration]
                   return readq_relaxed(pmu->base + DDRC_PERF_CNT_VALUE_RD_OP);
                          ^
   drivers/perf/marvell_cn10k_ddr_pmu.c:443:3: error: implicit declaration of function 'writeq_relaxed' [-Werror,-Wimplicit-function-declaration]
                   writeq_relaxed(val, pmu->base + reg_offset);
                   ^
   drivers/perf/marvell_cn10k_ddr_pmu.c:451:3: error: implicit declaration of function 'writeq_relaxed' [-Werror,-Wimplicit-function-declaration]
                   writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_CTRL);
                   ^
   drivers/perf/marvell_cn10k_ddr_pmu.c:493:2: error: implicit declaration of function 'writeq_relaxed' [-Werror,-Wimplicit-function-declaration]
           writeq_relaxed(START_OP_CTRL_VAL_START, ddr_pmu->base +
           ^
   drivers/perf/marvell_cn10k_ddr_pmu.c:501:2: error: implicit declaration of function 'writeq_relaxed' [-Werror,-Wimplicit-function-declaration]
           writeq_relaxed(END_OP_CTRL_VAL_END, ddr_pmu->base +
           ^
   drivers/perf/marvell_cn10k_ddr_pmu.c:527:2: error: implicit declaration of function 'writeq_relaxed' [-Werror,-Wimplicit-function-declaration]
           writeq_relaxed(OP_MODE_CTRL_VAL_MANNUAL, ddr_pmu->base +
           ^
   drivers/perf/marvell_cn10k_ddr_pmu.c:549:10: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
                                 res->start);
                                 ^~~~~~~~~~
   drivers/perf/marvell_cn10k_ddr_pmu.c:557:50: warning: format specifies type 'unsigned long long' but the argument has type 'resource_size_t' (aka 'unsigned int') [-Wformat]
           pr_info("CN10K DDR PMU Driver for ddrc@%llx\n", res->start);
                                                  ~~~~     ^~~~~~~~~~
                                                  %x
   include/linux/printk.h:519:34: note: expanded from macro 'pr_info'
           printk(KERN_INFO pr_fmt(fmt), ##__VA_ARGS__)
                                   ~~~     ^~~~~~~~~~~
   include/linux/printk.h:446:60: note: expanded from macro 'printk'
   #define printk(fmt, ...) printk_index_wrap(_printk, fmt, ##__VA_ARGS__)
                                                       ~~~    ^~~~~~~~~~~
   include/linux/printk.h:418:19: note: expanded from macro 'printk_index_wrap'
                   _p_func(_fmt, ##__VA_ARGS__);                           \
                           ~~~~    ^~~~~~~~~~~
   2 warnings and 10 errors generated.


vim +/readq_relaxed +352 drivers/perf/marvell_cn10k_ddr_pmu.c

   338	
   339	static void cn10k_ddr_perf_counter_enable(struct cn10k_ddr_pmu *pmu,
   340						  int counter, bool enable)
   341	{
   342		u32 reg;
   343		u64 val;
   344	
   345		if (counter > DDRC_PERF_NUM_COUNTERS) {
   346			pr_err("Error: unsupported counter %d\n", counter);
   347			return;
   348		}
   349	
   350		if (counter < DDRC_PERF_NUM_GEN_COUNTERS) {
   351			reg = DDRC_PERF_CFG(counter);
 > 352			val = readq_relaxed(pmu->base + reg);
   353	
   354			if (enable)
   355				val |= EVENT_ENABLE;
   356			else
   357				val &= ~EVENT_ENABLE;
   358	
 > 359			writeq_relaxed(val, pmu->base + reg);
   360		} else {
   361			val = readq_relaxed(pmu->base + DDRC_PERF_CNT_FREERUN_EN);
   362			if (enable) {
   363				if (counter == DDRC_PERF_READ_COUNTER_IDX)
   364					val |= DDRC_PERF_FREERUN_READ_EN;
   365				else
   366					val |= DDRC_PERF_FREERUN_WRITE_EN;
   367			} else {
   368				if (counter == DDRC_PERF_READ_COUNTER_IDX)
   369					val &= ~DDRC_PERF_FREERUN_READ_EN;
   370				else
   371					val &= ~DDRC_PERF_FREERUN_WRITE_EN;
   372			}
   373			writeq_relaxed(val, pmu->base + DDRC_PERF_CNT_FREERUN_EN);
   374		}
   375	}
   376	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--lrZ03NoBR/3+SXJZ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
EO0Z8/8Lbq1/8rexAQA=

--lrZ03NoBR/3+SXJZ--
