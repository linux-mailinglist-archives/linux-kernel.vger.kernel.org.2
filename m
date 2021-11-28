Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E83846066C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357661AbhK1NYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352653AbhK1NWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:22:36 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3016AC061756;
        Sun, 28 Nov 2021 05:19:20 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id z18so17544815iof.5;
        Sun, 28 Nov 2021 05:19:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VfhF2cplorqVHebuBeCfTfE4UpfH7xJY2vB57O2IOs4=;
        b=CzMIxkAOJdM4pWlQ0//WoQrsaI+ZQvzSeQnPELMfbLUeHJm+nFZ+pOhxqAVE+CpN3Y
         DOErrZmTRZ7xWa2EnbIcLpoQ5CEOWSY+rWQGYFh4AaDeqMDDGNDOW3xoKxNtjXwIS3ZV
         yuaL7KYvHcykCOR212NtRcrXdoV+8hugtF/w5KtfpXwZd+ADDi1ythHejFY1y1t7bXNH
         s4rMAHrISqbQVPy1fxtunRllkH7XKefJeY5WZwcyMjXC3NawCZVXKg77+JbI/iqCALm4
         pcZuJ9TwpujX7yr/iiXUyJHNTd/6VPlqMn8y45ACQa7iR/X6SGYZT8CKgOp47RptLLr6
         LNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VfhF2cplorqVHebuBeCfTfE4UpfH7xJY2vB57O2IOs4=;
        b=iW90QoVG+doS6k6DuAeCF7E67LNvRjiz2edzl6jhQ3yEQTOtth1ko7brPptr5/kn+m
         OlbO6L9/y1c4OU0hrBMffzkJVE4F3+gOe6lAywPs9+hWCepQNndR8roPBJxctXn1k/6p
         v0nx0p9lX+yWq47iYSVX/n537mdnm4Nk5ZsKbR6cCN9Xha2hH/U9LEvfr3l1LszUb3vJ
         SI31817ZXZ2Lw/6Qw5VtaUphuVxVnbVx92wPb21Nus93h1qH2RF78jAKng+iuVzMWyY3
         Mscx3FYnXZvDnthPrMOq2W1HPLpdoSAGPgfFjpD6ay/nVOgTpIa/9gSGXzOmtTN55jKp
         /tfQ==
X-Gm-Message-State: AOAM531dFjFQOflIZgLMI2hwlXPcBg1/8tQZ2k5Mf31QzmI/CadtOCyl
        ofs1oql+m74psnOEZdSK34k=
X-Google-Smtp-Source: ABdhPJwLi8WLY4X8ZY5n8mKIV9ZMjZ85u77A2tpmrrFMUbXkAX1vwG3Sy5PA2eRk6ago6OjUQ30iSg==
X-Received: by 2002:a05:6638:25c4:: with SMTP id u4mr58541922jat.87.1638105559515;
        Sun, 28 Nov 2021 05:19:19 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id q12sm6990413ile.77.2021.11.28.05.19.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:19:19 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     aford@beaconembedded.com, tharvey@gateworks.com,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 2/9] soc: imx: gpcv2: Add dispmix and mipi domains to imx8mn
Date:   Sun, 28 Nov 2021 07:18:45 -0600
Message-Id: <20211128131853.15125-3-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128131853.15125-1-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
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
index a0eab9f41a71..3e59d479d001 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -843,6 +843,31 @@ static const struct imx_pgc_domain imx8mn_pgc_domains[] = {
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

