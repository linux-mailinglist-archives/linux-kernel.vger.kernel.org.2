Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE2983F6DEA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 05:50:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237967AbhHYDvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 23:51:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238513AbhHYDuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 23:50:40 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB350C061764
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:49:54 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r19so34834920eds.13
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 20:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vanguardiasur-com-ar.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=3kZXI1vtvS0Yvb6slBFRI9pS9XAeJXzQm2yXW938Umo=;
        b=rYLlw4fbNP1HTkXasUqH8ZRD7nxcL0P7KPGpLdqgwnOWslAsIhC9jnsZlxrx5otqpo
         0N0Z+R3+Qd9VBsJP0pp/X6mjgcKX3uDeXXaB5/YKqIdbBniid8BqTFbbBMuUFH7VRQ2T
         Gzc7ZpquX6irb4GDSnakgLUYLUbs6xRt4YJIpJX+XMSY3x77cXB6jDgxNm+O18zr5b8A
         kTeVsXIQ2igplvXzF6erSAKUInYqMD2njfkNLSEu8YQh/71OI4SqC48mpwOC+CZoa+ol
         I86mqWiZk1OM2fNoHpEGJrBm8W8vMZr1pSS/ixy3CwCqtxKi/Hz96FMuVoW6m/o4UpRv
         PLHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=3kZXI1vtvS0Yvb6slBFRI9pS9XAeJXzQm2yXW938Umo=;
        b=C1i6UWUfYlH0v6onPLoMHw4Ql9itxQwCTcsXuGegbGF43V311XCOhHGyspvzMEU+xh
         O4f8AVmxzAw9y05pHFpTLc6Mubm5svDTaKWS7otwcwRoqA6t2SyGZ0sS95lp86lSxpwp
         Urq0BjaYSzQJ4ee+4jokOpKU0jgi+6vM5BNzW0vjLXkptefXfpYUvgEMvVf2F1gxUb9o
         DkC0ltp6tZYU2zFLmflWigpR7r9vkdp+i2U6DRZoxpdZNTzRFWnUOJeb0/l6W4Dz6R8D
         wBx/LrZ1baduavj3FI+WGT4JxCkMIGtTPewkowEbtig603cZfAxstB9pP5NowXYqf58S
         1EXw==
X-Gm-Message-State: AOAM5329DrsPv/N7ViHD++SR5qLLP9VhrpbdnXPcHeEumHaIn0UByncl
        gJeKe0HyEm2qAGGvgaP3nhWMFRDyNa0FVJzvqiMylA==
X-Google-Smtp-Source: ABdhPJz6WxJB9n9R0lhxCYrp90OGkbSPfI3upiI7vUcraPT3a8lXeVRKeYJ+3pLVzsidvy6f73vg7LbF70pb18gBPoI=
X-Received: by 2002:a05:6402:693:: with SMTP id f19mr20106726edy.213.1629863393359;
 Tue, 24 Aug 2021 20:49:53 -0700 (PDT)
MIME-Version: 1.0
References: <20210816105934.28265-1-irui.wang@mediatek.com>
 <20210816105934.28265-2-irui.wang@mediatek.com> <CAAEAJfDoSW3F85bFKTRvvGZXTZbCBRpUwZzEyx3zhrA6psiZfA@mail.gmail.com>
 <6efbfdbac55c5c8175168be96d3a2e63b4ac0f07.camel@mediatek.com>
In-Reply-To: <6efbfdbac55c5c8175168be96d3a2e63b4ac0f07.camel@mediatek.com>
From:   Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
Date:   Wed, 25 Aug 2021 00:49:41 -0300
Message-ID: <CAAEAJfBvWDqtb8oqxx9zosEbBhFVMiszG2cu=Y7OXx3-T4gAOQ@mail.gmail.com>
Subject: Re: [PATCH 1/9] dt-bindings: media: mtk-vcodec: Add binding for
 MT8195 two venc cores
