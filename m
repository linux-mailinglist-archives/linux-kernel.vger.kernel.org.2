Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5EF63F1EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:03:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232039AbhHSRDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbhHSRDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:03:44 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7F31C061757
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 10:03:07 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id m26so6076889pff.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 10:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J4TZpk9abAOIRKhcZR3S8JjrqJEXcoiOGPcZGih+iXo=;
        b=auXwozIFqZIBkGrvjkaA9y+v4Lz6pmtuu0mTnZV4/46y3SWh4xYDQl9te429g52oiK
         WhLiZyb749FJhFUVlpM+wnjQX2mYvJ2Mh27lZR/bFPCPKlNqnSH3/xgvPVlDkdjB42KK
         oj0Z0CgSGSzftsBmSvSF1f7FPR0omfht3gs9tjxkaEVLnfJZwb58BwzzoIKnylXNzH4S
         sntWvT6TExk9rkYzlQaOq03QkFS0RL61T4gC7tmZUbIhjWXQeHPKUovZBU54PYLuLbIe
         fLlrzCwVDWizDP2XtwxpcFmmM8A53eNSFLD+BImXWB7wSkrOEeSjM2JgiSxlJwnJUeqn
         zpuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J4TZpk9abAOIRKhcZR3S8JjrqJEXcoiOGPcZGih+iXo=;
        b=NPsH9FwFPYgj0Jeo3GwHWIz7pdfkUGXUyZH/MUrOo0ZycGFbLLjLK49lbzcIaSDg1M
         e9/rS9iLq9U6bYhJV3zYcVwH2gtNua29JzfaNLEAMeizIWf87wchaQlw5SX8iVjXyHEA
         VbRxfNt1gOAylQiD8MQeczdCXQzrzTBlcH4qVkrs7WBYbsqsjiS9Kfepr53IGdLJX+es
         PBR6jlLNw7PG9Nyupd6Hljajgu1jteFjXa3h6HLwtglMHi+ibQroXkmfs83j4C0ZlmuK
         kfbVSZTy2TpSuRjIXDc0/dXBerhzf9Fc0Ch7p+mnGzu9+/OdfZtv8mwoDCUik/4+8DSa
         H8Yw==
X-Gm-Message-State: AOAM532NllNPLNAXAHLDnb7MUp+Crz+B2B+DJqtwu9kIYkN+szj6kZt9
        QSUoPgKVINwwGR430dbF+3sZ
X-Google-Smtp-Source: ABdhPJzxByJWQ3Gil5gsikf7ZATLGZajf5JLxBFsaCwWf//owO5gJ5pkkFlcGu7GAK2/rHUv4pAa+w==
X-Received: by 2002:a63:798f:: with SMTP id u137mr14739508pgc.321.1629392587346;
        Thu, 19 Aug 2021 10:03:07 -0700 (PDT)
Received: from thinkpad ([2409:4072:6d9a:7958:19b:f47b:7b55:abc8])
        by smtp.gmail.com with ESMTPSA id r8sm4640850pgp.30.2021.08.19.10.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:03:06 -0700 (PDT)
Date:   Thu, 19 Aug 2021 22:33:01 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        quic_jhugo@quicinc.com
Subject: Re: [PATCH v1 2/2] bus: mhi: core: Optimize and update MMIO register
 write method
Message-ID: <20210819170301.GF200135@thinkpad>
References: <1629330634-36465-1-git-send-email-bbhatt@codeaurora.org>
 <1629330634-36465-3-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629330634-36465-3-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 04:50:34PM -0700, Bhaumik Bhatt wrote:
