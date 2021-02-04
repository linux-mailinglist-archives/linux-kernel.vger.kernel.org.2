Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C413530FF5D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 22:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbhBDVcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 16:32:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbhBDVcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 16:32:31 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29ABEC061793
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 13:31:50 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id m76so4705006ybf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 13:31:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=29BoGNlBSuRptp75qdFu7EtcEjyZvsuV2W9BZnedNiw=;
        b=m7JhjKA5LR57ijKi9WJBvdVcUt8vGEfUDLk1uoFrZoPnHCr4eWh1SKKac2ygEQBFVC
         2qvmKOu3CcpqsHl7+roCbgqgdQWOrewROlxxDAtknEB8iggJidNsgfxaivb90APnN9wv
         0h0+zbwPFSal3i2jtZP0PilXVsEgBOx7DmwwAmJIci6gnYls7ICevMnfnpvKxYhTrZoH
         TjUOKIqeZ+XTHGWwT7Lcytkhpi8tkMNJoS360hisK3n0o8tuIyTaFkrctKNBJAxA1VJk
         0bDISpotUj6pO/5XTpO3UOC5rprKrCVZkGBj0T4HtHYQaxOa9A8XKXbZhyd9r1ybG9nm
         AP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=29BoGNlBSuRptp75qdFu7EtcEjyZvsuV2W9BZnedNiw=;
        b=fF2cPlFH0DwKzs+4KFyvxGiRh+BgamiYWxNcC5puRe/hiyLMpRZ/Rir54VIhUZK0A7
         LJyLkL7UALYDtBYrMt3/YGcyo6hoYesLA1JdCVCJM2YsPEWzE8Ew+m9mC2oE4TgFI131
         dM+k5hiIrtDVyKguy1t5oHQfgmVWRZgsp+GT4xmUW1iOhoWzzI/qwMdsVcCekKL+swTu
         YEnX8oD3CmWMRcVG9pnWoRLmOLu/EaN/NuBLJeF/fqnWj+v2lbVcT3+1zk9R00F0m0Dk
         66NHkqGYrS6slnOQRBmMD5caMHoRCvfVcbhu4qsJZeLGCznboJEHAoAZhkhq4NViBYA2
         7O3A==
X-Gm-Message-State: AOAM531rXEX/Y6CSAV5n2Xe9HDEPiQnFS8Hxfjn90cuTrgX6JMKAbGDO
        tjW0BcLM5OLVocVIKHuGV9uHqryM0/15CcUf6bN9Kw==
X-Google-Smtp-Source: ABdhPJzXo+2QfAAZsWBIWdDQJqEUS/VFWFs+8oVZFxPhskYIqgK0ZJ38GKKtHrSVeSIg0cb1D3Jg1FOxNRw1AGpG7/w=
X-Received: by 2002:a25:b74c:: with SMTP id e12mr2004516ybm.20.1612474309232;
 Thu, 04 Feb 2021 13:31:49 -0800 (PST)
MIME-Version: 1.0
References: <20210121225712.1118239-1-saravanak@google.com>
 <CGME20210204115252eucas1p2d145686f7a5dc7e7a04dddd0b0f2286c@eucas1p2.samsung.com>
 <20210121225712.1118239-3-saravanak@google.com> <9692dfc9-4c63-71c9-b52b-d0feba466695@samsung.com>
In-Reply-To: <9692dfc9-4c63-71c9-b52b-d0feba466695@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 4 Feb 2021 13:31:13 -0800
Message-ID: <CAGETcx_KDA55Ti=5CHw48BP1L2Xo64=AFFe+17g27n=P-KUrow@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] of: property: Add fw_devlink support for interrupts
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-tegra <linux-tegra@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marc Zyngier <maz@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Android Kernel Team <kernel-team@android.com>,
        Rob Herring <robh@kernel.org>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 4, 2021 at 3:52 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Saravana,
>
> On 21.01.2021 23:57, Saravana Kannan wrote:
> > This allows fw_devlink to create device links between consumers of an
> > interrupt and the supplier of the interrupt.
> >
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Kevin Hilman <khilman@baylibre.com>
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> > Reviewed-by: Thierry Reding <treding@nvidia.com>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> This patch landed some time ago in linux-next as commit 4104ca776ba3
> ("of: property: Add fw_devlink support for interrupts"). It breaks MMC
> host controller operation on ARM Juno R1 board (the mmci@50000 device
> defined in arch/arm64/boot/dts/arm/juno-motherboard.dtsi). I didn't

I grepped around and it looks like the final board file is this or
whatever includes it?
arch/arm64/boot/dts/arm/juno-base.dtsi

This patch just finds the interrupt-parent and then tries to use that
as a supplier if "interrupts" property is listed. But the only
interrupt parent I can see is:
        gic: interrupt-controller@2c010000 {
                compatible = "arm,gic-400", "arm,cortex-a15-gic";

And the driver uses IRQCHIP_DECLARE() and hence should be pretty much
a NOP since those suppliers are never devices and are ignored.
$ git grep "arm,gic-400" -- drivers/
drivers/irqchip/irq-gic.c:IRQCHIP_DECLARE(gic_400, "arm,gic-400", gic_of_init);

This doesn't make any sense. Am I looking at the right files? Am I
missing something?

-Saravana
