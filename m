Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E27239ECD4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 05:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbhFHDQy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 23:16:54 -0400
Received: from mga12.intel.com ([192.55.52.136]:44667 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230237AbhFHDQw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 23:16:52 -0400
IronPort-SDR: 7mP66wFXDQrJZ4l9HnXdizMuqkb14lGwlEIli7caZa7oWmuAS2kTKJ9YnkRj7DXQrAf8s4Z4d+
 6CGf7cVTRQIw==
X-IronPort-AV: E=McAfee;i="6200,9189,10008"; a="184448059"
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="184448059"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 20:15:00 -0700
IronPort-SDR: xk21ECQQo6o3Z9GqXtWVsBcywzmVaMXEWDNYfMVx3BmaN6M4K8ZULP63q5kAAn/1c+yANhHy0I
 DnSWJkwc5CVQ==
X-IronPort-AV: E=Sophos;i="5.83,256,1616482800"; 
   d="scan'208";a="447733233"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.11]) ([10.239.13.11])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2021 20:14:57 -0700
Subject: Re: [kbuild-all] Re: kernel/rcu/tree.c:2073:23: warning: stack frame
 size of 2704 bytes in function 'rcu_gp_kthread'
To:     paulmck@kernel.org
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
References: <202106061253.0X2QKyyI-lkp@intel.com>
 <20210606044926.GJ4397@paulmck-ThinkPad-P17-Gen-1>
 <4696fe3d-a7ad-acae-686e-6295ca327737@intel.com>
 <20210607151939.GP4397@paulmck-ThinkPad-P17-Gen-1>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <e7bbb0e5-3063-031b-af6e-273e97f1d61f@intel.com>
Date:   Tue, 8 Jun 2021 11:14:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20210607151939.GP4397@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/7/21 11:19 PM, Paul E. McKenney wrote:
> On Mon, Jun 07, 2021 at 05:18:21PM +0800, Rong Chen wrote:
>>
>> On 6/6/21 12:49 PM, Paul E. McKenney wrote:
>>> On Sun, Jun 06, 2021 at 12:19:57PM +0800, kernel test robot wrote:
>>>> Hi Paul,
>>>>
>>>> FYI, the error/warning still remains.
>>>>
>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>> head:   f5b6eb1e018203913dfefcf6fa988649ad11ad6e
>>>> commit: 7dffe01765d9309b8bd5505503933ec0ec53d192 rcu: Add lockdep_assert_irqs_disabled() to raw_spin_unlock_rcu_node() macros
>>>> date:   5 months ago
>>>> config: powerpc-randconfig-r023-20210606 (attached as .config)
>>>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 551a697c5cf33275b66add4fc467fcf59084cffb)
>>>> reproduce (this is a W=1 build):
>>>>           wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>           chmod +x ~/bin/make.cross
>>>>           # install powerpc cross compiling tool for clang build
>>>>           # apt-get install binutils-powerpc-linux-gnu
>>>>           # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7dffe01765d9309b8bd5505503933ec0ec53d192
>>>>           git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>           git fetch --no-tags linus master
>>>>           git checkout 7dffe01765d9309b8bd5505503933ec0ec53d192
>>>>           # save the attached .config to linux build tree
>>>>           COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc
>>>>
>>>> If you fix the issue, kindly add following tag as appropriate
>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>
>>>> All warnings (new ones prefixed by >>):
>>>>
>>>>      In file included from kernel/rcu/tree.c:21:
>>>>      In file included from include/linux/kernel.h:12:
>>>>      In file included from include/linux/bitops.h:29:
>>>>      In file included from arch/powerpc/include/asm/bitops.h:62:
>>>>      arch/powerpc/include/asm/barrier.h:49:9: warning: '__lwsync' macro redefined [-Wmacro-redefined]
>>>>      #define __lwsync()      __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
>>>>              ^
>>>>      <built-in>:310:9: note: previous definition is here
>>>>      #define __lwsync __builtin_ppc_lwsync
>>>>              ^
>>>>>> kernel/rcu/tree.c:2073:23: warning: stack frame size of 2704 bytes in function 'rcu_gp_kthread' [-Wframe-larger-than=]
>>>>      static int __noreturn rcu_gp_kthread(void *unused)
>>> Does -rcu commit 2f20de99a63b ("rcu: Make rcu_gp_cleanup() be noinline
>>> for tracing") help?
>> Hi Paul,
>>
>> The stack frame size decreased to 2256 bytes:
>>
>>    kernel/rcu/tree.c:2129:23: warning: stack frame size of 2256 bytes in
>> function 'rcu_gp_kthread' [-Wframe-larger-than=]
> Very good, thank you!  Does the following patch (in addition to that
> commit) also help?

Hi Paul,

I applied the below patch on commit 2f20de99a63b and the warning is gone.

Best Regards,
Rong Chen

>
> 							Thanx, Paul
>
> ------------------------------------------------------------------------
>
> diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
> index 13bd8eee62bf..ef435aeac993 100644
> --- a/kernel/rcu/tree.c
> +++ b/kernel/rcu/tree.c
> @@ -1737,7 +1737,7 @@ static void rcu_strict_gp_boundary(void *unused)
>   /*
>    * Initialize a new grace period.  Return false if no grace period required.
>    */
> -static bool rcu_gp_init(void)
> +static noinline bool rcu_gp_init(void)
>   {
>   	unsigned long firstseq;
>   	unsigned long flags;
> @@ -1931,7 +1931,7 @@ static void rcu_gp_fqs(bool first_time)
>   /*
>    * Loop doing repeated quiescent-state forcing until the grace period ends.
>    */
> -static void rcu_gp_fqs_loop(void)
> +static noinline void rcu_gp_fqs_loop(void)
>   {
>   	bool first_gp_fqs;
>   	int gf = 0;

