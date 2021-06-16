Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037043A8DDA
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 02:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbhFPAwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 20:52:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:19524 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhFPAwU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:52:20 -0400
IronPort-SDR: pU13mGTaG0+7/hOl5GZ4qAHHHIhRSfQrwWt5M5BFUxVwrVqFV2G9ej1ED5cTwgfy5NBY1hLTcv
 RVuky/k5fCJg==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="291725048"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="291725048"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 17:50:15 -0700
IronPort-SDR: H6vVoP9Ubu/wl6tmboav+OPis3i8aMqVNFelmghrAJ0rJGZ8pgLZEPs1vADrTjco6sx119oJmQ
 l2rhaAuWqplw==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="452153451"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.5.156]) ([10.212.5.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 17:50:15 -0700
Subject: Re: [patch V2 00/52] x86/fpu: Spring cleaning and PKRU sanitizing
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
References: <20210614154408.673478623@linutronix.de>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <962710ca-fc77-f2ce-290a-4656dc719b70@intel.com>
Date:   Tue, 15 Jun 2021 17:50:14 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614154408.673478623@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/2021 8:44 AM, Thomas Gleixner wrote:
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
> It applies on top of
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git master
> 
> and is also available via git:
> 
>    git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git x86/fpu
> 
> This is a follow up to V1 which can be found here:
> 
>       https://lore.kernel.org/r/20210611161523.508908024@linutronix.de
> 
> Changes vs. V1:
> 
>    - Fix the broken init_fpstate initialization
> 
>    - Make xstate copy to ptrace work correctly
> 
>    - Sanitize the regset functions more and get rid of
>      fpstate_sanitize_xstate().
> 
>    - Addressed review comments
> 
>    - Picked up tags
> 
> Thanks,
> 
> 	tglx
> ---
>   arch/x86/events/intel/lbr.c          |    6
>   arch/x86/include/asm/fpu/internal.h  |  179 +++-------
>   arch/x86/include/asm/fpu/xstate.h    |   70 ++-
>   arch/x86/include/asm/pgtable.h       |   57 ---
>   arch/x86/include/asm/pkeys.h         |    9
>   arch/x86/include/asm/pkru.h          |   62 +++
>   arch/x86/include/asm/processor.h     |    9
>   arch/x86/include/asm/special_insns.h |   14
>   arch/x86/kernel/cpu/common.c         |   29 -
>   arch/x86/kernel/fpu/core.c           |  242 +++++++++----
>   arch/x86/kernel/fpu/init.c           |    4
>   arch/x86/kernel/fpu/regset.c         |  177 ++++-----
>   arch/x86/kernel/fpu/signal.c         |   59 +--
>   arch/x86/kernel/fpu/xstate.c         |  620 ++++++++++++++---------------------
>   arch/x86/kernel/process.c            |   19 +
>   arch/x86/kernel/process_64.c         |   28 +
>   arch/x86/kvm/svm/sev.c               |    1
>   arch/x86/kvm/x86.c                   |   56 +--
>   arch/x86/mm/extable.c                |    2
>   arch/x86/mm/fault.c                  |    2
>   arch/x86/mm/pkeys.c                  |   22 -
>   include/linux/pkeys.h                |    4
>   22 files changed, 818 insertions(+), 853 deletions(-)
> 
> 

I applied shadow stack, IBT on top of this series, and ran routine 
tests.  All passed with one small change to patch #45 (see reply to that 
one).

Thanks,
Yu-cheng
