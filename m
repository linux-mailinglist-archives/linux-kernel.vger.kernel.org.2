Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4122E3DC564
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 11:25:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234746AbhGaJZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 05:25:04 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:60046
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233201AbhGaJYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 05:24:55 -0400
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 263FF3F070
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 09:24:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627723489;
        bh=UFrU0S2bBX7EdA6lqG0g8Nn8+OpcqLpY1eSVFyrsvVw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=VF8AJsws9UtBEk+FfYS+vKjuKs3dSdMipPMHvnu83AFCYgSJoBXpTL0MD7KzkCwju
         U4miyEXwewsi8joFnlL3ouhuXON4roHre/zaFUf8xUu8wPaokD/NdKH0IgNMGQ9B+L
         /lL+jFm1NFmktvAzpo2BpxP0ZXHZe2BjkmMwmr0+fTi8wnMv0Uj3SYjbe0hvws63T7
         qzetrkWPeJfwfB82pD9Twg9S/VJJONxzYP2GdI1cJqeu8c1XYWnBPfG92E0DWRKQCT
         2PwGCdxX74CZiia+52NZ0nUwxZ5DrCf/stdxq6oWhVA0cem03tI9AotjFPKmzhcNeg
         smrrmgNwr1VVw==
Received: by mail-ej1-f72.google.com with SMTP id k21-20020a1709062a55b0290590e181cc34so2659456eje.3
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 02:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UFrU0S2bBX7EdA6lqG0g8Nn8+OpcqLpY1eSVFyrsvVw=;
        b=sFHbLeHuNxVb7jN6yRdolu2iBM2XsVLhOY7R02xIRy3k0MTBS0ZTlX2kzlx7WLYXAT
         KMA9HTQ0Rnq4IlTnBF/B4JHJs1Xdw9XM1/1zOIzLfHooy96o5Hnf8/lM2aMl30NUxT6p
         6eLhamLlrXU/5tMP/mTuN5eDUAqoLKJOrbkbkieAQ9007ofS9ATSU+lnbgeOwKBxj8R0
         MO+Gpou0O1Cr7oTnoBXn0+75fyLClNPwe0vuNQRQNHsO4J7T2nQ6UcUEA1B5y6FvMmF0
         009PoPJZ090caYkyymVPbpVdnkkB203qxxydXx4fpN9hbO7fK9rS19GEbY2TIXQN/OnX
         Nc9g==
X-Gm-Message-State: AOAM532rhNDNptPzHJmmW9qnZSh+HMv0N9JS2P9tn6ewAuQPqbwrKJd+
        0TV8z4+ouNVBgWyCPJQ4UllExalqkeYJ1QxXfGBNoWP629EyOto/Zn/x3ySpCMR53JemIsDdmZq
        KDF877XCp81u5wm8W40N/2XDUtKC1Onj/vzwiBT2Z7A==
X-Received: by 2002:a17:906:45b:: with SMTP id e27mr6644139eja.375.1627723488140;
        Sat, 31 Jul 2021 02:24:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1xUNY9MDqXQPMmbYu8q3NXm6Wwff2iuWqe6SEijIFM6pC3pnzQBfwNFCRmBOiJeVKeItFrg==
X-Received: by 2002:a05:6402:40d4:: with SMTP id z20mr1261891edb.89.1627723477052;
        Sat, 31 Jul 2021 02:24:37 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id r16sm1947693edt.15.2021.07.31.02.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 02:24:36 -0700 (PDT)
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
Subject: [PATCH 3/8] ARM: dts: exynos: add CPU topology to Exynos4412
Date:   Sat, 31 Jul 2021 11:24:04 +0200
Message-Id: <20210731092409.31496-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210731092409.31496-1-krzysztof.kozlowski@canonical.com>
References: <20210731092409.31496-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe Exynos4412 CPU topology.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos4412.dtsi | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4412.dtsi b/arch/arm/boot/dts/exynos4412.dtsi
index a142fe84010b..d3802046c8b8 100644
--- a/arch/arm/boot/dts/exynos4412.dtsi
+++ b/arch/arm/boot/dts/exynos4412.dtsi
@@ -35,6 +35,23 @@ cpus {
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
+		};
+
 		cpu0: cpu@a00 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a9";
-- 
2.27.0

