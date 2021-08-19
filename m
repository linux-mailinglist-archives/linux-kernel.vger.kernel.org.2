Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9B193F1E95
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 19:02:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbhHSRDV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Aug 2021 13:03:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbhHSRDU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Aug 2021 13:03:20 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3E6C061575
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 10:02:44 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id y23so6478060pgi.7
        for <linux-kernel@vger.kernel.org>; Thu, 19 Aug 2021 10:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KqBAIDNf4KI+7R9PW3HCAEUqOqaD6fR6+WQBrUCULKY=;
        b=z1B8bUNPLeGGpwQpF0qQWSkYBEjy0CQu68bzOIHjPVxkyyhZ8q91NunSN6OqH54L+3
         jrRFZbIT0CveXy4/JBRSqFmySzUMqn7YVNV7UnZm92eEEkMUXJjrXoTlp2aKneS5PoIK
         74DH2fX200D4IKk+4W2/xPqDbstUr/pnt1/DbxnzUaZxY0MXcQD9GlbVnimTC9+SKcyL
         yVrX134NL0Dxtqz+yN0PR3poo8Dgu4z9tubmaL4RHZNSIKBRWeWrxPoJbUX9IO9IQvCd
         N5fUIRIbkKXFGIpNEjt0McT6b1nmJ6r6tsbfAe+xt3rpmuMtNYxvIrtxc8Hqp7Ayy80b
         KyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KqBAIDNf4KI+7R9PW3HCAEUqOqaD6fR6+WQBrUCULKY=;
        b=q1y0MT2cptSa4vgVN5kkvTnWqE0vnG1T3/ULy2ASiqO2lALnEXS22h8mW4Mb86nBsF
         0jxl9K/gGJ4yhQmpyI2ShuvqvhrBn9yoXNg9X/0AZ445+zBg6Hkt3v78Gn2KlTKwtfuS
         IdcuSYJRYy+KotnohLc8fDOmO6mxtY2lOpMZ9KcRdxnnEogqt8LcsDz96lQ3cKBWRuIn
         kreFC89K++fG6uHP7l+dNbuG2w7ypndJrC2PHH2jmjNqvjZUV3VdHXjNwz435UQ5w3Ul
         sOOU96XpJdUY++FLn36ki7ZX/GuTfd0gcelXEnVSlXLgYA4jQoznU7RU3/P9bylWF7Kl
         5gIQ==
X-Gm-Message-State: AOAM533PDqI+OHPZqfiSo8rG+lFBiUFuR57hsH1Hvkv8GAxFprZuwZPu
        jA1sGgGi/vVUm9VXw4bHWT+3
X-Google-Smtp-Source: ABdhPJwJ0L62mAbDbkIzAyBcjzYAZ+o/n2ZdJ9jL6vK35ZR2dH+I8t0dSIGs3m6OZuA+Z6yLmEXbVA==
X-Received: by 2002:a05:6a00:9a4:b0:3e2:f6d0:c926 with SMTP id u36-20020a056a0009a400b003e2f6d0c926mr8275781pfg.31.1629392563724;
        Thu, 19 Aug 2021 10:02:43 -0700 (PDT)
Received: from thinkpad ([2409:4072:6d9a:7958:19b:f47b:7b55:abc8])
        by smtp.gmail.com with ESMTPSA id d20sm3919702pfu.36.2021.08.19.10.02.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 10:02:43 -0700 (PDT)
Date:   Thu, 19 Aug 2021 22:32:37 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>
Cc:     linux-arm-msm@vger.kernel.org, hemantk@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        quic_jhugo@quicinc.com
Subject: Re: [PATCH v1 1/2] bus: mhi: core: Bail on writing register fields
 if read fails
Message-ID: <20210819170237.GE200135@thinkpad>
References: <1629330634-36465-1-git-send-email-bbhatt@codeaurora.org>
 <1629330634-36465-2-git-send-email-bbhatt@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1629330634-36465-2-git-send-email-bbhatt@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 04:50:33PM -0700, Bhaumik Bhatt wrote:
