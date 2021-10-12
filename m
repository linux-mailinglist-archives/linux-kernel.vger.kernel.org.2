Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FEAD429EF4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 09:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbhJLHvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 03:51:03 -0400
Received: from ssl.serverraum.org ([176.9.125.105]:52747 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbhJLHu4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 03:50:56 -0400
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id DD8A822205;
        Tue, 12 Oct 2021 09:48:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1634024927;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XTY/Z+zotHcX5KpcuZaorS0sZpvLJgkD21qg7w9gSRQ=;
        b=LWsI1mI6pSamxpDS/0+dFr2odTpKKzNiH6/1yG4SErONEZ2/U+oBsSryCX6kdka0owzZMP
        DhXdqjh+2CuV/P8auid/ozf8cdDxmpTGrRZc1+gBbUPCEgCMQeKqfe6uxsO40QV3wn5VNG
        E5LGJih/KiyGiPJztKa8y0OH1XN3seM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 12 Oct 2021 09:48:46 +0200
From:   Michael Walle <michael@walle.cc>
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pratyush Yadav <p.yadav@ti.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: mtd: spi-nor: Add
 output-driver-strength property
In-Reply-To: <20211012061704.284214-1-alexander.stein@ew.tq-group.com>
References: <20211012061704.284214-1-alexander.stein@ew.tq-group.com>
User-Agent: Roundcube Webmail/1.4.11
Message-ID: <a347541ba3f8c76912d4afdb6dc64d4d@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 2021-10-12 08:17, schrieb Alexander Stein:
> This property is for optimizing output voltage impedance and is
> specific to each board. It overwrites the default set by the flash
> device. Various flash devices support different impedances.
> 
> Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
> ---
> Changes in v2:
> * Updated the property description and the commit message accordingly
> 
>  Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> index ed590d7c6e37..4c3c506a8853 100644
> --- a/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> +++ b/Documentation/devicetree/bindings/mtd/jedec,spi-nor.yaml
> @@ -72,6 +72,14 @@ properties:
>        be used on such systems, to denote the absence of a reliable 
> reset
>        mechanism.
> 
> +  output-driver-strength:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Output driver strength in ohms which optimizes the impedance at 
> Vcc/2
> +      output voltage. This property overwrites the default set by the 
> flash
> +      device. This is board specific and should be determined by the
> +      manufacturer. Various flash devices support different 
> impedances.

Mh, this seems to be very tailored to this flash chip. Eg. the "Vcc/2", 
is
this something specific to this flash or is this some kind of common 
usage?
For example, Winbond flashes specifies the output driver strength in 
percent.
Settings are 25%, 50%, 75%, 100% there.

I'd have to ask a hardware guy, if one could convert between these two
representations of the driver strength.

Rob, do you know how is this case ususally handled? Can there be 
different
properties, like:

output-driver-strength-ohms
output-driver-strength-percent

or similar.

-michael
