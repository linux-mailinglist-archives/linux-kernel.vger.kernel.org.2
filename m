Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FABB3ECEBA
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 08:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233562AbhHPGrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 02:47:09 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:43264 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbhHPGrE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 02:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1629096393; x=1660632393;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QOlG895YLHjDjZlX0+oU0a41P3tagn5ancDt1lnfWhE=;
  b=tyhypsGr1ssdZDXE7tVL+mXGTXxFDbDzvdIjaOn7SxF288n8NbZw8c1K
   vgA8xluS8a9l6d5nDB1sCoxmCjUTm7K3pC8J9MmIPCYUgDrvYV1lFF/Xp
   Tv95RRit/b55vb7GqmwOwBEyEf/mzjDoce3e6cmCDpzzaFgR2VMcIn7v6
   aZ2DWq3JZDOGdkIPaVvDX7FKBz47OvDa4h1SjbBjoSfplNAm308dqUI0u
   CiNPzmGxVuZDadX9EvpkSsPiPClvXsBgX2AJy6SoV/EAQno0L5k0sDodJ
   ddcbQHVujgRJL8CjZ4Wf+Uj6bFSsWaSFc+6Nffz5Ua3Nv05iLOmjNGZb1
   w==;
IronPort-SDR: BrheuwS149YsFwi3XG2K3Wr46ZPaN2CbmcFrIHSnFq4Cg5ZZt6l7M1HFzg0H/PmnTMvyoiSZGA
 OPrPwrbms5gf6EuYUc9GoN5wleO4tOakYz7cujvVW5f+Yah+gfTxdEk14/gdGKybdmgQPXaDSg
 /IogmZtWJleaOuP2XNw7CKXgeLugjvmKoLMtl3O8weON9RgpJ0JqCOSfdEBIxav0FDQOELvSVM
 7Z8lEgBVyi1yDPG2Q3IuYfbjz2ExZPwMbKoDV7nE8mj03FxGnGEysTaOOu4bku4q+heCavOiZu
 SCCRT7fsB0SXOmDFM8Q92Zkf
X-IronPort-AV: E=Sophos;i="5.84,324,1620716400"; 
   d="scan'208";a="132362618"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 15 Aug 2021 23:46:31 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Sun, 15 Aug 2021 23:46:31 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Sun, 15 Aug 2021 23:46:27 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 2/7] dt-bindings: add vendor prefix for calamp
Date:   Mon, 16 Aug 2021 09:44:11 +0300
Message-ID: <20210816064416.1630674-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
References: <20210816064416.1630674-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for CalAmp Corp.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 07fb0d25fc15..8cf2ed41537a 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -191,6 +191,8 @@ patternProperties:
     description: B&R Industrial Automation GmbH
   "^bticino,.*":
     description: Bticino International
+  "^calamp,.*":
+    description: CalAmp Corp.
   "^calaosystems,.*":
     description: CALAO Systems SAS
   "^calxeda,.*":
-- 
2.25.1

