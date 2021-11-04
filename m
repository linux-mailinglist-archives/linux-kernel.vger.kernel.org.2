Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2E54450B2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 09:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231132AbhKDI7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 04:59:49 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:16453 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhKDI7s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 04:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1636016230; x=1667552230;
  h=date:from:to:subject:message-id:references:mime-version:
   in-reply-to;
  bh=uYP98T1lWdkr5+qrsVnyqqWos9v2lmU4T/cfxWtY65g=;
  b=ldbKJDQvVRrSuaDyGG4T2GIqusnZThjZDFE4MWxKr+9tQV0JjemSBESK
   hTTwcvxFXF5X2/43AeeEyWezc5kknKs38mK8shspYnr0mGffgwSbzu+C9
   mhLds/jindLSJfzxNHq994Ei9qlGwhjorT6McqfeU/zThIaCYHlG3otm0
   m+kS9S1ORgQqRb6dX0BbPpQ+mZsUpwOmxO+14OSzNYu8R9UD7auN1uVwI
   0cc5xgkL+SPreClgwfoeK6HAaTe0UzCc91wznhddtYkY5GLjWcVUpIQPV
   hoWCf5OrvK3p5kAn0pX57nnjz/orRk4WGptflas6XuH6OWAlxDGb95BAg
   A==;
IronPort-SDR: Zu/2WzzgZHxh5zmp4AQdIS+JXQvZxh1va+aIBdVN/FDUwh5kAFORlUYQlk7a4+lmgyHsNj8Oud
 1V2eoNF62rhpsPDfiUZ3fWs4vb81nMZ50Zx910+QOG/GK3w37JZ4a4W83o9ARlW5NZIVDlN5j0
 mQ3f5DALmXxXZWh2AR22KsVgYFG0dE3AIh/q7KiQQQSeWWxBnuiO+RaC2fcQBElRHcbMrue3S+
 ZrDQW5TPNNDb3wUP60YGnJXDz0hp0XO5K0QeD+omiFLJqBOIjQPMynyuUHsGT4ihPHK5e18qYL
 zwZ4MbV6bYk1nEC76D3tZ17P
X-IronPort-AV: E=Sophos;i="5.87,208,1631602800"; 
   d="scan'208";a="150696948"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Nov 2021 01:57:10 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 4 Nov 2021 01:57:10 -0700
Received: from localhost (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 4 Nov 2021 01:57:09 -0700
Date:   Thu, 4 Nov 2021 09:58:56 +0100
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <andrew@lunn.ch>, <alexandre.belloni@bootlin.com>,
        <linux-phy@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 0/3] phy: Add driver for lan966x Serdes driver
Message-ID: <20211104085856.tlvwwbpgyv2djdyz@soft-dev3-1.localhost>
References: <20211020094229.1760793-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20211020094229.1760793-1-horatiu.vultur@microchip.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kishon, Vinod,

Please let me know if you have more comments to this patch series.
Do you think it would be possible to get it in 5.16?

The 10/20/2021 11:42, Horatiu Vultur wrote:
> This patch serie adds support for Microchip lan966x serdes. The lan966x
> device contains has 7 interfaces, consisting of 2 copper transceivers,
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
