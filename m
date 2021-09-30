Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F28741DB01
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 15:28:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351377AbhI3NaG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 09:30:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:47471 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351362AbhI3NaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 09:30:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633008503; x=1664544503;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=WGH/7oHZ2lCij6lC7BGo1OaMpElgiKRYeW6ANkvGzVg=;
  b=Vkp8WC2ioKQ37h6r35xan0z1zl8v+ZvtJdP0FEDpq/6vwp7gB/inMf2x
   z9q/34ncvYn42lfADOZC7ZgAc5r/3TAZ/jyX/BIS3zX/bSkFvptCWz9uE
   ui2M6BmE5QA2XGNGlH3JaN86ASST6aDcWo1X+jlPJoOo2z18VRlphyaJt
   Chn/Z8dD2+iyQ8YX1yMG1Lt/MIHLh/ptSvlULB+Gm0aRODjJWrrbzIRW2
   MybCrmTLPdcxoG+FaZsoasNMO7TMSpgvrhh8oavuUdP4G7jTNKhBjUMfg
   r+shCFZmtG8MwUEKFm+Zbb4Aqg6i1QeScFQhFBHLdskZDs3EfsROep94A
   A==;
IronPort-SDR: /RNOiQNmjxpxi+yLj/icS2/tINUabZwNWoMF7i4ELTYDNGgSIuAqUYKAFLMystikET5LQ+oV3o
 +kpsXZEYJJvuVW7mxEV5c3KGACBZXoREGvjPhLAVdC5Y/FhVKj9NqsHapJ67bd+BAffWHlt2T4
 eyb5vEpmLU4znwZ0EY2B/bZq/PuzHKL7YkvYF2lEpGaVy5IapzFa8fOzFQrw7eJ+x3DGmVnsTx
 an8f/XButtGKNVcu+Ast32q1RkxQirm+LL+k9V+tPq//BqKhiZJkNXHncys2QNMWGS9An1G+fd
 kE5Ja8bXxBuy+ykI+rfIkD8T
X-IronPort-AV: E=Sophos;i="5.85,336,1624345200"; 
   d="scan'208";a="137988284"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Sep 2021 06:28:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 30 Sep 2021 06:28:21 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Thu, 30 Sep 2021 06:28:17 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v7 0/3] Add driver for lan966x Generic Clock Controller
Date:   Thu, 30 Sep 2021 18:58:12 +0530
Message-ID: <20210930132815.15353-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a device driver for Generic Clock Controller
of lan966x SoC.

v6 -> v7:
- Added Kconfig and Makefile entires for lan966x clock driver.

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
 drivers/clk/Kconfig                           |   7 +
 drivers/clk/Makefile                          |   1 +
 drivers/clk/clk-lan966x.c                     | 236 ++++++++++++++++++
 include/dt-bindings/clock/microchip,lan966x.h |  28 +++
 5 files changed, 329 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/microchip,lan966x-gck.yaml
 create mode 100644 drivers/clk/clk-lan966x.c
 create mode 100644 include/dt-bindings/clock/microchip,lan966x.h

-- 
2.17.1

