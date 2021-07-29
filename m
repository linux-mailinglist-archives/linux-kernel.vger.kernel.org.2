Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 733793DAD7C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 22:23:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232950AbhG2UXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 16:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbhG2UXt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 16:23:49 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4CFC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 13:23:45 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h11so9092171ljo.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 13:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=zItpp9hN+Ox0fGbxSWTqxYyC7gmKerkf7vHtH6r/daA=;
        b=Z3cIIrUEl5uj15iDeDNAaHFESBCGt6SWOh/H+5hV7w7VkRMlp2sDa/4VlZYdXy2CuN
         5TE/4VeEUfgCR3Cdz6VLyjUISYhLUtxXWdcC3e3uFMcC1A6lzwTUWDj/sz2Jl0oGz0Jl
         VdVcwn7mEAfcNElwn1S1DZxWoidpr2NgAQ77XkkdKwp9jOJ449K5ra634GW15dsJWIX0
         CuNCQdeIyPG+iJtX6odyueFw3XxyLzheatR7Xp6XM8ADzOQR32bZmLA9r4mWg6uBHn9E
         OOj0mQp3yWQq+Ew2z+1QZ0CnxHPzjssnPLnlceYcxOpwpHst1S1Lb3lhez4F042aarkg
         UcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zItpp9hN+Ox0fGbxSWTqxYyC7gmKerkf7vHtH6r/daA=;
        b=hJI9g+N3p0PiWyotDxBRlV+Hj4IjjUU0C5VT+fWKukvTMdm+u9/YzyLXwT56XWbJGx
         8gfgLJKxqso+JoHpA5+4pC2Krpri+ZHgkTx1irgtQBVeLgftKbZ2IMc4dRSw+ZRspCeT
         doPAy5Hos9JE/lQD7xUPReDLJ1rFQIuI1B+rF54/A17MwySPN+xnfYq0W/9SQWaoR0E8
         suLBeCi9NbFOG0ydeg5GUaQbNZueYmYZvdMleNkzOZQwuK1LyuqhZUGZJVrsOgtc/IRO
         Xcy6oD2lobzP0/heBWFCRk5IFAcaBMMAjeFnh8P4E25mVsdHnpq5VBBIWakYJSwRXXJO
         AYvw==
X-Gm-Message-State: AOAM531Fe54vjQrAi0vB/iPrRPSvNzJNgXJwMqdVPRGX3evnSsibcJJs
        RqZPWooTeNnql9HLAJ5TAVtbOA==
X-Google-Smtp-Source: ABdhPJyF6OVGokvPtT5sxy3b0J3+h3E84HoeOanc5G5G6wQkJWEMtOFnUSafEyqe3BF216Dx31Rm1A==
X-Received: by 2002:a2e:7602:: with SMTP id r2mr4066231ljc.33.1627590222430;
        Thu, 29 Jul 2021 13:23:42 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id p4sm228456ljg.2.2021.07.29.13.23.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Jul 2021 13:23:42 -0700 (PDT)
Subject: Re: [PATCH 04/11] drm/msm/disp/dpu1: Add DSC support in RM
To:     Vinod Koul <vkoul@kernel.org>, Rob Clark <robdclark@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonathan Marek <jonathan@marek.ca>,
        Abhinav Kumar <abhinavk@codeaurora.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        freedreno@lists.freedesktop.org
References: <20210715065203.709914-1-vkoul@kernel.org>
 <20210715065203.709914-5-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <c8e9b236-4438-c2b3-a9a3-80f1c1c517a9@linaro.org>
