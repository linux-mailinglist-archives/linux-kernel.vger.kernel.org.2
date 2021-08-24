Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735223F5B72
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 11:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235755AbhHXJyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 05:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235926AbhHXJyL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 05:54:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00D0C06179A
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:53:27 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d17so11879926plr.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 02:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=y+4TOdfiSrPLpilk4nXd191TRaZiBNSbpfGRJDlN6Xo=;
        b=vPgvA0tj4fvHTKQGRUrcP0uEeIWCIRwx+dPJ6dGccUF4YIgoRJa+YVOsvkIXM21I0r
         n+md7zdI3okOy4xHX2uVtw783gUKvQGN5vS5Kd8z8bZeqhWfyHpbFf712EFyTnRzILHO
         Fvpv41PaTn2x2nvZYTzPVHay+ErepF7RQjpvl2RKg08jljTn3PUK7B6ZXkJPLyQjPA5R
         Cgb6O0uWM12qKePazoJpJfVQwpLh/yijFHX6lG3Kydkg9t0WMCPO6RAIhSh0puWhCvQY
         hSmYuO7p42PAYBusuAytm80hxGYWdSwc5bkZ9WYl1vTXb/DzNSZwZOvk4vY4MXno7w8q
         uF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=y+4TOdfiSrPLpilk4nXd191TRaZiBNSbpfGRJDlN6Xo=;
        b=YhTeeSrIFVtBwSsN2WYVfOWujRjIPnK1jNm0oH9YSI6t/7Q0ejNoXZ66V4jaU2UE2s
         PmwVg2Jb4/BupBrLgLIhRpRMx2zqMIJJ6bJHXcy1n4MeJpV3eGTrk5VoVt/jdHJJmKau
         fCCv5VsqXca9iWalOcDuNk+Nfxw7gcH9DwzTeGK+YMYxcEbIkTsbcqg3Oit9H02YqPlw
         qWqQsCEx4Ilcm+tIQkXXQlo2vOL+UFQmnpVxSBCy5fYCxY4MSC8B+/VnDM1jSdKDOBO+
         LkR1h+CpGfdeRacY5qbRIbIA/GFVlaXog+W8/xSF/jnWxKTWEW5NTYkzUANRMYepK7n0
         78iA==
X-Gm-Message-State: AOAM533iIdfQOBBrmkbpvcjwn+40rDbBIoNnkkNgLhKubAlZr3UOus7T
        WSHjx+0xY33sN7WGkgwhNDAsNQ==
X-Google-Smtp-Source: ABdhPJxht4KPxR628aDJtIWzZmmfHxaeU2++K2HaMoN6ksTkRxgKPtCCpNOp59sviJumX/HyYX3arw==
X-Received: by 2002:a17:90a:8905:: with SMTP id u5mr3456576pjn.95.1629798806963;
        Tue, 24 Aug 2021 02:53:26 -0700 (PDT)
Received: from google.com ([2401:fa00:1:10:4a93:46f4:da9a:4371])
        by smtp.gmail.com with ESMTPSA id p29sm18874522pfw.141.2021.08.24.02.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 02:53:26 -0700 (PDT)
Date:   Tue, 24 Aug 2021 17:53:21 +0800
From:   Tzung-Bi Shih <tzungbi@google.com>
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Alexandre Courbot <acourbot@chromium.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>, Yong Wu <yong.wu@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Fritz Koenig <frkoenig@chromium.org>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srv_heupstream@mediatek.com, linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH 4/9] media: mtk-vcodec: Add venc power on/off interface
Message-ID: <YSTBkZg0LBJGJsrE@google.com>
References: <20210816105934.28265-1-irui.wang@mediatek.com>
 <20210816105934.28265-5-irui.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816105934.28265-5-irui.wang@mediatek.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 16, 2021 at 06:59:29PM +0800, Irui Wang wrote:
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc.c
> @@ -16,6 +16,7 @@
>  #include "mtk_vcodec_intr.h"
>  #include "mtk_vcodec_util.h"
>  #include "venc_drv_if.h"
> +#include "mtk_vcodec_enc_pm.h"
Please try to maintain the order.

> @@ -285,11 +291,12 @@ static int fops_vcodec_release(struct file *file)
>  	mtk_v4l2_debug(1, "[%d] encoder", ctx->id);
>  	mutex_lock(&dev->dev_mutex);
>  
> +	v4l2_m2m_ctx_release(ctx->m2m_ctx);
>  	mtk_vcodec_enc_release(ctx);
>  	v4l2_fh_del(&ctx->fh);
>  	v4l2_fh_exit(&ctx->fh);
>  	v4l2_ctrl_handler_free(&ctx->ctrl_hdl);
> -	v4l2_m2m_ctx_release(ctx->m2m_ctx);
> +	mtk_vcodec_enc_power_off(ctx);
Any reason to move the v4l2_m2m_ctx_release()?

> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_enc_pm.c
> @@ -12,6 +12,7 @@
>  
>  #include "mtk_vcodec_enc_pm.h"
>  #include "mtk_vcodec_util.h"
> +#include "mtk_vcodec_enc_hw.h"
Please try to maintain the order.

> +int mtk_venc_enable_comp_hw(struct mtk_vcodec_dev *dev)
> +{
> +	int i, ret;
> +	struct mtk_venc_comp_dev *venc_comp;
> +
> +	/*
> +	 * frame_racing mode needs power on all available component devices.
> +	 */
> +	for (i = 0; i < MTK_VENC_HW_MAX; i++) {
> +		venc_comp = (struct mtk_venc_comp_dev *)dev->enc_comp_dev[i];
> +		if (!venc_comp)
> +			return 0;
> +
> +		ret = mtk_smi_larb_get(venc_comp->pm.larbvenc);
> +		if (ret < 0) {
> +			mtk_v4l2_err("power on core[%d] fail %d", i, ret);
> +				goto pw_err;
The goto statement has extra indent layer.

> +int mtk_venc_disable_comp_hw(struct mtk_vcodec_dev *dev)
> +{
> +	int i;
> +	struct mtk_venc_comp_dev *venc_comp;
> +
> +	/*power off all available component device*/
Need extra space between /* */.

> +int mtk_vcodec_enc_power_on(struct mtk_vcodec_ctx *ctx)
> +{
> +	int ret;
> +	struct mtk_vcodec_dev *dev = ctx->dev;
> +
> +	if (dev->venc_pdata->hw_mode == VENC_FRAME_RACING_MODE) {
> +		ret = mtk_venc_enable_comp_hw(dev);
> +		if (ret < 0) {
> +			mtk_v4l2_err("enable venc comp hw fail :%d", ret);
> +			return ret;
> +		}
> +	} else {
> +		ret = mtk_smi_larb_get(dev->pm.larbvenc);
> +		if (ret < 0) {
> +			mtk_v4l2_err("pm_runtime_resume_and_get fail %d", ret);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
It seems the function doesn't need struct mtk_vcodec_ctx.

Does mtk_vcodec_enc_power_on(struct mtk_vcodec_dev* ) make more sense?

> +int mtk_vcodec_enc_power_off(struct mtk_vcodec_ctx *ctx)
> +{
> +	struct mtk_vcodec_dev *dev = ctx->dev;
> +
> +	if (dev->venc_pdata->hw_mode == VENC_FRAME_RACING_MODE)
> +		mtk_venc_disable_comp_hw(dev);
> +	else
> +		mtk_smi_larb_put(dev->pm.larbvenc);
> +
> +	return 0;
> +}
It seems the function doesn't need struct mtk_vcodec_ctx.
