Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FB33FF6C5
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 00:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347592AbhIBWDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 18:03:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:52732 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347527AbhIBWDp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 18:03:45 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10095"; a="198806543"
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="gz'50?scan'50,208,50";a="198806543"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2021 15:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,263,1624345200"; 
   d="gz'50?scan'50,208,50";a="689332893"
Received: from lkp-server01.sh.intel.com (HELO 4fbc2b3ce5aa) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 02 Sep 2021 15:02:45 -0700
Received: from kbuild by 4fbc2b3ce5aa with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mLunE-0009KN-MO; Thu, 02 Sep 2021 22:02:44 +0000
Date:   Fri, 3 Sep 2021 06:01:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [rcu:dev.2021.08.25a 99/115] kernel/time/hrtimer.c:1478:7: warning:
 no previous prototype for '__run_hrtimer_get_debug'
Message-ID: <202109030640.6NuTjfs6-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2021.08.25a
head:   2ba1d046d9bc5b4496027d120e3ddcdfbb2fe9f4
commit: b5d3ff1ac4a5c2cad4fe4c253029971886ff7fcf [99/115] EXP cpu: Print out last hrtimer handler
config: i386-tinyconfig (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/commit/?id=b5d3ff1ac4a5c2cad4fe4c253029971886ff7fcf
        git remote add rcu https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
        git fetch --no-tags rcu dev.2021.08.25a
        git checkout b5d3ff1ac4a5c2cad4fe4c253029971886ff7fcf
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/time/hrtimer.c:120:21: warning: initialized field overwritten [-Woverride-init]
     120 |  [CLOCK_REALTIME] = HRTIMER_BASE_REALTIME,
         |                     ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:120:21: note: (near initialization for 'hrtimer_clock_to_base_table[0]')
   kernel/time/hrtimer.c:121:22: warning: initialized field overwritten [-Woverride-init]
     121 |  [CLOCK_MONOTONIC] = HRTIMER_BASE_MONOTONIC,
         |                      ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:121:22: note: (near initialization for 'hrtimer_clock_to_base_table[1]')
   kernel/time/hrtimer.c:122:21: warning: initialized field overwritten [-Woverride-init]
     122 |  [CLOCK_BOOTTIME] = HRTIMER_BASE_BOOTTIME,
         |                     ^~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:122:21: note: (near initialization for 'hrtimer_clock_to_base_table[7]')
   kernel/time/hrtimer.c:123:17: warning: initialized field overwritten [-Woverride-init]
     123 |  [CLOCK_TAI]  = HRTIMER_BASE_TAI,
         |                 ^~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c:123:17: note: (near initialization for 'hrtimer_clock_to_base_table[11]')
>> kernel/time/hrtimer.c:1478:7: warning: no previous prototype for '__run_hrtimer_get_debug' [-Wmissing-prototypes]
    1478 | void *__run_hrtimer_get_debug(int cpu)
         |       ^~~~~~~~~~~~~~~~~~~~~~~
   kernel/time/hrtimer.c: In function '__run_hrtimer':
   kernel/time/hrtimer.c:1507:7: warning: variable 'expires_in_hardirq' set but not used [-Wunused-but-set-variable]
    1507 |  bool expires_in_hardirq;
         |       ^~~~~~~~~~~~~~~~~~


vim +/__run_hrtimer_get_debug +1478 kernel/time/hrtimer.c

  1477	
> 1478	void *__run_hrtimer_get_debug(int cpu)
  1479	{
  1480		return READ_ONCE(per_cpu(__run_hrtimer_fn, cpu));
  1481	}
  1482	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--liOOAslEiF7prFVr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--liOOAslEiF7prFVr--
