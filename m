Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC243460D1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 15:01:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231767AbhCWOBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 10:01:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231920AbhCWOAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 10:00:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9F1C061763;
        Tue, 23 Mar 2021 07:00:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id b9so20889284wrt.8;
        Tue, 23 Mar 2021 07:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k9Vaz9gbCiGzDFxbKD8l0JESGomqtwi3Gvy71+upcT0=;
        b=OQC4TgtTuKoOM1fGAto4orkg/MPJxi/XDk8Krl4qpA3moYNKEScvfXNe1APkuhurBW
         aEmJh8QjeYATUy3VDxke5opEmlPKwg39+JyNClY9t0CTanVhxy6hyPE5FenxviDS+kUu
         XDRm5DFJ5g2fK0kCxWVO39tbh5mHP2qrmw+03V9Ktv4NsfLQLMI5DzhLufUp4rqSqdKQ
         GMwm3zGa7oFlnkANiuxO8WRIgDRkfgVQMcXa0fbin6QqWGKm9vSf8gYpi6PW6l8TaBvo
         sMPpexQa2/DL4UppxsvQxdj0vUH3A+RrxqWAvty2gb8/4qzFKF55MpA8X5kRACUvIgPP
         0MnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=k9Vaz9gbCiGzDFxbKD8l0JESGomqtwi3Gvy71+upcT0=;
        b=s1KwaMmmec0fY4p6nOIdwFqY4OF/jv6Evb+CBQp8kFbZPLxOX9iGryknBU/jCiXzz5
         e8HQ34Y0Wk+LgUQe9UAsKS+hqHCwThvtH6ifd84EhECwyGZoKzJdfJIMLvlA+IY4AWi1
         E7PxO/xSYkrJd4+tTkKX93+DXxN3dPf6XjLOgZmWwgLFd/PrgGP1gVXZMI2ok2/aKX+c
         yGMLt18I9UGGfDyDNBblQzD/LM4mWyRIvKBfAaR1dzM/mJR/WKuMHvtBgKT04Oqboffu
         RNuEEfZlpy6vc9gYV4UepSEgOVnNf/vK8ch/3aqPOSA3zmL8HmHcVyIJMDQEvoOYoP6D
         t7Ng==
X-Gm-Message-State: AOAM532xAq+f1bboXybioHJH2FyC97OkQmyeqwa49WnMtQHy0mbmn5a8
        4nhKo6od0sKuFlxCJVraY7a7xS+beIsQLnGS
X-Google-Smtp-Source: ABdhPJyH0R/5PT0svyu8+7nCmsjm+plk9uKA8hY0z/U4fC0pa2liHmAzFrE3LdxDJqQqai6abx//uw==
X-Received: by 2002:adf:b313:: with SMTP id j19mr4115195wrd.188.1616508039650;
        Tue, 23 Mar 2021 07:00:39 -0700 (PDT)
Received: from hthiery.fritz.box (ip1f1322f8.dynamic.kabel-deutschland.de. [31.19.34.248])
        by smtp.gmail.com with ESMTPSA id 7sm2616070wmk.8.2021.03.23.07.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 07:00:38 -0700 (PDT)
From:   Heiko Thiery <heiko.thiery@gmail.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Walle <michael@walle.cc>,
        Heiko Thiery <heiko.thiery@gmail.com>
Subject: [PATCH v2] arm64: dts: imx8mq-kontron-pitx-imx8m: pass phy reset delays
Date:   Tue, 23 Mar 2021 15:00:21 +0100
Message-Id: <20210323140019.14388-1-heiko.thiery@gmail.com>
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

Without these reset delays the board will hang during startup when
bootargs has ip=dhcp set.

Fixes: 1dc7f3d79a1a ("arm64: dts: fsl: add support for Kontron pitx-imx8m board")
Signed-off-by: Heiko Thiery <heiko.thiery@gmail.com>
---
v2:
 - add desciption what issue will be fixed
 - add Fixes tag

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

