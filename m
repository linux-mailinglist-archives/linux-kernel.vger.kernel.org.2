Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAC6637174B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 May 2021 16:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhECO7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 May 2021 10:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbhECO7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 May 2021 10:59:06 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E71CC06174A;
        Mon,  3 May 2021 07:58:13 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id h7so2976471plt.1;
        Mon, 03 May 2021 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vRW0z6o62j2Rv6stuOnNguxxqbJxgi3ojoBSOT6id5I=;
        b=E1l7I2OZq0m5k+wR5en1GXGQ2k//0/zMXkQLeNcSvDD9aHIxK7wFsBnKW8S/GqOthq
         kpwPW1LjF2lRY3MCn+YFKZwlvr5sxz+njK7hftSHv8imbbdPLa9hqPr8TvoubIDHP8uD
         3Edela3tN5gualI+5lLw/MoU1XdzNb1U36/7mmwkN+1Cr8dFlsLvEqrv8ITtTQP+sCeV
         O71OFTc91ECUatQkrfnli8Er2/0KmzgVjThRNg+j4wAnbFqY1ipDVZAmEjolhEV9LKkE
         qLZ4t91A0Ix5GCBgXNKa47rfq7AKeU9EwCkYwQKAssi7CfcSAv+gptmMsm2AsO1zyRfg
         814g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vRW0z6o62j2Rv6stuOnNguxxqbJxgi3ojoBSOT6id5I=;
        b=Zp9Mjbr6zhy6EUc9Hz3Yg3tU6heww9nBuNL6Ex5sGzHKanaaF4izXpomndhGNn6wiQ
         sasS4ordjdW4ovKKufu4wUgTOO5Ux2ScEMxgcyObUh/YIKWmCtW2Djau3Fyg3yjc7Ps7
         P1Vz0Hj9OWuKp04QJ9GhAvISd1V7MvoLwedzUkiVDJS7KhzrJh3ZNCdfGCdQCPOxfJzi
         9H3EPuK8lCnyBUsMecfP/hoeyTgMWSjyxynTGaqERgAjIQs/sepXSNu15mkl0+KsNa8+
         RMlzqQ/y1SGJCeFFsDsRkwsccwlXDmWkAXVd9QLoGpPKIRm/8a54ONxjRevurTkItXhQ
         T9lQ==
X-Gm-Message-State: AOAM530tdRhmGdoT/SHljto6KCKCMpcKQMg4XaunDKioe3EpOiccottj
        fH0fdN7O7bq7plCuDUmQ2B6IW4sfWUQ=
X-Google-Smtp-Source: ABdhPJxdH8shFvNDWBfe4hBmSWExpR/lT3D5XRXibkmmvQaUQvlFlgIk4vF6l7dDVeQwG2M+l87IrQ==
X-Received: by 2002:a17:90a:e005:: with SMTP id u5mr22338268pjy.127.1620053892697;
        Mon, 03 May 2021 07:58:12 -0700 (PDT)
Received: from archl-on2.. ([103.51.75.154])
        by smtp.gmail.com with ESMTPSA id k38sm3593983pgi.73.2021.05.03.07.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 07:58:11 -0700 (PDT)
From:   Anand Moon <linux.amoon@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anand Moon <linux.amoon@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCHv1 2/9] arm64: dts: amlogic: Add audio power domain for g12a and g12b
Date:   Mon,  3 May 2021 14:54:35 +0000
Message-Id: <20210503145503.1477-3-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210503145503.1477-1-linux.amoon@gmail.com>
References: <20210503145503.1477-1-linux.amoon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add audio power domain id for sound on g12a and g12b sbc
to enable audio power domain via "pwrc" controller.

Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts     | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts    | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts   | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts     | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi | 1 +
 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts  | 1 +
 7 files changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index 81269ccc2496..24599f448564 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -217,6 +217,7 @@ sound {
 		assigned-clock-rates = <294912000>,
 				       <270950400>,
 				       <393216000>;
+		power-domains = <&pwrc PWRC_G12A_AUDIO_ID>;
 		status = "okay";
 
 		dai-link-0 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 579f3d02d613..1c821800514a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -167,6 +167,7 @@ sound {
 		assigned-clock-rates = <294912000>,
 				       <270950400>,
 				       <393216000>;
+		power-domains = <&pwrc PWRC_G12A_AUDIO_ID>;
 		status = "okay";
 
 		dai-link-0 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
index 6c7bfacbad78..99ed165a41c9 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gsking-x.dts
@@ -49,6 +49,7 @@ sound {
 		assigned-clock-rates = <294912000>,
 				       <270950400>,
 				       <393216000>;
+		power-domains = <&pwrc PWRC_G12A_AUDIO_ID>;
 		status = "okay";
 
 		dai-link-0 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
index 707daf92787b..6bcc4685e65b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
@@ -58,6 +58,7 @@ sound {
 		assigned-clock-rates = <294912000>,
 				       <270950400>,
 				       <393216000>;
+		power-domains = <&pwrc PWRC_G12A_AUDIO_ID>;
 		status = "okay";
 
 		dai-link-0 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
index 5d96c1449050..555524cd50f2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
@@ -45,6 +45,7 @@ sound {
 		assigned-clock-rates = <294912000>,
 				       <270950400>,
 				       <393216000>;
+		power-domains = <&pwrc PWRC_G12A_AUDIO_ID>;
 		status = "okay";
 
 		dai-link-0 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 344573e157a7..e99533dd64c2 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -258,6 +258,7 @@ sound {
 		assigned-clock-rates = <294912000>,
 				       <270950400>,
 				       <393216000>;
+		power-domains = <&pwrc PWRC_G12A_AUDIO_ID>;
 		status = "okay";
 
 		dai-link-0 {
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
index 0c7892600d56..4b12685af1ad 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
@@ -40,6 +40,7 @@ sound {
 		assigned-clock-rates = <294912000>,
 				       <270950400>,
 				       <393216000>;
+		power-domains = <&pwrc PWRC_G12A_AUDIO_ID>;
 		status = "okay";
 
 		dai-link-0 {
-- 
2.31.1

