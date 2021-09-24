Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34FA54173F9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 15:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345504AbhIXNBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 09:01:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:22007 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345554AbhIXM6d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:58:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1632488220; x=1664024220;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=AmKKclpZcFNcvwMP+o4M6sQV78XNe3m606nLof/hX7U=;
  b=f0BIccMiHO/aO3IQF0iYuLiiJ9DTlmXUmD2JH3adgu0qcS2SVKXGdN3k
   khKwaHIuP9+JwhgcVlAY6ibPnOzIbmjUSLYKTXNzW+ncZs8gJpgit6swy
   m8LgLFZD2I61ViaXJZD5kE/+JhY3Ml0xwmn8SSrDQ1Jh+e7xJ47DvAgQr
   e183AmGgYBAaFh/gcwDhHZwXQZ0rrblKDZjDpzxrlN487f7ckWYoFHSFl
   QGkIgMx/4VsfJLEHnorytqIwO8kOeqUPf/yaH6/5tNZWSsHVS2PnVwy0d
   xET9Y6DQAs/l3fkKbQi3COdjAilBhtRc45fytUTo1pCvIvI8rYclLQqPQ
   g==;
IronPort-SDR: kV9HdlRilkcqA6M2KxI509HJJQvLmqlFKpiuSG+EjQbhrMtym/MRkwU24X7fuq0+IkMQGc0Lpr
 P3febleJik1wDpv10Um/YzToPYQVJ0SNu9jmiEMFOS1qauf25VaCCnYl1bJcPR3Lzfv2LQkG9g
 h7bWHbJektY2z/DUBoeIPrmfe6pRDgfd78Y83v6STYnGxMBI5FFWr/4r8sBFLOp0eIkPx8q2X4
 +5LXz9+daNLaVbjW4t13hWyiIBrfM0L8UA0SnmrispMD+QZ50gyBMSB//v5l+Cn9W2mPq0yMup
 f/mRVD0QwCmEKsRkJee15MFA
X-IronPort-AV: E=Sophos;i="5.85,319,1624345200"; 
   d="scan'208";a="70524939"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Sep 2021 05:56:58 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 24 Sep 2021 05:56:58 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 24 Sep 2021 05:56:55 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v6 0/3] Add driver for lan966x Generic Clock Controller
Date:   Fri, 24 Sep 2021 18:26:50 +0530
Message-ID: <20210924125653.2955-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a device driver for Generic Clock Controller
of lan966x SoC.

v5 -> v6:
- Added Acked-by to dt-bindings file.
- Removed "_clk" in clock-names.
- Added Reviewed-by to Documentation file.

v4 -> v5:
- In v4 dt-bindings, missed adding "clock-names" in required
  properties and example. So, added them.
- Returning proper error - PTR_ERR.
- Removed unused variable "ret" in probe function.

v3 -> v4:
- Updated "clocks" and added "clock-names" in dt-bindings.
- Used clk_parent_data instead of of_clk_get_parent_name().

v2 -> v3:
- Fixed dt_binding_check errors.

v1 -> v2:
- Updated license in dt-bindings.
- Updated example provided for clock controller node.

Kavyasree Kotagiri (3):
  dt-bindings: clock: lan966x: Add binding includes for lan966x SoC
    clock IDs
  dt-bindings: clock: lan966x: Add LAN966X Clock Controller
  clk: lan966x: Add lan966x SoC clock driver

 .../bindings/clock/microchip,lan966x-gck.yaml |  57 +++++
 drivers/clk/clk-lan966x.c                     | 236 ++++++++++++++++++
 include/dt-bindings/clock/microchip,lan966x.h |  28 +++
 3 files changed, 321 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
 create mode 100644 drivers/clk/clk-lan966x.c
 create mode 100644 include/dt-bindings/clock/microchip,lan966x.h

-- 
2.17.1

