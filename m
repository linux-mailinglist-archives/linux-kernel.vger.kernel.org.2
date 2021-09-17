Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E18B040F98A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 15:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbhIQNxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 09:53:13 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:12065 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235351AbhIQNxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 09:53:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631886709; x=1663422709;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=BaKR0GXJ7avCWzr+NGsVFd6GROFyzc6wFVyGk4om47Y=;
  b=q+aLJTKhrCWv+fv1TrJsickP77LvIV+NkhE0nRjzoLe0mp/ykubSUsjr
   FPpNFwuo8x7um43G06C5YGjtAHBQD3a0ANAGgVCsA63GzZyN9IyeGpA+u
   +O3KAiss2ZTWPqSUe7lZBHMno8JzwENWfYiyaLjNpyhULmEJAarkBr9Ct
   5XPLkUpckbIZZfHdoOMPtr0eMNMiE3Gwb8/lS2mXaW1rui3GdWQAFSVfh
   9aZmAiRzl5oeTmiTSsmXpc9D7R4BiadgF6BB+ysQH8zrAh0+x3VsCYtsX
   3hDoJKqBqFSaXQsW8kFOAAVfdj5p3HIcES4iqzd8KWTaISon/jP/6gygT
   w==;
IronPort-SDR: lXznJIalnbo3zY6JUz7II6EWu5d1JoYIwWwrSmSzjMD7WVJRP7090GHnf9qcRd8+U/9RBNgWme
 adLARUJgTmKyKu7PqGZhNjA+PhnRyIVSs6D0aOQ/6cIESFDOWpZkIQ/I9AxuFlOSUID0EU4TzB
 NEF1S8cKBdPRP8aY648HuXjC9o+1aEW0HnMJ/+yygdkMKipvjzb+7ws7SjirEn8VflLIBULn8X
 yAtkJfRa+YCzGfDBnbIBCXhnB/7n4JhVgk+W2K6nYBP3So6/On8WnP6F8yjXEqmcyQW2p6ahCT
 2wypRFehQvZ6a+is5OZ8fxNy
X-IronPort-AV: E=Sophos;i="5.85,301,1624345200"; 
   d="scan'208";a="132212843"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Sep 2021 06:51:49 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 17 Sep 2021 06:51:48 -0700
Received: from kavya-HP-Compaq-6000-Pro-SFF-PC.microchip.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 17 Sep 2021 06:51:45 -0700
From:   Kavyasree Kotagiri <kavyasree.kotagiri@microchip.com>
To:     <robh+dt@kernel.org>, <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-clk@vger.kernel.org>, <UNGLinuxDriver@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Kavyasree.Kotagiri@microchip.com>,
        <Manohar.Puri@microchip.com>
Subject: [PATCH v5 0/3] Add driver for lan966x Generic Clock Controller
Date:   Fri, 17 Sep 2021 19:21:39 +0530
Message-ID: <20210917135142.9689-1-kavyasree.kotagiri@microchip.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series adds a device driver for Generic Clock Controller
of lan966x SoC.

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

