Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 820433DC7FF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 21:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbhGaTaz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 15:30:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:64650 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhGaTax (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 15:30:53 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10062"; a="274331675"
X-IronPort-AV: E=Sophos;i="5.84,285,1620716400"; 
   d="gz'50?scan'50,208,50";a="274331675"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2021 12:30:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,285,1620716400"; 
   d="gz'50?scan'50,208,50";a="665656165"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jul 2021 12:30:44 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m9uh1-000BTh-Jy; Sat, 31 Jul 2021 19:30:43 +0000
Date:   Sun, 1 Aug 2021 03:30:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Carlos Bilbao <bilbao@vt.edu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: arch/powerpc/kernel/time.c:801:5: error: no previous prototype for
 'update_persistent_clock64'
Message-ID: <202108010312.8uIaWK0u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20210801-003033/Carlos-Bilbao/include-linux-Reorganize-timekeeping-and-ktime-headers/20210722-233301
head:   fb6876d6185db9db41efb455500de67da0937a36
commit: fb6876d6185db9db41efb455500de67da0937a36 include: linux: Reorganize timekeeping and ktime headers
date:   3 hours ago
config: powerpc-bluestone_defconfig (attached as .config)
compiler: powerpc-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fb6876d6185db9db41efb455500de67da0937a36
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20210801-003033/Carlos-Bilbao/include-linux-Reorganize-timekeeping-and-ktime-headers/20210722-233301
        git checkout fb6876d6185db9db41efb455500de67da0937a36
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/powerpc/kernel/time.c:801:5: error: no previous prototype for 'update_persistent_clock64' [-Werror=missing-prototypes]
     801 | int update_persistent_clock64(struct timespec64 now)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~
>> arch/powerpc/kernel/time.c:840:6: error: no previous prototype for 'read_persistent_clock64' [-Werror=missing-prototypes]
     840 | void read_persistent_clock64(struct timespec64 *ts)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   cc1: all warnings being treated as errors


vim +/update_persistent_clock64 +801 arch/powerpc/kernel/time.c

10f7e7c15e6ce4 arch/ppc64/kernel/time.c   Arnd Bergmann          2005-06-23  800  
5235afa89a246c arch/powerpc/kernel/time.c Arnd Bergmann          2018-04-23 @801  int update_persistent_clock64(struct timespec64 now)
^1da177e4c3f41 arch/ppc64/kernel/time.c   Linus Torvalds         2005-04-16  802  {
f2783c15007468 arch/powerpc/kernel/time.c Paul Mackerras         2005-10-20  803  	struct rtc_time tm;
f2783c15007468 arch/powerpc/kernel/time.c Paul Mackerras         2005-10-20  804  
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  805  	if (!ppc_md.set_rtc_time)
023f333a99cee9 arch/powerpc/kernel/time.c Jason Gunthorpe        2012-12-17  806  		return -ENODEV;
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  807  
5235afa89a246c arch/powerpc/kernel/time.c Arnd Bergmann          2018-04-23  808  	rtc_time64_to_tm(now.tv_sec + 1 + timezone_offset, &tm);
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  809  
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  810  	return ppc_md.set_rtc_time(&tm);
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  811  }
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  812  
5bfd643583b2e2 arch/powerpc/kernel/time.c Arnd Bergmann          2018-04-23  813  static void __read_persistent_clock(struct timespec64 *ts)
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  814  {
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  815  	struct rtc_time tm;
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  816  	static int first = 1;
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  817  
d90246cd8e0141 arch/powerpc/kernel/time.c Martin Schwidefsky     2009-08-22  818  	ts->tv_nsec = 0;
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  819  	/* XXX this is a litle fragile but will work okay in the short term */
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  820  	if (first) {
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  821  		first = 0;
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  822  		if (ppc_md.time_init)
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  823  			timezone_offset = ppc_md.time_init();
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  824  
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  825  		/* get_boot_time() isn't guaranteed to be safe to call late */
d90246cd8e0141 arch/powerpc/kernel/time.c Martin Schwidefsky     2009-08-22  826  		if (ppc_md.get_boot_time) {
d90246cd8e0141 arch/powerpc/kernel/time.c Martin Schwidefsky     2009-08-22  827  			ts->tv_sec = ppc_md.get_boot_time() - timezone_offset;
d90246cd8e0141 arch/powerpc/kernel/time.c Martin Schwidefsky     2009-08-22  828  			return;
d90246cd8e0141 arch/powerpc/kernel/time.c Martin Schwidefsky     2009-08-22  829  		}
d90246cd8e0141 arch/powerpc/kernel/time.c Martin Schwidefsky     2009-08-22  830  	}
d90246cd8e0141 arch/powerpc/kernel/time.c Martin Schwidefsky     2009-08-22  831  	if (!ppc_md.get_rtc_time) {
d90246cd8e0141 arch/powerpc/kernel/time.c Martin Schwidefsky     2009-08-22  832  		ts->tv_sec = 0;
d90246cd8e0141 arch/powerpc/kernel/time.c Martin Schwidefsky     2009-08-22  833  		return;
aa3be5f32db137 arch/powerpc/kernel/time.c Tony Breeds            2007-09-21  834  	}
f2783c15007468 arch/powerpc/kernel/time.c Paul Mackerras         2005-10-20  835  	ppc_md.get_rtc_time(&tm);
978d7eb31d44de arch/powerpc/kernel/time.c Benjamin Herrenschmidt 2009-11-01  836  
5bfd643583b2e2 arch/powerpc/kernel/time.c Arnd Bergmann          2018-04-23  837  	ts->tv_sec = rtc_tm_to_time64(&tm);
f2783c15007468 arch/powerpc/kernel/time.c Paul Mackerras         2005-10-20  838  }
f2783c15007468 arch/powerpc/kernel/time.c Paul Mackerras         2005-10-20  839  
5bfd643583b2e2 arch/powerpc/kernel/time.c Arnd Bergmann          2018-04-23 @840  void read_persistent_clock64(struct timespec64 *ts)
978d7eb31d44de arch/powerpc/kernel/time.c Benjamin Herrenschmidt 2009-11-01  841  {
978d7eb31d44de arch/powerpc/kernel/time.c Benjamin Herrenschmidt 2009-11-01  842  	__read_persistent_clock(ts);
978d7eb31d44de arch/powerpc/kernel/time.c Benjamin Herrenschmidt 2009-11-01  843  
978d7eb31d44de arch/powerpc/kernel/time.c Benjamin Herrenschmidt 2009-11-01  844  	/* Sanitize it in case real time clock is set below EPOCH */
978d7eb31d44de arch/powerpc/kernel/time.c Benjamin Herrenschmidt 2009-11-01  845  	if (ts->tv_sec < 0) {
978d7eb31d44de arch/powerpc/kernel/time.c Benjamin Herrenschmidt 2009-11-01  846  		ts->tv_sec = 0;
978d7eb31d44de arch/powerpc/kernel/time.c Benjamin Herrenschmidt 2009-11-01  847  		ts->tv_nsec = 0;
978d7eb31d44de arch/powerpc/kernel/time.c Benjamin Herrenschmidt 2009-11-01  848  	}
978d7eb31d44de arch/powerpc/kernel/time.c Benjamin Herrenschmidt 2009-11-01  849  		
978d7eb31d44de arch/powerpc/kernel/time.c Benjamin Herrenschmidt 2009-11-01  850  }
978d7eb31d44de arch/powerpc/kernel/time.c Benjamin Herrenschmidt 2009-11-01  851  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--GvXjxJ+pjyke8COw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--GvXjxJ+pjyke8COw--
