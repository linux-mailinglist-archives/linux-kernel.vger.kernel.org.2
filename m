Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 039E53225E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 07:26:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhBWG03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 01:26:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhBWGV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 01:21:26 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F7FCC061221
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:19:27 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id s23so1193448pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:19:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SE8LvB13EoijNekrwFmw4zAb9BZgnUUKtus/CbxCO44=;
        b=Vzqnw822lH2lfVZnHFzXqgEjRR+CAv1klD1WlOha88yUivgU/HRzplnKxIRyISmh0c
         JbvmMk3JdaI2X1TDHww+2/w7j/gkEVZkZOQZS69erTcEV6JBiWyzuSXvc9JMPyGMs9Kw
         +Dn0H3PI6Wgd7h/fts19GzE8gCfBUHadG09JQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SE8LvB13EoijNekrwFmw4zAb9BZgnUUKtus/CbxCO44=;
        b=g+c7qr1GXaASprtUFIXP4c057HqLPpj9gbEmuADI34tx/+BFDMHOnpYUGWqX5FPANo
         OGvgl1hsjtLLxHMXdEmA9IVTRu2dwe3qN3J66kWDbVhi5DmF/hzRlTI0hVbFn/ia6aj2
         MPFvF30h56cQb9CKHToCXeUBfbfOul///3f5OijT1VWMH2t4MuJC191lgFIUlh+rQKqp
         XZIBPAAzaZoNvmTlZSxTw/aIgmMX2z+ZmbJ/R8ogUZxLcNgLESYtHWGGAPGyevUoiFqQ
         js3SZNtLCUMy2I0GoTwVNHPiu+Qyvd6rpyj0Hk/3c7b+Cq5iq3vHgupSQWbtJYGG083N
         kbuw==
X-Gm-Message-State: AOAM531LFtdKU3R0MKvWPC+UWyZurZr3dH3YIjuNNee7xzmwfvtB4ZNx
        2LrQ/E+dKeeD2EA9PjdSOrBdVg==
X-Google-Smtp-Source: ABdhPJzoIJDh0x+aPCJvQ3KGczLpHsrN+drRAIc5AD4BKUwfO1ZvK1x/0gzZUZpOaaY3vYvOJ8Z3MA==
X-Received: by 2002:a17:90a:1d0a:: with SMTP id c10mr28899732pjd.142.1614061167210;
        Mon, 22 Feb 2021 22:19:27 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id n10sm20135169pgk.91.2021.02.22.22.19.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 22:19:26 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        soc@kernel.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 6/8] ARM: mstar: Add OPP table for infinity
Date:   Tue, 23 Feb 2021 15:18:28 +0900
Message-Id: <20210223061830.1913700-7-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210223061830.1913700-1-daniel@0x0f.com>
References: <20210223061830.1913700-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add an OPP table for the inifinity chips so
that cpu frequency scaling can happen.

Co-authored-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity.dtsi | 34 +++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity.dtsi b/arch/arm/boot/dts/mstar-infinity.dtsi
index 0bee517797f4..441a917b88ba 100644
--- a/arch/arm/boot/dts/mstar-infinity.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity.dtsi
@@ -8,6 +8,40 @@
 
 #include <dt-bindings/gpio/msc313-gpio.h>
 
+/ {
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-240000000 {
+			opp-hz = /bits/ 64 <240000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp-400000000 {
+			opp-hz = /bits/ 64 <400000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+		opp-600000000 {
+			opp-hz = /bits/ 64 <600000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+
+		opp-800000000 {
+			opp-hz = /bits/ 64 <800000000>;
+			opp-microvolt = <1000000>;
+			clock-latency-ns = <300000>;
+		};
+	};
+};
+
+&cpu0 {
+	operating-points-v2 = <&cpu0_opp_table>;
+};
+
 &imi {
 	reg = <0xa0000000 0x16000>;
 };
-- 
2.30.0.rc2

