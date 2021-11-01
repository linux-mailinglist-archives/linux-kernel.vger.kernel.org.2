Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB8654414FF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:07:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhKAIKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:10:01 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62106 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbhKAIJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:09:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635754045; x=1667290045;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OqCupavxhellN9DVR1JhZQjBSHWKv2Z7me13wqboXFA=;
  b=NQxnJ5z3jW3/xH6F5RBXQWmLq9a9h3slWpo1bML9LSivyN99bXnkwokm
   /BT4KR86uOj+Y39pxxX9yooKMakIk6cAzrHY7oKkSZPAijHTTQBdqySIS
   a02dwNnf5srG9ZCAMuF8wop7vhrQg0BAi0pPL+vg8blNO++vRrSpCgF5L
   a8AlsojQrMIgTUXr8UbkD9av4G81ZuHNlDK2fBgY+tjYQvD6EVKiTj0qo
   NdhOLlQpOfvQcGGfAodHTLVSWbetohWgL12e4vsE7OJphFUJvIL5iPUZU
   vH0xGOk7DPktedQitmmMkEP3BWm+WGUUdsdznkloxPOG8UprA6xoj3Mai
   A==;
IronPort-SDR: vrQeYL6J66D6id8IuHpnn0Zu1WGRP+40chCbfCulU9d0+Bc11evTze2C8vqrw+5FMvdEI1FSqb
 tG/tFHq+3CpQE4JAH/yLBUV6GGijHFtxcqY1UAk/StzciVk5OjOPuH4YVGr5OyZvV+mr3jTBxp
 0xSZKDctFN7LZ7DKqis3+TgUdMSmrwmtmRl5o88LSsSCiCyLidoYHRSP1qAgNiamXgaYiL+Y9P
 TazDQiJux9JHTxu/T0IeIS/nGP7i4zvsTc5WbcOlbFYn4HiykqQRpYk+bFEMEFbMeFehwW3lCO
 K9KlJRsGvC5CvHyulHlVcmhx
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="74923430"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Nov 2021 01:07:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 1 Nov 2021 01:07:23 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 1 Nov 2021 01:07:21 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <kavyasree.kotagiri@microchip.com>, <eugen.hristev@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH v3 0/4] Extend lan966x clock driver for clock gating support
Date:   Mon, 1 Nov 2021 09:08:41 +0100
Message-ID: <20211101080845.3343836-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series depends on the following series, therefor keep it as RFC.
https://www.spinics.net/lists/linux-clk/msg62795.html

This patch series extend the clock driver to support also clock gating.

v2->v3:
 - add devm_clk_hw_register_gate function

v1->v2:
 - add Acked-by tag for patch 2
 - make the resource for clock gating as an optional resource

Horatiu Vultur (4):
  clk: gate: Add devm_clk_hw_register_gate()
  dt-bindings: clock: lan966x: Extend for clock gate support
  dt-bindings: clock: lan966x: Extend includes with clock gates
  clk: lan966x: Extend lan966x clock driver for clock gating support

 .../bindings/clock/microchip,lan966x-gck.yaml |  3 +-
 drivers/clk/clk-gate.c                        | 35 +++++++++++
 drivers/clk/clk-lan966x.c                     | 59 ++++++++++++++++++-
 include/dt-bindings/clock/microchip,lan966x.h |  8 ++-
 include/linux/clk-provider.h                  | 23 ++++++++
 5 files changed, 123 insertions(+), 5 deletions(-)

-- 
2.33.0

