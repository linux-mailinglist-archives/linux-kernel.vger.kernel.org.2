Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 594CA420AB0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 14:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhJDMPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 08:15:44 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:6568 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbhJDMPn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 08:15:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1633349634; x=1664885634;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XzV/xaAshOgxQMr9vTLfv0mRfWvzB1eZ9Rf95BaVOlQ=;
  b=sNNFQN0Hdyt1ZBoZv/0kEKDDwE/5N5NZyy7Q++b7XFKQQwdD9oahgWne
   bOUu70j2ZdRiA1xpromn8/fKuMDBdhydwGd2Sdn47E70jAy9Y0CLQNzng
   y8cQXo25FyeFFv/ALsvqXCmwo42USig1eXwSZ+kABkbgt5P2d+IPDaFd6
   mUJP8pWMfs61Z7LHWd56G00C1XEwZG+EumqMv/85hn1bPCzPMDdcL4BKk
   piidcfzMcxwq2L22W7kVM4NGfA8GB6MFA0YRKLSS/LGGaDE6VZuF2c30q
   4hNM5kIdCYHxq2nwBPRh1dwDzGa9eSrl2UDMrV3TOqRH7OzTeBsef6Utc
   g==;
IronPort-SDR: TT6vvSjQfqJOd3f553TLFNlxsnQs27D8nUmPQo+pAJhjCY0qE+yLlEDJZxI/iq2QR7mE70V8aM
 4lwrgJyRLyk5S3M/Mx7lgYvFk0z1Kdlu/vLnz9hdoZ7laOLW3lwPP2BZ5h3TIb8k5naVhT0AEt
 ObHIqG1lG3h8/UqcZjk7FEnBvDp2BgSpXhNDqqvxs2SOwV5DXBG5bSWWA9XypTgtILOzhXPHU6
 ODCmyScLeg6D4h6f8/M5TWhAT3jxD577aj8GWcpVu6SJzHTjjRFk46bvFUp/SSoCM0jpwPMsJB
 QnLR+kK4fNfm/O3O8dLl2sOd
X-IronPort-AV: E=Sophos;i="5.85,345,1624345200"; 
   d="scan'208";a="138945570"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Oct 2021 05:13:53 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Mon, 4 Oct 2021 05:13:52 -0700
Received: from ness.home (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2176.14 via Frontend
 Transport; Mon, 4 Oct 2021 05:13:51 -0700
From:   <nicolas.ferre@microchip.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
CC:     Ludovic Desroches <ludovic.desroches@microchip.com>,
        <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Eugen Hristev <eugen.hristev@microchip.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH] ARM: at91: Documentation: add sama7g5 family
Date:   Mon, 4 Oct 2021 14:13:45 +0200
Message-ID: <20211004121345.22761-1-nicolas.ferre@microchip.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Ferre <nicolas.ferre@microchip.com>

Add the new SAMA7G5 ARMv7 based SoC family from Microchip to the AT91
documentation.

Signed-off-by: Nicolas Ferre <nicolas.ferre@microchip.com>
---
 Documentation/arm/microchip.rst | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/arm/microchip.rst b/Documentation/arm/microchip.rst
index 9c013299fd3b..388f69998844 100644
--- a/Documentation/arm/microchip.rst
+++ b/Documentation/arm/microchip.rst
@@ -137,6 +137,18 @@ the Microchip website: http://www.microchip.com.
 
           http://ww1.microchip.com/downloads/en/DeviceDoc/DS60001476B.pdf
 
+    * ARM Cortex-A7 based SoCs
+      - sama7g5 family
+
+        - sama7g51
+        - sama7g52
+        - sama7g53
+        - sama7g54 (device superset)
+
+          * Datasheet
+
+          Coming soon
+
     * ARM Cortex-M7 MCUs
       - sams70 family
 
-- 
2.32.0

