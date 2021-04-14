Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3D6635EB16
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 04:47:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232714AbhDNCri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 22:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhDNCrg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 22:47:36 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3882C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:47:15 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id n140so19109064oig.9
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 19:47:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uODSff3t2JSJqxFmEXfapBv0QkFqQwxecfMeix/4Xhg=;
        b=P631JNgnQJKoJT8k6iHyWS7SzFFegwexZ5mGAB0sXUE72L34HvEEPtiui3W8wiF66n
         Jz2ToTYX9M7FP2i8S55NnkOKm1+dMPsDhmqiI1r5bpkqYDVPYs0owyzAsMue/jaSexiZ
         oxTpGenbTauS11vt8itGtCITFUclDK19hQcE7vbfhNxP1xfEf+oMCqtHB5I/ap+UNSYj
         6dbIHY3Vz7LCTi73Fvz3l7Nst75fUkFpglYJ6ic8qDYrdnemFLzVAMq3H3voe8ZQA5UX
         qXlBw64+l7aF37B3D5J98D3ekBK64uBltk3nQke/OwQQ1t79rMCXW/nLwpfQK5wKmbat
         tIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uODSff3t2JSJqxFmEXfapBv0QkFqQwxecfMeix/4Xhg=;
        b=E9PuZ7t95V3+biU9BS6cHKKWYU5ZAEzlsHGywZEgt2DHWIF1UuFPRmVIaSXVbfK++H
         /fX38tdgLbOT4/V2bN1TcC0aweFVmeMG5vtCmeyUTXXi60q7h4VTW8GP+5cy1pMVEYo/
         GVqxRKR/SYP+SfKJlifnayYhtvV39+rHN1hYjrAD/A5HDmyajGqr1kVENW5d1Vtgibqb
         PQ8AsuruQXAmUomWonfokJ8HaEQr2dQGPu04QJqvu5RXQ6vQDUGlA5s21x/4212Ki3JO
         oo99yuYPh54lnpBdL7DunhVkzrlnhxR9cUG9BIEjCKcxlX33xuVQfjdPfOWZ8PJ09zZ7
         i04Q==
X-Gm-Message-State: AOAM530Ws5fgPG1j1HIb4+6alEmpoWWqv1vXKyZXScJKeD5hPmkDkL5p
        43vVekhIfCRFBnmwux2jcTn4jA==
X-Google-Smtp-Source: ABdhPJyeMBwF8/BA758z0/LHS5xbw4Go//yuABYqrtdJI4syuogqUsBuF6MJaujiZAkbPIidsVRktQ==
X-Received: by 2002:aca:1312:: with SMTP id e18mr649250oii.153.1618368435099;
        Tue, 13 Apr 2021 19:47:15 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id b12sm3845680oti.17.2021.04.13.19.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 19:47:14 -0700 (PDT)
Date:   Tue, 13 Apr 2021 21:47:12 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     soc@kernel.org, linux@armlinux.org.uk, will@kernel.org,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3] ARM: kernel: Fix interrupted SMC calls
Message-ID: <20210414024712.GX1538589@yoga>
References: <20210326182237.47048-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326182237.47048-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 26 Mar 13:22 CDT 2021, Manivannan Sadhasivam wrote:

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

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

Regards,
Bjorn

> ---
> 
> Changes in v3:
> 
> * Rebased on top of v5.12-rc2
> * Sent to SoC list since there was no review so far apart from initial one
>   by Russel
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
> index be8050b0c3df..70993af22d80 100644
> --- a/arch/arm/kernel/asm-offsets.c
> +++ b/arch/arm/kernel/asm-offsets.c
> @@ -24,6 +24,7 @@
>  #include <asm/vdso_datapage.h>
>  #include <asm/hardware/cache-l2x0.h>
>  #include <linux/kbuild.h>
> +#include <linux/arm-smccc.h>
>  #include "signal.h"
>  
>  /*
> @@ -148,6 +149,8 @@ int main(void)
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
