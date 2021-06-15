Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C76A3A8602
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 18:04:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231783AbhFOQF5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 12:05:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231657AbhFOQFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 12:05:50 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 687A9C061574
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:03:45 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id i13so51872102edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 09:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jATvgsyjbjceyrk+GBlriKazySRs/GnMPU1wY1FrMxc=;
        b=bRjftlF1KH3Qf7vluE8mcq94YTQQsSdT+NNa4G6UIFaOc+t7Z8AhxerVKlAfdFn6JL
         P8DYpM5QIqe5QRqupmzMnQw1GKkmCsTEd41bOUflKXB1Tt7+WVOtyRoGq27ista5h7br
         a01euiqXr1kiiQNLKvhZLo5c4TgYbplcWxbc770tc2UU4i9iBzb+A6zR/BkxySbQWCO+
         I6Mn/gEWu1daF7bXCz+ayOpF1Q/2GEPzCxbff5YgahqTx5hTsGK0RHA4E3k5HWV6IOKD
         NGhdhJLlAFVKtUrO7+MSDf/T6KDk0kdfx474X0f46Qr++DE8RHl9JUcuFEZSJ3EPdhq9
         34GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jATvgsyjbjceyrk+GBlriKazySRs/GnMPU1wY1FrMxc=;
        b=Srns1N/i6IdkxG0Be6QK7OEMT/omAIeF3VFFFKvcrSconuPZ1LpwScckljmTwMxPdi
         C2rMIO03rRrc0pCxANGWxegNUmfmxb0jTWaDQEQrMHAZlXxcqxXnsTPIa6SaVverp5yL
         wKYop4d9OG4Uwdvo0TAUQEMd1K6O0/EGnixWsChplAAPhbvDCxN582ws8A/jxjGuqhd/
         C+HkdCVmNF2/azE+6XZSMEawdtml8pHvmtFIrrqxLJVo/cMslssVrLVIDBiF3SsAQrNL
         /+EWj0Zg1080lOiLSOZAGD3mPe4cPic4xlzSGvJphAQOjZ/TPGlK8k7xkairS5YH24+A
         8G9A==
X-Gm-Message-State: AOAM531r4ooBCjb6EnydBzApOfWZEWd6wNB39gLZYjmxsUB0LHW7adl6
        H+LgJurLW8UyHVLbG7J5My4=
X-Google-Smtp-Source: ABdhPJzm/yP5KvqDx7Z+PdOI9aLGuAf0o0swGNa0VlH0BzL/Upo9HKLTdyQrYcy3k3FFbjsYbS7HUw==
X-Received: by 2002:a50:eb92:: with SMTP id y18mr138663edr.249.1623773024056;
        Tue, 15 Jun 2021 09:03:44 -0700 (PDT)
Received: from yoga-910.localhost ([188.26.224.68])
        by smtp.gmail.com with ESMTPSA id b1sm1640061ejz.54.2021.06.15.09.03.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 09:03:43 -0700 (PDT)
From:   Ioana Ciornei <ciorneiioana@gmail.com>
To:     shawnguo@kernel.org
Cc:     leoyang.li@nxp.com, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH 3/3] arm64: dts: ls1088ardb: update PHY nodes with IRQ information
Date:   Tue, 15 Jun 2021 19:03:37 +0300
Message-Id: <20210615160337.1320644-4-ciorneiioana@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615160337.1320644-1-ciorneiioana@gmail.com>
References: <20210615160337.1320644-1-ciorneiioana@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Describe the IRQs for both the QSGMII PHYs and the 10GBASE-R PHY found
on the LS1088ARDB board.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
index bf7b43ab1293..1bfbce69cc8b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-rdb.dts
@@ -83,34 +83,42 @@ &emdio1 {
 	status = "okay";
 
 	mdio1_phy5: ethernet-phy@c {
+		interrupts-extended = <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0xc>;
 	};
 
 	mdio1_phy6: ethernet-phy@d {
+		interrupts-extended = <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0xd>;
 	};
 
 	mdio1_phy7: ethernet-phy@e {
+		interrupts-extended = <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0xe>;
 	};
 
 	mdio1_phy8: ethernet-phy@f {
+		interrupts-extended = <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0xf>;
 	};
 
 	mdio1_phy1: ethernet-phy@1c {
+		interrupts-extended = <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x1c>;
 	};
 
 	mdio1_phy2: ethernet-phy@1d {
+		interrupts-extended = <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x1d>;
 	};
 
 	mdio1_phy3: ethernet-phy@1e {
+		interrupts-extended = <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x1e>;
 	};
 
 	mdio1_phy4: ethernet-phy@1f {
+		interrupts-extended = <&extirq 1 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x1f>;
 	};
 };
@@ -120,6 +128,7 @@ &emdio2 {
 
 	mdio2_aquantia_phy: ethernet-phy@0 {
 		compatible = "ethernet-phy-ieee802.3-c45";
+		interrupts-extended = <&extirq 2 IRQ_TYPE_LEVEL_LOW>;
 		reg = <0x0>;
 	};
 };
-- 
2.31.1

