Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B76842CD4D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbhJMWHr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:07:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbhJMWHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:07:41 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DDA8C061749;
        Wed, 13 Oct 2021 15:05:37 -0700 (PDT)
Received: from crub.agik.hopto.org (pd95f1d7c.dip0.t-ipconnect.de [217.95.29.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: agust@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 9DDC983615;
        Thu, 14 Oct 2021 00:05:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1634162734;
        bh=uZm5D2+CRm7bH5HFGW3gUhOTGOqsiOrv5b4dSLnjlUQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iY+rL/fPzv9+GTvNOazn778jJn80o/iahhzIwkZEDscxCQlerLX/6SQPFTx9zoLwW
         w6WefyhXzCcheTXW056K1nCiriaH2/o6dYBoiM67toTcFmX9MICj1unhT1km0w09OO
         +uFH0ETkAvnEIdZjq+Iih7KP1Z8KzqThb4c5sFI7cVSt7W8DpQuPLe+Gh+ZQAlQbdz
         eI3myiBXFtNN7P8y05EHTBCmkOiVe40/AmuQk+2/QrmCbDim1U/jPCdIsnTPluKyaI
         t03oMiY/O0evABmIm0A9GvYadHxwHuR+qWjIaXSp1TA68lPPiZW2ZjgFbWIPy9YGw+
         OjkcyX+jdMdKQ==
From:   Anatolij Gustschin <agust@denx.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 3/4] powerpc/5200: dts: fix memory node unit name
Date:   Thu, 14 Oct 2021 00:05:31 +0200
Message-Id: <20211013220532.24759-4-agust@denx.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211013220532.24759-1-agust@denx.de>
References: <20211013220532.24759-1-agust@denx.de>
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes build warnings:
Warning (unit_address_vs_reg): /memory: node has a reg or ranges property, but no unit name

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/charon.dts    | 2 +-
 arch/powerpc/boot/dts/digsy_mtc.dts | 2 +-
 arch/powerpc/boot/dts/lite5200.dts  | 2 +-
 arch/powerpc/boot/dts/lite5200b.dts | 2 +-
 arch/powerpc/boot/dts/media5200.dts | 2 +-
 arch/powerpc/boot/dts/mpc5200b.dtsi | 2 +-
 arch/powerpc/boot/dts/o2d.dts       | 2 +-
 arch/powerpc/boot/dts/o2d.dtsi      | 2 +-
 arch/powerpc/boot/dts/o2dnt2.dts    | 2 +-
 arch/powerpc/boot/dts/o3dnt.dts     | 2 +-
 arch/powerpc/boot/dts/pcm032.dts    | 2 +-
 arch/powerpc/boot/dts/tqm5200.dts   | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/boot/dts/charon.dts b/arch/powerpc/boot/dts/charon.dts
index 6f9fe88a5f36..ea6e76ae2545 100644
--- a/arch/powerpc/boot/dts/charon.dts
+++ b/arch/powerpc/boot/dts/charon.dts
@@ -35,7 +35,7 @@
 		};
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x08000000>;	// 128MB
 	};
diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index 010156649bfe..57024a4c1e7d 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -16,7 +16,7 @@
 	model = "intercontrol,digsy-mtc";
 	compatible = "intercontrol,digsy-mtc";
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x02000000>;	// 32MB
 	};
 
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index 84a12e7915e9..b9d8487813b4 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -32,7 +32,7 @@
 		};
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x04000000>;	// 64MB
 	};
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index c361c59a9681..7e2d91c7cb66 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -31,7 +31,7 @@
 		led4 { gpios = <&gpio_simple 2 1>; };
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x10000000>;	// 256MB
 	};
 
diff --git a/arch/powerpc/boot/dts/media5200.dts b/arch/powerpc/boot/dts/media5200.dts
index f7d7538eb69d..96524ede16cd 100644
--- a/arch/powerpc/boot/dts/media5200.dts
+++ b/arch/powerpc/boot/dts/media5200.dts
@@ -32,7 +32,7 @@
 		};
 	};
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x08000000>;	// 128MB RAM
 	};
 
diff --git a/arch/powerpc/boot/dts/mpc5200b.dtsi b/arch/powerpc/boot/dts/mpc5200b.dtsi
index 8c645d2bc455..ffa82c7e1055 100644
--- a/arch/powerpc/boot/dts/mpc5200b.dtsi
+++ b/arch/powerpc/boot/dts/mpc5200b.dtsi
@@ -33,7 +33,7 @@
 		};
 	};
 
-	memory: memory {
+	memory: memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x04000000>;	// 64MB
 	};
diff --git a/arch/powerpc/boot/dts/o2d.dts b/arch/powerpc/boot/dts/o2d.dts
index 24a46f65e529..e0a8d3034417 100644
--- a/arch/powerpc/boot/dts/o2d.dts
+++ b/arch/powerpc/boot/dts/o2d.dts
@@ -12,7 +12,7 @@
 	model = "ifm,o2d";
 	compatible = "ifm,o2d";
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x08000000>;  // 128MB
 	};
 
diff --git a/arch/powerpc/boot/dts/o2d.dtsi b/arch/powerpc/boot/dts/o2d.dtsi
index 6661955a2be4..b55a9e5bd828 100644
--- a/arch/powerpc/boot/dts/o2d.dtsi
+++ b/arch/powerpc/boot/dts/o2d.dtsi
@@ -19,7 +19,7 @@
 	model = "ifm,o2d";
 	compatible = "ifm,o2d";
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x04000000>;	// 64MB
 	};
 
diff --git a/arch/powerpc/boot/dts/o2dnt2.dts b/arch/powerpc/boot/dts/o2dnt2.dts
index eeba7f5507d5..c2eedbd1f5fc 100644
--- a/arch/powerpc/boot/dts/o2dnt2.dts
+++ b/arch/powerpc/boot/dts/o2dnt2.dts
@@ -12,7 +12,7 @@
 	model = "ifm,o2dnt2";
 	compatible = "ifm,o2d";
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x08000000>;  // 128MB
 	};
 
diff --git a/arch/powerpc/boot/dts/o3dnt.dts b/arch/powerpc/boot/dts/o3dnt.dts
index fd00396b0593..e4c1bdd41271 100644
--- a/arch/powerpc/boot/dts/o3dnt.dts
+++ b/arch/powerpc/boot/dts/o3dnt.dts
@@ -12,7 +12,7 @@
 	model = "ifm,o3dnt";
 	compatible = "ifm,o2d";
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x04000000>;  // 64MB
 	};
 
diff --git a/arch/powerpc/boot/dts/pcm032.dts b/arch/powerpc/boot/dts/pcm032.dts
index b6fdf861c7d6..d00f13b62510 100644
--- a/arch/powerpc/boot/dts/pcm032.dts
+++ b/arch/powerpc/boot/dts/pcm032.dts
@@ -20,7 +20,7 @@
 	model = "phytec,pcm032";
 	compatible = "phytec,pcm032";
 
-	memory {
+	memory@0 {
 		reg = <0x00000000 0x08000000>;	// 128MB
 	};
 
diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
index 40b139d92a19..372177b19e60 100644
--- a/arch/powerpc/boot/dts/tqm5200.dts
+++ b/arch/powerpc/boot/dts/tqm5200.dts
@@ -32,7 +32,7 @@
 		};
 	};
 
-	memory {
+	memory@0 {
 		device_type = "memory";
 		reg = <0x00000000 0x04000000>;	// 64MB
 	};
-- 
2.17.1

