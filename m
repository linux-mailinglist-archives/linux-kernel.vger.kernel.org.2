Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0EFB4307486
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jan 2021 12:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhA1LNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jan 2021 06:13:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbhA1LN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jan 2021 06:13:26 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECFD0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:12:46 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id y5so4842246ilg.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jan 2021 03:12:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/WJw1aJ983EEKpRj5gZ4zFlUrwFHoMadbviHbndDVT8=;
        b=dfDCHTrz8XskJkazSFR/d269ImWmkT6WKjpQ1j4AVPkVQ0H4j5zdogEiMZAuBs2Nuq
         PLm6Pn+zV760awkBSwTDMSe/TivqPc3s/134zz9sRbBQABFJfAnM4SjROF9bDhhkPFXx
         dFFpptCksPnvkPoUioIRniNKaaMkEX+xcGyNg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/WJw1aJ983EEKpRj5gZ4zFlUrwFHoMadbviHbndDVT8=;
        b=mF/fVFhgnXRaLD2PVr+wK+SNTFdWWUVEHJCtWWlX+tDEcoxlLnRpaWNsXpt8hMZnIB
         pgylPo4FsCYoECxyAd2ojDhQKG+HNVniM5LpZznHyn51a74pbdh4/jg9T7YI3jwmuOfL
         j/aU0ueY7S/shKHHWrMSIcHxGA5/jWGD7LAGwv2lqx2ciUsuoowmJTk5hv+hDzMVmCBs
         sjjBfFCjQaZc/fPzjadWBLE/ce47t26N8tSIFbYUzylJGQTe8TWWyiDIMv+1FLbC+T5s
         FNn4Z0El+gj6WJ6vI7P9N7J2ueijHh88SEu6AFN/a6PoLSs6mrmQzXJwMdTUMh3l2aMN
         L1dw==
X-Gm-Message-State: AOAM5306gAYsSqxNODn7vzhL+Qm8QKtUnUaW9pdgS6XfptwP296LYqIU
        qomzUgJHzLQjJSRJt6q7QlltdMzN4vAjOZIgqylV+w==
X-Google-Smtp-Source: ABdhPJxpvtqvyRoNVw2J32fCidzTHWv4s/97L1l2P7XY3BFLhw9LEXqsuGOgsssZ07Bdcb7TGzMR023+FxP+UJYso4w=
X-Received: by 2002:a05:6e02:509:: with SMTP id d9mr12671592ils.150.1611832366253;
 Thu, 28 Jan 2021 03:12:46 -0800 (PST)
MIME-Version: 1.0
References: <20210128072802.830971-1-hsinyi@chromium.org> <20210128072802.830971-4-hsinyi@chromium.org>
 <1611820251.16091.7.camel@mtksdaap41>
In-Reply-To: <1611820251.16091.7.camel@mtksdaap41>
From:   Hsin-Yi Wang <hsinyi@chromium.org>
Date:   Thu, 28 Jan 2021 19:12:20 +0800
Message-ID: <CAJMQK-igcZXrnTb6pA3S6X_uTF6aGhKFLAHtdet62od9vVx4rg@mail.gmail.com>
Subject: Re: [PATCH v11 3/9] drm/mediatek: add RDMA fifo size error handle
To:     CK Hu <ck.hu@mediatek.com>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 28, 2021 at 3:52 PM CK Hu <ck.hu@mediatek.com> wrote:
>
> Hi, Hsin-Yi:
>
> On Thu, 2021-01-28 at 15:27 +0800, Hsin-Yi Wang wrote:
> > From: Yongqiang Niu <yongqiang.niu@mediatek.com>
> >
> > This patch add RDMA fifo size error handle
> > rdma fifo size will not always bigger than the calculated threshold
> > if that case happened, we need set fifo size as the threshold
> >
> > Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> > ---
> >  drivers/gpu/drm/mediatek/mtk_disp_rdma.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > index b84004394970f..04b9542010b00 100644
> > --- a/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > +++ b/drivers/gpu/drm/mediatek/mtk_disp_rdma.c
> > @@ -168,6 +168,10 @@ void mtk_rdma_config(struct device *dev, unsigned int width,
> >        * account for blanking, and with a pixel depth of 4 bytes:
> >        */
> >       threshold = width * height * vrefresh * 4 * 7 / 1000000;
> > +
> > +     if (threshold > rdma_fifo_size)
> > +             threshold = rdma_fifo_size;
> > +
>
> Please see the discussion in [1].
>
> [1]
> https://patchwork.kernel.org/project/linux-mediatek/patch/1607591262-21736-6-git-send-email-yongqiang.niu@mediatek.com/
>
> Regards,
> CK
>

Hi CK,

Even if we set threshold to
threshold = RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) * width * height *
vrefresh / 2 / MAX_WIDTH / MAX_HEIGHT / MAX_VREFRESH;

I'm not sure what value MAX_WIDTH, MAX_HEIGHT, and MAX_VREFRESH should
set to for each SoC.
Since there's no conclusion yet, I'll drop this patch in the series,
as this seems not an mt8183 specific fix.


> >       reg = RDMA_FIFO_UNDERFLOW_EN |
> >             RDMA_FIFO_PSEUDO_SIZE(rdma_fifo_size) |
> >             RDMA_OUTPUT_VALID_FIFO_THRESHOLD(threshold);
>
