Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BDFE426E54
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:01:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232320AbhJHQDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:55358 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243248AbhJHQDQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:03:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A41C960F4F;
        Fri,  8 Oct 2021 16:01:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633708880;
        bh=jWi68rEsi9NaQCcaC+9ZLImPkQGr21C405hcox+Pmk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gXnjBc/iyOw+VXavdt8OMqM1TQDiHnHbwx9aMP1olnKCvrBBhK/fHO5z6/ltsIMaM
         8LNSK0gTMsCZ58azzUxH25G2jPpjc+k5TlIKYjiCKB/bhcmTI0dNhIiMRVdTdqVxOh
         P9zHIQbZb9KwyvwDEfD8DZngOv7IcmmAj6AA2hF5byEjGN9+WANWuFrscu6r1QAfo9
         DZj8WF38Q/yxbSjnBOTcLnrDV5lDYOe53ptEnV8MaV1nVepfB9f9iOG9Rh+9oye//v
         L5Ng4EFwOb9K9YDOCJaQX+lby3ifUbfdubjOomtYV2YpPkgRB/WeZZNO7V3Ba8INFE
         e8gBRboZShAeg==
Received: by pali.im (Postfix)
        id D9F6A2AE9; Fri,  8 Oct 2021 18:01:18 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Documentation: arm: marvell: Put Armada XP section between Armada 370 and 375
Date:   Fri,  8 Oct 2021 18:01:04 +0200
Message-Id: <20211008160105.24225-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211008160105.24225-1-pali@kernel.org>
References: <20211008160105.24225-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From evolution and feature point of view Armada XP belongs between Armada
370 and Armada 375 families.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/arm/marvell.rst | 45 +++++++++++++++--------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
index d4fe191bb88c..65d27b7ab110 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -129,6 +129,25 @@ EBU Armada family
   Core:
 	Sheeva ARMv7 compatible PJ4B
 
+  Armada XP Flavors:
+        - MV78230
+        - MV78260
+        - MV78460
+
+    NOTE:
+	not to be confused with the non-SMP 78xx0 SoCs
+
+    - Product infos:   https://web.archive.org/web/20150101215721/http://www.marvell.com/embedded-processors/armada-xp/
+    - Product Brief:   https://web.archive.org/web/20121021173528/http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
+    - Functional Spec: https://web.archive.org/web/20180829171131/http://www.marvell.com/embedded-processors/armada-xp/assets/ARMADA-XP-Functional-SpecDatasheet.pdf
+    - Hardware Specs:
+        - https://web.archive.org/web/20141127013651/http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78230_OS.PDF
+        - https://web.archive.org/web/20141222000224/http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78260_OS.PDF
+        - https://web.archive.org/web/20141222000230/http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78460_OS.PDF
+
+  Core:
+	Sheeva ARMv7 compatible Dual-core or Quad-core PJ4B-MP
+
   Armada 375 Flavors:
 	- 88F6720
 
@@ -165,32 +184,6 @@ EBU Armada family
   Core:
 	ARM Cortex-A9
 
-  Armada XP Flavors:
-        - MV78230
-        - MV78260
-        - MV78460
-
-    NOTE:
-	not to be confused with the non-SMP 78xx0 SoCs
-
-    Product infos:
-        https://web.archive.org/web/20150101215721/http://www.marvell.com/embedded-processors/armada-xp/
-
-    Product Brief:
-	https://web.archive.org/web/20121021173528/http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
-
-    Functional Spec:
-	https://web.archive.org/web/20180829171131/http://www.marvell.com/embedded-processors/armada-xp/assets/ARMADA-XP-Functional-SpecDatasheet.pdf
-
-    - Hardware Specs:
-
-        - https://web.archive.org/web/20141127013651/http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78230_OS.PDF
-        - https://web.archive.org/web/20141222000224/http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78260_OS.PDF
-        - https://web.archive.org/web/20141222000230/http://www.marvell.com/embedded-processors/armada-xp/assets/HW_MV78460_OS.PDF
-
-  Core:
-	Sheeva ARMv7 compatible Dual-core or Quad-core PJ4B-MP
-
   Linux kernel mach directory:
 	arch/arm/mach-mvebu
   Linux kernel plat directory:
-- 
2.20.1

