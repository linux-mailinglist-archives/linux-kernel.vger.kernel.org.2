Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1758230F3B7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 14:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236301AbhBDNM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 08:12:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbhBDNM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 08:12:27 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F692C061573
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 05:11:46 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id j21so238949wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 05:11:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XHpCqY3+e6XVnsv3h2zCtkKd/6jd0Ce4KQqnlJfkPlk=;
        b=L8rxkW6o4Wy+af+1cYbNPRz3rEV8RELj5QtBMm776nBM2T3hBIbSwDKIJCX66EDA4S
         cP7ccmorLUb45N1Ze/8KiDzdYKIZNAKpg86O61k/1BA7nuIjz3s4EcKVC0w9zafnfprB
         T0+FP51YGK0uTKgStYbCAj0C5xivsRE8F3sUJYOZ37Wx0yxlW62uMJ4t7YxdJQtciPi/
         gH9tz9jwIs2avXAg+DyPpsz2g+TQzWwW9G2mvnhr2RgzGV5j/4xNK1oT741BJD9CtPSX
         7UstaVyy5Kj9726Z1dzNxjOvqeGY10BWM4EJbKU5MlyWPwohcZMEzUQkf4Na1jpeerLX
         dpBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=XHpCqY3+e6XVnsv3h2zCtkKd/6jd0Ce4KQqnlJfkPlk=;
        b=qb4FtSobOHLuYVPoJhES/b/7q1pkcjmm1Ea8Ab8S8YPAjFrQL31wPDsoF8bJHcJsNM
         Q7aQ1R3b8/1ZGmXObbOPuySslxWgU6VI4EJYkqdTrQK6txuFmkHwdCaeCi+TYjJ1BTxC
         enMVcZBCY7rYP5X3tTOq8HQK3faWJRHv4G3jL2U5xan15RYPF2D+zbmlAQUB5vsXE1Xl
         iRoTv6JOkDfC6p0nCd9FYwWltvc1lqKg3ccvFYvzQ5OeNju6sTBMW/0A/y+G+w8vfdfZ
         BXx8cdUmRsDy/lqEwZQuFO8DXZt7tC8rmpvHRZ/PjWIMJcFlvWDGvSroUQDnlwpItEnd
         4kWw==
X-Gm-Message-State: AOAM530U4QUEEDlcWw+MjbZ3be9mCzxsMJzHNwbYXKnhXIRUR6131sOB
        TRoYigq5ut4rWb7dJMS431nGTI4si4OxsYo4
X-Google-Smtp-Source: ABdhPJzDKgsnv+YzL06X+JT1pMgIDNYOASBCRI47Y70DO8HRzoG3qOIKC2nYpWhPHDc0HAwhHlOHvw==
X-Received: by 2002:a05:600c:4f48:: with SMTP id m8mr7553017wmq.12.1612444304619;
        Thu, 04 Feb 2021 05:11:44 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id 62sm6299317wmd.34.2021.02.04.05.11.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Feb 2021 05:11:44 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Anurag Kumar Vulisha <anurag.kumar.vulisha@xilinx.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Vinod Koul <vkoul@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH] phy: zynqmp: Simplify code by using dev_err_probe()
Date:   Thu,  4 Feb 2021 14:11:42 +0100
Message-Id: <0df30548f721b10475a6cc5659beda102fec3c87.1612444300.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use already prepared dev_err_probe() introduced by commit a787e5400a1c
("driver core: add device probe log helper").
It simplifies EPROBE_DEFER handling.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 drivers/phy/xilinx/phy-zynqmp.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/phy/xilinx/phy-zynqmp.c b/drivers/phy/xilinx/phy-zynqmp.c
index 2b0f921b6ee3..2b65f84a5f89 100644
--- a/drivers/phy/xilinx/phy-zynqmp.c
+++ b/drivers/phy/xilinx/phy-zynqmp.c
@@ -874,13 +874,10 @@ static int xpsgtr_get_ref_clocks(struct xpsgtr_dev *gtr_dev)
 
 		snprintf(name, sizeof(name), "ref%u", refclk);
 		clk = devm_clk_get_optional(gtr_dev->dev, name);
-		if (IS_ERR(clk)) {
-			if (PTR_ERR(clk) != -EPROBE_DEFER)
-				dev_err(gtr_dev->dev,
-					"Failed to get reference clock %u: %ld\n",
-					refclk, PTR_ERR(clk));
-			return PTR_ERR(clk);
-		}
+		if (IS_ERR(clk))
+			return dev_err_probe(gtr_dev->dev, PTR_ERR(clk),
+					     "Failed to get reference clock %u\n",
+					     refclk);
 
 		if (!clk)
 			continue;
-- 
2.30.0

