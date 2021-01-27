Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E82730542D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 08:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233303AbhA0HN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 02:13:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S317532AbhA0Apg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 19:45:36 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7135EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 16:44:54 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id k132so407246ybf.2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 16:44:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cZ1VOxuGzH4//g/DaFwaGuEQdEVHQtm8F+WWpgu+EU4=;
        b=YFwJyraNsG0Ipsao5vP9jRz0JyTwxqIANtk6nOQvZcx29nRAsdCLR454XFhdNB/idA
         a3FNw884X2BUO1qiZsLlgWPb+/KCVDt3R+chLAaTpm17Fua/LBF+uUKkAf7aOi9HrG9p
         5dpDZ8ieVaz3zoxM5tOHYe16Jw9bnA4d96zpVhB9gPwYy/GWLl/RKqHBBalAj9es8iCH
         /tiEeD08cviEUow2rlvj1zDrv+FrDqCUzEM+A4rD6vr+xtrZoz1J//6JSZ82sFxVLi/5
         Xp2fPWAgj666ooBEDH3gmcJ8tnwxPVi3dqK6yGJEh3FiUN+W2E9P9zRPX78dyoM16Mzk
         xWKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cZ1VOxuGzH4//g/DaFwaGuEQdEVHQtm8F+WWpgu+EU4=;
        b=mslXXEXmPtC+YvTji8fsz6MrAvXtUjAOG19JIchIqP0fbIb8jYmCFAvZSsqCDORT5R
         M3V9BbJ7S+gKPPv++Lq1WJtanJQPlupSpXyBRC8RYfme0BbNExYAuIXy6HfMZUuWGHXI
         Y645R8Se2MQYzXadyup2N6wG9chNRGF96i4yTHVP2PF+lNh/YsRu3Ou5eDn8cDWVtfGW
         /zqlLEchlio9aJYmqEqRwcr7daFhWA6KX4yovrLrk//mWc2iCFYf0ydAiS+QvkZDl4QG
         iUXh7gNhvS3oIZ4EQH5Wv5u3osjQ04XCH+0JIQmdGKFooQAMLd/XybmwYIslleI23jOd
         Psfg==
X-Gm-Message-State: AOAM533lVptgJIgnmwp5rH0gEbd79pqSJpBrXYVGRyTuL4PUTtluhANU
        lT0fk0s26W0e39nxF7YRuB48F6gb3UZgbDFgcns/Rg==
X-Google-Smtp-Source: ABdhPJz06rM3i8q6OzxaIC/5CSA959lRbZ/D6V9CzjqmU5rjnj+8/8N4uqtfABX3dPXZ1Isz9zmWSUJ0cBdlthZyPRw=
X-Received: by 2002:a25:f8a:: with SMTP id 132mr12458631ybp.228.1611708293540;
 Tue, 26 Jan 2021 16:44:53 -0800 (PST)
MIME-Version: 1.0
References: <20210120105246.23218-1-michael@walle.cc> <CAL_JsqLSJCLtgPyAdKSqsy=JoHSLYef_0s-stTbiJ+VCq2qaSA@mail.gmail.com>
 <CAGETcx86HMo=gaDdXFyJ4QQ-pGXWzw2G0J=SjC-eq4K7B1zQHg@mail.gmail.com>
 <c3e35b90e173b15870a859fd7001a712@walle.cc> <CAGETcx8eZRd1fJ3yuO_t2UXBFHObeNdv-c8oFH3mXw6zi=zOkQ@mail.gmail.com>
 <f706c0e4b684e07635396fcf02f4c9a6@walle.cc> <CAGETcx8_6Hp+MWFOhRohXwdWFSfCc7A=zpb5QYNHZE5zv0bDig@mail.gmail.com>
 <CAMuHMdWvFej-6vkaLM44t7eX2LpkDSXu4_7VH-X-3XRueXTO=A@mail.gmail.com>
 <a24391e62b107040435766fff52bdd31@walle.cc> <CAGETcx8FO+YSM0jwCnDdnvE3NCdjZ=1FSmAZpyaOEOvCgd4SXw@mail.gmail.com>
 <CAMuHMdX8__juNc-Lx8Tu9abMKq-pT=yA4s6D1w4ZeStKOasGpg@mail.gmail.com>
