Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB8313FC8CD
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 15:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239886AbhHaNvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 09:51:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:45006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239847AbhHaNvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 09:51:42 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE8906103A;
        Tue, 31 Aug 2021 13:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630417847;
        bh=0/puZ1DnYbulIiCsq72aaBHvD0Op7lgwXm2j4v10DWU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=jHRXWFObnzzfkSUxyqjyAzp3yhz+iDHtLiIOr2+GqGM04XGek3dlunGKxx0JDNbwH
         r0Ilb3h/c9Nui9ZI31twx0g6LoKQw/fsIGA1tH5C0Z0nkJ8bPFdbOcG6FVibBWYZOJ
         RYiFqvINZbjCg8Gq/PfF3kHpRvCTmGRKx3UN1bjYwY1PaOPnEhUejgqSU7VA5Paqcc
         oFe9ZG9sTZkVEixBZeJ2fLgI15kwi0DpWR0gA6VNPdCexDejrJMLQoqAI9T3CHB0sd
         AppeTMFTi+pn0seFfIn+3scT8yzHFVkXBiJic63hwrsf41H+JL/e5DVeqlaFGtHrF3
         d4VdJsNbTVLPQ==
Received: by mail-ed1-f52.google.com with SMTP id q17so26970939edv.2;
        Tue, 31 Aug 2021 06:50:47 -0700 (PDT)
X-Gm-Message-State: AOAM530baCne3+QaOGdGAS1SrqYKGPvK+FWX6cJFmq57sQEB6Kbhv31B
        lR4VkUm699WBfgkcrtReGe5qYfDUX46z6hh9pQ==
X-Google-Smtp-Source: ABdhPJyLzjbCPa0wTpzwt6rAxhVcwtW1DCxv2OE+lMi2EBNxYFss19SDC0y72tFokBzcLQhSftwTIEY/j0QG9asTPtA=
X-Received: by 2002:a05:6402:180f:: with SMTP id g15mr24326222edy.258.1630417846350;
 Tue, 31 Aug 2021 06:50:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210831125843.1233488-1-nsaenzju@redhat.com>
In-Reply-To: <20210831125843.1233488-1-nsaenzju@redhat.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 31 Aug 2021 08:50:34 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+R06nrnzuY8MxpCsxzcmTg1NW2L5eSNxM2ne+GqwMdgQ@mail.gmail.com>
Message-ID: <CAL_Jsq+R06nrnzuY8MxpCsxzcmTg1NW2L5eSNxM2ne+GqwMdgQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: bcm2711-rpi-4-b: Fix pcie0's unit
 address formatting
To:     Nicolas Saenz Julienne <nsaenzju@redhat.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org,
        "maintainer:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "moderated list:BROADCOM BCM2835 ARM ARCHITECTURE" 
        <linux-rpi-kernel@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefan Wahren <stefan.wahren@i2se.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 7:59 AM Nicolas Saenz Julienne
<nsaenzju@redhat.com> wrote:
>
> dtbs_check currently complains that:
>
> arch/arm/boot/dts/bcm2711-rpi-4-b.dts:220.10-231.4: Warning
> (pci_device_reg): /scb/pcie@7d500000/pci@1,0: PCI unit address format
> error, expected "0,0"
>
> Unsurprisingly pci@0,0 is the right address, as illustrated by its reg
> property:
>
>     &pcie0 {
>             pci@0,0 {
>                     /*
>                      * As defined in the IEEE Std 1275-1994 document,
>                      * reg is a five-cell address encoded as (phys.hi
>                      * phys.mid phys.lo size.hi size.lo). phys.hi
>                      * should contain the device's BDF as 0b00000000
>                      * bbbbbbbb dddddfff 00000000. The other cells
>                      * should be zero.
>                      */
>                     reg = <0 0 0 0 0>;
>             };
>     };
>
> The device is clearly 0. So fix it.
>
> Also add a missing 'device_type = "pci"'.
>
> Fixes: 258f92d2f840 ("ARM: dts: bcm2711: Add reset controller to xHCI node")
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
> ---
>
> Changes since v1:
>  - s/bus/device/ when talking about unit addresses
>  - Add device_type
>  - Add Suggested-by
>
>  arch/arm/boot/dts/bcm2711-rpi-4-b.dts | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
