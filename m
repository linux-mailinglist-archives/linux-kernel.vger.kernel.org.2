Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22178426E52
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:01:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243063AbhJHQDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:03:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:55326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243225AbhJHQDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:03:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DE67C60FE8;
        Fri,  8 Oct 2021 16:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633708880;
        bh=XP28/+pFwjXafyYFOv7PyNtjlSJXuYe6i82N1G2BQMA=;
        h=From:To:Cc:Subject:Date:From;
        b=pK7V4zDzhvBeR0uE9IA+bGE8PI7R+YzcrtSOnoG/MLQ4y+Oqh+4Ts/fBRwHPN7EaI
         HwUIKcA5tFnCJ0Z529GHsPuTauNH2Mt8nZPnuygWyrc1U5yJsamv395NOn6IPR2dLP
         7InZyWhGKDsD1HTBLA4onn2yd+MktW8TNR3+EWIIc9AeW7bYhkuIdLjFugEGhzDveL
         NhO0RqAd7G8SpUBVRYqW5cnjdxZBwnBCr8F/yjovKt+JFyQJdaC7OeDGdjK1hX8zuP
         9xJewyl3BIzHuUReC09AeVOMB+Ad7RKtnHIqa812iXYF03EmyyJlMFe707q+OBay4y
         2A1blnneDgbTw==
Received: by pali.im (Postfix)
        id B0C9D760; Fri,  8 Oct 2021 18:01:17 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Lunn <andrew@lunn.ch>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Documentation: arm: marvell: Add some links to homepage / product infos
Date:   Fri,  8 Oct 2021 18:01:03 +0200
Message-Id: <20211008160105.24225-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Webarchive contains some useful resources like product info or links to
other documents.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/arm/marvell.rst | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
index c3d3f27edfbb..d4fe191bb88c 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -103,6 +103,8 @@ Discovery family
 
                 Not supported by the Linux kernel.
 
+  Homepage:
+        https://web.archive.org/web/20110924171043/http://www.marvell.com/embedded-processors/discovery-innovation/
   Core:
 	Feroceon 88fr571-vd ARMv5 compatible
 
@@ -119,6 +121,7 @@ EBU Armada family
         - 88F6707
         - 88F6W11
 
+    - Product infos:   https://web.archive.org/web/20141002083258/http://www.marvell.com/embedded-processors/armada-370/
     - Product Brief:   https://web.archive.org/web/20121115063038/http://www.marvell.com/embedded-processors/armada-300/assets/Marvell_ARMADA_370_SoC.pdf
     - Hardware Spec:   https://web.archive.org/web/20140617183747/http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-datasheet.pdf
     - Functional Spec: https://web.archive.org/web/20140617183701/http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA370-FunctionalSpec-datasheet.pdf
@@ -129,6 +132,7 @@ EBU Armada family
   Armada 375 Flavors:
 	- 88F6720
 
+    - Product infos: https://web.archive.org/web/20140108032402/http://www.marvell.com/embedded-processors/armada-375/
     - Product Brief: https://web.archive.org/web/20131216023516/http://www.marvell.com/embedded-processors/armada-300/assets/ARMADA_375_SoC-01_product_brief.pdf
 
   Core:
@@ -169,6 +173,9 @@ EBU Armada family
     NOTE:
 	not to be confused with the non-SMP 78xx0 SoCs
 
+    Product infos:
+        https://web.archive.org/web/20150101215721/http://www.marvell.com/embedded-processors/armada-xp/
+
     Product Brief:
 	https://web.archive.org/web/20121021173528/http://www.marvell.com/embedded-processors/armada-xp/assets/Marvell-ArmadaXP-SoC-product%20brief.pdf
 
-- 
2.20.1

