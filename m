Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12563443E95
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:50:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231629AbhKCIxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:53:07 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:44039 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbhKCIxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635929429; x=1667465429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HR8MgdUn71d4vquXx3WLx9oUzmUU/LV8HVEitayxeBs=;
  b=QzUOm8NGygwc13NZkHo1/GRDHhogerSryK64+2YQbYX3wzg80CImBuDa
   lYREWo7wd4x7T8Tt5FvEXa1JJywjvE9U2B9lizTe357z9NflE809faQNC
   6vo5hatVTMEzBcQQk58R0eInQvgEYPL1WSDqPfQ8CnKSEcgy/yPAwMjiT
   R6KCt3xTFjRPsrY4PqnQegC87vHeEHL7NN+vnR8xyZM2zUdiLSicq9oui
   HDk47AZd5g+I1tpta5jms/g4xRuYQD/xtS3Pm/iC/WUkQMbWtOzIvS1eg
   93tq8Z0MwgeVRCmEUZsSaJ1GLZTAT+/WuIZA9I8vpuBp/Wv1johY4yvpQ
   g==;
IronPort-SDR: 6XdMca9L04c6un8aVU7iiq/XO7tiqDbx5kZUd2CYTa6o6uUxqu9FJAGaOEA0QwIZd0VS3VQ4KI
 CMEmkHQ3tGIDIVIS43M6WPecqv98sauDOKwwS7Qs1ywVyXkbY/NPibPLqua6NI0aF8ZHCWrQ0E
 J+y33RuMFfvfC+6a2e5HHWXBzR0czJyPAh4uMyzoLTVWkHkxCxRkYq4R8WrX8QSBxhjbySwkhr
 g/WdH6RYn5ZpM0mrztIi8W/aZNzLY+jVRt6S9L3jx2ayniFiyMMxLt3sAra4pY2LuB4YweU/ic
 qNqpEorqr4ZCoCHOFwTWy7UZ
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="150539826"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Nov 2021 01:50:26 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 3 Nov 2021 01:50:26 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 3 Nov 2021 01:50:24 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <nicolas.ferre@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH v4 0/4] Extend lan966x clock driver for clock gating support
Date:   Wed, 3 Nov 2021 09:50:58 +0100
Message-ID: <20211103085102.1656081-1-horatiu.vultur@microchip.com>
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

v3->v4:
 - fix reg property in the schema file

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

 .../bindings/clock/microchip,lan966x-gck.yaml |  5 +-
 drivers/clk/clk-gate.c                        | 35 +++++++++++
 drivers/clk/clk-lan966x.c                     | 59 ++++++++++++++++++-
 include/dt-bindings/clock/microchip,lan966x.h |  8 ++-
 include/linux/clk-provider.h                  | 23 ++++++++
 5 files changed, 125 insertions(+), 5 deletions(-)

-- 
2.33.0

