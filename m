Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADFF83E2FE7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 21:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244093AbhHFTvZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 6 Aug 2021 15:51:25 -0400
Received: from relay11.mail.gandi.net ([217.70.178.231]:52811 "EHLO
        relay11.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232086AbhHFTvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 15:51:23 -0400
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay11.mail.gandi.net (Postfix) with ESMTPSA id E505D100003;
        Fri,  6 Aug 2021 19:51:05 +0000 (UTC)
Date:   Fri, 6 Aug 2021 21:50:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/15] MAINTAINERS: update mtd-physmap.yaml reference
Message-ID: <20210806215052.6d8f70af@xps13>
In-Reply-To: <24957d89f650521bfe27c64722110d6fb0d26921.1626947923.git.mchehab+huawei@kernel.org>
References: <cover.1626947923.git.mchehab+huawei@kernel.org>
        <24957d89f650521bfe27c64722110d6fb0d26921.1626947923.git.mchehab+huawei@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mauro,

I was about to apply the 4 MTD patches but unfortunately they don't
appear in patchwork as the linux-mtd mailing list was only CCed in the
cover letter. Here is my Acked-by for all of them, if you prefer me to
take them anyway please just resent these patches to me + the ML.

Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote on
Thu, 22 Jul 2021 12:00:01 +0200:

> Changeset 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
> renamed: Documentation/devicetree/bindings/mtd/arm-versatile.txt
> to: Documentation/devicetree/bindings/mtd/mtd-physmap.yaml.
> 
> Update its cross-reference accordingly.
> 
> Fixes: 63f8e9e0ac65 ("dt-bindings: mtd: Convert mtd-physmap to DT schema")
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d69b2d4646be..76acb9fe0622 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1386,7 +1386,7 @@ F:	Documentation/devicetree/bindings/auxdisplay/arm-charlcd.txt
>  F:	Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml
>  F:	Documentation/devicetree/bindings/i2c/i2c-versatile.txt
>  F:	Documentation/devicetree/bindings/interrupt-controller/arm,versatile-fpga-irq.txt
> -F:	Documentation/devicetree/bindings/mtd/arm-versatile.txt
> +F:	Documentation/devicetree/bindings/mtd/mtd-physmap.yaml
>  F:	arch/arm/boot/dts/arm-realview-*
>  F:	arch/arm/boot/dts/integrator*
>  F:	arch/arm/boot/dts/versatile*

Thanks,
Miquèl