> Helper API to write register fields relies on successful reads
> of the register/address prior to the write. Bail out if a failure
> is seen when reading the register before the actual write is
> performed.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>

As spotted by the test bot, can you please update pm.c as well?

Thanks,
Mani

> ---
>  drivers/bus/mhi/core/boot.c     | 25 +++++++++++++++++--------
>  drivers/bus/mhi/core/init.c     | 24 ++++++++++++++++++------
>  drivers/bus/mhi/core/internal.h |  7 ++++---
>  drivers/bus/mhi/core/main.c     |  9 ++++++---
>  4 files changed, 45 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 0a97262..13eacda 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c
> @@ -19,8 +19,8 @@
>  #include "internal.h"
>  
>  /* Setup RDDM vector table for RDDM transfer and program RXVEC */
> -void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
> -		      struct image_info *img_info)
> +int mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
> +		     struct image_info *img_info)
>  {
>  	struct mhi_buf *mhi_buf = img_info->mhi_buf;
>  	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
> @@ -28,6 +28,7 @@ void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
>  	struct device *dev = &mhi_cntrl->mhi_dev->dev;
>  	u32 sequence_id;
>  	unsigned int i;
> +	int ret;
>  
>  	for (i = 0; i < img_info->entries - 1; i++, mhi_buf++, bhi_vec++) {
>  		bhi_vec->dma_addr = mhi_buf->dma_addr;
> @@ -45,12 +46,17 @@ void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
>  	mhi_write_reg(mhi_cntrl, base, BHIE_RXVECSIZE_OFFS, mhi_buf->len);
>  	sequence_id = MHI_RANDOM_U32_NONZERO(BHIE_RXVECSTATUS_SEQNUM_BMSK);
>  
> -	mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
> -			    BHIE_RXVECDB_SEQNUM_BMSK, BHIE_RXVECDB_SEQNUM_SHFT,
> -			    sequence_id);
> +	ret = mhi_write_reg_field(mhi_cntrl, base, BHIE_RXVECDB_OFFS,
> +				  BHIE_RXVECDB_SEQNUM_BMSK,
> +				  BHIE_RXVECDB_SEQNUM_SHFT, sequence_id);
> +	if (ret) {
> +		dev_err(dev, "Failed to write sequence ID for BHIE_RXVECDB\n");
> +		return ret;
> +	}
>  
>  	dev_dbg(dev, "Address: %p and len: 0x%zx sequence: %u\n",
>  		&mhi_buf->dma_addr, mhi_buf->len, sequence_id);
> +	return 0;
>  }
>  
>  /* Collect RDDM buffer during kernel panic */
> @@ -202,11 +208,14 @@ static int mhi_fw_load_bhie(struct mhi_controller *mhi_cntrl,
>  
>  	mhi_write_reg(mhi_cntrl, base, BHIE_TXVECSIZE_OFFS, mhi_buf->len);
>  
> -	mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
> -			    BHIE_TXVECDB_SEQNUM_BMSK, BHIE_TXVECDB_SEQNUM_SHFT,
> -			    sequence_id);
> +	ret = mhi_write_reg_field(mhi_cntrl, base, BHIE_TXVECDB_OFFS,
> +				  BHIE_TXVECDB_SEQNUM_BMSK,
> +				  BHIE_TXVECDB_SEQNUM_SHFT, sequence_id);
>  	read_unlock_bh(pm_lock);
>  
> +	if (ret)
> +		return ret;
> +
>  	/* Wait for the image download to complete */
>  	ret = wait_event_timeout(mhi_cntrl->state_event,
>  				 MHI_PM_IN_ERROR_STATE(mhi_cntrl->pm_state) ||
> diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
> index 5aaca6d..0917465 100644
> --- a/drivers/bus/mhi/core/init.c
> +++ b/drivers/bus/mhi/core/init.c
> @@ -544,10 +544,15 @@ int mhi_init_mmio(struct mhi_controller *mhi_cntrl)
>  	mhi_cntrl->mhi_cmd[PRIMARY_CMD_RING].ring.db_addr = base + CRDB_LOWER;
>  
>  	/* Write to MMIO registers */
> -	for (i = 0; reg_info[i].offset; i++)
> -		mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
> -				    reg_info[i].mask, reg_info[i].shift,
> -				    reg_info[i].val);
> +	for (i = 0; reg_info[i].offset; i++) {
> +		ret = mhi_write_reg_field(mhi_cntrl, base, reg_info[i].offset,
> +					  reg_info[i].mask, reg_info[i].shift,
> +					  reg_info[i].val);
> +		if (ret) {
> +			dev_err(dev, "Unable to write to MMIO registers");
> +			return ret;
> +		}
> +	}
>  
>  	return 0;
>  }
> @@ -1118,8 +1123,15 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>  		 */
>  		mhi_alloc_bhie_table(mhi_cntrl, &mhi_cntrl->rddm_image,
>  				     mhi_cntrl->rddm_size);
> -		if (mhi_cntrl->rddm_image)
> -			mhi_rddm_prepare(mhi_cntrl, mhi_cntrl->rddm_image);
> +		if (mhi_cntrl->rddm_image) {
> +			ret = mhi_rddm_prepare(mhi_cntrl,
> +					       mhi_cntrl->rddm_image);
> +			if (ret) {
> +				mhi_free_bhie_table(mhi_cntrl,
> +						    mhi_cntrl->rddm_image);
> +				goto error_reg_offset;
> +			}
> +		}
>  	}
>  
>  	mutex_unlock(&mhi_cntrl->pm_mutex);
> diff --git a/drivers/bus/mhi/core/internal.h b/drivers/bus/mhi/core/internal.h
> index 721739c..3d17ec3 100644
> --- a/drivers/bus/mhi/core/internal.h
> +++ b/drivers/bus/mhi/core/internal.h
> @@ -663,8 +663,9 @@ int __must_check mhi_poll_reg_field(struct mhi_controller *mhi_cntrl,
>  				    u32 shift, u32 val, u32 delayus);
>  void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
>  		   u32 offset, u32 val);
> -void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
> -			 u32 offset, u32 mask, u32 shift, u32 val);
> +int __must_check mhi_write_reg_field(struct mhi_controller *mhi_cntrl,
> +				     void __iomem *base, u32 offset,
> +				     u32 mask, u32 shift, u32 val);
>  void mhi_ring_er_db(struct mhi_event *mhi_event);
>  void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
>  		  dma_addr_t db_val);
> @@ -678,7 +679,7 @@ int mhi_init_dev_ctxt(struct mhi_controller *mhi_cntrl);
>  void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl);
>  int mhi_init_irq_setup(struct mhi_controller *mhi_cntrl);
>  void mhi_deinit_free_irq(struct mhi_controller *mhi_cntrl);
> -void mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
> +int mhi_rddm_prepare(struct mhi_controller *mhi_cntrl,
>  		      struct image_info *img_info);
>  void mhi_fw_load_handler(struct mhi_controller *mhi_cntrl);
>  int mhi_prepare_channel(struct mhi_controller *mhi_cntrl,
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index c01ec2f..902d854 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -66,19 +66,22 @@ void mhi_write_reg(struct mhi_controller *mhi_cntrl, void __iomem *base,
>  	mhi_cntrl->write_reg(mhi_cntrl, base + offset, val);
>  }
>  
> -void mhi_write_reg_field(struct mhi_controller *mhi_cntrl, void __iomem *base,
> -			 u32 offset, u32 mask, u32 shift, u32 val)
> +int __must_check mhi_write_reg_field(struct mhi_controller *mhi_cntrl,
> +				     void __iomem *base, u32 offset,
> +				     u32 mask, u32 shift, u32 val)
>  {
>  	int ret;
>  	u32 tmp;
>  
>  	ret = mhi_read_reg(mhi_cntrl, base, offset, &tmp);
>  	if (ret)
> -		return;
> +		return ret;
>  
>  	tmp &= ~mask;
>  	tmp |= (val << shift);
>  	mhi_write_reg(mhi_cntrl, base, offset, tmp);
> +
> +	return 0;
>  }
>  
>  void mhi_write_db(struct mhi_controller *mhi_cntrl, void __iomem *db_addr,
> -- 
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project
> 
