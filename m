Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D3043FD21
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 15:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhJ2NKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 09:10:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231551AbhJ2NKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 09:10:12 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC210C061745
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 06:07:43 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id gh1so6240397qvb.8
        for <linux-kernel@vger.kernel.org>; Fri, 29 Oct 2021 06:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RM/bmXapeBMh8+hpkmuvSolriwwEu8yH0p43JcPWCxk=;
        b=JbrJN6TZUsbo9JpQsvgIVP6KOjV8795JkEAt7GBb1EHJ1OA5nURuxMQ0K2v3Z6Vaj3
         MT1GY/SYopL87+NU20ZTwHkq8auoreegZImNaxJMuGAKvZtRBclj2VQKCcpoUeLzWtVC
         imI6YyBK5Hkpvi9BoWCu4eYU+YcigCHMY0KSLezdJrRxnRtSk2WYX5GaC+gX9/qYlPxb
         qRWqhEaZWwE5kp07fHg+z3Qe0q2LXf7L2cgDjLdbKqcmAOIV4NNCp7fffZ425HRtAPGG
         2KBecILyimsbz3joFdek1ayqQASemWcmzBwQSoegfJP6RSTyvYdYqNAv5hpYJbF8kWft
         CA5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RM/bmXapeBMh8+hpkmuvSolriwwEu8yH0p43JcPWCxk=;
        b=5oma2SBbVd8/AwPaLtdA7l1b+m+wZK9cJIoEUm0xWDncl8KyOTzN50QJCNBBIxNji9
         9Yb99ItyJPT2DsEj8zT4FPHHpcDQZaQ2hJfUcLbtU/+9tZQCknlCQ9YHm2ELj9ND9nSB
         NiW8ZrFwTMjH61+SUfjR9lZ6mT1xRPCYejW4Z7IPID0IH7xNt/NSoarX8yW7cwHZBCiT
         uNro9TU8Xv/uWlB40ufGqYA/AYnOVKAXZFvHdCPSLBBqHD6KddOD5NuEnFtbmsRmpFbJ
         JgleAgBZCHCYxMuLBLjJEwdEp4BFrMSiLDFTYi0xp0vE2EpF3ApTHPq+f37OtmT96lFP
         Obhw==
X-Gm-Message-State: AOAM530/8sT+g5OspNp9hYRnK12N2zpB5cOSIEYx7sFhMwIp39n60mIW
        trCRsbmhVpIksCWFXFWdTvz+dAdVV5L7icDCOkV3uol6NYI=
X-Google-Smtp-Source: ABdhPJycrVL9EM1WkDbofkgiWuRPwE5CFOGucVbQDvC5kPJcPytF2VCCGVy5aLeGKxsgBVw0+jTq+rUAmjM0VVg7ak8=
X-Received: by 2002:a05:6214:229:: with SMTP id j9mr10536899qvt.27.1635512863100;
 Fri, 29 Oct 2021 06:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <1635510619-6715-1-git-send-email-quic_kalyant@quicinc.com>
In-Reply-To: <1635510619-6715-1-git-send-email-quic_kalyant@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Fri, 29 Oct 2021 16:07:32 +0300
Message-ID: <CAA8EJppXBC43=bWigTwQ-QkMsDVf829LRXokEBKcWJdHOoOezQ@mail.gmail.com>
Subject: Re: [v2] drm/msm/disp/dpu1: set default group ID for CTL.
To:     Kalyan Thota <quic_kalyant@quicinc.com>
Cc:     y@qualcomm.com,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <dri-devel@lists.freedesktop.org>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>,
        freedreno <freedreno@lists.freedesktop.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Krishna Manikandan <mkrishn@codeaurora.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Abhinav Kumar <abhinavk@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Oct 2021 at 15:30, Kalyan Thota <quic_kalyant@quicinc.com> wrote:
>
> New required programming in CTL for SC7280. Group ID informs
> HW of which VM owns that CTL. Force this group ID to
> default/disabled until virtualization support is enabled in SW.
>
> Changes in v1:
>  - Fix documentation and add descritpion for the change (Stephen)
>
> Signed-off-by: Kalyan Thota <quic_kalyant@quicinc.com>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c | 2 +-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h | 5 ++++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c     | 8 ++++++++
>  3 files changed, 13 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> index ce6f32a..283605c 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c
> @@ -45,7 +45,7 @@
>         (PINGPONG_SDM845_MASK | BIT(DPU_PINGPONG_TE2))
>
>  #define CTL_SC7280_MASK \
> -       (BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE))
> +       (BIT(DPU_CTL_ACTIVE_CFG) | BIT(DPU_CTL_FETCH_ACTIVE) | BIT(DPU_CTL_VM_CFG))
>
>  #define MERGE_3D_SM8150_MASK (0)
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> index 4ade44b..31af04a 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h
> @@ -179,13 +179,16 @@ enum {
>
>  /**
>   * CTL sub-blocks
> - * @DPU_CTL_SPLIT_DISPLAY       CTL supports video mode split display
> + * @DPU_CTL_SPLIT_DISPLAY:     CTL supports video mode split display
> + * @DPU_CTL_FETCH_ACTIVE:      Active CTL for fetch HW (SSPPs)
> + * @DPU_CTL_VM_CFG:            CTL config to support multiple VMs
>   * @DPU_CTL_MAX
>   */
>  enum {
>         DPU_CTL_SPLIT_DISPLAY = 0x1,
>         DPU_CTL_ACTIVE_CFG,
>         DPU_CTL_FETCH_ACTIVE,
> +       DPU_CTL_VM_CFG,
>         DPU_CTL_MAX
>  };
>
> diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> index 64740ddb..02da9ec 100644
> --- a/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> +++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_hw_ctl.c
> @@ -36,6 +36,7 @@
>  #define  MERGE_3D_IDX   23
>  #define  INTF_IDX       31
>  #define CTL_INVALID_BIT                 0xffff
> +#define CTL_DEFAULT_GROUP_ID           0xf
>
>  static const u32 fetch_tbl[SSPP_MAX] = {CTL_INVALID_BIT, 16, 17, 18, 19,
>         CTL_INVALID_BIT, CTL_INVALID_BIT, CTL_INVALID_BIT, CTL_INVALID_BIT, 0,
> @@ -498,6 +499,13 @@ static void dpu_hw_ctl_intf_cfg_v1(struct dpu_hw_ctl *ctx,
>         u32 intf_active = 0;
>         u32 mode_sel = 0;
>
> +       /* CTL_TOP[31:28] carries group_id to collate CTL paths
> +        * per VM. Explicitly disable it until VM support is
> +        * added in SW. Power on reset value is not disable.
> +        */
> +       if ((test_bit(DPU_CTL_VM_CFG, &ctx->caps->features)))
> +               mode_sel = CTL_DEFAULT_GROUP_ID  << 28;
> +
>         if (cfg->intf_mode_sel == DPU_CTL_MODE_SEL_CMD)
>                 mode_sel |= BIT(17);
>
> --
> 2.7.4
>


-- 
With best wishes
Dmitry
