Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED0B93B45AD
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 16:34:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231570AbhFYOhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 10:37:04 -0400
Received: from mga05.intel.com ([192.55.52.43]:58255 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229940AbhFYOhE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 10:37:04 -0400
IronPort-SDR: WvIW1mUM1AV+KapvOZeXbg3ssE3gO2CbubbJ8FVOljiFsV9pzHy5Ks3dJKMZCO0XMovNNil8TH
 OmIupHroUjQw==
X-IronPort-AV: E=McAfee;i="6200,9189,10026"; a="293313554"
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="293313554"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 07:34:43 -0700
IronPort-SDR: /owS6tI4rchNxOSFtxiJpJkmzQZSWf4kGmq8N9DMqvUZrma5ehP6Dm5BN30CdW1wCS6QzDC8Lc
 d/nuHfGftqSw==
X-IronPort-AV: E=Sophos;i="5.83,299,1616482800"; 
   d="scan'208";a="453831722"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2021 07:34:38 -0700
Date:   Fri, 25 Jun 2021 22:50:41 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Chang Seok Bae <chang.seok.bae@intel.com>,
        Megha Dey <megha.dey@linux.intel.com>, aubrey.li@intel.com,
        zhengjun.xing@linux.intel.com, feng.tang@intel.com,
        yujie.liu@intel.com, beibei.si@intel.com, philip.li@intel.com,
        julie.du@intel.com
Subject: Re: [patch V4 00/65] x86/fpu: Spring cleaning and PKRU sanitizing
Message-ID: <20210625145041.GA29722@xsang-OptiPlex-9020>
References: <20210623120127.327154589@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210623120127.327154589@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Wed, Jun 23, 2021 at 02:01:27PM +0200, Thomas Gleixner wrote:
> The main parts of this series are:
> 
>   - Simplification and removal/replacement of redundant and/or
>     overengineered code.
> 
>   - Name space cleanup as the existing names were just a permanent source
>     of confusion.
> 
>   - Clear seperation of user ABI and kernel internal state handling.
> 
>   - Removal of PKRU from being XSTATE managed in the kernel because PKRU
>     has to be eagerly restored on context switch and keeping it in sync
>     in the xstate buffer is just pointless overhead and fragile.
> 
>     The kernel still XSAVEs PKRU on context switch but the value in the
>     buffer is not longer used and never restored from the buffer.
> 
>     This still needs to be cleaned up, but the series is already 40+
>     patches large and the cleanup of this is not a functional problem.
> 
>     The functional issues of PKRU management are fully addressed with the
>     series as is.
> 
>   - Cleanup of fpu signal restore
> 
>     - Make the fast path self contained. Handle #PF directly and skip
>       the slow path on any other exception as that will just end up
>       with the same result that the frame is invalid. This allows
>       the compiler to optimize the slow path out for 64bit kernels
>       w/o ia32 emulation.
> 
>     - Reduce code duplication and unnecessary operations
> 
> It applies on top of
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
> 
> and is also available via git:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu

0-Day kernel CI tested this branch from performance view, choosing some sub-tests
from will-it-scale and stress-ng (detail as below)

Test Summary
============
no obvious performance changes found vs v5.13-rc7 so far

Test Environment
================
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/log/?h=x86/fpu
* a263e30a4f111 (tglx-devel/x86/fpu) x86/fpu/signal: Let xrstor handle the features to init
* cf917e53a97e9 x86/fpu/signal: Handle #PF in the direct restore path
* 7b269dff0be66 x86/fpu: Return proper error codes from user access functions
* d2d6be9e16386 x86/fpu/signal: Split out the direct restore code
...
* d3ca29fb9911f x86/fpu: Fix copy_xstate_to_kernel() gap handling
*   58a664af246e6 Merge branch 'x86/fpu' of ../tip into x86/fpu
|\
| * b7c11876d24bd (tip/x86/fpu, peterz-queue/x86/fpu) selftests/x86: Test signal frame XSTATE header corruption handling
...
* | 13311e74253fe (tag: v5.13-rc7


64bit kernel testing, upon below platforms:
(1)
model: Cascade Lake
Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz
nr_node: 2
nr_cpu: 88
memory: 128G
(2)
model: Ice Lake
nr_node: 2
nr_cpu: 96
memory: 256G


32bit kernel testing, upon below platform:
Intel(R) Core(TM) i7-3770K CPU @ 3.50GHz
model: Ivy Bridge
nr_node: 1
nr_cpu: 8
memory: 16G


tested below test suites:
will-it-scale-performance-context_switch1
will-it-scale-performance-page_fault1
will-it-scale-performance-poll1
will-it-scale-performance-pthread_mutex1
will-it-scale-performance-writeseek1

regarding stress-ng, either no gap or data is unstable on
64bit (1) platform

commit:                                                                                                          
  v5.13-rc7                                                                                                      
  a263e30a4f111e13a6c859102d1b319a79b072c0                                                                       
                                                                                                                 
       v5.13-rc7 a263e30a4f111e13a6c859102d1                                                                     
---------------- ---------------------------                                                                     
         %stddev     %change         %stddev
             \          |                \
 2.786e+08 ±  2%      -1.3%  2.751e+08        stress-ng.switch.ops
   4643776 ±  2%      -1.3%    4585061        stress-ng.switch.ops_per_sec
--
  25884344 ± 15%      +5.3%   27252860 ± 12%  stress-ng.nanosleep.ops
    431397 ± 15%      +5.3%     454204 ± 12%  stress-ng.nanosleep.ops_per_sec
--
  5.48e+09 ±  2%      +4.3%  5.713e+09 ±  3%  stress-ng.yield.ops
  91326562 ±  2%      +4.3%   95215138 ±  3%  stress-ng.yield.ops_per_sec
--
   6723205 ±  3%      -2.0%    6585690 ±  9%  stress-ng.tee.ops
    112049 ±  3%      -2.0%     109755 ±  9%  stress-ng.tee.ops_per_sec
--
   3078530            -0.2%    3072610        stress-ng.zombie.ops
     49390            -0.2%      49295        stress-ng.zombie.ops_per_sec
--
   2261601            -0.1%    2259339        stress-ng.cyclic.ops
     37693            -0.1%      37655        stress-ng.cyclic.ops_per_sec
--
 1.543e+09 ± 16%      +0.4%   1.55e+09 ± 19%  stress-ng.fifo.ops
  25721633 ± 16%      +0.4%   25831339 ± 19%  stress-ng.fifo.ops_per_sec
--
    192171            +0.6%     193383        stress-ng.clone.ops
      2998            +0.6%       3016        stress-ng.clone.ops_per_sec
--
  88703410            -0.5%   88257268        stress-ng.sleep.ops
   1470841            -0.5%    1463509        stress-ng.sleep.ops_per_sec
--
    401598            +0.1%     401990        stress-ng.netlink-proc.ops
      6692            +0.1%       6699        stress-ng.netlink-proc.ops_per_sec
--
 1.182e+08            +2.5%  1.212e+08        stress-ng.softlockup.ops
   1969636            +2.5%    2019730        stress-ng.softlockup.ops_per_sec
--
 1.866e+08            -0.2%  1.863e+08        stress-ng.fanotify.ops
   4754116 ± 12%      -2.8%    4620280 ±  5%  stress-ng.fanotify.ops_per_sec
--
  17926280            -0.3%   17866738        stress-ng.vforkmany.ops
    286256            +0.4%     287262        stress-ng.vforkmany.ops_per_sec
--
 1.381e+09 ± 13%      +8.7%  1.501e+09 ± 19%  stress-ng.fifo.ops
  23013090 ± 13%      +8.7%   25020209 ± 19%  stress-ng.fifo.ops_per_sec
--
 1.165e+08 ±  2%      -2.0%  1.141e+08 ±  3%  stress-ng.splice.ops
   1941398 ±  2%      -2.0%    1901755 ±  3%  stress-ng.splice.ops_per_sec
--
   5476091            -0.2%    5466962        stress-ng.vfork.ops
     91262            -0.2%      91116        stress-ng.vfork.ops_per_sec
--
  21878786            -1.4%   21574984        stress-ng.netlink-task.ops
    364646            -1.4%     359582        stress-ng.netlink-task.ops_per_sec
--
   5023286            +1.6%    5101458        stress-ng.pthread.ops
     83554            +1.6%      84869        stress-ng.pthread.ops_per_sec
--
  92688395 ±  2%      -8.3%   84967931 ±  4%  stress-ng.futex.ops
   1544792 ±  2%      -8.3%    1416117 ±  4%  stress-ng.futex.ops_per_sec
--
   5416582 ±  2%      +1.6%    5504734 ±  5%  stress-ng.wait.ops
     90275 ±  2%      +1.6%      91744 ±  5%  stress-ng.wait.ops_per_sec
--
 7.939e+08 ±  4%      +0.7%  7.998e+08        stress-ng.mq.ops
  13231931 ±  4%      +0.7%   13329018        stress-ng.mq.ops_per_sec
--
 3.936e+08 ± 53%     +51.5%  5.965e+08 ± 37%  stress-ng.hrtimers.ops
   6416615 ± 52%     +49.8%    9609730 ± 38%  stress-ng.hrtimers.ops_per_sec
--
  35268682            -1.1%   34872339        stress-ng.sendfile.ops
    587805            -1.1%     581200        stress-ng.sendfile.ops_per_sec
--
  18126587            -0.7%   18000304 ±  3%  stress-ng.sem-sysv.ops
    302108            -0.7%     300004 ±  3%  stress-ng.sem-sysv.ops_per_sec
--
 9.953e+08 ±  2%      -0.4%  9.912e+08        stress-ng.pipe.ops
  16589030 ±  2%      -0.4%   16519202        stress-ng.pipe.ops_per_sec
--
   1056000            +0.0%    1056000        stress-ng.schedpolicy.ops
     17599            +0.0%      17599        stress-ng.schedpolicy.ops_per_sec
--
 2.481e+09            +1.2%   2.51e+09        stress-ng.vm-splice.ops
  41349053            +1.2%   41828864        stress-ng.vm-splice.ops_per_sec
--
  56805932 ±  2%      +1.1%   57451245 ±  2%  stress-ng.eventfd.ops
    946751 ±  2%      +1.1%     957505 ±  2%  stress-ng.eventfd.ops_per_sec
--
      1605            -1.2%       1585 ±  2%  stress-ng.mmapfork.ops
     25.18 ±  4%      -0.8%      24.98 ±  4%  stress-ng.mmapfork.ops_per_sec
--
   2549139            +1.2%    2578537        stress-ng.fork.ops
     42485            +1.2%      42975        stress-ng.fork.ops_per_sec
--
  16582541 ±  3%     -10.8%   14792067 ± 21%  stress-ng.close.ops
    276357 ±  3%     -10.8%     246515 ± 21%  stress-ng.close.ops_per_sec
--
 1.847e+09            -1.3%  1.822e+09        stress-ng.pipeherd.ops
  30743202            -1.3%   30330538        stress-ng.pipeherd.ops_per_sec
--
   6780757 ±  2%      +4.3%    7070424        stress-ng.tee.ops
    113008 ±  2%      +4.3%     117835        stress-ng.tee.ops_per_sec
--
   3421466            +0.0%    3422853        stress-ng.dnotify.ops
     57024            +0.0%      57047        stress-ng.dnotify.ops_per_sec
--
    749895            -0.9%     742801        stress-ng.kill.ops
     12498            -0.9%      12379        stress-ng.kill.ops_per_sec
--
 3.761e+08            -2.5%  3.668e+08        stress-ng.msg.ops
   6266833            -2.5%    6112949        stress-ng.msg.ops_per_sec
--
   2258479            +0.1%    2260255        stress-ng.daemon.ops
     37641            +0.1%      37670        stress-ng.daemon.ops_per_sec
--
  40560445            -0.8%   40239283        stress-ng.affinity.ops
    668138            -1.6%     657142        stress-ng.affinity.ops_per_sec
--
     21230 ±  4%      -0.9%      21047 ±  2%  stress-ng.inotify.ops
    353.14 ±  4%      -0.9%     349.88 ±  2%  stress-ng.inotify.ops_per_sec
--
  23250444 ±  2%      +1.6%   23627954        stress-ng.fault.ops
    387495 ±  2%      +1.6%     393795        stress-ng.fault.ops_per_sec
--
  3.94e+08            -0.2%  3.933e+08        stress-ng.sem.ops
   6567438            -0.2%    6555371        stress-ng.sem.ops_per_sec
--
    698544            -0.0%     698480        stress-ng.session.ops
     11494            +0.0%      11495        stress-ng.session.ops_per_sec

> 
> This is a follow up to V3 which can be found here:
> 
>      https://lore.kernel.org/r/20210618141823.161158090@linutronix.de
> 
> Changes vs. V3:
> 
>   - Dropped the two bugfixes which are applied already and rebased on top
> 
>   - Addressed review comments (Andy, Boris)
> 
>     Patches: 13, 35, 36, 37, 46, 58, 62, 63
> 
>   - Fixed the math-emu fallout which I had stashed safely on the 32bit
>     testbox (Boris)
> 
>     Patch: 28
> 
>   - Picked up tags
> 
> Thanks to everyone for review, feedback and testing (various teams
> @Intel).
> 
> Note: I've not picked up any tested-by tags. It would be nice to have
> them on this hopefully final version.
> 
> Thanks,
> 
> 	tglx
> ---
>  arch/x86/events/intel/lbr.c          |    6 
>  arch/x86/include/asm/fpu/internal.h  |  202 ++++------
>  arch/x86/include/asm/fpu/xstate.h    |   78 +++-
>  arch/x86/include/asm/pgtable.h       |   57 ---
>  arch/x86/include/asm/pkeys.h         |    9 
>  arch/x86/include/asm/pkru.h          |   62 +++
>  arch/x86/include/asm/processor.h     |    9 
>  arch/x86/include/asm/special_insns.h |   14 
>  arch/x86/kernel/cpu/common.c         |   34 -
>  arch/x86/kernel/fpu/core.c           |  282 +++++++--------
>  arch/x86/kernel/fpu/init.c           |   15 
>  arch/x86/kernel/fpu/regset.c         |  223 ++++++------
>  arch/x86/kernel/fpu/signal.c         |  419 ++++++++++------------
>  arch/x86/kernel/fpu/xstate.c         |  645 +++++++++++++----------------------
>  arch/x86/kernel/process.c            |   22 +
>  arch/x86/kernel/process_64.c         |   28 +
>  arch/x86/kernel/traps.c              |    5 
>  arch/x86/kvm/svm/sev.c               |    1 
>  arch/x86/kvm/x86.c                   |   56 +--
>  arch/x86/math-emu/fpu_proto.h        |    2 
>  arch/x86/math-emu/load_store.c       |    2 
>  arch/x86/math-emu/reg_ld_str.c       |    2 
>  arch/x86/mm/extable.c                |    2 
>  arch/x86/mm/fault.c                  |    2 
>  arch/x86/mm/pkeys.c                  |   22 -
>  include/linux/pkeys.h                |    4 
>  26 files changed, 1037 insertions(+), 1166 deletions(-)
> 
> 
