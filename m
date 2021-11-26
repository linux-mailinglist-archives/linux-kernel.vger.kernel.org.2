Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B76F45E6B9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Nov 2021 05:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245314AbhKZELs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 23:11:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245042AbhKZEJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 23:09:47 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE717C09B1A1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 19:00:04 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id t4so6831796pgn.9
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 19:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Y8dE3AAJJgRb5p8JynRSYl6enUHHyhRzw4ija+nYQ/Y=;
        b=QugnDvL/d8W2utpSyo47BlwDdIdY7q/XkNAvACI21JYok1iFlqzv7umrdeMq2kx5E2
         vwxOdjD1SgzGNQeG2fSIAkYdSWSNbfz2beDEUB38iAT8eG2/7Z/w0C9InIC2g/ElygF0
         NUDhtV8q1e21AFM2VdgJm6cxt/8pvkB2xZKjHsrd9wAz2pbJhTFkvBAzHTNfeiR/Mkmh
         RS6UvxmRJE7f17SzkgBbnXNkePR1I/SZXjkhA6wJ+NgYXsz7t2PpdD6JUnPnjp+yDL93
         RnaM0lmAROYjWcfv1AQeAMX6dVY5Sm9bR8MyZHA31yywjjhvwODBJ4I08VCh4GWb3c/5
         Z9Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Y8dE3AAJJgRb5p8JynRSYl6enUHHyhRzw4ija+nYQ/Y=;
        b=EGfBl3FX1DyKA+RSh9nO2o4vTWtluQ+pXKWMyFGLWbi/ZweWAATR93J7VxDvot3wjR
         K+Hs7pS+ibNndglZeGugSpVZFGPUWAZaWWmDRygVU17aynH8ldqGjaoLFCADr1Bv2dk0
         2pGeAItUi8A/AfypuEAZzETzBk9l0kwrrXREq/nbDMDFp6/aO0izSUWKWHTh6cyOZkID
         3aPrCXE0aPSo9SvV3o/1zS750L9ZvdvD3EJHI/usW2JBzCLYO3RoS54Vw31O8K0uTG0/
         BJtCFfWWw38bDsMqFD+kD0T3wskpF6f3aJc3i3U1OBOOzpfWuEmD7xCjFp6aB7t9jq8B
         4LjA==
X-Gm-Message-State: AOAM531zMQkCCYHLW7tN2h7Pgc1rmm6QeXaGu+dl9SiGyv11zK8j+V/g
        KBYcPbJgP1oAGVLWfE2kPFHp
X-Google-Smtp-Source: ABdhPJzLNQOJ0uE2c2+Fr7+rVw5U/a8SMLvdYIKSDNToO2+W4uKb+RM2gx9UK+uQxpbrUtWmNIvMUQ==
X-Received: by 2002:a63:6f88:: with SMTP id k130mr19211144pgc.475.1637895604190;
        Thu, 25 Nov 2021 19:00:04 -0800 (PST)
Received: from thinkpad ([117.215.117.247])
        by smtp.gmail.com with ESMTPSA id q13sm5244520pfk.22.2021.11.25.19.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 19:00:03 -0800 (PST)
Date:   Fri, 26 Nov 2021 08:29:59 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <quic_bbhatt@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, quic_hemantk@quicinc.com,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        Bhaumik Bhatt <bbhatt@codeaurora.org>
Subject: Re: [PATCH] bus: mhi: core: Use macros for execution environment
 features
Message-ID: <20211126025959.GB5859@thinkpad>
References: <1636409978-31847-1-git-send-email-quic_bbhatt@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1636409978-31847-1-git-send-email-quic_bbhatt@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 08, 2021 at 02:19:38PM -0800, Bhaumik Bhatt wrote:
> From: Bhaumik Bhatt <bbhatt@codeaurora.org>
> 
> The implementation for execution environment specific functionality
> is spread out. Use macros that help determine the paths to be taken.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Applied to mhi-next!

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/boot.c     | 2 +-
>  drivers/bus/mhi/core/internal.h | 3 ++-
>  drivers/bus/mhi/core/pm.c       | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 0a97262..74295d3 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c
> @@ -417,7 +417,7 @@ void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl)
>  	}
>  
>  	/* wait for ready on pass through or any other execution environment */
> -	if (mhi_cntrl->ee != MHI_EE_EDL && mhi_cntrl->ee != MHI_EE_PBL)
> +	if (!MHI_FW_LOAD_CAPABLE(mhi_cntrl->ee))
>  		goto fw_load_ready_state;
>  
>  	fw_name = (mhi_cntrl->ee == MHI_EE_EDL) ?
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
> index 3a732af..9d72b1d1 100644
> --- a/drivers/bus/mhi/core/internal.h
> +++ b/drivers/bus/mhi/core/internal.h
> @@ -390,7 +390,8 @@ extern const char * const mhi_ee_str[MHI_EE_MAX];
>  
>  #define MHI_IN_PBL(ee) (ee == MHI_EE_PBL || ee == MHI_EE_PTHRU || \
>  			ee == MHI_EE_EDL)
> -
> +#define MHI_POWER_UP_CAPABLE(ee) (MHI_IN_PBL(ee) || ee == MHI_EE_AMSS)
> +#define MHI_FW_LOAD_CAPABLE(ee) (ee == MHI_EE_PBL || ee == MHI_EE_EDL)
>  #define MHI_IN_MISSION_MODE(ee) (ee == MHI_EE_AMSS || ee == MHI_EE_WFW || \
>  				 ee == MHI_EE_FP)
>  
> diff --git a/drivers/bus/mhi/core/pm.c b/drivers/bus/mhi/core/pm.c
> index fb99e37..0bb8d77 100644
> --- a/drivers/bus/mhi/core/pm.c
> +++ b/drivers/bus/mhi/core/pm.c
> @@ -1068,7 +1068,7 @@ int mhi_async_power_up(struct mhi_controller *mhi_cntrl)
>  	write_unlock_irq(&mhi_cntrl->pm_lock);
>  
>  	/* Confirm that the device is in valid exec env */
> -	if (!MHI_IN_PBL(current_ee) && current_ee != MHI_EE_AMSS) {
> +	if (!MHI_POWER_UP_CAPABLE(current_ee)) {
>  		dev_err(dev, "%s is not a valid EE for power on\n",
>  			TO_MHI_EXEC_STR(current_ee));
>  		ret = -EIO;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
