Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C92D4401FC4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:37:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244414AbhIFShd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:37:33 -0400
Received: from mga14.intel.com ([192.55.52.115]:47238 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244290AbhIFShb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:37:31 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10099"; a="219714174"
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="219714174"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2021 11:36:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,273,1624345200"; 
   d="scan'208";a="579716452"
Received: from bspteam04.iind.intel.com ([10.106.46.142])
  by orsmga004.jf.intel.com with ESMTP; 06 Sep 2021 11:36:22 -0700
From:   shruthi.sanil@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, kris.pan@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH v6 0/2] Add the driver for Intel Keem Bay SoC timer block
Date:   Tue,  7 Sep 2021 00:06:19 +0530
Message-Id: <20210906183621.21075-1-shruthi.sanil@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shruthi Sanil <shruthi.sanil@intel.com>

The timer block supports 1 64-bit free running counter
and 8 32-bit general purpose timers.

Patch 1 holds the device tree binding documentation.
Patch 2 holds the device driver.

This driver is tested on the Keem Bay evaluation module board.

Changes since v5:
- Created a MFD device for the common configuration register
  in the device tree bindings.
- Updated the timer driver with the MFD framework to access the
  common configuration register.

Changes since v4:
- Updated the description in the device tree bindings.
- Updated the unit address of all the timers and counter
  in the device tree binding.

Changes since v3:
- Update in KConfig file to support COMPILE_TEST for Keem Bay timer.
- Update in device tree bindings to remove status field.
- Update in device tree bindings to remove 64-bit address space for
  the child nodes by using non-empty ranges.

Changes since v2:
- Add multi timer support.
- Update in the device tree binding to support multi timers.
- Code optimization.

Changes since v1:
- Add support for KEEMBAY_TIMER to get selected through Kconfig.platforms.
- Add CLOCK_EVT_FEAT_DYNIRQ as part of clockevent feature.
- Avoid overlapping reg regions across 2 device nodes.
- Simplify 2 device nodes as 1 because both are from same IP block.
- Adapt the driver code according to the new simplified devicetree.

Shruthi Sanil (2):
  dt-bindings: timer: Add bindings for Intel Keem Bay SoC Timer
  clocksource: Add Intel Keem Bay timer support

 .../bindings/timer/intel,keembay-timer.yaml   | 173 ++++++++++++
 MAINTAINERS                                   |   5 +
 drivers/clocksource/Kconfig                   |  11 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-keembay.c           | 252 ++++++++++++++++++
 5 files changed, 442 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
 create mode 100644 drivers/clocksource/timer-keembay.c


base-commit: 27151f177827d478508e756c7657273261aaf8a9
-- 
2.17.1

