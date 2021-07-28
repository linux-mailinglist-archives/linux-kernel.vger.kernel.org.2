Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5FD93D94D9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 20:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhG1SBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 14:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231261AbhG1SBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 14:01:00 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117E7C061757;
        Wed, 28 Jul 2021 11:00:59 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id p38so1978300qvp.11;
        Wed, 28 Jul 2021 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rPqLjOXsqV94UI25n/9CxZKC1Erx0U3BkTkX0ji1T7I=;
        b=IbQtOFHYx1EjJ567K1P9YznQxwLwclrO6ezP9aDlFfDQdVBaFa0p14UXh2f5pEv2Ip
         ZVduQHDVa2ukcMv/h/gOEtdyhX82CwtnP9ND3hiKc7OzIboRSgUbosWOTtIeA2G4bmBD
         D81eVwcrwWFrEh/SncOy8qKPRZJGf13D5TCKDz5VuL0fYMLXI5ka3Jv0Ii3X4hKyXTUr
         tRBnTXUnyCX+ZuehdBZBK3Uh2WX3GGat1oWPtfVLsQW11XhcO8GGq9Sl4Bl5vTjPDCHv
         6zIX3jViB1Yb1h0bs8GFgVsBMiEw9spPPAcfABg/p8opslmK5YWrYldrKbnnoaiJOwEn
         h09g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rPqLjOXsqV94UI25n/9CxZKC1Erx0U3BkTkX0ji1T7I=;
        b=eUvYmfvaGuYM117KrdQ8NNYHWLuJcgaDxCVPkzV4GXeDOQC/3ZUIq/ko6veSYIHXGo
         nJ4bapI8g9uz0VYNyM0T9Rww+BCICtK831l/9mXZ5qZMCxomOPrQbNk0ulJRy4/npLj1
         NcdnzgdZELIOfZ3cCsaja/y1xKPzlCy+htdyg2PLupU9WP6YkARCFizWVoYiLjbqTo/Y
         hhktnthWjzodO7l6p+BPQaIlaaXtzooYcMAuKZz7P54SMhr486okWOguMIiTIYhzxV4z
         r+52GC9W8pBUQPA+mbH226nMV8Ag3Ga/eLfkPhUCxF2tvSF2Qi3RgZM8pL4WLRxUzVNF
         vrMw==
X-Gm-Message-State: AOAM532/ODhCdh669A75x+U5TnIPrD1ipqmEZHCs1rxfVTDJyX9FpgjW
        ehXUdiB2At1XaTAhWopF33k=
X-Google-Smtp-Source: ABdhPJwfHlE/wHQhpc7paohVWmUOifKKt2PNUIlQQ+it5vD1Md0OsrvSP7Fg1/ufE1LIvCZeg15jgQ==
X-Received: by 2002:a0c:ed51:: with SMTP id v17mr1292786qvq.20.1627495258206;
        Wed, 28 Jul 2021 11:00:58 -0700 (PDT)
Received: from master-laptop.sparksnet ([2601:153:980:85b1:b58:2ae8:d75f:660a])
        by smtp.gmail.com with ESMTPSA id r5sm223341qtm.75.2021.07.28.11.00.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jul 2021 11:00:57 -0700 (PDT)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     Peter Geis <pgwipeout@gmail.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] clk: rockchip: fix clk-pll rk356x early pll init
Date:   Wed, 28 Jul 2021 14:00:28 -0400
Message-Id: <20210728180034.717953-3-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210728180034.717953-1-pgwipeout@gmail.com>
References: <20210728180034.717953-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rk356x needs to reclock certain plls at boot. If the grf phandles
are not linked in the cru and pmucru nodes, it is unable to apply any
assigned-clock-rates at boot.

Fix this by removing the check for the grf for selecting the utilized
operations.

"The rk3568 reuses the pll_rk3328-type which in turn is a modified
pll_rk3036 and uses their ops. Which in turn means the pll shouldn't
access the GRF at all, as it uses the pll's own register to check the
locked state."

Suggested-by: Heiko Stuebner <heiko@sntech.de>
Link:
https://lore.kernel.org/linux-devicetree/20210728135534.703028-7-pgwipeout@gmail.com/
Fixes: c9c3c6eecc55 ("clk: rockchip: simplify GRF handling in pll
clocks")
Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 drivers/clk/rockchip/clk-pll.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/rockchip/clk-pll.c b/drivers/clk/rockchip/clk-pll.c
index fe937bcdb487..f7827b3b7fc1 100644
--- a/drivers/clk/rockchip/clk-pll.c
+++ b/drivers/clk/rockchip/clk-pll.c
@@ -940,7 +940,7 @@ struct clk *rockchip_clk_register_pll(struct rockchip_clk_provider *ctx,
 	switch (pll_type) {
 	case pll_rk3036:
 	case pll_rk3328:
-		if (!pll->rate_table || IS_ERR(ctx->grf))
+		if (!pll->rate_table)
 			init.ops = &rockchip_rk3036_pll_clk_norate_ops;
 		else
 			init.ops = &rockchip_rk3036_pll_clk_ops;
-- 
2.25.1

