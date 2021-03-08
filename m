Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 873E033144A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 18:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbhCHRLg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 12:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbhCHRLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 12:11:32 -0500
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EE87C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  8 Mar 2021 09:11:32 -0800 (PST)
Received: by mail-qv1-xf4a.google.com with SMTP id u8so8157613qvm.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Mar 2021 09:11:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:message-id:mime-version:subject:from:to:cc;
        bh=tr6HPkgg4MpqWELU1JEOSqGDxtxLd5dCELHGhpEUINY=;
        b=gyAhJPIJZ6+npspbb5RY1bDEB+mSkCu8gFewM5MDwQZqi/n5g7l7VNpeB+OUb2Q7K6
         ITZoyRrIpyK7YGSyE/7d3h6V5mpk5r87VAHlcRCfogUl4NQG2kU2V9HVM6vVCYge1hC2
         vgU1eoNz7eFQAH9g2FhM3EJKsONxpLgfbxT54RRsmsNKbqIC3JxUSaRqxg8yQ2J35hU6
         AFsxOOgCyHlOCOFnBHjOkZbOxgj7POoHgHnZsjCZU/ioxYx18OxtS/7JWAKp60fA08/S
         8pszrq2V3vWtXxDGJLyFG/cwUubVBuGKtZKW5i7UiBGFYLm8j3pquD04A7PKYmYG60oi
         CHMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
         :to:cc;
        bh=tr6HPkgg4MpqWELU1JEOSqGDxtxLd5dCELHGhpEUINY=;
        b=bgDVw0m3cI4O8BWzffYUBVUczO94mUJ6F7mtnC6qOhq5f7nBFupfd9xQUFgZhOoyNW
         4ZuU6vreCZpOg4BoTMo+mK7u5Q5Tp4qtjVI6fL7kaMsLgBLoQIXK/0wP0X2oPghmQ9eM
         +qSRLtR59dRBXxJmFPNz7eyQEkuINfLiip4mGytrz50i2kalvprMdjvN0rGq7wFdsImw
         doKYxAhVDBvOCu/w/NIR8GgqFRZyoXsmCmxzb1wrFmJN8WLbwWObMUG2x5MfQPKZhp+P
         KQdHB4OyCFXiplSatFHPWdf7JXABYfx9HzoUUb5mpjWjNSDyn3FKiQ7tYQMn3cDD81GL
         nJgw==
X-Gm-Message-State: AOAM532SZypyxbsQyQPSbuw88c2dK73QbrkKgGQQw6pCVTZcexuU4V6C
        O9iBgqg5z/e0QKjrqZNGWIV0Og1CW6Q=
X-Google-Smtp-Source: ABdhPJz2ZlLneZ3FlZYATGAP2s9AJEsAx87D3eZviiGASrYqqJBH+I3gnmjuQ3+KB7CzOVlhxMACVsrGq+U=
Sender: "gmouse via sendgmr" <gmouse@gmouse.zrh.corp.google.com>
X-Received: from gmouse.zrh.corp.google.com ([2a00:79e0:42:200:8548:5463:8d18:40de])
 (user=gmouse job=sendgmr) by 2002:a05:6214:4b3:: with SMTP id
 w19mr21839691qvz.26.1615223491101; Mon, 08 Mar 2021 09:11:31 -0800 (PST)
Date:   Mon,  8 Mar 2021 18:10:50 +0100
Message-Id: <20210308171049.3962577-1-gmouse@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.30.1.766.gb4fecdf3b7-goog
Subject: [PATCH v2] ARM: dts: nuvoton: Fix flash layout
From:   gmouse@google.com
To:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     "Anton D. Kachalov" <gmouse@google.com>, openbmc@lists.ozlabs.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Anton D. Kachalov" <gmouse@google.com>

This change follows OpenBMC partitions' naming layout.

Signed-off-by: Anton D. Kachalov <gmouse@google.com>
---
 arch/arm/boot/dts/nuvoton-npcm750-evb.dts | 38 +++++++----------------
 1 file changed, 11 insertions(+), 27 deletions(-)

diff --git a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
index 9f13d08f5804..55c5a89592d7 100644
--- a/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
+++ b/arch/arm/boot/dts/nuvoton-npcm750-evb.dts
@@ -78,8 +78,8 @@ partitions@80000000 {
 			compatible = "fixed-partitions";
 			#address-cells = <1>;
 			#size-cells = <1>;
-			bbuboot1@0 {
-				label = "bb-uboot-1";
+			u-boot@0 {
+				label = "u-boot";
 				reg = <0x0000000 0x80000>;
 				read-only;
 				};
@@ -88,38 +88,22 @@ bbuboot2@80000 {
 				reg = <0x0080000 0x80000>;
 				read-only;
 				};
-			envparam@100000 {
-				label = "env-param";
+			u-boot-env@100000 {
+				label = "u-boot-env";
 				reg = <0x0100000 0x40000>;
 				read-only;
 				};
-			spare@140000 {
-				label = "spare";
-				reg = <0x0140000 0xC0000>;
-				};
 			kernel@200000 {
 				label = "kernel";
-				reg = <0x0200000 0x400000>;
-				};
-			rootfs@600000 {
-				label = "rootfs";
-				reg = <0x0600000 0x700000>;
-				};
-			spare1@D00000 {
-				label = "spare1";
-				reg = <0x0D00000 0x200000>;
-				};
-			spare2@0F00000 {
-				label = "spare2";
-				reg = <0x0F00000 0x200000>;
+				reg = <0x0200000 0x580000>;
 				};
-			spare3@1100000 {
-				label = "spare3";
-				reg = <0x1100000 0x200000>;
+			rofs@780000 {
+				label = "rofs";
+				reg = <0x0780000 0x1680000>;
 				};
-			spare4@1300000 {
-				label = "spare4";
-				reg = <0x1300000 0x0>;
+			rwfs@1e00000 {
+				label = "rwfs";
+				reg = <0x1e00000 0x200000>;
 			};
 		};
 	};
-- 
2.30.1.766.gb4fecdf3b7-goog

