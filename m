Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1039C375146
	for <lists+linux-kernel@lfdr.de>; Thu,  6 May 2021 11:09:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234090AbhEFJKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 05:10:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:47122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234014AbhEFJKC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 05:10:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B7A360FEE;
        Thu,  6 May 2021 09:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620292144;
        bh=HaAfWtOAafkNSsvz88e84TAEk52kR7zNGm+Hs1lufVE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Kbz3ZT3czmDTPiEHofA2omrUzRRbVbZvQ9cVWU+5hyYE80BUTfKlHHMNOvyP3clN5
         wD4qvnDOoWcmLh0KNq4IwcLF+u0Z7KOeE24Ah09aOzzOrv6SIx9q4/VzcVZZSLdEtL
         ve60187F0+KLqVy5q61j4peVs0JD4Jz/+GSF+gGLs6ajNcSMxmTE5a6EooyLpaZv9p
         BKoCjDR4KA4dNuCt3YfB15hcTeXTTbVUPf5v4XzylVVDCrAXt7iFQTt0zckNSnaooI
         pG6ov8gbmdsEdt7T06f+Amae9J+ZJRJI+OGJQv2bN9KqDI3PDijh+G1C/1scduatgB
         uPKU8ld7JmWOQ==
Received: by pali.im (Postfix)
        id 5F565732; Thu,  6 May 2021 11:09:02 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 mvebu + mvebu/dt64 6/6] arm64: dts: marvell: armada-37xx: move firmware node to generic dtsi file
Date:   Thu,  6 May 2021 11:08:02 +0200
Message-Id: <20210506090802.14268-6-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210506090802.14268-1-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210506090802.14268-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the turris-mox-rwtm firmware node from Turris MOX' device tree into
the generic armada-37xx.dtsi file and use the generic compatible string
'marvell,armada-3700-rwtm-firmware' instead of the current one.

The Turris MOX rWTM firmware can be used on any Armada 37xx device,
giving them access to the rWTM hardware random number generator, which
is otherwise unavailable.

This change allows Linux to load the turris-mox-rwtm.ko module on these
boards.

Tested on ESPRESSObin v5 with both default Marvell WTMI firmware and
CZ.NIC's firmware. With default WTMI firmware the turris-mox-rwtm fails
to probe, while with CZ.NIC's firmware it registers the HW random number
generator.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Marek Behún <kabel@kernel.org>
Cc: <stable@vger.kernel.org> # 5.4+: 46d2f6d0c99f ("arm64: dts: armada-3720-turris-mox: add firmware node")
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 8 --------
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 8 ++++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 0753cc489638..ebb0ddf8d306 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -107,14 +107,6 @@
 		/* enabled by U-Boot if SFP module is present */
 		status = "disabled";
 	};
-
-	firmware {
-		turris-mox-rwtm {
-			compatible = "cznic,turris-mox-rwtm";
-			mboxes = <&rwtm 0>;
-			status = "okay";
-		};
-	};
 };
 
 &i2c0 {
diff --git a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
index 1b7f43e27589..847a2d12a4be 100644
--- a/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-37xx.dtsi
@@ -505,4 +505,12 @@
 			};
 		};
 	};
+
+	firmware {
+		armada-3700-rwtm {
+			compatible = "marvell,armada-3700-rwtm-firmware";
+			mboxes = <&rwtm 0>;
+			status = "okay";
+		};
+	};
 };
-- 
2.20.1

