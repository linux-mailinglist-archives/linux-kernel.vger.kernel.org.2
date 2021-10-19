Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDF9433181
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 10:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbhJSItF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 04:49:05 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:29235 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234736AbhJSItC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 04:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1634633209; x=1666169209;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8HzmcFlB9X+AGRuuZC7PDuJl2mB4NxIlDbChXkWBnBQ=;
  b=db3/fjS7Nh6Uz3bypifrMSK1UgYa5eTI5SZkqs6l5QoDc41aRmIoB6oM
   B7xSemzVtZrPFfs6wIxlMKhmvXYSZ6biSOeXEB9z2WXpOpCXcPgnIE6qv
   IJSsAMvolzVENBCiYHErFURx7AdvTC/fsmwvuKpfAbmwF6BE6dH/9aJuM
   QpWIKk+DpSpdmdxMClU43HNYjmSUd7fTGgq+HRIWHHvCxnmTjDXFYtciv
   ZyfM9UJVwUC8HBGUokZp5SFK+Nf78asgSEGTJRKxvjorKLw1Q/f+6c9mA
   xvAkPk2Aur6OPkdY3oE86nzjKPr+A3cHyuhQeaTfvlCtuwv6vfN+F9yTD
   g==;
IronPort-SDR: KNHEGymc4XRxXES49XEt/04Nrt2oS65qsH6DsYU28o4Q3KilkpIen3ZoL+yLDWokrhQabf4S27
 2llzjBQ9AoPIWERyGlGcbCARDQwLINslHvgnZDnnjNpOF425Qi8qClykLdQDybzextZRqK3oen
 nWopmIG7DanOVPOJPUfa3NYUohhrftsURIK0hzeseXwiOztoZUCOWcmb9lyt91gpMQoMq3kpuM
 Zl5XXi9pnJkdmgGETXlHlVvcQ/3WMrJjRUBYxzm+t6idv0CkTB1iYlF40HAmbCu0IVEEZNAycX
 IFy7Erz0OCs0Fz3brUBuYTG4
X-IronPort-AV: E=Sophos;i="5.85,383,1624345200"; 
   d="scan'208";a="148671234"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 19 Oct 2021 01:46:49 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 19 Oct 2021 01:46:49 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 19 Oct 2021 01:46:47 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <robh+dt@kernel.org>
CC:     <nicolas.ferre@microchip.com>, <kavyasree.kotagiri@microchip.com>,
        <eugen.hristev@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [RFC PATCH 2/3] dt-bindings: clock: lan966x: Extend includes with clock gates
Date:   Tue, 19 Oct 2021 10:44:48 +0200
Message-ID: <20211019084449.1411060-3-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211019084449.1411060-1-horatiu.vultur@microchip.com>
References: <20211019084449.1411060-1-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On lan966x it is allow to control the clock to some peripherals like
USB. So extend the include file with these clocks.

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

