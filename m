Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5AD410DCB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbhISXXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:23:05 -0400
Received: from mga01.intel.com ([192.55.52.88]:20983 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229517AbhISXXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:23:04 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10112"; a="245450795"
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; 
   d="gz'50?scan'50,208,50";a="245450795"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2021 16:21:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,305,1624345200"; 
   d="gz'50?scan'50,208,50";a="702056315"
Received: from lkp-server01.sh.intel.com (HELO 285e7b116627) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 19 Sep 2021 16:21:36 -0700
Received: from kbuild by 285e7b116627 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mS67r-0005gj-UM; Sun, 19 Sep 2021 23:21:35 +0000
Date:   Mon, 20 Sep 2021 07:20:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [tglx-devel:hrtimer 8/12] kernel/time/hrtimer.c:1232:53: warning: |
 has lower precedence than ==; == will be evaluated first
Message-ID: <202109200732.IJRqFku3-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="LQksG6bCIzRHxTLp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--LQksG6bCIzRHxTLp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git hrtimer
head:   16c372aeaca31d5d9d998466e75e845a2926685f
commit: 6161421a8190f07b3c0a52c0b62c8b3f51de6ddf [8/12] hrtimer: Avoid reprogramming when callback is running
config: hexagon-randconfig-r023-20210919 (attached as .config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c8b3d7d6d6de37af68b2f379d0e37304f78e115f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/commit/?id=6161421a8190f07b3c0a52c0b62c8b3f51de6ddf
        git remote add tglx-devel https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git
        git fetch --no-tags tglx-devel hrtimer
        git checkout 6161421a8190f07b3c0a52c0b62c8b3f51de6ddf
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 ARCH=hexagon 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/time/hrtimer.c:120:21: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [CLOCK_REALTIME]        = HRTIMER_BASE_REALTIME,
                                     ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
           [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,
                                     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:22: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [CLOCK_MONOTONIC]       = HRTIMER_BASE_MONOTONIC,
                                     ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
           [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,
                                     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:21: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [CLOCK_BOOTTIME]        = HRTIMER_BASE_BOOTTIME,
                                     ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
           [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,
                                     ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:17: warning: initializer overrides prior initialization of this subobject [-Winitializer-overrides]
           [CLOCK_TAI]             = HRTIMER_BASE_TAI,
                                     ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:118:27: note: previous initialization is here
           [0 ... MAX_CLOCKS - 1]  = HRTIMER_MAX_CLOCK_BASES,
                                     ^~~~~~~~~~~~~~~~~~~~~~~
>> kernel/time/hrtimer.c:1232:53: warning: | has lower precedence than ==; == will be evaluated first [-Wparentheses]
           force_local &= base->cpu_base->next_timer == timer | in_callback;
                          ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^
   kernel/time/hrtimer.c:1232:53: note: place parentheses around the '==' expression to silence this warning
           force_local &= base->cpu_base->next_timer == timer | in_callback;
                                                              ^
                          (                                  )
   kernel/time/hrtimer.c:1232:53: note: place parentheses around the | expression to evaluate it first
           force_local &= base->cpu_base->next_timer == timer | in_callback;
                                                              ^
                                                        (                  )
   kernel/time/hrtimer.c:147:20: warning: unused function 'is_migration_base' [-Wunused-function]
   static inline bool is_migration_base(struct hrtimer_clock_base *base)
                      ^
   kernel/time/hrtimer.c:1902:20: warning: unused function '__hrtimer_peek_ahead_timers' [-Wunused-function]
   static inline void __hrtimer_peek_ahead_timers(void)
                      ^
   7 warnings generated.


vim +1232 kernel/time/hrtimer.c

  1211	
  1212	static int __hrtimer_start_range_ns(struct hrtimer *timer, ktime_t tim,
  1213					    u64 delta_ns, const enum hrtimer_mode mode,
  1214					    struct hrtimer_clock_base *base)
  1215	{
  1216		struct hrtimer_clock_base *new_base;
  1217		bool in_callback, force_local, first;
  1218	
  1219		/*
  1220		 * If the timer is on the local cpu base and is the first expiring
  1221		 * timer then this might end up reprogramming the hardware twice
  1222		 * (on removal and on enqueue). To avoid that by prevent the
  1223		 * reprogram on removal, keep the timer local to the current CPU
  1224		 * and enforce reprogramming after it is queued no matter whether
  1225		 * it is the new first expiring timer again or not.
  1226		 *
  1227		 * Also avoid reprogramming if the timer callback is currently
  1228		 * running.
  1229		 */
  1230		in_callback = base->running == timer;
  1231		force_local = base->cpu_base == this_cpu_ptr(&hrtimer_bases);
> 1232		force_local &= base->cpu_base->next_timer == timer | in_callback;
  1233	
  1234		/*
  1235		 * Remove an active timer from the queue. In case it is not queued
  1236		 * on the current CPU, make sure that remove_hrtimer() updates the
  1237		 * remote data correctly.
  1238		 *
  1239		 * If it's on the current CPU and the first expiring timer, then
  1240		 * skip reprogramming, keep the timer local and enforce
  1241		 * reprogramming later if it was the first expiring timer.  This
  1242		 * avoids programming the underlying clock event twice (once at
  1243		 * removal and once after enqueue).
  1244		 */
  1245		remove_hrtimer(timer, base, true, force_local);
  1246	
  1247		if (mode & HRTIMER_MODE_REL)
  1248			tim = ktime_add_safe(tim, base->get_time());
  1249	
  1250		tim = hrtimer_update_lowres(timer, tim, mode);
  1251	
  1252		hrtimer_set_expires_range_ns(timer, tim, delta_ns);
  1253	
  1254		/* Switch the timer base, if necessary: */
  1255		if (!force_local) {
  1256			new_base = switch_hrtimer_base(timer, base,
  1257						       mode & HRTIMER_MODE_PINNED);
  1258		} else {
  1259			new_base = base;
  1260		}
  1261	
  1262		first = enqueue_hrtimer(timer, new_base, mode);
  1263		if (!force_local || in_callback)
  1264			return first;
  1265	
  1266		/*
  1267		 * Timer was forced to stay on the current CPU to avoid
  1268		 * reprogramming on removal and enqueue. Force reprogram the
  1269		 * hardware by evaluating the new first expiring timer.
  1270		 */
  1271		hrtimer_force_reprogram(new_base->cpu_base, 1);
  1272		return 0;
  1273	}
  1274	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--LQksG6bCIzRHxTLp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--LQksG6bCIzRHxTLp--
