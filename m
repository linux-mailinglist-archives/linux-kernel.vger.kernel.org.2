Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC883F285A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 10:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232844AbhHTI0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 04:26:20 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46286
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232484AbhHTI0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 04:26:17 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 070824076F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 08:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1629447459;
        bh=d8xM/AjEqi+D82F4uBDDQrAWzl08FrG+YxG5akZl0IU=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=QgSbiPhRLy4RKgEz9TYJttmAk2UNP6zJREJAwHOMoiVuVhYWemjUBWXYAP70dbd12
         BXQzDUdFkW8XNgrfFQvAPuNIuf7tce++FG8zVlxf4mOjlM6S6dUuDBxo6Q2FBgRc4d
         NZ57Xn1xCok7lnTWVJidqvH+rF4ZodaEyW3egFFuwLxfL6gcYLe/RdsPdW5V2tSJDw
         5uG2+XmLpRJhZUZVN53kH1yH5nyawvP8i1VBPxQCD2KCeS4VJgXuy1HT3V+IdYGZvl
         xjGr3oUiSD9heIWyjPRb8Bt5VkxcOYx2Nke7NbfnHc9akxjr2KbvhjEX3skiT/ilOs
         IjxuMYMtAfb9A==
Received: by mail-ej1-f72.google.com with SMTP id q19-20020a1709064cd3b02904c5f93c0124so3376120ejt.14
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 01:17:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8xM/AjEqi+D82F4uBDDQrAWzl08FrG+YxG5akZl0IU=;
        b=ZaMfDVssb+mOsoek2hjV4aagcknK50fB2m5atBRW10j0AnBlKW8FcJUUIBbSV1OFZ0
         NVYiopB3KMRC2uKSADZ9t2NXSbkx3sx24qCigwTzk7CUFh9kBhIZR9XhY92UwNBrjGRf
         ypHG097SHWS6O61pfkf01YR8Bg/5X68SyRKaXLOtRxUbvWHaN8OHHiRwVvjozwXmKbwW
         TuCR8aIbO9NE5l57NWm5lvFt6CnhhRsT4/YrNyr+mKkdr3fiiw+kwsqYcniXAPK0eT8S
         RGipOY9QPXLfMZlQaI+f/HJdJqU472Dei/DmUi3yM4476BbEQ++0ocwrRZ9wCrTDZpCC
         pR+A==
X-Gm-Message-State: AOAM532lNn1n+tQg3L7Dr4eoW1yRaC5GgxltbwAJq8hRXisFvpBHfDJE
        Mh37PtkROcGIila9y5kGfWPRG+VHie+0CevCh1ZteuMkhqvckJ5hbD4KCqa0Tvuy+y1j5jyiulj
        /ZODsi9dHLe6qhWRTd+j4d+/yI/HucnrBdQWopwgT3A==
X-Received: by 2002:a17:906:1416:: with SMTP id p22mr19936539ejc.364.1629447457995;
        Fri, 20 Aug 2021 01:17:37 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyedBftyAz+28KskU/X2mqtpXdfrTDtjkZC8gEQB+dg5iHeoEDxeeEa0X5sxtezOQDUYByLOQ==
X-Received: by 2002:a17:906:1416:: with SMTP id p22mr19936525ejc.364.1629447457819;
        Fri, 20 Aug 2021 01:17:37 -0700 (PDT)
Received: from localhost.localdomain ([86.32.42.198])
        by smtp.gmail.com with ESMTPSA id d22sm2488041ejk.5.2021.08.20.01.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 01:17:37 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH 1/3] arm64: dts: arm: align watchdog and mmc node names with dtschema
Date:   Fri, 20 Aug 2021 10:17:31 +0200
Message-Id: <20210820081733.83976-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the watchdog and mmc device node names with the schema to fix
warnings like:

  mmci@50000: $nodename:0: 'mmci@50000' does not match '^mmc(@.*)?$'
  wdt@f0000: $nodename:0: 'wdt@f0000' does not match '^watchdog(@.*|-[0-9a-f])?$'

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/arm/juno-motherboard.dtsi    | 4 ++--
 arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
index 40d95c58b55e..f45c912b2806 100644
--- a/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-motherboard.dtsi
@@ -218,7 +218,7 @@ led7 {
 					};
 				};
 
-				mmci@50000 {
+				mmc@50000 {
 					compatible = "arm,pl180", "arm,primecell";
 					reg = <0x050000 0x1000>;
 					interrupts = <5>;
@@ -246,7 +246,7 @@ kmi@70000 {
 					clock-names = "KMIREFCLK", "apb_pclk";
 				};
 
-				wdt@f0000 {
+				watchdog@f0000 {
 					compatible = "arm,sp805", "arm,primecell";
 					reg = <0x0f0000 0x10000>;
 					interrupts = <7>;
diff --git a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
index 4c4a381d2c75..7260bcf4b2ab 100644
--- a/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
+++ b/arch/arm64/boot/dts/arm/rtsm_ve-motherboard.dtsi
@@ -130,7 +130,7 @@ aaci@40000 {
 					clock-names = "apb_pclk";
 				};
 
-				mmci@50000 {
+				mmc@50000 {
 					compatible = "arm,pl180", "arm,primecell";
 					reg = <0x050000 0x1000>;
 					interrupts = <9>, <10>;
@@ -190,7 +190,7 @@ v2m_serial3: serial@c0000 {
 					clock-names = "uartclk", "apb_pclk";
 				};
 
-				wdt@f0000 {
+				watchdog@f0000 {
 					compatible = "arm,sp805", "arm,primecell";
 					reg = <0x0f0000 0x1000>;
 					interrupts = <0>;
-- 
2.30.2

