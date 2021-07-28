Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9172F3D9171
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 16:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236665AbhG1O7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 10:59:55 -0400
Received: from gloria.sntech.de ([185.11.138.130]:50722 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235457AbhG1O7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 10:59:54 -0400
Received: from [95.90.166.74] (helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1m8l2E-0006Fd-5Z; Wed, 28 Jul 2021 16:59:50 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>, Peter Geis <pgwipeout@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org, Peter Geis <pgwipeout@gmail.com>
Subject: Re: [RFC PATCH 3/9] dt-bindings: usb: generic-ohci: increase maximum clocks
Date:   Wed, 28 Jul 2021 16:59:49 +0200
Message-ID: <3733382.QJadu78ljV@diego>
In-Reply-To: <20210728122606.697619-4-pgwipeout@gmail.com>
References: <20210728122606.697619-1-pgwipeout@gmail.com> <20210728122606.697619-4-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,

Am Mittwoch, 28. Juli 2021, 14:26:00 CEST schrieb Peter Geis:
> The rk3568 generic ohci controller has four clocks.
> Increase the maximum clocks in the documentation to account for this.
> 
> Signed-off-by: Peter Geis <pgwipeout@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/generic-ohci.yaml | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/generic-ohci.yaml b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> index 569777a76c90..850996e6f451 100644
> --- a/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> +++ b/Documentation/devicetree/bindings/usb/generic-ohci.yaml
> @@ -59,7 +59,7 @@ properties:
>  
>    clocks:
>      minItems: 1
> -    maxItems: 3
> +    maxItems: 4
>      description: |
>        In case the Renesas R-Car Gen3 SoCs:
>          - if a host only channel: first clock should be host.
> 

In the patch adding the usb nodes, I see that this 4th clock references
the clock generated inside usbphy itself.

Does the usb controller actually use that or is this just a way to
enable the usbphy clock, which in that case should maybe just happen
on phy-power-on in the phy driver?


Heiko


