Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55A45427BEF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Oct 2021 18:27:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhJIQ3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Oct 2021 12:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbhJIQ3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Oct 2021 12:29:19 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580C7C061570;
        Sat,  9 Oct 2021 09:27:22 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id x1so10492512iof.7;
        Sat, 09 Oct 2021 09:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r77wkyHKd/WE+9fCuvSEWugo7EmVAfFhl1U72UK/PRs=;
        b=e9K61TkyQpmaVMZjuKox30awbpmjFkHGAZPAl3gdlK7T5gOjmWBcgZVBYjraZmoQoh
         y9gti2wO3u5SGzWI0wRciMwcmxzopAxE0G8OHC4OUgc3oiUQoLmjIml3TUHYWDRQfQw5
         qwLzxB9TnuM8PQBtsd733+GolpaZw2WKAsvePFOcgxGgbPXtkh3heU3i6fYOVy62PMRE
         5XzQUAGQ/UVKrsJkjd8970PgpN9W0bdJRe+woRshwiqn+UpI9QBkigr0EfY4Wxm6EsPt
         YO8qSra0rfR4FXMFQ1qfuaNR/q+W+EUV+CKaoRyqjdgVeOIQ28WfLoGYqGI/MI4YtWDE
         7u+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r77wkyHKd/WE+9fCuvSEWugo7EmVAfFhl1U72UK/PRs=;
        b=hn5hyJbuj+fjfH9Bc1NS3wGKT46bNCafFpB/3jDTX+qRzPgw5tJdUfjErbjI8kaVlU
         vseQl4jRHxdhHAFHvmPq1gFSvq0yHvuGc1+MymCDJ+1yCbntvONGKDbMvFAmMAHcMZMg
         FuDgr8ppd6IH2PftMv2uJMepyLPkQAcM/61Nh5j+jtMeHsviswxxEzhR7hOqPNtK77hd
         snHArtheGu1HFiwjBruihuhsQFakTn0DosUVDFkSdg9KyffmLYBT2iaIQFwTy8FQWtsM
         GLaacl2VSdo8YnjguLwqiDiHuWLeGHKv30Q3rAcUFRNQF7Fd5BML7XlMhnxHcDv+2OA6
         9GjA==
X-Gm-Message-State: AOAM531fDtd37FREYKWmulTL6xjG+k9g/M+ZAEorYOl0zBegntD8zYwT
        kZKyn9TQzOHyLWWf3J9dcc8=
X-Google-Smtp-Source: ABdhPJwyqUmVqMDLj9s23DQ8NZVUf/q04LA3Y4DNd6liukydi1oNbTrmNf+3L9IQn/RZNeZ/+sDi4A==
X-Received: by 2002:a02:1088:: with SMTP id 130mr12195551jay.87.1633796841660;
        Sat, 09 Oct 2021 09:27:21 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:cb0f:c46c:9a27:ace])
        by smtp.gmail.com with ESMTPSA id y5sm1253722ilg.58.2021.10.09.09.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Oct 2021 09:27:21 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V2 2/9] soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
Date:   Sat,  9 Oct 2021 11:26:52 -0500
Message-Id: <20211009162700.1452857-3-aford173@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211009162700.1452857-1-aford173@gmail.com>
References: <20211009162700.1452857-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dispmix will be needed for the blkctl driver, so add it
to the gpcv2.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/soc/imx/gpcv2.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 95f05575f843..7b568cf39a5a 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -842,6 +842,31 @@ static const struct imx_pgc_domain imx8mn_pgc_domains[] = {
 		.pgc   = BIT(IMX8MN_PGC_GPUMIX),
 		.keep_clocks = true,
 	},
+
+	[IMX8MN_POWER_DOMAIN_DISPMIX] = {
+		.genpd = {
+			.name = "dispmix",
+		},
+			.bits  = {
+			.pxx = IMX8MN_DISPMIX_SW_Pxx_REQ,
+			.map = IMX8MN_DISPMIX_A53_DOMAIN,
+			.hskreq = IMX8MN_DISPMIX_HSK_PWRDNREQN,
+			.hskack = IMX8MN_DISPMIX_HSK_PWRDNACKN,
+		},
+		.pgc   = BIT(IMX8MN_PGC_DISPMIX),
+		.keep_clocks = true,
+	},
+
+	[IMX8MN_POWER_DOMAIN_MIPI] = {
+		.genpd = {
+			.name = "mipi",
+		},
+			.bits  = {
+			.pxx = IMX8MN_MIPI_SW_Pxx_REQ,
+			.map = IMX8MN_MIPI_A53_DOMAIN,
+		},
+		.pgc   = BIT(IMX8MN_PGC_MIPI),
+	},
 };
 
 static const struct regmap_range imx8mn_yes_ranges[] = {
-- 
2.25.1

