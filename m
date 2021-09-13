Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 104D1409CC5
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 21:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241301AbhIMTSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 15:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241298AbhIMTR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 15:17:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B668C061574;
        Mon, 13 Sep 2021 12:16:40 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l18-20020a05600c4f1200b002f8cf606262so170128wmq.1;
        Mon, 13 Sep 2021 12:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGP6w5BoosLgxABsa+U9w08nzy5En7qL5PIYU2nb6Sw=;
        b=GpLYqyFUjPuKNFrS2251Cs8CYSxV4lXggSaOUMLxhUa5Oa4iKnBIqR79l2agVpqHbg
         Wz1bqcTXb1seNxt/nNIcfo15U6685U8SFY0xo5fchoggQJ6qqNBeESp0w3qwVUbRrbch
         x0tm35bAvsw+aFq+BAcSVOSg3DK0IKGoHO3HftW/3LX1Hl1199YBuQYAZ46shS+uX1gC
         334VE7XZi/DA6vpGe7HV5HJF9L838b+NrXJHAZER0ZCyar7NKXP091EFfoBmxZGZsvHO
         kG/Oky5xNdsTjS22aOmxTx6XYL4MNM/LYmHIknjRtBwrhJEdpsju44e+bVPtMPDaKyJT
         yr5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FGP6w5BoosLgxABsa+U9w08nzy5En7qL5PIYU2nb6Sw=;
        b=jz2vL8Ds/dgUxNY2I94ndGiyAUUkcNmOUQltP5/20eG/i/MMUGxmxwR9IWmATwDmrK
         0B7CkVm7ojS+tUyf7PHQGAyB3wv80JbXDSjgLQF+Z6UuzeyZ7vgUXhDPGiPgCuMHM5oM
         TZepbI4aJZ6AF04TYU/BDCvYdX1uMZXSyYZuB3zEmQrRmBzJBKaiM6nrDlmzYKr+JGhm
         IJlK+pg9csVEvzrtwb1ogkqYmGTRmEONcdUxLNYEQKGPYhcf0dBjaQhQiij43LUL56zw
         1KeIN6p7TfeV9BSH8PgXTFNVlvllmLSWw3diNZ6rFqd42w1UfvRoxhaEQ4ipNKzwQpzw
         0TqQ==
X-Gm-Message-State: AOAM530OCKYmk/QXTfbT6lSxFMpNgjsRT5MFLIwh0V/AuzOjJiyTh0NS
        JEiMvHEwEdElFPJAY5jgO6qhiPrL7sZ1jG4D
X-Google-Smtp-Source: ABdhPJyJhbJXM0giaX6MfKzr6rE+lubAlnSraxoR2w1tNAQWyor9Q8GUgHX16RqOr11wX2Ii5KNQSw==
X-Received: by 2002:a1c:7d0f:: with SMTP id y15mr12207180wmc.41.1631560598628;
        Mon, 13 Sep 2021 12:16:38 -0700 (PDT)
Received: from t450s.fritz.box (ip5f5bdc1b.dynamic.kabel-deutschland.de. [95.91.220.27])
        by smtp.gmail.com with ESMTPSA id f3sm7465059wmj.28.2021.09.13.12.16.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 12:16:38 -0700 (PDT)
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
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH] arm64: dts: imx8mq-kontron-pitx-imx8m: remove vqmmc-supply node
Date:   Mon, 13 Sep 2021 21:16:27 +0200
Message-Id: <20210913191626.12726-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sw4 output (V_1V8_S0 voltage) from the PMIC is also used as supply
for the eMMC. This voltage can not be changed and is not allowed to
switched off. So we do not want to provide this regulator to the SDHC
driver to control this voltage.

Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
index f593e4ff62e1..436d98135ba9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
@@ -348,7 +348,6 @@
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	vqmmc-supply = <&sw4_reg>;
 	bus-width = <8>;
 	non-removable;
 	no-sd;
-- 
2.20.1

