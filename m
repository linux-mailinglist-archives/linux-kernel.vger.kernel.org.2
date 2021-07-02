Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2389B3BA615
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 00:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231179AbhGBWyf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 18:54:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhGBWye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 18:54:34 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB13C061764;
        Fri,  2 Jul 2021 15:52:01 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id v20so18604483eji.10;
        Fri, 02 Jul 2021 15:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Yd46gkoCwEb4bTGA5aRlP58DFHDPO3UuhUys68/ZC8=;
        b=bkClNSNE2jrZuxkwQFwvzqYVpbVaVUkuUQfC20fX85VHhdo9i4PbgIHjOP06E+SXJN
         OV9CdGtHQw0729surn/NPaP5dg4mXUp8lbTxTQ5hJpp7CBp+W7W6L97Fat8zsO3pA4eu
         u7xtNP6Shb/NKJVto8qDdeI2oa4KNYqTGDVZSolIIxIOfRQC0az+8KeNuW0ziVDdeLPN
         zX7A33eTJFTS9Q1ubW/6xySa1/ymvqICSENj7NWoBw+Fdc0QclPy1jtPYdTiNikglloD
         0L1dyC1G07QqYrOnbHTP0YQ64gVmZP9LZJeN9W/m7akvG0FbcTmU+pJr+OyekcpH5aq0
         8uOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Yd46gkoCwEb4bTGA5aRlP58DFHDPO3UuhUys68/ZC8=;
        b=KUO3yZA2NeXvLDJQYJvC2efv13xtlYNkFp9gNZZvTSgRlCJ5OppUrzvwIsVr44Ay8L
         Yik3JGt2NnYeMKspib5NdwKxdjjE1PMT0uL1Ug9KN7mLBxaUxTEbOLrZ+hy/meI+iP+7
         05PXYrAjmMQLTkXQNuftRnivb2KcQq5aR1FgAth9qHKGC/vBWo1IOu4p3c8UMIouguQU
         VsNxDiJ93F9GAMHF5KNHFYj8Wt9DgVxHVWR3GS5N8uhAmLSxGHR+EpObHiMvRQVP0BdI
         UvAPFW/KFDOQ4qNBEPK60+zbnaOf07M2eGT8uqpOx1kBZsDHZAIjGVpYvyC0Hxo377dI
         /YpQ==
X-Gm-Message-State: AOAM533mL3ml5OeHhKTxMqLDUAY2A5cIsx7onZiwAZQCFVUfDQf4U78b
        SpWOgATstHQGcNvO5+Amci42IfcnSJ8=
X-Google-Smtp-Source: ABdhPJyf+1YH/WcpezdktAW8H6mMs6mfjeqZzfgwQ8aed0fcIxRyHYH8d9w3oilIshsRCQSPuOaCYA==
X-Received: by 2002:a17:907:72ce:: with SMTP id du14mr2006899ejc.529.1625266320484;
        Fri, 02 Jul 2021 15:52:00 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-063-046.95.117.pool.telefonica.de. [95.117.63.46])
        by smtp.googlemail.com with ESMTPSA id r17sm1866964edt.33.2021.07.02.15.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:52:00 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-clk@vger.kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Subject: [PATCH v1 2/6] clk: imx: clk-divider-gate: Switch to clk_divider.determine_rate
Date:   Sat,  3 Jul 2021 00:51:41 +0200
Message-Id: <20210702225145.2643303-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
References: <20210702225145.2643303-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

.determine_rate is meant to replace .round_rate in CCF in the future.
Switch over to .determine_rate now that clk_divider_ops has gained
support for that.

Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Abel Vesa <abel.vesa@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/imx/clk-divider-gate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/imx/clk-divider-gate.c b/drivers/clk/imx/clk-divider-gate.c
index 0322a843d245..26b210cba9be 100644
--- a/drivers/clk/imx/clk-divider-gate.c
+++ b/drivers/clk/imx/clk-divider-gate.c
@@ -64,10 +64,10 @@ static unsigned long clk_divider_gate_recalc_rate(struct clk_hw *hw,
 				   div->flags, div->width);
 }
 
-static long clk_divider_round_rate(struct clk_hw *hw, unsigned long rate,
-				   unsigned long *prate)
+static int clk_divider_determine_rate(struct clk_hw *hw,
+				      struct clk_rate_request *req)
 {
-	return clk_divider_ops.round_rate(hw, rate, prate);
+	return clk_divider_ops.determine_rate(hw, req);
 }
 
 static int clk_divider_gate_set_rate(struct clk_hw *hw, unsigned long rate,
@@ -154,12 +154,12 @@ static int clk_divider_is_enabled(struct clk_hw *hw)
 
 static const struct clk_ops clk_divider_gate_ro_ops = {
 	.recalc_rate = clk_divider_gate_recalc_rate_ro,
-	.round_rate = clk_divider_round_rate,
+	.determine_rate = clk_divider_determine_rate,
 };
 
 static const struct clk_ops clk_divider_gate_ops = {
 	.recalc_rate = clk_divider_gate_recalc_rate,
-	.round_rate = clk_divider_round_rate,
+	.determine_rate = clk_divider_determine_rate,
 	.set_rate = clk_divider_gate_set_rate,
 	.enable = clk_divider_enable,
 	.disable = clk_divider_disable,
-- 
2.32.0

