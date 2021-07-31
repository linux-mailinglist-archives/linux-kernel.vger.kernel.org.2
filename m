Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 374F53DC561
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Jul 2021 11:25:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbhGaJY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Jul 2021 05:24:56 -0400
Received: from smtp-relay-canonical-1.canonical.com ([185.125.188.121]:59946
        "EHLO smtp-relay-canonical-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232542AbhGaJYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Jul 2021 05:24:48 -0400
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-1.canonical.com (Postfix) with ESMTPS id 510183F238
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 09:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1627723482;
        bh=ERP8Nj6BhzRSI6a/TCOdFNPpRXHoJA+/4PhYRhY4Cn4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=ltZcAAlNLOY43R5wfUoIv463WaIZosnP5B0zkDYpunVh2xACR1sFOW5AZD8GBimRZ
         xpjawjZYOB2AMsCs4abW/yzJDj/UWFONqW4Z2Di0+v07/haMi+nGLRzYyL3+ZVcTRv
         G92Xffrnie/6DP0T9n0AivJbqi6fHKm3kvEnEOlm3YwP3MaisjiyAEK+V+iqLWTzvy
         Fa2uOG47+8SeNIvuguOtcMDoitht1rB4B/nFA1Td/hq9oFLBgN3GH6hYsPNdUA0rRI
         qcWAXsk/kIkf8bRDi/dnbVlqFZysXMrwqiNkSEmi+NTZ1tRtlOseUkP71kRR6NlZZd
         k0Y7FCSP/7VCw==
Received: by mail-ed1-f69.google.com with SMTP id y39-20020a50bb2a0000b02903bc05daccbaso5876741ede.5
        for <linux-kernel@vger.kernel.org>; Sat, 31 Jul 2021 02:24:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ERP8Nj6BhzRSI6a/TCOdFNPpRXHoJA+/4PhYRhY4Cn4=;
        b=bg62owU7XYFheuoX96ydQ2qS+kH5OynaYv2ZDl0RbTtvahwHA5FF6VGlybyK0bUTsz
         S4AphWfcFSt6J26uxiQwmMDOEtrQuFE99OoGIYHlNrLME76drudfCiDrbuhAtgqWzUdm
         FGTOgcQ/euPBBUEtpdJ16d49kk7MNGigeu0XbZSLXScicDupy/p6ueLwtMqYFjSVQK9Z
         Y0pqAeGxH5vzcVxLxIKeBvLHkzvcWWxPCa8DSC8w7gcMGv7NdRyih+gFQEgXk+AItIhp
         2w5mVsW6iRaUTOblb+8EusmDlIY40WQIPERyW4O31R0/O36YyUF1nhMVCy1j7kwn31Kh
         /yAQ==
X-Gm-Message-State: AOAM531gjZfQLTvUPcRDy/LRQ+kgz2AinYAeBZnJdOEuZX2vuewPMWJf
        K6nFs3gQnR+r5Yw8hOZr9XvI/D1nhgCUbMjLAYVqUEdLFop0JYYQ/8Rxb62BQ9p5IMVqn1xBkPu
        xy+fBDfqLMXNk98qp/4XRmrm4fTfI5YNwmnUKRE7N+g==
X-Received: by 2002:aa7:c2d7:: with SMTP id m23mr8435684edp.30.1627723482007;
        Sat, 31 Jul 2021 02:24:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzWDPnTDXwoerV0fH7BKZWtc51zibHNXd/dd+1kecWozTV2HkLy5eSAhhDXTpFxZ0+A24W0fA==
X-Received: by 2002:aa7:c2d7:: with SMTP id m23mr8435672edp.30.1627723481915;
        Sat, 31 Jul 2021 02:24:41 -0700 (PDT)
Received: from localhost.localdomain ([86.32.47.9])
        by smtp.gmail.com with ESMTPSA id r16sm1947693edt.15.2021.07.31.02.24.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Jul 2021 02:24:41 -0700 (PDT)
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
Subject: [PATCH 7/8] ARM: dts: exynos: add CPU topology to Exynos5422
Date:   Sat, 31 Jul 2021 11:24:08 +0200
Message-Id: <20210731092409.31496-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210731092409.31496-1-krzysztof.kozlowski@canonical.com>
References: <20210731092409.31496-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Describe Exynos5422 CPU topology.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5422-cpus.dtsi | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5422-cpus.dtsi b/arch/arm/boot/dts/exynos5422-cpus.dtsi
index 4b641b9b8179..412a0bb4b988 100644
--- a/arch/arm/boot/dts/exynos5422-cpus.dtsi
+++ b/arch/arm/boot/dts/exynos5422-cpus.dtsi
@@ -21,6 +21,38 @@ cpus {
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
 			compatible = "arm,cortex-a7";
-- 
2.27.0

