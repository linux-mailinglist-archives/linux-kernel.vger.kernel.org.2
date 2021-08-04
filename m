Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C28493DFD40
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbhHDIuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:50:22 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:8538 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235582AbhHDIuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:50:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628067008; x=1659603008;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SANyoTXEkSZYs9jZZwYAbHPpyzXhdOFIYKmGc0zGshw=;
  b=JFSj2pjDBn4m8i+weIidsS/NkZdxV0dP2BeVfJ9xsIKtuR6md9ikRTOd
   cgjiG+TcGctxNHsdOW1LjlE2wAdEnW4HnlM5qxQ00ek9qldyQoajRBX7n
   VFrWF7TGX6isIpuLbfPYjBhIOzXmilytut8VDCajFsMLfmfOun4wpZbdB
   /6qObuwRMAV8uCdo1LFskV1/3ySilaU/W1M/KfK4SbuYOM641+aCE+XRa
   VDrJd0EPm4kawXntPWooGHF55m/EgUA6nY0QYyu9HGQuqSrmnWIpg4Osr
   A57m1O+v/RG59iH6JpYCIG22i4BYs2ZM4N0TJq8TFRgmnJCW3iNl29bzp
   Q==;
IronPort-SDR: JnIJ5QtIuF25Imbomp8RfiFz+9kOBrxiW/FVmznWJfXDHZQaFDJKiEC+LPNFgq4D6l9rwuJpWv
 4YBxpvnn7D17uOEmXGjG15VUatOlJtEWkYUpPrSyHBdwi/1oQAJEW/7W8hZsoMOrBugFpX1rs+
 +Ymzgs5lJiUybPrCxlgqj9vxa40QYISf6tqRCon18pkAQUu27ijvz/WaJ4YK+opk7Xhozx3FkH
 yxFEmyh9rPSWNkOcjGJSW68mfx7JIgMEtXX8dfxqhDLjMOvHrm3z1u+f33iB1dRneTc6o8MGyk
 Z+Jh5HzwOdDuiGK7AoCvWs5P
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="64658358"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2021 01:50:08 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 01:50:08 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 4 Aug 2021 01:50:05 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>
Subject: [GIT PULL] ARM: at91: dt for 5.15
Date:   Wed, 4 Aug 2021 10:50:00 +0200
Message-ID: <20210804085000.13233-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here are the dt changes for 5.15 which contains addition of SAMA7G5, some
enhancements to current boards and a couple of (low priority) fixes.

Thanks, best regards,
  Nicolas

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-dt-5.15

for you to fetch changes up to 818c4593434e81c9971b8fc278215121622c755e:

  ARM: dts: at91: use the right property for shutdown controller (2021-08-02 12:34:09 +0200)

----------------------------------------------------------------
AT91 dt for 5.15:

- add sama7g5 SoC and associated evaluation kit, the sama7g5-ek
- adaptation of some DT for sama5d27 som1 ek, sama5d4 xplained and
  sama5d2 icp boards
- fixes to gpio and shutdown controller nodes for all boards

----------------------------------------------------------------
Claudiu Beznea (3):
      dt-bindings: atmel-sysreg: add bindings for sama7g5
      ARM: dts: at91: add pinctrl-{names, 0} for all gpios
      ARM: dts: at91: add conflict note for d3

Codrin Ciubotariu (1):
      ARM: dts: at91: sama5d2_icp: enable digital filter for I2C nodes

Eugen Hristev (3):
      dt-bindings: ARM: at91: document sama7g5ek board
      ARM: dts: at91: add sama7g5 SoC DT and sama7g5-ek
      ARM: dts: at91: sama5d27_som1_ek: enable ADC node

Ludovic Desroches (1):
      ARM: dts: at91: sama5d4_xplained: change the key code of the gpio key

Nicolas Ferre (1):
      ARM: dts: at91: use the right property for shutdown controller

Tudor Ambarus (1):
      ARM: dts: at91: sama5d4_xplained: Remove spi0 node

 .../devicetree/bindings/arm/atmel-at91.yaml        |   5 +
 .../devicetree/bindings/arm/atmel-sysregs.txt      |  14 +-
 arch/arm/boot/dts/Makefile                         |   2 +
 arch/arm/boot/dts/at91-kizbox3_common.dtsi         |   2 +-
 arch/arm/boot/dts/at91-sam9x60ek.dts               |  18 +-
 arch/arm/boot/dts/at91-sama5d27_som1_ek.dts        |   6 +-
 arch/arm/boot/dts/at91-sama5d27_wlsom1_ek.dts      |   2 +-
 arch/arm/boot/dts/at91-sama5d2_icp.dts             |   8 +-
 arch/arm/boot/dts/at91-sama5d2_ptc_ek.dts          |   2 +-
 arch/arm/boot/dts/at91-sama5d2_xplained.dts        |   2 +-
 arch/arm/boot/dts/at91-sama5d3_xplained.dts        |  31 +-
 arch/arm/boot/dts/at91-sama5d4_xplained.dts        |  32 +-
 arch/arm/boot/dts/at91-sama7g5ek.dts               | 656 +++++++++++++++
 arch/arm/boot/dts/sama7g5-pinfunc.h                | 923 +++++++++++++++++++++
 arch/arm/boot/dts/sama7g5.dtsi                     | 528 ++++++++++++
 15 files changed, 2209 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91-sama7g5ek.dts
 create mode 100644 arch/arm/boot/dts/sama7g5-pinfunc.h
 create mode 100644 arch/arm/boot/dts/sama7g5.dtsi

-- 
Nicolas Ferre
