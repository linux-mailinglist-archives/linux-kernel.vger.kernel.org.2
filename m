Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECE3A409B30
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 19:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243695AbhIMRvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 13:51:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:64157 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229937AbhIMRvP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 13:51:15 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10106"; a="285446847"
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="285446847"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2021 10:49:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,290,1624345200"; 
   d="scan'208";a="432659202"
Received: from bspteam04.iind.intel.com ([10.106.46.142])
  by orsmga006.jf.intel.com with ESMTP; 13 Sep 2021 10:49:56 -0700
From:   shruthi.sanil@intel.com
To:     daniel.lezcano@linaro.org, tglx@linutronix.de, robh+dt@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     andriy.shevchenko@linux.intel.com, kris.pan@linux.intel.com,
        mgross@linux.intel.com, srikanth.thokala@intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        mallikarjunappa.sangannavar@intel.com, shruthi.sanil@intel.com
Subject: [PATCH v7 0/2] Add the driver for Intel Keem Bay SoC timer block
Date:   Mon, 13 Sep 2021 23:19:53 +0530
Message-Id: <20210913174955.32330-1-shruthi.sanil@intel.com>
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

Changes since v6:
- Removed the unused compatible string from the mfd device node
  to fix the error thrown by the make dt-binding command.

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

 .../bindings/timer/intel,keembay-timer.yaml   | 172 ++++++++++++
 MAINTAINERS                                   |   5 +
 drivers/clocksource/Kconfig                   |  11 +
 drivers/clocksource/Makefile                  |   1 +
 drivers/clocksource/timer-keembay.c           | 252 ++++++++++++++++++
 5 files changed, 441 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/intel,keembay-timer.yaml
 create mode 100644 drivers/clocksource/timer-keembay.c


base-commit: 6880fa6c56601bb8ed59df6c30fd390cc5f6dd8f
-- 
2.17.1

