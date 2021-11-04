Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6296844570C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 17:18:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231788AbhKDQVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Nov 2021 12:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhKDQVF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Nov 2021 12:21:05 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E91C06127A;
        Thu,  4 Nov 2021 09:18:27 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id r3so6068927iod.6;
        Thu, 04 Nov 2021 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wo5qK1z+5eqpNHE5Evq0w36c+Io1/MhLt1zQlF+SBVw=;
        b=m2UzacC3PTeta/7T14wUcDwYmB9RG7IJr6XNA/969DAv5vNn1W8eTJU1wCMq6ukD9g
         SaXTJinP8pQXav/13BWVrOXSDUSjN2wYdsWJC88MvHMdjp+HSznOFsINKrQZKZ7/yL0v
         aMwbqlsIQW76e2YzfzxESKH/WcOJbORlL6LAmRZkqESWi/w7kuwPwOu8grOs9VTPAc45
         lgNh0pOhtryQ0lLG5LLQFC3BCb2Rda0ayjypV6AH/TB+VKoMrCQZ+jukNT+mdpe4fScf
         rtagBWJErK1/dmIu5E0eixUf6reECFaAU2gAQty9LYPonGSNhyIKw2HK7UzkkjjYtSeI
         8Xmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wo5qK1z+5eqpNHE5Evq0w36c+Io1/MhLt1zQlF+SBVw=;
        b=CjizBa/00mp7u4yst2HPa5DxixGKhQfYbs6Oe17ZguxHU6AVn0PgaW5bFT3FcGOrhU
         cKk8iHCzniNH3EwBfZCrJIn4MyYJSHp6AH+CN1/tMSiQJ9A7EAWxHC2cUwcppiPLp2Mk
         IAbBrRnGWT7O/bZs1tt26WHtXDh+zJaliSBS5dk2LtG6s5+s/NrcZeyn/Z8ZbrmJaVbO
         3/frecTXh+HLmxEnDhr+m+kgwoK/6aSKKT7hTQPkggBtOtAFV5BI5+TCAIu+9I2H5Wn/
         h6NzUYC8o26Gi0tYhsFPCiR+WCAlbbv7PjkZZtX/5UXmeHW7iE1rRgYxhYuKmHGx9h3G
         hcPQ==
X-Gm-Message-State: AOAM533xlqkqMfz09HX8FWl+eH1TPY0dhHScUDGtviTUuZv4saikcU5a
        H7YcyquB0SccMROs9pnSY4+XsdLLvnY=
X-Google-Smtp-Source: ABdhPJzxrMcVNNbunhJ5x8mSkQyE18/YU67DkNy1ZZz1qxqaYxeb9lWSPd5SAphxbOKxHA3oam+fng==
X-Received: by 2002:a5d:8619:: with SMTP id f25mr37021626iol.46.1636042706730;
        Thu, 04 Nov 2021 09:18:26 -0700 (PDT)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:e81d:737a:bb84:83ba])
        by smtp.gmail.com with ESMTPSA id e17sm3266326iow.18.2021.11.04.09.18.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Nov 2021 09:18:25 -0700 (PDT)
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
Subject: [PATCH V3 1/9] soc: imx: gpcv2: keep i.MX8MN gpumix bus clock enabled
Date:   Thu,  4 Nov 2021 11:17:56 -0500
Message-Id: <20211104161804.587250-2-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211104161804.587250-1-aford173@gmail.com>
References: <20211104161804.587250-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like the i.MX8MM, keep the gpumix clocks running when the
domain is active.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/drivers/soc/imx/gpcv2.c b/drivers/soc/imx/gpcv2.c
index b8d52d8d29db..95f05575f843 100644
--- a/drivers/soc/imx/gpcv2.c
+++ b/drivers/soc/imx/gpcv2.c
@@ -840,6 +840,7 @@ static const struct imx_pgc_domain imx8mn_pgc_domains[] = {
 			.hskack = IMX8MN_GPUMIX_HSK_PWRDNACKN,
 		},
 		.pgc   = BIT(IMX8MN_PGC_GPUMIX),
+		.keep_clocks = true,
 	},
 };
 
-- 
2.32.0

