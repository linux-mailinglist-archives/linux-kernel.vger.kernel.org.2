Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B965D40F71B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 14:07:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243330AbhIQMIK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 08:08:10 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:7248 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241146AbhIQMIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 08:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631880407; x=1663416407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NXDAy+CRI7k7m+658m84ankQhiEgdMYRLNF2ieT1Yck=;
  b=tHL5u+AMyym6sU7x4UUho/QUOmo3YtRMrYflQi1Q9LV7Ln0hhDb3Qtsn
   qX0pfy9afVAJhwiBp9n/KEX6ygjm9kH5kYLULyZLWz6vHfSW3Q3U7++wg
   R/zJ2wFnFxVuYe3R9UrRgHkPUcXvgr3XMkV4V8UzseEgAdhYHZLY3lYP5
   En4f4zviJqc6CHxbW5OSN2yUikpqC0DFUrzrLdkXtfAKQYXNn/fSBFsd7
   rJw+H+27Khie/UaDuj9ti0T1Oe9NUb/U0uaMlGhmXVhGTl1r9XMpF05J3
   1cYQAeJOKj9FR/RTKPbWchQ4zd+wsBEkGNU45yj12OnwZA+LUtbuN1pGw
   g==;
IronPort-SDR: +b+mXqiQc2djas2ZRX6OJswICNBmydrq95qlNx6aFZv+rYEZQcBr9z/xDPPRJYRO0rHcM2O5rP
 +lpioxN46gRTlPJXfEM90/l3nELhb2gUgvGPhNTl041Zoo1EaqduxRIOiPFDd4DR2zVE7FeBfe
 his0WRUquUWuIQrlduljKxRxe7Ynb29V12Gbxk5f2odVTxK+RMKJcU9mRxGRVJjHsI/GHZzCG1
 tqXc38Z29gCFXArLBbglZBiwHt2IDcPAJu+daHN5IWxRUG+rHLTe1RACaDdm5NnKqi3UyqYidE
 ijDko9lP++JkXY9amwMQXusr
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="136943131"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 05:06:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 05:06:46 -0700
Received: from rob-dk-mpu01.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 05:06:44 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>
CC:     <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 00/17] clk: at91: updates for power management and dvfs
Date:   Fri, 17 Sep 2021 15:06:25 +0300
Message-ID: <20210917120642.8993-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This series addresses the clock power management for SAMA7G5 and also
updates the master clock driver and sam9x60-pll driver to accommodate
the requests at [1] and avoid overclocking of CPU and MCK0 domains while
changing the frequency via DVFS.

The power management part is implemented by adding
save_context()/restore_context() on each clock driver (patch 1/17). Since
the PM part is necessary only for backup mode (supported on SAMA5D2 and
SAMA7G5) the pmc.c has been adapted to call the
save_context()/restore_context() only on switches to/from backup mode
(patch 2/17).

Patch 3/17 adds the securam clock on SAMA7G5. This is necessary for
backup mode of SAMA7G5.

Patch 4/17 adapt SAMA7G5 MCK1..4 driver to use the defines at
include/linux/clk/at91_pmc.h introduced in commit ec03f18cc222
("clk: at91: add register definition for sama7g5's master clock").

Patch 5/17 improves a bit readabiblity in some places of master clock
driver.

Patch 6/17 enable the suspend/resume for clocks also for SAMA7G5.

Patches 7-10/17 adds fixes in master clock driver and sam9x60-pll driver.

Patches 11-12/17 address DVFS by adding notifiers for master clock driver
and sam9x60-pll driver to avoid overclocking for CPU domain and MCK0
domain.

Patch 13/17 removes the master clock prescaler from Linux clock tree
as it has been discovered a hardware bug on it and it may not lock
on some scenario although its output clock is stable.

Patch 14/17 decreases the low limit of MCK0 as it can go even to 32KHz.

Patch 15/17 uses clk_core_get_rate_recalc() in clk_rate_get().

Patches 16-17/17 adds minor cleanups on clk.c

Stephen,

I added everything in one series (again) and didn't send at 1st the non-DVFS
patches (as you suggested in [2]) as at the time of proposal patch 4/17
here depended on commit ec03f18cc222 ("clk: at91: add register definition
for sama7g5's master clock") which wasn't present on your tree at that
time.

Thank you,
Claudiu Beznea

[1] https://lore.kernel.org/lkml/20210105104426.4tmgc2l3vyicwedd@vireshk-i7/
[2] https://lore.kernel.org/lkml/163047507296.42057.10597374695758699868@swboyd.mtv.corp.google.com/ 

Changes in v3:
- minor fixes in patch 1/7 (e.g. use regmap_read() + checks + update +
  regmap_write() sequence instead of regmap_read() + checks +
  regmap_update_bits()
- patch 4/17 has been updated after commit ec03f18cc222
  ("clk: at91: add register definition for sama7g5's master clock")
- patch 6-10/17, 14-17/17 are newly introduced
- notifier for sam9x60 div pll was introduced (patch 11/17) and
  notifier logic for master clock div has been changed (patch 12/17)
  to use safe divider on PRE_RATE_CHANGE events and update clock to highest
  possible rate on POST_RATE_CHANGE events
- master clock prescaler has been removed from Linux clock tree for
  SAMA7G5

Changes in v2:
- addressed code review comments
- collected tags


Claudiu Beznea (17):
  clk: at91: re-factor clocks suspend/resume
  clk: at91: pmc: execute suspend/resume only for backup mode
  clk: at91: sama7g5: add securam's peripheral clock
  clk: at91: clk-master: add register definition for sama7g5's master
    clock
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
  clk: remove extra empty line
  clk: do not initialize ret

 drivers/clk/at91/at91rm9200.c       |   2 +-
 drivers/clk/at91/at91sam9260.c      |   2 +-
 drivers/clk/at91/at91sam9g45.c      |   2 +-
 drivers/clk/at91/at91sam9n12.c      |   2 +-
 drivers/clk/at91/at91sam9rl.c       |   2 +-
 drivers/clk/at91/at91sam9x5.c       |   2 +-
 drivers/clk/at91/clk-generated.c    |  46 ++-
 drivers/clk/at91/clk-main.c         |  66 ++++
 drivers/clk/at91/clk-master.c       | 463 ++++++++++++++++++++++------
 drivers/clk/at91/clk-peripheral.c   |  40 ++-
 drivers/clk/at91/clk-pll.c          |  39 +++
 drivers/clk/at91/clk-programmable.c |  29 +-
 drivers/clk/at91/clk-sam9x60-pll.c  | 174 +++++++++--
 drivers/clk/at91/clk-system.c       |  20 ++
 drivers/clk/at91/clk-usb.c          |  27 ++
 drivers/clk/at91/clk-utmi.c         |  39 +++
 drivers/clk/at91/dt-compat.c        |   2 +-
 drivers/clk/at91/pmc.c              | 183 +++--------
 drivers/clk/at91/pmc.h              |  29 +-
 drivers/clk/at91/sam9x60.c          |   6 +-
 drivers/clk/at91/sama5d2.c          |   2 +-
 drivers/clk/at91/sama5d3.c          |   2 +-
 drivers/clk/at91/sama5d4.c          |   2 +-
 drivers/clk/at91/sama7g5.c          |  58 +++-
 drivers/clk/clk.c                   |   5 +-
 25 files changed, 928 insertions(+), 316 deletions(-)

-- 
2.25.1

