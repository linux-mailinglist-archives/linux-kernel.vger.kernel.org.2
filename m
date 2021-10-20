Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D93954344D7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 07:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229839AbhJTFvH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 01:51:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbhJTFvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 01:51:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A11C06161C;
        Tue, 19 Oct 2021 22:48:50 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id i20so21422526edj.10;
        Tue, 19 Oct 2021 22:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TGqtnb1rSlFIJCcakP0JPmdnWPSfi8jo7otyHB8m/lY=;
        b=d5WaBpeDRvEkjEK5jDYeUgJklVZA7TCiDf0lhH0gByPnfiIMMsiupPpzuya2YrzXDi
         sj31v+FxXomHqeJ1iRb6JaN7CkYMgmsCdinsTHl5Z1oqM57TS3ud/NCpLoZgTTr7SoGP
         WwCbf8fEXwJAHR7aAqnyTgjMbR7XAOfzoq79VQJf4jq2IeQkXJoNnNzt31AFxXfT1Adf
         y9ZdDNoKdH90g1IyJDp3+lr6CFZyTanc4s4cRV/S+T5gUKhbaQwz0bPGChSvbRXoUt5K
         DB3C9r4i/2sDQakh/Z+7VtDqn2UHERwEXB4qEqusm/b4lirGxhoNXDiL6YM6g1eJaxPE
         bMqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TGqtnb1rSlFIJCcakP0JPmdnWPSfi8jo7otyHB8m/lY=;
        b=ijaOrqRPr5dENjafLfWmmTGbqj++f5DzwrNqO5ckmcf3XCWTmVhUVZNttW3PWWgtrV
         yM9QDdoW87F+4FbXriy7dfDlNlKYLzQtlq/O+Z8SI4WDv2bfs6mqfvt3rvnwtg7qkHhY
         lt/EIBvcY0N14/Yv8o5x4cWC70jBAn/l2JrohXaGVapMx1EHFSN5MnUjH4xxVCepPxuB
         aRu32k/q2h59apnmr1f76qJFH2mMr8cmRGnPDlauYgcP4oFMbxL+Lxt8aVqeCeUX+CrY
         Lxls6rT/z9diomuNSCHh12GrsplScLDsGOwWvBrIXAA/dQY/xBDujzd6373HcBOSvGnx
         zGNA==
X-Gm-Message-State: AOAM533eBq517PNnJ9fo0uSEaKxS/mWAT0eoYBa8t3q+87fKnzOgUU/4
        HSY3vDdf0wjT+I4xtttQM3265W/8e/kGkg==
X-Google-Smtp-Source: ABdhPJwZEJPm7EKdKVuqI5XFM8S9twdpozy1WLH8/rscgNp3FQBNqoQvOPQLtYabK8pAKy/HOu/i/A==
X-Received: by 2002:a17:906:48ce:: with SMTP id d14mr44866967ejt.336.1634708929325;
        Tue, 19 Oct 2021 22:48:49 -0700 (PDT)
Received: from hthiery.kontron.local ([213.135.10.150])
        by smtp.gmail.com with ESMTPSA id s24sm434620ejm.87.2021.10.19.22.48.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 22:48:48 -0700 (PDT)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Heiko Thiery <heiko.thiery@gmail.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        Michael Walle <michael@walle.cc>
Subject: [PATCH] arm64: dts: fsl: imx8mq-kontron-pitx-imx8m: get rid of unneeded off-on-delay-us
Date:   Wed, 20 Oct 2021 07:48:43 +0200
Message-Id: <20211020054842.10246-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The default delay value for power cycle the sd card is 1ms. Since this is
sufficient we can remove this value here.

Fixes: 5dbadc848259 ("arm64: dts: fsl: add support for Kontron pitx-imx8m board")
Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
index f593e4ff62e1..e4429a1c874d 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
@@ -51,7 +51,6 @@ reg_usdhc2_vmmc: regulator-usdhc2-vmmc {
 		regulator-min-microvolt = <3300000>;
 		regulator-max-microvolt = <3300000>;
 		gpio = <&gpio2 19 GPIO_ACTIVE_HIGH>;
-		off-on-delay-us = <20000>;
 		enable-active-high;
 	};
 };
-- 
2.30.2

