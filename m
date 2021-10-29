Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 100A043F6AF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Oct 2021 07:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhJ2FgF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Oct 2021 01:36:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbhJ2FgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Oct 2021 01:36:03 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23B6C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 22:33:32 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id x9so1855753ilu.6
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 22:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FReYOopH02D5COr/NffWZKd+wG9WfCzdcsCckINuOIg=;
        b=I/Y64zF/ZpuDtCvP7DXWwJDekequNVZ0j0qyEbOjPZjY6DZgEJ+OeniAVKShH5FZGz
         WjO8IYnAq4i1OFMbDK1L3gz+P/TaKI8Xa+xZyUj7gNBpQm7wD/K0q1oJ9ehrzTCxdCjE
         O8ZEzctOgSVLLPg2CqXubJ8rei5qxnvHBLlvY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FReYOopH02D5COr/NffWZKd+wG9WfCzdcsCckINuOIg=;
        b=EV0BZhQA8QuZK9AUD+lYsQoVbuiDfcwW9mhMRcpB/4DBiYIHNDV80K/FuyadEMylru
         lAPeGGRb3LWQnYxTndXvDmRZocGu8GsDsAXXHo1phQaIFC1U2Dhnzvm62Tcrv7eFrrj7
         psMKvlGJESLycHi3HM8oVeuxCdEnX8E1DNKZrzC4irJ+1XrJS4o/5fqHfgb7ewPWfqTN
         t4pHRJ6su1iSAbqUX9wsAmV7YHXtUVlYGoACpxtZCU8FY90rGsMT+Vdn9tn9dmTiFIGm
         X4NnEGjVnP7+RIq6zrSE/YzkvIS5e0Nu+Yz+9oGQCOoR/rN+RJYd9JnOIbnFZm0Hnv4L
         Ljxg==
X-Gm-Message-State: AOAM530FbFhs/giSnVI3I/cU3RWOD4iYdbYsaq71ZfIYUvY6imY7PuuI
        Gqi2yE+NDeGTTzbQ8IVDByzeaVoMutDh6g==
X-Google-Smtp-Source: ABdhPJwm8JGgJrL/yYtt+EBasCaIIWCV0o+wMpJI/d4WqrgW9Gzyyymuysv8FFXleL/zo6Piz22wwg==
X-Received: by 2002:a92:1e11:: with SMTP id e17mr6157755ile.196.1635485611540;
        Thu, 28 Oct 2021 22:33:31 -0700 (PDT)
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com. [209.85.166.43])
        by smtp.gmail.com with ESMTPSA id i1sm2809618iov.10.2021.10.28.22.33.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 22:33:29 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id p8so4695981iod.8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 22:33:29 -0700 (PDT)
X-Received: by 2002:a05:6638:12cd:: with SMTP id v13mr6826768jas.84.1635485608849;
 Thu, 28 Oct 2021 22:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20211028101912.4624-1-jason-jh.lin@mediatek.com> <20211028101912.4624-4-jason-jh.lin@mediatek.com>
In-Reply-To: <20211028101912.4624-4-jason-jh.lin@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Fri, 29 Oct 2021 13:32:53 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhCD-mG-5grj5s3c7NJF1nt=V3v4FN=MvZe2ZMkP9z5_A@mail.gmail.com>
Message-ID: <CAC=S1nhCD-mG-5grj5s3c7NJF1nt=V3v4FN=MvZe2ZMkP9z5_A@mail.gmail.com>
Subject: Re: [PATCH v6 3/6] drm/mediatek: Detect CMDQ execution timeout
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

On Thu, Oct 28, 2021 at 6:19 PM jason-jh.lin <jason-jh.lin@mediatek.com> wrote:
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
Reviewed-by: Fei Shao <fshao@chromium.org>



> ---
>  drivers/gpu/drm/mediatek/mtk_drm_crtc.c | 20 ++++++++++++++++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
> index e23e3224ac67..a368cbc18923 100644
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
> +       else if (--mtk_crtc->cmdq_vblank_cnt == 0)
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
