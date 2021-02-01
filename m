Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C24DD30A7BA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 13:36:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbhBAMgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 07:36:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbhBAMgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 07:36:48 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A712C0613D6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 04:36:08 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id g15so10846050pjd.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 04:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=aubOLGUr38JbgOFBEsGBKw5otENSJyK21msYOAdprUo=;
        b=mLci0Qi20948hhLLaInBmW62ubOIpF9fL7qKXMFfTyeFnpOlsbYsl11mhUdnLt5H41
         opI/BhUu0NmskxVbtZN6B+URC4kcCa27Zj1dih5tG3nvufAV8byOvzr9bMZaSVO/8ezv
         MHedQ83Pg3QXFGmk0YfZKs4t1XX8L4kK0CmVq5XOyoKDWd/7OdEpMpxAyaxBIL1bvVUC
         drvC1O0q12vZSX4teqi6SPLFXV3SyF2Vu2GItdY802N3m/3ngEq9OtiF+/Mv72wt8Ykl
         nVBAzG++C4cfwEiz26b51bpX0i7CuRDn9AfejGnFF4xo/u42GO/fE2vGNIIopSUo5l/p
         rkrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=aubOLGUr38JbgOFBEsGBKw5otENSJyK21msYOAdprUo=;
        b=Eh9ZT/3Gma3rl+PawDFm+qztrvuddjZJooOe/XfRltNQ9ocxGjCx4ISd+C7nTm6qOr
         84+N1Les6KJ+E379xpJKmqfHp0InpFJHT8hwjOm6Udfjt0NlewjqsfsuUsf8j/5jwUcV
         wH99OBhq6vzwIQHUMGWMC7vow3vFRwITK2+yGtQ+wQ3qTF8AYNimQPdlyAl6u+CWZvIM
         ZSG//kHWEzdwMnb+5FojniCkX10pohj3j0KgnUf0Q4vP0pTPiUX358wwjlPM4CrEvWAN
         sWirU2qhUh+taWFgjrhlGwOq7Rdqat1LYMGGbY6/gt/1GYx4VQALJywX0t1tblG6ac4F
         O9kA==
X-Gm-Message-State: AOAM532hrXJBywLuSX1j3OBP3oqi2YqyutPUIYU9/mWhwD7UdqlHbxpX
        kWo5XfOWMzkNiwGMIS2K2sVo
X-Google-Smtp-Source: ABdhPJwEy3jT5OzO6ZIaXOaPhYxmEqRfzl1fLck4+1pJfPg329b18wKkZGACNJ7rHEa6I8+oFVtTvg==
X-Received: by 2002:a17:902:a710:b029:dc:3817:e7c2 with SMTP id w16-20020a170902a710b02900dc3817e7c2mr17320672plq.0.1612182967365;
        Mon, 01 Feb 2021 04:36:07 -0800 (PST)
Received: from thinkpad ([103.77.37.179])
        by smtp.gmail.com with ESMTPSA id h1sm18590849pgj.59.2021.02.01.04.36.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 04:36:06 -0800 (PST)
Date:   Mon, 1 Feb 2021 18:06:02 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     linux@armlinux.org.uk, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2] ARM: kernel: Fix interrupted SMC calls
Message-ID: <20210201123602.GD108653@thinkpad>
References: <20210118181040.51238-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210118181040.51238-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jan 18, 2021 at 11:40:40PM +0530, Manivannan Sadhasivam wrote:
> On Qualcomm ARM32 platforms, the SMC call can return before it has
> completed. If this occurs, the call can be restarted, but it requires
> using the returned session ID value from the interrupted SMC call.
> 
> The ARM32 SMCC code already has the provision to add platform specific
> quirks for things like this. So let's make use of it and add the
> Qualcomm specific quirk (ARM_SMCCC_QUIRK_QCOM_A6) used by the QCOM_SCM
> driver.
> 
> This change is similar to the below one added for ARM64 a while ago:
> commit 82bcd087029f ("firmware: qcom: scm: Fix interrupted SCM calls")
> 
> Without this change, the Qualcomm ARM32 platforms like SDX55 will return
> -EINVAL for SMC calls used for modem firmware loading and validation.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

A gentle ping on this patch!

Thanks,
Mani

> ---
> 
> Changes in v2:
> 
> * Preserved callee saved registers and used the registers r4, r5 which
>   are getting pushed onto the stack.
> 
>  arch/arm/kernel/asm-offsets.c |  3 +++
>  arch/arm/kernel/smccc-call.S  | 11 ++++++++++-
>  2 files changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
> index a1570c8bab25..2e2fa6fc2d4f 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -23,6 +23,7 @@
>  #include <asm/vdso_datapage.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <linux/kbuild.h>
> +#include <linux/arm-smccc.h>
>  #include "signal.h"
>  
>  /*
> @@ -147,6 +148,8 @@ int main(void)
>    DEFINE(SLEEP_SAVE_SP_PHYS,	offsetof(struct sleep_save_sp, save_ptr_stash_phys));
>    DEFINE(SLEEP_SAVE_SP_VIRT,	offsetof(struct sleep_save_sp, save_ptr_stash));
>  #endif
> +  DEFINE(ARM_SMCCC_QUIRK_ID_OFFS,	offsetof(struct arm_smccc_quirk, id));
> +  DEFINE(ARM_SMCCC_QUIRK_STATE_OFFS,	offsetof(struct arm_smccc_quirk, state));
>    BLANK();
>    DEFINE(DMA_BIDIRECTIONAL,	DMA_BIDIRECTIONAL);
>    DEFINE(DMA_TO_DEVICE,		DMA_TO_DEVICE);
> diff --git a/arch/arm/kernel/smccc-call.S b/arch/arm/kernel/smccc-call.S
> index 00664c78faca..931df62a7831 100644
> --- a/arch/arm/kernel/smccc-call.S
> +++ b/arch/arm/kernel/smccc-call.S
> @@ -3,7 +3,9 @@
>   * Copyright (c) 2015, Linaro Limited
>   */
>  #include <linux/linkage.h>
> +#include <linux/arm-smccc.h>
>  
> +#include <asm/asm-offsets.h>
>  #include <asm/opcodes-sec.h>
>  #include <asm/opcodes-virt.h>
>  #include <asm/unwind.h>
> @@ -27,7 +29,14 @@ UNWIND(	.fnstart)
>  UNWIND(	.save	{r4-r7})
>  	ldm	r12, {r4-r7}
>  	\instr
> -	pop	{r4-r7}
> +	ldr	r4, [sp, #36]
> +	cmp	r4, #0
> +	beq	1f			// No quirk structure
> +	ldr     r5, [r4, #ARM_SMCCC_QUIRK_ID_OFFS]
> +	cmp     r5, #ARM_SMCCC_QUIRK_QCOM_A6
> +	bne	1f			// No quirk present
> +	str	r6, [r4, #ARM_SMCCC_QUIRK_STATE_OFFS]
> +1:	pop	{r4-r7}
>  	ldr	r12, [sp, #(4 * 4)]
>  	stm	r12, {r0-r3}
>  	bx	lr
> -- 
> 2.25.1
> 
