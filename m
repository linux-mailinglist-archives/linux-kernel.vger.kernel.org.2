Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C797D3F9883
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 13:41:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbhH0Lmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 07:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbhH0Lmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 07:42:31 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2768C061757
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 04:41:42 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d17so3736033plr.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 04:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=itfac-mrt-ac-lk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=mGpH5mvYecvwlCQ8u2SHdQPH4lb1tr2RmaIwutOOIpo=;
        b=yAeswcrBqfgkHPkxXbxBYRCTM1ss+RtFy8k2TIQe7lO/YP7yO0he7KCaivhVA2wjdQ
         wq2hG8o6/3CIAW/GIh5lk2Qm6dTtl1XSxPai0k8p4tmb5i/dUakXBLwOdaYZ7jgsUS8C
         cb7qfzc1afzkoG3ekB/85O2+1996VAqpxBIKho5PskjWBSCo5AxgySSQHiJCiLqqXY2U
         kaZJ0Bm13g6iRsUeOFuVH/YNQyrj2Nq6ubC8Ul9YivP7RCCYY9HBNWYsaxF4cxZlJtzI
         r1scPaqPfP2DSRk+RKy1kZlRcTWq51iQbORnVM/6H03mk+OkXi+R7rsklk07oSDTcPiT
         g+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=mGpH5mvYecvwlCQ8u2SHdQPH4lb1tr2RmaIwutOOIpo=;
        b=cMLL5xDTZuthASmimWjwADcX/ZPDSCiPrsN0tz1nCG/cKf6+vgH06Kf9fktz/JKQjU
         I+CNoCKLePZK74JFuNoCVl4H2Ne/yOR3XNE6xe8m2wpVt2pftG+R/9JoExBTgUwBOBw7
         q6WCQHfVBf6cNp3cE9SA4aQu/iqr+yOfxoWvMaWRFpLXmiXCHLDUI4laXWFtUkBxBcMM
         n62jAPYsP+AkGTdfDaS/7uzSot055U5iM/XuQxR7Aw6sZ/G/HWmG5jI/OIV05eo1yGjl
         NmAok3xz5zTpKf9bsiWtMSPVxpzKsDzUaGHq4zgAsL2xcxOXcegq9VzPfZpsGpcchjGg
         zT/Q==
X-Gm-Message-State: AOAM533cu5owq+zCQ2xNGfa4DGBqh9eOs7Fy28Wtiz5Xr6w2td24LDIN
        eR5UE/1TF/JddRPXrdiFllsZ
X-Google-Smtp-Source: ABdhPJyEBx8IHEJhRdJ/KkDw4FOc5Vq3z8Q5+PGGvfxtplxN/JfH8vBByqeOI8eJ/9EdufbTYektgA==
X-Received: by 2002:a17:90b:1d0c:: with SMTP id on12mr23008283pjb.12.1630064502206;
        Fri, 27 Aug 2021 04:41:42 -0700 (PDT)
Received: from localhost.localdomain ([123.231.122.209])
        by smtp.gmail.com with ESMTPSA id i11sm5977457pfd.37.2021.08.27.04.41.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 04:41:41 -0700 (PDT)
From:   "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>
To:     mturquette@baylibre.com, sboyd@kernel.org
Cc:     "F.A.Sulaiman" <asha.16@itfac.mrt.ac.lk>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] clk: fix passing zero to warning in clk_hw_create_clk()
Date:   Fri, 27 Aug 2021 17:11:15 +0530
Message-Id: <20210827114115.15255-1-asha.16@itfac.mrt.ac.lk>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch has reported passing to zero warning in ERR_CAST.
"drivers/clk/clk.c:3673 clk_hw_create_clk() warn: passing zero to 'ERR_CAST'"

This patch resolves it by using IS_ERR instead of IS_ERR_OR_NULL.

Signed-off-by: F.A. SULAIMAN <asha.16@itfac.mrt.ac.lk>
---
 drivers/clk/clk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 65508eb89ec9..cf47526789af 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -3669,7 +3669,7 @@ struct clk *clk_hw_create_clk(struct device *dev, struct clk_hw *hw,
 	struct clk_core *core;
 
 	/* This is to allow this function to be chained to others */
-	if (IS_ERR_OR_NULL(hw))
+	if (IS_ERR(hw))
 		return ERR_CAST(hw);
 
 	core = hw->core;
-- 
2.17.1

