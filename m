Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9E04382385
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 06:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232989AbhEQEgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 00:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbhEQEgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 00:36:50 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4540C061573
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 21:35:33 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id g11so916762ilq.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 May 2021 21:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9qPWRHR+PUcFLbaucVvojL1MaT1ICFcyjD+jNvEEGdg=;
        b=AlTeHTsWilvuYwm9xksxhaCVaXuNSjuJ8FquZYO31IrTM+Y339sDWT8JHoCnXnzIIT
         AjBipQYY76/Bu+Esgj9jMeOKCiKyqka7FvDAUdvfYW24dhaxjlVdoQiDMrBhXWb2dbwU
         vskUTHlYPU20jMMANw3Pg1HegjmHdM8pkUezU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9qPWRHR+PUcFLbaucVvojL1MaT1ICFcyjD+jNvEEGdg=;
        b=Zu/clkBJtf+ZuOj0JIWOX1JM/l3dPykyz1ivWycTSq216aKDSk7gORwc/D8/BPu77F
         ccT+aqaWB0WY9zBdcDYbD9qgPeSsj21E2sN4V1+VyoGEqnWVMvQsWAs06BdSgA/F3gu/
         yn6YYHa48Am7zVQ5lvhDyfu1I8oU4s0Ub4Yg/JIKj/bWobdRlhX5DCIZbTh8Z4mpfJCo
         D1z/IO9f2knyYoBh0Yefmxbr1TQg7zuqLDcqWlX7k/3Zdm/9HHlbxNwv7UotEBu1EH06
         HX7o6Y4uFqQH+Cby5CsYY6s76Hhy6WnaqtxVozwuEgxvdp+kSxLloOk+2NOgT1f3XqV2
         Vk9g==
X-Gm-Message-State: AOAM530j3cGtG1b5ALDZejBvUghZpVcyBBPsnZj0LJwhCG98eJ0zvTs6
        BTr1fC1JyFr/Y2y9PAIoWdlyRxCxd6XjFctDPBFr9g==
X-Google-Smtp-Source: ABdhPJzoRYq5Zv23D3UkkHYKjX4FehsOCDj3SbfFabhwmX4Id9eUzexY6pzchM5x0sFFg7FADcEPVYyFS/WFm/wJU3s=
X-Received: by 2002:a92:360e:: with SMTP id d14mr50144021ila.106.1621226133306;
 Sun, 16 May 2021 21:35:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210427111526.1772293-1-acourbot@chromium.org> <20210427111526.1772293-8-acourbot@chromium.org>
In-Reply-To: <20210427111526.1772293-8-acourbot@chromium.org>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Mon, 17 May 2021 12:35:07 +0800
Message-ID: <CAJMQK-g=bnr9bAkvN61sFapX_XOKmUF8LPivtCEzUhP-LjoHUw@mail.gmail.com>
Subject: Re: [PATCH v4 07/15] media: mtk-vcodec: vdec: add media device if
 using stateless api
To:     Alexandre Courbot <acourbot@chromium.org>
Cc:     Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 27, 2021 at 7:16 PM Alexandre Courbot <acourbot@chromium.org> wrote:
>
> From: Yunfei Dong <yunfei.dong@mediatek.com>
>
> The stateless API requires a media device for issuing requests. Add one
> if we are being instantiated as a stateless decoder.
>
> Signed-off-by: Yunfei Dong <yunfei.dong@mediatek.com>
> [acourbot: refactor, cleanup and split]
> Co-developed-by: Alexandre Courbot <acourbot@chromium.org>
> Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> ---
>  drivers/media/platform/Kconfig                |  1 +
>  .../platform/mtk-vcodec/mtk_vcodec_dec_drv.c  | 39 +++++++++++++++++++
>  .../platform/mtk-vcodec/mtk_vcodec_drv.h      |  2 +
>  3 files changed, 42 insertions(+)
>
> diff --git a/drivers/media/platform/Kconfig b/drivers/media/platform/Kconfig
> index ae1468aa1b4e..4154fdec2efb 100644
> --- a/drivers/media/platform/Kconfig
> +++ b/drivers/media/platform/Kconfig
> @@ -315,6 +315,7 @@ config VIDEO_MEDIATEK_VCODEC
>         select VIDEO_MEDIATEK_VCODEC_VPU if VIDEO_MEDIATEK_VPU
>         select VIDEO_MEDIATEK_VCODEC_SCP if MTK_SCP
>         select V4L2_H264
> +       select MEDIA_CONTROLLER

