Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDB43E18EF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242694AbhHEP5o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:57:44 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:35531 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242805AbhHEP5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:57:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628179048; x=1659715048;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=F3gj+l86LGzCXpPdm2bvQS8DTJlfMc1PnzmCTCU9NWo=;
  b=PSpnn/1q6NC49YTSRzJ7gP2br4uK3x39oIl1L0xqW7kDT3Y6gINm2YUm
   zWzn10RhOLkycRa7T+VpNgS/3y97jccUE6keRS7dVTbNRQVbb1dGA/r1z
   2vy6iAO+k0QKK2WnEv/qQSlsBwrmvLx6LnWnPOF1+SMXmbTeanWQ/JooJ
   fuygXgJlLyIK9UyEflknaPTVBHTAGC4YHFj1wk8G8BUMfi8LENNhZgrrl
   gCp1cCJM8VonYhJft2SrHoKVl5D60Mna/7D+zmF2MDkpoAb7y70lz7PEw
   qXyxNKo73PUoqfPolH7JshS5nb1k0X38BjeU6Y63UTV3Rct3qWCORjKz+
   g==;
IronPort-SDR: n9rnYFlLL/iZ26UuOJnityprQY8Q3eO5jiRPszsRFXa8rF8xdOo4VYceE1Kr3wMyiGyUFgcMT2
 LusXKlf12QL9bacp7DRyGa4OfvKcTsjrvaI7QTMX6u0QWgJn9FeP4iIDvV41bYF6SE1H0bj927
 3DVeMtDX3rgIEMZKhVtWXeB2GmfhZ8bBBI3iE9FFy/Jg8G0779oTSh2MNut0WZXaxx15h8lian
 CAjPHUEGErGzfcD5E0qhGrm9GzGB6X1QLabMtrtIgsvuoOzrScxdiH376G1/M+eLYcH77PJP/p
 LcCKemC0ptp/Z3vspL1QkTK5
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="131188582"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2021 08:57:27 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 08:57:26 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 5 Aug 2021 08:57:04 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 5/7] dt-bindings: add vendor prefix for calamp
Date:   Thu, 5 Aug 2021 18:53:55 +0300
Message-ID: <20210805155357.594414-6-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805155357.594414-1-claudiu.beznea@microchip.com>
References: <20210805155357.594414-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for CalAmp Corp.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 2fa00c7b7ee2..61fe4778498d 100644
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

