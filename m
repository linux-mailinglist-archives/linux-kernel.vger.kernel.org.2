Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 446E139FB39
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 17:53:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbhFHPzh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Jun 2021 11:55:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:33720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230425AbhFHPzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Jun 2021 11:55:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AF1B360FEA;
        Tue,  8 Jun 2021 15:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623167623;
        bh=Y0s5y8UvUQGn8A1rWcis5dg8fyss+/kqJGCt41rubgc=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=CQbphQVsb7ZAoau4YKL8co69sN785zak6gqpK21Z6chsxG2PKYJJwXQci/icel3f0
         q/KQpQ+N7AF06t+P/cVQX9+1ZrxfyRf6HtzvbH75kgS4foDHqxKb+x7zawHMyJUlWH
         d2GXUc/0b9lu4vy9s0f4OIpQez7Cgy6iJvGpAKJq+lNAwMiekzHvA4jf4bg25MCLy7
         i8ds5JQJjGEABxVd/sl8fYXeFdnWaNj1sx8uk6Zodag/cqP9ZEfIiwDYtm5/zHcJQR
         0/gbtvG2Bi/aBVA2kkivd827cUAIiVcx4KBRodMJLvw2/UyQWkxXME9J2Zl6igFgjd
         eB9C1dliVwwiA==
Subject: Re: [kbuild-all] Re: kernel/rcu/tree.c:2073:23: warning: stack frame
 size of 2704 bytes in function 'rcu_gp_kthread'
To:     paulmck@kernel.org, Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
References: <202106061253.0X2QKyyI-lkp@intel.com>
 <20210606044926.GJ4397@paulmck-ThinkPad-P17-Gen-1>
 <4696fe3d-a7ad-acae-686e-6295ca327737@intel.com>
 <20210607151939.GP4397@paulmck-ThinkPad-P17-Gen-1>
 <e7bbb0e5-3063-031b-af6e-273e97f1d61f@intel.com>
 <20210608050134.GZ4397@paulmck-ThinkPad-P17-Gen-1>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <f3cc5211-0c68-17c8-a222-4bc2c2525522@kernel.org>
Date:   Tue, 8 Jun 2021 08:53:17 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210608050134.GZ4397@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/2021 10:01 PM, Paul E. McKenney wrote:
> On Tue, Jun 08, 2021 at 11:14:40AM +0800, Rong Chen wrote:
>>
>>
>> On 6/7/21 11:19 PM, Paul E. McKenney wrote:
>>> On Mon, Jun 07, 2021 at 05:18:21PM +0800, Rong Chen wrote:
>>>>
>>>> On 6/6/21 12:49 PM, Paul E. McKenney wrote:
>>>>> On Sun, Jun 06, 2021 at 12:19:57PM +0800, kernel test robot wrote:
>>>>>> Hi Paul,
>>>>>>
>>>>>> FYI, the error/warning still remains.
>>>>>>
>>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>>>> head:   f5b6eb1e018203913dfefcf6fa988649ad11ad6e
>>>>>> commit: 7dffe01765d9309b8bd5505503933ec0ec53d192 rcu: Add lockdep_assert_irqs_disabled() to raw_spin_unlock_rcu_node() macros
>>>>>> date:   5 months ago
>>>>>> config: powerpc-randconfig-r023-20210606 (attached as .config)
>>>>>> compiler: clang version 13.0.0 (https://github.com/llvm/llvm-project 551a697c5cf33275b66add4fc467fcf59084cffb)
>>>>>> reproduce (this is a W=1 build):
>>>>>>            wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>>>>>            chmod +x ~/bin/make.cross
>>>>>>            # install powerpc cross compiling tool for clang build
>>>>>>            # apt-get install binutils-powerpc-linux-gnu
>>>>>>            # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7dffe01765d9309b8bd5505503933ec0ec53d192
>>>>>>            git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>>>            git fetch --no-tags linus master
>>>>>>            git checkout 7dffe01765d9309b8bd5505503933ec0ec53d192
>>>>>>            # save the attached .config to linux build tree
>>>>>>            COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=powerpc
>>>>>>
>>>>>> If you fix the issue, kindly add following tag as appropriate
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>>
>>>>>> All warnings (new ones prefixed by >>):
>>>>>>
>>>>>>       In file included from kernel/rcu/tree.c:21:
>>>>>>       In file included from include/linux/kernel.h:12:
>>>>>>       In file included from include/linux/bitops.h:29:
>>>>>>       In file included from arch/powerpc/include/asm/bitops.h:62:
>>>>>>       arch/powerpc/include/asm/barrier.h:49:9: warning: '__lwsync' macro redefined [-Wmacro-redefined]
>>>>>>       #define __lwsync()      __asm__ __volatile__ (stringify_in_c(LWSYNC) : : :"memory")
>>>>>>               ^
>>>>>>       <built-in>:310:9: note: previous definition is here
>>>>>>       #define __lwsync __builtin_ppc_lwsync
>>>>>>               ^
>>>>>>>> kernel/rcu/tree.c:2073:23: warning: stack frame size of 2704 bytes in function 'rcu_gp_kthread' [-Wframe-larger-than=]
>>>>>>       static int __noreturn rcu_gp_kthread(void *unused)
>>>>> Does -rcu commit 2f20de99a63b ("rcu: Make rcu_gp_cleanup() be noinline
>>>>> for tracing") help?
>>>> Hi Paul,
>>>>
>>>> The stack frame size decreased to 2256 bytes:
>>>>
>>>>     kernel/rcu/tree.c:2129:23: warning: stack frame size of 2256 bytes in
>>>> function 'rcu_gp_kthread' [-Wframe-larger-than=]
>>> Very good, thank you!  Does the following patch (in addition to that
>>> commit) also help?
>>
>> Hi Paul,
>>
>> I applied the below patch on commit 2f20de99a63b and the warning is gone.
> 
> Very good, and thank you for your testing.  I have applied the requested
> Reported-by and your Tested-by on the commit shown below.  Please let
> me know if you would prefer some other Reported/Tested setup.
> 
> 							Thanx, Paul
> 
> ------------------------------------------------------------------------
> 
> commit 336e92638287615d47c07af4ff6feb397cfe2084
> Author: Paul E. McKenney <paulmck@kernel.org>
> Date:   Mon Jun 7 21:57:02 2021 -0700
> 
>      rcu: Make rcu_gp_init() and rcu_gp_fqs_loop noinline to conserve stack
>      
>      The kbuild test project found an oversized stack frame in rcu_gp_kthread()
>      for some kernel configurations.  This oversizing was due to a very large
>      amount of inlining, which is unnecessary due to the fact that this code
>      executes infrequently.  This commit therefore marks rcu_gp_init() and
>      rcu_gp_fqs_loop noinline to conserve stack space.
>      
>      Reported-by: kernel test robot <lkp@intel.com>
>      Tested-by: Rong Chen <rong.a.chen@intel.com>
>      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
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

Small comment if it is not too late. noinline_for_stack expands to the 
same thing but is self documenting :) that way people do not have to git 
blame to see why these are marked as noinline (not that too many people 
are probably touching this but still).

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
> 

Cheers,
Nathan
