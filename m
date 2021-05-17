Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBCA383B58
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 19:33:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243128AbhEQRe7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 13:34:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242956AbhEQReu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 13:34:50 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A38FC061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:34 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id m124so5111813pgm.13
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 10:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=isU+R0YtdvBEb/YxNhS8iAmTy3xonfIIdT0KEAXDyUY=;
        b=bJ4knYa1+wo1bFrOT/oDLvt8veW+tkDk3aEEse8oCipOnmPe7zk+QIRTGkTtZ6KMpK
         OrjJ8bl7Fejg/ryFRfI2eofAUC0NPqN/pLKzJN+MxmZ17d7J04FsgSgPi7KbaSiH7vgl
         MS6ckEOpDtfDuBUDe0Ju135s8MOKfCkL8DgGo9n5bMSAxqjcHQS8jL7WX0MiPpCvLmaX
         TU5Pag4M6BHH/GHuO6IM7NOKGjtq+yN1VF+bETI+9eanXOIQ/6Lu03VM9gES23uH0yip
         dIBKI+WuIXAs/vSLDJGspzqWnLLTSIlRGJxALemjp4HZeZ0KSYBUYzxEbkESlMGMmZCU
         DJtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=isU+R0YtdvBEb/YxNhS8iAmTy3xonfIIdT0KEAXDyUY=;
        b=VDkCfa0UWs94cDOiLs+JoX6BrgKgoir+m6QlA2WA7Qb7UimQV4K5P4r0DK69rr99Wo
         DOImMyXfPhWjJJqSZkVzD5Txf5RSHBQqhR2JEmIQc2CFWXXRH6WmbS03m+CUZqcmRB1v
         AOL/YRFnvcsjd+wT/AYJuGPyolMJyL6LopH40W66AwjxZ8MqZzdX2sq4LH03L0IKf/9x
         lq/DsBbovk2YjxTyKOytE5ux46DtsaicgbVA2DzM4CK27Qn4ammGEXOVczqF3IKGWKfN
         UxBuhAuOSRtHq58d9pIWfIj5LLBGUdU4+GD8sDGy5LAdPKhLjeK94vUn3eygqrP5tAWg
         Om4w==
X-Gm-Message-State: AOAM530f+wGdqIP323Ub52R+nD8RRYhPK+LsMRQ+lTJY4W1NDUL+uJS/
        Po3tmU5bSp17v20WOrMQK0I=
X-Google-Smtp-Source: ABdhPJyaGfGcNWLlYnSVTpg5LA09Jl/79wWm2dvOP0W4GgpoCwv9EBUL1PSpCTOJG+W18AFvfa/Hig==
X-Received: by 2002:aa7:9252:0:b029:2ae:bde3:621f with SMTP id 18-20020aa792520000b02902aebde3621fmr725640pfp.18.1621272813968;
        Mon, 17 May 2021 10:33:33 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:47e:c24d:6c72:a52:2c8:7df1])
        by smtp.gmail.com with ESMTPSA id c12sm10358296pfr.154.2021.05.17.10.33.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 10:33:33 -0700 (PDT)
From:   Gene Chen <gene.chen.richtek@gmail.com>
To:     lee.jones@linaro.org, matthias.bgg@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        gene_chen@richtek.com, Wilma.Wu@mediatek.com,
        shufan_lee@richtek.com, cy_huang@richtek.com
Subject: [PATCH v8 04/10] mfd: mt6360: Combine mt6360 pmic/ldo resources into mt6360 regulator resources
Date:   Tue, 18 May 2021 01:33:08 +0800
Message-Id: <20210517173314.140912-5-gene.chen.richtek@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
References: <20210517173314.140912-1-gene.chen.richtek@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gene Chen <gene_chen@richtek.com>

Combine mt6360 pmic/ldo resources into mt6360 regulator resources
to simplify the similar resources object.

Signed-off-by: Gene Chen <gene_chen@richtek.com>
Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/mt6360-core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 512480f7bd40..3553c7045829 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -266,7 +266,7 @@ static const struct resource mt6360_led_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_FLED1_STRB_TO_EVT, "fled1_strb_to_evt"),
 };
 
-static const struct resource mt6360_pmic_resources[] = {
+static const struct resource mt6360_regulator_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_PGB_EVT, "buck1_pgb_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OC_EVT, "buck1_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_BUCK1_OV_EVT, "buck1_ov_evt"),
@@ -279,9 +279,6 @@ static const struct resource mt6360_pmic_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_OC_EVT, "ldo7_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO6_PGB_EVT, "ldo6_pgb_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO7_PGB_EVT, "ldo7_pgb_evt"),
-};
-
-static const struct resource mt6360_ldo_resources[] = {
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO1_OC_EVT, "ldo1_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO2_OC_EVT, "ldo2_oc_evt"),
 	DEFINE_RES_IRQ_NAMED(MT6360_LDO3_OC_EVT, "ldo3_oc_evt"),
@@ -299,10 +296,7 @@ static const struct mfd_cell mt6360_devs[] = {
 		    NULL, 0, 0, "mediatek,mt6360-chg"),
 	MFD_CELL_OF("mt6360-led", mt6360_led_resources,
 		    NULL, 0, 0, "mediatek,mt6360-led"),
-	MFD_CELL_OF("mt6360-pmic", mt6360_pmic_resources,
-		    NULL, 0, 0, "mediatek,mt6360-pmic"),
-	MFD_CELL_OF("mt6360-ldo", mt6360_ldo_resources,
-		    NULL, 0, 0, "mediatek,mt6360-ldo"),
+	MFD_CELL_RES("mt6360-regulator", mt6360_regulator_resources),
 	MFD_CELL_OF("mt6360-tcpc", NULL,
 		    NULL, 0, 0, "mediatek,mt6360-tcpc"),
 };
-- 
2.25.1

