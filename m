Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C90C3A34EC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 22:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230299AbhFJUh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 16:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbhFJUh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 16:37:57 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B795C061574;
        Thu, 10 Jun 2021 13:35:52 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id v206-20020a1cded70000b02901a586d3fa23so7212048wmg.4;
        Thu, 10 Jun 2021 13:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VeZXswZxRD+3nTHCw6XIn2R0ZIwkjuuYpAtyCSKoiyc=;
        b=fyOH+33+oSzufKMhSSVK9A4tuPMTrqdsJT9Xnhwii7ajsVNYmURYGAjB03+NGj0EwZ
         CjY72dXff51psKaFO7bZrsM4f+r9PVHfczw4jzcYU4IEyBvTFjmP47uY8F/23ryd9tr7
         dkn/s9lfPs8oYKwn1USPuVckuuiH49HzdoLygTsr9J/aAQ9NT4CjUSEcsqgLniQQvz09
         ZOmYO+SuacogCUDppSS1k3IjEBpLlC61YsYbxVoeKd5t9HtxPgpekrmj2FIvYg36NqwN
         YdOe7RGon5lcde7Bgu/nJGBEkPhtLbnlN5/jietHP3zHsqtqR4z8wozFZOBc4/aZ8Rxj
         K1/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VeZXswZxRD+3nTHCw6XIn2R0ZIwkjuuYpAtyCSKoiyc=;
        b=AzrwYE25XbfbIJnZmgFOg3VU6+c5Crca8yobZ/t++KR8OJJI887qQF1v3h0PLIxDdL
         ATI7smXromfs+iYblmQAevNx4+GhwmyQkeJ17CaUShEyNT4uSyybZr6jSDghW+WFufkr
         j20MFCGVNQsNllkxfZUrPoiRCtxV1LfgJHjNLFdrH3gaSI5nlohrucwPrPUWQUxCCXRs
         b9cFALI/ogO+HSg0ozTn2LqArmQaa8TtzkqbIT2FcbWiUBczpWJ1e1Ep+wcvsCHT2eu5
         OIz4n2VrTTepYoPk3g9QNRSsziPqOvOTWIPucHmPAuYsS1kFmssaS+YT0tZ/aF9hVLuP
         Cjcw==
X-Gm-Message-State: AOAM533udBo9AWuQXXVcNcjzrzsHshnKpbq4/FBPk+6a0Bm22sQHtKGW
        D5QXkOSqL69j+gGV50JmdoI=
X-Google-Smtp-Source: ABdhPJwJgJKfP3/wUnNSWXN8P8VMjcaDQiO8aym5JBB4uUhLMFnfwySNC5y+RnBC2l7lRJH4JfACJw==
X-Received: by 2002:a05:600c:2194:: with SMTP id e20mr16420410wme.138.1623357350613;
        Thu, 10 Jun 2021 13:35:50 -0700 (PDT)
Received: from cluster5 ([80.76.206.81])
        by smtp.gmail.com with ESMTPSA id z5sm4705333wrv.67.2021.06.10.13.35.48
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 10 Jun 2021 13:35:48 -0700 (PDT)
From:   Matthew Hagan <mnhagan88@gmail.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Matthew Hagan <mnhagan88@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 1/3] ARM: dts: NSP: add device names to compatible
Date:   Thu, 10 Jun 2021 21:35:10 +0100
Message-Id: <20210610203524.2215918-1-mnhagan88@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently only the SoC type and platform are specified for all NSP
devices. This patch adds the device names.

Signed-off-by: Matthew Hagan <mnhagan88@gmail.com>
---
 arch/arm/boot/dts/bcm958522er.dts  | 2 +-
 arch/arm/boot/dts/bcm958525er.dts  | 2 +-
 arch/arm/boot/dts/bcm958525xmc.dts | 2 +-
 arch/arm/boot/dts/bcm958622hr.dts  | 2 +-
 arch/arm/boot/dts/bcm958625hr.dts  | 2 +-
 arch/arm/boot/dts/bcm958625k.dts   | 2 +-
 arch/arm/boot/dts/bcm988312hr.dts  | 2 +-
 7 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/arm/boot/dts/bcm958522er.dts b/arch/arm/boot/dts/bcm958522er.dts
