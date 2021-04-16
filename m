Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0CCD361EE0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 13:36:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242605AbhDPLhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 07:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235505AbhDPLhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 07:37:06 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E52C061574
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 04:36:40 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id g5so34958940ejx.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Apr 2021 04:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hb0KNXdt3Vcrzc5KdIrNFouVnhjw8ZSpLxSSHlTslNk=;
        b=1CrS3ARf/IicOTk7a/Jq1L7OsbXDkq5GWYi+GfggyosXhEL2PyquxsrZKNCJ4jIFdQ
         8Lh+motFbf6pIZk5KhVAMJsRYlK7y1aEbHHZ49Tf8uLHjK+nk+RX09nyn4OFIqExM1b/
         8VKqYwfg6s0X565kxCuXEzau/tH/z+siqcmzPx11e+T7jt63fhJRchq2VQWr43wn5dVq
         T1atCVnVAfy2ieptlq29dfCUNosyUs+xH0+xoryHRj+DZJgUyCavmbCnpx4uLbrWDrY5
         juTUWNo+mE3ER9Lw7AOANchVB4YdeqP7foo79XafynTf4cMAOWIVdXXy5S+KrAs46RBA
         /4Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hb0KNXdt3Vcrzc5KdIrNFouVnhjw8ZSpLxSSHlTslNk=;
        b=InNd/h+mu3zryN3rpqjgV76RcnGHp/BciGMuWOJrrfUgLOp3bwIt/7lBWRtQSfTN2m
         gaEy4pWIiNR1uAsYb3KBWZ98sv3Zt5nch16CYZOi65yEXPEj0le6GaNc9Xvkbhp/qUcL
         pqwaa3EUjFUwYNxWT+I+TP0qGU/e5P7UVmX5wlpWER3HyjvypUA9k52zoc0rP2wENLfm
         RRaPqSCjUP6MiTLCLrNMUdeZqoY2tqEq/STRyzYbBllZrSi0PTLPoVIK2hwAT1WYgPIu
         UclYTeombtpFai0KmGngdeIwsqMG2huy9IzmU96s07zs4pEBfPB0g3ret7NDHMAyp0Mj
         rJnQ==
X-Gm-Message-State: AOAM532hMQEKChFX2HkmeDiwcNq8rPl2AqUhWQNrS63HAZwR9YMQqnHq
        RDwHWq3hMaeeEerdVPYNFzd3m9E6ez2a7mJ0YcqzbQ==
X-Google-Smtp-Source: ABdhPJwoB+VnxyMg1MBAWWE4KZI53MeRQyKQhX4YaWIzG+AzE7dOfkdNme3imQCXq+/8wneZ1MPp/vVs9Lo8gRBFysw=
X-Received: by 2002:a17:906:26d4:: with SMTP id u20mr8286680ejc.114.1618572999322;
 Fri, 16 Apr 2021 04:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210407123438.224551-1-mindal@semihalf.com>
In-Reply-To: <20210407123438.224551-1-mindal@semihalf.com>
From:   =?UTF-8?Q?Kornel_Dul=C4=99ba?= <mindal@semihalf.com>
Date:   Fri, 16 Apr 2021 13:36:28 +0200
Message-ID: <CAKpxNiySoggtGdy784evjFWzErikSdp7JxV5z05i7Dc51c3MMg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: fsl-ls1028a: Correct ECAM PCIE window ranges
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     shawnguo@kernel.org, leoyang.li@nxp.com, robh+dt@kernel.org,
        Marcin Wojtas <mw@semihalf.com>,
        Tomasz Nowicki <tn@semihalf.com>, upstream@semihalf.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Apr 7, 2021 at 2:35 PM Kornel Duleba <mindal@semihalf.com> wrote:
>
> Currently all PCIE windows point to bus address 0x0, which does not match
> the values obtained from hardware during EA.
> Replace those values with CPU addresses, since in reality we
> have a 1:1 mapping between the two.
>
> Signed-off-by: Kornel Duleba <mindal@semihalf.com>
> ---
>  arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> index 262fbad8f0ec..85c62a6fabb6 100644
> --- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> +++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
> @@ -994,19 +994,19 @@ pcie@1f0000000 { /* Integrated Endpoint Root Complex */
>                         msi-map = <0 &its 0x17 0xe>;
>                         iommu-map = <0 &smmu 0x17 0xe>;
>                                   /* PF0-6 BAR0 - non-prefetchable memory */
> -                       ranges = <0x82000000 0x0 0x00000000  0x1 0xf8000000  0x0 0x160000
> +                       ranges = <0x82000000 0x1 0xf8000000  0x1 0xf8000000  0x0 0x160000
>                                   /* PF0-6 BAR2 - prefetchable memory */
> -                                 0xc2000000 0x0 0x00000000  0x1 0xf8160000  0x0 0x070000
> +                                 0xc2000000 0x1 0xf8160000  0x1 0xf8160000  0x0 0x070000
>                                   /* PF0: VF0-1 BAR0 - non-prefetchable memory */
> -                                 0x82000000 0x0 0x00000000  0x1 0xf81d0000  0x0 0x020000
> +                                 0x82000000 0x1 0xf81d0000  0x1 0xf81d0000  0x0 0x020000
>                                   /* PF0: VF0-1 BAR2 - prefetchable memory */
> -                                 0xc2000000 0x0 0x00000000  0x1 0xf81f0000  0x0 0x020000
> +                                 0xc2000000 0x1 0xf81f0000  0x1 0xf81f0000  0x0 0x020000
>                                   /* PF1: VF0-1 BAR0 - non-prefetchable memory */
> -                                 0x82000000 0x0 0x00000000  0x1 0xf8210000  0x0 0x020000
> +                                 0x82000000 0x1 0xf8210000  0x1 0xf8210000  0x0 0x020000
>                                   /* PF1: VF0-1 BAR2 - prefetchable memory */
> -                                 0xc2000000 0x0 0x00000000  0x1 0xf8230000  0x0 0x020000
> +                                 0xc2000000 0x1 0xf8230000  0x1 0xf8230000  0x0 0x020000
>                                   /* BAR4 (PF5) - non-prefetchable memory */
> -                                 0x82000000 0x0 0x00000000  0x1 0xfc000000  0x0 0x400000>;
> +                                 0x82000000 0x1 0xfc000000  0x1 0xfc000000  0x0 0x400000>;
>
>                         enetc_port0: ethernet@0,0 {
>                                 compatible = "fsl,enetc";
> --
> 2.31.1
>

Have you had a chance to to review the patch? Any questions or remarks?

Regards,
Kornel
