Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3DC458030
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 20:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbhKTTwO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 14:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbhKTTwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 14:52:13 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA32C061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 11:49:10 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id e144so17619333iof.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 11:49:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hr4it2Nu4JOURKxzXa2x66i2A/MiAQxWQ0LABh8nC9s=;
        b=LgTTv3lPW8Wx3HL2Tz4NpYsq5aSAdjeMRmMKb2XLhhk65VUIVH4BlC8LwL4VaNvkEi
         RDhnNuzVnjhyE9TGrxzi9XnfITPglhvylhyx+YFlCO5KA9KoLg+qW7o9iVZdfm6IOCVQ
         YsLQTcVU8G5R0QXn555PHvKhFJybQSIF671pMaPSXmwiApjV23yyrD3wvvSy2JEssewA
         ccdTJivH/hJqC5JR3ghJ8SDcaUB+2dTF5WG7aOQVrfCHPl0ozvMtvJVZvGdobn7H7uHJ
         h7e/IoZjA5xSGx7nyYSrGnr7B2SYbzrFdxmd+6Pw1k+eWuyenmblCzxHNEsR3buDLUcF
         ZO2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hr4it2Nu4JOURKxzXa2x66i2A/MiAQxWQ0LABh8nC9s=;
        b=F5U5DaRUqOZ2l0LzBDigGjWRLYQbFQejph2GQ/E6Iyj9pHG0RA1zzr1WNeaR63owwD
         9xLwWO7OBPRVIA6erfAZL7kJUmjqE6Ffim1ZJiqpsFGRtZ6PFvzI7wP6iY3lXoFZ35sr
         9z9SXWEEsQKhrghuru9ZdQANk5PTAFCD0O8sdFHM1ggY8bGAsK5k+8Q/wJIN+XK+PsWb
         HGoTH1UL/TneI9cS6ZkJ7cbBLwzQtqebx3WqC81N39AMg/H4Ee2OuRtkzcVxO73OA8ir
         O+/ULoRPCoZrRGGGFgJPtRzNejCbRs3IeBJIbM5ZjqB1aimcQoG/dZLLEpJp2LasxeGH
         Jlhw==
X-Gm-Message-State: AOAM531Zc/1w2qS8tx3jD+xfecLYiXdpGQqDQ4yYayrXONScziondTE9
        HWhggBVRb8T1lu0hD8Inbsw=
X-Google-Smtp-Source: ABdhPJw48jx7b9hQD9iYukk5NV4yS382dP5h4GcVdBRMUFcLeSv+9EqhCIfaMjnRdQKNFIzPo1+yfw==
X-Received: by 2002:a05:6638:2512:: with SMTP id v18mr35514340jat.22.1637437749356;
        Sat, 20 Nov 2021 11:49:09 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:de9c:9e61:8791:1fd7])
        by smtp.gmail.com with ESMTPSA id t6sm2135976ils.44.2021.11.20.11.49.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 11:49:08 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     tharvey@gateworks.com, aford@beaconembedded.com,
        Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] soc: imx: gpcv2: Enable vpumix/dispmix to wait for handshake
Date:   Sat, 20 Nov 2021 13:49:00 -0600
Message-Id: <20211120194900.1309914-1-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a comment in the code that states the driver needs to
wait for the handshake, but it's only available when the bus
has been enabled from the blk-ctrl.  Since both the
vpumix and dispmix are called from the blk-ctl, it seems
reasonable to assume the bus is enabled. Add a bool to determine
which power-domains are able to properly wait for this
handshake and set the corresping boolean for the two domains
activated by the blk-ctrl.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 7b6dfa33dcb9..a957f7fff968 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -204,6 +204,7 @@ struct imx_pgc_domain {
 	const int voltage;
 	const bool keep_clocks;
 	struct device *dev;
+	bool blkctrl_bus_enabled;
 };
 
 struct imx_pgc_domain_data {
@@ -282,17 +283,14 @@ static int imx_pgc_power_up(struct generic_pm_domain *genpd)
 				   domain->bits.hskreq, domain->bits.hskreq);
 
 		/*
-		 * ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK, reg_val,
-		 *				  (reg_val & domain->bits.hskack), 0,
-		 *				  USEC_PER_MSEC);
-		 * Technically we need the commented code to wait handshake. But that needs
-		 * the BLK-CTL module BUS clk-en bit being set.
-		 *
-		 * There is a separate BLK-CTL module and we will have such a driver for it,
-		 * that driver will set the BUS clk-en bit and handshake will be triggered
-		 * automatically there. Just add a delay and suppose the handshake finish
-		 * after that.
+		 * blkctrl_bus_enabled implies that the GPC is being invoked from a blk-ctrl
+		 * and not from a peripheral or other GPC power domain.  The blk-ctrl is required
+		 * to support the handshake.
 		 */
+		if (domain->blkctrl_bus_enabled)
+			ret = regmap_read_poll_timeout(domain->regmap, GPC_PU_PWRHSK, reg_val,
+							(reg_val & domain->bits.hskack), 0,
+							USEC_PER_MSEC);
 	}
 
 	/* Disable reset clocks for all devices in the domain */
@@ -701,6 +699,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
 		},
 		.pgc   = BIT(IMX8MM_PGC_VPUMIX),
 		.keep_clocks = true,
+		.blkctrl_bus_enabled = true,
 	},
 
 	[IMX8MM_POWER_DOMAIN_VPUG1] = {
@@ -749,6 +748,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
 		},
 		.pgc   = BIT(IMX8MM_PGC_DISPMIX),
 		.keep_clocks = true,
+		.blkctrl_bus_enabled = true,
 	},
 
 	[IMX8MM_POWER_DOMAIN_MIPI] = {
-- 
2.32.0

