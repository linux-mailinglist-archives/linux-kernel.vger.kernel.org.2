Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD23B46066B
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Nov 2021 14:21:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357651AbhK1NYi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Nov 2021 08:24:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352647AbhK1NWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Nov 2021 08:22:34 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C86AC06174A;
        Sun, 28 Nov 2021 05:19:18 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id w4so14056424ilv.12;
        Sun, 28 Nov 2021 05:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xbIfDUs+5XAJQDCARVUwLaxPcfEpTJ3HeBuzoGHbX0M=;
        b=d+jnT97dBzIg10fip9fmjEIUsJjH/X40BYOLCfqJIp6DxoG5suV349c4B11N3132jB
         Cm3Wngpt1L6sPfgolyTOXaud1M1N+ZVAD0K+YRvMOXs0o23SDplcNMxrH3Tau5YSOjIz
         FYiqD6hnZ3+dgOPN3uL4KbA5kgEuScPhAart+31Xc2PmyjQCrWQN5w3pa9wb1BVUGq7N
         l64myRR2iKHGIREC/re2r/OpaWuwAQ5bRddaXIAx22z6MKvnpaeHjosnRzuJuTkYKmSs
         97ql8uRNaw5fTLyX/BtnklerlQlChx+d6OQXdCY3fgfSQDuRFbwYCKLoLu1+Of2h7Ry3
         RBLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xbIfDUs+5XAJQDCARVUwLaxPcfEpTJ3HeBuzoGHbX0M=;
        b=Eo3miJdH3OK96iVOIePMNak68BDmCdlAtzyuBk1d/4in1wzAQ7EvaecZ+V/r2+c+eb
         8RhduyKz//nKDBEs77wkW+uUieCDdpoiyFn2opq+Lds5FYOSMUtrlClBvr1CanG3WEqq
         EFFAILcQqOoAblwOTGtW3yb7zpCGavieVBKuz7K+40DKjBlFUvDufdZI/ob5yFboWzxW
         emDx4mn2RFavgr+rB5MieAR8+lDhfE+/ILZ9nGO2qMfzpJnpxvRftcVLdbe3E9daeLEi
         sjSL0/8LYifMIp7NIZPHbPW7MWRf/N5vzWFhQLgFm85vTF44E/CXPjGAyPHmFyCnxt/P
         uGXg==
X-Gm-Message-State: AOAM532rxz/dk7xracyj8lEbyxToRe/j2uwo8UOT0LAnEN+Rc3cwkJPO
        ZYeJsPm9XxquzC7uYpPWyeCip4YinG2aqQ==
X-Google-Smtp-Source: ABdhPJyY/r448DdE3+W0BBrztbjX8TctizCLD/EWV3Sn6M88tqPfkxVJeuphSpsN7Hb8sEnoIoeGOQ==
X-Received: by 2002:a05:6e02:1a47:: with SMTP id u7mr30409394ilv.258.1638105557550;
        Sun, 28 Nov 2021 05:19:17 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:2a06:17d2:47df:6c8e])
        by smtp.gmail.com with ESMTPSA id q12sm6990413ile.77.2021.11.28.05.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Nov 2021 05:19:17 -0800 (PST)
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
Subject: [PATCH V4 1/9] soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
Date:   Sun, 28 Nov 2021 07:18:44 -0600
Message-Id: <20211128131853.15125-2-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211128131853.15125-1-aford173@gmail.com>
References: <20211128131853.15125-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the i.MX8MM, keep the gpumix clocks running when the
domain is active.

Signed-off-by: Adam Ford <aford173@gmail.com>
---
 drivers/soc/imx/gpcv2.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index 8176380b02e6..a0eab9f41a71 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -841,6 +841,7 @@ static const struct imx_pgc_domain imx8mn_pgc_domains[] = {
 			.hskack = IMX8MN_GPUMIX_HSK_PWRDNACKN,
 		},
 		.pgc   = BIT(IMX8MN_PGC_GPUMIX),
+		.keep_clocks = true,
 	},
 };

--
2.32.0

