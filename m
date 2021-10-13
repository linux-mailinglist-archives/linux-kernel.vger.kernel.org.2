Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4CB42CD4B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 00:07:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhJMWHn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 18:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbhJMWHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 18:07:41 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DBA1C061746;
        Wed, 13 Oct 2021 15:05:37 -0700 (PDT)
Received: from crub.agik.hopto.org (pd95f1d7c.dip0.t-ipconnect.de [217.95.29.124])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: agust@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 43B3283612;
        Thu, 14 Oct 2021 00:05:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1634162734;
        bh=urliHNW43HlnOTWcyGDh78CSVRs4kDbRslzJnUMNtfo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hjLfWaUhvPOdfEymbTsEbKVqyRnWBVMak2dhRLoYKfRcv/uaNnbeODLt9PA6Y6/Ve
         BGpPADoFpY78Nir2OBmFPpnqnOmMYwjsQXiHEZBT/W9fV1D+IbLjnDKB6b+/9EGV8V
         aC23keOnEQmpblR/eSPw+PLXGeFsGUtadakbj73S4Pw6w/oULN53akSFDrS1h9FbkW
         E61xzTTNykq/3kzPKn7EGQLdX7eqbbsb0EERcQiaUoJ0DahytBug+qI0mPGheedTQP
         sX2dRInwBee/hYeZqW0b4afbOhNJ/8t7cu7zCZswUtXuKOIuxx563QU2wZuWTi/tiy
         3k4Cx20k6XFMw==
From:   Anatolij Gustschin <agust@denx.de>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 2/4] powerpc/5200: dts: fix pci ranges warnings
Date:   Thu, 14 Oct 2021 00:05:30 +0200
Message-Id: <20211013220532.24759-3-agust@denx.de>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211013220532.24759-1-agust@denx.de>
References: <20211013220532.24759-1-agust@denx.de>
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix ranges property warnings:
pci@f0000d00:ranges: 'oneOf' conditional failed, one must be fixed:

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 arch/powerpc/boot/dts/a4m072.dts    | 6 +++---
 arch/powerpc/boot/dts/charon.dts    | 6 +++---
 arch/powerpc/boot/dts/digsy_mtc.dts | 6 +++---
 arch/powerpc/boot/dts/lite5200.dts  | 6 +++---
 arch/powerpc/boot/dts/lite5200b.dts | 6 +++---
 arch/powerpc/boot/dts/media5200.dts | 6 +++---
 arch/powerpc/boot/dts/mucmc52.dts   | 6 +++---
 arch/powerpc/boot/dts/pcm030.dts    | 6 +++---
 arch/powerpc/boot/dts/pcm032.dts    | 6 +++---
 arch/powerpc/boot/dts/tqm5200.dts   | 6 +++---
 10 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/boot/dts/a4m072.dts b/arch/powerpc/boot/dts/a4m072.dts
index a9cef5726422..d4270a2ec6c7 100644
--- a/arch/powerpc/boot/dts/a4m072.dts
+++ b/arch/powerpc/boot/dts/a4m072.dts
@@ -140,8 +140,8 @@
 		clock-frequency = <0>; /* From boot loader */
 		interrupts = <2 8 0 2 9 0 2 10 0>;
 		bus-range = <0 0>;
-		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000
-			  0x02000000 0 0x90000000 0x90000000 0 0x10000000
-			  0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000>,
+			 <0x02000000 0 0x90000000 0x90000000 0 0x10000000>,
+			 <0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/charon.dts b/arch/powerpc/boot/dts/charon.dts
index 408b486b13df..6f9fe88a5f36 100644
--- a/arch/powerpc/boot/dts/charon.dts
+++ b/arch/powerpc/boot/dts/charon.dts
@@ -225,8 +225,8 @@
 		clock-frequency = <0>; // From boot loader
 		interrupts = <2 8 0 2 9 0 2 10 0>;
 		bus-range = <0 0>;
-		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000
-			  0x02000000 0 0x90000000 0x90000000 0 0x10000000
-			  0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000>,
+			 <0x02000000 0 0x90000000 0x90000000 0 0x10000000>,
+			 <0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
 	};
 };
diff --git a/arch/powerpc/boot/dts/digsy_mtc.dts b/arch/powerpc/boot/dts/digsy_mtc.dts
index 0e5e9d3acf79..010156649bfe 100644
--- a/arch/powerpc/boot/dts/digsy_mtc.dts
+++ b/arch/powerpc/boot/dts/digsy_mtc.dts
@@ -98,9 +98,9 @@
 		clock-frequency = <0>; // From boot loader
 		interrupts = <2 8 0 2 9 0 2 10 0>;
 		bus-range = <0 0>;
