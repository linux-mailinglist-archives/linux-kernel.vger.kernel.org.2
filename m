Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D28A6323141
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 20:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhBWTSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 14:18:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230371AbhBWTRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 14:17:39 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E658C061786;
        Tue, 23 Feb 2021 11:16:59 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id l12so23702342wry.2;
        Tue, 23 Feb 2021 11:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZkbaIDWZRUYWSVfBQBD2rtNcOFSNf3jHCxMDgA44aTQ=;
        b=emnBhwCucUH5MDxw9kqXSK4fLMFOVeF5LQyyP2ueN9l6C3GT2Jb832ESekExpD2ulB
         bz3vrYM0CMHv+I+uADL9EtSJh+YKqeHtEfRa5QtklRWw+hmNQ9G8/wPXTo+zowhtragZ
         dVpetzAhz+T5O7atjS1t2i8cYCxoIwppBV0HUDiY+1Z9uee8hgP73kqWUz8o2a7MXWbF
         vFeeSvnzGxvYVxmAQaTpkcAnD3DvwNHqG+KTo1/KR6pmH6QBVMnf37llXlH57oc6RMul
         CHREALbvOYI4y7gjpLzC5OzrzIXMv1aJcLG9zLRhEwnluJmHPF9zzs2lxb5wYPfVCcvy
         aPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZkbaIDWZRUYWSVfBQBD2rtNcOFSNf3jHCxMDgA44aTQ=;
        b=iWRJevME6JJrpJvW/79TsNfNv3gJ6J2lxo/Io3HloiQksF3SFWb9CDSBiZtoTQRRBS
         HJiyGPW7p12Npt2fM8EjKqsOR+5XMWO/+GRlQHnYoeGST5VF+Z5SCJvac8+ReNpg7brs
         IgaxAEE6aqNhHVlEodLF+O6FP7nlqMqyfYq6v74sSAOYtdh+dVcWNvu1C52fz3uZ3v1Z
         ITsfagOczzTYHHQhBwOB2VC4gJ6ThMYqJW6gqeAVGKgdD0IdC1MStqCWH/akwSnZVUvI
         uw4witN/cAj3F40GqPXX+olhH5M603XvueV+TeXGNd2eLjNWbFibVHAUsRHdv+rc40Hz
         RGwA==
X-Gm-Message-State: AOAM531FK5txGDhDruYbPe9g0ftPYeMo18Qem34/smQeBN9FoBzgc8nR
        ICSFu5IGL05v7u07SpprzAY=
X-Google-Smtp-Source: ABdhPJwCPQ4imOqHhAHWFS5QeGCu5mLFF86Ko5oqsIvSnitogrPSnhkMheEdbyCXl03atS/kwe1opw==
X-Received: by 2002:a5d:6b45:: with SMTP id x5mr27019874wrw.415.1614107818048;
        Tue, 23 Feb 2021 11:16:58 -0800 (PST)
Received: from localhost.localdomain (2a01cb0008bd270084c09ff22cc10cb2.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:84c0:9ff2:2cc1:cb2])
        by smtp.gmail.com with ESMTPSA id a21sm3611413wmb.5.2021.02.23.11.16.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 11:16:57 -0800 (PST)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     krzk@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, catalin.marinas@arm.com, will@kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v4 02/10] arm64: dts: imx8mm-nitrogen-r2: rework USDHC1
Date:   Tue, 23 Feb 2021 20:16:45 +0100
Message-Id: <20210223191652.436397-3-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210223191652.436397-1-adrien.grassein@gmail.com>
References: <20210223191652.436397-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add VMMC and VQMMC description for USDHC1 (eMMC).
There are comming directly from the alimentation
stage, so add the vref_3V3 fixed regulator.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
index 4a3dabeb8c85..217ac8c53702 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-nitrogen-r2.dts
@@ -17,6 +17,13 @@ reg_vref_1v8: regulator-vref-1v8 {
 		regulator-max-microvolt = <1800000>;
 	};
 
+	reg_vref_3v3: regulator-vref-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "vref-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+	};
+
 	reg_wlan_vmmc: regulator-wlan-vmmc {
 		compatible = "regulator-fixed";
 		pinctrl-names = "default";
@@ -209,6 +216,8 @@ &usdhc1 {
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
+	vmmc-supply = <&reg_vref_3v3>;
+	vqmmc-supply = <&reg_vref_1v8>;
 	status = "okay";
 };
 
-- 
2.25.1

