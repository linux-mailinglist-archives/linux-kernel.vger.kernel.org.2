Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16D40411531
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 15:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhITNEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 09:04:32 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:33248
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233205AbhITNEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 09:04:31 -0400
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com [209.85.221.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 404E23F226
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1632142984;
        bh=UfizrBJBT6h793qifWAMSREo4JNWpi+qoZht6aRmJGE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=h7msZLgID9c4U+hUwUlpY1qofWMd6qzPkpr1HLDN3FNyxY1ht5a+dr9FbUYWzr+cy
         YHVy01Lg8478g8wlAwOUu/K90BgaY3TZ+AANtsP53s1sQDKIsqsTpCbk7F2moJZiPR
         373Ku7AOhbperXQwXktKO8ZDzUB2uGwp1ZTGd2Zz6FuZ0khnyPoI6YS+P8dlNWKpww
         Ccx5X1C9+xM5YBbgQhml2+YTODtKDDTeZJrLQu0lM6Rw/CulIWzs+6AgC+VHPbrOmn
         Wh/ev8PeB4j51OJgbRtrewhFX8/RBappV4YO35E9sU/foA55EXzwpef4epvJOih3tj
         pGNKLOMH3MonA==
Received: by mail-wr1-f72.google.com with SMTP id i16-20020adfded0000000b001572ebd528eso6007394wrn.19
        for <linux-kernel@vger.kernel.org>; Mon, 20 Sep 2021 06:03:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UfizrBJBT6h793qifWAMSREo4JNWpi+qoZht6aRmJGE=;
        b=GVtLP/v75iayJKTEEDNLbGJwfjN0BWIpgCT3utOmNB7WldcLpxZV+PL/LEjj8vnGP1
         kVvISMAwZv1odTDURzCnENRwwYUflwUyfJ1yohhLmrOzaAgyfsNXMy3KC624T4u9BKni
         I0io8nzq/vAN+q+1oC2HMNIvLfFuNEogg4770k47tLfbd8R7dTxSAyQBjcMomaFuu2/h
         noh515G89GLXP4qHXkLssQhlyHYYBLJOM+CwJuLBm7L5A91qWCC+6Zbs5ghCRb8zLDq1
         FiMlPObo1Y2yFscCuqKc3uy9BL1Ay3K1RwApCFUvlKwLIffcFaG6yM6qwXWUcbymfiA5
         zr/Q==
X-Gm-Message-State: AOAM533W4Ab+WFXOaXoRsLLHTyI2mFUyxNA3yxjtIiEYVAPVg13wyJW3
        KARR3QDTVNA0By+aTXcngc/XY27W3+oGk6mWTiSi4IVo1QwsB3EH+QsO11Q9Hpaqbecfzb4EVIP
        1Vh+EWmFuEezm4lerZOhnGRgO6SlwsBPGKhHLKLKX6g==
X-Received: by 2002:a1c:228b:: with SMTP id i133mr29327834wmi.179.1632142982421;
        Mon, 20 Sep 2021 06:03:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/BB9e96BfKaLLJbiEnOqtb29yH57oOh/zntshgoog9DQ8mK0SbPb2pcaq0hwTZ3DzpPLfZA==
X-Received: by 2002:a1c:228b:: with SMTP id i133mr29327794wmi.179.1632142982023;
        Mon, 20 Sep 2021 06:03:02 -0700 (PDT)
Received: from kozik-lap.lan (lk.84.20.244.219.dc.cable.static.lj-kabel.net. [84.20.244.219])
        by smtp.gmail.com with ESMTPSA id g22sm18015331wmp.39.2021.09.20.06.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 06:03:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RESEND PATCH v2 3/5] riscv: dts: sifive: drop duplicated nodes and properties in sifive
Date:   Mon, 20 Sep 2021 15:02:46 +0200
Message-Id: <20210920130248.145058-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com>
References: <20210920130248.145058-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DTSI file defines soc node and address/size cells, so there is no
point in duplicating it in DTS file.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>

---

Changes since v1:
1. None
---
 arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts | 5 -----
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
index 2b4af7b4cc2f..ba304d4c455c 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unleashed-a00.dts
@@ -8,8 +8,6 @@
 #define RTCCLK_FREQ		1000000
 
 / {
-	#address-cells = <2>;
-	#size-cells = <2>;
 	model = "SiFive HiFive Unleashed A00";
 	compatible = "sifive,hifive-unleashed-a00", "sifive,fu540-c000",
 		     "sifive,fu540";
@@ -27,9 +25,6 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x2 0x00000000>;
 	};
 
-	soc {
-	};
-
 	hfclk: hfclk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 9b0b9b85040e..4f66919215f6 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -8,8 +8,6 @@
 #define RTCCLK_FREQ		1000000
 
 / {
-	#address-cells = <2>;
-	#size-cells = <2>;
 	model = "SiFive HiFive Unmatched A00";
 	compatible = "sifive,hifive-unmatched-a00", "sifive,fu740-c000",
 		     "sifive,fu740";
@@ -27,9 +25,6 @@ memory@80000000 {
 		reg = <0x0 0x80000000 0x4 0x00000000>;
 	};
 
-	soc {
-	};
-
 	hfclk: hfclk {
 		#clock-cells = <0>;
 		compatible = "fixed-clock";
-- 
2.30.2

