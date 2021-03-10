Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D922D33401F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 15:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232986AbhCJOPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 09:15:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbhCJOPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 09:15:05 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26941C061760
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:15:05 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id t29so12021980pfg.11
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 06:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8VRAirfevKmUWNCrs14aatYK1Jqu0K30gv7JJNtCMro=;
        b=tEJQ3VnKAD4WGlA/T4R2UaiQZXE89wl366FVuI8/sG3HDPzrjlB8lvT6JEp4zGr1Wp
         1dFPMFQ6TzYcMw3o3EwK4Tqg/wyQ0SLOeSvTm44aigcSyb1+RsbL9tNhd8W6N20jS0zY
         TPc6TpOvW3f3XIZTluIQFAucv0XX9r/GII41/3vRhJbNCOqzX4M3DgmUKe6sShGnkYRD
         MbWO01JryYholDe2CKapFJRRW+UYMNvc+WXogsIEbfx8mg7QnchJCvrLYTS4Pz9iXDsj
         nZ+w1TDyPF6jxcef3vDus/sK5vpkuttDDMTZE3Z4/vVbyvEWWn0TNF/o5VHpBSL/isIv
         848Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8VRAirfevKmUWNCrs14aatYK1Jqu0K30gv7JJNtCMro=;
        b=arPU2Sfg2nEukOVxo0WsD3BKIIBoqlAbGsbgM9ur+JFgWuMWTLcl4wifzHi9Xn8Ant
         IXg1yXyjcq6aGptVuQvjwDiLzPYUNXyAu3ZPraRVjVQV32550xqrhEi1SrzgqDdXp83l
         dwbq1cc9nhm6xjRJWeLo+M2t7ayykCZQrAzXBHdPIH6Largw2ni1hCZhHwNyi6J5Alt3
         0krZIYHLo+PKCp8cYYr2dnoLFABanE82eiotdtQai6aMQUILY9/BrNCRR2QUvqPEmzpl
         emYtPeXb1DdJLiFqc+8zeaM+fiRyZy61yvFPpPlbE019qU5y5xkrpW7zF5L2MPfOcrnC
         QcVw==
X-Gm-Message-State: AOAM531vRlmvzCxy6bxeuBsy15u8qrd5grcgOH8VBJGA+P33pV+DOT1C
        sYMu6aO3ZVhsn9JRvA3fkjcW
X-Google-Smtp-Source: ABdhPJx5WO2muywySjBRhugk0IwlGBiY0hVjSoEt/Bv1W4JEE1tJabz8HTSFhD+cR/8NPd+y6NFMJg==
X-Received: by 2002:a63:4504:: with SMTP id s4mr2984320pga.184.1615385704658;
        Wed, 10 Mar 2021 06:15:04 -0800 (PST)
Received: from thinkpad ([103.66.79.59])
        by smtp.gmail.com with ESMTPSA id 9sm16220155pgy.79.2021.03.10.06.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 06:15:04 -0800 (PST)
Date:   Wed, 10 Mar 2021 19:44:58 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        jhugo@codeaurora.org, linux-kernel@vger.kernel.org,
        carl.yin@quectel.com, naveen.kumar@quectel.com,
        loic.poulain@linaro.org
Subject: Re: [PATCH] bus: mhi: Make firmware image optional for controller
Message-ID: <20210310141458.GU30275@thinkpad>
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

Applied to mhi-next!

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
