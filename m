Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2B413FF338
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 20:27:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346954AbhIBS2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 14:28:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:48714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235359AbhIBS2H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 14:28:07 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7AB1361041;
        Thu,  2 Sep 2021 18:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630607228;
        bh=CN6VfpJ6jbtvL+pY5FWJO2QEw5tgM1IquTBPB0VMzEA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=MEcpEUfQXpUnT9P3hNd5t02YjLiwygNAYmd6CRA2FvrrQn5ttZpcjHfv3qY/PU9cd
         byrno9FtcENKEA5MolJzLaL+IGlvgq5Bf6pvxH4Aaei44BfzAxsVo1qIvfMBabUCn3
         kteXahGBC+wRIS/EgK1z7R9jFX7U9eGYRzS7Gz5yThl3xIX0gDpR4pBQxhgi+NkNjL
         bdBrRDh/+OsKGZG5VmMbWg+tNGPJYocdTcbcXBZQuwEFksR4+A36JttuwkY3q0p1Ay
         25/K/7OcIWUqmZA3fYJzMCz14XbdD5EknIEMrbp5WLw+WDALIV/VcjhLvzEvNIKLQy
         OhDnqmsa+OqlA==
Subject: Re: kernel/sched/core.c:5854:20: warning: unused function
 'sched_core_cpu_deactivate'
To:     kernel test robot <lkp@intel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Josh Don <joshdon@google.com>
References: <202109030259.bGgH5Lv6-lkp@intel.com>
From:   Nathan Chancellor <nathan@kernel.org>
Message-ID: <ab74f0f3-a7ea-e525-0725-946b1c754df3@kernel.org>
Date:   Thu, 2 Sep 2021 11:27:06 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <202109030259.bGgH5Lv6-lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/2/2021 11:21 AM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   4a3bb4200a5958d76cc26ebe4db4257efa56812b
> commit: 3c474b3239f12fe0b00d7e82481f36a1f31e79ab sched: Fix Core-wide rq->lock for uninitialized CPUs
> date:   13 days ago
> config: mips-randconfig-r004-20210902 (attached as .config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c9948e9254fbb6ea00f66c7b4542311d21e060be)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install mips cross compiling tool for clang build
>          # apt-get install binutils-mips-linux-gnu
>          # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3c474b3239f12fe0b00d7e82481f36a1f31e79ab
>          git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>          git fetch --no-tags linus master
>          git checkout 3c474b3239f12fe0b00d7e82481f36a1f31e79ab
>          # save the attached .config to linux build tree
>          mkdir build_dir
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross O=build_dir ARCH=mips SHELL=/bin/bash kernel/sched/
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
>     kernel/sched/core.c:3272:20: warning: unused function 'rq_has_pinned_tasks'
>     static inline bool rq_has_pinned_tasks(struct rq
>     ^
>     kernel/sched/core.c:5123:20: warning: unused function 'sched_tick_start'
>     static inline void sched_tick_start(int cpu) { }
>     ^
>     kernel/sched/core.c:5124:20: warning: unused function 'sched_tick_stop'
>     static inline void sched_tick_stop(int cpu) { }
>     ^
>     kernel/sched/core.c:5853:20: warning: unused function 'sched_core_cpu_starting'
>     static inline void sched_core_cpu_starting(unsigned int cpu) {}
>     ^
>>> kernel/sched/core.c:5854:20: warning: unused function 'sched_core_cpu_deactivate'
>     static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
>     ^
>>> kernel/sched/core.c:5855:20: warning: unused function 'sched_core_cpu_dying'
>     static inline void sched_core_cpu_dying(unsigned int cpu) {}
>     ^
>     fatal error: error in backend: Nested variants found in inline asm string: ' .set push
>     .set noat
>     .set push
>     .set arch=r4000
>     .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/cmpxchg.h", .line = 163, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
>     1: ll $0, $2 # __cmpxchg_asm
>     bne $0, ${3:z}, 2f
>     .set pop
>     move $$1, ${4:z}
>     .set arch=r4000
>     sc $$1, $1
>     beqz $$1, 1b
>     .set pop
>     2: .if ( 0x00 ) != -1)) 0x00 ) != -1)) : ($( static struct ftrace_branch_data __attribute__((__aligned__(4))) __attribute__((__section__("_ftrace_branch"))) __if_trace = $( .func = __func__, .file = "arch/mips/include/asm/cmpxchg.h", .line = 163, $); 0x00 ) != -1)) : $))) ) && ( 0 ); .set push; .set mips64r2; .rept 1; sync 0x00; .endr; .set pop; .else; ; .endif
>     '
>     clang-14: error: clang frontend command failed with exit code 70 (use -v to see invocation)
>     clang version 14.0.0 (git://gitmirror/llvm_project c9948e9254fbb6ea00f66c7b4542311d21e060be)
>     Target: mipsel-unknown-linux
>     Thread model: posix
>     InstalledDir: /opt/cross/clang-c9948e9254/bin
>     clang-14: note: diagnostic msg:
>     Makefile arch include kernel mm nr_bisected scripts source usr
> 
> 
> vim +/sched_core_cpu_deactivate +5854 kernel/sched/core.c
> 
>    5852	
>    5853	static inline void sched_core_cpu_starting(unsigned int cpu) {}
>> 5854	static inline void sched_core_cpu_deactivate(unsigned int cpu) {}
>> 5855	static inline void sched_core_cpu_dying(unsigned int cpu) {}
>    5856	

Is there any way for the test robot to ignore -Wunused-function warnings 
for stub functions? Masahiro purposefully wanted these warnings shown 
for static inline functions after commit 6863f5643dd7 ("kbuild: allow 
Clang to find unused static inline functions for W=1 build") but the 
entire point of the stub functions is that there should be no warnings 
ever (even though I know this is a W=1 build but still...).

Cheers,
Nathan
