Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9055C3BB8A2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 10:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhGEIMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 04:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbhGEIMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 04:12:07 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A92AC061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 01:09:30 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id d9so19991189ioo.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 01:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZBH9ykzeoMrqSlrgZpvseA7xgJC3UHZbKlTJSyxYYE=;
        b=vMJVUcrQnNHyGr1e2E/BBoCJ6Ml9vmYjG8w3y4ezQrmHEogj/M4Ky5n/R11b3OUHP+
         GA0To8jdS+EcmI5/P9/WIwMSOKXzdcpQ56ciPZXsLuzhCebjrvgAjKMVj0ZSx/Rh9bv+
         oXlnbv/La5iOfvDexZJU47ZVPg07ff2LAUCfOgs6Y1t84ZdmUZwHHXcFdMnDGr08ohIi
         jAg4g2iJ6DEwZqa8bdRZInOXHa9ciiu9rr19zEl8/2xix+m5y77dPZvww9IhHTwvkUIg
         fume5Bf4qhsquNTGV8+6wI8MJW55gP3FMqs1E+rG3ZTrB4s3NzG7t1aErBKD70HBEFdZ
         dY8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZBH9ykzeoMrqSlrgZpvseA7xgJC3UHZbKlTJSyxYYE=;
        b=mlj8cszP8ZUpVpjCiLQu2Uo0Qw4wrkh5FJbf1S6z99FdSiLQDxsARlN/61d6HS0zAr
         AF1idF8sOpGQZTNeiw8eaNJOBr/SoecU/fheeIWLFI4+2aFHvZoT+ZycyYlzCG+VGJUc
         yOkaffIyVxz6E2wWJ4bFxKTRz2Tj5P68CZen8sRkQlxHGp7sG7CuzAVQJvEcM14bFIYV
         yh1eEj/SK7/OJ3T69IStfU90/d4Xn1jDfw+hQXqLPQ8mBXwtVMjI4ZzrmPPAyTocxmWu
         aZwy3bBgrxi2dA7FXzDbXO+VTQsRKcf0KilCfdXKJF9SOYlfXC65t0s1NRXhAc0LLaiT
         Fb5A==
X-Gm-Message-State: AOAM532FRdAozXAAHk4yQJkdaOtEF9p7+EJYWgFvLjpN7mBvJ8tEAhFn
        wA5UDyYatKsszH9OsG8nnjRP7+8d+RSJk+xNk0vuyQ==
X-Google-Smtp-Source: ABdhPJwhLvFCwfzhhvvHGLbA3HvWk2qBShYvoOt9KTiT7lVNLd4KXAYWkrfEYA95oI9qjWhL1m8bENMubRJRcwBEMEc=
X-Received: by 2002:a5e:a612:: with SMTP id q18mr10954029ioi.76.1625472569703;
 Mon, 05 Jul 2021 01:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <1624428350-1424-1-git-send-email-kyrie.wu@mediatek.com>
 <1624428350-1424-2-git-send-email-kyrie.wu@mediatek.com> <CA+Px+wW6PrYihYo8F2Op8XPfVHMmO7ODRQrF75DQxc4gRM-qfg@mail.gmail.com>
 <1625039759.22769.3.camel@mhfsdcap03>
In-Reply-To: <1625039759.22769.3.camel@mhfsdcap03>
From:   Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 5 Jul 2021 16:09:18 +0800
Message-ID: <CA+Px+wUXK2t42S0HgcOj7_kbkSskHGris5LBquTS3d+hi8kCaQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: mtk-jpeg: Add binding for MT8195 JPG
To:     "kyrie.wu" <kyrie.wu@mediatek.com>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Rick Chang <rick.chang@mediatek.com>,
        Bin Liu <bin.liu@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Tzung-Bi Shih <tzungbi@chromium.org>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Tomasz Figa <tfiga@chromium.org>, xia.jiang@mediatek.com,
        maoguang.meng@mediatek.com, srv_heupstream@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 3:56 PM kyrie.wu <kyrie.wu@mediatek.com> wrote:
> Mt8195 has two hardwares, "mediatek,mt8195-jpgenc0" for hw0 and
> "mediatek,mt8195-jpgenc1" for HW1. These two nodes will register
> hardware interrupt, initialize clock, power domain, remap register base
> addr and other operations. But the device node is not registered.
> "mediatek,mt8195-jpgenc" will register the device node to represent jpeg
> encode device. Then the component framework is used to manage the above
> two hardwares.
Please don't top-posting.  Inline your replies so that people can
easily follow the discussion.

I still don't quite understand why it needs to introduce 2 compatible
strings.  If hw0 and hw1 are different from interrupts, clocks, power
domain, and etc, couldn't you use the same compatible string (e.g.
"mt8195-jpgenc") and provide them different DT attributes?

> On Fri, 2021-06-25 at 17:18 +0800, Tzung-Bi Shih wrote:
> > On Wed, Jun 23, 2021 at 2:06 PM kyrie.wu <kyrie.wu@mediatek.com> wrote:
> > >  Documentation/devicetree/bindings/media/mediatek-jpeg-encoder.txt | 3 +++
> > >  1 file changed, 3 insertions(+)
> > Note: the patch won't apply after [1].
> >
> > [1]: https://lore.kernel.org/patchwork/patch/1445298/
> >
> > >  Required properties:
> > >  - compatible : "mediatek,mt2701-jpgenc"
> > > +- compatible : "mediatek,mt8195-jpgenc"
> > > +- compatible : "mediatek,mt8195-jpgenc0"
> > > +- compatible : "mediatek,mt8195-jpgenc1"
> > Why it needs 3 compatible strings?
