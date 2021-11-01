Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31909441503
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 09:08:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhKAIKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 04:10:06 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:62892 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbhKAIKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 04:10:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635754052; x=1667290052;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GiZSP2N7eXt6hJAdSEsqoCePxdQqvxfYMrEZp11WUS8=;
  b=btUoBPUemhQzGKzHBKNNqad3bW+w9eS6nGOTGFqM9vyBh+H+dIebIS10
   6XJUNHhJ3kd9yqw7NWIvwb+7WgJp2GE3IhPJKUJF7765oGYW7ddlPiWQG
   2aBEKxmvRl1GAON6Se2HKQt42HPSEBQzQWznMfBgz1TfJWuku9SisjeP2
   LltdH4w7ZXw2qnVUjquYhr7qlx75UNX2ZAxX7w/cTCz9+ohbP+7RIzbcg
   ZnMrlOntoAgR+T2QEZTPdY4qtcVVQtJWNKF01MIqcNW32zT0MXeI1SDtS
   Opb640zUM1zHXySaMycB0QZ3Gg8gKIhLRrd+gfEpaXpIVojEVILnhcCDp
   g==;
IronPort-SDR: ZybH/CG+CTCwImvPF6ws7pxj6QcYtMfxmP1jUpsTPGjKR3waPwZBQHngOOj1MbLrC9hZlmNazn
 15tK87m74ihysxarg2MXKCVNveGohntGjpIWCXqgeBafVo5FazBw8MhOqhVhSGU6OvLReznZYU
 3Dw5zlLkG86NQW0+00WvTUd+yOXRzw6ZYhg3HdqkC20t559KfvoibhRf+0mvOBgvCzEmT+Aq2W
 k3hYcHqtff6bBszU5LTgK5iTwIXCYlegIllYrun6lOzDE6NY1PSxp6U1JYm+tABnyqOw8f4G2h
 7WT3MsnVNQSVR4EO9J3AAyoc
X-IronPort-AV: E=Sophos;i="5.87,198,1631602800"; 
   d="scan'208";a="137558403"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 01 Nov 2021 01:07:31 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 1 Nov 2021 01:07:29 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Mon, 1 Nov 2021 01:07:27 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <kavyasree.kotagiri@microchip.com>, <eugen.hristev@microchip.com>,
        <linux-clk@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [RFC PATCH v3 3/4] dt-bindings: clock: lan966x: Extend includes with clock gates
Date:   Mon, 1 Nov 2021 09:08:44 +0100
Message-ID: <20211101080845.3343836-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211101080845.3343836-1-horatiu.vultur@microchip.com>
References: <20211101080845.3343836-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On lan966x it is allow to control the clock to some peripherals like
USB. So extend the include file with these clocks.

Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 include/dt-bindings/clock/microchip,lan966x.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/dt-bindings/clock/microchip,lan966x.h b/include/dt-bindings/clock/microchip,lan966x.h
index fe36ed6d8b5f..6f9d43d76d5a 100644
--- a/include/dt-bindings/clock/microchip,lan966x.h
+++ b/include/dt-bindings/clock/microchip,lan966x.h
@@ -23,6 +23,12 @@
 #define GCK_ID_TIMER		12
 #define GCK_ID_USB_REFCLK	13
 
-#define N_CLOCKS		14
+/* Gate clocks */
+#define GCK_GATE_UHPHS		14
+#define GCK_GATE_UDPHS		15
+#define GCK_GATE_MCRAMC		16
+#define GCK_GATE_HMATRIX	17
+
+#define N_CLOCKS		18
 
 #endif
-- 
2.33.0

