Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C22A3EA00B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Aug 2021 09:59:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhHLH73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Aug 2021 03:59:29 -0400
Received: from mga01.intel.com ([192.55.52.88]:18629 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231520AbhHLH72 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Aug 2021 03:59:28 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10073"; a="237331227"
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="237331227"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 00:59:03 -0700
X-IronPort-AV: E=Sophos;i="5.84,315,1620716400"; 
   d="scan'208";a="517343518"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.255.29.191]) ([10.255.29.191])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2021 00:59:00 -0700
Subject: Re: [kbuild-all] Re: [PATCH v2 1/3] drivers/clocksource/timer-of:
 Remove __init markings
To:     Chunyan Zhang <zhang.lyra@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        Saravana Kannan <saravanak@google.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
References: <20210715065455.392923-2-zhang.lyra@gmail.com>
 <202108011431.Nx7sS0uY-lkp@intel.com>
 <CAAfSe-vY9bkLb7Q2Tn=2ug6pau9VHkfZyvmoQNMqeKmxfquOHg@mail.gmail.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <257619cf-5381-3f8b-3f80-2308e2a2cb85@intel.com>
Date:   Thu, 12 Aug 2021 15:58:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAAfSe-vY9bkLb7Q2Tn=2ug6pau9VHkfZyvmoQNMqeKmxfquOHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/12/2021 2:39 PM, Chunyan Zhang wrote:
> On Sun, 1 Aug 2021 at 14:18, kernel test robot <lkp@intel.com> wrote:
>>
>> Hi Chunyan,
>>
>> I love your patch! Yet something to improve:
>>
>> [auto build test ERROR on tip/timers/core]
>> [also build test ERROR on linux/master linus/master v5.14-rc3 next-20210730]
>> [If your patch is applied to the wrong git tree, kindly drop us a note.
>> And when submitting patch, we suggest to use '--base' as documented in
>> https://git-scm.com/docs/git-format-patch]
>>
>> url:    https://github.com/0day-ci/linux/commits/Chunyan-Zhang/Add-module-build-support-for-timer-driver/20210715-145711
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 2d0a9eb23ccfdf11308bec6db0bc007585d919d2
>> config: s390-buildonly-randconfig-r003-20210728 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project c49df15c278857adecd12db6bb1cdc96885f7079)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install s390 cross compiling tool for clang build
>>          # apt-get install binutils-s390x-linux-gnu
>>          # https://github.com/0day-ci/linux/commit/8e3c2c4da32affdbca933979110050e564351c84
>>          git remote add linux-review https://github.com/0day-ci/linux
>>          git fetch --no-tags linux-review Chunyan-Zhang/Add-module-build-support-for-timer-driver/20210715-145711
>>          git checkout 8e3c2c4da32affdbca933979110050e564351c84
>>          # save the attached .config to linux build tree
>>          mkdir build_dir
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=s390 SHELL=/bin/bash
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All errors (new ones prefixed by >>):
>>
>>     s390x-linux-gnu-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_attach':
>>     main.c:(.text+0x21a): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: main.c:(.text+0x270): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_detach':
>>     main.c:(.text+0x478): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: main.c:(.text+0x4d4): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: drivers/tty/ipwireless/main.o: in function `ipwireless_probe':
>>     main.c:(.text+0x70c): undefined reference to `ioremap'
>>     s390x-linux-gnu-ld: main.c:(.text+0x83e): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: main.c:(.text+0x8b6): undefined reference to `ioremap'
>>     s390x-linux-gnu-ld: main.c:(.text+0x93a): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
>>     xillybus_of.c:(.text+0x9a): undefined reference to `devm_platform_ioremap_resource'
>>     s390x-linux-gnu-ld: drivers/net/arcnet/arc-rimi.o: in function `check_mirror':
>>     arc-rimi.c:(.text+0x5c): undefined reference to `ioremap'
>>     s390x-linux-gnu-ld: arc-rimi.c:(.text+0xc2): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: drivers/net/arcnet/arc-rimi.o: in function `arc_rimi_exit':
>>     arc-rimi.c:(.exit.text+0x44): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: drivers/net/arcnet/arc-rimi.o: in function `arcrimi_found':
>>     arc-rimi.c:(.init.text+0x37c): undefined reference to `ioremap'
>>     s390x-linux-gnu-ld: arc-rimi.c:(.init.text+0x3c8): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: arc-rimi.c:(.init.text+0x614): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: arc-rimi.c:(.init.text+0x674): undefined reference to `ioremap'
>>     s390x-linux-gnu-ld: arc-rimi.c:(.init.text+0x6de): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_probe':
>>     fmvj18x_cs.c:(.text+0x756): undefined reference to `ioremap'
>>     s390x-linux-gnu-ld: fmvj18x_cs.c:(.text+0x788): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: fmvj18x_cs.c:(.text+0x7e0): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_detach':
>>     fmvj18x_cs.c:(.text+0xce0): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: drivers/net/ethernet/fujitsu/fmvj18x_cs.o: in function `fmvj18x_get_hwinfo':
>>     fmvj18x_cs.c:(.text+0x27d4): undefined reference to `ioremap'
>>     s390x-linux-gnu-ld: fmvj18x_cs.c:(.text+0x2940): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
>>     cistpl.c:(.text+0x9c): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
>>     cistpl.c:(.text+0x46c): undefined reference to `ioremap'
>>     s390x-linux-gnu-ld: cistpl.c:(.text+0x4a8): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: cistpl.c:(.text+0x4e6): undefined reference to `iounmap'
>>     s390x-linux-gnu-ld: cistpl.c:(.text+0x4f8): undefined reference to `ioremap'
>>     s390x-linux-gnu-ld: drivers/crypto/ccree/cc_driver.o: in function `ccree_probe':
>>     cc_driver.c:(.text+0x5a8): undefined reference to `devm_ioremap_resource'
>>     s390x-linux-gnu-ld: drivers/crypto/ccree/cc_debugfs.o: in function `cc_debugfs_init':
>>     cc_debugfs.c:(.text+0xac): undefined reference to `debugfs_create_regset32'
>>     s390x-linux-gnu-ld: cc_debugfs.c:(.text+0x190): undefined reference to `debugfs_create_regset32'
>>     s390x-linux-gnu-ld: drivers/clocksource/timer-of.o: in function `timer_of_init':
>>     timer-of.c:(.text+0x104): undefined reference to `of_iomap'
>>>> s390x-linux-gnu-ld: timer-of.c:(.text+0x306): undefined reference to `iounmap'
> 
> Seems TIMER_OF should depend on HAS_IOMEM, but this error is not
> related with changes in the above patch?

Hi Chunyan,

Thanks for the feedback, the bot found the error was first found with 
this patch, sometimes it doesn't mean the patch brings the error.

Best Regards,
Rong Chen

> 
> 
>>     s390x-linux-gnu-ld: drivers/clocksource/timer-of.o: in function `timer_of_cleanup':
>>     timer-of.c:(.text+0x5f2): undefined reference to `iounmap'
>>
>> ---
>> 0-DAY CI Kernel Test Service, Intel Corporation
>> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org
> 
