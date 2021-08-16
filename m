Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24C283ECEB5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:46:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233459AbhHPGq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 02:46:57 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:61375 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhHPGq4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:46:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629096385; x=1660632385;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Fa+HDUhrzM19UbPMgeqxqr6FMdoF3kvbbnJcNb1KEuo=;
  b=mlHu4WwwjqyoUoKQ/zcf028Yu1lqH9BsxLCi+2bSmP/AqHd8pIn3K0Hk
   IpliW2tZntVPzMpHLWlAeExhwISWLubljYF1VKIutKfgAiYrM+mdY3YbL
   MiSCev+dTESHdrcdLIpS/uvH5cps+BMBjoPj9Bc3igFU14AVjh/mj1eh8
   MLlDt2Ip+aB5BTe0SWCbrihgTWbSFo8MwlHMHNf9Sspuczd1NBjkFgpxJ
   s7NrkTvWHWZ8eYA0ArXRB1/fsEnPfG0h2GM7cDtVs6CRiArW/CrY3Vh09
   BDw0t/L4ALbvK7fxmzyUrkBTc8tQy4ykvhb1iVoA5tXgZRf+msF7dWLs1
   w==;
IronPort-SDR: RZG8+ZbFhaZfug3g9E+DwfbwypFrDJ3MQmF26e4kMUHT+dUzqmdZWyt1UlGJ8pDrU85WlibnCm
 Cs6cdGP9aH70WuvBQPz36drcfwHoTdGyeQtPUJ2At6yCANp4Bu94Vl25VJbbcn8d7epLaWpYP0
 2gECqFc91nvZqSleK6Ia97o1A0n4h6PChKqIBlZfdHSySIud07Bks797CbJxXzB69EwDy8FTjl
 mQHJmdf3u09j884D+xifrI2f/JEY95XQeAcCckhk3YN4MNneAS1fZYtD7yOuQLAuAG/uvq+BBT
 2O0rNERXRUCO77Rks1eXXhMj
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="128382240"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2021 23:46:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 15 Aug 2021 23:46:23 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 15 Aug 2021 23:46:19 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 0/7] ARM: dts: at91: add Exegin Q5xR5 and CalAmp LMU5000
Date:   Mon, 16 Aug 2021 09:44:09 +0300
Message-ID: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds support for Exegin Q5xR5 and CalAmp LMU5000 boards
which were maintained up to this moment, separatelly, in OpenWrt tree.
With these patches the support for these boards will be included in
upstream kernel and there will be no need to forward port the proper
patches in OpenWrt every time the OpenWrt kernel version is changed.

Thank you,
Claudiu Beznea

Changes in v2:
- swapped commit message and diff b/w patches
  "dt-bindings: ARM: at91: document exegin q5xr5 board" and
  "dt-bindings: ARM: at91: document CalAmp LMU5000 board"
- re-ordered patches to accommodate the above swapping
- collected tags

Adam Porter (1):
  ARM: dts: at91: add CalAmp LMU5000 board

Claudiu Beznea (5):
  ARM: dts: at91: at91sam9260: add pinctrl label
  dt-bindings: add vendor prefix for calamp
  dt-bindings: ARM: at91: document CalAmp LMU5000 board
  dt-bindings: add vendor prefix for exegin
  dt-bindings: ARM: at91: document exegin q5xr5 board

Owen Kirby (1):
  ARM: dts: at91: add Exegin Q5xR5 board

 .../devicetree/bindings/arm/atmel-at91.yaml   |  12 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   4 +
 arch/arm/boot/dts/Makefile                    |   2 +
 arch/arm/boot/dts/at91-lmu5000.dts            | 148 +++++++++++++
 arch/arm/boot/dts/at91-q5xr5.dts              | 200 ++++++++++++++++++
 arch/arm/boot/dts/at91sam9260.dtsi            |   2 +-
 6 files changed, 367 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/boot/dts/at91-lmu5000.dts
 create mode 100644 arch/arm/boot/dts/at91-q5xr5.dts

-- 
2.25.1

