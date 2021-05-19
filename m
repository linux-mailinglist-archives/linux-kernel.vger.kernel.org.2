Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD3F3888AB
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 09:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243683AbhESHwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 03:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243226AbhESHwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 03:52:03 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 644C0C061760
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 00:50:44 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id h20-20020a17090aa894b029015db8f3969eso2365433pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 00:50:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SHfnoSjpeSA7P7SyDHgJJjYJgXT2xogBrtIgLEZ6Eo4=;
        b=TJ4pSjtkJLRPEOmhgq92BMOrkvLx9ljoeW5Gdhau68hkiDWzWM0SPRdo6TyP4v+7Q/
         4oLNy/grrZInGPuqplAvyXeSlFF2/iC+65ZxnmKPj/EdYzJjZi//Inc8HDXpY0MH6PbA
         bB6wbCkUUCVMiNjhDiD9ZBKiTUn6SLmKRx4glIxQasg/kf5WZ3yVLPP4qpqL9Cimg93L
         G3upToea1gC2ZAezzPfTEJWaNe4/4xWTOoCPRxtRfXn2XYl15b7u+TIlQnkNR1scTkAV
         xJd6eiR7ag68jjc4pGrYOJ+J3BmnRCLIyqWOH3p9G7KkcLzf3lHWj9eAmA2gp3sk2Fqq
         CZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SHfnoSjpeSA7P7SyDHgJJjYJgXT2xogBrtIgLEZ6Eo4=;
        b=nCwgm1khqt5Vql+HemsFdNYTx+czpgXotRIpnKr7uBf5ZBlTusFOHLrJLJDvdsO/AV
         nWEHj0pvtz/k1tBEdEVA1OEfxa1y+8bd9QwNCHRkloVr7tYsWYMts6M9tU/sUWM0uKOc
         MJRXqBH7fTEgihIGF+li1HG0bpCUetsH94MZlp2JYa6v8MQxJSB7f7tW9EjCmi4pXM01
         uyn3RRg/ZmEdYhE1dNwBbDWk8LSTs/TNd7Mfh8FLnPK74WE7u4V/mjR0N6EPWoqFLzgp
         ty0q81xQ0/WQ9Z0l7GBfNX3kb+4qc+dTYjRbHc41er7kHmhEQUhZ5/SNB4QSgusnp/KW
         /+ZQ==
X-Gm-Message-State: AOAM531IRhju1Cl7QW+wNC58HgZF63NUdze0JqAms4iHPpQ3HWTvfk5z
        5WFVAqMQRyLjUqra+XJW62qn4Mk3+sosked6
X-Google-Smtp-Source: ABdhPJwYek/LvJhQOnxnJQ/2HyjTJZjZcY2ALVu2ceS7vspxyOc84gCSTPj8GxnlwW5Ebf1xmroLVw==
X-Received: by 2002:a17:902:7281:b029:ea:afe2:b356 with SMTP id d1-20020a1709027281b02900eaafe2b356mr9629734pll.16.1621410643809;
        Wed, 19 May 2021 00:50:43 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id t1sm14301560pjo.33.2021.05.19.00.50.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 00:50:43 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: Check ramp_delay_table for regulator_set_ramp_delay_regmap
Date:   Wed, 19 May 2021 15:50:24 +0800
Message-Id: <20210519075024.1644990-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Return -EINVAL if ramp_delay_table is NULL.
Also add WARN_ON since the driver code needs fix if this happened.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/helpers.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index 0e16e31c968f..1e61fec4636e 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -948,8 +948,10 @@ int regulator_set_ramp_delay_regmap(struct regulator_dev *rdev, int ramp_delay)
 	int ret;
 	unsigned int sel;
 
-	if (!rdev->desc->n_ramp_values)
+	if (!rdev->desc->n_ramp_values || !rdev->desc->ramp_delay_table) {
+		WARN_ON(!rdev->desc->n_ramp_values || !rdev->desc->ramp_delay_table);
 		return -EINVAL;
+	}
 
 	ret = find_closest_bigger(ramp_delay, rdev->desc->ramp_delay_table,
 				  rdev->desc->n_ramp_values, &sel);
-- 
2.25.1

