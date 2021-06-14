Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D377F3A6A08
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 17:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233321AbhFNP16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 11:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233171AbhFNP15 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 11:27:57 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1960AC0613A2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:25:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id my49so17363293ejc.7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 08:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XJFjbPhrfegtNfuhhG4/X46/NhufcLg6TAlq0f4ZbDY=;
        b=VafrduA4pNBvoLbBwUrPmoT93xIdd26m4mmE/choRFD4GegDsDhmCGUlpxa9fXrv3b
         a+15uTmSBib674P7e18F+ggD8YCFSH3ELUvdVZ7Vqk6AhfAG9n6/Xpp+gTwFiFi2ayS7
         JrJUwJDnlR77khiNgFdQaghdOU+zuUGP9IHy+8V+o9DpePLMds3p26e3I719RhPU9wQC
         ngYrycrMHdiIGpkqySKBKaMlgaEOaUzGYEommx0vqdksCLb8G9TCwK8SbzvLSZ7vQBwW
         WIPPnCe4GXriuhpocHXqBo1PEihhv51I5dHpbQBVDND7BdRfjQBnhzSK92/MFpuWu5z0
         JBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=XJFjbPhrfegtNfuhhG4/X46/NhufcLg6TAlq0f4ZbDY=;
        b=QhlcTB7DXurcDh81LN0l2K/gtaG5YlV0obg1YpgEnpZbXF3ouTwTSvUmxRqgiLvMUI
         ISAFNxQnCL2k9T7dSszAoF7lBAyfuCF7iq8oZJLxPPc8DkH0SdCZfNjxY6EDN1oYdeWc
         AeacAabmC43SRwrO/cFPmzHDQIVobHsv+tY3Xpa7ZGVKZ22+xeWDJ5WL2354h/lh38Lp
         A0AjU1784jymmTpfNejhOQ51JNsYksRelwfjBEu7os+E6+//ZUxRTzcCaGm4NqfxTBUy
         4F4x5gTWgxNL6XTmmCpFinBR+3Xnr7ELd7f5s332yVzpqD5XCMnIPNvPiG2hW1SGghmo
         L/sA==
X-Gm-Message-State: AOAM533AWPfOhYJNwOrslOzsBAREeU0sDCrUpiYIeAszOjn0Xd6iO6hg
        JlrzlS/iFhTDty8/BLFevcDcN7a6T19NFf+l
X-Google-Smtp-Source: ABdhPJyQHh3TvhJ7fivhs429FHtuBrUkssK0kbjeqyU1rPXFu8sbhnz11EV2J/9Sl6sD55qn+crwlQ==
X-Received: by 2002:a17:907:9487:: with SMTP id dm7mr15621754ejc.349.1623684349246;
        Mon, 14 Jun 2021 08:25:49 -0700 (PDT)
Received: from localhost ([2a02:768:2307:40d6:f666:9af6:3fed:e53b])
        by smtp.gmail.com with ESMTPSA id br21sm7574230ejb.124.2021.06.14.08.25.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jun 2021 08:25:48 -0700 (PDT)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 04/33] arm64: zynqmp: Fix irps5401 device nodes
Date:   Mon, 14 Jun 2021 17:25:12 +0200
Message-Id: <10bf5f9e7a18579626fb1850e3a8a7476ba6f2ed.1623684253.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623684253.git.michal.simek@xilinx.com>
References: <cover.1623684253.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add compatible string for irps5401 chip.
- Do not use irps54012 as device node which is not correct.
- Fix addresses of irps5401/u180 on zcu104 revisions.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

Changes in v2: None

 arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts | 10 ++++++----
 arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts |  9 ++++++---
 2 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
index 99896db6b8ca..5c35edd736aa 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu104-revA.dts
@@ -157,11 +157,13 @@ i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
-			irps5401_43: irps54012@43 { /* IRPS5401 - u175 */
-				reg = <0x43>;
+			irps5401_43: irps5401@43 { /* IRPS5401 - u175 */
+				compatible = "infineon,irps5401";
+				reg = <0x43>; /* pmbus / i2c 0x13 */
 			};
-			irps5401_4d: irps54012@4d { /* IRPS5401 - u180 */
-				reg = <0x4d>;
+			irps5401_44: irps5401@44 { /* IRPS5401 - u180 */
+				compatible = "infineon,irps5401";
+				reg = <0x44>; /* pmbus / i2c 0x14 */
 			};
 		};
 
diff --git a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
index d4b68f0d0098..68b758e40f80 100644
--- a/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
+++ b/arch/arm64/boot/dts/xilinx/zynqmp-zcu111-revA.dts
@@ -326,13 +326,16 @@ i2c@2 {
 			#address-cells = <1>;
 			#size-cells = <0>;
 			reg = <2>;
-			irps5401_43: irps54012@43 { /* IRPS5401 - u53 check these */
+			irps5401_43: irps5401@43 { /* IRPS5401 - u53 check these */
+				compatible = "infineon,irps5401";
 				reg = <0x43>;
 			};
-			irps5401_44: irps54012@44 { /* IRPS5401 - u55 */
+			irps5401_44: irps5401@44 { /* IRPS5401 - u55 */
+				compatible = "infineon,irps5401";
 				reg = <0x44>;
 			};
-			irps5401_45: irps54012@45 { /* IRPS5401 - u57 */
+			irps5401_45: irps5401@45 { /* IRPS5401 - u57 */
+				compatible = "infineon,irps5401";
 				reg = <0x45>;
 			};
 			/* u68 IR38064 +0 */
-- 
2.32.0

