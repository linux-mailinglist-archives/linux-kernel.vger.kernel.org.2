Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E59643618A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Oct 2021 14:23:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbhJUMZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 08:25:21 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:3531 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbhJUMZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 08:25:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634818984; x=1666354984;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=YtjyPXLkroGsz9agc6VrcGiYg7a86tG8R99+t7K0eFo=;
  b=EGqQsKl3EYcNaPsjhYHqHdrWv1FKdLGsjrBAfQeuDPcBisOydv0DbI2Y
   u/GgBtmZ7CeO0+bEUFGlTvb8eTCk/XCiyaC408d0eIc8PwryWSCfcV7KU
   VgcJlulxUZ3l5k9t4f1s+3G5ZEv3bjqtKPZDgObMECpL6fuPpmrgGRWDC
   YOkPS10TXIP8D7lbbPqeQ/X5nFj9yi/jyVYKtxIrW7xrYtAfsusfkjt92
   PZyePeNLbbtxy+beJI84cKp0MLSwGMPF/iI+TAxEoc3SOLIVo6HabbjfY
   FUuwVLbWIJCKOb9ybkz3ztuHaZvXF7W1uPq505tPm2giSRzwSlCSA+Md2
   Q==;
IronPort-SDR: 5SjRX4WIFmH8a0fVc5piMgZLHkcdwsfOgArp/+Sa9QkmWSA0vb5SWWUMGKEaE23B1hB2mOyYAF
 39K9n43lAupipxDUUW1u2CPoXwqEgEKFHfVU7XGHm7U3qPC+QHdZT6kOuk5nmTK6jJigu54QjJ
 WdFjSGjslmyzAChHzYkvZUp9x0R4lrR/KFLGDjSAc66KittI3jDRHEMTdvRLZ2Gazt2LDnxHcs
 8eCw3V8VitFTw54X8DeTxD7pD/R4ahNG3HRg8eqgx7/4SX2z4R9FfSNqEj7xKkbWJibQbXxqB1
 J13owTIfaSHlGBVEFWcuP7Uf
X-IronPort-AV: E=Sophos;i="5.87,169,1631602800"; 
   d="scan'208";a="133907797"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Oct 2021 05:23:03 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 21 Oct 2021 05:23:03 -0700
Received: from ness.mchp-main.com (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Thu, 21 Oct 2021 05:23:01 -0700
From:   <nicolas.ferre@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <linux-clk@vger.kernel.org>
CC:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Linux Kernel list <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [GIT PULL] clk: at91: clk changes for 5.16
Date:   Thu, 21 Oct 2021 14:22:48 +0200
Message-ID: <20211021122248.33261-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Organization: microchip
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Stephen,

Here are the clk changes for 5.16. I took the initiative to create a
Pull-Request for it as it's surely more convenient, as I proposed in my
reply to Claudiu's cover letter.
I created it on top of your current clk-at91 branch that contains one patch by
Clément already.

Please pull.

Thanks, best regards,
  Nicolas

The following changes since commit c405f5c15e9f6094f2fa1658e73e56f3058e2122:

  clk: at91: check pmc node status before registering syscore ops (2021-10-07 20:47:47 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git tags/clk-at91-5.16

for you to fetch changes up to 865aea519c06456c30846782be063dd9fcd3f99e:

  clk: use clk_core_get_rate_recalc() in clk_rate_get() (2021-10-21 14:00:59 +0200)

----------------------------------------------------------------
AT91 clk driver changes for 5.16:

- Clock power management for new SAMA7G5 SoC;
- Updates to the master clock driver and sam9x60-pll to be able to use
  cpufreq-dt driver and avoid overclocking of CPU and MCK0 domains while
  changing the frequency via DVFS;
- Power management refinement with the use of save_context()/restore_context()
  on each clock driver to specify their use in case of Backup mode only.

----------------------------------------------------------------
Claudiu Beznea (15):
      clk: at91: re-factor clocks suspend/resume
      clk: at91: pmc: execute suspend/resume only for backup mode
      clk: at91: sama7g5: add securam's peripheral clock
      clk: at91: clk-master: add register definition for sama7g5's master clock
      clk: at91: clk-master: improve readability by using local variables
      clk: at91: pmc: add sama7g5 to the list of available pmcs
      clk: at91: sam9x60-pll: use DIV_ROUND_CLOSEST_ULL
      clk: at91: clk-master: check if div or pres is zero
      clk: at91: clk-master: mask mckr against layout->mask
      clk: at91: clk-master: fix prescaler logic
      clk: at91: clk-sam9x60-pll: add notifier for div part of PLL
      clk: at91: clk-master: add notifier for divider
      clk: at91: sama7g5: remove prescaler part of master clock
      clk: at91: sama7g5: set low limit for mck0 at 32KHz
      clk: use clk_core_get_rate_recalc() in clk_rate_get()

 drivers/clk/at91/at91rm9200.c       |   2 +-
 drivers/clk/at91/at91sam9260.c      |   2 +-
 drivers/clk/at91/at91sam9g45.c      |   2 +-
 drivers/clk/at91/at91sam9n12.c      |   2 +-
 drivers/clk/at91/at91sam9rl.c       |   2 +-
 drivers/clk/at91/at91sam9x5.c       |   2 +-
 drivers/clk/at91/clk-generated.c    |  46 +++-
 drivers/clk/at91/clk-main.c         |  66 +++++
 drivers/clk/at91/clk-master.c       | 463 ++++++++++++++++++++++++++++-------
 drivers/clk/at91/clk-peripheral.c   |  40 ++-
 drivers/clk/at91/clk-pll.c          |  39 +++
 drivers/clk/at91/clk-programmable.c |  29 ++-
 drivers/clk/at91/clk-sam9x60-pll.c  | 174 ++++++++++---
 drivers/clk/at91/clk-system.c       |  20 ++
 drivers/clk/at91/clk-usb.c          |  27 ++
 drivers/clk/at91/clk-utmi.c         |  39 +++
 drivers/clk/at91/dt-compat.c        |   2 +-
 drivers/clk/at91/pmc.c              | 173 +++----------
 drivers/clk/at91/pmc.h              |  29 ++-
 drivers/clk/at91/sam9x60.c          |   6 +-
 drivers/clk/at91/sama5d2.c          |   2 +-
 drivers/clk/at91/sama5d3.c          |   2 +-
 drivers/clk/at91/sama5d4.c          |   2 +-
 drivers/clk/at91/sama7g5.c          |  29 +--
 drivers/clk/clk.c                   |   2 +-
 25 files changed, 890 insertions(+), 312 deletions(-)

-- 
Nicolas Ferre
