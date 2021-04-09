Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99398359CD6
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 13:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233882AbhDILOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Apr 2021 07:14:36 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:12864 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbhDILOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Apr 2021 07:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1617966862; x=1649502862;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qZFUWLDF6CKxNvBkCZRU9lb0ndfbo/lqLOhVBqgLb4E=;
  b=uusJmTDd46++AVTIgYJbOoDVtw+hcJI8cuDV806M4ariI4rjNcsnxeSJ
   CZVYk/xNm8mBArrfcS5R8KLRAwSmgDQH+TsOB49Or+zJBnRQ80RaAzZ+/
   jQ0QarKU8wfbm1GJwfmGbSQXy9ppgJQoG31AKwnd+CO1EJAgZukTvNzAI
   Or73cf85L0HhFqthIXC14JQ9MvO0r03oQN3c1DYgOtkbB/8zJC4ZJ07d9
   aWmt6j1cRma9KI0epSFxlgq9HHgBq3MQZaIrfa0Uxc4H58de4VE6/91Qm
   HXNQq+HflLfMb0YHhVR02OxDHX7VC40l10hak+zO5MN7ZuuCd5oHIL7pH
   g==;
IronPort-SDR: YPa/25pFMPrdajRyu+iUW5SkmHzcO+T1oYlVfXSbOKObnIe3nHBh4bnUCNstAsBn9xVk2iGLCd
 tQ4BoliYD2GHAVb9gZu90zF4wV3Z0Kgykjiq9Me8BvAfsu9c37+JCqaOjhmTWh6xOx23Ee8Vst
 GeDuVYdGkTRB7hKsMeopytJzFilSvaLrHQAgm1UW7G109TVkv7s/6AnxRAyiiiptncUZJ6IgkJ
 +vrnjYrGM/4Wm4INO8y2PCmoMQLGMc64xx+2lZi3J3mKhIJHRlUiB+gqo3Cfo0ZClqxQbEZBGD
 UAk=
X-IronPort-AV: E=Sophos;i="5.82,209,1613458800"; 
   d="scan'208";a="122420532"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Apr 2021 04:14:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 9 Apr 2021 04:14:21 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Fri, 9 Apr 2021 04:14:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <linux@armlinux.org.uk>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v2 00/24] ARM: at91: pm: add support for sama7g5
Date:   Fri, 9 Apr 2021 14:13:21 +0300
Message-ID: <20210409111345.294472-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series adds PM support for SAMA7G5. The standby, ulp0, ulp1, and
backup modes are supported.

Thank you,
Claudiu Beznea

Changes in v2:
- keep only the generic sama7_dt in patch 22/24 and adapt patch 23/24
- collected tags

Claudiu Beznea (23):
  ARM: at91: pm: move pm_bu to soc_pm data structure
  ARM: at91: pm: move the setup of soc_pm.bu->suspended
  ARM: at91: pm: document at91_soc_pm structure
  ARM: at91: pm: check for different controllers in at91_pm_modes_init()
  ARM: at91: pm: do not initialize pdev
  ARM: at91: pm: use r7 instead of tmp1
  ARM: at91: pm: avoid push and pop on stack while memory is in
    self-refersh
  ARM: at91: pm: s/CONFIG_SOC_SAM9X60/CONFIG_HAVE_AT91_SAM9X60_PLL/g
  ARM: at91: pm: add support for waiting MCK1..4
  ARM: at91: sfrbu: add sfrbu registers definitions for sama7g5
  ARM: at91: ddr: add registers definitions for sama7g5's ddr
  ARM: at91: pm: add self-refresh support for sama7g5
  ARM: at91: pm: add support for MCK1..4 save/restore for ulp modes
  ARM: at91: pm: add support for 2.5V LDO regulator control
  ARM: at91: pm: wait for ddr power mode off
  dt-bindings: atmel-sysreg: add bindings for sama7g5
  ARM: at91: pm: add sama7g5 ddr controller
  ARM: at91: pm: add sama7g5 ddr phy controller
  ARM: at91: pm: save ddr phy calibration data to securam
  ARM: at91: pm: add backup mode support for SAMA7G5
  ARM: at91: pm: add sama7g5's pmc
  ARM: at91: pm: add pm support for SAMA7G5
  ARM: at91: pm: add sama7g5 shdwc

Eugen Hristev (1):
  ARM: at91: sama7: introduce sama7 SoC family

 .../devicetree/bindings/arm/atmel-sysregs.txt |  15 +-
 arch/arm/mach-at91/Makefile                   |   1 +
 arch/arm/mach-at91/generic.h                  |   2 +
 arch/arm/mach-at91/pm.c                       | 343 ++++++--
 arch/arm/mach-at91/pm.h                       |   3 +
 arch/arm/mach-at91/pm_data-offsets.c          |   2 +
 arch/arm/mach-at91/pm_suspend.S               | 827 +++++++++++++-----
 arch/arm/mach-at91/sama7.c                    |  33 +
 include/soc/at91/sama7-ddr.h                  |  80 ++
 include/soc/at91/sama7-sfrbu.h                |  34 +
 10 files changed, 1050 insertions(+), 290 deletions(-)
 create mode 100644 arch/arm/mach-at91/sama7.c
 create mode 100644 include/soc/at91/sama7-ddr.h
 create mode 100644 include/soc/at91/sama7-sfrbu.h

-- 
2.25.1

