Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36CF6334015
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:15:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhCJOOb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:14:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbhCJON6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:13:58 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD66C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:13:58 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id y67so12196074pfb.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IQ8NzWqzIwJ9jb0KP0ibknbRfcJhc5kNPf4DExKU+7M=;
        b=Pf/lPKwqN9Ovmrt9CuhnYMmMX42mRa2f0T2IKH6zYfE5xkSM1R+TjZsFRd/PejO7mf
         RT5niPghRydb3cDTeitupex3guJ9bx1bOHxuwZViDDHkaX5M0yo3sj+8b2a6XJkKwozM
         WNhkpRudL5ekZjHCUXmg6f9Ekexhj1QeJftm/SMk3n4Ahs+Tnkh5Hocg7RsBmP/kjvO3
         jJRwm/7t2qPaKSVt7plkKXe+/2Nt9rHyV465eTLf5vSKKwjQPIyAn1xyFrenAZV6a4XO
         8I47jwZX6bOH5EXCiHRlrehS2BxH0aETZJ6kNTIj9iLW9ss5c5hBdtbzMmAdgS/0jD5l
         /SIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IQ8NzWqzIwJ9jb0KP0ibknbRfcJhc5kNPf4DExKU+7M=;
        b=lRApFlY0iskESUv69/zr1ahTgzIJgzT0uSHDKTnbdavJNSdt+tQzGkHtUiiY2AP32P
         F6bRAvGfkEe0ni6ighsoVtoX3ROpNxn+bkkZfT6eE0JX7VoyrCnBxccBFdu8kULhoGjt
         xwKgbr/vyTUilysgYxkZwyY2sbuYUAhbzUZXX28q9dmjcIeVpv+jUWIpCEMX7xZECAKw
         gebAt4enP/fvHVvZy8pmuPD69wh+iYIsqs1VtfH9vHLri+dVb11pasmWbqLJdBfHUEwQ
         RzjTCgJteqLJ1vUbCijZImD7eW187Bc8iRWJE4/Oza8UbeYsP3Sf7xKcynU0nek1GIvi
         7Cjw==
X-Gm-Message-State: AOAM530vlCk4GRW3RTAvym8agrbAH2+exM/0DxX1F80n86qLcTxCPpU3
        gnCk+PLdXuoJMRqfvCR4Cco6
X-Google-Smtp-Source: ABdhPJwwIF/2qhpyibqh2XMSh3QESUmHFJ6QSvMsfzz5DmgDjxzSw8kTxAS0W+zMvWYnY4+nm4+z2Q==
X-Received: by 2002:a63:c80c:: with SMTP id z12mr2899793pgg.376.1615385638009;
        Wed, 10 Mar 2021 06:13:58 -0800 (PST)
Received: from thinkpad ([103.66.79.59])
        by smtp.gmail.com with ESMTPSA id j5sm16193078pgl.55.2021.03.10.06.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 06:13:57 -0800 (PST)
Date:   Wed, 10 Mar 2021 19:43:52 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org
Subject: Re: [PATCH] bus: mhi: Make firmware image optional for controller
Message-ID: <20210310141352.GT30275@thinkpad>
References: <1615315595-37750-1-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1615315595-37750-1-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 09, 2021 at 10:46:35AM -0800, Bhaumik Bhatt wrote:
> Some controllers can opt to not have MHI download a firmware
> image to have the device bootup and can find the device in a
> pass through execution environment, ready to go. Thus, MHI
> controllers for those devices do not need fw_image defined.
> Make it optional to accommodate different bootup modes.
> 
> Suggested-by: Loic Poulain <loic.poulain@linaro.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
>  include/linux/mhi.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/include/linux/mhi.h b/include/linux/mhi.h
> index 56c4c52..838a3c4 100644
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -296,7 +296,7 @@ struct mhi_controller_config {
>   * @wake_db: MHI WAKE doorbell register address
>   * @iova_start: IOMMU starting address for data (required)
>   * @iova_stop: IOMMU stop address for data (required)
> - * @fw_image: Firmware image name for normal booting (required)
> + * @fw_image: Firmware image name for normal booting (optional)
>   * @edl_image: Firmware image name for emergency download mode (optional)
>   * @rddm_size: RAM dump size that host should allocate for debugging purpose
>   * @sbl_size: SBL image size downloaded through BHIe (optional)
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
