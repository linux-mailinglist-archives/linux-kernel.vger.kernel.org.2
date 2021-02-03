Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E85EF30D497
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Feb 2021 09:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232366AbhBCIEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Feb 2021 03:04:22 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:2012 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231738AbhBCIES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Feb 2021 03:04:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612339454; x=1643875454;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZR9hqebKvpdI53Be1YePqr1uKNOod+LZPamyNKNil8o=;
  b=WjucNY1tRTDgu3Ws9R4X4pgyOFJkaxXEgh51AEKBRvGJmJZ50wnkwRNh
   /B21/z7/6n/6wQFMIqdAhsCXPlBQdeuuQDLIQU+kWBVvFWR9V1CGttC2r
   QrXyLg4gReQ4c7UWhh3Lopl6z+JZ8uODQq2N6ce0Nf28iC4L2Fl2cVCLW
   UyuP6Ld4vr/1fUZp7aQgImCTJoknj4YcPs4/bTekhwIPwEn/J/ZOv130y
   wWIab9KX7QzaKExnwqKR06Xy2dqDoNCLjZ+7/R5RfPr9qrLIQsllVMsQN
   OCJjPTykWKRNvRpk5eo7Rn+kiOuTRShWKAdrFIgJkSVjH2nC8yl3yjXAK
   g==;
IronPort-SDR: ZoSgsSbD6K3iLqHjcZ8Fb773GnMoEZwGl6VK2BnPcrhr1GAwtuGwYMgc9pxNHwsCFRKmF1rJOs
 DaQj6XIX7bg2g28HQVcvFuhaRiJ8xkwZXtIhikMQ/pRxPGtXEv+ljprFREWl/d2hVo73km8XRX
 oimCCtaY5u/izm1ZeuN/rGrfA0wL4xKxIJTKoO+sy91qYewxq9my5kg78VbEr2PTRpiI/b+8ob
 ICW7o6ajusy8kR9WFe6PYqu+aWXcnhH64NKTQ7+8yJRW+XP3X+bNuwnDd1SW2vCtjDqICjU4rB
 VEg=
X-IronPort-AV: E=Sophos;i="5.79,397,1602572400"; 
   d="scan'208";a="42728861"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Feb 2021 01:02:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 3 Feb 2021 01:02:54 -0700
Received: from tyr.hegelund-hansen.dk (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 3 Feb 2021 01:02:53 -0700
Message-ID: <69f4cb1bf7dc2351fea3a657dd860a802f66926b.camel@microchip.com>
Subject: Re: [PATCH v4 0/3] Adding the Sparx5 Switch Reset Driver
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Date:   Wed, 3 Feb 2021 09:02:52 +0100
In-Reply-To: <20210120081921.3315847-1-steen.hegelund@microchip.com>
References: <20210120081921.3315847-1-steen.hegelund@microchip.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Philipp,

I just wanted to know if there are any outstanding items that you
would like me to handle, or you think that the driver is acceptable as
it is now?

BR
Steen

On Wed, 2021-01-20 at 09:19 +0100, Steen Hegelund wrote:
> This series provides the Microchip Sparx5 Switch Reset Driver
> 
> The Sparx5 Switch SoC has a number of components that can be reset
> individually, but at least the Switch Core needs to be in a well
> defined
> state at power on, when any of the Sparx5 drivers starts to access
> the
> Switch Core, this reset driver is available.
> 
> The reset driver is loaded early via the postcore_initcall interface,
> and
> will then be available for the other Sparx5 drivers (SGPIO, SwitchDev
> etc)
> that are loaded next, and the first of them to be loaded can perform
> the
> one-time Switch Core reset that is needed.
> 
> The driver has protection so that the system busses, DDR controller,
> PCI-E
> and ARM A53 CPU and a few other subsystems are not touched by the
> reset.
> 
> The Sparx5 Chip Register Model can be browsed at this location:
> https://github.com/microchip-ung/sparx-5_reginfo
> 
> History:
> 
> v3 -> v4 Added commit message descriptions
> 
> v2 -> v3 Removed unused headers
>          Renamed the reset controller dev member.
>          Use regmap_read_poll_timeout instead of polling a function.
>          Used two separate syscon entries in the binding
>          Simplified the syscon error handling.
>          Simplified the devm_reset_controller_register error
> handling.
>          Moved the contents of the mchp_sparx5_reset_config function
> into
>          the probe function.
> 
> v1 -> v2 Removed debug prints
>          Changed the error handling to save the error code before
> jumping.
> 
> Steen Hegelund (3):
>   dt-bindings: reset: microchip sparx5 reset driver bindings
>   reset: mchp: sparx5: add switch reset driver
>   arm64: dts: reset: add microchip sparx5 switch reset driver
> 
>  .../bindings/reset/microchip,rst.yaml         |  59 +++++++++
>  arch/arm64/boot/dts/microchip/sparx5.dtsi     |  14 +-
>  drivers/reset/Kconfig                         |   8 ++
>  drivers/reset/Makefile                        |   1 +
>  drivers/reset/reset-microchip-sparx5.c        | 120
> ++++++++++++++++++
>  5 files changed, 199 insertions(+), 3 deletions(-)
>  create mode 100644
> Documentation/devicetree/bindings/reset/microchip,rst.yaml
>  create mode 100644 drivers/reset/reset-microchip-sparx5.c
> 