In-Reply-To: <CAMuHMdX8__juNc-Lx8Tu9abMKq-pT=yA4s6D1w4ZeStKOasGpg@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 26 Jan 2021 16:44:17 -0800
Message-ID: <CAGETcx-0G-Y8wT_+BfP5vbi0gW6KonwgoJ6DdqjaGbFkutTGag@mail.gmail.com>
Subject: Re: [PATCH] PCI: dwc: layerscape: convert to builtin_platform_driver()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Michael Walle <michael@walle.cc>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Roy Zang <roy.zang@nxp.com>, PCI <linux-pci@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 26, 2021 at 12:50 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Mon, Jan 25, 2021 at 11:42 PM Saravana Kannan <saravanak@google.com> wrote:
> > On Mon, Jan 25, 2021 at 11:49 AM Michael Walle <michael@walle.cc> wrote:
> > > Am 2021-01-21 12:01, schrieb Geert Uytterhoeven:
> > > > On Thu, Jan 21, 2021 at 1:05 AM Saravana Kannan <saravanak@google.com>
> > > > wrote:
> > > >> On Wed, Jan 20, 2021 at 3:53 PM Michael Walle <michael@walle.cc>
> > > >> wrote:
> > > >> > Am 2021-01-20 20:47, schrieb Saravana Kannan:
> > > >> > > On Wed, Jan 20, 2021 at 11:28 AM Michael Walle <michael@walle.cc>
> > > >> > > wrote:
> > > >> > >>
> > > >> > >> [RESEND, fat-fingered the buttons of my mail client and converted
> > > >> > >> all CCs to BCCs :(]
> > > >> > >>
> > > >> > >> Am 2021-01-20 20:02, schrieb Saravana Kannan:
> > > >> > >> > On Wed, Jan 20, 2021 at 6:24 AM Rob Herring <robh@kernel.org> wrote:
> > > >> > >> >>
> > > >> > >> >> On Wed, Jan 20, 2021 at 4:53 AM Michael Walle <michael@walle.cc>
> > > >> > >> >> wrote:
> > > >> > >> >> >
> > > >> > >> >> > fw_devlink will defer the probe until all suppliers are ready. We can't
> > > >> > >> >> > use builtin_platform_driver_probe() because it doesn't retry after probe
> > > >> > >> >> > deferral. Convert it to builtin_platform_driver().
> > > >> > >> >>
> > > >> > >> >> If builtin_platform_driver_probe() doesn't work with fw_devlink, then
> > > >> > >> >> shouldn't it be fixed or removed?
> > > >> > >> >
> > > >> > >> > I was actually thinking about this too. The problem with fixing
> > > >> > >> > builtin_platform_driver_probe() to behave like
> > > >> > >> > builtin_platform_driver() is that these probe functions could be
> > > >> > >> > marked with __init. But there are also only 20 instances of
> > > >> > >> > builtin_platform_driver_probe() in the kernel:
> > > >> > >> > $ git grep ^builtin_platform_driver_probe | wc -l
> > > >> > >> > 20
> > > >> > >> >
> > > >> > >> > So it might be easier to just fix them to not use
> > > >> > >> > builtin_platform_driver_probe().
> > > >> > >> >
> > > >> > >> > Michael,
> > > >> > >> >
> > > >> > >> > Any chance you'd be willing to help me by converting all these to
> > > >> > >> > builtin_platform_driver() and delete builtin_platform_driver_probe()?
> > > >> > >>
> > > >> > >> If it just moving the probe function to the _driver struct and
> > > >> > >> remove the __init annotations. I could look into that.
> > > >> > >
> > > >> > > Yup. That's pretty much it AFAICT.
> > > >> > >
> > > >> > > builtin_platform_driver_probe() also makes sure the driver doesn't ask
> > > >> > > for async probe, etc. But I doubt anyone is actually setting async
> > > >> > > flags and still using builtin_platform_driver_probe().
> > > >> >
> > > >> > Hasn't module_platform_driver_probe() the same problem? And there
> > > >> > are ~80 drivers which uses that.
> > > >>
> > > >> Yeah. The biggest problem with all of these is the __init markers.
> > > >> Maybe some familiar with coccinelle can help?
> > > >
> > > > And dropping them will increase memory usage.
> > >
> > > Although I do have the changes for the builtin_platform_driver_probe()
> > > ready, I don't think it makes much sense to send these unless we agree
> > > on the increased memory footprint. While there are just a few
> > > builtin_platform_driver_probe() and memory increase _might_ be
> > > negligible, there are many more module_platform_driver_probe().
> >
> > While it's good to drop code that'll not be used past kernel init, the
> > module_platform_driver_probe() is going even more extreme. It doesn't
> > even allow deferred probe (well before kernel init is done). I don't
> > think that behavior is right and that's why we should delete it. Also,
>
> This construct is typically used for builtin hardware for which the
> dependencies are registered very early, and thus known to probe at
> first try (if present).
>
> > I doubt if any of these probe functions even take up 4KB of memory.
>
> How many 4 KiB pages do you have in a system with 10 MiB of SRAM?
> How many can you afford to waste?

There are only a few instances of this macro in the kernel. How many
of those actually fit the description above? We can probably just
check the DT?

-Saravana
