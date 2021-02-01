Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF69E30AF06
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbhBASVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:21:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232335AbhBASPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:15:40 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16DFDC06174A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 10:14:27 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id y142so4154265pfb.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 10:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nr70diwKm9rfL7MM7qHNXTK5sP1+kROD5tDezAlipcU=;
        b=MweWa4R7QAtD77x3C6hFfsPVEwdDdzzg2MD23DvRQbnCZqpsh1VWYPKZhhTEiXxk7d
         o3GSAr6sxoiE+hut5dWYJka3Fqcjrgebg2NkGx7paQu7MLA+ryo5Dxl+PJ1krr6axQmJ
         BVZ/3nXL7XJwpEY6c4fXt4AaERVP+PgpPh+/+5J1ysGDhkVmFz0vDV5f4Y+elbyeXk0c
         yTGofEMPyb6S94+d4oeJVf+HV64D2vYiOTYNBXcIYNIkv2Lc0OA2oI5QnUGqMFGXg8qH
         AWZMHBO2wMIbdtNPorCO175mb+9kwcJsgUH+pv3UFv5soO7tL6PDOwEmIMAYDqlvmPeI
         bFAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nr70diwKm9rfL7MM7qHNXTK5sP1+kROD5tDezAlipcU=;
        b=ppWePvzbdKscOq1ZQNY6sv2xhdyH1uDlP+m0rqUq32htTY+BYgY0TaGqP6W+PuwqC2
         emPzhq0HpWzmvNQ6ZdcTZoBosyUvu/l+p7cx4osB3ItVF+naBKdfPDYJsipfl6uiiKpW
         0X8iZGFY8hHldbMrwMEIeo+zrf0e7/vPl2UeZSJTzhkezDIu0BF96cr4vnW8oPoZdWoa
         uPAVFozOpMfgsvW0Exc8BA/tB1nd66BBv32uRdkwHw+rpDMHFKhW1CRwpdn/HfjijYzj
         BtdFzi19+zQ22peKRJCq0m4FcgRY0B85kJlT+VBJtb0ADrTyODdHFGvs7wlYmQcJ88C/
         h0XA==
X-Gm-Message-State: AOAM530nOc5KHQ9jeH6vYJfw0wsV4j93T2R1rC1W2d8Qq0HGu3P0Mj7W
        ca9dhQHyT9buwP7xOfZULijTMA==
X-Google-Smtp-Source: ABdhPJwzdaVIdOZgQQgRIn5605WsBCr6WfU13mva0Y8/Hs+/Czbt+LpbG0ndGzNOxhoJR65jJJNgIQ==
X-Received: by 2002:a62:4e10:0:b029:1c9:9015:dc5b with SMTP id c16-20020a624e100000b02901c99015dc5bmr17643686pfb.30.1612203266668;
        Mon, 01 Feb 2021 10:14:26 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id e12sm75784pjj.23.2021.02.01.10.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Feb 2021 10:14:26 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 31/31] coresight: etm4x: Handle accesses to TRCSTALLCTLR
Date:   Mon,  1 Feb 2021 11:13:51 -0700
Message-Id: <20210201181351.1475223-32-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
References: <20210201181351.1475223-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

TRCSTALLCTLR register is only implemented if

   TRCIDR3.STALLCTL == 0b1

Make sure the driver touches the register only it is implemented.

Cc: stable@vger.kernel.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Link: https://lore.kernel.org/r/20210127184617.3684379-1-suzuki.poulose@arm.com
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etm4x-core.c  | 9 ++++++---
 drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm4x-core.c b/drivers/hwtracing/coresight/coresight-etm4x-core.c
index 473ab7480a36..5017d33ba4f5 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-core.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-core.c
@@ -306,7 +306,8 @@ static int etm4_enable_hw(struct etmv4_drvdata *drvdata)
 	etm4x_relaxed_write32(csa, 0x0, TRCAUXCTLR);
 	etm4x_relaxed_write32(csa, config->eventctrl0, TRCEVENTCTL0R);
 	etm4x_relaxed_write32(csa, config->eventctrl1, TRCEVENTCTL1R);
-	etm4x_relaxed_write32(csa, config->stall_ctrl, TRCSTALLCTLR);
+	if (drvdata->stallctl)
+		etm4x_relaxed_write32(csa, config->stall_ctrl, TRCSTALLCTLR);
 	etm4x_relaxed_write32(csa, config->ts_ctrl, TRCTSCTLR);
 	etm4x_relaxed_write32(csa, config->syncfreq, TRCSYNCPR);
 	etm4x_relaxed_write32(csa, config->ccctlr, TRCCCCTLR);
@@ -1463,7 +1464,8 @@ static int etm4_cpu_save(struct etmv4_drvdata *drvdata)
 	state->trcauxctlr = etm4x_read32(csa, TRCAUXCTLR);
 	state->trceventctl0r = etm4x_read32(csa, TRCEVENTCTL0R);
 	state->trceventctl1r = etm4x_read32(csa, TRCEVENTCTL1R);
-	state->trcstallctlr = etm4x_read32(csa, TRCSTALLCTLR);
+	if (drvdata->stallctl)
+		state->trcstallctlr = etm4x_read32(csa, TRCSTALLCTLR);
 	state->trctsctlr = etm4x_read32(csa, TRCTSCTLR);
 	state->trcsyncpr = etm4x_read32(csa, TRCSYNCPR);
 	state->trcccctlr = etm4x_read32(csa, TRCCCCTLR);
@@ -1575,7 +1577,8 @@ static void etm4_cpu_restore(struct etmv4_drvdata *drvdata)
 	etm4x_relaxed_write32(csa, state->trcauxctlr, TRCAUXCTLR);
 	etm4x_relaxed_write32(csa, state->trceventctl0r, TRCEVENTCTL0R);
 	etm4x_relaxed_write32(csa, state->trceventctl1r, TRCEVENTCTL1R);
-	etm4x_relaxed_write32(csa, state->trcstallctlr, TRCSTALLCTLR);
+	if (drvdata->stallctl)
+		etm4x_relaxed_write32(csa, state->trcstallctlr, TRCSTALLCTLR);
 	etm4x_relaxed_write32(csa, state->trctsctlr, TRCTSCTLR);
 	etm4x_relaxed_write32(csa, state->trcsyncpr, TRCSYNCPR);
 	etm4x_relaxed_write32(csa, state->trcccctlr, TRCCCCTLR);
diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
index b646d53a3133..0995a10790f4 100644
--- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
+++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
@@ -389,7 +389,7 @@ static ssize_t mode_store(struct device *dev,
 		config->eventctrl1 &= ~BIT(12);
 
 	/* bit[8], Instruction stall bit */
-	if (config->mode & ETM_MODE_ISTALL_EN)
+	if ((config->mode & ETM_MODE_ISTALL_EN) && (drvdata->stallctl == true))
 		config->stall_ctrl |= BIT(8);
 	else
 		config->stall_ctrl &= ~BIT(8);
-- 
2.25.1

