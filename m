Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6447D3570F3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 17:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242871AbhDGPuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 11:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353821AbhDGPsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 11:48:53 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B829C061762;
        Wed,  7 Apr 2021 08:48:41 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id u11so6066126wrp.4;
        Wed, 07 Apr 2021 08:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hRBTxBbm6K/qIaEm5hFZJ+Neshbuuk8fIPNBgmcgXe8=;
        b=kZx+9vzw+6A/2ttOrDHDt3998Bex0Vx3JJwsal4I577bKyDWgajn9F0kdBa7gGOKk6
         b8dMuS+JxDthkiHq1i1KpDIR+sihTsyUB6ZlHUSMNv9ayJnt+DE1hzmhkZS+Swjko+mw
         ap+7HSb6OguwSyfDwi6CVn/ryJS+JIwcNVZ+FoLV4lw7p48p+QtlCVHeqlyMKL97ZwOB
         FucSLuqFZzzbGAMvcq7P6r2c2bQlqqsAxv3kNCx/KlBwGSKi4EUmP4lQKz20B99j9t6P
         Mn2j+pD/jyWctA3ddxwQVmUZfJagMmIGmHnNVMbtw7jjQxjNGJSkf1lpDVzK6p/jWP+B
         mFWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hRBTxBbm6K/qIaEm5hFZJ+Neshbuuk8fIPNBgmcgXe8=;
        b=GyrjwCPefFBgLQb65j8PthSMRNXoNZrh13Lfs2LgcMkcVKy2GIhM271m5HmzlDxfiL
         yR1RN4bZ4IWsDo1xYu5798cu+2egqn0gT/28wLvDgAe6trjzTaePFOwGWMAuQdv76yqX
         b9zB0J/YwZJM/wXAmiV6mqxGIXLxyeXDin0lBc3q+5auk83dcjEzXv/TNZMw0wixppy7
         0D5BMjWhFAVDOQgiSR775zhCMz4XX2Y7o2IandoASUMiI2UIGjPrYfbmtxmaaX2KO52U
         lybfgTfUoSGEHV/qbI9RJpMT+QKdKjpngOCtuRGZJo31GF4m0FyMWKbTYTuQtrL8WtAR
         S1Uw==
X-Gm-Message-State: AOAM531iufXXcZk7sWymWJ3PabFgT+YkuemM0hcemnF/NXUTuFCUO1qf
        vq7ZvSokrbt4TxkF4DvoPGexqNZf20XLZsM92tqI2KITUtbnfA==
X-Google-Smtp-Source: ABdhPJwmHo2CQ9i8r855a9TbwcQvBaUTnOL8pNbf2t/BWlCHY694vB9zK3M3P1rOnHnHFZnXFQ8xD/465c2pwrZ+f4s=
X-Received: by 2002:adf:e4c9:: with SMTP id v9mr5245940wrm.342.1617810519738;
 Wed, 07 Apr 2021 08:48:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210401030558.2301621-1-david.e.box@linux.intel.com> <20210401030558.2301621-9-david.e.box@linux.intel.com>
In-Reply-To: <20210401030558.2301621-9-david.e.box@linux.intel.com>
From:   Rajneesh Bhardwaj <irenic.rajneesh@gmail.com>
Date:   Wed, 7 Apr 2021 11:48:14 -0400
Message-ID: <CAE2upjT6X1cNvoX8HNFkGHP_aDA1t=JngHFPDUjQ1Y0teuErvQ@mail.gmail.com>
Subject: Re: [PATCH 8/9] platform/x86: intel_pmc_core: Add LTR registers for
 Tiger Lake
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com,
        gayatri.kammela@intel.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>

On Wed, Mar 31, 2021 at 11:06 PM David E. Box
<david.e.box@linux.intel.com> wrote:
>
> From: Gayatri Kammela <gayatri.kammela@intel.com>
>
> Just like Ice Lake, Tiger Lake uses Cannon Lake's LTR information
> and supports a few additional registers. Hence add the LTR registers
> specific to Tiger Lake to the cnp_ltr_show_map[].
>
> Also adjust the number of LTR IPs for Tiger Lake to the correct amount.
>
> Signed-off-by: Gayatri Kammela <gayatri.kammela@intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  drivers/platform/x86/intel_pmc_core.c | 2 ++
>  drivers/platform/x86/intel_pmc_core.h | 4 +++-
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/platform/x86/intel_pmc_core.c b/drivers/platform/x86/intel_pmc_core.c
> index 458c0056e7a1..9168062c927e 100644
> --- a/drivers/platform/x86/intel_pmc_core.c
> +++ b/drivers/platform/x86/intel_pmc_core.c
> @@ -383,6 +383,8 @@ static const struct pmc_bit_map cnp_ltr_show_map[] = {
>          * a list of core SoCs using this.
>          */
>         {"WIGIG",               ICL_PMC_LTR_WIGIG},
> +       {"THC0",                TGL_PMC_LTR_THC0},
> +       {"THC1",                TGL_PMC_LTR_THC1},
>         /* Below two cannot be used for LTR_IGNORE */
>         {"CURRENT_PLATFORM",    CNP_PMC_LTR_CUR_PLT},
>         {"AGGREGATED_SYSTEM",   CNP_PMC_LTR_CUR_ASLT},
> diff --git a/drivers/platform/x86/intel_pmc_core.h b/drivers/platform/x86/intel_pmc_core.h
> index f41f61aa7008..634130b589a2 100644
> --- a/drivers/platform/x86/intel_pmc_core.h
> +++ b/drivers/platform/x86/intel_pmc_core.h
> @@ -192,8 +192,10 @@ enum ppfear_regs {
>  #define ETR3_CLEAR_LPM_EVENTS_BIT              28
>  #define LPM_STS_LATCH_MODE_BIT                 31
>
> -#define TGL_NUM_IP_IGN_ALLOWED                 22
>  #define TGL_PMC_SLP_S0_RES_COUNTER_STEP                0x7A
> +#define TGL_PMC_LTR_THC0                       0x1C04
> +#define TGL_PMC_LTR_THC1                       0x1C08
> +#define TGL_NUM_IP_IGN_ALLOWED                 23
>  #define TGL_PMC_LPM_RES_COUNTER_STEP_X2                61      /* 30.5us * 2 */
>
>  /*
> --
> 2.25.1
>


-- 
Thanks,
Rajneesh
