Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAFE336A05
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 03:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbhCKCGo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 21:06:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhCKCGY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 21:06:24 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED0CC061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 18:06:13 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id z5so9462917plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 18:06:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=coDvSDUBJQPVLSZkKZ05ZugBq5eL94Od5GZjs8z9wn8=;
        b=gdHxWYFB8lai36v50M2CSU1yrASaAV1VmyWv8xtPnO+qcVWOCkQxM8fCSpF5eyo5hQ
         2oDKkm9OeHIiMba1zj64m2IZjSQl5951ysENMhpUDupEXIDOXWC0roIUnDx/7SgdLt+N
         O1LedtLo5lSCdCYxmGjxaCWVMw/bhDdCwS1sSSnIZ+RfBjNNhS3uZQTujEnPAa6NazUi
         LLZIh1q/FUSw0eeUyJGKttPnQOIREqIQ+ypbg9fdL0cpo//BiIUNUdxShMQi9z0Jvhzf
         t1E0Ss5/fXWxDMk8+xWrp9Hrqt0T8cKapx8m8vqxoY25+VbeImmdhwmYKUDueLrgirYv
         4oCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=coDvSDUBJQPVLSZkKZ05ZugBq5eL94Od5GZjs8z9wn8=;
        b=U2aLbdYSx9tQeXnChWHf0q46jGvrCc9brg92uCiL2EgczAEEoB8In+zYO1R1axi5O3
         4AXn8aiETof1t1Vw0Zhi6B6v4zb6R/O4Nhc4WEwmJym2S0fZqN9hEfdBiYqjoLIcQN/2
         x4nWGxJyFaBptXrmwLpRM8rvpeTh4LbcRUoHDBVhSrB5kiwXDIzN6By33Pg5EMrn/f1Y
         g1rJCEvOE2pg+6KWw9GyH9Esinpbwu68YICfd288H6WTmiI2dMFs7AqBP1c0fL+fXULt
         88Fyb7TnZ/EE0vp+JD1DK4qLx+MXyTZs4jXvIq/r0sVOqGkHYu+L6YQyIc5UriRNk5H4
         ZSEw==
X-Gm-Message-State: AOAM530TUtH0/Gsh6GGvqvr7IKJYV/qk97Rc4Ccp3fOpzkqguFHA87Db
        1P8nbvHJfTsZ7ZoWNli/E+Uzb9FZtsHsww==
X-Google-Smtp-Source: ABdhPJw/rjlo1qIMK8WD0HnTLz++v2zCHesg6Nq636iyUeOEzrvvVunQqU1rbsniS5sPmSwRNBdt3g==
X-Received: by 2002:a17:902:8b86:b029:e5:bef6:56b0 with SMTP id ay6-20020a1709028b86b02900e5bef656b0mr5875971plb.76.1615428372971;
        Wed, 10 Mar 2021 18:06:12 -0800 (PST)
Received: from localhost.localdomain (220-133-186-239.HINET-IP.hinet.net. [220.133.186.239])
        by smtp.gmail.com with ESMTPSA id s19sm688941pfh.168.2021.03.10.18.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 18:06:12 -0800 (PST)
From:   Axel Lin <axel.lin@ingics.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org, Axel Lin <axel.lin@ingics.com>
Subject: [PATCH] regulator: mt6315: Fix off-by-one for .n_voltages
Date:   Thu, 11 Mar 2021 10:05:58 +0800
Message-Id: <20210311020558.579597-1-axel.lin@ingics.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The valid selector is 0 ~ 0xbf, so the .n_voltages should be 0xc0.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
---
 drivers/regulator/mt6315-regulator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/regulator/mt6315-regulator.c b/drivers/regulator/mt6315-regulator.c
index fc7654624dd6..9edc34981ee0 100644
--- a/drivers/regulator/mt6315-regulator.c
+++ b/drivers/regulator/mt6315-regulator.c
@@ -41,7 +41,7 @@ struct mt6315_chip {
 		.type = REGULATOR_VOLTAGE,			\
 		.id = _bid,					\
 		.owner = THIS_MODULE,				\
-		.n_voltages = 0xbf,				\
+		.n_voltages = 0xc0,				\
 		.linear_ranges = mt_volt_range1,		\
 		.n_linear_ranges = ARRAY_SIZE(mt_volt_range1),	\
 		.vsel_reg = _vsel,				\
-- 
2.25.1

