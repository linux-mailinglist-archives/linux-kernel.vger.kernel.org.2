Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21E33A7FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 15:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231611AbhFONcx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 09:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhFONcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 09:32:35 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D583C061283
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:30:19 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id g6so13277286pfq.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Jun 2021 06:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfA//XDHk1xzo5Tdw2AS+yBhajvzEWoalpaqlgn4ZH0=;
        b=gPhSVWLgF5fmuFfMChFsixIyyamjYlbXA1ogmmbfKRpMI72JJpEo5nDz5Ah5ae/38A
         TM0Pz6hsqamnQl7m0DqLgchNiyBXadmyNBw/Dn6U1IFskDAa0gXqviVuNA25NzS2c+5x
         ZuRWXHDdxXieBzI9oddMhk7f8ku5gcDTwH6ikWbvlubq6fIixE8jD+zl7IWdbJQ8eSuD
         04+jfXxDgLNNGtoVb0ZbZsWCjypI8Ck1Pp2IOrdchZDWacDaGHDwYvz4PHyRJ1/4c1Vn
         W+SerYVYPqow41piW+23bhm8qTNsWtpPQwnuPpkofc3cCz4dTHrl2Q+Hq/lfUWHRvAs/
         lYig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qfA//XDHk1xzo5Tdw2AS+yBhajvzEWoalpaqlgn4ZH0=;
        b=Uoa5UOQkQ+EGq0OwMlnKpv26dVVV7YJUtgiwTj06Uz3CI9mA1iMHWECYPhVAnUsuyQ
         8vsNVsqyLMIYnidFu71vhXiexyoh4moow5tWn7B0p88EOurHQC8KUVzi2oH7pOG2biVq
         qRda5g4E5DxJpJmkEy/7zIr3KCyaTbn36AlmOaMu2ZEdGlvLLD+h2+ECnHhItvPfAh0Q
         mxgTpBbbPxQKQkCqyq5TEO3nOLbxpadwxyMgzPUz0K2tG4ZKFGA7vIzYKmj4adXvv9/i
         ee2bjzbufNnTYKHs2fCJjuwt7APYLEz3r2g53BnTfl7HHvFENLwyWNeYe34SiLR6ZLBJ
         Zo1Q==
X-Gm-Message-State: AOAM531dktSpk/9nVJyF5e38Q0EMTQJaZo0Hv7f8P54gZbo67i+/BI1k
        GueXEIp1QQ4syelCdL3p2usdlHf6jLTbVk40
X-Google-Smtp-Source: ABdhPJx77s94sOI0pzxLaFZciG7hr0v347H3P247gjMUa/VBBOQAToIVBHmz0N/LRNTEr4eZ2ZsxgA==
X-Received: by 2002:aa7:9983:0:b029:2e9:e086:7917 with SMTP id k3-20020aa799830000b02902e9e0867917mr4487116pfh.57.1623763818835;
        Tue, 15 Jun 2021 06:30:18 -0700 (PDT)
Received: from localhost.localdomain (122-117-179-2.HINET-IP.hinet.net. [122.117.179.2])
        by smtp.gmail.com with ESMTPSA id n69sm15914245pfd.132.2021.06.15.06.30.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 06:30:18 -0700 (PDT)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mt6315: Fix checking return value of devm_regmap_init_spmi_ext
Date:   Tue, 15 Jun 2021 21:29:34 +0800
Message-Id: <20210615132934.3453965-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

devm_regmap_init_spmi_ext() returns ERR_PTR() on error.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6315-regulator.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/regulator/mt6315-regulator.c b/drivers/regulator/mt6315-regulator.c
index 865a292bedcb..284c229e1aa4 100644
--- a/drivers/regulator/mt6315-regulator.c
+++ b/drivers/regulator/mt6315-regulator.c
@@ -223,8 +223,8 @@ static int mt6315_regulator_probe(struct spmi_device *pdev)
 	int i;
 
 	regmap = devm_regmap_init_spmi_ext(pdev, &mt6315_regmap_config);
-	if (!regmap)
-		return -ENODEV;
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
 
 	chip = devm_kzalloc(dev, sizeof(struct mt6315_chip), GFP_KERNEL);
 	if (!chip)
-- 
2.25.1

