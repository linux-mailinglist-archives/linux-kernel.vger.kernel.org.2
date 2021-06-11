Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FE3C3A4357
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 15:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhFKNwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 09:52:43 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:40834 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbhFKNwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 09:52:37 -0400
Received: by mail-io1-f47.google.com with SMTP id l64so9506509ioa.7
        for <linux-kernel@vger.kernel.org>; Fri, 11 Jun 2021 06:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cosmicpenguin-net.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=InTc7zVp8z/NGQD/JqXKMqqaeMO/59YVbb1foQ3kwds=;
        b=dugv4qACGBhXNZln5rZ+h/+f6h00hQGm0VbU9JbSOIS+lhwsUMm9Egq1DIlIUbTO/8
         8wZ5Cg0lsBD0UnewFkPoPTj3pHuWmuZ1cQM62CQjTI1j8ySlaEVcOiaE4rd/mhV+mOtl
         XQnn3NNElkyCvbZ6w4BTB4fYyheyPFwrrBG95WKcQj8+l5hfHRWGCtEzo5bpzxmh3qXq
         obdo+EB88Bp6AWY3973oJukVGuaL4gAs8url/dYQC1jS0nvTrzwsRzNWvpwCrpwCUpMd
         aPO3X3suMXUsPU3uoxju9n8b5rhb/+nQLmSCHu535ezyr3znPtF6PaGR7za/vaIoIszK
         by2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=InTc7zVp8z/NGQD/JqXKMqqaeMO/59YVbb1foQ3kwds=;
        b=IS7YiXohaXCYahxmcYH36mpDA/Pd0aeW4169BOjdwFQy7eeHNV69KFZwX6mfoquTO3
         5B1j1oEKRC0Ape8/Pd9v5pUF1qA+COTbPXNES8OVQ9vxdG581+BWNBVsAkILN0drvOYy
         O5W80uVi0aF8h6oKKF7CYHXoE47S2Yafzaf/2ZIXfv923qiqFTHjtOPbvNXZKcb8Zb7s
         ArOa0S3ufRsk3c1354FY0zyjX36JdY48egiLKSvIZgmnKxzYFwec7Rsi8Xk2Efgz2zQd
         GeClcJ07h9577ZWh38vlh3vYM1NSBjovRKwgCA+8ob3RKOvi7jIPHwHlkJnSS68xph7v
         E8TQ==
X-Gm-Message-State: AOAM533YTQ340fBOzD9RWGeU0EjinUZAYsPgcs4qZmOpHRXZNw/tGMet
        kJtIsjgxYEd6DOt5i3AKeNx8bA==
X-Google-Smtp-Source: ABdhPJz0hWqaVZyohn0Y19vurHp+kRglYW6LrsF8Q0tdyoom2aSA+rKV/RHevdUoULudZyroZafoJw==
X-Received: by 2002:a5d:8e06:: with SMTP id e6mr3389252iod.202.1623419363886;
        Fri, 11 Jun 2021 06:49:23 -0700 (PDT)
Received: from cosmicpenguin.net (c-71-237-100-236.hsd1.co.comcast.net. [71.237.100.236])
        by smtp.gmail.com with ESMTPSA id w25sm3341738iox.18.2021.06.11.06.49.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 06:49:23 -0700 (PDT)
Date:   Fri, 11 Jun 2021 07:49:21 -0600
From:   Jordan Crouse <jordan@cosmicpenguin.net>
To:     Rob Clark <robdclark@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        "moderated list:ARM SMMU DRIVERS" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 4/5] iommu/arm-smmu-qcom: Add stall support
Message-ID: <20210611134921.xjzcn4eso6fjzzte@cosmicpenguin.net>
Mail-Followup-To: Rob Clark <robdclark@gmail.com>,
        dri-devel@lists.freedesktop.org, iommu@lists.linux-foundation.org,
        freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        Rob Clark <robdclark@chromium.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Isaac J. Manjarres" <isaacm@codeaurora.org>,
        "moderated list:ARM SMMU DRIVERS" <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20210610214431.539029-1-robdclark@gmail.com>
 <20210610214431.539029-5-robdclark@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210610214431.539029-5-robdclark@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 10, 2021 at 02:44:12PM -0700, Rob Clark wrote:
> From: Rob Clark <robdclark@chromium.org>
> 
> Add, via the adreno-smmu-priv interface, a way for the GPU to request
> the SMMU to stall translation on faults, and then later resume the
> translation, either retrying or terminating the current translation.
> 
> This will be used on the GPU side to "freeze" the GPU while we snapshot
> useful state for devcoredump.
> 

Acked-by: Jordan Crouse <jordan@cosmicpenguin.net>

