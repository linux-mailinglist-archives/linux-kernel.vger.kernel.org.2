Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3FF935A3D1
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 18:45:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbhDIQpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 12:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234091AbhDIQpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 12:45:16 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E0BBC061762
        for <linux-kernel@vger.kernel.org>; Fri,  9 Apr 2021 09:45:03 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id 25so4910790oiy.5
        for <linux-kernel@vger.kernel.org>; Fri, 09 Apr 2021 09:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CKkD5ja3i0VRl2clV2HLjrNV7Tgym2/sv1PGcuAD7+I=;
        b=odEnotfq2hnesbxmtPahx2uLcv8BIrDFKsr0aDCT2pqeP3nqMtLhpQnYQ205dZwD1p
         vVLN9Ge8gahDz0BBgBbzutPLUAS2ItjoT5E2iQGpFO4UrGjq/PhUplQZtDaqqjA2Ww/S
         qKY4kJRo0jjSszlSSGe1cfPkkMjFPY4ELnScCBTNnhsLDF2+G+vJbEiM7/1iLlQa3wFX
         rPWfGo6OiS4bM5lHOY/ipH8CSUAdiokSotgKk9WdR6DYFuBDBjqgVrAIxiiz5O1D0SY0
         R/FpQlId0nwbvbfMrsE6fXNWxyToACIE1QwymrHgoH/rtj3zhXRw0YX0bpr2ffdchKyw
         cBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CKkD5ja3i0VRl2clV2HLjrNV7Tgym2/sv1PGcuAD7+I=;
        b=lj13S/KsFfZ/AlsWfKZrgITAyGxZbByyKtWbaJ0RbcP2zZ0Vc5PrnuabJLfSYjK7pX
         CLgaEppzH6nKg7R0TC/wKDgUwrHz4fSUT2n+jJRhVy2TXRyszYq73ORBUKpnXcjE0Ywq
         qfqj7WLnpuoTwKAdINGdz7+dsSyvYKvrWw8ufzxKC4S9lqqQsp/HCyQF89Gp/6mECQkA
         dKgeFgIx9YcLmBd5zBROkesWsoEiI/Ee8ec1wbRs7CoeqKOe6Q3B2MIeNB3/2vh6Ec9x
         4YN9KlhBqHrGQmcIuEKebZtPbPv9cFYMVNWEQWmDUsaop1j7W0TMITEwLqMRX/NkQPLg
         4p7w==
X-Gm-Message-State: AOAM530XK0L0G/ljzW2acqM0EXgvEGpklrRC+wreemlv3z/4HcEFt8Jg
        hizdGIHTHHo13LpVLC5BJncPX8iAazGeVg==
X-Google-Smtp-Source: ABdhPJxk5C8vF/PtCFFzfdry5a/FFH82hO4d+zyi3Awf63asygtfD/m6JpQTcThBmF5Xt6nMuw+mCw==
X-Received: by 2002:aca:c350:: with SMTP id t77mr224523oif.90.1617986702695;
        Fri, 09 Apr 2021 09:45:02 -0700 (PDT)
