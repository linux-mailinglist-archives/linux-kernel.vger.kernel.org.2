Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A5EA3A71AF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 23:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231345AbhFNWBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 18:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231277AbhFNWBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 18:01:23 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497A8C061574;
        Mon, 14 Jun 2021 14:59:05 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id b9so17554567ybg.10;
        Mon, 14 Jun 2021 14:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TZ9IOmDtrZ7ni16mZAp2GrXLaKHRdUgj/PRjU6h2E4g=;
        b=hyJC88zcRBbPbmWSBxuipd4CSWNL1IvjA7MZr+nsTkzyjCH5iRWCnlMNpIRqS9el9c
         XtD8+XTXh5LqEx9SzMAm0LEcwpuklJ/GLTHUD0d1dwzRL0YXJcW6sDmRBZjCpkfb6wmv
         feY+aawuh7VyjZz39qiMoMbW4BzFHVyk6lrUx+HNkXCcjHuQxTgZCo1jE7jjy7F0scQz
         ZkFNTpUmQ61KIWhkjl4KzKvOxgFssx/2eZzBgXnY5jYkF8jKyFJ4MxwRnMu1nCJD8EsW
         zL9xKAm93+/jb6Cu1MinBAUjdETuB1JKJdb/lw6i6Jgmf/RhoOq48OHToUgxlTh7jKKM
         sTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TZ9IOmDtrZ7ni16mZAp2GrXLaKHRdUgj/PRjU6h2E4g=;
        b=ZbmYc21T9JS+bKdlhkV7TrOdEGZdzznJrPHOcU9c7sVtEA1g+Ka4rxpMf8DB974tgl
         948CwFN+DHe2ffJwgoekbAug6Y3gQRikH4HVlco273JUJOr+NicHSAVQ/sIl7o0tP8pd
         CXJIhDSqeppl5/0VUt705WPdfkIztZr9fuitp0PyBhqzjnEMzzZh1phEy3oKXfZghtr5
         XgmNiwCjBg/18ej5CLO2c3tTMMb8OFps9auS8bdafuc1WN0x3r09Q2N5qC5JUAwfKeuI
         XTLz9KoppINW2OgL2w8yuCHBVFSfUIRakuIDEGTK+nc8SZhc0B60Dvd9GTQzB2q2jEZp
         XqeA==
X-Gm-Message-State: AOAM5311e3JiKo0v446g9N/fHDOuFT6XTYM4Z5yDKcO09WvIQM65MZfZ
        5RYBQnw6eNlnTRqV+Y4c7Ru8ZlgAZebxpWsbv73Or6/ONt4N8A==
X-Google-Smtp-Source: ABdhPJwM4JriTTGxJctcBS5AHLq3/0YqXry11po9fnxM/+M939A6AkOG4ffHD4uRJYcu+d1NLAf1LXQjWPejUAOxq8E=
X-Received: by 2002:a25:db93:: with SMTP id g141mr28180078ybf.141.1623707944462;
 Mon, 14 Jun 2021 14:59:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210614154359.805555-1-benjamin.gaignard@collabora.com>
 <20210614154359.805555-4-benjamin.gaignard@collabora.com> <19d8cb97-d715-eb5f-5b2c-0c273937fd00@arm.com>
In-Reply-To: <19d8cb97-d715-eb5f-5b2c-0c273937fd00@arm.com>
From:   Peter Geis <pgwipeout@gmail.com>
Date:   Mon, 14 Jun 2021 17:58:52 -0400
Message-ID: <CAMdYzYrD=qtwAPc8tNRB8Ko-f_zhOVKiOsbgPPqpAi2MrDzSSA@mail.gmail.com>
Subject: Re: [PATCH 3/4] PHY: rockchip: USB2: Allow 64 bits reg property
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Benjamin Gaignard <benjamin.gaignard@collabora.com>, kishon@ti.com,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2021 at 1:09 PM Robin Murphy <robin.murphy@arm.com> wrote:
>
> On 2021-06-14 16:43, Benjamin Gaignard wrote:
> > In rk356x device-tree "reg" property could be coded on 64 bits.
> > Change reg type and of_property_read_ to make it works.
>
> On platforms with #address-cells=1, this isn't going to do what you
> think. Worse, it's not even going to fail, because you *can* read a
> 64-bit value from an address cell with a size cell after it...

Apologies, this was a hack and in no way ready for submission.

While I've got you here, what would be the best way to handle this?
Since previous generations #address-cells=1 and #size-cells=1, where
the rk356x #address-cells=2 and #size-cells=2 and we need to account
for both of them.

Thanks,
Peter

>
> Robin.
>
> > Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> > Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> > ---
> >   drivers/phy/rockchip/phy-rockchip-inno-usb2.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > index 46ebdb1460a3d..45518f96d7217 100644
> > --- a/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > +++ b/drivers/phy/rockchip/phy-rockchip-inno-usb2.c
> > @@ -1068,7 +1068,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
> >       struct rockchip_usb2phy *rphy;
> >       const struct rockchip_usb2phy_cfg *phy_cfgs;
> >       const struct of_device_id *match;
> > -     unsigned int reg;
> > +     u64 reg;
> >       int index, ret;
> >
> >       rphy = devm_kzalloc(dev, sizeof(*rphy), GFP_KERNEL);
> > @@ -1098,7 +1098,7 @@ static int rockchip_usb2phy_probe(struct platform_device *pdev)
> >               rphy->usbgrf = NULL;
> >       }
> >
> > -     if (of_property_read_u32(np, "reg", &reg)) {
> > +     if (of_property_read_u64(np, "reg", &reg)) {
> >               dev_err(dev, "the reg property is not assigned in %pOFn node\n",
> >                       np);
> >               return -EINVAL;
> >
