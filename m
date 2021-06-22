Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04CC13AFAAC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 03:43:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbhFVBpp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 21:45:45 -0400
Received: from mga04.intel.com ([192.55.52.120]:51601 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229663AbhFVBpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 21:45:45 -0400
IronPort-SDR: D6GrgZUTWyVCHD88mDeUWcyy4ALzXjDCSW9NxuIA9dzBNJheG0hGKdUdggqQik1Vb3Y+LpTGkn
 OzhP6F286mIw==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="205139619"
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="205139619"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 18:43:30 -0700
IronPort-SDR: M4LbRyUdsW/Smz7CkhYeLlA+20dwSZf0+6/KL714AmSS6tp7QyRkZ22Sct6TByeFgSqneUMYEc
 pOLErqIA8qZA==
X-IronPort-AV: E=Sophos;i="5.83,290,1616482800"; 
   d="scan'208";a="486715732"
Received: from xsang-optiplex-9020.sh.intel.com (HELO xsang-OptiPlex-9020) ([10.239.159.41])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 18:43:25 -0700
Date:   Tue, 22 Jun 2021 09:59:37 +0800
From:   Oliver Sang <oliver.sang@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "Luck, Tony" <tony.luck@intel.com>,
        "Yu, Yu-cheng" <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Li, Aubrey" <aubrey.li@intel.com>,
        "Xing, Zhengjun" <zhengjun.xing@linux.intel.com>,
        "Tang, Feng" <feng.tang@intel.com>,
        "Liu, Yujie" <yujie.liu@intel.com>,
        "Si, Beibei" <beibei.si@intel.com>,
        "Li, Philip" <philip.li@intel.com>,
        "Du, Julie" <julie.du@intel.com>
Subject: Re: [patch V3 00/66] x86/fpu: Spring cleaning and PKRU sanitizing
Message-ID: <20210622015937.GB687@xsang-OptiPlex-9020>
References: <20210618141823.161158090@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210618141823.161158090@linutronix.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On Fri, Jun 18, 2021 at 10:18:23PM +0800, Thomas Gleixner wrote:
> The main parts of this series are:
> 
>   - Yet more bug fixes
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
> 
> It applies on top of
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
> 
> and is also available via git:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu

0-Day kernel CI tested this branch from performance view,
choosing some sub-tests from will-it-scale (detail as below), since we
thought if the branch has the impact of fpu ops, will-it-scale should be
able to catch it.
we also plan to add stress-ng for new round test.
could you suggest if any other suitable test suites? and what's the most
proper sub-tests in will-it-scale and stress-ng?

Test Summary
============
no obvious will-it-scale performance changes found so far

Test Environment
================
https://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git/log/?h=x86/fpu
* 0619677ee36c3 (tglx-devel/x86/fpu) x86/fpu/signal: Let xrstor handle the features to init   <----- the tip we tested
* a114fd9946c28 x86/fpu/signal: Handle #PF in the direct restore path
* 73e26fdd0cf1c x86/fpu: Return proper error codes from user access functions
...
* 63bf804bfa6b0 x86/fpu: Make init_fpstate correct with optimized XSAVE
* 6db8e02d5e932 x86/fpu: x86/fpu: Preserve supervisor states in sanitize_restored_user_xstate()
*   4fe93c2272dbb Merge branch 'x86/fpu' of ../tip into x86/fpu    <----- the base we compared
|\
| * b7c11876d24bd (tip/x86/fpu, peterz-queue/x86/fpu) selftests/x86: Test signal frame XSTATE header corruption handling

64bit kernel testing, upon below platform:
model: Cascade Lake
Intel(R) Xeon(R) Gold 6238M CPU @ 2.10GHz
nr_node: 2
nr_cpu: 88
memory: 128G


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



> 
> This is a follow up to V2 which can be found here:
> 
>      https://lore.kernel.org/r/20210614154408.673478623@linutronix.de
> 
> Changes vs. V2:
> 
>   - Fixed the testing fallout (Dave, Kan)
> 
>   - Fixed a few issues found by myself when going through the lot
>     with a fine comb, especially MXCSR handling
> 
>   - Drop the FNSAVE optimizations
> 
>   - Cleanup of signal restore
> 
>   - Addressed review comments, mostly comments and a hopefully better
>     naming scheme which now just uses the instruction names and
>     consolidates everything else on save/restore so it's close to the way
>     how the hardware works.
> 
>   - A few cleanups and simplifications on the way (mostly regset related).
> 
>   - Picked up tags
> 
> With the above I'm not intending to do any further surgery on that
> code at the moment, though there is still room for improvement which
> can and has to be worked on when new bits are added.
> 
> Thanks,
> 
>         tglx
> ---
>  arch/x86/events/intel/lbr.c          |    6
>  arch/x86/include/asm/fpu/internal.h  |  211 +++-------
>  arch/x86/include/asm/fpu/xstate.h    |   70 ++-
>  arch/x86/include/asm/pgtable.h       |   57 --
>  arch/x86/include/asm/pkeys.h         |    9
>  arch/x86/include/asm/pkru.h          |   62 +++
>  arch/x86/include/asm/processor.h     |    9
>  arch/x86/include/asm/special_insns.h |   14
>  arch/x86/kernel/cpu/common.c         |   34 -
>  arch/x86/kernel/fpu/core.c           |  276 +++++++------
>  arch/x86/kernel/fpu/init.c           |   15
>  arch/x86/kernel/fpu/regset.c         |  220 ++++++-----
>  arch/x86/kernel/fpu/signal.c         |  423 +++++++++------------
>  arch/x86/kernel/fpu/xstate.c         |  693 ++++++++++++++---------------------
>  arch/x86/kernel/process.c            |   22 -
>  arch/x86/kernel/process_64.c         |   28 +
>  arch/x86/kernel/traps.c              |    5
>  arch/x86/kvm/svm/sev.c               |    1
>  arch/x86/kvm/x86.c                   |   56 +-
>  arch/x86/mm/extable.c                |    2
>  arch/x86/mm/fault.c                  |    2
>  arch/x86/mm/pkeys.c                  |   22 -
>  include/linux/pkeys.h                |    4
>  23 files changed, 1060 insertions(+), 1181 deletions(-)
> 
> 
