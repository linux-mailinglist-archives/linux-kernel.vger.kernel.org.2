Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E83573E18E6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 17:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242787AbhHEP5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 11:57:15 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:20424 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242756AbhHEP4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 11:56:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1628178999; x=1659714999;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0QVxHcmZ9L6f6OEKoKgRnF1g91VpcBy5zpzMgpahQWE=;
  b=aOPzmsqO2T3V6i/obe130FwvbuadBJ6b2iUl4bHE2rkZdWkqnkpu/WQU
   ScDYZuY8MnXWuo+rDDTtyL89JR7cUFipJMMAtwd3NOAxpLcJzAsuW7qsj
   UdxejzcOtzYV+twm7DhzbtjS+8hjiwvvLxlyNh4IhgcKUyvpLmTw2XcsM
   HY12/sX5Bk+0FvQRlQh30+F3D33rreNawIC+pvfmymKfps067GD4ljRym
   xNpbvRyAPZH3uDWLJobInkHGc4K2VeC9i1e7qIIpWDcMcbWWuwOMtirYc
   IMDJHtn9Qfghk4cLWbqxTTlwwTv9en6vesQghRsIYB1POj+nD/RkRkqYx
   w==;
IronPort-SDR: Aot8wCgC0XDJxvzxn7KL/e6cAU4FgIY7HrtMZTwpze2SkxzbJorMvg1RpuKmYE/ksgbbOThbbA
 aWLHNxgZtj03HLb/dkkxqFe5/XrwZLvzerPFd74ld8oiAtCd1uH9dH7GutJN4sSgUIVH5nL6BU
 iei0YtV7GymumNfmXIvZQLnbvI+e/g+BphhIurXi2F7tXo/TicbU16TGJTdkW2i1zZMKTCiDS/
 idEqGz3/hV9R5qUprjrBG/8+HNpefMJeIcCwodqdGqfpIl8M0vxu71yIBZbK3e3JLdzkLIDYUG
 78m2f+hnTq1ZtQdmKqQri/V4
X-IronPort-AV: E=Sophos;i="5.84,296,1620716400"; 
   d="scan'208";a="127242289"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2021 08:56:32 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 5 Aug 2021 08:56:32 -0700
Received: from m18063-ThinkPad-T460p.mchp-main.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.2 via Frontend Transport; Thu, 5 Aug 2021 08:56:25 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>,
        <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 2/7] dt-bindings: add vendor prefix for exegin
Date:   Thu, 5 Aug 2021 18:53:52 +0300
Message-ID: <20210805155357.594414-3-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210805155357.594414-1-claudiu.beznea@microchip.com>
References: <20210805155357.594414-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add vendor prefix for Exegin Technologies Limited.

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 07fb0d25fc15..2fa00c7b7ee2 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -391,6 +391,8 @@ patternProperties:
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

