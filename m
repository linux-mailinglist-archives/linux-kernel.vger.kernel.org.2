Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE17429D19
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 07:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbhJLF1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 01:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232560AbhJLF1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 01:27:35 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F9BC061570;
        Mon, 11 Oct 2021 22:25:34 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id g10so75531520edj.1;
        Mon, 11 Oct 2021 22:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=tl9ETMRggwTt4w1BJuvSOqa6Sje5OfaoWtxCYX0xMYM=;
        b=iP+o4z4l+t1ja+iu363orMJJ7zwyAd2jhBzfzgx004tVQ6Q5dnXfO3Eu9zfor8ImbT
         nAE4MJcarP0hZelY6wDGVRvNPWo2oDwY8+antfp65W1ftS7baKH0ZYv9dqbuXs4Od1aK
         7eUT591gjiwnJ4LqCx7XOnvbe/L2bMikzCjo/PGUXtsRHvWiva9HvDkjXZ8b2V9o5fm1
         3CGVe5Ph+EBZPRSw9X9R/8922OFZeXrxolBjAncXBBDO4mWapuRcmDuXu33+QV8QP0qu
         cKxj2hxXBs13HVDEItHxwatMtODCB4Wm8uzsEQL48K1w217AL8PGHlFVbGdOizs2Q3S4
         WTHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=tl9ETMRggwTt4w1BJuvSOqa6Sje5OfaoWtxCYX0xMYM=;
        b=UyYPlveSEoeF052la+GeakiUYvJVj7DZyamA2LW4Dm9h30xQ1Qaaby/ue3Vkg7L+YL
         0VcXUAQ2O0yKCICszkwe9XsVKUrTZyI1zOQSLvDMbCpU/oRdlBn9wITEZFTmUNFwHolw
         ocAOPHrMtvbIgcZq3zCh65qeW6J8D0JYf7Dw/5to116oWUb850lkWdkfjsD4Wcea0Tda
         yHYaXjwwWBOmLN4YToO1ELW0wGZkfWR0upTXTdoimiOXFcwKjkFwopDD945akfP+Xuv4
         lbczv5ks1T3D/gxFCuZCAHWkhMpX9I5wj7uU/O7saEWTKEuAZe7+hs8qZcPh28fg8/+o
         xN/Q==
X-Gm-Message-State: AOAM532GRZlEsmVo/2DPz/lRbN09rGvYEFpe0vWoR5DD9vdUUwxkPpD8
        LlL7+nsDup500VUd7inHjs8VomyMwJ240g==
X-Google-Smtp-Source: ABdhPJxcaUjKbcxZ4kYoGoH/sohed8/AYst/1v6n91ZXxoR2Z7hPP48dUNM3cuYKYRfXZkRhp1CXgw==
X-Received: by 2002:a17:907:3f27:: with SMTP id hq39mr29317304ejc.352.1634016332664;
        Mon, 11 Oct 2021 22:25:32 -0700 (PDT)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id r22sm4323321ejd.109.2021.10.11.22.25.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 22:25:32 -0700 (PDT)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH 3/3] arm64: dts: meson-gxbb-wetek: use updated LED bindings
Date:   Tue, 12 Oct 2021 05:25:22 +0000
Message-Id: <20211012052522.30873-4-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211012052522.30873-1-christianshewitt@gmail.com>
References: <20211012052522.30873-1-christianshewitt@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Update the dts to use the newer style of LED bindings.

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index a4d34398da35..94dafb955301 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -7,6 +7,7 @@
 
 #include "meson-gxbb.dtsi"
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/leds/common.h>
 
 / {
 	aliases {
@@ -26,8 +27,10 @@
 	leds {
 		compatible = "gpio-leds";
 
-		led-system {
-			label = "wetek-play:system-status";
+		led-power {
+			/* red in suspend or power-off */
+			color = <LED_COLOR_ID_BLUE>;
+			function = LED_FUNCTION_POWER;
 			gpios = <&gpio_ao GPIOAO_13 GPIO_ACTIVE_HIGH>;
 			default-state = "on";
 			panic-indicator;
-- 
2.17.1

