Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7AE407DD6
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 16:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234505AbhILOw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Sep 2021 10:52:26 -0400
Received: from mga17.intel.com ([192.55.52.151]:1600 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229653AbhILOwZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Sep 2021 10:52:25 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10105"; a="201639660"
X-IronPort-AV: E=Sophos;i="5.85,287,1624345200"; 
   d="gz'50?scan'50,208,50";a="201639660"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2021 07:51:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,287,1624345200"; 
   d="gz'50?scan'50,208,50";a="696194178"
Received: from lkp-server01.sh.intel.com (HELO 730d49888f40) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 12 Sep 2021 07:51:07 -0700
Received: from kbuild by 730d49888f40 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mPQp0-0006i4-S9; Sun, 12 Sep 2021 14:51:06 +0000
Date:   Sun, 12 Sep 2021 22:50:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Denis Pauk <pauk.denis@gmail.com>
Cc:     kbuild-all@lists.01.org, pauk.denis@gmail.com,
        Bernhard Seibold <mail@bernhard-seibold.de>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>, linux-hwmon@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] hwmon: (nct6775) Use sio_data in superio_*().
Message-ID: <202109122253.VsFmZxWu-lkp@intel.com>
References: <20210912110557.41346-2-pauk.denis@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline
In-Reply-To: <20210912110557.41346-2-pauk.denis@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Denis,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hwmon/hwmon-next]
[also build test ERROR on v5.14 next-20210910]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Denis-Pauk/hwmon-nct6775-Support-access-via-Asus-WMI/20210912-190749
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: arm-randconfig-s032-20210912 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/f11f2179ea7eb747b68a65ac03fce15ff4319004
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Denis-Pauk/hwmon-nct6775-Support-access-via-Asus-WMI/20210912-190749
        git checkout f11f2179ea7eb747b68a65ac03fce15ff4319004
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm SHELL=/bin/bash drivers/hwmon/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/hwmon/nct6775.c: In function 'clear_caseopen':
>> drivers/hwmon/nct6775.c:3452:70: error: macro "inb" passed 2 arguments, but takes just 1
    3452 |         reg = sio_data->inb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr]);
         |                                                                      ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
>> drivers/hwmon/nct6775.c:3452:13: warning: assignment to 'u8' {aka 'unsigned char'} from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3452 |         reg = sio_data->inb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr]);
         |             ^
>> drivers/hwmon/nct6775.c:3454:70: error: macro "outb" passed 3 arguments, but takes just 2
    3454 |         sio_data->outb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
         |                                                                      ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:252: note: macro "outb" defined here
     252 | #define outb(v,p)       ({ __iowmb(); __raw_writeb(v,__io(p)); })
         | 
   drivers/hwmon/nct6775.c:3454:17: warning: statement with no effect [-Wunused-value]
    3454 |         sio_data->outb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
         |         ~~~~~~~~^~~~~~
   drivers/hwmon/nct6775.c:3456:70: error: macro "outb" passed 3 arguments, but takes just 2
    3456 |         sio_data->outb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
         |                                                                      ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:252: note: macro "outb" defined here
     252 | #define outb(v,p)       ({ __iowmb(); __raw_writeb(v,__io(p)); })
         | 
   drivers/hwmon/nct6775.c:3456:17: warning: statement with no effect [-Wunused-value]
    3456 |         sio_data->outb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
         |         ~~~~~~~~^~~~~~
   drivers/hwmon/nct6775.c: In function 'nct6775_check_fan_inputs':
   drivers/hwmon/nct6775.c:3572:70: error: macro "inb" passed 2 arguments, but takes just 1
    3572 |         data->sio_reg_enable = sio_data->inb(sio_data, SIO_REG_ENABLE);
         |                                                                      ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3572:30: warning: assignment to 'u8' {aka 'unsigned char'} from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3572 |         data->sio_reg_enable = sio_data->inb(sio_data, SIO_REG_ENABLE);
         |                              ^
   drivers/hwmon/nct6775.c:3576:56: error: macro "inb" passed 2 arguments, but takes just 1
    3576 |                 int cr2c = sio_data->inb(sio_data, 0x2c);
         |                                                        ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
>> drivers/hwmon/nct6775.c:3576:28: warning: initialization of 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3576 |                 int cr2c = sio_data->inb(sio_data, 0x2c);
         |                            ^~~~~~~~
   drivers/hwmon/nct6775.c:3582:57: error: macro "inb" passed 2 arguments, but takes just 1
    3582 |                 fan4pin = !(sio_data->inb(sio_data, 0x2A) & 0x80);
         |                                                         ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
