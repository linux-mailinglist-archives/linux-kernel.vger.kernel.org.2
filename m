Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 760CC453CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Nov 2021 00:57:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232032AbhKQAAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 19:00:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhKQAAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 19:00:45 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87573C061570;
        Tue, 16 Nov 2021 15:57:47 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id r132so566934pgr.9;
        Tue, 16 Nov 2021 15:57:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=OVuTAXKfST06LlKa+3lMZr3LwgCnmVMpB0im1jCL3Bc=;
        b=R0HeMjNP0oOGJit2TNJfMFN3aPrN1kb/JK9644Ic65UEfFRZsGsK27vd282geVOWWR
         8rMMFbhSbiwKLImoS0pmCSPUVPS3cQiz1Xm+I+jN7d2JUWRir8XzGHSci5G0DpQZwR3n
         GMFG8ocDfIR5V3PGgjJzPBNMVGeKzmFfKLRob3Y0tZTpt0WGLkf4IE7sqqc6m6+RSfKB
         DtGY2U7f6anDms43hsqdaE1rTLqodp0KXkto0tO2/18238ePV9eOIjxs9zP+/VX9/bqZ
         wOILzAbQx6dRbNTj6Su3pjRxZUVzdLZL+R3VCnTXnS9ecQZe7AvCY1RzRkPUzWp4alVq
         V/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OVuTAXKfST06LlKa+3lMZr3LwgCnmVMpB0im1jCL3Bc=;
        b=yQPN/+nNR2iyOMGuodmM2FTOzRlKn2oaG8B9ktmosApFEFrLldVT3R8+8wjR6zHtt0
         hw29U6fhXMj24djppF6dBODxuQc+kH2Wz5AM1AwfMq2YH9DXa3Qs/QCPdX9xXOevX2FK
         nt1hMCiKoktSBjufV1Qe+sfZjF3COEM9SvLiic/KASqIfFrzyyzEULXqJQRGAkJz/G4v
         W+YH78EUQzjhyaoU/pwSd/WXscsa2Ffv12IBGlH4A9trblykXq5ew5C3Lq76g12ezyiM
         3bCLpu2M8aaB3cnZF54R7udfMz9ZvpH8dxt2UsPisv6+BkJMDm7KBkuEZiHvI1n2LtY7
         2nxw==
X-Gm-Message-State: AOAM530Z9rgPijVPz8FZNXiFHn97M9A8VgOQZNdv9hsdoL1D8jxmuqQg
        SE9LP8KW72c/0se0enN7XkQ=
X-Google-Smtp-Source: ABdhPJwsRHRl1g6o/W4ZLU43Dsi9Xri70sEvBX9y2A2g4/QPkp4X8RIip5UKAvVk62VsVeP0+/K+pg==
X-Received: by 2002:a63:e614:: with SMTP id g20mr2120302pgh.159.1637107067072;
        Tue, 16 Nov 2021 15:57:47 -0800 (PST)
Received: from localhost.lan (p4899162-ipngn25301marunouchi.tokyo.ocn.ne.jp. [122.18.9.162])
        by smtp.gmail.com with ESMTPSA id t67sm717236pfd.24.2021.11.16.15.57.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Nov 2021 15:57:46 -0800 (PST)
Received: from x2.lan (localhost [127.0.0.1])
        by localhost.lan (Postfix) with ESMTPSA id B13E2900957;
        Tue, 16 Nov 2021 23:57:44 +0000 (GMT)
From:   Vincent Pelletier <plr.vincent@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Qiu Wenbo <qiuwenbo@kylinos.com.cn>,
        devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Abdurachmanov <david.abdurachmanov@sifive.com>
Subject: [PATCH v2 3/6] riscv: dts: sifive unmatched: Expose the PMIC sub-functions
Date:   Tue, 16 Nov 2021 23:57:39 +0000
Message-Id: <72d7baa6829ff02ee7ad0344fe1d33a2269780a6.1637107062.git.plr.vincent@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <bb7e8e36425a2c243cfbf03a23af525499268822.1637107062.git.plr.vincent@gmail.com>
References: <bb7e8e36425a2c243cfbf03a23af525499268822.1637107062.git.plr.vincent@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These sub-functions are available in the chip revision on this board, so
expose them.

Signed-off-by: Vincent Pelletier <plr.vincent@gmail.com>

--
Changes since v1:
- Remove trailing "." on subject line.
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index cf8937708829..270360b258b7 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -75,6 +75,18 @@ pmic@58 {
 		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 
+		onkey {
+			compatible = "dlg,da9063-onkey";
+		};
+
+		rtc {
+			compatible = "dlg,da9063-rtc";
+		};
+
+		wdt {
+			compatible = "dlg,da9063-watchdog";
+		};
+
 		regulators {
 			vdd_bcore1: bcore1 {
 				regulator-min-microvolt = <900000>;
-- 
2.33.1

