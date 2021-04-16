Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C30E361BF4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 11:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240126AbhDPIlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 04:41:25 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:57244 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239357AbhDPIlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 04:41:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1618562460; x=1650098460;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hRZGwHEW2Rm+EIdp1pn2NibgsC3B9G1O3PvlTho8hO8=;
  b=xg1j+qIhQ/QmaDozTrWoJKH28QiVzagURMTAvF79jzjoILhtG5KaddKU
   63EXBDVamH03IeAoh2uiKTjehJRcbw19vo3KiRVkRf2HTXs+kW+Dyacag
   89QnI5iMrnVnHK9KDPNQV6s9x5BUtZIDdUxouX7Vh8jq9ffjzn0OuRssM
   7qG6txrpkGoD11Cvhb0vKyi39k3YjzWY9GmFacIUQn8kvDV05I1RKwde5
   MNHWtWNkRY8q2gM9zia5cl68uWYEHwNlIgKMybKcBZw1ZqfNUOj94ButD
   kawt3ZFgX1pRjdmDDXwMPf5Q0e2vA4GI+hc06jA5bRlmAAqJoIsr9xbBq
   A==;
IronPort-SDR: v9ZcpGo82jKi9ccqofEILvEnIrvO8kR9/UusQ5tOg7XK7z+Ggfv0Qz7jxHGwEr9lVmffkh8hfM
 7vBEHN+NVLdnBU4DbYXtqlLkMQ9hgZI3AZnaBJL1D/UK8pb5aooedMKClE74n1+taKp3JxVPTv
 h+mfvauHX9EHEGOWUOUMjKgSzcMSSI9+o9k5kdi83Ql8xOUq1pYaaKRMIJBf6vjvSr8GGddq9V
 gefODKv6DtA65Uj55iRPJ4OBhIVbMqJCWcc4izC/sAJ97+NhUtmRJL0Is+kTg/yBHtjvjP1Phw
 lpA=
X-IronPort-AV: E=Sophos;i="5.82,226,1613458800"; 
   d="scan'208";a="113816631"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Apr 2021 01:40:59 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 16 Apr 2021 01:40:58 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 16 Apr 2021 01:40:57 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v9 0/3] Adding the Sparx5 Switch Reset Driver
Date:   Fri, 16 Apr 2021 10:40:51 +0200
Message-ID: <20210416084054.2922327-1-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series provides the Microchip Sparx5 Switch Reset Driver

The Sparx5 Switch SoC has a number of components that can be reset
individually, but at least the Switch Core needs to be in a well defined
state at power on, when any of the Sparx5 drivers starts to access the
Switch Core, this reset driver is available.

The reset driver is loaded early via the postcore_initcall interface, and
will then be available for the other Sparx5 drivers (SGPIO, SwitchDev etc)
that are loaded next, and the first of them to be loaded can perform the
one-time Switch Core reset that is needed.

The driver has protection so that the system busses, DDR controller, PCI-E
and ARM A53 CPU and a few other subsystems are not touched by the reset.

Sparx5 will no longer use the existing Ocelot chip reset driver, but use
this new switch reset driver as it has the reset controller interface that
allows the first client to perform the reset on behalf of all the Sparx5
component drivers.

The Sparx5 Chip Register Model can be browsed at this location:
https://github.com/microchip-ung/sparx-5_reginfo
and the datasheet is available here:
https://ww1.microchip.com/downloads/en/DeviceDoc/SparX-5_Family_L2L3_Enterprise_10G_Ethernet_Switches_Datasheet_00003822B.pdf

History:

v8 -> v9 Added reviewed-by tag.

v7 -> v8 Updated the commit descriptions to explain the change from using
         the existing Ocelot chip reset driver to use a new switch reset
         driver.

v6 -> v7 Use devm_platform_get_and_ioremap_resource to get the IO range.
         Rebase on v5.12-rc1

v5 -> v6 Using the existing CPU syscon for reset protection and add a small
         IO range for the GCB Reset Register.

v4 -> v5 Changed the two syscons into IO ranges and updated the bindings to
         reflect this change.

v3 -> v4 Added commit message descriptions

v2 -> v3 Removed unused headers
         Renamed the reset controller dev member.
         Use regmap_read_poll_timeout instead of polling a function.
         Used two separate syscon entries in the binding
         Simplified the syscon error handling.
         Simplified the devm_reset_controller_register error handling.
         Moved the contents of the mchp_sparx5_reset_config function into
         the probe function.

v1 -> v2 Removed debug prints
         Changed the error handling to save the error code before jumping.

Steen Hegelund (3):
  dt-bindings: reset: microchip sparx5 reset driver bindings
  reset: mchp: sparx5: add switch reset driver
  arm64: dts: reset: add microchip sparx5 switch reset driver

 .../bindings/reset/microchip,rst.yaml         |  58 +++++++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |   7 +-
 drivers/reset/Kconfig                         |   8 +
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-microchip-sparx5.c        | 146 ++++++++++++++++++
 5 files changed, 218 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml
 create mode 100644 drivers/reset/reset-microchip-sparx5.c

-- 
2.31.1