> As of now, MMIO writes done after ready state transition use the
> mhi_write_reg_field() API even though the whole register is being
> written in most cases. Optimize this process by using mhi_write_reg()
> API instead for those writes and use the mhi_write_reg_field()
> API for MHI config registers only.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/init.c | 64 ++++++++++++++++++++++-----------------------
>  1 file changed, 31 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 0917465..e4be171 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -433,75 +433,65 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	struct {
>  		u32 offset;
> -		u32 mask;
> -		u32 shift;
>  		u32 val;
>  	} reg_info[] = {
>  		{
> -			CCABAP_HIGHER, U32_MAX, 0,
> +			CCABAP_HIGHER,
>  			upper_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
>  		},
>  		{
> -			CCABAP_LOWER, U32_MAX, 0,
> +			CCABAP_LOWER,
>  			lower_32_bits(mhi_cntrl->mhi_ctxt->chan_ctxt_addr),
>  		},
>  		{
> -			ECABAP_HIGHER, U32_MAX, 0,
> +			ECABAP_HIGHER,
>  			upper_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
>  		},
>  		{
> -			ECABAP_LOWER, U32_MAX, 0,
> +			ECABAP_LOWER,
>  			lower_32_bits(mhi_cntrl->mhi_ctxt->er_ctxt_addr),
>  		},
>  		{
> -			CRCBAP_HIGHER, U32_MAX, 0,
> +			CRCBAP_HIGHER,
>  			upper_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
>  		},
>  		{
> -			CRCBAP_LOWER, U32_MAX, 0,
> +			CRCBAP_LOWER,
>  			lower_32_bits(mhi_cntrl->mhi_ctxt->cmd_ctxt_addr),
>  		},
>  		{
> -			MHICFG, MHICFG_NER_MASK, MHICFG_NER_SHIFT,
> -			mhi_cntrl->total_ev_rings,
> -		},
> -		{
> -			MHICFG, MHICFG_NHWER_MASK, MHICFG_NHWER_SHIFT,
> -			mhi_cntrl->hw_ev_rings,
> -		},
> -		{
> -			MHICTRLBASE_HIGHER, U32_MAX, 0,
> +			MHICTRLBASE_HIGHER,
>  			upper_32_bits(mhi_cntrl->iova_start),
>  		},
>  		{
> -			MHICTRLBASE_LOWER, U32_MAX, 0,
> +			MHICTRLBASE_LOWER,
>  			lower_32_bits(mhi_cntrl->iova_start),
>  		},
>  		{
> -			MHIDATABASE_HIGHER, U32_MAX, 0,
> +			MHIDATABASE_HIGHER,
>  			upper_32_bits(mhi_cntrl->iova_start),
>  		},
>  		{
> -			MHIDATABASE_LOWER, U32_MAX, 0,
> +			MHIDATABASE_LOWER,
>  			lower_32_bits(mhi_cntrl->iova_start),
>  		},
>  		{
> -			MHICTRLLIMIT_HIGHER, U32_MAX, 0,
> +			MHICTRLLIMIT_HIGHER,
>  			upper_32_bits(mhi_cntrl->iova_stop),
>  		},
>  		{
> -			MHICTRLLIMIT_LOWER, U32_MAX, 0,
> +			MHICTRLLIMIT_LOWER,
>  			lower_32_bits(mhi_cntrl->iova_stop),
>  		},
>  		{
> -			MHIDATALIMIT_HIGHER, U32_MAX, 0,
> +			MHIDATALIMIT_HIGHER,
>  			upper_32_bits(mhi_cntrl->iova_stop),
>  		},
>  		{
> -			MHIDATALIMIT_LOWER, U32_MAX, 0,
> +			MHIDATALIMIT_LOWER,
>  			lower_32_bits(mhi_cntrl->iova_stop),
>  		},
> -		{ 0, 0, 0 }
> +		{0, 0}
>  	};
>  
>  	dev_dbg(dev, "Initializing MHI registers\n");
> @@ -544,14 +534,22 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>  	mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING].ring.db_addr = base + CRDB_LOWER;
>  
>  	/* Write to MMIO registers */
> -	for (i = 0; reg_info[i].offset; i++) {
> -		ret = mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
> -					  reg_info[i].mask, reg_info[i].shift,
> -					  reg_info[i].val);
> -		if (ret) {
> -			dev_err(dev, "Unable to write to MMIO registers");
> -			return ret;
> -		}
> +	for (i = 0; reg_info[i].offset; i++)
> +		mhi_write_reg(mhi_cntrl, base, reg_info[i].offset,
> +			      reg_info[i].val);
> +
> +	ret = mhi_write_reg_field(mhi_cntrl, base, MHICFG, MHICFG_NER_MASK,
> +				  MHICFG_NER_SHIFT, mhi_cntrl->total_ev_rings);
> +	if (ret) {
> +		dev_err(dev, "Unable to read MHICFG register\n");
> +		return ret;
> +	}
> +
> +	ret = mhi_write_reg_field(mhi_cntrl, base, MHICFG, MHICFG_NHWER_MASK,
> +				  MHICFG_NHWER_SHIFT, mhi_cntrl->hw_ev_rings);
> +	if (ret) {
> +		dev_err(dev, "Unable to read MHICFG register\n");
> +		return ret;
>  	}
>  
>  	return 0;
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
