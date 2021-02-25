Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAECB324D32
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Feb 2021 10:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234947AbhBYJvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Feb 2021 04:51:52 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:37923 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbhBYJvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Feb 2021 04:51:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1614246693; x=1645782693;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=F3rfTVxGQi2qbRG4zQv/sOnH3Fbxz0HFmKAWLQq9zvM=;
  b=TuxS+LbUgS8i4waaoqu3I9rNaIWVivZTW1pT9UAZbYn0+BIv6k6K5yLs
   b1MWtuEhHwJhZw1c1qzSxwiJE+NFAVFqCi/yc+1Lqh+6vw8CUjc5obDDG
   LNPqmYpZDyB3uW9bczIUkqn5a0p+d+xEc+JqlL8yCyh4qZ7IVprek01pf
   aQ0MLIceyyUFt2zo4Gb6zkpXdEtHL5BbwH/I9JrW3zjGvTRODyBWemmzu
   y2srG4/gYZTOjcwe53xMbqy87B/WK6f/3asVxdKemRIiUE7zRxBptH4a2
   nK/5Cfqv0Zik8Mb0DtvJvpfUKCIBcWfwwr+l+XJIZKPzGnvjI4WHlSMeu
   A==;
IronPort-SDR: fOQPPpRAxM54YT1G2CT0ybql442twlnyv4DjZqk3AaQGc0OOIbGx0Q0E6PKfk0zFBojD1gKU3S
 Hf3sfDs+PwcqDS5LRGkxlkQIzi1gwNSK5UUTk68nHIUEmO/C5e98FyBluhAt35ebfTgLmuwHu9
 cMer2KKCfnjSN7NOE3yDO/LMlxdtp8D1+SITL3Oi7HXzX+P3PdVAkbfdKQDM3SvJpNCDDkXQQk
 ACT16wTKqvV/y4zZR9+A5vZXJIkDOs4laT8m5d3e10N/uy9w+vSIRf6GHQaeS7iz6o1c+JsO5j
 Q3k=
X-IronPort-AV: E=Sophos;i="5.81,205,1610434800"; 
   d="scan'208";a="111073774"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2021 02:50:17 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 25 Feb 2021 02:50:15 -0700
Received: from mchp-dev-shegelun.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Thu, 25 Feb 2021 02:50:13 -0700
From:   Steen Hegelund <steen.hegelund@microchip.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>
CC:     Steen Hegelund <steen.hegelund@microchip.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v6 0/3] Adding the Sparx5 Switch Reset Driver
Date:   Thu, 25 Feb 2021 10:50:02 +0100
Message-ID: <20210225095005.1510846-1-steen.hegelund@microchip.com>
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
 drivers/reset/reset-microchip-sparx5.c        | 151 ++++++++++++++++++
 5 files changed, 223 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/microchip,rst.yaml
 create mode 100644 drivers/reset/reset-microchip-sparx5.c

-- 
2.30.0

