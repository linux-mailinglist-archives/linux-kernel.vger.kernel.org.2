Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACA83DC7EF
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 21:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhGaTSx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 15:18:53 -0400
Received: from mga12.intel.com ([192.55.52.136]:10754 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229448AbhGaTSw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 15:18:52 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10062"; a="192854238"
X-IronPort-AV: E=Sophos;i="5.84,285,1620716400"; 
   d="gz'50?scan'50,208,50";a="192854238"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2021 12:18:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,285,1620716400"; 
   d="gz'50?scan'50,208,50";a="501026078"
Received: from lkp-server01.sh.intel.com (HELO d053b881505b) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2021 12:18:44 -0700
Received: from kbuild by d053b881505b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1m9uVP-000BTN-EM; Sat, 31 Jul 2021 19:18:43 +0000
Date:   Sun, 1 Aug 2021 03:17:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Carlos Bilbao <bilbao@vt.edu>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        0day robot <lkp@intel.com>
Subject: arch/m68k/atari/time.c:51:2: error: implicit declaration of function
 'legacy_timer_tick'
Message-ID: <202108010344.oIjIwf0X-lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="UlVJffcvxoiEqYs2"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UlVJffcvxoiEqYs2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://github.com/0day-ci/linux/commits/UPDATE-20210801-003033/Carlos-Bilbao/include-linux-Reorganize-timekeeping-and-ktime-headers/20210722-233301
head:   fb6876d6185db9db41efb455500de67da0937a36
commit: fb6876d6185db9db41efb455500de67da0937a36 include: linux: Reorganize timekeeping and ktime headers
date:   3 hours ago
config: m68k-buildonly-randconfig-r001-20210801 (attached as .config)
compiler: m68k-linux-gcc (GCC) 10.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/fb6876d6185db9db41efb455500de67da0937a36
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review UPDATE-20210801-003033/Carlos-Bilbao/include-linux-Reorganize-timekeeping-and-ktime-headers/20210722-233301
        git checkout fb6876d6185db9db41efb455500de67da0937a36
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-10.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/m68k/atari/time.c: In function 'mfp_timer_c_handler':
>> arch/m68k/atari/time.c:51:2: error: implicit declaration of function 'legacy_timer_tick' [-Werror=implicit-function-declaration]
      51 |  legacy_timer_tick(1);
         |  ^~~~~~~~~~~~~~~~~
   arch/m68k/atari/time.c: At top level:
   arch/m68k/atari/time.c:59:1: warning: no previous prototype for 'atari_sched_init' [-Wmissing-prototypes]
      59 | atari_sched_init(void)
         | ^~~~~~~~~~~~~~~~
   arch/m68k/atari/time.c:140:5: warning: no previous prototype for 'atari_mste_hwclk' [-Wmissing-prototypes]
     140 | int atari_mste_hwclk( int op, struct rtc_time *t )
         |     ^~~~~~~~~~~~~~~~
   arch/m68k/atari/time.c:199:5: warning: no previous prototype for 'atari_tt_hwclk' [-Wmissing-prototypes]
     199 | int atari_tt_hwclk( int op, struct rtc_time *t )
         |     ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   arch/m68k/hp300/time.c: In function 'hp300_tick':
>> arch/m68k/hp300/time.c:66:2: error: implicit declaration of function 'legacy_timer_tick' [-Werror=implicit-function-declaration]
      66 |  legacy_timer_tick(1);
         |  ^~~~~~~~~~~~~~~~~
   arch/m68k/hp300/time.c: At top level:
   arch/m68k/hp300/time.c:101:13: warning: no previous prototype for 'hp300_sched_init' [-Wmissing-prototypes]
     101 | void __init hp300_sched_init(void)
         |             ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   arch/m68k/mac/via.c:111:13: warning: no previous prototype for 'via_init' [-Wmissing-prototypes]
     111 | void __init via_init(void)
         |             ^~~~~~~~
   arch/m68k/mac/via.c: In function 'via_timer_handler':
>> arch/m68k/mac/via.c:588:2: error: implicit declaration of function 'legacy_timer_tick' [-Werror=implicit-function-declaration]
     588 |  legacy_timer_tick(1);
         |  ^~~~~~~~~~~~~~~~~
   arch/m68k/mac/via.c: At top level:
   arch/m68k/mac/via.c:593:13: warning: no previous prototype for 'via_init_clock' [-Wmissing-prototypes]
     593 | void __init via_init_clock(void)
         |             ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors
--
   arch/m68k/mvme16x/config.c:57:12: warning: no previous prototype for 'mvme16x_parse_bootinfo' [-Wmissing-prototypes]
      57 | int __init mvme16x_parse_bootinfo(const struct bi_record *bi)
         |            ^~~~~~~~~~~~~~~~~~~~~~
   arch/m68k/mvme16x/config.c:265:13: warning: no previous prototype for 'config_mvme16x' [-Wmissing-prototypes]
     265 | void __init config_mvme16x(void)
         |             ^~~~~~~~~~~~~~
   arch/m68k/mvme16x/config.c: In function 'mvme16x_timer_int':
>> arch/m68k/mvme16x/config.c:381:2: error: implicit declaration of function 'legacy_timer_tick' [-Werror=implicit-function-declaration]
     381 |  legacy_timer_tick(1);
         |  ^~~~~~~~~~~~~~~~~
   arch/m68k/mvme16x/config.c: In function 'mvme16x_hwclk':
   arch/m68k/mvme16x/config.c:439:2: warning: #warning check me! [-Wcpp]
     439 | #warning check me!
         |  ^~~~~~~
   cc1: some warnings being treated as errors
--
   arch/m68k/sun3/sun3ints.c: In function 'sun3_int5':
>> arch/m68k/sun3/sun3ints.c:76:2: error: implicit declaration of function 'legacy_timer_tick' [-Werror=implicit-function-declaration]
      76 |  legacy_timer_tick(1);
         |  ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/legacy_timer_tick +51 arch/m68k/atari/time.c

26ccd2d376d9b7 Finn Thain    2018-12-01  41  
1efdd4bd254311 Finn Thain    2018-12-01  42  static irqreturn_t mfp_timer_c_handler(int irq, void *dev_id)
1efdd4bd254311 Finn Thain    2018-12-01  43  {
1efdd4bd254311 Finn Thain    2018-12-01  44  	unsigned long flags;
1efdd4bd254311 Finn Thain    2018-12-01  45  
1efdd4bd254311 Finn Thain    2018-12-01  46  	local_irq_save(flags);
26ccd2d376d9b7 Finn Thain    2018-12-01  47  	do {
26ccd2d376d9b7 Finn Thain    2018-12-01  48  		last_timer_count = st_mfp.tim_dt_c;
26ccd2d376d9b7 Finn Thain    2018-12-01  49  	} while (last_timer_count == 1);
26ccd2d376d9b7 Finn Thain    2018-12-01  50  	clk_total += INT_TICKS;
42f1d57f055064 Arnd Bergmann 2020-09-24 @51  	legacy_timer_tick(1);
d6444094042b4f Arnd Bergmann 2020-09-24  52  	timer_heartbeat();
1efdd4bd254311 Finn Thain    2018-12-01  53  	local_irq_restore(flags);
1efdd4bd254311 Finn Thain    2018-12-01  54  
1efdd4bd254311 Finn Thain    2018-12-01  55  	return IRQ_HANDLED;
1efdd4bd254311 Finn Thain    2018-12-01  56  }
1efdd4bd254311 Finn Thain    2018-12-01  57  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--UlVJffcvxoiEqYs2
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
6v8AzZPIpYAzAQA=

--UlVJffcvxoiEqYs2--
