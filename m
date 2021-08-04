Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92ECD3DFD2C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Aug 2021 10:43:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236669AbhHDIni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Aug 2021 04:43:38 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:17712 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235307AbhHDInh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Aug 2021 04:43:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628066605; x=1659602605;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0ADUjCZHtfH0W3DEFX09j9+FrYmRgchKbOEPrq5pl80=;
  b=zDRE1FqiiBjDBdDw3hbEC6zAoRYBGSh6gDknXTKYpZAkB5d/IgmhYp7J
   MpAviV6erScTLRKS6K5LswJXkuQ8XhSiHm0ZrqoV6XCYO3bMzDKXeyu+U
   RrFWMpahUIa9iFfbIFZB+/QXHIJlQReP7TChO9M6jUnS40gU5wvwPKgIR
   Fp/nw12H8kiZimpOpw2GN3al5icA//E2kdCoGKo+Q7hEtGi/EdGdGD0Ti
   1ijEAOh1VlSsveAm5HvwVGDxy/j+7iEyojkMFyAlfMwo3JOtCOtIgJPMI
   St5aMc75y7J+pjA6umyqEXTnOpm5crtIg1SkfW0DF2r9anN3Kbfxv1UYl
   Q==;
IronPort-SDR: J1Qr9iEnZafSLZTXtoJr6w7ACiPE3SVafJ0Kig7vY3+K05HuBAdbIr8SN5UrmiaSB3r/10e8da
 RztrieyHORqcW4QXaicSVR91rvWH7RqEL7viCJzc+p+nmJk5G2jDtyUD7Ef6N5HxUdpgyvbc0t
 xdYCs8i6XJFxp/AphW3mEHmkxwdBxP5S4KRs2xtqy9wa09oosWpltTNxDJQBt7oK4kr0NQCp11
 RDqOk6jMlB8QiGic3EABhR22faLmxWzhT14n74ebrmEkyTriPWiGI2r+bKnyfa84OTp+ihLbEC
 10ZVSrrYV3TqXQVniIcS80LL
X-IronPort-AV: E=Sophos;i="5.84,293,1620716400"; 
   d="scan'208";a="130992116"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Aug 2021 01:43:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 4 Aug 2021 01:43:24 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server id 15.1.2176.2 via Frontend
 Transport; Wed, 4 Aug 2021 01:43:22 -0700
From:   <nicolas.ferre@microchip.com>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        <arm@kernel.org>, <soc@kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Subject: [GIT PULL v2] ARM: at91: soc for 5.15
Date:   Wed, 4 Aug 2021 10:43:16 +0200
Message-ID: <20210804084316.12641-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210804081721.11093-1-nicolas.ferre@microchip.com>
References: <20210804081721.11093-1-nicolas.ferre@microchip.com>
MIME-Version: 1.0
Organization: microchip
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Arnd, Olof,

Here are the soc changes for 5.15 which contains the introduction of our new
SoC family: the SAMA7G5.
Note that one header file is shared with the clock sub-system. We synchronized
with Stephen to make it appear in this Pull-Request.

- v1 -> v2: text of the signed tag aligned with kernel revision targeted.

Thanks, best regards,
  Nicolas

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/at91-soc-5.15

for you to fetch changes up to ad9bc2e35cf575644064284943aefdde426644cc:

  ARM: at91: pm: add sama7g5 shdwc (2021-07-19 14:32:13 +0200)

----------------------------------------------------------------
AT91 soc for 5.15:

- add new SoC based on a Cortex-A7 core: the SAMA7G5 family
  - mach-at91 entry, Kconfig and header files
  - Power Management Controller (PMC) code and associated power management
    changes. Support for suspend/resume, Ultra Low Power modes and
    Backup with Memory in Self-Refresh mode.
  - Power management association with DDR controller and
    shutdown controller for addressing this variety of modes.

----------------------------------------------------------------
Claudiu Beznea (23):
      clk: at91: add register definition for sama7g5's master clock
      ARM: at91: pm: move pm_bu to soc_pm data structure
      ARM: at91: pm: move the setup of soc_pm.bu->suspended
      ARM: at91: pm: document at91_soc_pm structure
      ARM: at91: pm: check for different controllers in at91_pm_modes_init()
      ARM: at91: pm: do not initialize pdev
      ARM: at91: pm: use r7 instead of tmp1
      ARM: at91: pm: avoid push and pop on stack while memory is in self-refersh
      ARM: at91: pm: s/CONFIG_SOC_SAM9X60/CONFIG_HAVE_AT91_SAM9X60_PLL/g
      ARM: at91: pm: add support for waiting MCK1..4
      ARM: at91: sfrbu: add sfrbu registers definitions for sama7g5
      ARM: at91: ddr: add registers definitions for sama7g5's ddr
      ARM: at91: pm: add self-refresh support for sama7g5
      ARM: at91: pm: add support for MCK1..4 save/restore for ulp modes
      ARM: at91: pm: add support for 2.5V LDO regulator control
      ARM: at91: pm: wait for ddr power mode off
      ARM: at91: pm: add sama7g5 ddr controller
      ARM: at91: pm: add sama7g5 ddr phy controller
      ARM: at91: pm: save ddr phy calibration data to securam
      ARM: at91: pm: add backup mode support for SAMA7G5
      ARM: at91: pm: add sama7g5's pmc
      ARM: at91: pm: add pm support for SAMA7G5
      ARM: at91: pm: add sama7g5 shdwc

Eugen Hristev (3):
      ARM: at91: add new SoC sama7g5
      ARM: at91: debug: add sama7g5 low level debug uart
      ARM: at91: sama7: introduce sama7 SoC family

 arch/arm/Kconfig.debug               |  10 +
 arch/arm/mach-at91/Kconfig           |  18 +
 arch/arm/mach-at91/Makefile          |   1 +
 arch/arm/mach-at91/generic.h         |   2 +
 arch/arm/mach-at91/pm.c              | 343 +++++++++++----
 arch/arm/mach-at91/pm.h              |   3 +
 arch/arm/mach-at91/pm_data-offsets.c |   2 +
 arch/arm/mach-at91/pm_suspend.S      | 827 ++++++++++++++++++++++++++---------
 arch/arm/mach-at91/sama7.c           |  33 ++
 include/linux/clk/at91_pmc.h         |  26 ++
 include/soc/at91/sama7-ddr.h         |  80 ++++
 include/soc/at91/sama7-sfrbu.h       |  34 ++
 12 files changed, 1090 insertions(+), 289 deletions(-)
 create mode 100644 arch/arm/mach-at91/sama7.c
 create mode 100644 include/soc/at91/sama7-ddr.h
 create mode 100644 include/soc/at91/sama7-sfrbu.h

-- 
Nicolas Ferre