Should this also select MEDIA_CONTROLLER_REQUEST_API config?

Thanks
>         help
>           Mediatek video codec driver provides HW capability to
>           encode and decode in a range of video formats on MT8173
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> index 533781d4680a..e942e28f96fe 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_dec_drv.c
> @@ -14,6 +14,7 @@
>  #include <media/v4l2-event.h>
>  #include <media/v4l2-mem2mem.h>
>  #include <media/videobuf2-dma-contig.h>
> +#include <media/v4l2-device.h>
>
>  #include "mtk_vcodec_drv.h"
>  #include "mtk_vcodec_dec.h"
> @@ -324,6 +325,31 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
>                 goto err_event_workq;
>         }
>
> +       if (dev->vdec_pdata->uses_stateless_api) {
> +               dev->mdev_dec.dev = &pdev->dev;
> +               strscpy(dev->mdev_dec.model, MTK_VCODEC_DEC_NAME,
> +                               sizeof(dev->mdev_dec.model));
> +
> +               media_device_init(&dev->mdev_dec);
> +               dev->mdev_dec.ops = &mtk_vcodec_media_ops;
> +               dev->v4l2_dev.mdev = &dev->mdev_dec;
> +
> +               ret = v4l2_m2m_register_media_controller(dev->m2m_dev_dec,
> +                       dev->vfd_dec, MEDIA_ENT_F_PROC_VIDEO_DECODER);
> +               if (ret) {
> +                       mtk_v4l2_err("Failed to register media controller");
> +                       goto err_reg_cont;
> +               }
> +
> +               ret = media_device_register(&dev->mdev_dec);
> +               if (ret) {
> +                       mtk_v4l2_err("Failed to register media device");
> +                       goto err_media_reg;
> +               }
> +
> +               mtk_v4l2_debug(0, "media registered as /dev/media%d",
> +                       vfd_dec->num);
> +       }
>         ret = video_register_device(vfd_dec, VFL_TYPE_VIDEO, 0);
>         if (ret) {
>                 mtk_v4l2_err("Failed to register video device");
> @@ -336,6 +362,12 @@ static int mtk_vcodec_probe(struct platform_device *pdev)
>         return 0;
>
>  err_dec_reg:
> +       if (dev->vdec_pdata->uses_stateless_api)
> +               media_device_unregister(&dev->mdev_dec);
> +err_media_reg:
> +       if (dev->vdec_pdata->uses_stateless_api)
> +               v4l2_m2m_unregister_media_controller(dev->m2m_dev_dec);
> +err_reg_cont:
>         destroy_workqueue(dev->decode_workqueue);
>  err_event_workq:
>         v4l2_m2m_release(dev->m2m_dev_dec);
> @@ -368,6 +400,13 @@ static int mtk_vcodec_dec_remove(struct platform_device *pdev)
>
>         flush_workqueue(dev->decode_workqueue);
>         destroy_workqueue(dev->decode_workqueue);
> +
> +       if (media_devnode_is_registered(dev->mdev_dec.devnode)) {
> +               media_device_unregister(&dev->mdev_dec);
> +               v4l2_m2m_unregister_media_controller(dev->m2m_dev_dec);
> +               media_device_cleanup(&dev->mdev_dec);
> +       }
> +
>         if (dev->m2m_dev_dec)
>                 v4l2_m2m_release(dev->m2m_dev_dec);
>
> diff --git a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> index 78d4a7728ddf..10edd238c939 100644
> --- a/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> +++ b/drivers/media/platform/mtk-vcodec/mtk_vcodec_drv.h
> @@ -383,6 +383,7 @@ struct mtk_vcodec_enc_pdata {
>   * struct mtk_vcodec_dev - driver data
>   * @v4l2_dev: V4L2 device to register video devices for.
>   * @vfd_dec: Video device for decoder
> + * @mdev_dec: Media device for decoder
>   * @vfd_enc: Video device for encoder.
>   *
>   * @m2m_dev_dec: m2m device for decoder
> @@ -418,6 +419,7 @@ struct mtk_vcodec_enc_pdata {
>  struct mtk_vcodec_dev {
>         struct v4l2_device v4l2_dev;
>         struct video_device *vfd_dec;
> +       struct media_device mdev_dec;
>         struct video_device *vfd_enc;
>
>         struct v4l2_m2m_dev *m2m_dev_dec;
> --
> 2.31.1.498.g6c1eba8ee3d-goog
>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
