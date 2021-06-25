Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABD163B4A4F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 23:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFYV5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 17:57:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:39656 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229531AbhFYV5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 17:57:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DEEA161946;
        Fri, 25 Jun 2021 21:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1624658102;
        bh=GSOsH6IpZZHhvWBQhMeEjpX7aKWrlZrJfSzabd36Wqk=;
        h=From:To:Cc:Subject:Date:From;
        b=FVU+DIffQzYvXm6boLgv2mZoGFOPXT9sHuInvDecA0aHmd9brzTsBu3g/TwbQLTrx
         5yLQ8SYSGnrccSGN2EFXMfhl5t84Kbf1Q01bpcBwZtjDWnvQ0MCRMEKMKwrZKVobG/
         jHaMOSYPQkTq6hI2StWv2t5E9KzIcmoqg0CVC02qSKDyTH5iL2IR8HMwehERnEfn44
         I/6/vz19kURp8CVuWPof6AU3BlsiVF2daDB5ps+/kI+y/ZKvmyRgV7TddacGNCN7Lz
         t1Yp6piogCFZkfOvOPGdhzLRyVsWfovEFntAVB3dryiDVnFNvmCCGeUcQ8TNUsfvY0
         wmZcySNm0b5OA==
Received: by pali.im (Postfix)
        id 9F804A7D; Fri, 25 Jun 2021 23:54:59 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Documentation: arm: marvell: Add few missing models and documentation files
Date:   Fri, 25 Jun 2021 23:54:37 +0200
Message-Id: <20210625215437.2156-1-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 Documentation/arm/marvell.rst | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/arm/marvell.rst b/Documentation/arm/marvell.rst
index c50be711ec72..4d75826b4939 100644
--- a/Documentation/arm/marvell.rst
+++ b/Documentation/arm/marvell.rst
@@ -58,11 +58,19 @@ Kirkwood family
                 - Product Brief  : https://web.archive.org/web/20120616201621/http://www.marvell.com/embedded-processors/kirkwood/assets/88F6180-003_ver1.pdf
                 - Hardware Spec  : https://web.archive.org/web/20130730091654/http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6180_OpenSource.pdf
                 - Functional Spec: https://web.archive.org/web/20130730091033/http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+        - 88F6280
+
+                - Product Brief  : https://web.archive.org/web/20130730091058/http://www.marvell.com/embedded-processors/kirkwood/assets/88F6280_SoC_PB-001.pdf
         - 88F6281
 
                 - Product Brief  : https://web.archive.org/web/20120131133709/http://www.marvell.com/embedded-processors/kirkwood/assets/88F6281-004_ver1.pdf
                 - Hardware Spec  : https://web.archive.org/web/20120620073511/http://www.marvell.com/embedded-processors/kirkwood/assets/HW_88F6281_OpenSource.pdf
                 - Functional Spec: https://web.archive.org/web/20130730091033/http://www.marvell.com/embedded-processors/kirkwood/assets/FS_88F6180_9x_6281_OpenSource.pdf
+        - 88F6321
+        - 88F6322
+        - 88F6323
+
+                - Product Brief  : https://web.archive.org/web/20120616201639/http://www.marvell.com/embedded-processors/kirkwood/assets/88f632x_pb.pdf
   Homepage:
 	https://web.archive.org/web/20160513194943/http://www.marvell.com/embedded-processors/kirkwood/
   Core:
@@ -89,6 +97,10 @@ Discovery family
 
         - MV76100
 
+                - Product Brief  : https://web.archive.org/web/20140722064429/http://www.marvell.com/embedded-processors/discovery-innovation/assets/MV76100-002_WEB.pdf
+                - Hardware Spec  : https://web.archive.org/web/20140722064425/http://www.marvell.com/embedded-processors/discovery-innovation/assets/HW_MV76100_OpenSource.pdf
+                - Functional Spec: https://web.archive.org/web/20111110081125/http://www.marvell.com/embedded-processors/discovery-innovation/assets/FS_MV76100_78100_78200_OpenSource.pdf
+
                 Not supported by the Linux kernel.
 
   Core:
@@ -124,17 +136,23 @@ EBU Armada family
 
   Armada 38x Flavors:
 	- 88F6810	Armada 380
+	- 88F6811 Armada 381
+	- 88F6821 Armada 382
+	- 88F6W21 Armada 383
 	- 88F6820 Armada 385
 	- 88F6828 Armada 388
 
     - Product infos:   https://web.archive.org/web/20181006144616/http://www.marvell.com/embedded-processors/armada-38x/
     - Functional Spec: https://web.archive.org/web/20200420191927/https://www.marvell.com/content/dam/marvell/en/public-collateral/embedded-processors/marvell-embedded-processors-armada-38x-functional-specifications-2015-11.pdf
+    - Hardware Spec:   https://web.archive.org/web/20180713105318/https://www.marvell.com/docs/embedded-processors/assets/marvell-embedded-processors-armada-38x-hardware-specifications-2017-03.pdf
+    - Design guide:    https://web.archive.org/web/20180712231737/https://www.marvell.com/docs/embedded-processors/assets/marvell-embedded-processors-armada-38x-hardware-design-guide-2017-08.pdf
 
   Core:
 	ARM Cortex-A9
 
   Armada 39x Flavors:
 	- 88F6920 Armada 390
+	- 88F6925 Armada 395
 	- 88F6928 Armada 398
 
     - Product infos: https://web.archive.org/web/20181020222559/http://www.marvell.com/embedded-processors/armada-39x/
-- 
2.20.1