To:     =?UTF-8?B?SXJ1aSBXYW5nICjnjovnkZ4p?= <Irui.Wang@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        =?UTF-8?B?TG9uZ2ZlaSBXYW5nICjnjovpvpnpo54p?= 
        <Longfei.Wang@mediatek.com>,
        =?UTF-8?B?VGlmZmFueSBMaW4gKOael+aFp+ePiik=?= 
        <tiffany.lin@mediatek.com>,
        "frkoenig@chromium.org" <frkoenig@chromium.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        =?UTF-8?B?TWFvZ3VhbmcgTWVuZyAo5a2f5q+b5bm/KQ==?= 
        <Maoguang.Meng@mediatek.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "tzungbi@chromium.org" <tzungbi@chromium.org>,
        =?UTF-8?B?WXVuZmVpIERvbmcgKOiRo+S6kemjnik=?= 
        <Yunfei.Dong@mediatek.com>,
        =?UTF-8?B?WW9uZyBXdSAo5ZC05YuHKQ==?= <Yong.Wu@mediatek.com>,
        srv_heupstream <srv_heupstream@mediatek.com>,
        "tfiga@google.com" <tfiga@google.com>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "hsinyi@chromium.org" <hsinyi@chromium.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?UTF-8?B?QW5kcmV3LUNUIENoZW4gKOmZs+aZuui/qik=?= 
        <Andrew-CT.Chen@mediatek.com>,
        "acourbot@chromium.org" <acourbot@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Aug 2021 at 23:04, Irui Wang (=E7=8E=8B=E7=91=9E) <Irui.Wang@med=
iatek.com> wrote:
>
> Hi,Ezequiel,
>
> Thanks for your reviewing.
>
> On Tue, 2021-08-24 at 08:02 -0300, Ezequiel Garcia wrote:
> > Hi Irui,
> >
> > On Mon, 16 Aug 2021 at 08:00, Irui Wang <irui.wang@mediatek.com>
> > wrote:
> > >
> > > Enable MT8195 two H.264 venc cores, updates vcodec binding
> > > document.
> > >
> > > Signed-off-by: Irui Wang <irui.wang@mediatek.com>
> > > ---
> > >  Documentation/devicetree/bindings/media/mediatek-vcodec.txt | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/media/mediatek-
> > > vcodec.txt b/Documentation/devicetree/bindings/media/mediatek-
> > > vcodec.txt
> > > index de961699ba0a..eb2e24c32426 100644
> > > --- a/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > > +++ b/Documentation/devicetree/bindings/media/mediatek-vcodec.txt
> > > @@ -11,6 +11,8 @@ Required properties:
> > >    "mediatek,mt8173-vcodec-dec" for MT8173 decoder.
> > >    "mediatek,mt8192-vcodec-enc" for MT8192 encoder.
> > >    "mediatek,mt8195-vcodec-enc" for MT8195 encoder.
> > > +  "mediatek,mtk-venc-core0" for MT8195 avc core0 device.
> > > +  "mediatek,mtk-venc-core1" for MT8195 avc core1 device.
> >
> > What is the difference between core0 and core1?
> >
> > Thanks,
> > Ezequiel
>
> Both core0 and core1 are H264 encoder hardware, they have their own
> hardware register base, used power-domains/clocks/irqs. We can use any
> of them for H.264 encoding, but the two cores can work together for
> higher performance, it's called "frame racing", a hardware encoding
> mode, control flow just like in the commit messages:
>
> core0 frame#0.frame#2.frame#4...
> core1    frame#1.frame#3.frame#5...
>

If they are two encoder cores, why do you need different compatible strings=
?

It would be interesting to see a device tree which shows how this should
be used in the real world, but from the looks of it, it seems you don't
need a separate compatible.

It seems this series is somewhat related to Yunfei's "[PATCH v5,
00/15] Using component framework to support multi hardware decode",
but I don't see a device tree patch either in that series.

Given this is a complex architecture, I don't know if it
makes sense to discuss decoder and encoder independently.

If you guys unify the two series, and add the device tree patches for it,
or at least for the most complex cases, maybe that will surface the
architecture more clearly and come up with an easier solution that
doesn't involve
an async framework to pull in the parts together.

Thanks,
Ezequiel