>> drivers/hwmon/nct6775.c:3582:59: error: invalid operands to binary & (have 'int (*)(struct nct6775_sio_data *, int)' and 'int')
    3582 |                 fan4pin = !(sio_data->inb(sio_data, 0x2A) & 0x80);
         |                             ~~~~~~~~~~~~~                 ^
         |                                     |
         |                                     int (*)(struct nct6775_sio_data *, int)
   drivers/hwmon/nct6775.c:3584:57: error: macro "inb" passed 2 arguments, but takes just 1
    3584 |                 bool gpok = sio_data->inb(sio_data, 0x27) & 0x80;
         |                                                         ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3584:59: error: invalid operands to binary & (have 'int (*)(struct nct6775_sio_data *, int)' and 'int')
    3584 |                 bool gpok = sio_data->inb(sio_data, 0x27) & 0x80;
         |                             ~~~~~~~~~~~~~                 ^
         |                                     |
         |                                     int (*)(struct nct6775_sio_data *, int)
   drivers/hwmon/nct6775.c:3601:74: error: macro "outb" passed 3 arguments, but takes just 2
    3601 |                                                      data->sio_reg_enable);
         |                                                                          ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:252: note: macro "outb" defined here
     252 | #define outb(v,p)       ({ __iowmb(); __raw_writeb(v,__io(p)); })
         | 
   drivers/hwmon/nct6775.c:3600:49: warning: statement with no effect [-Wunused-value]
    3600 |                                         sio_data->outb(sio_data, SIO_REG_ENABLE,
         |                                         ~~~~~~~~^~~~~~
   drivers/hwmon/nct6775.c:3609:65: error: macro "inb" passed 2 arguments, but takes just 1
    3609 |                         fan3pin = !(sio_data->inb(sio_data, 0x24) & 0x40);
         |                                                                 ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3609:67: error: invalid operands to binary & (have 'int (*)(struct nct6775_sio_data *, int)' and 'int')
    3609 |                         fan3pin = !(sio_data->inb(sio_data, 0x24) & 0x40);
         |                                     ~~~~~~~~~~~~~                 ^
         |                                             |
         |                                             int (*)(struct nct6775_sio_data *, int)
   drivers/hwmon/nct6775.c:3614:63: error: macro "inb" passed 2 arguments, but takes just 1
    3614 |                         fan4pin = sio_data->inb(sio_data, 0x1C) & 0x01;
         |                                                               ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3614:65: error: invalid operands to binary & (have 'int (*)(struct nct6775_sio_data *, int)' and 'int')
    3614 |                         fan4pin = sio_data->inb(sio_data, 0x1C) & 0x01;
         |                                   ~~~~~~~~~~~~~                 ^
         |                                           |
         |                                           int (*)(struct nct6775_sio_data *, int)
   drivers/hwmon/nct6775.c:3619:63: error: macro "inb" passed 2 arguments, but takes just 1
    3619 |                         fan5pin = sio_data->inb(sio_data, 0x1C) & 0x02;
         |                                                               ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3619:65: error: invalid operands to binary & (have 'int (*)(struct nct6775_sio_data *, int)' and 'int')
    3619 |                         fan5pin = sio_data->inb(sio_data, 0x1C) & 0x02;
         |                                   ~~~~~~~~~~~~~                 ^
         |                                           |
         |                                           int (*)(struct nct6775_sio_data *, int)
   drivers/hwmon/nct6775.c:3624:56: error: macro "inb" passed 2 arguments, but takes just 1
    3624 |                 int cr24 = sio_data->inb(sio_data, 0x24);
         |                                                        ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3624:28: warning: initialization of 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3624 |                 int cr24 = sio_data->inb(sio_data, 0x24);
         |                            ^~~~~~~~
   drivers/hwmon/nct6775.c:3629:56: error: macro "inb" passed 2 arguments, but takes just 1
    3629 |                 int cr1a = sio_data->inb(sio_data, 0x1a);
         |                                                        ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3629:28: warning: initialization of 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3629 |                 int cr1a = sio_data->inb(sio_data, 0x1a);
         |                            ^~~~~~~~
   drivers/hwmon/nct6775.c:3630:56: error: macro "inb" passed 2 arguments, but takes just 1
    3630 |                 int cr1b = sio_data->inb(sio_data, 0x1b);
         |                                                        ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3630:28: warning: initialization of 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3630 |                 int cr1b = sio_data->inb(sio_data, 0x1b);
         |                            ^~~~~~~~
--
         | 
   drivers/hwmon/nct6775.c:3634:28: warning: initialization of 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3634 |                 int cr2f = sio_data->inb(sio_data, 0x2f);
         |                            ^~~~~~~~
   drivers/hwmon/nct6775.c:3650:56: error: macro "inb" passed 2 arguments, but takes just 1
    3650 |                 int cr1a = sio_data->inb(sio_data, 0x1a);
         |                                                        ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3650:28: warning: initialization of 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3650 |                 int cr1a = sio_data->inb(sio_data, 0x1a);
         |                            ^~~~~~~~
   drivers/hwmon/nct6775.c:3651:56: error: macro "inb" passed 2 arguments, but takes just 1
    3651 |                 int cr1b = sio_data->inb(sio_data, 0x1b);
         |                                                        ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3651:28: warning: initialization of 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3651 |                 int cr1b = sio_data->inb(sio_data, 0x1b);
         |                            ^~~~~~~~
   drivers/hwmon/nct6775.c:3652:56: error: macro "inb" passed 2 arguments, but takes just 1
    3652 |                 int cr1c = sio_data->inb(sio_data, 0x1c);
         |                                                        ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3652:28: warning: initialization of 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3652 |                 int cr1c = sio_data->inb(sio_data, 0x1c);
         |                            ^~~~~~~~
   drivers/hwmon/nct6775.c:3653:56: error: macro "inb" passed 2 arguments, but takes just 1
    3653 |                 int cr1d = sio_data->inb(sio_data, 0x1d);
         |                                                        ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3653:28: warning: initialization of 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3653 |                 int cr1d = sio_data->inb(sio_data, 0x1d);
         |                            ^~~~~~~~
   drivers/hwmon/nct6775.c:3654:56: error: macro "inb" passed 2 arguments, but takes just 1
    3654 |                 int cr2a = sio_data->inb(sio_data, 0x2a);
         |                                                        ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3654:28: warning: initialization of 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3654 |                 int cr2a = sio_data->inb(sio_data, 0x2a);
         |                            ^~~~~~~~
   drivers/hwmon/nct6775.c:3655:56: error: macro "inb" passed 2 arguments, but takes just 1
    3655 |                 int cr2b = sio_data->inb(sio_data, 0x2b);
         |                                                        ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3655:28: warning: initialization of 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3655 |                 int cr2b = sio_data->inb(sio_data, 0x2b);
         |                            ^~~~~~~~
   drivers/hwmon/nct6775.c:3656:56: error: macro "inb" passed 2 arguments, but takes just 1
    3656 |                 int cr2d = sio_data->inb(sio_data, 0x2d);
         |                                                        ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3656:28: warning: initialization of 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3656 |                 int cr2d = sio_data->inb(sio_data, 0x2d);
         |                            ^~~~~~~~
   drivers/hwmon/nct6775.c:3657:56: error: macro "inb" passed 2 arguments, but takes just 1
    3657 |                 int cr2f = sio_data->inb(sio_data, 0x2f);
         |                                                        ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3657:28: warning: initialization of 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3657 |                 int cr2f = sio_data->inb(sio_data, 0x2f);
         |                            ^~~~~~~~
   drivers/hwmon/nct6775.c:3665:52: error: macro "inb" passed 2 arguments, but takes just 1
    3665 |                 cre0 = sio_data->inb(sio_data, 0xe0);
         |                                                    ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
>> drivers/hwmon/nct6775.c:3665:22: warning: assignment to 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3665 |                 cre0 = sio_data->inb(sio_data, 0xe0);
         |                      ^
   drivers/hwmon/nct6775.c:3666:52: error: macro "inb" passed 2 arguments, but takes just 1
    3666 |                 creb = sio_data->inb(sio_data, 0xeb);
         |                                                    ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3666:22: warning: assignment to 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3666 |                 creb = sio_data->inb(sio_data, 0xeb);
         |                      ^
   drivers/hwmon/nct6775.c:3667:52: error: macro "inb" passed 2 arguments, but takes just 1
    3667 |                 cred = sio_data->inb(sio_data, 0xed);
         |                                                    ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:3667:22: warning: assignment to 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    3667 |                 cred = sio_data->inb(sio_data, 0xed);
         |                      ^
   drivers/hwmon/nct6775.c: In function 'nct6775_probe':
   drivers/hwmon/nct6775.c:4531:44: error: macro "inb" passed 2 arguments, but takes just 1
    4531 |         cr2a = sio_data->inb(sio_data, 0x2a);
         |                                            ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:4531:14: warning: assignment to 'u8' {aka 'unsigned char'} from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    4531 |         cr2a = sio_data->inb(sio_data, 0x2a);
         |              ^
   drivers/hwmon/nct6775.c:4558:57: error: macro "inb" passed 2 arguments, but takes just 1
    4558 |                 data->vid = sio_data->inb(sio_data, 0xe3);
         |                                                         ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:4558:27: warning: assignment to 'u8' {aka 'unsigned char'} from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    4558 |                 data->vid = sio_data->inb(sio_data, 0xe3);
         |                           ^
   drivers/hwmon/nct6775.c:4567:64: error: macro "inb" passed 2 arguments, but takes just 1
    4567 |                                     NCT6775_REG_CR_FAN_DEBOUNCE);
         |                                                                ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:4566:21: warning: assignment to 'u8' {aka 'unsigned char'} from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    4566 |                 tmp = sio_data->inb(sio_data,
         |                     ^
   drivers/hwmon/nct6775.c:4591:33: error: macro "outb" passed 3 arguments, but takes just 2
    4591 |                              tmp);
         |                                 ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:252: note: macro "outb" defined here
     252 | #define outb(v,p)       ({ __iowmb(); __raw_writeb(v,__io(p)); })
         | 
   drivers/hwmon/nct6775.c:4590:25: warning: statement with no effect [-Wunused-value]
    4590 |                 sio_data->outb(sio_data, NCT6775_REG_CR_FAN_DEBOUNCE,
         |                 ~~~~~~~~^~~~~~
   drivers/hwmon/nct6775.c: In function 'nct6791_enable_io_mapping':
   drivers/hwmon/nct6775.c:4642:74: error: macro "inb" passed 2 arguments, but takes just 1
    4642 |         val = sio_data->inb(sio_data, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE);
         |                                                                          ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:4642:13: warning: assignment to 'int' from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    4642 |         val = sio_data->inb(sio_data, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE);
         |             ^
   drivers/hwmon/nct6775.c:4646:43: error: macro "outb" passed 3 arguments, but takes just 2
    4646 |                                val & ~0x10);
         |                                           ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:252: note: macro "outb" defined here
     252 | #define outb(v,p)       ({ __iowmb(); __raw_writeb(v,__io(p)); })
         | 
   drivers/hwmon/nct6775.c:4645:25: warning: statement with no effect [-Wunused-value]
    4645 |                 sio_data->outb(sio_data, NCT6791_REG_HM_IO_SPACE_LOCK_ENABLE,
         |                 ~~~~~~~~^~~~~~
   drivers/hwmon/nct6775.c: In function 'nct6775_resume':
   drivers/hwmon/nct6775.c:4680:53: error: macro "inb" passed 2 arguments, but takes just 1
    4680 |         reg = sio_data->inb(sio_data, SIO_REG_ENABLE);
         |                                                     ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:4680:13: warning: assignment to 'u8' {aka 'unsigned char'} from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    4680 |         reg = sio_data->inb(sio_data, SIO_REG_ENABLE);
         |             ^
   drivers/hwmon/nct6775.c:4682:78: error: macro "outb" passed 3 arguments, but takes just 2
    4682 |                 sio_data->outb(sio_data, SIO_REG_ENABLE, data->sio_reg_enable);
         |                                                                              ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:252: note: macro "outb" defined here
     252 | #define outb(v,p)       ({ __iowmb(); __raw_writeb(v,__io(p)); })
         | 
   drivers/hwmon/nct6775.c:4682:25: warning: statement with no effect [-Wunused-value]
    4682 |                 sio_data->outb(sio_data, SIO_REG_ENABLE, data->sio_reg_enable);
         |                 ~~~~~~~~^~~~~~
   drivers/hwmon/nct6775.c: In function 'nct6775_find':
   drivers/hwmon/nct6775.c:4759:53: error: macro "inb" passed 2 arguments, but takes just 1
    4759 |         val = (sio_data->inb(sio_data, SIO_REG_DEVID) << 8) |
         |                                                     ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:4759:55: error: invalid operands to binary << (have 'int (*)(struct nct6775_sio_data *, int)' and 'int')
    4759 |         val = (sio_data->inb(sio_data, SIO_REG_DEVID) << 8) |
         |                ~~~~~~~~~~~~~                          ^~
         |                        |
         |                        int (*)(struct nct6775_sio_data *, int)
   drivers/hwmon/nct6775.c:4760:58: error: macro "inb" passed 2 arguments, but takes just 1
    4760 |                 sio_data->inb(sio_data, SIO_REG_DEVID + 1);
         |                                                          ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:4810:52: error: macro "inb" passed 2 arguments, but takes just 1
    4810 |         val = (sio_data->inb(sio_data, SIO_REG_ADDR) << 8)
         |                                                    ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:4810:54: error: invalid operands to binary << (have 'int (*)(struct nct6775_sio_data *, int)' and 'int')
    4810 |         val = (sio_data->inb(sio_data, SIO_REG_ADDR) << 8)
         |                ~~~~~~~~~~~~~                         ^~
         |                        |
         |                        int (*)(struct nct6775_sio_data *, int)
   drivers/hwmon/nct6775.c:4811:55: error: macro "inb" passed 2 arguments, but takes just 1
    4811 |             | sio_data->inb(sio_data, SIO_REG_ADDR + 1);
         |                                                       ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
   drivers/hwmon/nct6775.c:4820:53: error: macro "inb" passed 2 arguments, but takes just 1
    4820 |         val = sio_data->inb(sio_data, SIO_REG_ENABLE);
         |                                                     ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:258: note: macro "inb" defined here
     258 | #define inb(p)  ({ __u8 __v = __raw_readb(__io(p)); __iormb(); __v; })
         | 
>> drivers/hwmon/nct6775.c:4820:13: warning: assignment to 'u16' {aka 'short unsigned int'} from 'int (*)(struct nct6775_sio_data *, int)' makes integer from pointer without a cast [-Wint-conversion]
    4820 |         val = sio_data->inb(sio_data, SIO_REG_ENABLE);
         |             ^
   drivers/hwmon/nct6775.c:4823:68: error: macro "outb" passed 3 arguments, but takes just 2
    4823 |                 sio_data->outb(sio_data, SIO_REG_ENABLE, val | 0x01);
         |                                                                    ^
   In file included from include/linux/io.h:13,
                    from drivers/hwmon/nct6775.c:56:
   arch/arm/include/asm/io.h:252: note: macro "outb" defined here
     252 | #define outb(v,p)       ({ __iowmb(); __raw_writeb(v,__io(p)); })
         | 
   drivers/hwmon/nct6775.c:4823:25: warning: statement with no effect [-Wunused-value]
    4823 |                 sio_data->outb(sio_data, SIO_REG_ENABLE, val | 0x01);
         |                 ~~~~~~~~^~~~~~
   At top level:
   drivers/hwmon/nct6775.c:284:17: warning: 'NCT6775_REG_CR_CASEOPEN_CLR' defined but not used [-Wunused-const-variable=]
     284 | static const u8 NCT6775_REG_CR_CASEOPEN_CLR[] = { 0xe6, 0xee };
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/inb +3452 drivers/hwmon/nct6775.c

  3423	
  3424	static ssize_t
  3425	clear_caseopen(struct device *dev, struct device_attribute *attr,
  3426		       const char *buf, size_t count)
  3427	{
  3428		struct nct6775_data *data = dev_get_drvdata(dev);
  3429		struct nct6775_sio_data *sio_data = dev_get_platdata(dev);
  3430		int nr = to_sensor_dev_attr(attr)->index - INTRUSION_ALARM_BASE;
  3431		unsigned long val;
  3432		u8 reg;
  3433		int ret;
  3434	
  3435		if (kstrtoul(buf, 10, &val) || val != 0)
  3436			return -EINVAL;
  3437	
  3438		mutex_lock(&data->update_lock);
  3439	
  3440		/*
  3441		 * Use CR registers to clear caseopen status.
  3442		 * The CR registers are the same for all chips, and not all chips
  3443		 * support clearing the caseopen status through "regular" registers.
  3444		 */
  3445		ret = sio_data->enter(sio_data);
  3446		if (ret) {
  3447			count = ret;
  3448			goto error;
  3449		}
  3450	
  3451		sio_data->select(sio_data, NCT6775_LD_ACPI);
> 3452		reg = sio_data->inb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr]);
  3453		reg |= NCT6775_CR_CASEOPEN_CLR_MASK[nr];
