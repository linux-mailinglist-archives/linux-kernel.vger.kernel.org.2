Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E5F3225E1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 07:28:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbhBWG0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 01:26:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhBWGV2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 01:21:28 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02799C061225
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:19:30 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id s23so1193507pji.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Feb 2021 22:19:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G4thmjduZ43HX5eyCNJENeVZMcyA8AVKFXPpIRfsEmo=;
        b=amHWH1xFUTFu36kpCUT4l9b90U0fBp3Q9fyx8iXV9r/xiRDq9pDWnJnL5GPlqLxbSj
         HR0yuPTyY+r+HwX+t5dEfOPeVRXaEaI3mggCZWThxuvElg0+eLqgqpVKAuTGcld4bc6X
         MHx5hnu+uT3f4oMN6r166FajTuyU6Mtf+FsqQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G4thmjduZ43HX5eyCNJENeVZMcyA8AVKFXPpIRfsEmo=;
        b=Dd0sbg0p/8U24BfmgzXSOveNTw0r2DgIA4IOSefG3UXHRm8OO1OjPDfsV/KYGv/TFl
         tlzCIf3Ey1Ofu0rSgvQ4F4Az1SjRY71X/FzbxKjgzOklGYM5OkRCgqM4oBiKmv6Ru+wI
         C6JMXB63Ipabekewzdbp+TeAxZcSBohyoZ4qrdn0erSvGG3Vb+AGm7g4RA1BsOmyHob1
         hxTeoQFhZGiEsLjJzckbMeeMc1y7oexHHzyqQ5y5ZSA0TzSEStD4uYFUehrmrlafojgk
         pX+vNq9GVgRI0SnWtLio7xBHiI5zqRpi+btVPHEI5Cgq2FxM36ezJ7XXhw3pA0gD4J1x
         YW1g==
X-Gm-Message-State: AOAM531uMH0bNijaEkP3iUn9S61mB4o7/Pc1W5ITcUb/J86M8RHsAodr
        9EbyVogbcahNz1JqRuRSGGFtLw==
X-Google-Smtp-Source: ABdhPJzKdWD/HPnom8Qx8jH6AAUN43gD8lpStgM44BbHKJBQkB14izYGXPrhe4CCETIu2OGeezBwGg==
X-Received: by 2002:a17:90a:7e94:: with SMTP id j20mr28131038pjl.218.1614061169617;
        Mon, 22 Feb 2021 22:19:29 -0800 (PST)
Received: from shiro.work (p345188-ipngn200408sizuokaden.shizuoka.ocn.ne.jp. [124.98.97.188])
        by smtp.googlemail.com with ESMTPSA id n10sm20135169pgk.91.2021.02.22.22.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 22:19:29 -0800 (PST)
From:   Daniel Palmer <daniel@0x0f.com>
To:     devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        soc@kernel.org, sboyd@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        w@1wt.eu, Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH 7/8] ARM: mstar: Add OPP table for infinity3
Date:   Tue, 23 Feb 2021 15:18:29 +0900
Message-Id: <20210223061830.1913700-8-daniel@0x0f.com>
X-Mailer: git-send-email 2.30.0.rc2
In-Reply-To: <20210223061830.1913700-1-daniel@0x0f.com>
References: <20210223061830.1913700-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The infinity3 has a slightly higher max frequency
compared to the infinity so extend the OPP table.

Co-authored-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-infinity3.dtsi | 58 ++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-infinity3.dtsi b/arch/arm/boot/dts/mstar-infinity3.dtsi
index 9857e2a9934d..a56cf29e5d82 100644
--- a/arch/arm/boot/dts/mstar-infinity3.dtsi
+++ b/arch/arm/boot/dts/mstar-infinity3.dtsi
@@ -6,6 +6,64 @@
 
 #include "mstar-infinity.dtsi"
 
+&cpu0_opp_table {
+	opp-1008000000 {
+		opp-hz = /bits/ 64 <1008000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+	};
+
+	// overclock frequencies below, shown to work fine up to 1.3 GHz
+	opp-108000000 {
+		opp-hz = /bits/ 64 <1080000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+		turbo-mode;
+	};
+
+	opp-1188000000 {
+		opp-hz = /bits/ 64 <1188000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+		turbo-mode;
+	};
+
+	opp-1296000000 {
+		opp-hz = /bits/ 64 <1296000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+		turbo-mode;
+	};
+
+	opp-1350000000 {
+		opp-hz = /bits/ 64 <1350000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+		turbo-mode;
+	};
+
+	opp-1404000000 {
+		opp-hz = /bits/ 64 <1404000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+		turbo-mode;
+	};
+
+	opp-1458000000 {
+		opp-hz = /bits/ 64 <1458000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+		turbo-mode;
+	};
+
+	opp-1512000000 {
+		opp-hz = /bits/ 64 <1512000000>;
+		opp-microvolt = <1000000>;
+		clock-latency-ns = <300000>;
+		turbo-mode;
+	};
+};
+
 &imi {
 	reg = <0xa0000000 0x20000>;
 };
-- 
2.30.0.rc2

