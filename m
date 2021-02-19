Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2062B31FAFE
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Feb 2021 15:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230145AbhBSOfj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Feb 2021 09:35:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbhBSOdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Feb 2021 09:33:31 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF23BC061794;
        Fri, 19 Feb 2021 06:30:41 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t15so8741345wrx.13;
        Fri, 19 Feb 2021 06:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PmMIZkS+PT2xN55/r3OOHdDRLyKVZ3DVfYmTr1HQ6/4=;
        b=iqm8x6MCaAXDkCRcCU0XMH7lpC48kMIkLqhQM/wPqgPUvBtuoAGn80FwHokvKwCAq/
         B8LO6zMZCvTIIwoNCU6h6O/R34XVkC4kxssLJPOnERe1ik0eklybHAV+bAhyu2JY5JtC
         +PeSolYCx0Z2POvTvU70QfOO69DGvebH7kVj+OViTJTzTRZDHIpHUljQHk76DaUGfLds
         AjAp6kbDG5SsJcYQwyr55H/n9aSObHW1FV0nPFwMfVFla5AvwOp+onfHxcEcVC/Yc9is
         ElEV9pCxzE+qrkTzTkl+C6C6m+oQ/KKMFsWO8m83M/X8KD6MJOYhHT+1R5JFTgZYChJC
         xryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PmMIZkS+PT2xN55/r3OOHdDRLyKVZ3DVfYmTr1HQ6/4=;
        b=VuaPUqOo3bOL9RhBWPsjurJxsk1xxTjGdmeHLxKsJ+dQ+YR3Buq4zIadebUFsJEIQM
         LAvbmWQ9VNXalGe+I30cRIiGbPY8tKZrrnBpNBWGWTRco1VYGY8xmVCRo6VbJzec/FBx
         pdIRRKUz8v3bAHyR4b7ebkZkUOVl/1RiqH4ROIxUFbTGes0PdBfFf9dj4gEEbolZ1p7W
         JLF4hS5G12DHcbtXKAuyHnxVgwn8JCEl7/Q4qZ4401JORla2xJKTK3B1TSPbiL88zmEB
         /XwUZV9NnsKetxafaa3buVSwuR4gBJY6oiI7wfaj4xt4GxR3NoIb1Cqe//0E9SCH128p
         PwPg==
X-Gm-Message-State: AOAM530OYDS+XsDpzQcZfWx7yfNUqtzNS16aUo2SkQl3oo2yeiVASsT3
        NoIFahDMESeCq+T3tq4taXM=
X-Google-Smtp-Source: ABdhPJwbxQV1hYr4zE1n45zsh8w8sqMa5Ay7WBxmdXs71Ies0H14/ED98vKPrFJC/YbNStZKjoVNHQ==
X-Received: by 2002:a05:6000:146:: with SMTP id r6mr9228419wrx.239.1613745040661;
        Fri, 19 Feb 2021 06:30:40 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd27003cf54d240f3b36ef.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:3cf5:4d24:f3b:36ef])
        by smtp.gmail.com with ESMTPSA id v9sm8348215wrn.86.2021.02.19.06.30.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Feb 2021 06:30:40 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v3 7/9] arm64: dts: imx8mm-nitrogen-r2: add FlexSPI
Date:   Fri, 19 Feb 2021 15:30:26 +0100
Message-Id: <20210219143028.207975-8-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210219143028.207975-1-adrien.grassein@gmail.com>
References: <20210219143028.207975-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add FlexSPI description an pin muxing.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 .../boot/dts/freescale/imx8mm-nitrogen-r2.dts   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 9a210ca63731..0fd8e2a54073 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -78,6 +78,12 @@ ethphy0: ethernet-phy@4 {
 	};
 };
 
+&flexspi {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_flexspi>;
+	status = "okay";
+};
+
 &i2c1 {
 	clock-frequency = <100000>;
 	pinctrl-names = "default";
@@ -367,6 +373,17 @@ MX8MM_IOMUXC_NAND_READY_B_GPIO3_IO16		0x159
 		>;
 	};
 
+	pinctrl_flexspi: flexspigrp {
+		fsl,pins = <
+			MX8MM_IOMUXC_NAND_ALE_QSPI_A_SCLK	0x1c2
+			MX8MM_IOMUXC_NAND_CE0_B_QSPI_A_SS0_B	0x82
+			MX8MM_IOMUXC_NAND_DATA00_QSPI_A_DATA0	0x82
+			MX8MM_IOMUXC_NAND_DATA01_QSPI_A_DATA1	0x82
+			MX8MM_IOMUXC_NAND_DATA02_QSPI_A_DATA2	0x82
+			MX8MM_IOMUXC_NAND_DATA03_QSPI_A_DATA3	0x82
+		>;
+	};
+
 	pinctrl_hog: hoggrp {
 		fsl,pins = <
 			MX8MM_IOMUXC_GPIO1_IO03_GPIO1_IO3 0x09
-- 
2.25.1

