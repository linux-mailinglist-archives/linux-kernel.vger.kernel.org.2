Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E384C314A29
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 09:21:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbhBIIUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Feb 2021 03:20:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhBIIUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Feb 2021 03:20:43 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7537C061788
        for <linux-kernel@vger.kernel.org>; Tue,  9 Feb 2021 00:20:02 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id m6so11443602pfk.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Feb 2021 00:20:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zU44lqKZfuZa5WJ6YSMKYxpCeD9c1eY+nex3tkGFwBk=;
        b=qPqMf0zWe3zyWdr2Qchr0jORtbXnV5uaYbMTXt4WnFJcks169V9aehOzLsJWXp8f+G
         D/aOWKNpwGItLVT8ycseObdD5QUJurC9iXsdyJo37R5oq+/m9bV48/bXVnrFLcyIYe+Q
         jq++6zfErycPWeP0hncWq7qYYt/cAqXx+IYSbVKq+hdQMHYNSIRRexgG6cnDpzKMP61T
         KcQUIHsTuA3ZsNfoHgoIvlL7fFz5htuVtKxG/f8NFdZ63AqtkwPPgtkrEIViH0sajmH/
         JguR0+J9Q77vXwWpTZL4xwY1C091DmZHC24f6OiSwyJXqQ77mgB0EvsgFeCOwedF7gxk
         v5Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zU44lqKZfuZa5WJ6YSMKYxpCeD9c1eY+nex3tkGFwBk=;
        b=p9M9NYkeixCNrUzfucU0UH04k6hsxfo5X3KxQvxL7Jy/00dtbnbsSayU7fTQMTdxUt
         oKP6/w9fxLoJOy4KkuAv8yMB48Md0+aDRCaEQlbHYdzmBIdJHHszaONLfLfKvmFCbuti
         CBOLu5hPFttorWExjSaJ1Rb6vjWspGPrCZRCFNVUrtFpslF0+0BJPQO+B7bdfZ/ieIbF
         svE028WfBhnW5PvFseYQ7HSsPdy/11yRKQeN2vHbnhJMhmYu5S/6Fq04GlfqZkST/AHL
         7gV3z6iQd3BZc/+7IrcO7suZNvMCGKgngsoZuFOJxYjmD3XCF0myTTt1kCXkBZ37Cgun
         TbHw==
X-Gm-Message-State: AOAM533f8IKhN7OOm7QiXBh4mrDRFA/7WB2tWDgHsxG635c1vEaegca8
        oid39vy809q4lEXLVwm7kSc=
X-Google-Smtp-Source: ABdhPJwVDNTXY2OqlNwQ3lJEh+Ycf5UAfMfcq0D5qrhteeMDLM375h6ln369yMQOP/WZO4O6nqqDog==
X-Received: by 2002:a63:c60b:: with SMTP id w11mr2769704pgg.215.1612858802414;
        Tue, 09 Feb 2021 00:20:02 -0800 (PST)
Received: from localhost.localdomain ([106.198.21.213])
        by smtp.gmail.com with ESMTPSA id y16sm22011002pfb.83.2021.02.09.00.19.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 00:20:01 -0800 (PST)
From:   Atul Gopinathan <leoatul12@gmail.com>
To:     mchehab+huawei@kernel.org
Cc:     gregkh@linuxfoundation.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Atul Gopinathan <leoatul12@gmail.com>
Subject: [PATCH v2 1/2] staging: hikey9xx: change spaces to tabs
Date:   Tue,  9 Feb 2021 13:49:34 +0530
Message-Id: <20210209081935.3084-1-leoatul12@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following type of checkpatch error:
"ERROR: code indent should use tabs where possible"

Signed-off-by: Atul Gopinathan <leoatul12@gmail.com>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c     | 2 +-
 drivers/staging/hikey9xx/hi6421v600-regulator.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 2301f4fcd48d..9c5e113e1a81 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -177,7 +177,7 @@ static void hi6421_spmi_pmic_irq_init(struct hi6421_spmi_pmic *ddata)
 
 	for (i = 0; i < HISI_IRQ_ARRAY; i++)
 		regmap_write(ddata->regmap, SOC_PMIC_IRQ_MASK_0_ADDR + i,
-				        HISI_MASK);
+					HISI_MASK);
 
 	for (i = 0; i < HISI_IRQ_ARRAY; i++) {
 		regmap_read(ddata->regmap, SOC_PMIC_IRQ0_ADDR + i, &pending);
diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index c801bb840962..f6a14e9c3cbf 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -106,7 +106,7 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 
 	ret = regmap_update_bits(pmic->regmap, rdev->desc->enable_reg,
 				 rdev->desc->enable_mask,
-			         rdev->desc->enable_mask);
+				 rdev->desc->enable_mask);
 
 	/* Avoid powering up multiple devices at the same time */
 	usleep_range(rdev->desc->off_on_delay, rdev->desc->off_on_delay + 60);
-- 
2.27.0

