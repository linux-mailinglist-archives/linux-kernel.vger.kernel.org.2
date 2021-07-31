Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804E63DC562
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 11:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhGaJY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 05:24:59 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:59976
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232866AbhGaJYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 05:24:47 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 16B053F22C
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 09:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627723481;
        bh=oZaMws7fwrXQ+39v59StjW2jRchmqWMSe99swu1ZncA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=nXg/FIqSDxEjmBHEH0h9pnjLLCOQJDVVzCZ/umh/7rFsyRWezPguqgjA0HW2TJTZE
         +h6JdFvLqhFLZ4jtVdtXc08Qe2yT0H1grLb72dwEmhd+WuE38yov3ldUknvN4K2UoZ
         MftRET4rUAvA9kAKppuyGLN1TYMKaeMWmqel+MRgLmhUwdgYj/PHmjl9U5rNN8BH2u
         O8qHuW+bKlLXDwxu5Lqx7wJwzlQYGn5AN6MYtLKuB+iDlKGa68+aMr9IqSUh9Mm9o1
         S2dBjrQhtmzrH3AD2CRYSn1FJson4RI4y6+FquLNIMhaqEd2GEzPFjZGiMWCl4sDSl
         GNJumKlHwx5+Q==
Received: by mail-ed1-f70.google.com with SMTP id y19-20020a0564021713b02903bbfec89ebcso5837795edu.16
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 02:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oZaMws7fwrXQ+39v59StjW2jRchmqWMSe99swu1ZncA=;
        b=Y4fVp+GM1HJu/M1YvRTdidpub94UH5chGROuhiM0FbGOcltL2+3XB5rJsPW/OnvmmO
         VwkZFeEunNpKJdr44Z5Kidaxrm6mlCdIrIHl70GP9jl/XRL0SCkE9b30yb+hjq1g5Sb6
         nVKOLwN2SiJTPwquD5uOQ59Elz2XayKZ4pz3HZbF9J7U/tmN0mlaTAywpAeW0eMuNx0U
         uLt0TZRT81za54z+6YiltyYwA8P6P3CJ3ntWIiIFOEg7BwQoKfuLL2Rv+D9F9aJ+l7g5
         gtUdMOpGgZ1zoNcSFMwi56O1ArwizY8AozST8jaoqpF9umezUfpH1/pa5eqcOJiMGoyv
         clWg==
X-Gm-Message-State: AOAM530M0Tq2jamPoosQ6Ql/8pS0HCGazCSVW5ALnHwhQfCtEI+Bmnja
        uNsvu67PWPqTQgKCveUv6ccTkFXMBofMkBRJr2tutBXwASRJxrk+E3MfXyo7YBubs2cpzeVuetK
        7hAxueYg8nmz9QG+1MG96pcG2RXD9HPrXaqsXd4QIhA==
X-Received: by 2002:aa7:c792:: with SMTP id n18mr8329661eds.269.1627723480790;
        Sat, 31 Jul 2021 02:24:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/sf10Y8srbg8K+efQ4NmEX6nec9k/+iYcFltTGdhcbdRPp/dreDc16TZIWHAzqpOtGFDNEg==
X-Received: by 2002:aa7:c792:: with SMTP id n18mr8329653eds.269.1627723480696;
        Sat, 31 Jul 2021 02:24:40 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id r16sm1947693edt.15.2021.07.31.02.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 02:24:40 -0700 (PDT)
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
Subject: [PATCH 6/8] ARM: dts: exynos: add CPU topology to Exynos5420
Date:   Sat, 31 Jul 2021 11:24:07 +0200
Message-Id: <20210731092409.31496-6-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210731092409.31496-1-krzysztof.kozlowski@canonical.com>
References: <20210731092409.31496-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe Exynos5420 CPU topology.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5420-cpus.dtsi | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5420-cpus.dtsi b/arch/arm/boot/dts/exynos5420-cpus.dtsi
index 58d1c54cf925..e9f4eb75b50f 100644
--- a/arch/arm/boot/dts/exynos5420-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5420-cpus.dtsi
@@ -22,6 +22,38 @@ cpus {
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
 		cpu0: cpu@0 {
 			device_type = "cpu";
 			compatible = "arm,cortex-a15";
-- 
2.27.0

