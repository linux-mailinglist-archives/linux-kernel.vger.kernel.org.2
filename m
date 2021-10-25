Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B060438E99
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Oct 2021 07:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232316AbhJYFIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Oct 2021 01:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbhJYFIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Oct 2021 01:08:13 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49923C061764
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 22:05:52 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id h196so13856324iof.2
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 22:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JA+P5A/sB4KzKsxDYjkyZmdfTZPWFEA1bTgclSJrZHw=;
        b=KiE1qXXhWLLbW4vwLmlblzb3wQokb4W7dv086jJ8+hR4oxplQJsQxQtLqdDFO36jDh
         yeFPmAygk8PKy/qe22rLWlu9GlOSwHI0wsZHKTmvoCN9nFiQAzj7N/2RgnpRWZChBh5L
         rF1o1gTosZ1RUTjANl2Mo7CJGeBf5PC0yzWZM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JA+P5A/sB4KzKsxDYjkyZmdfTZPWFEA1bTgclSJrZHw=;
        b=MJP+1Obf/9bpcyrq9ByukSZ68xXHIdIB5AH9eVnYBKako5ThxYv/p0Ic5oIRLJzFBQ
         sJWqPK+J2hvgY3NeFa1loGLBPybRWVukdQ7ERnQqSFNU6967DrR60FNSGoXZJwVgtSa1
         AB9FmqnlPg0F4465PJ49hp+19nnA3gwTYJBgmRz4ataj03MTw9/Pn6dLoEaZftrAJugs
         KdPNCZSI6I2Il4y0r/1B27DN1Wb5zEky9OXCnchOMfxRJYS0qr8KBbw9BwWLL8BkYksv
         7Ts8+ygHiD99oaC+agidbIkIwD2luSR7KqB9Ub0yvB8CrNISBN5j81zUQaa8hGdWQCY/
         83JQ==
X-Gm-Message-State: AOAM531n2H0TC1YRz8iheeDadeYwkkE8SfcRboEz+n6e86+B75YT1EDE
        0Z+BSYNO9FWV3yeR+06Om4t9p8zjvXJkBg==
X-Google-Smtp-Source: ABdhPJyIKMvMFNM2dZAzpAL2Q59edodTZUV+v6eWEUB0H/rEKgsIyTXTjqu50cgSRYivM+j7ngLYdA==
X-Received: by 2002:a05:6638:134f:: with SMTP id u15mr9050076jad.145.1635138351311;
        Sun, 24 Oct 2021 22:05:51 -0700 (PDT)
Received: from mail-il1-f181.google.com (mail-il1-f181.google.com. [209.85.166.181])
        by smtp.gmail.com with ESMTPSA id x3sm4518208iov.26.2021.10.24.22.05.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 Oct 2021 22:05:50 -0700 (PDT)
Received: by mail-il1-f181.google.com with SMTP id 3so8990105ilq.7
        for <linux-kernel@vger.kernel.org>; Sun, 24 Oct 2021 22:05:50 -0700 (PDT)
X-Received: by 2002:a05:6602:2e95:: with SMTP id m21mr9431453iow.21.1635138339804;
 Sun, 24 Oct 2021 22:05:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210921155218.10387-1-jason-jh.lin@mediatek.com>
 <20210921155218.10387-10-jason-jh.lin@mediatek.com> <8b509551-7cfa-f55c-fc0f-db7d0a3886eb@collabora.com>
 <29992126d39a7f381a516fdb9cd6e39f1e51afdb.camel@mediatek.com>
In-Reply-To: <29992126d39a7f381a516fdb9cd6e39f1e51afdb.camel@mediatek.com>
From:   Fei Shao <fshao@chromium.org>
Date:   Mon, 25 Oct 2021 13:05:03 +0800
X-Gmail-Original-Message-ID: <CAC=S1niq+b4ue6nPLNT5JEiugh5UFDDL3hEYrUua0AzQ_+YeXA@mail.gmail.com>
Message-ID: <CAC=S1niq+b4ue6nPLNT5JEiugh5UFDDL3hEYrUua0AzQ_+YeXA@mail.gmail.com>
Subject: Re: [PATCH v11 09/16] soc: mediatek: add mtk-mmsys support for mt8195 vdosys0
To:     Jason-JH Lin <jason-jh.lin@mediatek.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        hsinyi@chromium.org, moudy.ho@mediatek.com,
        roy-cw.yeh@mediatek.com, Fabien Parent <fparent@baylibre.com>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        nancy.lin@mediatek.com, singo.chang@mediatek.com,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2021 at 6:13 PM Jason-JH Lin <jason-jh.lin@mediatek.com> wrote:
