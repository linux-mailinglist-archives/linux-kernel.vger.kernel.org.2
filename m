Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F11F5383B57
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:33:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243026AbhEQRez (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242932AbhEQRes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:34:48 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F45AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:31 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id lj11-20020a17090b344bb029015bc3073608so50689pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4pqFj7Us03V4DKXoPVf/+QTFVKwt46ibq2A620kOL0Q=;
        b=Zk1D+rU4hW4nerwdzxqplSrneAc1UjS+6fRKnD9kdguNc60rlUaCn9LNfT2hAv46p9
         dF1xYF4qKNHTBvJuYbswXGVVriGbDLzwYclqFzYrHlRe9ZEC1xweii+4OW19lLDV2Acc
         spIbFpDLwVOST6bGN6gpcjK8pBB4iaJ1d/ls4MhYlL39iPIEl2WfAleC4Qzzupnz8nrG
         A4Fi7STSj759NxwuFGXemxSLuZtdmsAcFP5NpaIH9jHgY6RKzgRKSXge3sbxTIW30M5m
         LDoH1t/eEy603/aabn0r+65i1t0SILSEQZ1lKb0x5Gj4At7uAJ204ENdHuKy0XxJCGpz
         SEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4pqFj7Us03V4DKXoPVf/+QTFVKwt46ibq2A620kOL0Q=;
        b=ZpfpfqfXGSEh21QPkg2hqArbkFL3tP3UuDrMd2UeBXq9b1de6v1L4LR9SF9GhOVybz
         Rg2fiQ/zmyhZB3hcQPJl95tsYsZADdiC4EzvPnUG0J/SYWkunrLkCi6KIbP0ExLCuSF8
         VZtutZ3CP9gh/qSC7TesIbB+AIH6uaI5drlZcCd0+uctVatJx0L8TcGtfcp7mYRoVej+
         kiAM51uPoEqkCRI7Y4/ee8hPWXH5J16BbZ73J6ffOzvXhjL/yEoJH2u6q379i+D08+ul
         9lXaYxVQHzbo8NKifK2KKt007zOeGkhBL/p2asqE4QkwimjohlWsv2MAxwp3o3HfKQ7w
         9V5Q==
X-Gm-Message-State: AOAM532CQ8pAKvH1DTkeHBe3o+UVleZmZwOd4cQGRc+bnj0ZXFaJgyWo
        fjPSkYYbgcK9bYbqJ9v0KF6yYyCs2cg=
X-Google-Smtp-Source: ABdhPJzT50m5T8D4oLIx2u84pBdh0BVHwS15cXOIDNzpnnzNh7QkdPbvXwqZzSnKWeBvVVl4BBczIA==
X-Received: by 2002:a17:90a:f87:: with SMTP id 7mr613916pjz.38.1621272811122;
        Mon, 17 May 2021 10:33:31 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47e:c24d:6c72:a52:2c8:7df1])
        by smtp.gmail.com with ESMTPSA id c12sm10358296pfr.154.2021.05.17.10.33.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:33:30 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v8 03/10] mfd: mt6360: Indicate sub-dev compatible name by using "-"
Date:   Tue, 18 May 2021 01:33:07 +0800
Message-Id: <20210517173314.140912-4-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
References: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Indicate sub-dev compatible name by using "-".

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index c374aa6c4a1b..512480f7bd40 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -293,18 +293,18 @@ static const struct resource mt6360_ldo_resources[] = {
 };
 
 static const struct mfd_cell mt6360_devs[] = {
-	MFD_CELL_OF("mt6360_adc", mt6360_adc_resources,
-		    NULL, 0, 0, "mediatek,mt6360_adc"),
-	MFD_CELL_OF("mt6360_chg", mt6360_chg_resources,
-		    NULL, 0, 0, "mediatek,mt6360_chg"),
-	MFD_CELL_OF("mt6360_led", mt6360_led_resources,
-		    NULL, 0, 0, "mediatek,mt6360_led"),
-	MFD_CELL_OF("mt6360_pmic", mt6360_pmic_resources,
-		    NULL, 0, 0, "mediatek,mt6360_pmic"),
-	MFD_CELL_OF("mt6360_ldo", mt6360_ldo_resources,
-		    NULL, 0, 0, "mediatek,mt6360_ldo"),
-	MFD_CELL_OF("mt6360_tcpc", NULL,
-		    NULL, 0, 0, "mediatek,mt6360_tcpc"),
+	MFD_CELL_OF("mt6360-adc", mt6360_adc_resources,
+		    NULL, 0, 0, "mediatek,mt6360-adc"),
+	MFD_CELL_OF("mt6360-chg", mt6360_chg_resources,
+		    NULL, 0, 0, "mediatek,mt6360-chg"),
+	MFD_CELL_OF("mt6360-led", mt6360_led_resources,
+		    NULL, 0, 0, "mediatek,mt6360-led"),
+	MFD_CELL_OF("mt6360-pmic", mt6360_pmic_resources,
+		    NULL, 0, 0, "mediatek,mt6360-pmic"),
+	MFD_CELL_OF("mt6360-ldo", mt6360_ldo_resources,
+		    NULL, 0, 0, "mediatek,mt6360-ldo"),
+	MFD_CELL_OF("mt6360-tcpc", NULL,
+		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
 
 static const unsigned short mt6360_slave_addr[MT6360_SLAVE_MAX] = {
-- 
2.25.1

