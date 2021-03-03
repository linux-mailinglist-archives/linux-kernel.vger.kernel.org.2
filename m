Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF9FC32BBD7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 22:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237850AbhCCM6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 07:58:33 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62731 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842802AbhCCINX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:13:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614759202; x=1646295202;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=75yzkttZViIFf7HKfyDkvSJk7HqKwKtL3phFRtFKS0o=;
  b=WK+Z4fffEzf9XIxEW4x44W6d2QtRqaL0DMGJJVRX9HLqy15Lowuaen7L
   mDdvbl55BFjXW1qWb1+ifruUw4NP0yPnT9X4O6z07Jo5K5gNrvXkvpCUJ
   I7+0OC1z5r0f6bmqMg7WT376/sFEex6BvuTWQ0cd2a92aNEp+n1BQ/v2/
   KXrtrf0r88ivhzXm5MxznKR+Ulf0358C2UapLshODHR1QhzOdvnYrkSHJ
   1gVzxd3WGWq1gPfTHZuHocjp7Ei3/aqzK6bpadchyH7T2R3iBARIrYCRT
   BD3Lf54zhE5qDXEP6genS5HI5nw5TAw4k2w0OMM/xYL6HyOenmvwj0je0
   A==;
IronPort-SDR: tdgsqI3FFVjCezGgghywQtZMA5UOVN7jk0XbRY1vY7zSVCf7Pc3yR0okBUm6259tJ1H8y6hi/L
 lKpa8Mt2xISbmvwxJxBUUqbIZ8KxXXB5s1q+cwcJvqu2al+d54IJkZ5dR5jbTk7now8soCa+yD
 gq41STIaLOLMnTrwI8/XfJdqascyCfwEQU4VFgmPyWPdN8nPAspGTnQ14UOjals8i8Y/hAJ8fW
 w4EQ0yf2LKDkuYse0H12OTN2M7NKAVT6RFKyMVRGoxPg+KSJpE/8W9u8jRQqIkUMgJ3rXhq6KY
 Jgg=
X-IronPort-AV: E=Sophos;i="5.81,219,1610434800"; 
   d="scan'208";a="105779077"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Mar 2021 01:12:05 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 3 Mar 2021 01:12:04 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 3 Mar 2021 01:12:02 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v7 0/3] Adding the Sparx5 Switch Reset Driver
Date:   Wed, 3 Mar 2021 09:11:55 +0100
Message-ID: <20210303081158.684532-1-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.30.1
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
2.30.1