>
> Hi Angelo,
>
> Thanks for the reviews.
>
>
> On Thu, 2021-10-14 at 16:05 +0200, AngeloGioacchino Del Regno wrote:
> > > Add mt8195 vdosys0 clock driver name and routing table to
> > > the driver data of mtk-mmsys.
> > >
>
> [snip]
>
> > >
> > > ---
> >
> > Hello Jason,
> > thanks for the patch! However, there are a few things to improve:
> >
>
> [snip]
>
> > > +#define MT8195_VDO0_SEL_IN                                 0xf34
> > > +#define MT8195_SEL_IN_VPP_MERGE_FROM_DSC_WRAP0_OUT         (0 <<
> > > 0)
> >
> > Bitshifting 0 by 0 bits == 0, so this is simply 0.
> >
> > > +#define MT8195_SEL_IN_VPP_MERGE_FROM_DISP_DITHER1          (1 <<
> > > 0)
> >
> > I would write 0x1 here
> >
> > > +#define MT8195_SEL_IN_VPP_MERGE_FROM_VDO1_VIRTUAL0         (2 <<
> > > 0)
> >
> > ....and 0x2 here: bitshifting of 0 bits makes little sense.
> >
> > > +#define MT8195_SEL_IN_DSC_WRAP0_IN_FROM_DISP_DITHER0
> > > (0 << 4)
> >
> > Bitshifting 0 by 4 bits is still 0, so this is again 0.
> > This is repeated too many times, so I will not list it for all of the
> > occurrences.
> >
> > > +#define MT8195_SEL_IN_DSC_WRAP0_IN_FROM_VPP_MERGE          (1 <<
> > > 4)
> >
> > This is BIT(4).
> >
> > > +#define MT8195_SEL_IN_DSC_WRAP1_IN_FROM_DISP_DITHER1
> > > (0 << 5) > +#define MT8195_SEL_IN_DSC_WRAP1_IN_FROM_VPP_MERGE
> > >     (1 << 5)
> >
> > ...and this is BIT(5)
> >
> > > +#define MT8195_SEL_IN_SINA_VIRTUAL0_FROM_VPP_MERGE         (0 <<
> > > 8)
> > > +#define MT8195_SEL_IN_SINA_VIRTUAL0_FROM_DSC_WRAP1_OUT
> > > (1 << 8)
> >
> > BIT(8)
> >
> > > +#define MT8195_SEL_IN_SINB_VIRTUAL0_FROM_DSC_WRAP0_OUT
> > > (0 << 9)
> > > +#define MT8195_SEL_IN_DP_INTF0_FROM_DSC_WRAP1_OUT          (0 <<
> > > 12)
> > > +#define MT8195_SEL_IN_DP_INTF0_FROM_VPP_MERGE
> > > (1 << 12)
> >
> > BIT(12)
> >
> > > +#define MT8195_SEL_IN_DP_INTF0_FROM_VDO1_VIRTUAL0          (2 <<
> > > 12)
> >
> > BIT(13)
> >
> > ... and please, use the BIT(nr) macro for all these bit definitions,
> > it's way more
> > readable like that.
> >
> > Regards,
> > - Angelo
>
> Because the HW register design of MT8195_VDO0_SEL_IN 0xf34 is like
> this:
>
> bit[1:0] as MT8195_SEL_IN_VPP_MERGE and
>   value: 0 as MT8195_SEL_IN_VPP_MERGE_FROM_DSC_WRAP0_OUT
>   value: 1 as MT8195_SEL_IN_VPP_MERGE_FROM_DISP_DITHER1
>   value: 2 as MT8195_SEL_IN_VPP_MERGE_FROM_VDO1_VIRTUAL0
> bit[4:4] as MT8195_SEL_IN_DSC_WRAP0_IN and
>   value 0 as MT8195_SEL_IN_DSC_WRAP0_IN_FROM_DISP_DITHER0
>   value 1 as MT8195_SEL_IN_DSC_WRAP0_IN_FROM_VPP_MERGE
> bit[5:5] as MT8195_SEL_IN_DSC_WRAP1_IN and
>   value 0 as
> MT8195_SEL_IN_DSC_WRAP1_IN_FROM_DISP_DITHER1
>   value 1 as
> MT8195_SEL_IN_DSC_WRAP1_IN_FROM_VPP_MERGE
> and so on...
>
> I think using BIT(nr) macro directly is not easy to debug.
>
>
> Is it better to define another MACRO like this?
>
> #define BIT_VAL(val, bit)  ((val) << (bit))
> #define MT8195_SEL_IN_DSC_WRAP0_IN_FROM_DISP_DITHER0  BIT_VAL(0, 4)
> #define MT8195_SEL_IN_DSC_WRAP0_IN_FROM_VPP_MERGE  BIT_VAL(1, 4)
> ...
>
> or
>
> #define MT8195_SEL_IN_DSC_WRAP0_IN (4)
> #define MT8195_SEL_IN_DSC_WRAP0_IN_FROM_DISP_DITHER0  (0
> << MT8195_SEL_IN_DSC_WRAP0_IN)
> #define MT8195_SEL_IN_DSC_WRAP0_IN_FROM_VPP_MERGE  (1 <<
> MT8195_SEL_IN_DSC_WRAP0_IN)
> ...
>
> What do you think?

Hi Jason,

If that's the case you can still use BIT(nr) for the definitions and
describe their usage in the comment, so both code readability and the
ease of maintenance are preserved, and people can easily tell if there
are duplicated/missing definitions while reading through the code.
Adding informative comments is never a bad thing.

I would do something like this (and further split the definitions into
sections by their functionalities with blank lines for visual
comfort):

/*
 * MT8195_VDO0_SEL_IN[1:0]: VPP_MERGE
 *   0x0 : DSC_WRAP0_OUT
 *   0x1 : DISP_DITHER1
 *   0x10: VDO1_VIRTUAL0
 */
#define MT8195_SEL_IN_VPP_MERGE_FROM_DSC_WRAP0_OUT           0
#define MT8195_SEL_IN_VPP_MERGE_FROM_DISP_DITHER1            BIT(0)
#define MT8195_SEL_IN_VPP_MERGE_FROM_VDO1_VIRTUAL0           BIT(1)

/*
 * MT8195_VDO0_SEL_IN[4:4]: DSC_WRAP0_IN
 *   0x0: DISP_DITHER0
 *   0x1: VPP_MERGE
 */
#define MT8195_SEL_IN_DSC_WRAP0_IN_FROM_DISP_DITHER0         0
#define MT8195_SEL_IN_DSC_WRAP0_IN_FROM_VPP_MERGE            BIT(4)
... and so on.

Regards,
Fei

>
>
> Regards,
> Jason-JH Lin <jason-jh.lin@mediatek.com>
>
