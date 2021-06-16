Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2AEF3A8DDD
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 02:52:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231775AbhFPAyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 20:54:39 -0400
Received: from mga03.intel.com ([134.134.136.65]:16036 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230507AbhFPAyi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 20:54:38 -0400
IronPort-SDR: E/RxdiNnr9GWIYyYi2Dkywy7DaFJxpd7egGjJ8HT4MvYHjl9psvLaVE0PUCq5kDU4F4chFC/CC
 nMdYo1sMy3XA==
X-IronPort-AV: E=McAfee;i="6200,9189,10016"; a="206130665"
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="206130665"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 17:52:33 -0700
IronPort-SDR: 5ODhYNMSOO5iPrbRyknXuV4poigcgPtanE2G3rKPno2jxZqBBlk/hKrI9+14DfWUx9W+b5feUR
 VfkUAVE1VmIA==
X-IronPort-AV: E=Sophos;i="5.83,276,1616482800"; 
   d="scan'208";a="452154021"
Received: from yyu32-mobl1.amr.corp.intel.com (HELO [10.212.5.156]) ([10.212.5.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jun 2021 17:52:32 -0700
Subject: Re: [patch V2 45/52] x86/fpu: Dont restore PKRU in
 fpregs_restore_userspace()
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
 <20210614155358.277290739@linutronix.de>
From:   "Yu, Yu-cheng" <yu-cheng.yu@intel.com>
Message-ID: <89da2d23-7de8-8dee-5b6a-361b7ceeae8e@intel.com>
Date:   Tue, 15 Jun 2021 17:52:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210614155358.277290739@linutronix.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/2021 8:44 AM, Thomas Gleixner wrote:
> switch_to(), flush_thread() write the task's PKRU value eagerly so the PKRU
> value of current is always valid in the hardware.
> 
> That means there is no point in restoring PKRU on exit to user or when
> reactivating the task's FPU registers in the signal frame setup path.
> 
> This allows to remove all the xstate buffer updates with PKRU values once
> the PKRU state is stored in thread struct while a task is scheduled out.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/include/asm/fpu/internal.h |   12 +++++++++++-
>   arch/x86/include/asm/fpu/xstate.h   |   19 +++++++++++++++++++
>   arch/x86/kernel/fpu/core.c          |    2 +-
>   3 files changed, 31 insertions(+), 2 deletions(-)
> 
> --- a/arch/x86/include/asm/fpu/internal.h
> +++ b/arch/x86/include/asm/fpu/internal.h
> @@ -455,7 +455,17 @@ static inline void fpregs_restore_userre
>   		return;
>   
>   	if (!fpregs_state_valid(fpu, cpu)) {
> -		restore_fpregs_from_fpstate(&fpu->state);
> +		/*
> +		 * This restores _all_ xstate which has not been
> +		 * established yet.
> +		 *
> +		 * If PKRU is enabled, then the PKRU value is already
> +		 * correct because it was either set in switch_to() or in
> +		 * flush_thread(). So it is excluded because it might be
> +		 * not up to date in current->thread.fpu.xsave state.
> +		 */
> +		__restore_fpregs_from_fpstate(&fpu->state,
> +					      xfeatures_mask_restore_user());

This needs to be xfeatures_mask_restore_user() | 
xfeatures_mask_supervisor().

>   		fpregs_activate(fpu);
>   		fpu->last_cpu = cpu;
>   	}

[...]
