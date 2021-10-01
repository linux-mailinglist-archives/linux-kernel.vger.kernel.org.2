Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9C341F1FD
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354855AbhJAQTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354813AbhJAQTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:19:24 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9896EC06177D
        for <linux-kernel@vger.kernel.org>; Fri,  1 Oct 2021 09:17:39 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u18so16325945wrg.5
        for <linux-kernel@vger.kernel.org>; Fri, 01 Oct 2021 09:17:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EzWy2nvLFCIuBba5ki21B6r/rdWPB3y7nLXxAimeS4w=;
        b=b2lLhCxu6V++Sis/mzcbImRUwTxDNoulIsuf3Sczqqkb3P62Hf51DBU/V8Y3dCY3HN
         rAmHWI7x8HxoS1AXDAOFpohrtioMc5sxKrjF2RRS21tl0Q0LxeED13VDEl3Vvo8frIai
         BlIbUZwOO//b4X2b+byOgLkAukKJtKa9Xk1MxDXLHsdr/Zo06R772bxPkEq3aF9qGBuR
         4pbDWJPO3Z6OXFcI3PV0P7g6fjuamXz0lGxqjXqyeqIukxKfoWOPY77DiZPPnRTiNDQS
         EFEaiN1U2lXaefXvFwMwxYdcTAJpXGyK8Xr0B+VmMShKQwaHAu2fP2MGxb8Et8Lq2m4R
         56WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EzWy2nvLFCIuBba5ki21B6r/rdWPB3y7nLXxAimeS4w=;
        b=bMq8+wpeF4fQ74gTaoQAe0cLv0WB5uV/udFVBgu9GbpliNHuaGfWJKvw9enghMUjKS
         yCLI1bB93Zd9Gmp6Sv98XqAvIbFIwbD0RflFhXt6hCSzMu0cDgW4JSVR8kBb5nYl+I19
         6H7zWWn7cLYKiNMnN/WkoGf8Dw0Z/Hdj3yh5mSeQX/ilQ+Yhflwr6Jf/kx5ZttmYRl4U
         2u6TMVqDIM7WPyA8AaeWRRlg0dy26Va8Q0B0ZTt8/ltX5VgTAZS0CwYnYrfP/KjYUgf0
         uEs9Xl1kjU6QX4+xSu1V4UpVVKMDwJv7aAU0u/r70jI6Gb+l9iIxn1GrQllQdqLxd9v2
         R/Kg==
X-Gm-Message-State: AOAM5319CPgOOulNOrkwNKQsNVeja/oavXTn4WvsMORa9iiQob9W8jY3
        z3dQAQX6CpBWIbGn/tMKMh89XiK0rewcgg==
X-Google-Smtp-Source: ABdhPJwgdmNt4q6CM1GJcIjHlayiUH7mjwfnFg2ReVmLQ9E++96gykDFNpXlrlKThqqyafXizNYSsg==
X-Received: by 2002:adf:a3c7:: with SMTP id m7mr13417466wrb.339.1633105057911;
        Fri, 01 Oct 2021 09:17:37 -0700 (PDT)
Received: from localhost.localdomain ([82.142.20.44])
        by smtp.gmail.com with ESMTPSA id d7sm6168206wrh.13.2021.10.01.09.17.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 09:17:37 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Add idle cooling devices
Date:   Fri,  1 Oct 2021 18:17:28 +0200
Message-Id: <20211001161728.1729664-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The thermal framework accepts now the cpu idle cooling device as an
alternative when the cpufreq cooling device fails.

Add the node in the DT so the cooling devices will be present and the
platforms can extend the thermal zone definition to add them.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 3871c7fd83b0..9ac232ffd284 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -124,6 +124,11 @@ cpu_b0: cpu@100 {
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <436>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			thermal-idle {
+				#cooling-cells = <2>;
+				duration-us = <10000>;
+				exit-latency-us = <500>;
+			};
 		};
 
 		cpu_b1: cpu@101 {
@@ -136,6 +141,11 @@ cpu_b1: cpu@101 {
 			#cooling-cells = <2>; /* min followed by max */
 			dynamic-power-coefficient = <436>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP>;
+			thermal-idle {
+				#cooling-cells = <2>;
+				duration-us = <10000>;
+				exit-latency-us = <500>;
+			};
 		};
 
 		idle-states {
-- 
2.25.1

