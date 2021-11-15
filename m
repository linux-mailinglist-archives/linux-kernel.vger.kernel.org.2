Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1880D451BED
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhKPAJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:09:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350414AbhKOUXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 15:23:48 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC7EC079781;
        Mon, 15 Nov 2021 12:11:17 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id t30so32944792wra.10;
        Mon, 15 Nov 2021 12:11:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OVufiMS+5ME6/qbmdZ9jFuP6rhzYyALe6R8u1xIQ+I8=;
        b=WxqUWqw9dcjW58RqrOawZJX8dFHGcFnqlOdeYJiHKEfL/w8CcJBKNfS5hs/bRlROkS
         DdCUsECLDA5V6QkypM6B5Wo2JFC8uqqpwXHvO2vr3PQkfLPcgvgG/dpAAkznKWl65CTh
         JG8S6Ii+uYuNCuRUEOU6lh36LitBTBiHXD5BNIp+F0gEkasoxvJUMDb6aPfs+pDeq7Ub
         tZ0U5WoZ06rEso3K4WPUoqi6IghSkiNAwMkIo5Gl1C2caO+WA5TvDvQjV7Npuwe7GsZ/
         X4VpmqIT0/BJDzxJ+kavTAjlQx/27rs4f6/LGwf4soEWmIW4B6jXLoAqzFHR0c6SDKn9
         0Sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OVufiMS+5ME6/qbmdZ9jFuP6rhzYyALe6R8u1xIQ+I8=;
        b=X85Jnd8C6r1Vx8ysWZn+XMZCArV6lBaycjkz1wtpi4h6eUCHHpHLN/d/Rabqyt68ok
         C+OvUqAagrT/1/DxUlXJjaK+NLsezABUK3GpbYBYFE8tZFpfebHVij/jso3Xku5qjdEf
         JhshxrAUh3T2vfguHpD9V99yfIAiaMWDs+IvdN65f2NcaRO2nrONC5Fau3TXzkGon8lx
         7s41v9hbv5wiO6sAaOZmRNeOaSgHfOCho1ZaUTCCqJqjsy9T8Q0ZNPsG22/P1jPfxa2f
         oGID/MAuQKFvhNuPzxVqx+gmbgOY7b8HgDK/f9SzAu2uqoGDUd0gtX93B1rCKVH1u4ih
         z/pg==
X-Gm-Message-State: AOAM533aYInPgXw8p1SRJDrEwh36m06jwDJi+sE2KL8Nvos/EY+V6nqz
        PEZA/Zdkkp9FxVGjqdC4BEM=
X-Google-Smtp-Source: ABdhPJxRaydlPIgKCNnFlVSM/bdOi7Fbn48Le9KlaQLD2hWe6B5eTE0Fonu5liBo3qPVFLkEO0xmbA==
X-Received: by 2002:adf:e484:: with SMTP id i4mr2123541wrm.49.1637007075508;
        Mon, 15 Nov 2021 12:11:15 -0800 (PST)
Received: from kista.localdomain (cpe-86-58-29-253.static.triera.net. [86.58.29.253])
        by smtp.gmail.com with ESMTPSA id q4sm15529370wrs.56.2021.11.15.12.11.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Nov 2021 12:11:15 -0800 (PST)
From:   Jernej Skrabec <jernej.skrabec@gmail.com>
To:     mripard@kernel.org, wens@csie.org
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Subject: [PATCH] arm64: dts: allwinner: h6: tanix-tx6: Add SPDIF
Date:   Mon, 15 Nov 2021 21:11:12 +0100
Message-Id: <20211115201112.452696-1-jernej.skrabec@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tanix TX6 board has SPDIF connector in form of 3.5 mm jack.

Add support for it.

Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>
---
 .../dts/allwinner/sun50i-h6-tanix-tx6.dts     | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
index 8f2a80f128de..6c10ff7f4b1c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-tanix-tx6.dts
@@ -52,6 +52,24 @@ reg_vdd_cpu_gpu: regulator-vdd-cpu-gpu {
 		regulator-min-microvolt = <1135000>;
 		regulator-max-microvolt = <1135000>;
 	};
+
+	sound-spdif {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "sun50i-h6-spdif";
+
+		simple-audio-card,cpu {
+			sound-dai = <&spdif>;
+		};
+
+		simple-audio-card,codec {
+			sound-dai = <&spdif_out>;
+		};
+	};
+
+	spdif_out: spdif-out {
+		#sound-dai-cells = <0>;
+		compatible = "linux,spdif-dit";
+	};
 };
 
 &cpu0 {
@@ -127,6 +145,10 @@ &r_ir {
 	status = "okay";
 };
 
+&spdif {
+	status = "okay";
+};
+
 &uart0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&uart0_ph_pins>;
-- 
2.33.1

