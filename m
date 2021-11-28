Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EE4460721
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 16:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358105AbhK1Ph4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 10:37:56 -0500
Received: from mga14.intel.com ([192.55.52.115]:48382 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1358062AbhK1Pfz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 10:35:55 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10181"; a="236076017"
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="236076017"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2021 07:32:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,271,1631602800"; 
   d="scan'208";a="458810480"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 28 Nov 2021 07:32:30 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mrMAH-000Aoi-M7; Sun, 28 Nov 2021 15:32:29 +0000
Date:   Sun, 28 Nov 2021 23:31:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [norov:bitmap-fast6 3/9]
 arch/x86/kernel/cpu/resctrl/rdtgroup.c:2755:74: error: expected ')'
Message-ID: <202111282332.BXPDHKvC-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/norov/linux bitmap-fast6
head:   a24f3834dc8fc58441c4219de9be07bce33b56fb
commit: 939b5bb6cfd3fda4335d63b83cd80475ea81be60 [3/9] all: replace bitmap_weigth() with bitmap_{empty,full,eq,gt,le}
config: i386-randconfig-a001-20211128 (https://download.01.org/0day-ci/archive/20211128/202111282332.BXPDHKvC-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 5c64d8ef8cc0c0ed3e0f2ae693d99e7f70f20a84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/norov/linux/commit/939b5bb6cfd3fda4335d63b83cd80475ea81be60
        git remote add norov https://github.com/norov/linux
        git fetch --no-tags norov bitmap-fast6
        git checkout 939b5bb6cfd3fda4335d63b83cd80475ea81be60
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/x86/kernel/cpu/resctrl/rdtgroup.c:2755:74: error: expected ')'
           if (bitmap_weight_le(&tmp_cbm, r->cache.cbm_len, r->cache.min_cbm_bits) {
                                                                                   ^
   arch/x86/kernel/cpu/resctrl/rdtgroup.c:2755:5: note: to match this '('
           if (bitmap_weight_le(&tmp_cbm, r->cache.cbm_len, r->cache.min_cbm_bits) {
              ^
   1 error generated.


vim +2755 arch/x86/kernel/cpu/resctrl/rdtgroup.c

  2689	
  2690	/*
  2691	 * Initialize cache resources per RDT domain
  2692	 *
  2693	 * Set the RDT domain up to start off with all usable allocations. That is,
  2694	 * all shareable and unused bits. All-zero CBM is invalid.
  2695	 */
  2696	static int __init_one_rdt_domain(struct rdt_domain *d, struct resctrl_schema *s,
  2697					 u32 closid)
  2698	{
  2699		enum resctrl_conf_type peer_type = resctrl_peer_type(s->conf_type);
  2700		enum resctrl_conf_type t = s->conf_type;
  2701		struct resctrl_staged_config *cfg;
  2702		struct rdt_resource *r = s->res;
  2703		u32 used_b = 0, unused_b = 0;
  2704		unsigned long tmp_cbm;
  2705		enum rdtgrp_mode mode;
  2706		u32 peer_ctl, ctrl_val;
  2707		int i;
  2708	
  2709		cfg = &d->staged_config[t];
  2710		cfg->have_new_ctrl = false;
  2711		cfg->new_ctrl = r->cache.shareable_bits;
  2712		used_b = r->cache.shareable_bits;
  2713		for (i = 0; i < closids_supported(); i++) {
  2714			if (closid_allocated(i) && i != closid) {
  2715				mode = rdtgroup_mode_by_closid(i);
  2716				if (mode == RDT_MODE_PSEUDO_LOCKSETUP)
  2717					/*
  2718					 * ctrl values for locksetup aren't relevant
  2719					 * until the schemata is written, and the mode
  2720					 * becomes RDT_MODE_PSEUDO_LOCKED.
  2721					 */
  2722					continue;
  2723				/*
  2724				 * If CDP is active include peer domain's
  2725				 * usage to ensure there is no overlap
  2726				 * with an exclusive group.
  2727				 */
  2728				if (resctrl_arch_get_cdp_enabled(r->rid))
  2729					peer_ctl = resctrl_arch_get_config(r, d, i,
  2730									   peer_type);
  2731				else
  2732					peer_ctl = 0;
  2733				ctrl_val = resctrl_arch_get_config(r, d, i,
  2734								   s->conf_type);
  2735				used_b |= ctrl_val | peer_ctl;
  2736				if (mode == RDT_MODE_SHAREABLE)
  2737					cfg->new_ctrl |= ctrl_val | peer_ctl;
  2738			}
  2739		}
  2740		if (d->plr && d->plr->cbm > 0)
  2741			used_b |= d->plr->cbm;
  2742		unused_b = used_b ^ (BIT_MASK(r->cache.cbm_len) - 1);
  2743		unused_b &= BIT_MASK(r->cache.cbm_len) - 1;
  2744		cfg->new_ctrl |= unused_b;
  2745		/*
  2746		 * Force the initial CBM to be valid, user can
  2747		 * modify the CBM based on system availability.
  2748		 */
  2749		cfg->new_ctrl = cbm_ensure_valid(cfg->new_ctrl, r);
  2750		/*
  2751		 * Assign the u32 CBM to an unsigned long to ensure that
  2752		 * bitmap_weight_le() does not access out-of-bound memory.
  2753		 */
  2754		tmp_cbm = cfg->new_ctrl;
> 2755		if (bitmap_weight_le(&tmp_cbm, r->cache.cbm_len, r->cache.min_cbm_bits) {
  2756			rdt_last_cmd_printf("No space on %s:%d\n", s->name, d->id);
  2757			return -ENOSPC;
  2758		}
  2759		cfg->have_new_ctrl = true;
  2760	
  2761		return 0;
  2762	}
  2763	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
