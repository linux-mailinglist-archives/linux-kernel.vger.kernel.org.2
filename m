Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3F342F02E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 14:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238649AbhJOMIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 08:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhJOMIS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 08:08:18 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A1CBC061570;
        Fri, 15 Oct 2021 05:06:12 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id z2so2350370wmc.3;
        Fri, 15 Oct 2021 05:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2pgx0g7Ab7G9I2hs6+wwaJaXi+B3ZQHmcz1sfiWia5A=;
        b=p9mF5RB3QcxoH1nzcEzae/jHbNvfWVcw7H7HO+Fj86UQt9K3rhLQuXfj1nb0qqvpIA
         Dg0olTtP9ma+CeksRGL56SJV1XVJB+azvRd3888/mR/zKtVXVF6x1qsUrKagFFmGbJvb
         qyS/D9YCldWULqp8R0thYoqPFz5iSr0Rjminq+iniEzE89oYXV8gfMn6kfuXTCPXTKFQ
         DsyhZl8cCqgCZyz6Do4vVqEONM7FHf23ZqIinSQ+ibZ83LAMahLC6OGiNN/GDYrQ1QlK
         hOvbSrw24A5rqZzRVQ0ZhJo4aIGjyLEFv+4iC4zKHXGtBo6EPMcqCyjG4HIOejbpXw6S
         5rBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2pgx0g7Ab7G9I2hs6+wwaJaXi+B3ZQHmcz1sfiWia5A=;
        b=k4pSNr5zYlVrdQLbYxEHtEskYprAnmby2MrQMdTEQZnutqc5Q1+z73SVj19yznrg7b
         vtUfqLnH0lyqy0S4DyhLQhCX3s7EJ4/rERmLUxEYRO1qlp0iCjKopcmjpylVAZMV/1b7
         X8ua2CN/4vYPbEsmvRZM3bKV7uo9/ITRVU2SQPmrdZxAvhQt4VVQkSRNQQCvuQ8cUjxp
         bwKhgNv7uBAupIuGeNyvWSU/itUdI6g+ESDdufIHqaxSsLu4EdOx1pW8x30W29v959tb
         hNYvbxBudVkjs9rjm60ADJkDqnJVtzhrj/EDJ7NoX6jT5RsU01/SxL2H/1BPlVX1lR6r
         QwCQ==
X-Gm-Message-State: AOAM531paV/ysYmWvCsAaNwglaDPWtNEvHuhnD7KIkhPveDn+wypweE2
        RhtpQb5d4ki49ymcp67X416o8GwQ1x8=
X-Google-Smtp-Source: ABdhPJwSdzurtgFgxXDGbUKhIi2uu02rWc1l+HCi+1IONPSJyiSZnabW2KnH8jXzGtkWKVBYzoIZHQ==
X-Received: by 2002:a05:600c:1c10:: with SMTP id j16mr26328587wms.12.1634299570676;
        Fri, 15 Oct 2021 05:06:10 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a01-0c23-c1f2-fb00-f22f-74ff-fe21-0725.c23.pool.telefonica.de. [2a01:c23:c1f2:fb00:f22f:74ff:fe21:725])
        by smtp.googlemail.com with ESMTPSA id j1sm4869155wrd.28.2021.10.15.05.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Oct 2021 05:06:10 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     sboyd@kernel.org
Cc:     heiko@sntech.de, knaerzche@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        martin.blumenstingl@googlemail.com
Subject: [PATCH] clk: composite: Also consider .determine_rate for rate + mux composites
Date:   Fri, 15 Oct 2021 14:05:59 +0200
Message-Id: <20211015120559.3515645-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <163425193558.1688384.15520943968787313145@swboyd.mtv.corp.google.com>
References: <163425193558.1688384.15520943968787313145@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 69a00fb3d69706 ("clk: divider: Implement and wire up
.determine_rate by default") switches clk_divider_ops to implement
.determine_rate by default. This breaks composite clocks with multiple
parents because clk-composite.c does not use the special handling for
mux + divider combinations anymore (that was restricted to rate clocks
which only implement .round_rate, but not .determine_rate).

Alex reports:
  This breaks lot of clocks for Rockchip which intensively uses
  composites,  i.e. those clocks will always stay at the initial parent,
  which in some cases  is the XTAL clock and I strongly guess it is the
  same for other platforms,  which use composite clocks having more than
  one parent (e.g. mediatek, ti ...)

  Example (RK3399)
  clk_sdio is set (initialized) with XTAL (24 MHz) as parent in u-boot.
  It will always stay at this parent, even if the mmc driver sets a rate
  of  200 MHz (fails, as the nature of things), which should switch it
  to   any of its possible parent PLLs defined in
  mux_pll_src_cpll_gpll_npll_ppll_upll_24m_p (see clk-rk3399.c)  - which
  never happens.

Restore the original behavior by changing the priority of the conditions
inside clk-composite.c. Now the special rate + mux case (with rate_ops
having a .round_rate - which is still the case for the default
clk_divider_ops) is preferred over rate_ops which have .determine_rate
defined (and not further considering the mux).

Fixes: 69a00fb3d69706 ("clk: divider: Implement and wire up .determine_rate by default")
Reported-by: Alex Bee <knaerzche@gmail.com>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
Re-sending this as inline patch instead of attaching it.

 drivers/clk/clk-composite.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/clk-composite.c b/drivers/clk/clk-composite.c
index 0506046a5f4b..510a9965633b 100644
--- a/drivers/clk/clk-composite.c
+++ b/drivers/clk/clk-composite.c
@@ -58,11 +58,8 @@ static int clk_composite_determine_rate(struct clk_hw *hw,
 	long rate;
 	int i;
 
-	if (rate_hw && rate_ops && rate_ops->determine_rate) {
-		__clk_hw_set_clk(rate_hw, hw);
-		return rate_ops->determine_rate(rate_hw, req);
-	} else if (rate_hw && rate_ops && rate_ops->round_rate &&
-		   mux_hw && mux_ops && mux_ops->set_parent) {
+	if (rate_hw && rate_ops && rate_ops->round_rate &&
+	    mux_hw && mux_ops && mux_ops->set_parent) {
 		req->best_parent_hw = NULL;
 
 		if (clk_hw_get_flags(hw) & CLK_SET_RATE_NO_REPARENT) {
@@ -107,6 +104,9 @@ static int clk_composite_determine_rate(struct clk_hw *hw,
 
 		req->rate = best_rate;
 		return 0;
+	} else if (rate_hw && rate_ops && rate_ops->determine_rate) {
+		__clk_hw_set_clk(rate_hw, hw);
+		return rate_ops->determine_rate(rate_hw, req);
 	} else if (mux_hw && mux_ops && mux_ops->determine_rate) {
 		__clk_hw_set_clk(mux_hw, hw);
 		return mux_ops->determine_rate(mux_hw, req);
-- 
2.33.0

