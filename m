Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B94316232
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 10:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231169AbhBJJ17 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 04:27:59 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:12984 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbhBJJVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 04:21:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1612948893; x=1644484893;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6el3Tqz8WopSjjVJsA7i52JT4Ne+cYvG/bjn3zupi+w=;
  b=1+ncbNwScMmMd4RIVw6ztabmZcJTSTvWxSSaMAUVPE3+iInbrvnmmguF
   jfV+SZyOc/pE1IJEVGvUEXpKG0x3YRZjH/uUoxLa2584i7NO6GOvqEhAH
   o4nbwoD/pbVea7uamwkB5uXpvwLBrow7we8H9Qu5zspswNfX7DM+OwhTK
   A50RnzpRkm62jvTddHCvuKGH1XgIcQGmvHFeh13bTygcezzWKWswF+RX7
   ct2Bq6F67EQFVq/f87JvlZ4Ds71/JnnBqYS7X5qOAe9vp98QSHJZAXJV0
   g5ae+46ucVHj7pHmOGv4tUJ0+V2906/RXt+tdJ9tTzNXpYSYsUNhc10hR
   g==;
IronPort-SDR: DoM2qgGUCVGDVMwE7A2zcbdbp7YftRL5Sk1Dfrz5FG9bt66r7gk9EkZlEziuCFwLpcvi9hIph3
 BFHty2ORhtsVCF2wroiFLS7dYzvpVu1TZMHFwra2v/Q18gCySAF6yl1++BouUqIa9cnkl5E/xU
 rYtEMUMN6yW9OQCk0jUET3lm8PIaN7o6hYpewzrSy5Zdl58ajzjqpqUvW3XRUpagFJ/Dl250lD
 wTt9v3b7SboU8lPv0f4kzG9/ggqRvHuWD11d1GNZpCscYLaM65V6MZyAD+Wawq/TBoUXXqXOdw
 Xk0=
X-IronPort-AV: E=Sophos;i="5.81,167,1610434800"; 
   d="scan'208";a="114529551"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Feb 2021 02:20:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 10 Feb 2021 02:20:01 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 10 Feb 2021 02:20:00 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v5 0/3] Adding the Sparx5 Switch Reset Driver
Date:   Wed, 10 Feb 2021 10:19:49 +0100
Message-ID: <20210210091952.2013027-1-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.30.0
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

The Sparx5 Chip Register Model can be browsed at this location:
https://github.com/microchip-ung/sparx-5_reginfo

History:

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

 .../bindings/reset/microchip,rst.yaml         |  55 ++++++++
 arch/arm64/boot/dts/microchip/sparx5.dtsi     |   9 +-
 drivers/reset/Kconfig                         |   8 ++
 drivers/reset/Makefile                        |   1 +
 drivers/reset/reset-microchip-sparx5.c        | 130 ++++++++++++++++++
 5 files changed, 200 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml
 create mode 100644 drivers/reset/reset-microchip-sparx5.c

-- 
2.30.0

