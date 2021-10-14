Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEB842DAA9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 15:42:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231639AbhJNNoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 09:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbhJNNoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 09:44:08 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E122FC061570
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 06:42:03 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id r19so26542303lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 14 Oct 2021 06:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2CXI/xEY/thPw45jl914tzVQCXxJgkaEiaihZoAS5NE=;
        b=JA9o2/acP9W4J3FcprsPhCKgkj/E2UWV2pDJVHkJ4lkrWNaeoh+JRjCZbki3h+3XPd
         DbXNtiBzwzSLL6Atqf4pFvF8umlMMAg93LCe7Z6PzewCP0XkOJIF4u+hVueTZIylzA9y
         jZLVpurJWuIR/uHVzy1uNGx4pMJGYu880UTbeCk/74vh4+jCHLft0YGpnO72PZg3VWhU
         cXsthfPZb25UyO6GhevPL6xzVlPMngF2KGH3AHGRajfDhOLon7WhB2RjjdNc0CQsL+tK
         eCEnIbSBobhJzE47zLXdWSXZG2Rkdgv7WJtJsnOWkBnWSmnnUfTKqLgIA4fAJ6QDmMcU
         CWGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2CXI/xEY/thPw45jl914tzVQCXxJgkaEiaihZoAS5NE=;
        b=ziFAjK3jUVH9fqJRWOUC6xyqkjU3Om8IzIsJ6yTGcYwYbRWKeaFawPLgXPrbHoFD4b
         dCykhjFVXkmjtI7a78SqZ3TaRa64O4+t/sZVLs/7CCrBWJ3joPJ0NXXGOIJSNW0NBsEk
         VU2rK/4EFquWAN6pvwJ4Z0IQslQMD3kAPrhwd9hyj1wX66Xm9KzwXf5WcsuDJZiADReY
         qfIoXBeaD2TEN40fKrK8NB1f2MV5uLN2/IRwbmY6+Jwg5/Mft4lWnpmo2Io77M9khOoI
         e9MNNUMv7DkYkSKFbh71oFzx4g6gguTOyy79oRHb20P80hAGUYKIF1DOs7jro08STxkY
         4A2g==
X-Gm-Message-State: AOAM5303fhldiYY2GnzA/imbWzY6LPHpIYJozzM79vlq7je6T9mAJrjP
        qZSICGzkr4xVN2R8G0JBCve8z1Qsl/kKMQ==
X-Google-Smtp-Source: ABdhPJwNNzCdzIL3xC+3e0+2YM3M3EDJLzSESCYU1w2R/ttjrblskkCcmL8BpX2Fc3Y174MuzJXojw==
X-Received: by 2002:ac2:5fea:: with SMTP id s10mr5299971lfg.652.1634218911792;
        Thu, 14 Oct 2021 06:41:51 -0700 (PDT)
Received: from [192.168.1.211] ([37.153.55.125])
        by smtp.gmail.com with ESMTPSA id i13sm231739lfb.45.2021.10.14.06.41.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Oct 2021 06:41:51 -0700 (PDT)
Subject: Re: [PATCH v2 06/11] drm/msm/disp/dpu1: Don't use DSC with mode_3d
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
References: <20211007070900.456044-1-vkoul@kernel.org>
 <20211007070900.456044-7-vkoul@kernel.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <11becace-7b44-6141-5a8b-1bd6d0673243@linaro.org>
