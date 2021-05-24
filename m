Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E111138DF95
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 05:09:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhEXDKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 23:10:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:58210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232200AbhEXDKl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 23:10:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A411261151;
        Mon, 24 May 2021 03:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621825754;
        bh=ctT3Pp3VdMz2xN/P8yl3Ml87iHNwfU+tatN/MfiCkZQ=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=C8DdV/93M7Aj+fiKzZ8Eq2kaPm2guPytAEtVzdxNwUHVhvR1wHKmcgQHZ9mHWlTPr
         pbLKDTO3D2tlHWr/nBbIcLmFleUwgfSRKmdNkd07dkpWaI9MG94PVK9vZuY7WqW9VI
         9KW4lpjg16O9kfQnTEgN+7Uj9yics4Up3CQHm64rkFkzG/LVrDrgbUKjArt/2uw1Wl
         P7Y2lzz6V77puhLiP4WYyc22CMMJzfXP7A2ujszWP/sCgzBPv/oeUyhqHikIi1PiJy
         6X0eVOz4V+5mZKtOWlBXGnyHCYKSXpb17bRQVWKxO909bI7mYSDco+2M92ndNZXxji
         c6/hMMElXftJw==
Subject: Re: [PATCH v5 21/28] x86/fpu/amx: Initialize child's AMX state
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        tglx@linutronix.de, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-22-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <8c8d91ae-5a3b-9523-725d-134840102df7@kernel.org>
Date:   Sun, 23 May 2021 20:09:13 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210523193259.26200-22-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/21 12:32 PM, Chang S. Bae wrote:
> Assure that a forked child starts AMX registers in the INIT-state.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes from v4:
> * Added as a new patch. This was missing on previous versions.
> ---
>  arch/x86/kernel/fpu/core.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index 016c3adebec3..cccfeafe81e5 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -285,6 +285,10 @@ int fpu__copy(struct task_struct *dst, struct task_struct *src)
>  
>  	fpregs_unlock();
>  
> +	/* AMX state is volatile, children do not inherit it. */
> +	if (xfeatures_mask_all & XFEATURE_MASK_XTILE)
> +		dst_fpu->state->xsave.header.xfeatures &= ~(XFEATURE_MASK_XTILE);
> +
>  	set_tsk_thread_flag(dst, TIF_NEED_FPU_LOAD);
>  
>  	trace_x86_fpu_copy_src(src_fpu);
> 

If we're going to start having different states with different
behaviors, let's make them real defines.

#define XFEATURE_MASK_CLEARED_ON_CLONE ...

--Andy
