Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37FA932F04B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Mar 2021 17:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231293AbhCEQqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Mar 2021 11:46:14 -0500
Received: from smtpweb146.aruba.it ([62.149.158.146]:53052 "EHLO
        smtpweb146.aruba.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhCEQpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Mar 2021 11:45:46 -0500
X-Greylist: delayed 420 seconds by postgrey-1.27 at vger.kernel.org; Fri, 05 Mar 2021 11:45:46 EST
Received: from ubuntu.localdomain ([146.241.168.111])
        by Aruba Outgoing Smtp  with ESMTPSA
        id IDTPlgHCw1jmzIDTQlCrA6; Fri, 05 Mar 2021 17:38:44 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
        t=1614962324; bh=Hz6URvn9uT/AAP9n5uDOBQH/4ROFVPnPAWploexpxk4=;
        h=From:To:Subject:Date:MIME-Version;
        b=cC7juDXqzv7NDDD4TA2OpjM9n8nULqhWv0KIbFaG0gLMljIhBiX0FidGh8dczKwXR
         ZbQin06IhRahFRjRB0uO/ux7yr/mZarKa1DnGFMjHzWTmbRH4x+WtHR6bCzV0TNKtp
         tzO09vLDEP4rL0goJreBQNzunv0E/ky2WNE+OeeI9plXyvfSeD3BtqT7WFId+67YeO
         a8ZGjKrB0Lr+NWsacLQ9UV7BhvWmH/UE50kaBPgvB1fhthjZmRt34i7ttmz4p7d8Ne
         5ck+ovNdzuSmRgUBBXfu7/ee1HeJguXPvLRMhU0tffE6X3+bm3fjhaNMv4B0WDAoD1
         QYJ4QYV6fJP3Q==
From:   Giulio Benetti <giulio.benetti@benettiengineering.com>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Giulio Benetti <giulio.benetti@micronovasrl.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: Add Hycon Technology vendor prefix
Date:   Fri,  5 Mar 2021 17:38:32 +0100
Message-Id: <20210305163834.70924-2-giulio.benetti@benettiengineering.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210305163834.70924-1-giulio.benetti@benettiengineering.com>
References: <20210305163834.70924-1-giulio.benetti@benettiengineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfMvPfMKV7LIyVpOZptBjgPGK0m1MMa2RYvm8SlWF41K9nvfSofX+Xh47T+5zrFaYSnp5p5YUNJAc5H5FQNDXbcc6uUl3BnXPxzVCUgflIJ/v1V0pc8Ol
 I3L37nFJj0C8qkSjgBow7Ou3fGrHB5/kYHGTS9BccAdrmDS2r9ECcUBL2Kis/XTaU1vp4v9g2msO8tljxpDYy11P/ygeGFNvXlRQCQzebM5BmgsbIoD6vD4D
 lyd01miKaQs5m3rtm6+qILJBevBIYw0Kso0HKcNk0Cbx519mFX7D4/tffynTrSLb2sRx085SCQTl71hnXNJcMDAb2r4zUVjPKtLJlUEj16BCu59NPZgFAURK
 KNpKEHET
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giulio Benetti <giulio.benetti@micronovasrl.com>

Update Documentation/devicetree/bindings/vendor-prefixes.yaml to
include "hycon" as a vendor prefix for "Hycon Technology".
Company website: http://www.hycontek.com/

Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index a1312637d6ff..51b00aa96dff 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -488,6 +488,8 @@ patternProperties:
   "^hugsun,.*":
     description: Shenzhen Hugsun Technology Co. Ltd.
   "^hwacom,.*":
+    description: Hycon Technology Corp.
+  "^hycon,.*":
     description: HwaCom Systems Inc.
   "^hydis,.*":
     description: Hydis Technologies
-- 
2.25.1

