Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CBF13474EA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 10:44:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235115AbhCXJo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Mar 2021 05:44:26 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:48495 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235077AbhCXJoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Mar 2021 05:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1616579060; x=1648115060;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vAL2C/cv6cfhXR8yAq0F6TMT+xO5j2GY0OKdM64ZkRE=;
  b=WtZOsbSils4UCdfh8IvkrM2p2LshQosDja7aahKWElpI7LF0f1lRBdUS
   pqWCe/6VWeav2By9xujgKSeWqS8pw2eXMayVLht3HSo8/niO2yMp1UU06
   S8gsBlu9ufF6oqmQgnaEBBYCjyfFAEr3Yg1ei68MPj2ypYf3gG7pxMy0E
   y33DG5GO0/p3T5o45QmO7tIo2Zx0qXRg22bRJROECbIhS4jH8+hSf9dxh
   Nqk6usRFXh2aPzr2MBPg+5BKgGOS8E2VoA2ZnnyeVLrdhUlTM67qXOy7d
   woMuiStXJYSBs7hkDt5BH5+jGL85QOpkapl2lxF5Mx2MXAHw5l0z8nHx1
   w==;
IronPort-SDR: aAaAaMi9zn5b0IKvAXVll+KT1qEYlXSXP8NEQWe7jSRcKsoO+nqpYopgBpi3nVF7kfvvFVtrQf
 G5HQV5cJejqk0/4DSKD/LaWrbxWX6JyY7uRRyyrfYlZiJGMTRD8/g7GhKHpt5crXiKEl7hVKcG
 lTgG2r3kf2m6QvYp/3Y1feD4C2iFgTSEOUWFoUf1Kg2HWAN1G9igbSa/8LNJnlDF+fo9rqGKtp
 xevkajNMmnSvv17+g7ww+o1KJQKakkOruTe042R9FbXIi4lW4CstrGE1IB9uivbkDshSMtFvGx
 R7M=
X-IronPort-AV: E=Sophos;i="5.81,274,1610434800"; 
   d="scan'208";a="108354587"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Mar 2021 02:44:19 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 24 Mar 2021 02:44:19 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Wed, 24 Mar 2021 02:44:15 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [RESEND PATCH 0/5] clk: at91: updates for power management and dvfs
Date:   Wed, 24 Mar 2021 11:43:48 +0200
Message-ID: <20210324094353.1710114-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series addresses the power management for SAMA7G5 and also updates
the master clock prescaller and master clock divider drivers to accommodate
the requests at [1].

The power management part is implemented by adding
save_context()/restore_context() on each clock driver (patch 1/5). Since
the PM part is necessary only for backup mode (supported on SAMA5D2 and
SAMA7G5) the pmc.c has been adapted to call the
save_context()/restore_context() only on switches to/from backup mode
(patch 2/5).

Patch 3/5 adds the securam clock on SAMA7G5. This is necessary for
backup mode of SAMA7G5.

Patch 4/5 adds registers definitions for the new master clocks (MCK1..4) of
SAMA7G5 and adapt the clk-master.c. The defines exported in
include/linux/clk/at91_pmc.h will be also used by platform specific PM
code.

Patch 5/5 adpat the master clock divider and master clock prescaller
to address the requests at [1].

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/lkml/20210105104426.4tmgc2l3vyicwedd@vireshk-i7/

Claudiu Beznea (5):
  clk: at91: re-factor clocks suspend/resume
  clk: at91: pmc: execute suspend/resume only for backup mode
  clk: at91: sama7g5: add securam's peripheral clock
  clk: at91: clk-master: add register definition for sama7g5's master
    clock
  clk: at91: clk-master: update for dvfs

 drivers/clk/at91/at91rm9200.c       |   2 +-
 drivers/clk/at91/at91sam9260.c      |   2 +-
 drivers/clk/at91/at91sam9g45.c      |   2 +-
 drivers/clk/at91/at91sam9n12.c      |   2 +-
 drivers/clk/at91/at91sam9rl.c       |   2 +-
 drivers/clk/at91/at91sam9x5.c       |   2 +-
 drivers/clk/at91/clk-generated.c    |  45 +++-
 drivers/clk/at91/clk-main.c         |  66 +++++
 drivers/clk/at91/clk-master.c       | 395 +++++++++++++++++++++-------
 drivers/clk/at91/clk-peripheral.c   |  38 ++-
 drivers/clk/at91/clk-pll.c          |  37 +++
 drivers/clk/at91/clk-programmable.c |  29 +-
 drivers/clk/at91/clk-sam9x60-pll.c  |  68 ++++-
 drivers/clk/at91/clk-system.c       |  20 ++
 drivers/clk/at91/clk-usb.c          |  27 ++
 drivers/clk/at91/clk-utmi.c         |  47 +++-
 drivers/clk/at91/dt-compat.c        |   2 +-
 drivers/clk/at91/pmc.c              | 175 +++---------
 drivers/clk/at91/pmc.h              |  27 +-
 drivers/clk/at91/sam9x60.c          |   2 +-
 drivers/clk/at91/sama5d2.c          |   2 +-
 drivers/clk/at91/sama5d3.c          |   2 +-
 drivers/clk/at91/sama5d4.c          |   2 +-
 drivers/clk/at91/sama7g5.c          |   3 +-
 include/linux/clk/at91_pmc.h        |  26 ++
 25 files changed, 750 insertions(+), 275 deletions(-)

-- 
2.25.1

