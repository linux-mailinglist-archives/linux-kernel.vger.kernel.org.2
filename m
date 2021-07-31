Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30A3DC55E
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 11:25:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhGaJYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 05:24:54 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:59952
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229703AbhGaJYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 05:24:46 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id E45CC3F228
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 09:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627723479;
        bh=LR7PylKlSM9jbeT9DvZDED63xszwtTNm8McFnmsrZzE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vbhNutqO5C+wrwQrf11kMUiWHkqzEf3pRq5EVfbBlbhNKbKBh39ISmZ0ZMEwd7I1W
         9JR2sUPtBMIB5TW7PHl9/3n9qNOR+9sfVbHuM3zMnESxe+PwhQybajB4C8IE/Qsx8v
         Vvj3YysUgc9pN+tsVvl7rp6TEFy2AJHIKtkuBJ6OzPTFXUq7LpEn+EstOb0y6/tdLZ
         LK4VllHS8lhNmUEgiwMqBp1P7evX4QWYBGZeIxMB/SgJJLfPEdYFW6DoMdjRqnPECe
         fHttX9uSjTYlwccwbZyi10DCDtcxDABFhOWHZWqZe6OV+kg8+8hM5Rf+I1rtNx7vOp
         l2UeXy7J1svRw==
Received: by mail-ed1-f70.google.com with SMTP id c20-20020a0564021014b029039994f9cab9so4441623edu.22
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 02:24:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LR7PylKlSM9jbeT9DvZDED63xszwtTNm8McFnmsrZzE=;
        b=cvcRHPTzK+IRdqOylijtnu1HdMC11eSuuTbPNn9droxM4NoFfi9U/4IIKBqIfYYg3d
         n7BY09pK6ElXTYeSrkqRg9/L6ujXWcStY+P27milimG1OJALaBD/xv1AcobS7msHeW97
         8g0vXVNb8BIjElaxdwwM2N49IeTRJFBATJj66Z6bWRa1F8meO3kwCSbqjVB6WNWuaHrz
         6pndXMeON4R41PNBitLewPnOora9VaRyTKXY5QrX173//LGZOV5fFLroYgC43HYlMprV
         22cxbUsV6xYMZ5i3IdOlES4izhPU/EOdKb9VjZ5YiqYNaZhBPKyQLU5ZSxYEceNJ7rbg
         dkXw==
X-Gm-Message-State: AOAM533XTwNR9ddDp7AjykbwQXI94MSH6cfK4xSzImNbVHNyQeY25RIJ
        yIVaPp3/8o4ppNDd9LgQl7Ol+zkmDGU13eZjf8AuaaZ77TLAt4uIoHhNXQ+1kmjx92YknMct8pX
        avnu7CT0jnVvsDfyIer3nVLe36xCgfxWru/tg1OIw/A==
X-Received: by 2002:a50:d64a:: with SMTP id c10mr8402830edj.199.1627723479598;
        Sat, 31 Jul 2021 02:24:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnlJgsAJ+NC3dcAMAIjP6kd6XsZ6o25gKIxAdDwyN5QE4D1Nu5jA5QJOklXRxaOPI7XGCfBw==
X-Received: by 2002:a50:d64a:: with SMTP id c10mr8402817edj.199.1627723479493;
        Sat, 31 Jul 2021 02:24:39 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id r16sm1947693edt.15.2021.07.31.02.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 02:24:39 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 5/8] ARM: dts: exynos: add CPU topology to Exynos5260
Date:   Sat, 31 Jul 2021 11:24:06 +0200
Message-Id: <20210731092409.31496-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210731092409.31496-1-krzysztof.kozlowski@canonical.com>
References: <20210731092409.31496-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe Exynos5260 CPU topology.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5260.dtsi | 38 ++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5260.dtsi b/arch/arm/boot/dts/exynos5260.dtsi
index 973448c4ad93..52fa211525ce 100644
--- a/arch/arm/boot/dts/exynos5260.dtsi
+++ b/arch/arm/boot/dts/exynos5260.dtsi
@@ -34,42 +34,68 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		cpu@0 {
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu2>;
+				};
+				core1 {
+					cpu = <&cpu3>;
+				};
+				core2 {
+					cpu = <&cpu4>;
+				};
+				core3 {
+					cpu = <&cpu5>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x0>;
 			cci-control-port = <&cci_control1>;
 		};
 
-		cpu@1 {
+		cpu1: cpu@1 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
 			reg = <0x1>;
 			cci-control-port = <&cci_control1>;
 		};
 
-		cpu@100 {
+		cpu2: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x100>;
 			cci-control-port = <&cci_control0>;
 		};
 
-		cpu@101 {
+		cpu3: cpu@101 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x101>;
 			cci-control-port = <&cci_control0>;
 		};
 
-		cpu@102 {
+		cpu4: cpu@102 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x102>;
 			cci-control-port = <&cci_control0>;
 		};
 
-		cpu@103 {
+		cpu5: cpu@103 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a7";
 			reg = <0x103>;
-- 
2.27.0