Date:   Thu, 14 Oct 2021 16:41:50 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211007070900.456044-7-vkoul@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/10/2021 10:08, Vinod Koul wrote:
> We cannot enable mode_3d when we are using the DSC. So pass
> configuration to detect DSC is enabled and not enable mode_3d
> when we are using DSC
> 
> We add a helper dpu_encoder_helper_get_dsc_mode() to detect dsc
> enabled and pass this to .setup_intf_cfg()
> 
> Signed-off-by: Vinod Koul <vkoul@kernel.org>
> ---
> Changes since
> v1:
>   - Move this patch from 7 to 6
>   - Update the changelog
>   - Make dsc as int and store the DSC indices
> 
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h     | 11 +++++++++++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c |  2 ++
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c           |  5 +++--
>   drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h           |  2 ++
>   4 files changed, 18 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> index e7270eb6b84b..fca07ed03317 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys.h
> @@ -332,6 +332,17 @@ static inline enum dpu_3d_blend_mode dpu_encoder_helper_get_3d_blend_mode(
>   	return BLEND_3D_NONE;
>   }
>   
> +static inline bool dpu_encoder_helper_get_dsc_mode(struct dpu_encoder_phys *phys_enc)
> +{
> +	struct drm_encoder *drm_enc = phys_enc->parent;
> +	struct msm_drm_private *priv = drm_enc->dev->dev_private;
> +
> +	if (priv->dsc)
> +		return BIT(0) | BIT(1); /* Hardcoding for 2 DSC topology */

Please use defined values here rater than just BIT().

> +
> +	return 0;
> +}
> +
>   /**
>    * dpu_encoder_helper_split_config - split display configuration helper function
>    *	This helper function may be used by physical encoders to configure
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> index aa01698d6b25..8e5c0911734c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_cmd.c
> @@ -70,6 +70,8 @@ static void _dpu_encoder_phys_cmd_update_intf_cfg(
>   	intf_cfg.intf_mode_sel = DPU_CTL_MODE_SEL_CMD;
>   	intf_cfg.stream_sel = cmd_enc->stream_sel;
>   	intf_cfg.mode_3d = dpu_encoder_helper_get_3d_blend_mode(phys_enc);
> +	intf_cfg.dsc = dpu_encoder_helper_get_dsc_mode(phys_enc);
> +
>   	ctl->ops.setup_intf_cfg(ctl, &intf_cfg);
>   }
>   
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index 64740ddb983e..3c79bd9c2fe5 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -118,7 +118,7 @@ static u32 dpu_hw_ctl_get_pending_flush(struct dpu_hw_ctl *ctx)
>   	return ctx->pending_flush_mask;
>   }
>   
> -static inline void dpu_hw_ctl_trigger_flush_v1(struct dpu_hw_ctl *ctx)
> +static void dpu_hw_ctl_trigger_flush_v1(struct dpu_hw_ctl *ctx)
>   {
>   
>   	if (ctx->pending_flush_mask & BIT(MERGE_3D_IDX))
> @@ -519,7 +519,8 @@ static void dpu_hw_ctl_intf_cfg(struct dpu_hw_ctl *ctx,
>   
>   	intf_cfg |= (cfg->intf & 0xF) << 4;
>   
> -	if (cfg->mode_3d) {
> +	/* In DSC we can't set merge, so check for dsc too */
> +	if (cfg->mode_3d && !cfg->dsc) {

The more I think about this hunk, the more I'm unsure about it.
Downstream has the following topoligies defined:
  * @SDE_RM_TOPOLOGY_DUALPIPE_3DMERGE_DSC: 2 LM, 2 PP, 3DMux, 1 DSC, 1 
INTF/WB
  * @SDE_RM_TOPOLOGY_QUADPIPE_3DMERGE_DSC  4 LM, 4 PP, 3DMux, 3 DSC, 2 INTF

While the latter is not supported on sdm845, the former one should be 
(by the hardware). So in the driver I think we should make sure that 
mode_3d does not get set rather than disallowing it here.

>   		intf_cfg |= BIT(19);
>   		intf_cfg |= (cfg->mode_3d - 0x1) << 20;
>   	}
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> index 806c171e5df2..5dfac5994bd4 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.h
> @@ -39,6 +39,7 @@ struct dpu_hw_stage_cfg {
>    * @mode_3d:               3d mux configuration
>    * @merge_3d:              3d merge block used
>    * @intf_mode_sel:         Interface mode, cmd / vid
> + * @dsc:                   DSC BIT masks
>    * @stream_sel:            Stream selection for multi-stream interfaces
>    */
>   struct dpu_hw_intf_cfg {
> @@ -46,6 +47,7 @@ struct dpu_hw_intf_cfg {
>   	enum dpu_3d_blend_mode mode_3d;
>   	enum dpu_merge_3d merge_3d;
>   	enum dpu_ctl_mode_sel intf_mode_sel;
> +	unsigned int dsc;
>   	int stream_sel;
>   };
>   
> 


-- 
With best wishes
Dmitry
