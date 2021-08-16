Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21D7F3ECEC2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbhHPGrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 02:47:23 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:35805 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbhHPGrQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:47:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629096405; x=1660632405;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6Z3xraYJn7692GEB/jLqBPc8LmMxKZXlwCBT3w0+7ps=;
  b=2Ct7RYUiBCYZcRLaPPQqxh99Yr5sBZRHCZufC3aZ6BWgm2DjmnlEMM80
   E+UNZg6DuxXqTbsb9UtF4zziWcMW6GxjxtZEqG7DGorrpocQCL3Yr9caB
   J5XpGH+7hSdYdAfE0++7ADBdAdSXggks0eB70pqVIPhx0tN4Vx6BLem1i
   oEmos+6ryOjT343ESS3DC9ThFNzOnTsdpiAaHJmYuDN5tPZHPwm20tuAR
   uq1wYL5MsPoa7+tk3BOVlTSzZQouesRrnZSEe4At/4CsC08Ld7w4E/nAf
   xJTtutvWnHf2nxCC1hZGK7s6o7sSYUoRnothSYkedbZ6ppkVbms+8dZUZ
   A==;
IronPort-SDR: zf9DVFLod6Y7SAxc450FpmHIpB25uulwjCARvsisoyxU1x0yJRqdW1pgSSTdFmXYF5NwiMzqx7
 77gjFjqn3WhOg7CwdRjFUY/qCW9C/iXv9xq7pVBXSPYvTIouOTgktonCt0Yne5y4YtoFNwENMB
 fEn4QKhxXBEszjKae0EdA0t00EuCjPG9qdO+LMgF9z7KKdzEK/PktDLi25HFQTdnQw3s5EOwK6
 YF7SVCwpRXRnc36GL6xlXo6abnoCsfsUIFiMk+hW2MM+o+0nVBN6SuMAjbKYU+qu4vE6wmH+2r
 lrKetvvnNGqjXJdTnY+dtQQs
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="125900538"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2021 23:46:44 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 15 Aug 2021 23:46:42 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 15 Aug 2021 23:46:38 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 5/7] dt-bindings: add vendor prefix for exegin
Date:   Mon, 16 Aug 2021 09:44:14 +0300
Message-ID: <20210816064416.1630674-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
References: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Exegin Technologies Limited.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 8cf2ed41537a..61fe4778498d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -393,6 +393,8 @@ patternProperties:
     description: Exar Corporation
   "^excito,.*":
     description: Excito
+  "^exegin,.*":
+    description: Exegin Technologies Limited
   "^ezchip,.*":
     description: EZchip Semiconductor
   "^facebook,.*":
-- 
2.25.1

