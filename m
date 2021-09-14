Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E41340A756
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 09:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240728AbhINH16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 03:27:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240218AbhINH1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 03:27:54 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7D37C061574;
        Tue, 14 Sep 2021 00:26:37 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id q26so18545936wrc.7;
        Tue, 14 Sep 2021 00:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nhy8sWoXjfZSgdBz+4DvtovrCyhceJaJe1SxiZwRYlI=;
        b=PG19ed3zT1U6GYaHDmoy6RQ1cLRFKwPTbadRPTwrE+cbu0O8VxRqblFlglu30u2iXu
         RQjH7Fvs66Hf4QKAXiwwIlTq8VAUlk9OjCcKvFMPmv1tsd1tzIxIDAKgsGb7rvoZsMBg
         BsXo6KtUnLOh97nGhJakDg2nfsX9SGpr3WWiq2dIc6NO8YTVx5TNirNuOHo36McKLHwz
         pvgsR5SRlaSI7pwLWLE/NfvZI9sTLU8uogk0hk2aB5YQ2khZtgSi3qvwH1R/7HtJUp4O
         nCetNJOUmeSI5oWxPpsrQ8dSaLCKM7H/W/I8rbtxv+GsVRaWTQCi3fb7+wIgAUaQ4pmT
         PN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Nhy8sWoXjfZSgdBz+4DvtovrCyhceJaJe1SxiZwRYlI=;
        b=xGwXxcjyOefj4O+04bV1TdG/VAvL0aKs4Zn21PYU8NYdrYdd7ryC7kjaaz/1t6IQcu
         OhmPo1vCm/qC7dAsZMzC9TAXGZ9OFNaoogEk5o2Wq8ivVpChAfRDcYcIi5ntBeb/yBYy
         9pz8frA9/54Rb3hlmhHAz3/tSJwde5HxueJllAhgHvFMFkVOvekewSWukHZwl2O2F1p8
         eLjX+7BFUK0StGRqDAhOMOvizRlaxWH7/91h3TvkbCtBmYyreNV4meHhrBiNNKvEDZp6
         X6L2l2Gu26rh+4Gtos4x56YvvTJ7cOSJYevKmrcvLf6dHkbhcKQeA2hQ6khL9KwFtrz6
         EXIw==
X-Gm-Message-State: AOAM530JRZmxAVjZgHQnc8UDjf98ZeRQlIA1Gc3b5gfm84kh2CD1XupD
        ErvVU1fhpw+RSdXlcs3gSX7h1Fnck97b6wJI
X-Google-Smtp-Source: ABdhPJy+pWTJNEI9mSSc6YvThPAheuCu9BMaZvqHeF9m0jHaYsiNYpEzeCNvIr2s9Fd9ByjMnIlrcA==
X-Received: by 2002:a5d:5042:: with SMTP id h2mr16712960wrt.57.1631604396255;
        Tue, 14 Sep 2021 00:26:36 -0700 (PDT)
Received: from hthiery.kontron.local ([213.135.10.150])
        by smtp.gmail.com with ESMTPSA id q11sm9037235wrn.65.2021.09.14.00.26.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 00:26:35 -0700 (PDT)
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
Subject: [PATCH v2] arm64: dts: imx8mq-kontron-pitx-imx8m: remove vqmmc-supply node
Date:   Tue, 14 Sep 2021 09:26:28 +0200
Message-Id: <20210914072627.24173-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sw4 output (V_1V8_S0 voltage) from the PMIC is the main supply for
the 1V8 power domain. It is not only used as supply for the eMMC.
So this voltage can not be changed and is not allowed to switched off.
Therefore we do not want to provide this regulator to the SDHC driver to
control this voltage.

Fixes: 5dbadc848259 ("arm64: dts: fsl: add support for Kontron pitx-imx8m board")
Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---

v2:
 - slightly reword the commit message (thanks Michael)
 - add Fixes tag (thanks Fabio)


 arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
index f593e4ff62e1..436d98135ba9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
@@ -348,7 +348,6 @@ &usdhc1 {
 	pinctrl-0 = <&pinctrl_usdhc1>;
 	pinctrl-1 = <&pinctrl_usdhc1_100mhz>;
 	pinctrl-2 = <&pinctrl_usdhc1_200mhz>;
-	vqmmc-supply = <&sw4_reg>;
 	bus-width = <8>;
 	non-removable;
 	no-sd;
-- 
2.30.0

