Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42BB540C4E0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbhIOMFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbhIOMFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:05:10 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F45C061793;
        Wed, 15 Sep 2021 05:03:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id z184-20020a1c7ec1000000b003065f0bc631so4639856wmc.0;
        Wed, 15 Sep 2021 05:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1v2Wz7r3SRYsAbKV8aTYHRg0UikNp3UThAxS/q0C7w0=;
        b=pJcFYnCZ8mO09t/6PwPkutiVf+XGgNkmftb1IuFOZXt0/x8j+s+H4eR/7UzdUyAM7C
         khmxYCeBsk4uAVQx1i5PBYDwZDOe1u4KMw7JhoEhPakkRCo07QdtkH78Av2fCGSCH23k
         3tzcnXxsXbOmAA+3woN6NKipC2prvgM5pg2d5oNyapMVCSG76VHvDSlU3Ix092eObs/m
         tIvMspswgtt18S75p/g/AFfAvzdUNtgTU0b5waeZvuFG94lnkhM70LxRHlieept0Wtwv
         v3g441vIHUDTNNB7NdeljkjO2Hf05FLuZ2v7ZA9FeT3bISHeLqTis7rkzi3f6p+yHoUP
         g8RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1v2Wz7r3SRYsAbKV8aTYHRg0UikNp3UThAxS/q0C7w0=;
        b=L6gN/BGDlySFbELRW0q8qEPOtKgT27PpEm3RPcHidfjZVpY50fqGt2JY085DBllerk
         32PNUULtuGt2e51LI145U3sEYb9/frhmwKiQQ4r+jbc3waY5JmL4wOJ3Op6o6jRf+iAj
         EEAmm8acmI8ECgUfIe0Gs2dm6ZVEoHg3hwyj2tEApA15annxm2BDmO9eJKbPJ42j98MC
         uf1W2dEE7CvhAiq7CVJnc8VN5r4SFVLPeT1i8M/RCBIY4EHnIITi32K13fJc7Gle0txT
         B27JREWmq0V2AkVX/NJnU5M6cVZDcC7lTPSMIANltH5DSzfBd1SlPk+wPIYWDg3bM3H9
         18Rg==
X-Gm-Message-State: AOAM532WxVPZUuEKYw7VN21/hT4uH6qgBTQbA4ypDG1nDBYLZC0zSnBL
        6Z8crsE/hK9eXepG17NGkPJTUeeD4vav0y/C
X-Google-Smtp-Source: ABdhPJzj+iZK8kf6OaDYgEGXfwizWgHXHzrMImbX/tAurZLPWH3d0i0/2suPJkytb2HGqkkfixSqyw==
X-Received: by 2002:a05:600c:35c4:: with SMTP id r4mr4201100wmq.194.1631707417203;
        Wed, 15 Sep 2021 05:03:37 -0700 (PDT)
Received: from hthiery.kontron.local ([213.135.10.150])
        by smtp.gmail.com with ESMTPSA id p21sm4255497wmi.30.2021.09.15.05.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:03:36 -0700 (PDT)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>
Subject: [PATCH] arm64: dts: imx8mm-kontron-n801x-som: do not allow to switch off buck2
Date:   Wed, 15 Sep 2021 14:03:26 +0200
Message-Id: <20210915120325.20248-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The buck2 output of the PMIC is the VDD core voltage of the cpu.
Switching off this will poweroff the CPU. Add the 'regulator-always-on'
property to avoid this.

Fixes: 8668d8b2e67f ("arm64: dts: Add the Kontron i.MX8M Mini SoMs and baseboards")
Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
index d0456daefda8..9db9b90bf2bc 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-kontron-n801x-som.dtsi
@@ -102,6 +102,7 @@ reg_vdd_arm: BUCK2 {
 				regulator-min-microvolt = <850000>;
 				regulator-max-microvolt = <950000>;
 				regulator-boot-on;
+				regulator-always-on;
 				regulator-ramp-delay = <3125>;
 				nxp,dvs-run-voltage = <950000>;
 				nxp,dvs-standby-voltage = <850000>;
-- 
2.30.0

