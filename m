Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E69C452EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 11:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233959AbhKPKYO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 05:24:14 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:60018 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233859AbhKPKXJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 05:23:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1637058012; x=1668594012;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=m8W15a1kB0nLYDdrfk+rvxEdZSKbZUupLWjYQM6oGUE=;
  b=VM+COGe2aRAO+p3jbrT7ZTDFYx4tolhOoknZHwLoxf4VZjsOFN/R/fps
   AbOoTm4i9o13laE9y+zRetq0bZM0PFWLsoK6lkeph0MAYeVMqA9/7MIRq
   ueujY1dyRd2g16rLzEgI9YfaM7HcaBD7Bkc7+cqgwyMmFA2GVtUG+GJdQ
   QUL3IOuOQWEgMhZofOLDE3pKG74443qU6KhEPnI/WNx4Hi8qWCxaWqLHy
   uti+eWlaw7pLxqQhHwXC0eeOq2ZSj3MeOuxaZHQsoPqEk4q34vVKgcPFr
   8apTlk1Opluwxd3Vxl0mKRb8dg6aZG4VC4167gPyqpNhHAiEcFdYop5r2
   A==;
IronPort-SDR: 4n34fcCSukz9vWI6Hp+XCvNkuvIzQyTCpcm7aUJcq/KRkRR/m3L8Dc/7X5E+Pki48BULritxaq
 S8SfBWOvJXsL7B6RmeFHE560et+BiYa4xmrDIkV0l8sNABP5FV3ffBjj+uL4PvEPjOWPcDJ832
 QxGKyIlx92FSc040oCzA3vJN91kBdtClXmI8Fcf0tXP5K8UbotLgWy0Ll+zWOUSAUHvBwgWZK6
 kCSmbhU1DAKlFejG29dQVYyxdVkw7bPh36SneMWd2/cZaPhBU5fGWVo63rb+BAh7HnpoMneW9E
 LKzi3L5vfJ2Cp6yQkWvwsfIk
X-IronPort-AV: E=Sophos;i="5.87,238,1631602800"; 
   d="scan'208";a="136710789"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Nov 2021 03:20:08 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 16 Nov 2021 03:20:05 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Tue, 16 Nov 2021 03:20:05 -0700
Date:   Tue, 16 Nov 2021 11:21:51 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <alexandre.belloni@bootlin.com>,
        <kuba@kernel.org>, <linux-phy@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH resend v4 0/3] phy: Add driver for lan966x Serdes driver
Message-ID: <20211116102151.k3evnn4f2rwsi5nk@soft-dev3-1.localhost>
References: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20211116100818.1615762-1-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 11/16/2021 11:08, Horatiu Vultur wrote:

Hi Kison, Vinod,

Can you let me know if you have more comments to this patch series?
Otherwise can you ack on it? Because I would like to have the patches
merged via netdev if that is OK for you.

Thanks


> This patch serie adds support for Microchip lan966x serdes. The lan966x
> device contains 7 interfaces, consisting of 2 copper transceivers,
> 3 Serdes and 2 RGMII interfaces. Two of the Serdes support QSGMII.
> The driver also adds the functionality of "muxing" the interfaces to
> different logical ports.
> 
> The following table shows which interfaces can be supported by the port.
> 
> PortNumber    Max Speed    Ethernet interface options
>     0            1Gbps       CuPHY, 1G SGMII or QSGMII
>     1            1Gbps       CuPHY, 1G SGMII or QSGMII
>     2          2.5Gbps       2.5G SGMII, QSGMII, RGMII
>     3          2.5Gbps       2.5G SGMII, QSGMII, RGMII
>     4          2.5Gbps       2.5G SGMII, QSGMII
>     5            1Gbps       QSGMII, RGMII
>     6            1Gbps       QSGMII, RGMII
>     7            1Gbps       QSGMII
> 
> v3->v4:
> - update description of the driver
> - removed unused registers
> - use bitfield operations in the registers
> - add macros for PLL configuration
> - move macros and structs at the top of the file
> 
> v2->v3:
> - remove unused includes
> - add missing '...' in microchip,lan966x-serdes.yaml
> - rename lan966x-serdes.h to phy-lan966x-serdes.h
> - Rename CU->PHY and RG->RGMII
> - update commit message for PATCH 2
> 
> v1->v2:
> - replace the regmap with iomem
> - update DT bindings
> 
> Horatiu Vultur (3):
>   dt-bindings: phy: Add lan966x-serdes binding
>   dt-bindings: phy: Add constants for lan966x serdes
>   phy: Add lan966x ethernet serdes PHY driver
> 
>  .../phy/microchip,lan966x-serdes.yaml         |  59 ++
>  drivers/phy/microchip/Kconfig                 |   8 +
>  drivers/phy/microchip/Makefile                |   1 +
>  drivers/phy/microchip/lan966x_serdes.c        | 548 ++++++++++++++++++
>  drivers/phy/microchip/lan966x_serdes_regs.h   | 209 +++++++
>  include/dt-bindings/phy/phy-lan966x-serdes.h  |  14 +
>  6 files changed, 839 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/phy/microchip,lan966x-serdes.yaml
>  create mode 100644 drivers/phy/microchip/lan966x_serdes.c
>  create mode 100644 drivers/phy/microchip/lan966x_serdes_regs.h
>  create mode 100644 include/dt-bindings/phy/phy-lan966x-serdes.h
> 
> -- 
> 2.33.0
> 

-- 
/Horatiu
