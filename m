Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E4B238D96D
	for <lists+linux-kernel@lfdr.de>; Sun, 23 May 2021 09:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbhEWHY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 May 2021 03:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231561AbhEWHYz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 May 2021 03:24:55 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2691C061574
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 00:23:29 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 29so6655455pgu.11
        for <linux-kernel@vger.kernel.org>; Sun, 23 May 2021 00:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8urE1FwcNJWb+S178YjjI1BKDx3hGjCJcKzWhu7QgrE=;
        b=ImHSNvEUCN1KN86KnEw4+lp+mRxLHr04OQriEJTtOQYnIXeRf5naL40XwShDV0zid/
         pJHzt2xhfKmiOyz9XTnJj10WgnbnDjCNKtfE7xRlV3XznhhCN2QTjv7jntEq/MQJ4zy5
         qJW8Wda/BEwsMUFwkbaGFuPKpIXcLw9Kha86fQ+Gi/lhF4xucbmsZEtPGktPEczAoqZA
         6tD+ikh48pfP5zdO7XtWNvEM/bDXINPE5g9FBUn0QraY2K/sICQWL9kHAYxm98xCrrnD
         Aj/BCEquF5mmxdKbxXJwi9A0t8q60GPPfMFSTzBNybq95skQ2N7qIhLloe278cgj89Nt
         aaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8urE1FwcNJWb+S178YjjI1BKDx3hGjCJcKzWhu7QgrE=;
        b=sm9BVxRw7mPixRdQXESoqXvNhFOzleibLVBjY6bMIvfFucqWnNmpFiw+SRY6yQNvYB
         Gm5B6cTtlQnf9PGSnXV9U02aA39KhFdbNl6Wr9fkwdMzdEvWLR72lCYdpIJMrV9iMdaY
         ln5ZD3z1o1GQbxUbKpkoD/kgCCzo4IChzc04jENNhAlAWj4DPkZJ+kha3q/9ltQhv86a
         Zj8QQHJ6jqE/lyMTxFeBAm99g5LvwyPoCGTIflH0DXiFTY2qG5fQsRsTD+gaqia5dB7g
         DKCQUriiQ6AODXYlK5VK54GCVftJaVD7u9UkVBO5DhWbuxI98l5eOKBoTbkekutssHD9
         Oa8g==
X-Gm-Message-State: AOAM530ULe8GJObKrbCtG32rgCYKy8wrK273w9GHiCDv/I3itDDhS10N
        98zeNlj9QwQO700EEHuDHwqksw==
X-Google-Smtp-Source: ABdhPJypCx4bEoFK+EKdzdU/3Ea/iH1BZBYQLPmgxhfrr2ElDddBq2YcxRtmHyLjVUZMrxggw0RvPw==
X-Received: by 2002:aa7:8b56:0:b029:2b9:77be:d305 with SMTP id i22-20020aa78b560000b02902b977bed305mr18754594pfd.61.1621754609224;
        Sun, 23 May 2021 00:23:29 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id u1sm8719861pgh.80.2021.05.23.00.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 May 2021 00:23:28 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Javier Martinez Canillas <javier@dowhile0.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH 1/2] regulator: max77802: Remove .set_ramp_delay from max77802_buck_dvs_ops
Date:   Sun, 23 May 2021 15:23:19 +0800
Message-Id: <20210523072320.2174443-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

max77802_set_ramp_delay_2bit() returns -EINVAL when id > MAX77802_BUCK4.
This was a leftover in commit b0615f1da543
("regulator: max77802: Split regulator operations for BUCKs").

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/max77802-regulator.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/regulator/max77802-regulator.c b/drivers/regulator/max77802-regulator.c
index 7b8ec8c0bd15..903c6fc10efb 100644
--- a/drivers/regulator/max77802-regulator.c
+++ b/drivers/regulator/max77802-regulator.c
@@ -345,7 +345,6 @@ static const struct regulator_ops max77802_buck_dvs_ops = {
 	.get_voltage_sel	= regulator_get_voltage_sel_regmap,
 	.set_voltage_sel	= regulator_set_voltage_sel_regmap,
 	.set_voltage_time_sel	= regulator_set_voltage_time_sel,
-	.set_ramp_delay		= max77802_set_ramp_delay_2bit,
 	.set_suspend_disable	= max77802_set_suspend_disable,
 };
 
-- 
2.25.1