> 3454		sio_data->outb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
  3455		reg &= ~NCT6775_CR_CASEOPEN_CLR_MASK[nr];
  3456		sio_data->outb(sio_data, NCT6775_REG_CR_CASEOPEN_CLR[nr], reg);
  3457		sio_data->exit(sio_data);
  3458	
  3459		data->valid = false;	/* Force cache refresh */
  3460	error:
  3461		mutex_unlock(&data->update_lock);
  3462		return count;
  3463	}
  3464	
  3465	static SENSOR_DEVICE_ATTR(intrusion0_alarm, S_IWUSR | S_IRUGO, show_alarm,
  3466				  clear_caseopen, INTRUSION_ALARM_BASE);
  3467	static SENSOR_DEVICE_ATTR(intrusion1_alarm, S_IWUSR | S_IRUGO, show_alarm,
  3468				  clear_caseopen, INTRUSION_ALARM_BASE + 1);
  3469	static SENSOR_DEVICE_ATTR(intrusion0_beep, S_IWUSR | S_IRUGO, show_beep,
  3470				  store_beep, INTRUSION_ALARM_BASE);
  3471	static SENSOR_DEVICE_ATTR(intrusion1_beep, S_IWUSR | S_IRUGO, show_beep,
  3472				  store_beep, INTRUSION_ALARM_BASE + 1);
  3473	static SENSOR_DEVICE_ATTR(beep_enable, S_IWUSR | S_IRUGO, show_beep,
  3474				  store_beep, BEEP_ENABLE_BASE);
  3475	
  3476	static umode_t nct6775_other_is_visible(struct kobject *kobj,
  3477						struct attribute *attr, int index)
  3478	{
  3479		struct device *dev = kobj_to_dev(kobj);
  3480		struct nct6775_data *data = dev_get_drvdata(dev);
  3481	
  3482		if (index == 0 && !data->have_vid)
  3483			return 0;
  3484	
  3485		if (index == 1 || index == 2) {
  3486			if (data->ALARM_BITS[INTRUSION_ALARM_BASE + index - 1] < 0)
  3487				return 0;
  3488		}
  3489	
  3490		if (index == 3 || index == 4) {
  3491			if (data->BEEP_BITS[INTRUSION_ALARM_BASE + index - 3] < 0)
  3492				return 0;
  3493		}
  3494	
  3495		return attr->mode;
  3496	}
  3497	
  3498	/*
  3499	 * nct6775_other_is_visible uses the index into the following array
  3500	 * to determine if attributes should be created or not.
  3501	 * Any change in order or content must be matched.
  3502	 */
  3503	static struct attribute *nct6775_attributes_other[] = {
  3504		&dev_attr_cpu0_vid.attr,				/* 0 */
  3505		&sensor_dev_attr_intrusion0_alarm.dev_attr.attr,	/* 1 */
  3506		&sensor_dev_attr_intrusion1_alarm.dev_attr.attr,	/* 2 */
  3507		&sensor_dev_attr_intrusion0_beep.dev_attr.attr,		/* 3 */
  3508		&sensor_dev_attr_intrusion1_beep.dev_attr.attr,		/* 4 */
  3509		&sensor_dev_attr_beep_enable.dev_attr.attr,		/* 5 */
  3510	
  3511		NULL
  3512	};
  3513	
  3514	static const struct attribute_group nct6775_group_other = {
  3515		.attrs = nct6775_attributes_other,
  3516		.is_visible = nct6775_other_is_visible,
  3517	};
  3518	
  3519	static inline void nct6775_init_device(struct nct6775_data *data)
  3520	{
  3521		int i;
  3522		u8 tmp, diode;
  3523	
  3524		/* Start monitoring if needed */
  3525		if (data->REG_CONFIG) {
  3526			tmp = data->read_value(data, data->REG_CONFIG);
  3527			if (!(tmp & 0x01))
  3528				data->write_value(data, data->REG_CONFIG, tmp | 0x01);
  3529		}
  3530	
  3531		/* Enable temperature sensors if needed */
  3532		for (i = 0; i < NUM_TEMP; i++) {
  3533			if (!(data->have_temp & BIT(i)))
  3534				continue;
  3535			if (!data->reg_temp_config[i])
  3536				continue;
  3537			tmp = data->read_value(data, data->reg_temp_config[i]);
  3538			if (tmp & 0x01)
  3539				data->write_value(data, data->reg_temp_config[i],
  3540						    tmp & 0xfe);
  3541		}
  3542	
  3543		/* Enable VBAT monitoring if needed */
  3544		tmp = data->read_value(data, data->REG_VBAT);
  3545		if (!(tmp & 0x01))
  3546			data->write_value(data, data->REG_VBAT, tmp | 0x01);
  3547	
  3548		diode = data->read_value(data, data->REG_DIODE);
  3549	
  3550		for (i = 0; i < data->temp_fixed_num; i++) {
  3551			if (!(data->have_temp_fixed & BIT(i)))
  3552				continue;
  3553			if ((tmp & (data->DIODE_MASK << i)))	/* diode */
  3554				data->temp_type[i]
  3555				  = 3 - ((diode >> i) & data->DIODE_MASK);
  3556			else				/* thermistor */
  3557				data->temp_type[i] = 4;
  3558		}
  3559	}
  3560	
  3561	static void
  3562	nct6775_check_fan_inputs(struct nct6775_data *data,
  3563			struct nct6775_sio_data *sio_data)
  3564	{
  3565		bool fan3pin = false, fan4pin = false, fan4min = false;
  3566		bool fan5pin = false, fan6pin = false, fan7pin = false;
  3567		bool pwm3pin = false, pwm4pin = false, pwm5pin = false;
  3568		bool pwm6pin = false, pwm7pin = false;
  3569	
  3570		/* Store SIO_REG_ENABLE for use during resume */
  3571		sio_data->select(sio_data, NCT6775_LD_HWM);
  3572		data->sio_reg_enable = sio_data->inb(sio_data, SIO_REG_ENABLE);
  3573	
  3574		/* fan4 and fan5 share some pins with the GPIO and serial flash */
  3575		if (data->kind == nct6775) {
> 3576			int cr2c = sio_data->inb(sio_data, 0x2c);
  3577	
  3578			fan3pin = cr2c & BIT(6);
  3579			pwm3pin = cr2c & BIT(7);
  3580	
  3581			/* On NCT6775, fan4 shares pins with the fdc interface */
> 3582			fan4pin = !(sio_data->inb(sio_data, 0x2A) & 0x80);
  3583		} else if (data->kind == nct6776) {
  3584			bool gpok = sio_data->inb(sio_data, 0x27) & 0x80;
  3585			const char *board_vendor, *board_name;
  3586	
  3587			board_vendor = dmi_get_system_info(DMI_BOARD_VENDOR);
  3588			board_name = dmi_get_system_info(DMI_BOARD_NAME);
  3589	
  3590			if (board_name && board_vendor &&
  3591			    !strcmp(board_vendor, "ASRock")) {
  3592				/*
  3593				 * Auxiliary fan monitoring is not enabled on ASRock
  3594				 * Z77 Pro4-M if booted in UEFI Ultra-FastBoot mode.
  3595				 * Observed with BIOS version 2.00.
  3596				 */
  3597				if (!strcmp(board_name, "Z77 Pro4-M")) {
  3598					if ((data->sio_reg_enable & 0xe0) != 0xe0) {
  3599						data->sio_reg_enable |= 0xe0;
  3600						sio_data->outb(sio_data, SIO_REG_ENABLE,
  3601							     data->sio_reg_enable);
  3602					}
  3603				}
  3604			}
  3605	
  3606			if (data->sio_reg_enable & 0x80)
  3607				fan3pin = gpok;
  3608			else
  3609				fan3pin = !(sio_data->inb(sio_data, 0x24) & 0x40);
  3610	
  3611			if (data->sio_reg_enable & 0x40)
  3612				fan4pin = gpok;
  3613			else
  3614				fan4pin = sio_data->inb(sio_data, 0x1C) & 0x01;
  3615	
  3616			if (data->sio_reg_enable & 0x20)
  3617				fan5pin = gpok;
  3618			else
  3619				fan5pin = sio_data->inb(sio_data, 0x1C) & 0x02;
  3620	
  3621			fan4min = fan4pin;
  3622			pwm3pin = fan3pin;
  3623		} else if (data->kind == nct6106) {
  3624			int cr24 = sio_data->inb(sio_data, 0x24);
  3625	
  3626			fan3pin = !(cr24 & 0x80);
  3627			pwm3pin = cr24 & 0x08;
  3628		} else if (data->kind == nct6116) {
  3629			int cr1a = sio_data->inb(sio_data, 0x1a);
  3630			int cr1b = sio_data->inb(sio_data, 0x1b);
  3631			int cr24 = sio_data->inb(sio_data, 0x24);
  3632			int cr2a = sio_data->inb(sio_data, 0x2a);
  3633			int cr2b = sio_data->inb(sio_data, 0x2b);
  3634			int cr2f = sio_data->inb(sio_data, 0x2f);
  3635	
  3636			fan3pin = !(cr2b & 0x10);
  3637			fan4pin = (cr2b & 0x80) ||			// pin 1(2)
  3638				(!(cr2f & 0x10) && (cr1a & 0x04));	// pin 65(66)
  3639			fan5pin = (cr2b & 0x80) ||			// pin 126(127)
  3640				(!(cr1b & 0x03) && (cr2a & 0x02));	// pin 94(96)
  3641	
  3642			pwm3pin = fan3pin && (cr24 & 0x08);
  3643			pwm4pin = fan4pin;
  3644			pwm5pin = fan5pin;
  3645		} else {
  3646			/*
  3647			 * NCT6779D, NCT6791D, NCT6792D, NCT6793D, NCT6795D, NCT6796D,
  3648			 * NCT6797D, NCT6798D
  3649			 */
  3650			int cr1a = sio_data->inb(sio_data, 0x1a);
  3651			int cr1b = sio_data->inb(sio_data, 0x1b);
  3652			int cr1c = sio_data->inb(sio_data, 0x1c);
  3653			int cr1d = sio_data->inb(sio_data, 0x1d);
  3654			int cr2a = sio_data->inb(sio_data, 0x2a);
  3655			int cr2b = sio_data->inb(sio_data, 0x2b);
  3656			int cr2d = sio_data->inb(sio_data, 0x2d);
  3657			int cr2f = sio_data->inb(sio_data, 0x2f);
  3658			bool dsw_en = cr2f & BIT(3);
  3659			bool ddr4_en = cr2f & BIT(4);
  3660			int cre0;
  3661			int creb;
  3662			int cred;
  3663	
  3664			sio_data->select(sio_data, NCT6775_LD_12);
  3665			cre0 = sio_data->inb(sio_data, 0xe0);
  3666			creb = sio_data->inb(sio_data, 0xeb);
  3667			cred = sio_data->inb(sio_data, 0xed);
  3668	
  3669			fan3pin = !(cr1c & BIT(5));
  3670			fan4pin = !(cr1c & BIT(6));
  3671			fan5pin = !(cr1c & BIT(7));
  3672	
  3673			pwm3pin = !(cr1c & BIT(0));
  3674			pwm4pin = !(cr1c & BIT(1));
  3675			pwm5pin = !(cr1c & BIT(2));
  3676	
  3677			switch (data->kind) {
  3678			case nct6791:
  3679				fan6pin = cr2d & BIT(1);
  3680				pwm6pin = cr2d & BIT(0);
  3681				break;
  3682			case nct6792:
  3683				fan6pin = !dsw_en && (cr2d & BIT(1));
  3684				pwm6pin = !dsw_en && (cr2d & BIT(0));
  3685				break;
  3686			case nct6793:
  3687				fan5pin |= cr1b & BIT(5);
  3688				fan5pin |= creb & BIT(5);
  3689	
  3690				fan6pin = !dsw_en && (cr2d & BIT(1));
  3691				fan6pin |= creb & BIT(3);
  3692	
  3693				pwm5pin |= cr2d & BIT(7);
  3694				pwm5pin |= (creb & BIT(4)) && !(cr2a & BIT(0));
  3695	
  3696				pwm6pin = !dsw_en && (cr2d & BIT(0));
  3697				pwm6pin |= creb & BIT(2);
  3698				break;
  3699			case nct6795:
  3700				fan5pin |= cr1b & BIT(5);
  3701				fan5pin |= creb & BIT(5);
  3702	
  3703				fan6pin = (cr2a & BIT(4)) &&
  3704						(!dsw_en || (cred & BIT(4)));
  3705				fan6pin |= creb & BIT(3);
  3706	
  3707				pwm5pin |= cr2d & BIT(7);
  3708				pwm5pin |= (creb & BIT(4)) && !(cr2a & BIT(0));
  3709	
  3710				pwm6pin = (cr2a & BIT(3)) && (cred & BIT(2));
  3711				pwm6pin |= creb & BIT(2);
  3712				break;
  3713			case nct6796:
  3714				fan5pin |= cr1b & BIT(5);
  3715				fan5pin |= (cre0 & BIT(3)) && !(cr1b & BIT(0));
  3716				fan5pin |= creb & BIT(5);
  3717	
  3718				fan6pin = (cr2a & BIT(4)) &&
  3719						(!dsw_en || (cred & BIT(4)));
  3720				fan6pin |= creb & BIT(3);
  3721	
  3722				fan7pin = !(cr2b & BIT(2));
  3723	
  3724				pwm5pin |= cr2d & BIT(7);
  3725				pwm5pin |= (cre0 & BIT(4)) && !(cr1b & BIT(0));
  3726				pwm5pin |= (creb & BIT(4)) && !(cr2a & BIT(0));
  3727	
  3728				pwm6pin = (cr2a & BIT(3)) && (cred & BIT(2));
  3729				pwm6pin |= creb & BIT(2);
  3730	
  3731				pwm7pin = !(cr1d & (BIT(2) | BIT(3)));
  3732				break;
  3733			case nct6797:
  3734				fan5pin |= !ddr4_en && (cr1b & BIT(5));
  3735				fan5pin |= creb & BIT(5);
  3736	
  3737				fan6pin = cr2a & BIT(4);
  3738				fan6pin |= creb & BIT(3);
  3739	
  3740				fan7pin = cr1a & BIT(1);
  3741	
  3742				pwm5pin |= (creb & BIT(4)) && !(cr2a & BIT(0));
  3743				pwm5pin |= !ddr4_en && (cr2d & BIT(7));
  3744	
  3745				pwm6pin = creb & BIT(2);
  3746				pwm6pin |= cred & BIT(2);
  3747	
  3748				pwm7pin = cr1d & BIT(4);
  3749				break;
  3750			case nct6798:
  3751				fan6pin = !(cr1b & BIT(0)) && (cre0 & BIT(3));
  3752				fan6pin |= cr2a & BIT(4);
  3753				fan6pin |= creb & BIT(5);
  3754	
  3755				fan7pin = cr1b & BIT(5);
  3756				fan7pin |= !(cr2b & BIT(2));
  3757				fan7pin |= creb & BIT(3);
  3758	
  3759				pwm6pin = !(cr1b & BIT(0)) && (cre0 & BIT(4));
  3760				pwm6pin |= !(cred & BIT(2)) && (cr2a & BIT(3));
  3761				pwm6pin |= (creb & BIT(4)) && !(cr2a & BIT(0));
  3762	
  3763				pwm7pin = !(cr1d & (BIT(2) | BIT(3)));
  3764				pwm7pin |= cr2d & BIT(7);
  3765				pwm7pin |= creb & BIT(2);
  3766				break;
  3767			default:	/* NCT6779D */
  3768				break;
  3769			}
  3770	
  3771			fan4min = fan4pin;
  3772		}
  3773	
  3774		/* fan 1 and 2 (0x03) are always present */
  3775		data->has_fan = 0x03 | (fan3pin << 2) | (fan4pin << 3) |
  3776			(fan5pin << 4) | (fan6pin << 5) | (fan7pin << 6);
  3777		data->has_fan_min = 0x03 | (fan3pin << 2) | (fan4min << 3) |
  3778			(fan5pin << 4) | (fan6pin << 5) | (fan7pin << 6);
  3779		data->has_pwm = 0x03 | (pwm3pin << 2) | (pwm4pin << 3) |
  3780			(pwm5pin << 4) | (pwm6pin << 5) | (pwm7pin << 6);
  3781	}
  3782	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--HlL+5n6rz5pIUxbD
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--HlL+5n6rz5pIUxbD--
