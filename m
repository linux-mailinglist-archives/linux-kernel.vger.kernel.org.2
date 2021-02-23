Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC2D323153
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:22:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231942AbhBWTUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233722AbhBWTST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:18:19 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 338F1C061793;
        Tue, 23 Feb 2021 11:17:01 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id v62so3467771wmg.4;
        Tue, 23 Feb 2021 11:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J/d7eXIXEc8ncUi4hT4pKicKvH/fXC8il23pGXu/3fE=;
        b=IE4ptQy11MI9V7+ArISPVtEniE56yCKml7Ad8/UxMcBWL4GdxvcwDk4m11DlwrqrUu
         NLYY51qMKOIyRLVZu4vHxbB1aHlKbwFdON0gNGPTjclgbEtFysjcgOfhgM2zQ+hi4wLh
         XnFgtrm8v8iueZ9zTjtdPVK8Bmr4cPis7Yebc9iXiQNNY1/NS736OJn6n6EUPGiDZCxq
         rLd+6DplFf/qxc4jopYZ8Ai9R3WGjZrGrq2Px6n6T0ywAH3HBlpznfvV/IuE0QEmuaz2
         /L+4q61EP+y5tA4Vo5HbD41grhuOzdDt650Zz79XH1H8pTlA4O7YXGR0frJOzgqDWQCv
         4GVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J/d7eXIXEc8ncUi4hT4pKicKvH/fXC8il23pGXu/3fE=;
        b=slBN4Ji4cwEXAmkU3dASTC20hfa2crsgtnmOsXoX7TCHfTfeMVrv3IozdjqnwJP+r4
         JCaopJoS44Tt0c4of9iv1MrqFpzgka2XgN9iNU6oZe9ZsNEq0s1lgOi/LHajZQTOD6vP
         AkAF+vbuMTjfZe8VMSUhvmQdkIaVpFTqqa8Q+fRDR1yLiGoPTPVvuVTSU4y+TXw+n2mC
         aWhdQMG8i5YcTtF5sFez2VUNOSBeCxGV85bh1x+JKezDo+z4HTenCfnZPo0Pt4YZlSQJ
         7wQAV1RmLQMsbOH+VJkTivi/1A3iweA/xj1EcmBSnguvVxrXlXxIucVvzbXTOaTjjXgv
         tYJA==
X-Gm-Message-State: AOAM53308kTk3ODCNuU8INI5cIWSFOFeu07PspydXKJhCuhv/eO3ItTB
        9z7VEufH/fV8KBk5pO0uUlU=
X-Google-Smtp-Source: ABdhPJxfKRX0BAbItUlNIRqrZWVYpyKdeY2s8XrE3u2cN3naJTXmaItasf2oudF+DgDT0q/2YcuyrQ==
X-Received: by 2002:a1c:f417:: with SMTP id z23mr234761wma.29.1614107819962;
        Tue, 23 Feb 2021 11:16:59 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270084c09ff22cc10cb2.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:84c0:9ff2:2cc1:cb2])
        by smtp.gmail.com with ESMTPSA id a21sm3611413wmb.5.2021.02.23.11.16.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:16:59 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 06/10] arm64: dts: imx8mm-nitrogen-r2: rework UART 2
Date:   Tue, 23 Feb 2021 20:16:48 +0100
Message-Id: <20210223191652.436397-6-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223191652.436397-1-adrien.grassein@gmail.com>
References: <20210223191652.436397-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove useless clocks in UART 2

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 1b16d09fa887..e44c5963040d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -223,8 +223,6 @@ &uart1 {
 &uart2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart2>;
-	assigned-clocks = <&clk IMX8MM_CLK_UART2>;
-	assigned-clock-parents = <&clk IMX8MM_CLK_24M>;
 	status = "okay";
 };
 
-- 
2.25.1

