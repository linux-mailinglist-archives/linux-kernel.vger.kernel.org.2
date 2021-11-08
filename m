Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4CDD449E6B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 22:46:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240584AbhKHVte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 16:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbhKHVtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 16:49:33 -0500
Received: from hall.aurel32.net (hall.aurel32.net [IPv6:2001:bc8:30d7:100::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29D28C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 13:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=aurel32.net
        ; s=202004.hall; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:
        Subject:Cc:To:From:Content-Type:From:Reply-To:Subject:Content-ID:
        Content-Description:In-Reply-To:References:X-Debbugs-Cc;
        bh=N66F6Wqb9JBCWGaFILjT7qMKPk0Bi6BRFQXkrAP8YSU=; b=dwCrZp+TvheeFG0rOfKtj6Cgrj
        mpJOjbGl+DQxUnvjcW7D64bmBs7HfRok5/F0nnH+61uSek1zYGJzOUtA35/5zQSqMrwo2+x0zE8I6
        kBa4xQwRpWUdlqUxlhsNxt1M81AgQhbCcNM4anrMu7xZLn32L4XiH1hwB6XH1icPEZUgLKvMYtmVu
        qcVEH8tpQEk+PPvJqj3OLgdSfrear1yeN8TetRZYtyGW24zgS3wcP0E66HsLGIOGingiXAaeUNkXW
        ySi3Z+nukH43ot6dubY++UEXguubrlxjjtfaj7u3wNGCKVVO9RVJVgfRwHuilxK/bMjh1KpeZjNr+
        Nz/RfbQQ==;
Received: from [2a01:e34:ec5d:a741:8a4c:7c4e:dc4c:1787] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <aurelien@aurel32.net>)
        id 1mkCTT-0001NP-9d; Mon, 08 Nov 2021 22:46:43 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.94.2)
        (envelope-from <aurelien@aurel32.net>)
        id 1mkCTS-007GI8-IX; Mon, 08 Nov 2021 22:46:42 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     linux-kernel@vger.kernel.org
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Rob Herring <robh+dt@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-riscv@lists.infradead.org (open list:RISC-V ARCHITECTURE)
Subject: [PATCH] riscv: dts: enable more DA9063 functions for the SiFive HiFive Unmatched
Date:   Mon,  8 Nov 2021 22:46:29 +0100
Message-Id: <20211108214629.1730870-1-aurelien@aurel32.net>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The DA9063 PMIC found on the SiFive HiFive Unmatched also provides an
RTC, a watchdog and the power button input.

Signed-off-by: Aurelien Jarno <aurelien@aurel32.net>
---
 arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
index 2e4ea84f27e7..c357b48582f7 100644
--- a/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
+++ b/arch/riscv/boot/dts/sifive/hifive-unmatched-a00.dts
@@ -70,6 +70,10 @@ pmic@58 {
 		interrupts = <1 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 
+		onkey {
+			compatible = "dlg,da9063-onkey";
+		};
+
 		regulators {
 			vdd_bcore1: bcore1 {
 				regulator-min-microvolt = <900000>;
@@ -205,6 +209,14 @@ vdd_ldo11: ldo11 {
 				regulator-always-on;
 			};
 		};
+
+		rtc {
+			compatible = "dlg,da9063-rtc";
+		};
+
+		wdt {
+			compatible = "dlg,da9063-watchdog";
+		};
 	};
 };
 
-- 
2.30.2

