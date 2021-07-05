Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF0D3BB82D
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 09:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbhGEHt5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 03:49:57 -0400
Received: from mga09.intel.com ([134.134.136.24]:22268 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230053AbhGEHty (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 03:49:54 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10035"; a="208895523"
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="208895523"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 00:47:12 -0700
X-IronPort-AV: E=Sophos;i="5.83,325,1616482800"; 
   d="scan'208";a="496033702"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2021 00:47:10 -0700
Subject: Re: [kbuild-all] Re: kernel/time/clocksource-wdtest.c:47:22: warning:
 signed shift result (0x27BC86B00) requires 35 bits to represent, but 'long'
 only has 32 bits
To:     paulmck@kernel.org, kernel test robot <lkp@intel.com>
Cc:     clang-built-linux@googlegroups.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
References: <202107040532.wqL30yFp-lkp@intel.com>
 <20210704174310.GR4397@paulmck-ThinkPad-P17-Gen-1>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <254ab0ec-2c25-29fd-cbe1-eaf2bc135326@intel.com>
Date:   Mon, 5 Jul 2021 15:47:09 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210704174310.GR4397@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/5/21 1:43 AM, Paul E. McKenney wrote:
> On Sun, Jul 04, 2021 at 05:42:36AM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   303392fd5c160822bf778270b28ec5ea50cab2b4
>> commit: 1253b9b87e42ab6a3d5c2cb27af2bdd67d7e50ff clocksource: Provide kernel module to test clocksource watchdog
>> date:   11 days ago
>> config: mips-randconfig-r015-20210702 (attached as .config)
>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 9eb613b2de3163686b1a4bd1160f15ac56a4b083)
>> reproduce (this is a W=1 build):
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # install mips cross compiling tool for clang build
>>          # apt-get install binutils-mips-linux-gnu
>>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1253b9b87e42ab6a3d5c2cb27af2bdd67d7e50ff
>>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>          git fetch --no-tags linus master
>>          git checkout 1253b9b87e42ab6a3d5c2cb27af2bdd67d7e50ff
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=mips
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> kernel/time/clocksource-wdtest.c:47:22: warning: signed shift result (0x27BC86B00) requires 35 bits to represent, but 'long' only has 32 bits [-Wshift-overflow]
>>             .mult                   = TICK_NSEC << JIFFIES_SHIFT, /* details above */
>>                                       ~~~~~~~~~ ^  ~~~~~~~~~~~~~
>>     1 warning generated.
> You have CONFIG_HZ_24=y and this test module assumes HZ > 100, as noted
> just above the excerpt below:
>
> /* Assume HZ > 100. */
> #define JIFFIES_SHIFT   8
>
> So this is expected behavior.
>
> Would it help if I gave that comment some teeth, for example, as
> shown at the end of this email?

Hi Paul,

I have confirmed that the below change can avoid the warning.

Best Regards,
Rong Chen

>
> ------------------------------------------------------------------------
>
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index e1856030fa66..8f0ad6e4183c 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -2573,6 +2573,7 @@ config TEST_FPU
>   config TEST_CLOCKSOURCE_WATCHDOG
>   	tristate "Test clocksource watchdog in kernel space"
>   	depends on CLOCKSOURCE_WATCHDOG
> +	depends on HZ >= 100
>   	help
>   	  Enable this option to create a kernel module that will trigger
>   	  a test of the clocksource watchdog.  This module may be loaded
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

