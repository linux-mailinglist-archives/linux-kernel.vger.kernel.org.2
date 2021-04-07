Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 439DC3576B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Apr 2021 23:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbhDGVWX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Apr 2021 17:22:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232473AbhDGVVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Apr 2021 17:21:47 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B88CC061760;
        Wed,  7 Apr 2021 14:21:33 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a4so2503025wrr.2;
        Wed, 07 Apr 2021 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jh571+ID0yhjIhjxf9sqAGVgpEsTICaKfHEOpTGXD08=;
        b=OO7/w7Rh3U88gbnj2a5swi/4XoKyJHBeb76uJS6ZsEIzGK7jn/8F/b/p3UgeUSSJES
         6YZqo2T/y+EVj4xDUKJH+mU/rSsOTu33xoux6JUUBpqdIbSZlL9uE7SJifDEDYLYVdfl
         OStIIWHsmQSd5x79KnyJhTtXjJzz42goXjCjCmW7fTvPwoCYF7n9GSC1KlBwnySXL13e
         XgWHyYML9S+9SMzP39XGCMeNWdGuYYbMsjHKtmxfGQVFYBzZB7J5M/QIsyKQwrC3Uo1O
         zkv7LBs/OM0QVkHbWiSQGOSr5GorUe4U0x5A3DjGZXASRlX+Y3h9zodVkPKj4qY1qvDm
         P6Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jh571+ID0yhjIhjxf9sqAGVgpEsTICaKfHEOpTGXD08=;
        b=UhB3gce/F6aU4uJPTUbTFsu5C8ghfm5wHX/7FesnCIX6BgevpsJALCGQ9uQbuI17sH
         XKn2YJwZ6jP4/O2ksB2gx6KXHjdhyz/q8KDIznUhkRthPtzfpNJRZtB2aKbpgL0q8DRB
         UZVCmDmf9HjK0i3R1+GzW940E1MXvRchoveRYjx08tzxH7Ij/IuXmdPrZ0eHSzqOVDRI
         buu/4DYmoVYG3dmV6a7QScw+lzo0efT6Tj8r8IK/cuK0GQ7R1FHxFj1IHtMqTZqArUoA
         wz4vpsaNOxyzGlJmytDLdi3oNMj9VW9qnMiMMH8IuSQNt1AUamSe+WmZaqI98ncqY6SC
         jm8Q==
X-Gm-Message-State: AOAM531WL5m6ZOZrdi8dVPdWT57BTJgG0CRODbowDlsAajRq7xgPSTEM
        hVTA3cYWxEitFlF/Vu3nAFI=
X-Google-Smtp-Source: ABdhPJziPKYKQAlsNoPeXWoU1fwTbJL91YMbyi9TaeQIh154vKLaCIaXpURz7OJrBl5pWZq719FxhQ==
X-Received: by 2002:adf:cf0f:: with SMTP id o15mr6532453wrj.91.1617830492311;
        Wed, 07 Apr 2021 14:21:32 -0700 (PDT)
Received: from adgra-XPS-15-9570.home (2a01cb0008bd270041a0a0f4308eafc0.ipv6.abo.wanadoo.fr. [2a01:cb00:8bd:2700:41a0:a0f4:308e:afc0])
        by smtp.gmail.com with ESMTPSA id l14sm17173952wrm.77.2021.04.07.14.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 14:21:32 -0700 (PDT)
From:   Adrien Grassein <adrien.grassein@gmail.com>
Cc:     robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        l.stach@pengutronix.de, Anson.Huang@nxp.com, krzk@kernel.org,
        peng.fan@nxp.com, aisheng.dong@nxp.com, qiangqing.zhang@nxp.com,
        alice.guo@nxp.com, aford173@gmail.com, agx@sigxcpu.org,
        andrew.smirnov@gmail.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Adrien Grassein <adrien.grassein@gmail.com>
Subject: [PATCH v1 6/7] soc: imx: gpcv2: add quirks to domains
Date:   Wed,  7 Apr 2021 23:21:21 +0200
Message-Id: <20210407212122.626137-7-adrien.grassein@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210407212122.626137-1-adrien.grassein@gmail.com>
References: <20210407212122.626137-1-adrien.grassein@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some domains need quirks during their operation.
For example, on i.MX8MM, USB domains should not be powered off.

Signed-off-by: Adrien Grassein <adrien.grassein@gmail.com>
---
 drivers/soc/imx/gpcv2.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 571d0381dd87..592b9808dcd4 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -119,6 +119,10 @@
 
 #define GPC_CLK_MAX		6
 
+/* Quirks */
+//Refuse to poweroff the domain
+#define GPC_QUIRKS_DONT_POWEROFF BIT(0)
+
 static DEFINE_MUTEX(gpc_pd_mutex);
 
 struct imx_pgc_domain {
@@ -139,6 +143,7 @@ struct imx_pgc_domain {
 
 	const int voltage;
 	struct device *dev;
+	const unsigned int quirks;
 };
 
 struct imx_pgc_domain_data {
@@ -263,6 +268,9 @@ static int imx_gpc_pu_pgc_sw_pdn_req(struct generic_pm_domain *genpd)
 	int i, ret = 0;
 	u32 value;
 
+	if (domain->quirks & GPC_QUIRKS_DONT_POWEROFF)
+		return 0;
+
 	mutex_lock(&gpc_pd_mutex);
 
 	/* Enable reset clocks for all devices in the domain */
@@ -606,6 +614,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
 			.map = IMX8MM_OTG1_A53_DOMAIN,
 		},
 		.pgc        = IMX8MM_PGC_OTG1,
+		.quirks     = GPC_QUIRKS_DONT_POWEROFF,
 	},
 
 	[IMX8MM_POWER_DOMAIN_USB_OTG2] = {
@@ -617,6 +626,7 @@ static const struct imx_pgc_domain imx8mm_pgc_domains[] = {
 			.map = IMX8MM_OTG2_A53_DOMAIN,
 		},
 		.pgc        = IMX8MM_PGC_OTG2,
+		.quirks     = GPC_QUIRKS_DONT_POWEROFF,
 	},
 };
 
-- 
2.25.1

