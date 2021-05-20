Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4602438ACE6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 13:50:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243852AbhETLvJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 07:51:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:58364 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242607AbhETLkO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 07:40:14 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D73DF61057;
        Thu, 20 May 2021 11:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621510733;
        bh=vlHTNsPasjda2fZpQUYmE5kVMjIxEDkJ+IuDW3NomvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XXSunl/kzCfQEcgu366I8FZ9Hf6mzr94R6r1XFejwIi0A6XRKBxqdDQyLJJ03Zgrf
         iVSG6By3JNbrGnxZaXQbayHXUOGtmL1iiqVkIAgQuJjYh+7PPOte1VXwCRGEzSEZJi
         s4EC9ABNINMLRsNOZsx3aK1JwWMcncCMO3x8+l3gbhYFufwcITYC+fiEGKskSsOpH2
         yZeX4a43dbqZLc0q7uHwtee+phzxCIbpPiqBdLZahC3KHDRSp5TCVLTGem/Jbpe2ts
         OFePPmZ1ViyZW253NeqpBwb0kZ1b1QP6VaQTteLKGxNFRqgJ3GjeE/tex0WyqzERSV
         G7gKBaYmCvhsA==
Received: by pali.im (Postfix)
        id 9879F9D1; Thu, 20 May 2021 13:38:52 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 mvebu + mvebu/dt64 2/2] arm64: dts: marvell: armada-37xx: move firmware node to generic dtsi file
Date:   Thu, 20 May 2021 13:38:44 +0200
Message-Id: <20210520113844.32319-3-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520113844.32319-1-pali@kernel.org>
References: <20210308153703.23097-1-kabel@kernel.org>
 <20210520113844.32319-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the turris-mox-rwtm firmware node from Turris MOX' device tree into
the generic armada-37xx.dtsi file and use the generic compatible string
'marvell,armada-3700-rwtm-firmware' instead of the current one.

Turris MOX DTS file contains also old compatible string for backward
compatibility.

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
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 6 ++----
 arch/arm64/boot/dts/marvell/armada-37xx.dtsi           | 8 ++++++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 0753cc489638..6700f2212b61 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -109,10 +109,8 @@
 	};
 
 	firmware {
-		turris-mox-rwtm {
-			compatible = "cznic,turris-mox-rwtm";
-			mboxes = <&rwtm 0>;
-			status = "okay";
+		armada-3700-rwtm {
+			compatible = "marvell,armada-3700-rwtm-firmware", "cznic,turris-mox-rwtm";
 		};
 	};
 };
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

