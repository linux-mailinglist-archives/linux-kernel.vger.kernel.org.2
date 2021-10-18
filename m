Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835B4430D61
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 03:17:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242936AbhJRBTX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 21:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231983AbhJRBTT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 21:19:19 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1702C06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 18:17:08 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 5so33930119edw.7
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 18:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnqEn1CtLr/NiyhAgmO/8MRbeaoY3H6FysR0WE07eMI=;
        b=CAzzpQc8d6pvPmR8WujIwnG/8mp9OOfW/GJEz0cHJFQGuE8vZAdGMpq7oD2rT8f2jD
         el8GQzh6RWyx9yp8C3agLrBlGNRm/6mrCWeM085GlIU6LOuzzZIXL67R2Ocri5EBx/kW
         jaf4Qk9+6r5KuIqpO7H/L3MXKgoxk+ZJQs65w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnqEn1CtLr/NiyhAgmO/8MRbeaoY3H6FysR0WE07eMI=;
        b=BI1q43T+udrfFJ+EZZHuQ37f50vdLuuC55np6+a3BsHkyvcXP0Azs4AZlW5vILIHra
         CwJu7xBYqGE7Ysc/kvqsHLoN/XaVekmeC+VVr6ncpIZKi6DHwt9GRsUAbQPlISczhDZ0
         HvSJJZoneK30jdVgTofcGUBHrbbiM1jOV92ZCXmQfDID/IzCZIHTrUjTf8KzhQSAk4zY
         +y2lYhdCmkU+Cd7AIaBDoCjtsirWqDWUXB+RKUdcxKDdJKqj3MkO98U0dPLInNf9gIOk
         z5fpsbhQ8XQmLZd7PDakU7o9+MJINCFktp9c6++y/atiD0Zw69LLlfPHOQ1UvwyQMuWL
         uGcg==
X-Gm-Message-State: AOAM532C2XvkUWgoClInizy6xQGcU45tESVgWT3hdT56dX7R90+/WwkY
        Q3X/Ih5L4mN801QErynqsgghfMgx6dhkcQ==
X-Google-Smtp-Source: ABdhPJxQQG/83bjVUNuSXk808uHcrw/RSPGWmrhwly6ew66OLux+NySXk1fbxFND/ORjPOvMTUAdYQ==
X-Received: by 2002:a05:6402:51cf:: with SMTP id r15mr39932336edd.60.1634519827299;
        Sun, 17 Oct 2021 18:17:07 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id jy25sm8035826ejc.100.2021.10.17.18.17.05
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Oct 2021 18:17:06 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id y30so46530631edi.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 18:17:05 -0700 (PDT)
X-Received: by 2002:a17:906:912:: with SMTP id i18mr25269308ejd.131.1634519824911;
 Sun, 17 Oct 2021 18:17:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210920170408.1561-1-dafna.hirschfeld@collabora.com> <c59b7f40-d99e-370a-b797-5dc72979df46@xs4all.nl>
In-Reply-To: <c59b7f40-d99e-370a-b797-5dc72979df46@xs4all.nl>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 18 Oct 2021 10:16:54 +0900
X-Gmail-Original-Message-ID: <CAPBb6MW_i1_Lh2ZaF8jGjcV-4XBhjswtyKkZCk3HxKO7LX79Og@mail.gmail.com>
Message-ID: <CAPBb6MW_i1_Lh2ZaF8jGjcV-4XBhjswtyKkZCk3HxKO7LX79Og@mail.gmail.com>
Subject: Re: [PATCH v4] media: mtk-vpu: Ensure alignment of 8 for DTCM buffer
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Dafna Hirschfeld <dafna.hirschfeld@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, kernel@collabora.com,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Dafna Hirschfeld <dafna3@gmail.com>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        minghsiu.tsai@mediatek.com, houlong.wei@mediatek.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans!

On Mon, Oct 4, 2021 at 6:37 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>
> On 20/09/2021 19:04, Dafna Hirschfeld wrote:
> > From: Alexandre Courbot <acourbot@chromium.org>
> >
> > When running memcpy_toio:
> > memcpy_toio(send_obj->share_buf, buf, len);
> > it was found that errors appear if len is not a multiple of 8:
> >
> > [58.350841] mtk-mdp 14001000.rdma: processing failed: -22
>
> Why do errors appear? Is that due to a HW bug? Some other reason?

MTK folks would be the best placed to answer this, but since the
failure is reported by the firmware I'd suspect either a firmware or
hardware limitation.

>
> >
> > This patch ensures the copy of a multiple of 8 size by calling
> > round_up(len, 8) when copying
> >
> > Fixes: e6599adfad30 ("media: mtk-vpu: avoid unaligned access to DTCM buffer.")
> > Signed-off-by: Alexandre Courbot <acourbot@chromium.org>
> > Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> > Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
> > Reviewed-by: Houlong Wei <houlong.wei@mediatek.com>
> > ---
> > changes since v3:
> > 1. multile -> multiple
> > 2. add inline doc
> >
> > changes since v2:
> > 1. do the extra copy only if len is not multiple of 8
> >
> > changes since v1:
> > 1. change sign-off-by tags
> > 2. change values to memset
> >
> >  drivers/media/platform/mtk-vpu/mtk_vpu.c | 15 ++++++++++++++-
> >  1 file changed, 14 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/platform/mtk-vpu/mtk_vpu.c b/drivers/media/platform/mtk-vpu/mtk_vpu.c
> > index ec290dde59cf..1df031716c8f 100644
> > --- a/drivers/media/platform/mtk-vpu/mtk_vpu.c
> > +++ b/drivers/media/platform/mtk-vpu/mtk_vpu.c
> > @@ -349,7 +349,20 @@ int vpu_ipi_send(struct platform_device *pdev,
> >               }
> >       } while (vpu_cfg_readl(vpu, HOST_TO_VPU));
> >
> > -     memcpy_toio(send_obj->share_buf, buf, len);
> > +     /*
> > +      * when copying data to the vpu hardware, the memcpy_toio operation must copy
> > +      * a multiple of 8. Otherwise the processing fails
>
> Same here: it needs to explain why the processing fails.
>
> > +      */
> > +     if (len % 8 != 0) {
> > +             unsigned char data[SHARE_BUF_SIZE];
>
> Wouldn't it be more robust if you say:
>
>                 unsigned char data[sizeof(send_obj->share_buf)];

Definitely yes.

>
> I also think that the SHARE_BUF_SIZE define needs a comment stating that it must be a
> multiple of 8, otherwise unexpected things can happen.
>
> You also noticed that the current SHARE_BUF_SIZE define is too low, but I saw
> no patch correcting this. Shouldn't that be fixed as well?

AFAICT the firmware expects this exact size on its end, so I don't
believe it can be changed that easily. But maybe someone from MTK can
prove me wrong.

Cheers,
Alex.
