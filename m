Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0387F327E72
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Mar 2021 13:37:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbhCAMhH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Mar 2021 07:37:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbhCAMhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Mar 2021 07:37:00 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 960FDC06178A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 04:36:20 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id x29so3207212pgk.6
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 04:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+k4h3DmLpBdKDskL9GZ/5TFWOILyp4Yu88KprHaLQKE=;
        b=LXsgkHRudMusscZhb8tcXfF/UOSbdaiDWcQYPsD1X4Wq3fGQFyFSTcgYFNAa8NLPNq
         tTbnNz9qHrGUsGM9wVQ39viWKoq/ILyVTBh1LVGv/DhNUk/eOQCioNlhOHSm5JbM0DYN
         eANJzwaDFbvAKU1QILsouWS76VWxkq1hclLwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+k4h3DmLpBdKDskL9GZ/5TFWOILyp4Yu88KprHaLQKE=;
        b=Bs49PA8PGwBW1CHxFJZEp5EPjoyyxk/tX1Jj1+P9JMf0/leo3fgorzqcUJmHN3d1GF
         3cdJ6PFvviYfJQC5J2QctgTpR2ijH6PCQSKhLh+LU4+DW/h8zkBTAbBt59CAdQSlf0Uc
         bgoJE9ENxwbgrfOivcin7gIpwACMlkpsQQSKq9xThrRswcg194a3gM0vZLNXtzngBoXP
         WP0m3X+iXwyMQmiVJqpFj3h2vCuI7rnzI59QX7B2qIYXZXNbtL3wpQ9rys3ynoOwjdOz
         MXn74U6R0gbLmRDWklX0FUVSKL/gCPL/kqMHgSXu/H0HK5ENIiMKbzaelykjP98rGdaB
         sN1g==
X-Gm-Message-State: AOAM531S+5ihG8D1j3w1KFZ/9kkvhsSjr+z2xwPLhIcMZT9O+HBfyQr2
        sOMvgXiJ28rw5pYX0hlt6njmLQVyBrGNFQ==
X-Google-Smtp-Source: ABdhPJwTEPhmbXdM73IRV4qErcw1tHV6jN+BJBRpELMoKnNa4BLKg/pydkhpYosYCFC+tEFU67mx0g==
X-Received: by 2002:a63:c1d:: with SMTP id b29mr13749890pgl.9.1614602180117;
        Mon, 01 Mar 2021 04:36:20 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id 8sm18130928pfp.171.2021.03.01.04.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Mar 2021 04:36:19 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     soc@kernel.org
Cc:     arnd@kernel.org, olof@lixom.net, w@1wt.eu,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 2/3] ARM: mstar: Add the external clocks to the base dsti
Date:   Mon,  1 Mar 2021 21:35:41 +0900
Message-Id: <20210301123542.2800643-3-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210301123542.2800643-1-daniel@0x0f.com>
References: <20210301123542.2800643-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All of the currently known MStar/SigmaStar ARMv7 SoCs have an "xtal"
clock input that is usually 24MHz and an "RTC xtal" that is usually 32KHz.

The xtal input has to be connected to something so it's enabled by default.

The MSC313 and MSC313E do not bring the RTC clock input out to the pins
so it's impossible to connect it. The SSC8336 does bring the input
out to the pins but it's not always actually connected to something.

The RTC node needs to always be present because in the future the nodes
for the clock muxes will refer to it even if it's not usable.

The RTC node is disabled by default and should be enabled at the board
level if the RTC input is wired up.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index b0a21b0b731f..889c3804c251 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -46,6 +46,21 @@ pmu: pmu {
 		interrupt-affinity = <&cpu0>;
 	};
 
+	clocks: clocks {
+		xtal: xtal {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <24000000>;
+		};
+
+		rtc_xtal: rtc_xtal {
+			#clock-cells = <0>;
+			compatible = "fixed-clock";
+			clock-frequency = <32768>;
+			status = "disabled";
+		};
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.30.1

