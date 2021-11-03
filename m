Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05292443EA0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 09:50:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhKCIxT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 04:53:19 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:60652 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231903AbhKCIxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 04:53:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1635929436; x=1667465436;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GiZSP2N7eXt6hJAdSEsqoCePxdQqvxfYMrEZp11WUS8=;
  b=n7Xsg7B6FtxojqSJ63eelzaPW1LvM6q/rSfmwPZEDTBpMHfugczNWSGS
   7Lx3cyMLat14KgSGyrROFdWZzj93g55XOWAX1H6p6N8Aqx9PfH/DAqR5T
   UocscDpxraCPgs4OjAAKNtr+vC/1Lkiwg09sAWDueY+LesMmuzh2POHaJ
   ah8NVuP5yFglPSUpX2igp2n5NG1bCzACpQ6SMoKVxHHsmGlZvOwXZNgeg
   vlVQh5GJA8D8lEy1RAjsNwg7xg8fybF/7O4NgX5u4dnfPqNoRXT1AHROc
   CoN62vooE3MMp58kQC76L4ySkOykqIUgTe9RzL05q3zUnXI097btHoi+K
   A==;
IronPort-SDR: h1k77vZFo63YpTQmI3Ydzv5x6QgG9vl9N1oKtm0+OiZrDbesSbviBYvQk6OnhT0H5XyLVSDsiH
 dIWZCRIF3vce3dOVztq7wmVjENvcejGVBzVUTnNcWOJb5kxuwvWvnpsMO3a4STCLT7fIkxMAs4
 S32PVRuX8RfD7Hu5OGdWr0o6BR7AVttPXaEcwqPm+cszf1PspPuavu4fktguIBqwJu4LEQCoO0
 ufJ+Vl8uqm1M3wreK01RX6DtJCPJ0u6mYHSwikVjDkqcIbZ0UdQhldG4E0hSUKtngK/7joN2B+
 bQSkySOu5jTepkZlHW+Cg9hz
X-IronPort-AV: E=Sophos;i="5.87,205,1631602800"; 
   d="scan'208";a="142628717"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 03 Nov 2021 01:50:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Wed, 3 Nov 2021 01:50:33 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Wed, 3 Nov 2021 01:50:30 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <robh+dt@kernel.org>, <kavyasree.kotagiri@microchip.com>,
        <nicolas.ferre@microchip.com>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [RFC PATCH v4 3/4] dt-bindings: clock: lan966x: Extend includes with clock gates
Date:   Wed, 3 Nov 2021 09:51:01 +0100
Message-ID: <20211103085102.1656081-4-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211103085102.1656081-1-horatiu.vultur@microchip.com>
References: <20211103085102.1656081-1-horatiu.vultur@microchip.com>
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

