Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 171363AB52B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Jun 2021 15:50:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbhFQNwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Jun 2021 09:52:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbhFQNwP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jun 2021 09:52:15 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98905C061574
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 06:50:07 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id j184so3166768qkd.6
        for <linux-kernel@vger.kernel.org>; Thu, 17 Jun 2021 06:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=GK8eHQct43wbLsYBUjGPg3hzzxwNiKpMXoEojlUUWzA=;
        b=OkYv2RdbSVF37r8l4wSmRWSJuSsOaVCxqtLQdtLBKIjI7OkxfwKh2BOvHdtFZn3PoP
         T8b1GONEn2Med5o0yNideznO20cfH3ImIR6wpJDbgWkPS5vXwECCLUB3Rj/HGnc03x+d
         yykDrHpVbf3MGctZ+29lnwctpbotiWT449YyVE9aB9AVlPaxq7jQCNdJYFey37fVCAt5
         /6t04VdalE9z+SrKxrKC0bQtgwC9i3Kt1LRmP1YfUsrLQBdyVzi7MTJ8PFtET5SKMHxC
         wdg8TmR5ycCeGTN1KUxUPI9Pkn+hTrrMInixVRaCcPcnqHFps6cEgpCFL8ZVjzXc4nxI
         anFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=GK8eHQct43wbLsYBUjGPg3hzzxwNiKpMXoEojlUUWzA=;
        b=EXg88M8aoyoNeJKc4FTrFynw3n7nNvpmhmzNxZ1b1suNC1twTLaFFFY0mPK92magxe
         ZcbLDg2V6a2UDxnvP9SmZ/pHws1LOp/diRYherjG7KiJMQPCva7vuUdwxIh9Hgtwv9sb
         uBNL1HcIamNBe2zHTlRO+MGMmh4ovL85QgcaTkT2W8v0/dTK3IgJ6mxilqEp4t0KklRC
         EUuoCOBvHrAc7FH50miX3DOOgXjHKKYHqqgRVcrdaFZl38F605Gg930dERFLBVoAtlBn
         SPFhvKLFqr3yZNy1HEmoM6DdI5qe0cLYScCHL8ScVxuqMbJVjyCM/D9tGAHsuewSqBEJ
         0fdw==
X-Gm-Message-State: AOAM531ASxj6AKq25nTDHugKXw8yKHfIcTvM+Wm9fwHQY8wakX7z7gf6
        kU6XVAhtQPQfGOYR7mQCOlqthVpAYtI5eWR8WwPgjQ==
X-Google-Smtp-Source: ABdhPJy32E2Z+NO3V3+PcBDo7cFlWmWlxIiL66KiEt4RIRcOw4GV42DKjNzYVlC/w2roUjM7IAvkpANU4G3tOgVF6fI=
X-Received: by 2002:a37:a041:: with SMTP id j62mr3881289qke.155.1623937806260;
 Thu, 17 Jun 2021 06:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210322003915.3199775-1-mw@semihalf.com> <87k0ms1vmd.fsf@BL-laptop>
In-Reply-To: <87k0ms1vmd.fsf@BL-laptop>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Thu, 17 Jun 2021 15:49:55 +0200
Message-ID: <CAPv3WKcyQc5K5cMYc4POasiExh+usVsyf7007R1rkRiDVgh16A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: ensure backward compatibility of the AP807 Xenon
To:     Gregory CLEMENT <gregory.clement@bootlin.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 17 cze 2021 o 15:14 Gregory CLEMENT
<gregory.clement@bootlin.com> napisa=C5=82(a):
>
> Hi Marcin,
>
> > A recent switch to a dedicated AP807 compatible string for the Xenon
> > SD/MMC controller result in the driver not being probed when
> > using updated device tree with the older kernel revisions.
> > It may also be problematic for other OSs/firmware that use
> > Linux device tree sources as a reference. Resolve the problem
> > with backward compatibility by restoring a previous compatible
> > string as secondary one.
> >
> > Signed-off-by: Marcin Wojtas <mw@semihalf.com>
>
> Applied on mvebu/dt64
>

Thank you!
Marcin

>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-ap807.dtsi | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi b/arch/arm64=
/boot/dts/marvell/armada-ap807.dtsi
> > index d9bbbfa4b4eb..4a23f65d475f 100644
> > --- a/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> > +++ b/arch/arm64/boot/dts/marvell/armada-ap807.dtsi
> > @@ -29,6 +29,7 @@ cpu_clk: clock-cpu {
> >  };
> >
> >  &ap_sdhci0 {
> > -     compatible =3D "marvell,armada-ap807-sdhci";
> > +     compatible =3D "marvell,armada-ap807-sdhci",
> > +                  "marvell,armada-ap806-sdhci"; /* Backward compatibil=
ity */
> >  };
> >
> > --
> > 2.29.0
> >
> >
> > _______________________________________________
> > linux-arm-kernel mailing list
> > linux-arm-kernel@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
> --
> Gregory Clement, Bootlin
> Embedded Linux and Kernel engineering
> http://bootlin.com