Received: from yoga (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id 3sm675633oti.30.2021.04.09.09.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Apr 2021 09:45:01 -0700 (PDT)
Date:   Fri, 9 Apr 2021 11:45:00 -0500
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Dikshita Agarwal <dikshita@codeaurora.org>
Cc:     linux-media@vger.kernel.org, stanimir.varbanov@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vgarodia@codeaurora.org, swboyd@chromium.org
Subject: Re: [PATCH v4] media: venus : hfi: add venus image info into smem
Message-ID: <20210409164500.GY904837@yoga>
References: <1617968779-28526-1-git-send-email-dikshita@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1617968779-28526-1-git-send-email-dikshita@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 09 Apr 06:46 CDT 2021, Dikshita Agarwal wrote:

> Fill fw version info into smem to be printed as part of
> soc info.
> 
> Signed-off-by: Dikshita Agarwal <dikshita@codeaurora.org>
> Reported-by: kernel test robot <lkp@intel.com>

Why/how did kernel test robot tell you that you should write the
firmware version in SMEM?

> 
> change since v3:
>  added dependency on QCOM_SMEM (Stephen)
> ---
>  drivers/media/platform/Kconfig               |  2 +-
>  drivers/media/platform/qcom/venus/hfi_msgs.c | 21 +++++++++++++++++++--
>  2 files changed, 20 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index fd1831e..9c75e88 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -543,7 +543,7 @@ config VIDEO_TI_VPE_DEBUG
>  
>  config VIDEO_QCOM_VENUS
>  	tristate "Qualcomm Venus V4L2 encoder/decoder driver"
> -	depends on VIDEO_DEV && VIDEO_V4L2
> +	depends on VIDEO_DEV && VIDEO_V4L2 && QCOM_SMEM
>  	depends on (ARCH_QCOM && IOMMU_DMA) || COMPILE_TEST
>  	select QCOM_MDT_LOADER if ARCH_QCOM
>  	select QCOM_SCM if ARCH_QCOM
> diff --git a/drivers/media/platform/qcom/venus/hfi_msgs.c b/drivers/media/platform/qcom/venus/hfi_msgs.c
> index 06a1908..74cfc4f 100644
> --- a/drivers/media/platform/qcom/venus/hfi_msgs.c
> +++ b/drivers/media/platform/qcom/venus/hfi_msgs.c
> @@ -6,6 +6,7 @@
>  #include <linux/hash.h>
>  #include <linux/list.h>
>  #include <linux/slab.h>
> +#include <linux/soc/qcom/smem.h>
>  #include <media/videobuf2-v4l2.h>
>  
>  #include "core.h"
> @@ -14,6 +15,10 @@
>  #include "hfi_msgs.h"
>  #include "hfi_parser.h"
>  
> +#define SMEM_IMG_VER_TBL 469
> +#define VER_STR_SZ	128
> +#define SMEM_IMG_OFFSET_VENUS (14 * 128)
> +
>  static void event_seq_changed(struct venus_core *core, struct venus_inst *inst,
>  			      struct hfi_msg_event_notify_pkt *pkt)
>  {
> @@ -239,15 +244,27 @@ static void
>  sys_get_prop_image_version(struct device *dev,
>  			   struct hfi_msg_sys_property_info_pkt *pkt)
>  {
> +	u8 *smem_tbl_ptr;
> +	u8 *img_ver;
>  	int req_bytes;
> +	size_t smem_blk_sz;
>  
>  	req_bytes = pkt->hdr.size - sizeof(*pkt);
>  
> -	if (req_bytes < 128 || !pkt->data[1] || pkt->num_properties > 1)
> +	if (req_bytes < VER_STR_SZ || !pkt->data[1] || pkt->num_properties > 1)
>  		/* bad packet */
>  		return;
>  
> -	dev_dbg(dev, VDBGL "F/W version: %s\n", (u8 *)&pkt->data[1]);
> +	img_ver = (u8 *)&pkt->data[1];
> +
> +	dev_dbg(dev, VDBGL "F/W version: %s\n", img_ver);
> +
> +	smem_tbl_ptr = qcom_smem_get(QCOM_SMEM_HOST_ANY,
> +		SMEM_IMG_VER_TBL, &smem_blk_sz);
> +	if (smem_tbl_ptr &&
> +	    smem_blk_sz >= SMEM_IMG_OFFSET_VENUS + VER_STR_SZ)
> +		memcpy(smem_tbl_ptr + SMEM_IMG_OFFSET_VENUS,
> +		       img_ver, VER_STR_SZ);

I think you should unwrap lines, the conditional isn't even more than 80
chars...

Apart from these nits I think the patch looks good.

Regards,
Bjorn

>  }
>  
>  static void hfi_sys_property_info(struct venus_core *core,
> -- 
> 2.7.4
> 
