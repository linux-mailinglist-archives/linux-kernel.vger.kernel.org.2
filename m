Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73E144C985
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Nov 2021 20:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbhKJTxU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Nov 2021 14:53:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231944AbhKJTxH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Nov 2021 14:53:07 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A6AC061766
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:50:19 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o4-20020a1c7504000000b0032cab7473caso4219854wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Nov 2021 11:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9v/p3H16Q1aF+/gSoivdZVyJ3IG44fQPKhtZ36YoWUc=;
        b=VjKbv2Zpc6bphwYBa6CnzuQ3EBlY7cT8fnqQxmtxi5dfMNOmVdkC6ZVNssGO9IbeeH
         FuPTyHp2SsTUWNCXoX+EjvpCyIUJb4Ctn4OZ4ezvBPsOUl0PViSncqzsGEiwnekHBLZw
         bcwcXhZp2JjtoOuP/UjB9JFcE4FVXaygmhzj/RJLR2/YjpFsFF7j36RKtN1LeKtEf+d+
         WtjmbgCehRd5LQUwErc0V9by2F30IkDUsnBgi5Hawi4Pt9v/mETFuDa9iVx4egfygdmx
         9Esz9+Ozc3BI9trSnkX9bDfduBlSEu6KRIkL6joNzj07/fxY7TUZfdIGrulE0dYOKOQQ
         nK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9v/p3H16Q1aF+/gSoivdZVyJ3IG44fQPKhtZ36YoWUc=;
        b=E/diiSuxbO9ZlUKH8MDRbSBezviXSjB/bvtlancejPhEZW4hlVI/dDwJjmKwSZgDPu
         vc/KE71c3F4OAXF8CKMAmlDFU7+bOa2/HgnDYSkMIzzhZmq687GHedTl5q2SzQXP6/dM
         RAMYdGHZOa66dp+prM+v7Jy0FnXb888v2n/i9okBT58/XeLAkjhe/lGAP23QgZuVOUe0
         /OV80p9vCNFC/Fd1khWERhf4UaegPqtj46PfLdOWBHwx9N7mFo15uTB3vh9tvzLUEkZY
         FAqA6zGTrVuVJv5jmJG/AfPrkPuUVkqtbv0RnsgKZp7uEeRZgCgPRZ434/Xw0yHIGevX
         dtww==
X-Gm-Message-State: AOAM531tsEq6XMqFLHDKFRbDTaN8pirmFQs0Lb4iih0daLQBEOr3BB/s
        I6HzqJ45ZlZx925ZAJM9eJ766A==
X-Google-Smtp-Source: ABdhPJwSPWVHGUSXAVFDBKRAJSOPw7HbTj6ZnnxeadITSc2hD6wRJTXTJzEv97AJwaIDDHZMAUsYmA==
X-Received: by 2002:a05:600c:4f8a:: with SMTP id n10mr1937772wmq.54.1636573817648;
        Wed, 10 Nov 2021 11:50:17 -0800 (PST)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id k15sm750935wrx.53.2021.11.10.11.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Nov 2021 11:50:17 -0800 (PST)
From:   Fabien Parent <fparent@baylibre.com>
To:     Qii Wang <qii.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] i2c: i2c-mt65xx: add MT8365 SoC support
Date:   Wed, 10 Nov 2021 20:49:58 +0100
Message-Id: <20211110194959.20611-3-fparent@baylibre.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110194959.20611-1-fparent@baylibre.com>
References: <20211110194959.20611-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for I2C on MT8365 SoCs.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---

v3: rebased
v2: No change

 drivers/i2c/busses/i2c-mt65xx.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/i2c/busses/i2c-mt65xx.c b/drivers/i2c/busses/i2c-mt65xx.c
index 9ea427f53083..a0249ebe7c7a 100644
--- a/drivers/i2c/busses/i2c-mt65xx.c
+++ b/drivers/i2c/busses/i2c-mt65xx.c
@@ -411,6 +411,19 @@ static const struct mtk_i2c_compatible mt8192_compat = {
 	.max_dma_support = 36,
 };
 
+static const struct mtk_i2c_compatible mt8365_compat = {
+	.regs = mt_i2c_regs_v1,
+	.pmic_i2c = 0,
+	.dcm = 1,
+	.auto_restart = 1,
+	.aux_len_reg = 1,
+	.timing_adjust = 1,
+	.dma_sync = 1,
+	.ltiming_adjust = 0,
+	.apdma_sync = 0,
+	.max_dma_support = 33,
+};
+
 static const struct of_device_id mtk_i2c_of_match[] = {
 	{ .compatible = "mediatek,mt2712-i2c", .data = &mt2712_compat },
 	{ .compatible = "mediatek,mt6577-i2c", .data = &mt6577_compat },
@@ -419,6 +432,7 @@ static const struct of_device_id mtk_i2c_of_match[] = {
 	{ .compatible = "mediatek,mt8173-i2c", .data = &mt8173_compat },
 	{ .compatible = "mediatek,mt8183-i2c", .data = &mt8183_compat },
 	{ .compatible = "mediatek,mt8192-i2c", .data = &mt8192_compat },
+	{ .compatible = "mediatek,mt8365-i2c", .data = &mt8365_compat },
 	{}
 };
 MODULE_DEVICE_TABLE(of, mtk_i2c_of_match);
-- 
2.33.1

