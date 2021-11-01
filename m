Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 253A544236E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Nov 2021 23:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232353AbhKAWbh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Nov 2021 18:31:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230167AbhKAWbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Nov 2021 18:31:36 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 567E1C061714;
        Mon,  1 Nov 2021 15:29:02 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id w1so15302484edd.10;
        Mon, 01 Nov 2021 15:29:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SL/dUv9NeV5l6fj8QBhu4yVmqmYR87PTtYyOH7UVUlQ=;
        b=ZGmaJw5uBiWyA0084+vSVCrlqA10cIe/GdXRhpeNExvDrjTipfz7P9KUMVn+yNQigY
         WXw1xwI1k4ZHdiJASwwomyraKXRc8/t3DStAgpxntoMjAtiBLd0ViJbjZH4Se9uq4hl9
         tzlBqSvRdoZRLDAZfIZ/ByD1bFAfZRbKItL7YyWZsYsoIV17lqC1W0WKBTG352VbJlW4
         RZKfFqA7LS2NA7gYiJLgbyt01t/PDyZNmYf8PqQ5bkmKDamB45J3Q8f6nMFNywJuIQeJ
         1Nn+d8DAiYzgIF+t/nVTpa+OCyVMtQVU1pA8BqCIwIx7t6/M26q6WauhPzyGF/n6MHGO
         1B+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SL/dUv9NeV5l6fj8QBhu4yVmqmYR87PTtYyOH7UVUlQ=;
        b=ovS7fClVbnptWFexBCEiGxDOhGJjVkQeSUa2GUj1C5+8wP8aNeSpFsGIwJ3xw2mWjd
         z80PSyIjS3UMYaV+RhTP9UxZ+Ts9HhEG3so3D3sE9hwnfi13aErNOgMqtv8qgJ3ajn6w
         UsZUZuYUkLeFkoKU/mFHcXALdGh0Lkkm/SJaDJd4q4e5ZytscnbMLb6wHZKAJ8SiAgx4
         mb28cP+sTehrEuzaFAQq+YmZuUeka3HvRhrZQAHHuiaCnS9Guy42Ln8pZ/2Mfitz3bHr
         FcZnw+NPBdGdoy1A329ioxZ3QgmcOjHuSoJEqftHqa0+BqTxzONZKPCs/TKGiUL661dX
         2UYg==
X-Gm-Message-State: AOAM532YXiOCJ8kE0IxwM/zKfIiS/Ze50bjI5iW2OLcq4up3R/dAL2Ii
        Gb+nCHNhNLNmNkvkXX+avLw=
X-Google-Smtp-Source: ABdhPJyr8rTDPGuD0RPW+QinoxB9FvG8wlApebXWSRd1WYp9AQ5LoaB81Ea7Nn9myVtaQ9MfXBTgzg==
X-Received: by 2002:a05:6402:274c:: with SMTP id z12mr12405523edd.151.1635805741014;
        Mon, 01 Nov 2021 15:29:01 -0700 (PDT)
Received: from tom-desktop.station (net-188-153-110-208.cust.vodafonedsl.it. [188.153.110.208])
        by smtp.gmail.com with ESMTPSA id w3sm9780294edj.63.2021.11.01.15.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 15:29:00 -0700 (PDT)
From:   Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     tomm.merciai@gmail.com, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alice Guo <alice.guo@nxp.com>, Adam Ford <aford173@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8m: add syscon node for display_blk_ctrl module regs
Date:   Mon,  1 Nov 2021 23:28:55 +0100
Message-Id: <20211101222857.6940-1-tomm.merciai@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add system controller node for registers of module Display Block Control
(DISPLAY_BLK_CTRL, base address: 0x32e28000).
The DISPLAY_BLK_CTRL module contains general purpose registers (GPRs),
which control varied features of the associated peripherals.
Reference: IMX8MMRM Rev. 3, 11/2020, p 3897
---
 arch/arm64/boot/dts/freescale/imx8mm.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 2f632e8ca388..3e496b457e1a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -961,6 +961,11 @@ aips4: bus@32c00000 {
 			#size-cells = <1>;
 			ranges = <0x32c00000 0x32c00000 0x400000>;
 
+			dispmix_gpr: display-gpr@32e28000 {
+				compatible = "fsl, imx8mm-iomuxc-gpr", "syscon";
+				reg = <0x32e28000 0x100>;
+			};
+
 			usbotg1: usb@32e40000 {
 				compatible = "fsl,imx8mm-usb", "fsl,imx7d-usb";
 				reg = <0x32e40000 0x200>;
-- 
2.25.1

