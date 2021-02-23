Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35595322F4A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 18:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233692AbhBWRBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 12:01:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233619AbhBWRAz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 12:00:55 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C0DC06178A;
        Tue, 23 Feb 2021 09:00:14 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id v1so23291037wrd.6;
        Tue, 23 Feb 2021 09:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=LiTCa6DBif/PzMmCMLr4DjB3Hi0VKw857tDOttZsLNE=;
        b=kvsOcWcgEK3QmhXthFAy5GwObgwYPEF1evtOsjmM1OlqsrMz9ykUBiMTT84HNzvxNe
         w6bPFW61/yt7h3aq8HEoKS6xhsJ0r5oUEuyyi07LMZEpZorhCGwhwN3dvt7Ilf9Jt8Cf
         +tcJsKnGVUaHMfVrEayhOSmnIalYFkGjB8IGyRAqPjcMKxpvk2su23+TuacMIdCMU3oa
         QpM8PLvtt40xHrkGze0uVqXBiye72Zudcb0UUBMgTS5iMr3fsM+T8RHueEaWQhYmSBoB
         Y9x2zJdpFoH0ZHQaSn796fspvcM8rtSPCMba4baFkllc8vJueFM0IrJkg/OnGkZXIJVL
         k0uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LiTCa6DBif/PzMmCMLr4DjB3Hi0VKw857tDOttZsLNE=;
        b=DjiiPkUHgN0JvU5R0XDsUwIV8W3uhqD8z2qaHLJow/2M7SLEFrRhpMb2OHla/LT8a9
         TkkD9NLuS/DE5b6IvOQRW7N5AQYZxjDza4GIp300P4vaWuwqojDKKH1D0qEGEGCO5qHu
         Qs5OsvE1H0iqBKKvVyrjEayGYErgdi/lNSs1+yiDS3FY5yQz/o17IS32RroWfzEku5bV
         VR3AlJ6uKdgGhBEJTKXeu4nYJrCi9wVAZtMYOkKPv7RZWMA1+CfmGXwhh3K5mH6HN8as
         lcoLi5uEwlauxR9mB8lEa6pEEJBbmkSfhAUGFKCCDY+/BGnM2lJZwGnzr4o3SNhKcE2S
         gpNA==
X-Gm-Message-State: AOAM533/CD/EMkMVfZpShzDuYh0LgVOXcL7zGoMwIuDSoQUdwXLlTEbc
        3/l0T2wxIa/x4FoXRQucBDMbzYtd2APWHO5U
X-Google-Smtp-Source: ABdhPJykd3acZCrN6qeMOXqXvbtu9EKp9Em3ZBixIDwhCWnn+rgjhXGqBROKFqyF3KHZe7UtaEEBIQ==
X-Received: by 2002:a5d:404d:: with SMTP id w13mr396623wrp.230.1614099613369;
        Tue, 23 Feb 2021 09:00:13 -0800 (PST)
Received: from skynet.lan (170.red-88-1-105.dynamicip.rima-tde.net. [88.1.105.170])
        by smtp.gmail.com with ESMTPSA id u12sm3057190wmq.38.2021.02.23.09.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Feb 2021 09:00:12 -0800 (PST)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>, Guenter Roeck <linux@roeck-us.net>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@protonmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] hwrng: bcm2835: add reset support
Date:   Tue, 23 Feb 2021 18:00:06 +0100
Message-Id: <20210223170006.29558-3-noltari@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210223170006.29558-1-noltari@gmail.com>
References: <20210222194510.14004-1-noltari@gmail.com>
 <20210223170006.29558-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM6368 devices need to reset the in order to generate true random numbers.
This is what BCM6368 produces without a reset:
root@OpenWrt:/# cat /dev/hwrng | rngtest -c 1000
rngtest 6.10
Copyright (c) 2004 by Henrique de Moraes Holschuh
This is free software; see the source for copying conditions.  There is NO warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

rngtest: starting FIPS tests...
rngtest: bits received from input: 20000032
rngtest: FIPS 140-2 successes: 0
rngtest: FIPS 140-2 failures: 1000
rngtest: FIPS 140-2(2001-10-10) Monobit: 2
rngtest: FIPS 140-2(2001-10-10) Poker: 1000
rngtest: FIPS 140-2(2001-10-10) Runs: 1000
rngtest: FIPS 140-2(2001-10-10) Long run: 30
rngtest: FIPS 140-2(2001-10-10) Continuous run: 0
rngtest: input channel speed: (min=37.253; avg=320.827; max=635.783)Mibits/s
rngtest: FIPS tests speed: (min=12.141; avg=15.034; max=16.428)Mibits/s
rngtest: Program run time: 1336176 microseconds
cat: write error: Broken pipe

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 v3: no changes.
 v2: no changes.

 drivers/char/hw_random/bcm2835-rng.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/hw_random/bcm2835-rng.c b/drivers/char/hw_random/bcm2835-rng.c
index 1a7c43b43c6b..1b93a896d8e8 100644
--- a/drivers/char/hw_random/bcm2835-rng.c
+++ b/drivers/char/hw_random/bcm2835-rng.c
@@ -13,6 +13,7 @@
 #include <linux/platform_device.h>
 #include <linux/printk.h>
 #include <linux/clk.h>
+#include <linux/reset.h>
 
 #define RNG_CTRL	0x0
 #define RNG_STATUS	0x4
@@ -32,6 +33,7 @@ struct bcm2835_rng_priv {
 	void __iomem *base;
 	bool mask_interrupts;
 	struct clk *clk;
+	struct reset_control *reset;
 };
 
 static inline struct bcm2835_rng_priv *to_rng_priv(struct hwrng *rng)
@@ -94,6 +96,10 @@ static int bcm2835_rng_init(struct hwrng *rng)
 			return ret;
 	}
 
+	ret = reset_control_reset(priv->reset);
+	if (ret)
+		return ret;
+
 	if (priv->mask_interrupts) {
 		/* mask the interrupt */
 		val = rng_readl(priv, RNG_INT_MASK);
@@ -159,6 +165,10 @@ static int bcm2835_rng_probe(struct platform_device *pdev)
 	if (PTR_ERR(priv->clk) == -EPROBE_DEFER)
 		return -EPROBE_DEFER;
 
+	priv->reset = devm_reset_control_get_optional_exclusive(dev, NULL);
+	if (IS_ERR(priv->reset))
+		return PTR_ERR(priv->reset);
+
 	priv->rng.name = pdev->name;
 	priv->rng.init = bcm2835_rng_init;
 	priv->rng.read = bcm2835_rng_read;
-- 
2.20.1

