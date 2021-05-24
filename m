Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80AEE38DFC9
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 05:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhEXDPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 23:15:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231896AbhEXDPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 23:15:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1D19661159;
        Mon, 24 May 2021 03:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621826019;
        bh=wKzkq3YoOloJxmhZRFM+gRxzm0ckJrSu6InMj1eT3wA=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=KVkhItDy4hMHsFlTBKnGwz0fd01vrOxS+4HOZCD3XsR8hcfpEl13eeIMq39H1fwHk
         Qia8lz8c3KT1B5a87DlO4i0CTCbz+51xsZJPhw6+OP6f5P5tYsKqnwnddX3d1QHm2X
         xLAnuceiOxKoqpheD8YQgB4B8j3NyUHZ0EKP0hUGLRJUL5rzmYVf4Pmi+6x7zFNs3i
         ZOuiLckfvX7ZOVoKzDIfVF+EbnLjUYWSWol/bNJeYhbntkCYWFMJZdfEria9D005zW
         ZJWCdaGdmxtkO+Ugi4yjShTqkbzpk+8D/HxdxQ/SaV5sxUzTFpbq9+9RPdNz+ZVkg4
         D2dtBksGCa4QA==
Subject: Re: [PATCH v5 28/28] x86/fpu/amx: Clear the AMX state when
 appropriate
To:     "Chang S. Bae" <chang.seok.bae@intel.com>, bp@suse.de,
        tglx@linutronix.de, mingo@kernel.org, x86@kernel.org
Cc:     len.brown@intel.com, dave.hansen@intel.com, jing2.liu@intel.com,
        ravi.v.shankar@intel.com, linux-kernel@vger.kernel.org
References: <20210523193259.26200-1-chang.seok.bae@intel.com>
 <20210523193259.26200-29-chang.seok.bae@intel.com>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <1980c78b-d51b-c186-9179-f3c72692ad8a@kernel.org>
Date:   Sun, 23 May 2021 20:13:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210523193259.26200-29-chang.seok.bae@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/21 12:32 PM, Chang S. Bae wrote:
> When AMX is enabled, and an AMX-task is saved, explicitly initialize the
> AMX state after the XSAVE.
> 
> This assures that the kernel will only request idle states with clean AMX
> state. In the case of the C6 idle state, this allows the hardware to get to
> a deeper power saving condition.
> 
> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Reviewed-by: Len Brown <len.brown@intel.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
> Changes from v4:
> * Added as a new patch. (Thomas Gleixner)
> ---
>  arch/x86/include/asm/special_insns.h | 6 ++++++
>  arch/x86/kernel/fpu/core.c           | 8 ++++++++
>  2 files changed, 14 insertions(+)
> 
> diff --git a/arch/x86/include/asm/special_insns.h b/arch/x86/include/asm/special_insns.h
> index 2acd6cb62328..f0ed063035eb 100644
> --- a/arch/x86/include/asm/special_insns.h
> +++ b/arch/x86/include/asm/special_insns.h
> @@ -306,6 +306,12 @@ static inline int enqcmds(void __iomem *dst, const void *src)
>  	return 0;
>  }
>  
> +static inline void tile_release(void)
> +{
> +	/* Instruction opcode for TILERELEASE; supported in binutils >= 2.36. */
> +	asm volatile(".byte 0xc4, 0xe2, 0x78, 0x49, 0xc0");
> +}
> +
>  #endif /* __KERNEL__ */
>  
>  #endif /* _ASM_X86_SPECIAL_INSNS_H */
> diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
> index cccfeafe81e5..53a5869078b8 100644
> --- a/arch/x86/kernel/fpu/core.c
> +++ b/arch/x86/kernel/fpu/core.c
> @@ -106,6 +106,14 @@ int copy_fpregs_to_fpstate(struct fpu *fpu)
>  		 */
>  		if (fpu->state->xsave.header.xfeatures & XFEATURE_MASK_AVX512)
>  			fpu->avx512_timestamp = jiffies;
> +
> +		/*
> +		 * Since the current task's state is safely in the XSAVE buffer, TILERELEASE
> +		 * the TILE registers to guarantee that dirty state will not interfere with the
> +		 * hardware's ability to enter the core C6 idle state.
> +		 */
> +		if (fpu->state_mask & XFEATURE_MASK_XTILE_DATA)
> +			tile_release();
>  		return 1;
>  	}
>  
> 

This looks wrong -- you should also invalidate the state.  And doing it
in the save path seems inefficient.

Can we do this just when going idle?

--Andy