-		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000
-			  0x02000000 0 0x90000000 0x90000000 0 0x10000000
-			  0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000>,
+			 <0x02000000 0 0x90000000 0x90000000 0 0x10000000>,
+			 <0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
 	};
 
 	localbus {
diff --git a/arch/powerpc/boot/dts/lite5200.dts b/arch/powerpc/boot/dts/lite5200.dts
index cb2782dd6132..84a12e7915e9 100644
--- a/arch/powerpc/boot/dts/lite5200.dts
+++ b/arch/powerpc/boot/dts/lite5200.dts
@@ -283,9 +283,9 @@
 		clock-frequency = <0>; // From boot loader
 		interrupts = <2 8 0 2 9 0 2 10 0>;
 		bus-range = <0 0>;
-		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000
-			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
-			  0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000>,
+			 <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000>,
+			 <0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
 	};
 
 	localbus {
diff --git a/arch/powerpc/boot/dts/lite5200b.dts b/arch/powerpc/boot/dts/lite5200b.dts
index 2b86c81f9048..c361c59a9681 100644
--- a/arch/powerpc/boot/dts/lite5200b.dts
+++ b/arch/powerpc/boot/dts/lite5200b.dts
@@ -116,9 +116,9 @@
 		clock-frequency = <0>; // From boot loader
 		interrupts = <2 8 0 2 9 0 2 10 0>;
 		bus-range = <0 0>;
-		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000
-			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
-			  0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000>,
+			 <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000>,
+			 <0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
 	};
 
 	localbus {
diff --git a/arch/powerpc/boot/dts/media5200.dts b/arch/powerpc/boot/dts/media5200.dts
index 61cae9dcddef..f7d7538eb69d 100644
--- a/arch/powerpc/boot/dts/media5200.dts
+++ b/arch/powerpc/boot/dts/media5200.dts
@@ -96,9 +96,9 @@
 
 				 0xe000 0 0 1 &media5200_fpga 0 5 // CoralIP
 				>;
-		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000
-			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
-			  0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000>,
+			 <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000>,
+			 <0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
 		interrupt-parent = <&mpc5200_pic>;
 	};
 
diff --git a/arch/powerpc/boot/dts/mucmc52.dts b/arch/powerpc/boot/dts/mucmc52.dts
index c6c66306308d..e88a7bd4034d 100644
--- a/arch/powerpc/boot/dts/mucmc52.dts
+++ b/arch/powerpc/boot/dts/mucmc52.dts
@@ -106,9 +106,9 @@
 				0x8000 0 0 3 &mpc5200_pic 0 2 3
 				0x8000 0 0 4 &mpc5200_pic 0 1 3
 				>;
-		ranges = <0x42000000 0 0x60000000 0x60000000 0 0x10000000
-			  0x02000000 0 0x90000000 0x90000000 0 0x10000000
-			  0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
+		ranges = <0x42000000 0 0x60000000 0x60000000 0 0x10000000>,
+			 <0x02000000 0 0x90000000 0x90000000 0 0x10000000>,
+			 <0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
 	};
 
 	localbus {
diff --git a/arch/powerpc/boot/dts/pcm030.dts b/arch/powerpc/boot/dts/pcm030.dts
index b1bc731f7afd..5cee474dcc4c 100644
--- a/arch/powerpc/boot/dts/pcm030.dts
+++ b/arch/powerpc/boot/dts/pcm030.dts
@@ -90,9 +90,9 @@
 				 0xc800 0 0 2 &mpc5200_pic 1 2 3
 				 0xc800 0 0 3 &mpc5200_pic 1 3 3
 				 0xc800 0 0 4 &mpc5200_pic 0 0 3>;
-		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000
-			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
-			  0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000>,
+			 <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000>,
+			 <0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
 	};
 
 	localbus {
diff --git a/arch/powerpc/boot/dts/pcm032.dts b/arch/powerpc/boot/dts/pcm032.dts
index 780e13d99e7b..b6fdf861c7d6 100644
--- a/arch/powerpc/boot/dts/pcm032.dts
+++ b/arch/powerpc/boot/dts/pcm032.dts
@@ -87,9 +87,9 @@
 				 0xc800 0 0 2 &mpc5200_pic 1 2 3
 				 0xc800 0 0 3 &mpc5200_pic 1 3 3
 				 0xc800 0 0 4 &mpc5200_pic 0 0 3>;
-		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000
-			  0x02000000 0 0xa0000000 0xa0000000 0 0x10000000
-			  0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x20000000>,
+			 <0x02000000 0 0xa0000000 0xa0000000 0 0x10000000>,
+			 <0x01000000 0 0x00000000 0xb0000000 0 0x01000000>;
 	};
 
 	localbus {
diff --git a/arch/powerpc/boot/dts/tqm5200.dts b/arch/powerpc/boot/dts/tqm5200.dts
index 9ed0bc78967e..40b139d92a19 100644
--- a/arch/powerpc/boot/dts/tqm5200.dts
+++ b/arch/powerpc/boot/dts/tqm5200.dts
@@ -200,8 +200,8 @@
 		clock-frequency = <0>; // From boot loader
 		interrupts = <2 8 0 2 9 0 2 10 0>;
 		bus-range = <0 0>;
-		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000
-			  0x02000000 0 0x90000000 0x90000000 0 0x10000000
-			  0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
+		ranges = <0x42000000 0 0x80000000 0x80000000 0 0x10000000>,
+			 <0x02000000 0 0x90000000 0x90000000 0 0x10000000>,
+			 <0x01000000 0 0x00000000 0xa0000000 0 0x01000000>;
 	};
 };
-- 
2.17.1

