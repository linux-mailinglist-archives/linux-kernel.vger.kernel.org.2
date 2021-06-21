Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D985D3AED3A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Jun 2021 18:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbhFUQR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 12:17:59 -0400
Received: from mga14.intel.com ([192.55.52.115]:43299 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230071AbhFUQR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 12:17:59 -0400
IronPort-SDR: bHVwbM05w78MWcTpKfl5TDfnjC5JG/E8PBmB/axl5ADqEV56Wfbp1ew+j2K/RYQLtWoTP6urpi
 bRPxYXYmxO9Q==
X-IronPort-AV: E=McAfee;i="6200,9189,10022"; a="206698547"
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="206698547"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 09:15:44 -0700
IronPort-SDR: 68XMMSd3evT7yCXErLke1L14KkHaV3zb5EaEDrijovCR98EF1PaUbKF8/QOFDVaoNia02UxXtH
 iZOCPDadUDag==
X-IronPort-AV: E=Sophos;i="5.83,289,1616482800"; 
   d="scan'208";a="480514839"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.209.157.87]) ([10.209.157.87])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2021 09:15:43 -0700
Subject: Re: [patch V3 00/66] x86/fpu: Spring cleaning and PKRU sanitizing
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>
References: <20210618141823.161158090@linutronix.de>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <4473dcbd-38fa-bc19-d665-673dfc763f8f@intel.com>
Date:   Mon, 21 Jun 2021 09:15:43 -0700
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

On 6/18/2021 7:18 AM, Thomas Gleixner wrote:
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

Run all my tests again, and all pass.

Thanks,
Yu-cheng

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
