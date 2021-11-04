Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A0FB44570F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:18:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231740AbhKDQVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhKDQVI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:21:08 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7990AC06120A;
        Thu,  4 Nov 2021 09:18:29 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id i9so6703769ilu.8;
        Thu, 04 Nov 2021 09:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p3IEzSCeOEXC5VlTfliM3rk6U/jC/ZurW6i2g+0wJuc=;
        b=allU9fQD4Dt+ML8K3Bqiumn2HK3Ji4tPOCCVLx2fCf2jAtuFl0pMs/9bLYpKgoFV61
         WjhBJHZUSABFWiWzTEoTBITig+ujbO6AVyxiBNV16u3vVn2858rfqklYRsB00GbgxZIN
         PStQrbR6KSxAWYjWpQ/w7yX7FcNgx5puLQwyCUQTbWx9ilqihuOlhdLbRxmmAWo0NVQt
         NCpZ32estdDGqSJIaxZnzTo49VL+ZspB3V/UIiHFqv8j0voF54RG1UCHAwvP4OBO5tkY
         f6QCBRjRBEYDi6P5N9BkIm1hukTXBsMqu6XzhEQeaUTY1jLwm8f+Y47t5XjyKQhiLtGM
         YFAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p3IEzSCeOEXC5VlTfliM3rk6U/jC/ZurW6i2g+0wJuc=;
        b=A6zRHPyO7zfgmuSd7rjtQSbmQRMaY/CTpgoUgndIDCd/RQ5NH758mCm43hupeotEJX
         nTNiWEwLv07u3/XWLrHWfGBITGJ0zZFqZwyj4Fx9gD70RFZc9lUvWv/eYZkhie5hPDq6
         9LtwdCjdpetWnQcRJXRpqhXNabWqnGqvWgo9P5Gg7GHMwnYpS9Mml2XrNM9J08GeGfdd
         qtFaioO0k++TLeAidK5gd/iTYq4Tsv2Lf+WqyNM95G13HtXeTxY00Zpm+PrHQfqK2gV3
         2apIU+Tb2EKZ0lLLvtRlLN2Nj9amOg3yP3fHCI1v/oPDFereVH5ttuExpYlerde54mD/
         GVZw==
X-Gm-Message-State: AOAM531h/nl7DxWx/d7zLy/9UpkKuFaED6GdVXw9uA6v6AldIQPu+k47
        a39sGkWRvw7f/MsLEEoJm5g=
X-Google-Smtp-Source: ABdhPJz8/jskraoS+3405snIdHjCcfSRk00AmOoHm94vAIqCgNiNeVza1LA1xSFxKLRo3OE9sKPj1Q==
X-Received: by 2002:a92:6910:: with SMTP id e16mr33673402ilc.190.1636042708709;
        Thu, 04 Nov 2021 09:18:28 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:e81d:737a:bb84:83ba])
        by smtp.gmail.com with ESMTPSA id e17sm3266326iow.18.2021.11.04.09.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:18:28 -0700 (PDT)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, ariel.dalessandro@collabora.com,
        krzk@kernel.org, tharvey@gateworks.com, l.stach@pengutronix.de,
        devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V3 2/9] soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
Date:   Thu,  4 Nov 2021 11:17:57 -0500
Message-Id: <20211104161804.587250-3-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211104161804.587250-1-aford173@gmail.com>
References: <20211104161804.587250-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dispmix will be needed for the blkctl driver, so add it
to the gpcv2.

Signed-off-by: Adam Ford <aford173@gmail.com>

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
2.32.0

