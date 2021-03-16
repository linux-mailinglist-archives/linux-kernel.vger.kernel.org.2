Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57A3233D059
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 10:11:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235792AbhCPJLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 05:11:03 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:54484 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhCPJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 05:10:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1615885829; x=1647421829;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OyawPMIxe+sTstl1UV+T58ODa1GXRyNduN1DSdXwEeo=;
  b=vkR+IqUIH9SKkIXLjPnILPEp7STohnAXsPIi69wZRE5GZDBTmu0bh7q7
   3U8ApKHXsHlRtqmF8SwFRxAc05D7Sb2z6WKggzdqRj9BQOvz57djpnRb/
   x1kmjo/zxghJGr0IoI9cCAGmI06TQZFj3bvy/T9dB8TGZnbvoNNF6mKzD
   CaeKsQIUpiHIQNcr+QyL/YxmRzq9a1K6ywg1Yv6gnSKdgCojvnbHgRbx6
   uMKHncQ+Fx5mYjyTMyQy0f+ge74LbCKDP3/t85Z0Q6jqLQrOSAs/e7KGw
   x/mv29ma39XlMA3jF5FxXNKamdg32R08Uolkgz4xAKBjxqzTg7HkKoBwH
   w==;
IronPort-SDR: 1iKmoQ1rEuYlRHZlj7N2yEwcgWlAWMCJDLAPlsOxzLAXY03JfRd4F2kEiMxPt7CsxZGLbx8BUR
 OzfmSAoZ12P4Wh6EDJGmx+UQNNJXAtSC7GaZAuIkDu/5jFUcOSmboa3lGAckOP0MWMd4cD72HU
 BpFAaYzLmWqa3z37r34cnBT++y7mHw1cpRdkMUmPCIE45KabqJrfVn3FMrGyTYakvl6mjfyWAA
 zQ6keHduqKuOt+mQkw7kCUGMVWEN0rkJGMNDkDrPwfiXXavHgJBUI/hej5IG2yBDYQvHJgEwiT
 U0g=
X-IronPort-AV: E=Sophos;i="5.81,251,1610434800"; 
   d="scan'208";a="110146014"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Mar 2021 02:08:55 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 16 Mar 2021 02:08:49 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Tue, 16 Mar 2021 02:08:47 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v8 0/3] Adding the Sparx5 Switch Reset Driver
Date:   Tue, 16 Mar 2021 10:08:36 +0100
Message-ID: <20210316090839.3207930-1-steen.hegelund@microchip.com>
X-Mailer: git-send-email 2.30.2
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
2.30.2