> Signed-off-by: Rob Clark <robdclark@chromium.org>
> ---
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 33 ++++++++++++++++++++++
>  include/linux/adreno-smmu-priv.h           |  7 +++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> index b2e31ea84128..61fc645c1325 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> @@ -13,6 +13,7 @@ struct qcom_smmu {
>  	struct arm_smmu_device smmu;
>  	bool bypass_quirk;
>  	u8 bypass_cbndx;
> +	u32 stall_enabled;
>  };
>  
>  static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
> @@ -23,12 +24,17 @@ static struct qcom_smmu *to_qcom_smmu(struct arm_smmu_device *smmu)
>  static void qcom_adreno_smmu_write_sctlr(struct arm_smmu_device *smmu, int idx,
>  		u32 reg)
>  {
> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu);
> +
>  	/*
>  	 * On the GPU device we want to process subsequent transactions after a
>  	 * fault to keep the GPU from hanging
>  	 */
>  	reg |= ARM_SMMU_SCTLR_HUPCF;
>  
> +	if (qsmmu->stall_enabled & BIT(idx))
> +		reg |= ARM_SMMU_SCTLR_CFCFG;
> +
>  	arm_smmu_cb_write(smmu, idx, ARM_SMMU_CB_SCTLR, reg);
>  }
>  
> @@ -48,6 +54,31 @@ static void qcom_adreno_smmu_get_fault_info(const void *cookie,
>  	info->contextidr = arm_smmu_cb_read(smmu, cfg->cbndx, ARM_SMMU_CB_CONTEXTIDR);
>  }
>  
> +static void qcom_adreno_smmu_set_stall(const void *cookie, bool enabled)
> +{
> +	struct arm_smmu_domain *smmu_domain = (void *)cookie;
> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +	struct qcom_smmu *qsmmu = to_qcom_smmu(smmu_domain->smmu);
> +
> +	if (enabled)
> +		qsmmu->stall_enabled |= BIT(cfg->cbndx);
> +	else
> +		qsmmu->stall_enabled &= ~BIT(cfg->cbndx);
> +}
> +
> +static void qcom_adreno_smmu_resume_translation(const void *cookie, bool terminate)
> +{
> +	struct arm_smmu_domain *smmu_domain = (void *)cookie;
> +	struct arm_smmu_cfg *cfg = &smmu_domain->cfg;
> +	struct arm_smmu_device *smmu = smmu_domain->smmu;
> +	u32 reg = 0;
> +
> +	if (terminate)
> +		reg |= ARM_SMMU_RESUME_TERMINATE;
> +
> +	arm_smmu_cb_write(smmu, cfg->cbndx, ARM_SMMU_CB_RESUME, reg);
> +}
> +
>  #define QCOM_ADRENO_SMMU_GPU_SID 0
>  
>  static bool qcom_adreno_smmu_is_gpu_device(struct device *dev)
> @@ -173,6 +204,8 @@ static int qcom_adreno_smmu_init_context(struct arm_smmu_domain *smmu_domain,
>  	priv->get_ttbr1_cfg = qcom_adreno_smmu_get_ttbr1_cfg;
>  	priv->set_ttbr0_cfg = qcom_adreno_smmu_set_ttbr0_cfg;
>  	priv->get_fault_info = qcom_adreno_smmu_get_fault_info;
> +	priv->set_stall = qcom_adreno_smmu_set_stall;
> +	priv->resume_translation = qcom_adreno_smmu_resume_translation;
>  
>  	return 0;
>  }
> diff --git a/include/linux/adreno-smmu-priv.h b/include/linux/adreno-smmu-priv.h
> index 53fe32fb9214..c637e0997f6d 100644
> --- a/include/linux/adreno-smmu-priv.h
> +++ b/include/linux/adreno-smmu-priv.h
> @@ -45,6 +45,11 @@ struct adreno_smmu_fault_info {
>   *                 TTBR0 translation is enabled with the specified cfg
>   * @get_fault_info: Called by the GPU fault handler to get information about
>   *                  the fault
> + * @set_stall:     Configure whether stall on fault (CFCFG) is enabled.  Call
> + *                 before set_ttbr0_cfg().  If stalling on fault is enabled,
> + *                 the GPU driver must call resume_translation()
> + * @resume_translation: Resume translation after a fault
> + *
>   *
>   * The GPU driver (drm/msm) and adreno-smmu work together for controlling
>   * the GPU's SMMU instance.  This is by necessity, as the GPU is directly
> @@ -60,6 +65,8 @@ struct adreno_smmu_priv {
>      const struct io_pgtable_cfg *(*get_ttbr1_cfg)(const void *cookie);
>      int (*set_ttbr0_cfg)(const void *cookie, const struct io_pgtable_cfg *cfg);
>      void (*get_fault_info)(const void *cookie, struct adreno_smmu_fault_info *info);
> +    void (*set_stall)(const void *cookie, bool enabled);
> +    void (*resume_translation)(const void *cookie, bool terminate);
>  };
>  
>  #endif /* __ADRENO_SMMU_PRIV_H */
> -- 
> 2.31.1
> 
