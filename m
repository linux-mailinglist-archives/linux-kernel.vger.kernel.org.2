Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A483C3219AD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Feb 2021 15:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232216AbhBVODE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Feb 2021 09:03:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231782AbhBVNE3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Feb 2021 08:04:29 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C814C06178A
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 05:03:43 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id n20so3250262ejb.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 05:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlW7XnTvf80UJ2UJ2BIr+dCpf/fNb2YhvZlxuKGK+8w=;
        b=iXJHz8iNMrs+0cRv74pIBMAisNBBDsB/6Sih+cPhatxrsQG8p2Y35qB/kZrmUNVj/b
         R3LDmXnBr4iWvHf7dvG6C30ShvtlOGvIZLdLdSVTCJ1KdsbXhAyU06fI1ccJnwV5wO4H
         xidhvUyRAPY8lDEH6+GQ2WFuFuxJAjORo0r/E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlW7XnTvf80UJ2UJ2BIr+dCpf/fNb2YhvZlxuKGK+8w=;
        b=LqevX0ERIkBnsPtEArk+d4n65QS4gLgtm+o30GlhGtNWJAXDQf4kOrShv0Q6Cd1CJd
         zHZfMBPzA8Ye2m7ovz6bOxPa8le9IUfQ8BYOxnpxcbKCINBv3fc1C97hOUgnfnIk5/VQ
         GIwuPL8nsRRHBeIuXJh/OKqOmJkoKuTSSC5WiwWohLrXyaK5axwNr8slgRvtJKi6OERm
         81qqMKiw3i5lMIiAJ0fz9EQe1AsU1JqvdhDOiBnw+A/WjeS+LTulE0O923OcbQHYczCl
         c+aJ+kTuJIzKipBwODNdtaqL85NWc7oQ6FdsjEd6ZAoAsEcgUO5BEnu+EWiYg8GSswt7
         g6VQ==
X-Gm-Message-State: AOAM530E0kMfc+7/7fuG5oJ0t2rzRXLgdyxQvF1cgzM0dI+BXYOHSp7J
        8cwZ+2sZrinyC8Mdw5+LnIAmqDqlQBFFTQ==
X-Google-Smtp-Source: ABdhPJzBhZDfTiZ3zYIR16fATGtzoEWUu8Z2Ij0Feo/rrt1PFSL2qhaWf5uD7kwjPfxG4UdXMP9uwg==
X-Received: by 2002:a17:906:66cc:: with SMTP id k12mr4519035ejp.382.1613999021494;
        Mon, 22 Feb 2021 05:03:41 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id r1sm11698769eds.70.2021.02.22.05.03.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Feb 2021 05:03:38 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id z22so21749695edb.9
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 05:03:38 -0800 (PST)
X-Received: by 2002:a05:6402:445:: with SMTP id p5mr23004309edw.20.1613999018242;
 Mon, 22 Feb 2021 05:03:38 -0800 (PST)
MIME-Version: 1.0
References: <20210121061804.26423-1-irui.wang@mediatek.com>
 <20210121061804.26423-3-irui.wang@mediatek.com> <CAPBb6MXqFU+-f4C=BaW9d_KyEUwZVTiBj-dqqxnGP-Zd7YkMVw@mail.gmail.com>
 <1613804103.896.27.camel@mhfsdcap03>
In-Reply-To: <1613804103.896.27.camel@mhfsdcap03>
From:   Alexandre Courbot <acourbot@chromium.org>
Date:   Mon, 22 Feb 2021 22:03:02 +0900
X-Gmail-Original-Message-ID: <CAPBb6MVKAhdcc-r8cJyx5wz2qTHU5BB5FE939b5fepaze8N+ew@mail.gmail.com>
Message-ID: <CAPBb6MVKAhdcc-r8cJyx5wz2qTHU5BB5FE939b5fepaze8N+ew@mail.gmail.com>
Subject: Re: [PATCH 3/3] media: mtk-vcodec: Separating mtk encoder driver
To:     Irui Wang <irui.wang@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tomasz Figa <tfiga@google.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Maoguang Meng <maoguang.meng@mediatek.com>,
        Longfei Wang <longfei.wang@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        srv_heupstream@mediatek.com,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 20, 2021 at 3:56 PM Irui Wang <irui.wang@mediatek.com> wrote:
>
> On Wed, 2021-02-03 at 19:44 +0900, Alexandre Courbot wrote:
> > Hi Irui,
> >
> > Thanks for pushing this forward. I had two small conflicts when
> > applying this patch to the media tree, so you may want to rebase
> > before sending the next version. Please see the comments inline.
> >
> > On Thu, Jan 21, 2021 at 3:18 PM Irui Wang <irui.wang@mediatek.com> wrote:
> > >
> > > MTK H264 Encoder(VENC_SYS) and VP8 Encoder(VENC_LT_SYS) are two
> > > independent hardware instance. They have their owner interrupt,
> > > register mapping, and special clocks.
> > >
> > > This patch seperates them into two drivers:
> >
> > seperates -> separates
> >
> > Also the patch does not result in two drivers, but two devices.
> >
> > > User Call "VIDIOC_QUERYCAP":
> > > H264 Encoder return driver name "mtk-vcodec-enc";
> > > VP8 Encoder return driver name "mtk-venc-vp8.
> >
> > I wonder if we need to use two different names? The driver is the
> > same, so it makes sense to me that both devices return
> > "mtk-vcodec-enc". Userspace can then list the formats on the CAPTURE
> > queue in order to query the supported codecs.
> >
> I'm afraid we can't, there is a symlink when chrome use the
> encoder(50-media.rules):
> ATTR{name} == "mtk-vcodec-enc", SYMLINK+="video-enc"
> ATTR{name} == "mtk-venc-vp8", SYMLINK+="video-enc0"
> if we use the same name,how userspace access the encoder? maybe there
> will be some modifications are needed in VEA(for example)?

Chrome OS can use a different udev rule to differentiate the two
nodes. Actually I already have a CL to support this:

https://chromium-review.googlesource.com/c/chromiumos/overlays/board-overlays/+/2673592

So both nodes being named the same won't be a problem for Chrome OS,
and makes more sense for an upstream merge anyway.

Cheers,
Alex.
