Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A667B3451BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 22:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbhCVVZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 17:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbhCVVZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 17:25:23 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51A0C061574;
        Mon, 22 Mar 2021 14:25:22 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso11883192wmi.3;
        Mon, 22 Mar 2021 14:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQGoNaPsmy1IXWU9jJIw0B6sqnx/pgrCgoYL+xGvia8=;
        b=DczGeAhbuxcAJ2miEjIX6ySIgzkbdvJh5Dohx3P1qd8EFzuNu5RuoSl76l0zp4UdCq
         hdbsF5ZjW8oE7IrkpgDDyxJCm8BckCRF9zvZgsSAluS1XuE6U+CeIsZn9i+Gaf1mfH21
         /p9GAT+lXM36TQSj+jNpyPxiRcl1zyyWbLTt6gXK2e8BpWksPS00OCewOung4uYBt2Pu
         ZPuASOBFHOYfaMp+LEL+V1oj5VrmeaJDkDqd6KKomlrVNvChbDjU9ns4pVhrW+mmA9Ha
         coNv+chzKzDooGZpcX7CgtOvb3J4Bf0HHXbBZ4lIdukDADutegWRPQumiWdbU8/1njMA
         xVZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mQGoNaPsmy1IXWU9jJIw0B6sqnx/pgrCgoYL+xGvia8=;
        b=q+fqbn7OR8H5btc4Y/EmWxjURGU5RsdssSOa0mtUpXkeaJiTEwP4GNFsEYOkT1ohos
         Kxir4T4X9HX2mAJsybgZ6zLBTVULpBa1ahE6pnY4sWvMYP3KuugHNJCKyEdNYtvc8VSZ
         kO6Kz+DfsMR1P0GvkLx/ZSgGhMEftji0eTMLzE9MZ4MqikaJfdhLm/dOMRvHSC+Js2Z9
         5ZBnsKvyN87eDjCnAHpfPMzZV8p5TxlQzhS8Y+dtlrhkccjGSn8ONcC+kswAJSDK0F2b
         QDFh1Ok25/q1C9ic87B4Q5yd+Th1U0+0ivPrCoHObJ5CsaRNuNQ9cVuSLa5iqYaAQhOc
         p4YQ==
X-Gm-Message-State: AOAM533iuk7ZOlnM7zEPCpmkaJkfny2GMpZUoLkA9RNsjDqZTEGLegve
        kDiAYUujtIsQbDFafRccxLY1b4HIYjBDy2lb
X-Google-Smtp-Source: ABdhPJztdGj74fHoag570iExS+t/KivNOuKFaGwEsR48SKLnA6lqAChEvhGiavdnGxfqNdC/Fr7VDg==
X-Received: by 2002:a1c:e184:: with SMTP id y126mr325641wmg.163.1616448321331;
        Mon, 22 Mar 2021 14:25:21 -0700 (PDT)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id x14sm20264875wrw.13.2021.03.22.14.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 14:25:20 -0700 (PDT)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>, heiko.thiery@gmail.com,
        michael@walle.cc
Subject: [PATCH] arm64: dts: imx8mq-kontron-pitx-imx8m: pass phy reset delays
Date:   Mon, 22 Mar 2021 22:24:46 +0100
Message-Id: <20210322212445.23410-1-heiko.thiery@gmail.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TI DP83867 PHY datasheet says:
T1: Post RESET stabilization time == 195us
T3: Hardware configuration pins transition to output drivers == 64us
T4: RESET pulse width == 1us

So with a little overhead set 'reset-assert-us' to 10us (T4) and
'reset-deassert-us' to 280us (T1+T3).

Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
 arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
index 91a9ceb10305..f593e4ff62e1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-kontron-pitx-imx8m.dts
@@ -90,6 +90,8 @@ ethphy0: ethernet-phy@0 {
 			ti,tx-internal-delay = <DP83867_RGMIIDCTL_2_75_NS>;
 			ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
 			reset-gpios = <&gpio1 11 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <10>;
+			reset-deassert-us = <280>;
 		};
 	};
 };
-- 
2.30.0

