Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B41A3AD9FC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Jun 2021 14:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234128AbhFSMgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Jun 2021 08:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbhFSMgq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Jun 2021 08:36:46 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70887C061574
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 05:34:34 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id t8so5232682pfe.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Jun 2021 05:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lnXkJrK3bbKfbG2bmCLaRAAKC3eTSFYqLBXTuAJNf/M=;
        b=T+/kVZQDtcu6pepiucvXtHV7rqFV4eI+q3St1JDkyUw6Lq9OyyCq+zAowtqzfF8Rk7
         /wqO5JetHMyjZrXZsGA8ZO7+vLTa4LZt60I4L9BasV2QyAWW45yTELNOI99AfMD7Cq9g
         uyh+oX/71RnSRDM3TlWSiKRDTh97ERPg5OTX/nqLFQGXdXsg5YeJvQB46vwLD0DnyhZU
         6puqJKHyeZc3Vhv8K3VE0Rp603ofegrvpKghQ2Odedu5rVfjpLZSLBTJvnaapF6HMAPk
         vTEkhiR3o3+bQZy2Y8vGE0zoizyIcNbxyqq9vql2LQEUqeXlNLHrKtzSMlGqNxB15/pc
         nqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lnXkJrK3bbKfbG2bmCLaRAAKC3eTSFYqLBXTuAJNf/M=;
        b=Lh4WQTZzep0agxzWnVnkuHNix3BkEjNM/sRqqddeur781+2Me2dvgyDY3oLFz0PxmZ
         uIPhuF16jJAKsOlYJ+CMF/gZXAEjKontEFUPOfQ5dhmZCjbBgZtqdEtpBv8uAQ0o+nDS
         H8ADT42oIEiV2zdK/GtfpBJ0w5aWImwoSPwMpkiWsdVJNe/Nwwh9Xqqr5NK6gIuVLoM+
         xoQYd7m9KJSNdYV1EyJrIc+xSPOfh0dNsd0ay5HsVqIRa0oeq9hy2um2sHexpkzBf8JC
         uA3RwmRpdjHM2n8l4/4zqT5tW6b3oFaXZbghwQY7I+nRrQfBwWVGXWP3tLQvbulPbm3S
         7Piw==
X-Gm-Message-State: AOAM5332iHUStLsi0kHsSif1TBn+KxzTuPcfl0WxPt1D5NG3iPzYetjA
        fNHivxB5GZ6hptlyLJeNxTLhlrhwkrUihPCc
X-Google-Smtp-Source: ABdhPJzJuBg+TnHM/T91eUyT0X8xLHuJ+GhkcrwiUOxeCKCC2Ykuo/ZunEa8AOacriuKBwUXUw6hzA==
X-Received: by 2002:a65:5684:: with SMTP id v4mr14327702pgs.218.1624106073679;
        Sat, 19 Jun 2021 05:34:33 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id co18sm1606997pjb.37.2021.06.19.05.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Jun 2021 05:34:33 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: hi6421v600: Fix setting idle mode
Date:   Sat, 19 Jun 2021 20:34:23 +0800
Message-Id: <20210619123423.4091429-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit db27f8294cd7 changed eco_mode << (ffs(sreg->eco_mode_mask) - 1)
to sreg->eco_mode_mask << (ffs(sreg->eco_mode_mask) - 1) which is wrong.
Fix it by simply set val = sreg->eco_mode_mask.

In additional, sreg->eco_mode_mask can be 0 (LDO3, LDO33, LDO34).
Return -EINVAL if idle mode is not supported when sreg->eco_mode_mask is 0.

While at it, also use unsigned int for reg_val/val which is the expected
type for regmap_read and regmap_update_bits.

Fixes: db27f8294cd7 ("staging: regulator: hi6421v600-regulator: use shorter names for OF properties")
Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/hi6421v600-regulator.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index b5a19938fd3a..9a68ef251de6 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -117,7 +117,7 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
 {
 	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
-	u32 reg_val;
+	unsigned int reg_val;
 
 	regmap_read(rdev->regmap, rdev->desc->enable_reg, &reg_val);
 
@@ -131,14 +131,17 @@ static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
 					  unsigned int mode)
 {
 	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
-	u32 val;
+	unsigned int val;
 
 	switch (mode) {
 	case REGULATOR_MODE_NORMAL:
 		val = 0;
 		break;
 	case REGULATOR_MODE_IDLE:
-		val = sreg->eco_mode_mask << (ffs(sreg->eco_mode_mask) - 1);
+		if (!sreg->eco_mode_mask)
+			return -EINVAL;
+
+		val = sreg->eco_mode_mask;
 		break;
 	default:
 		return -EINVAL;
-- 
2.25.1

