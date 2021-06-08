Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7A4C39EAA1
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Jun 2021 02:18:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230407AbhFHAUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Jun 2021 20:20:33 -0400
Received: from mail.kernel.org ([198.145.29.99]:44248 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230209AbhFHAUb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Jun 2021 20:20:31 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 08E4F61278
        for <linux-kernel@vger.kernel.org>; Tue,  8 Jun 2021 00:18:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623111520;
        bh=NBPR/t6DpZyrcU0kswew7pL5+ZXvRXVXN2mhIR75M3A=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gV5zOji+r2/clAW2Kobd6MnI0MfssYmgx1A7OFqpRsqOuiXpgXhAxKja3W5optCT3
         wuQhpkht84p5KG8cExyvNV85/GZC0CSCOV6ubQ02s2AS9JrnllVAKwb+ENsCZeg2cI
         VybfOTx9cW4Nr5y5nHIkeHQfAAwFS0GAhpwkYjOB6G1QauforodVXCE0G74xM+vqVS
         6rotESXDnqMABHo8l2b296r38xnuDu1C9L2huoX83MOkZW4s008WmiUwea5WdHC0Q+
         aczZ+y8zonQasglwTTyXQiLFHlCejATeI1D+M6Y548293Vd4KKBo79xEFzBLZJx7US
         2MEjsu++d57OQ==
Received: by mail-ej1-f48.google.com with SMTP id ci15so29536838ejc.10
        for <linux-kernel@vger.kernel.org>; Mon, 07 Jun 2021 17:18:39 -0700 (PDT)
X-Gm-Message-State: AOAM531OqPXk29apW92bVoP+PY8eDUE6zNJ0ih/8Onh1etd4yEZzfdLj
        G7Irh8apQSeHgB9cxTbbwSpqsx5phadyF4tvgQ==
X-Google-Smtp-Source: ABdhPJzndobiLhNjhOA4a7KXYaL6sXYZqGPxAn2dbv51QSkEkDv6RsyhwbgaVH6hMrbCM0A78i6voDNrMTPycwcs2lQ=
X-Received: by 2002:a17:906:b0cb:: with SMTP id bk11mr20679861ejb.310.1623111518484;
 Mon, 07 Jun 2021 17:18:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210603111455.5963-1-bernard@vivo.com>
In-Reply-To: <20210603111455.5963-1-bernard@vivo.com>
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Date:   Tue, 8 Jun 2021 08:18:27 +0800
X-Gmail-Original-Message-ID: <CAAOTY_-QpO1d6+jnQsun8htG8sGqrVVA3Jy1kvLqOZC+CExxTQ@mail.gmail.com>
Message-ID: <CAAOTY_-QpO1d6+jnQsun8htG8sGqrVVA3Jy1kvLqOZC+CExxTQ@mail.gmail.com>
Subject: Re: [PATCH] drm/mediatek: remove redundant error log print
To:     Bernard Zhao <bernard@vivo.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Bernard:

Bernard Zhao <bernard@vivo.com> =E6=96=BC 2021=E5=B9=B46=E6=9C=883=E6=97=A5=
 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=887:15=E5=AF=AB=E9=81=93=EF=BC=9A
>
> Fix coccicheck warning:
> drivers/gpu/drm/mediatek/mtk_dsi.c:1074:2-9: line 1074 is
> redundant because platform_get_irq() already prints an error.
>
> Signed-off-by: Bernard Zhao <bernard@vivo.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_dsi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediate=
k/mtk_dsi.c
> index ae403c67cbd9..e2e4fc8b1360 100644
> --- a/drivers/gpu/drm/mediatek/mtk_dsi.c
> +++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
> @@ -1082,10 +1082,8 @@ static int mtk_dsi_probe(struct platform_device *p=
dev)
>
>         ret =3D devm_request_irq(&pdev->dev, irq_num, mtk_dsi_irq,
>                                IRQF_TRIGGER_NONE, dev_name(&pdev->dev), d=
si);

devm_request_irq() would have below call stack to allocate memory.
When allocate memory fail, it would not print any error message,
doesn't it?

devm_request_irq() -> devm_request_threaded_irq() -> devres_alloc() ->
devres_alloc_node() -> alloc_dr() -> kmalloc_node_track_caller()

Regards,
Chun-Kuang.

> -       if (ret) {
> -               dev_err(&pdev->dev, "failed to request mediatek dsi irq\n=
");
> +       if (ret)
>                 goto err_unregister_host;
> -       }
>
>         init_waitqueue_head(&dsi->irq_wait_queue);
>
> --
> 2.31.0
>
