Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A85B743C67A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 11:32:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240996AbhJ0JfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 05:35:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbhJ0Jey (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 05:34:54 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA085C061570
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 02:32:29 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id f9so2764723ioo.11
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 02:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7XHjYTJsHtmmMad6y4D14arx8SSI4DLlQcaRHAcm09Q=;
        b=f7moHQylEHJ9KJFRrrluC9FcbdrY48H1HrCI6LgdHxR0ARIgYRHqyz3yKJ0V2VX9fB
         BwcF0KOpJmqgVmTesRjK8vGTilcFhpOBan2BWYH3k7UY1KwCLHyl7B5eekYGAAYyHCDw
         bEB8A5PuJKWeVmuFBzGeKMZO5sg7k5GTZv+uU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7XHjYTJsHtmmMad6y4D14arx8SSI4DLlQcaRHAcm09Q=;
        b=viL/DHPIUi80k/3XzUSM0bNxloqkduoOiLo1qFavHolMjaTyXnXQ4F5OREgKuTRfXq
         PP62CQxqJYUl9e8eG+7xabltj0QRo8Djl/lfx7xf+AXvQXOBFEQzKAU8w4NW+Bw8EboC
         ORJZdrDjM4B4QC2vDtQOJrSC1Cko4nY3B94rGAjzslPT3FUa/ZuytkqZmrbVLbkz7AJe
         8/0k5CXaWRkZfA7lsAb9IXsVdsAaxrFy+kqQvY6akN0AqlXLqapr5K2T/wfrq3neJhoD
         7UECAJ60/D96P9MLgXeV8qUtx/C31sNemIczAIGSn5elQD66csFREFVQ5jWTMrZ0MgN0
         5BYA==
X-Gm-Message-State: AOAM530l2FV3X+7aEogq05nl5ajSVL/4zwMGxjaOWUzMtOp5AduYYMnW
        ZGIF68x8zcht84WWQQRmyNW2o5Fk/vanFQ==
X-Google-Smtp-Source: ABdhPJyc+cbxgIn/yUDI/QnEP28kOjfXVJ7WPWnVmDikpMBNc2CCijyNYDOEa9ctKiQ+NhFfhc6JFA==
X-Received: by 2002:a05:6602:157:: with SMTP id v23mr16161228iot.75.1635327146826;
        Wed, 27 Oct 2021 02:32:26 -0700 (PDT)
Received: from mail-il1-f173.google.com (mail-il1-f173.google.com. [209.85.166.173])
        by smtp.gmail.com with ESMTPSA id y5sm2796759ilv.5.2021.10.27.02.32.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Oct 2021 02:32:26 -0700 (PDT)
Received: by mail-il1-f173.google.com with SMTP id j3so2252283ilr.6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 02:32:25 -0700 (PDT)
X-Received: by 2002:a05:6e02:1747:: with SMTP id y7mr18329876ill.95.1635327145411;
 Wed, 27 Oct 2021 02:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211027021857.20816-1-jason-jh.lin@mediatek.com> <20211027021857.20816-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20211027021857.20816-4-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Wed, 27 Oct 2021 17:31:49 +0800
X-Gmail-Original-Message-ID: <CAC=S1ng2=XRV9s2t2dxQf1a2V2GsFwhfB8tRxnNDp-QD5eR_xQ@mail.gmail.com>
Message-ID: <CAC=S1ng2=XRV9s2t2dxQf1a2V2GsFwhfB8tRxnNDp-QD5eR_xQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] drm/mediatek: Detect CMDQ execution timeout
To:     "jason-jh.lin" <jason-jh.lin@mediatek.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        hsinyi@chromium.org, nancy.lin@mediatek.com,
        singo.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jason,

On Wed, Oct 27, 2021 at 10:19 AM jason-jh.lin <jason-jh.lin@mediatek.com> wrote:
>
> From: Chun-Kuang Hu <chunkuang.hu@kernel.org>
>
> CMDQ is used to update display register in vblank period, so
> it should be execute in next 2 vblank. One vblank interrupt
> before send message (occasionally) and one vblank interrupt
> after cmdq done. If it fail to execute in next 3 vblank,
> tiemout happen.
>
> Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> Signed-off-by: jason-jh.lin <jason-jh.lin@mediatek.com>
> Reviewed-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index e23e3224ac67..dad1f85ee315 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> @@ -54,6 +54,7 @@ struct mtk_drm_crtc {
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         struct cmdq_client              cmdq_client;
>         u32                             cmdq_event;
> +       u32                             cmdq_vblank_cnt;
>  #endif
>
>         struct device                   *mmsys_dev;
> @@ -227,7 +228,10 @@ struct mtk_ddp_comp *mtk_drm_ddp_comp_for_plane(struct drm_crtc *crtc,
>  static void ddp_cmdq_cb(struct mbox_client *cl, void *mssg)
>  {
>         struct cmdq_cb_data *data = mssg;
> +       struct cmdq_client *cmdq_cl = container_of(cl, struct cmdq_client, client);
> +       struct mtk_drm_crtc *mtk_crtc = container_of(cmdq_cl, struct mtk_drm_crtc, cmdq_client);
>
> +       mtk_crtc->cmdq_vblank_cnt = 0;
>         cmdq_pkt_destroy(data->pkt);
>  }
>  #endif
> @@ -483,6 +487,15 @@ static void mtk_drm_crtc_update_config(struct mtk_drm_crtc *mtk_crtc,
>                                            cmdq_handle->pa_base,
>                                            cmdq_handle->cmd_buf_size,
>                                            DMA_TO_DEVICE);
> +               /*
> +                * CMDQ command should execute in next 3 vblank.
> +                * One vblank interrupt before send message (occasionally)
> +                * and one vblank interrupt after cmdq done,
> +                * so it's timeout after 3 vblank interrupt.
> +                * If it fail to execute in next 3 vblank, timeout happen.
> +                */
> +               mtk_crtc->cmdq_vblank_cnt = 3;
> +
>                 mbox_send_message(mtk_crtc->cmdq_client.chan, cmdq_handle);
>                 mbox_client_txdone(mtk_crtc->cmdq_client.chan, 0);
>         }
> @@ -499,11 +512,14 @@ static void mtk_crtc_ddp_irq(void *data)
>
>  #if IS_REACHABLE(CONFIG_MTK_CMDQ)
>         if (!priv->data->shadow_register && !mtk_crtc->cmdq_client.chan)
> +               mtk_crtc_ddp_config(crtc, NULL);
> +       else if (mtk_crtc->cmdq_vblank_cnt > 0 && --mtk_crtc->cmdq_vblank_cnt == 0)
I think atomic_dec_and_test() does what you want to do here.




> +               DRM_ERROR("mtk_crtc %d CMDQ execute command timeout!\n",
> +                         drm_crtc_index(&mtk_crtc->base));
>  #else
>         if (!priv->data->shadow_register)
> -#endif
>                 mtk_crtc_ddp_config(crtc, NULL);
> -
> +#endif
>         mtk_drm_finish_page_flip(mtk_crtc);
>  }
>
> --
> 2.18.0
>
