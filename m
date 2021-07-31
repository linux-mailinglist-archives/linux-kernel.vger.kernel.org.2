Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DED3DC563
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 11:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233324AbhGaJZC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 05:25:02 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:60032
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233029AbhGaJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 05:24:50 -0400
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id A42EB3F070
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 09:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627723483;
        bh=chFkYRASRXmnCTx3ox4fvgdh5vYDNQ+s+kCxqXeprbY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YXsVsGaZWOHequaxAuPZ3u4dHs0MJOTkgf7mTsLZoA8H8ekzazepCfbrfvRFSZZJ7
         Og+jWwcSArTtK63ZuRw2+h4CNzvLzwcPiGfXFE4zT3MA+NB1suMeZxyDGZgUWM2NY5
         uT+a+vuXLw3wcQcQBqktccsSQwyMuaLKa2xYVi4Fp+gqRDHdzKzdfXD3h+3kQCCfw9
         6NcVzzASnTClkIn1ySN/zM1n8/Uo/LiRh40ifLXs7inE20j45vQxz1MpgOEpkUVHJm
         kQeZT6EPyn+UczyEcb+lHB/Vxs4+o+Yobit+RoUHJKwUxcyVBQSdAXGD7pyhQGYp0Z
         X1+UpgqpwANjQ==
Received: by mail-ed1-f72.google.com with SMTP id u25-20020aa7d8990000b02903bb6a903d90so5884618edq.17
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 02:24:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=chFkYRASRXmnCTx3ox4fvgdh5vYDNQ+s+kCxqXeprbY=;
        b=OY4yLYNlkL7vHB5lVfpIIAy0BVtheZEQ8CE6NqFQSiLfWLijIXXRoB52mrKuRHURGd
         BISXCXWAYdTNIhiGAaajgj8sQUvGwSajuWBgNabbNPqdb5vrcnl9du6wj4XAVyKp60ls
         VGxqXMBH4y19ys0xraz2v8kLT8LtP37/OWOheBxzOdmdC/0gTRD9nrYPptQ+6tdFcXbY
         BHBgEmXLuAwsQL0s5c9uevW0/iIkOWbbtp5Hdg2rCesu4mHcioNEknAwW5FVy8BSP4+s
         eGD1QvkML7BK0wBybrrzRQSFQiwW53COPp/+Gycx9ysWL9duFV9XN7+RP0JB/i1AAQNO
         6/EQ==
X-Gm-Message-State: AOAM530Pa4RR5ECsmwQ0m4q5IWbqh8fub12POtG6nxgJ3DD8oUKM9Y8N
        r5FLA94ekcwNvo/7umhi2lvMQpZCI814g/BRblTDFxmecY0RuFKIQiaSgXxX4jdLth/sGALQ1M0
        VGlwo1jJ8ha9R/AeEyiiyg3cHoq8hPmii+e0hOi+Qug==
X-Received: by 2002:a05:6402:795:: with SMTP id d21mr8286572edy.351.1627723483220;
        Sat, 31 Jul 2021 02:24:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwB5LpBFJZe4d1UOd9BvYXXzvUaXaSYxvLp4RsSizpd+kp+Ein0sIsc5F4o+6q+hd41PzPxLg==
X-Received: by 2002:a05:6402:795:: with SMTP id d21mr8286563edy.351.1627723483120;
        Sat, 31 Jul 2021 02:24:43 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id r16sm1947693edt.15.2021.07.31.02.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 02:24:42 -0700 (PDT)
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
Subject: [PATCH 8/8] arm64: dts: exynos: add CPU topology to Exynos5433
Date:   Sat, 31 Jul 2021 11:24:09 +0200
Message-Id: <20210731092409.31496-8-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210731092409.31496-1-krzysztof.kozlowski@canonical.com>
References: <20210731092409.31496-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe Exynos5433 CPU topology.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm64/boot/dts/exynos/exynos5433.dtsi | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/exynos/exynos5433.dtsi b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
index 73aa0fa9b778..6a6f7dd1d65c 100644
--- a/arch/arm64/boot/dts/exynos/exynos5433.dtsi
+++ b/arch/arm64/boot/dts/exynos/exynos5433.dtsi
@@ -52,6 +52,38 @@ cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+				core2 {
+					cpu = <&cpu2>;
+				};
+				core3 {
+					cpu = <&cpu3>;
+				};
+			};
+
+			cluster1 {
+				core0 {
+					cpu = <&cpu4>;
+				};
+				core1 {
+					cpu = <&cpu5>;
+				};
+				core2 {
+					cpu = <&cpu6>;
+				};
+				core3 {
+					cpu = <&cpu7>;
+				};
+			};
+		};
+
 		cpu0: cpu@100 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a53";
-- 
2.27.0

