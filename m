Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 051913B0D45
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 20:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232629AbhFVS6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 14:58:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:50414 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230146AbhFVS6s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 14:58:48 -0400
IronPort-SDR: +HPSTLvYc+ib9cucg8igwtI+0opHBez6/eiotZZ0ss0Blxksu0LWmXEhNsDvg/AM4wOVpB5U61
 7JXUbvNc1xvg==
X-IronPort-AV: E=McAfee;i="6200,9189,10023"; a="228680950"
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="228680950"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 11:56:32 -0700
IronPort-SDR: hEhYUuZ3uflNZGVhO8COvCa5nt9rhyBUml8ltHiOsVRWrFwErddQ6j/elc5QSOl7coyQdssxfP
 pR2Zmg/LKxfw==
X-IronPort-AV: E=Sophos;i="5.83,292,1616482800"; 
   d="scan'208";a="444703154"
Received: from meghadey-mobl1.amr.corp.intel.com (HELO [10.251.74.37]) ([10.251.74.37])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2021 11:56:29 -0700
Subject: Re: [patch V3 00/66] x86/fpu: Spring cleaning and PKRU sanitizing
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210618141823.161158090@linutronix.de>
From:   "Dey, Megha" <megha.dey@linux.intel.com>
Message-ID: <d64f030b-2e04-8042-51cf-f7975925262b@linux.intel.com>
Date:   Wed, 23 Jun 2021 00:26:14 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210618141823.161158090@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

On 6/18/2021 7:48 PM, Thomas Gleixner wrote:
> The main parts of this series are:
> 
>    - Yet more bug fixes
> 
>    - Simplification and removal/replacement of redundant and/or
>      overengineered code.
> 
>    - Name space cleanup as the existing names were just a permanent source
>      of confusion.
> 
>    - Clear seperation of user ABI and kernel internal state handling.
> 
>    - Removal of PKRU from being XSTATE managed in the kernel because PKRU
>      has to be eagerly restored on context switch and keeping it in sync
>      in the xstate buffer is just pointless overhead and fragile.
> 
>      The kernel still XSAVEs PKRU on context switch but the value in the
>      buffer is not longer used and never restored from the buffer.
> 
>      This still needs to be cleaned up, but the series is already 40+
>      patches large and the cleanup of this is not a functional problem.
> 
>      The functional issues of PKRU management are fully addressed with the
>      series as is.
> 
>    - Cleanup of fpu signal restore
> 
>      - Make the fast path self contained. Handle #PF directly and skip
>        the slow path on any other exception as that will just end up
>        with the same result that the frame is invalid. This allows
>        the compiler to optimize the slow path out for 64bit kernels
>        w/o ia32 emulation.
> 
>      - Reduce code duplication and unnecessary operations
>        
> 
> It applies on top of
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
> 
> and is also available via git:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu
> 
> This is a follow up to V2 which can be found here:
> 
>       https://lore.kernel.org/r/20210614154408.673478623@linutronix.de

I tested the x86/fpu branch using both AVX2(intree) and AVX512(out of 
tree) crypto code.

I used the tcrypt test module in the kernel and ran the prime95 workload 
(which finds prime numbers using AVX2 or AVX512) as a background process 
to make sure that the AVX states don't get screwed up after we run the 
crypto in kernel.

I did not see any issues with this branch and all tcrypt tests run as 
expected. I tested using the SHA1/256, AES-CTR, AES-GCM, camelia and 
crc32t10diff crypto algorithms.

Thanks,
Megha

> 
> Changes vs. V2:
> 
>    - Fixed the testing fallout (Dave, Kan)
> 
>    - Fixed a few issues found by myself when going through the lot
>      with a fine comb, especially MXCSR handling
> 
>    - Drop the FNSAVE optimizations
> 
>    - Cleanup of signal restore
> 
>    - Addressed review comments, mostly comments and a hopefully better
>      naming scheme which now just uses the instruction names and
>      consolidates everything else on save/restore so it's close to the way
>      how the hardware works.
> 
>    - A few cleanups and simplifications on the way (mostly regset related).
> 
>    - Picked up tags
> 
> With the above I'm not intending to do any further surgery on that
> code at the moment, though there is still room for improvement which
> can and has to be worked on when new bits are added.
> 
> Thanks,
> 
> 	tglx
> ---
>   arch/x86/events/intel/lbr.c          |    6
>   arch/x86/include/asm/fpu/internal.h  |  211 +++-------
>   arch/x86/include/asm/fpu/xstate.h    |   70 ++-
>   arch/x86/include/asm/pgtable.h       |   57 --
>   arch/x86/include/asm/pkeys.h         |    9
>   arch/x86/include/asm/pkru.h          |   62 +++
>   arch/x86/include/asm/processor.h     |    9
>   arch/x86/include/asm/special_insns.h |   14
>   arch/x86/kernel/cpu/common.c         |   34 -
>   arch/x86/kernel/fpu/core.c           |  276 +++++++------
>   arch/x86/kernel/fpu/init.c           |   15
>   arch/x86/kernel/fpu/regset.c         |  220 ++++++-----
>   arch/x86/kernel/fpu/signal.c         |  423 +++++++++------------
>   arch/x86/kernel/fpu/xstate.c         |  693 ++++++++++++++---------------------
>   arch/x86/kernel/process.c            |   22 -
>   arch/x86/kernel/process_64.c         |   28 +
>   arch/x86/kernel/traps.c              |    5
>   arch/x86/kvm/svm/sev.c               |    1
>   arch/x86/kvm/x86.c                   |   56 +-
>   arch/x86/mm/extable.c                |    2
>   arch/x86/mm/fault.c                  |    2
>   arch/x86/mm/pkeys.c                  |   22 -
>   include/linux/pkeys.h                |    4
>   23 files changed, 1060 insertions(+), 1181 deletions(-)
> 
> 