Date:   Thu, 29 Jul 2021 23:23:41 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210715065203.709914-5-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2021 09:51, Vinod Koul wrote:
> This add the bits in RM to enable the DSC blocks
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
>   drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h |  1 +
>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c  | 32 +++++++++++++++++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h  |  1 +
>   3 files changed, 34 insertions(+)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> index d6717d6672f7..d56c05146dfe 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_kms.h
> @@ -165,6 +165,7 @@ struct dpu_global_state {
>   	uint32_t ctl_to_enc_id[CTL_MAX - CTL_0];
>   	uint32_t intf_to_enc_id[INTF_MAX - INTF_0];
>   	uint32_t dspp_to_enc_id[DSPP_MAX - DSPP_0];
> +	uint32_t dsc_to_enc_id[DSC_MAX - DSC_0];
>   };
>   
>   struct dpu_global_state
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> index fd2d104f0a91..4da6d72b7996 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.c
> @@ -11,6 +11,7 @@
>   #include "dpu_hw_intf.h"
>   #include "dpu_hw_dspp.h"
>   #include "dpu_hw_merge3d.h"
> +#include "dpu_hw_dsc.h"
>   #include "dpu_encoder.h"
>   #include "dpu_trace.h"
>   
> @@ -75,6 +76,14 @@ int dpu_rm_destroy(struct dpu_rm *rm)
>   			dpu_hw_intf_destroy(hw);
>   		}
>   	}
> +	for (i = 0; i < ARRAY_SIZE(rm->dsc_blks); i++) {
> +		struct dpu_hw_dsc *hw;
> +
> +		if (rm->intf_blks[i]) {

rm->dsc_blks[i]

> +			hw = to_dpu_hw_dsc(rm->dsc_blks[i]);
> +			dpu_hw_dsc_destroy(hw);
> +		}
> +	}
>   
>   	return 0;
>   }
> @@ -221,6 +230,19 @@ int dpu_rm_init(struct dpu_rm *rm,
>   		rm->dspp_blks[dspp->id - DSPP_0] = &hw->base;
>   	}
>   
> +	for (i = 0; i < cat->dsc_count; i++) {
> +		struct dpu_hw_dsc *hw;
> +		const struct dpu_dsc_cfg *dsc = &cat->dsc[i];
> +
> +		hw = dpu_hw_dsc_init(dsc->id, mmio, cat);
> +		if (IS_ERR_OR_NULL(hw)) {
> +			rc = PTR_ERR(hw);
> +			DPU_ERROR("failed dsc object creation: err %d\n", rc);
> +			goto fail;
> +		}
> +		rm->dsc_blks[dsc->id - DSC_0] = &hw->base;
> +	}
> +
>   	return 0;
>   
>   fail:
> @@ -476,6 +498,9 @@ static int _dpu_rm_reserve_intf(
>   	}
>   
>   	global_state->intf_to_enc_id[idx] = enc_id;
> +
> +	global_state->dsc_to_enc_id[0] = enc_id;
> +	global_state->dsc_to_enc_id[1] = enc_id;

This is not correct. At least this should be guarded with an if, 
checking that DSC is requested. Also we'd need to check that DSC 0 and 1 
are not allocated.

>   	return 0;
>   }
>   
> @@ -567,6 +592,8 @@ void dpu_rm_release(struct dpu_global_state *global_state,
>   		ARRAY_SIZE(global_state->ctl_to_enc_id), enc->base.id);
>   	_dpu_rm_clear_mapping(global_state->intf_to_enc_id,
>   		ARRAY_SIZE(global_state->intf_to_enc_id), enc->base.id);
> +	_dpu_rm_clear_mapping(global_state->dsc_to_enc_id,
> +		ARRAY_SIZE(global_state->dsc_to_enc_id), enc->base.id);
>   }
>   
>   int dpu_rm_reserve(
> @@ -640,6 +667,11 @@ int dpu_rm_get_assigned_resources(struct dpu_rm *rm,
>   		hw_to_enc_id = global_state->dspp_to_enc_id;
>   		max_blks = ARRAY_SIZE(rm->dspp_blks);
>   		break;
> +	case DPU_HW_BLK_DSC:
> +		hw_blks = rm->dsc_blks;
> +		hw_to_enc_id = global_state->dsc_to_enc_id;
> +		max_blks = ARRAY_SIZE(rm->dsc_blks);
> +		break;
>   	default:
>   		DPU_ERROR("blk type %d not managed by rm\n", type);
>   		return 0;
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> index 1f12c8d5b8aa..278d2a510b80 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_rm.h
> @@ -30,6 +30,7 @@ struct dpu_rm {
>   	struct dpu_hw_blk *intf_blks[INTF_MAX - INTF_0];
>   	struct dpu_hw_blk *dspp_blks[DSPP_MAX - DSPP_0];
>   	struct dpu_hw_blk *merge_3d_blks[MERGE_3D_MAX - MERGE_3D_0];
> +	struct dpu_hw_blk *dsc_blks[DSC_MAX - DSC_0];
>   
>   	uint32_t lm_max_width;
>   };
> 


-- 
With best wishes
Dmitry