index 5443fc079e6e..b6f4d931123c 100644
--- a/arch/arm/boot/dts/bcm958522er.dts
+++ b/arch/arm/boot/dts/bcm958522er.dts
@@ -37,7 +37,7 @@
 
 / {
 	model = "NorthStar Plus SVK (BCM958522ER)";
-	compatible = "brcm,bcm58522", "brcm,nsp";
+	compatible = "brcm,bcm958522er", "brcm,bcm58522", "brcm,nsp";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
diff --git a/arch/arm/boot/dts/bcm958525er.dts b/arch/arm/boot/dts/bcm958525er.dts
index e1e3c26cef19..af66caa87bfc 100644
--- a/arch/arm/boot/dts/bcm958525er.dts
+++ b/arch/arm/boot/dts/bcm958525er.dts
@@ -37,7 +37,7 @@
 
 / {
 	model = "NorthStar Plus SVK (BCM958525ER)";
-	compatible = "brcm,bcm58525", "brcm,nsp";
+	compatible = "brcm,bcm958525er", "brcm,bcm58525", "brcm,nsp";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
diff --git a/arch/arm/boot/dts/bcm958525xmc.dts b/arch/arm/boot/dts/bcm958525xmc.dts
index f161ba2e7e5e..3d6859e4fd5e 100644
--- a/arch/arm/boot/dts/bcm958525xmc.dts
+++ b/arch/arm/boot/dts/bcm958525xmc.dts
@@ -37,7 +37,7 @@
 
 / {
 	model = "NorthStar Plus XMC (BCM958525xmc)";
-	compatible = "brcm,bcm58525", "brcm,nsp";
+	compatible = "brcm,bcm958525xmc", "brcm,bcm58525", "brcm,nsp";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
diff --git a/arch/arm/boot/dts/bcm958622hr.dts b/arch/arm/boot/dts/bcm958622hr.dts
index 83cb877d63db..dca2c9c60857 100644
--- a/arch/arm/boot/dts/bcm958622hr.dts
+++ b/arch/arm/boot/dts/bcm958622hr.dts
@@ -37,7 +37,7 @@
 
 / {
 	model = "NorthStar Plus SVK (BCM958622HR)";
-	compatible = "brcm,bcm58622", "brcm,nsp";
+	compatible = "brcm,bcm958622hr", "brcm,bcm58622", "brcm,nsp";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
diff --git a/arch/arm/boot/dts/bcm958625hr.dts b/arch/arm/boot/dts/bcm958625hr.dts
index cda6cc281e18..3a62d2d90a18 100644
--- a/arch/arm/boot/dts/bcm958625hr.dts
+++ b/arch/arm/boot/dts/bcm958625hr.dts
@@ -37,7 +37,7 @@
 
 / {
 	model = "NorthStar Plus SVK (BCM958625HR)";
-	compatible = "brcm,bcm58625", "brcm,nsp";
+	compatible = "brcm,bcm958625hr", "brcm,bcm58625", "brcm,nsp";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
diff --git a/arch/arm/boot/dts/bcm958625k.dts b/arch/arm/boot/dts/bcm958625k.dts
index ffbff0014c65..d331c0a4e6b6 100644
--- a/arch/arm/boot/dts/bcm958625k.dts
+++ b/arch/arm/boot/dts/bcm958625k.dts
@@ -36,7 +36,7 @@
 
 / {
 	model = "NorthStar Plus SVK (BCM958625K)";
-	compatible = "brcm,bcm58625", "brcm,nsp";
+	compatible = "brcm,bcm958625k", "brcm,bcm58625", "brcm,nsp";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
diff --git a/arch/arm/boot/dts/bcm988312hr.dts b/arch/arm/boot/dts/bcm988312hr.dts
index 3fd39c479a3c..a7953e5acc01 100644
--- a/arch/arm/boot/dts/bcm988312hr.dts
+++ b/arch/arm/boot/dts/bcm988312hr.dts
@@ -37,7 +37,7 @@
 
 / {
 	model = "NorthStar Plus SVK (BCM988312HR)";
-	compatible = "brcm,bcm88312", "brcm,nsp";
+	compatible = "brcm,bcm988312hr", "brcm,bcm88312", "brcm,nsp";
 
 	chosen {
 		stdout-path = "serial0:115200n8";
-- 
2.26.3

