Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4400D3BA622
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Jul 2021 00:52:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233287AbhGBWyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 18:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbhGBWyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 18:54:39 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7A5C0613DE;
        Fri,  2 Jul 2021 15:52:04 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id i5so15299541eds.1;
        Fri, 02 Jul 2021 15:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=741oOKm9Y/CN6pZlsJDyA+wQ24ovzGnQR0XtQiJk4V0=;
        b=cvI1oGQdong/J6jo2Uvf7v7DwJpDQsEHB76D+A5tSKdsRTiJif1apV6Sc6OKruoHcU
         O1/6bF7h9IxRqm62vZco6/cmJpD/7zNoo+570lV7tmFWpN3KK59H61v7GPJ1NwYmNRxc
         B4DyHUGOv33SNJn9E9Uaw9b1cpVyfMNcIfm7b5VpM0i0hH3DWHNzgWtPJyXHd93SUuKY
         zACpIEWgQHAPFuJEHII5AefZ3zJcEFSKYpRj095dYUNZ25Zx0pSIJf7k7/WW+t5JB0Nv
         NvUCL5BLafsHKspqJ+DSaHkHCDQA5p9qfT7K7IPiGwsdudWC3ueuvUWGQMiFtV8raqAy
         LUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=741oOKm9Y/CN6pZlsJDyA+wQ24ovzGnQR0XtQiJk4V0=;
        b=j+Rg0wYXTJHzUNiiitCUg9pvyciClgepxJKpPDPFeXffsl+1WwnM5MPT0zIDuMxiQh
         7uJdXrMCW2/EnQkCIq31Va6TUfbEg3x2e6CPZkF3DEiZkINc7GCyKHEfbAUV9YhzWfqB
         4uYuUN6rFFANORu1RQSmXk/oHDEKXk6dPsVUg2rBY+l39mFYvCM3/P09UvtCTKE69r47
         5sRnagVCQiytiNG6ymMVAZrtXIaEWsvloSeIZNkvqDPwsg5E8DokXfbECJiS9YHsKdz+
         ZpJctV26tCeEtysParQXJxwG9R4Nw/3eq569TQJDaSE9/6GrYcxpNFQQLy84kFfOP6Sv
         Nc8A==
X-Gm-Message-State: AOAM5318fG79fTeGJ3kMlcaTjmS+qv8E1gs8hRFF4s6NxesiJeZoWMKX
        9WNyePGq2oV0BmRPuahpCilJiHQnEfM=
X-Google-Smtp-Source: ABdhPJyw33dANIX/Wgn1Qh4aloRjh0gEEBdoN1t3F9c93El0LTh594GXs/thf0NjLPIuBtUz7hwutA==
X-Received: by 2002:a05:6402:214:: with SMTP id t20mr2212183edv.20.1625266323359;
        Fri, 02 Jul 2021 15:52:03 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-117-063-046.95.117.pool.telefonica.de. [95.117.63.46])
        by smtp.googlemail.com with ESMTPSA id r17sm1866964edt.33.2021.07.02.15.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 15:52:03 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-clk@vger.kernel.org, sboyd@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH v1 6/6] clk: stm32mp1: Switch to clk_divider.determine_rate
Date:   Sat,  3 Jul 2021 00:51:45 +0200
Message-Id: <20210702225145.2643303-7-martin.blumenstingl@googlemail.com>
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

Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: linux-stm32@st-md-mailman.stormreply.com
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/clk/clk-stm32mp1.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/clk/clk-stm32mp1.c b/drivers/clk/clk-stm32mp1.c
index 256575bd29b9..4bd1fe7d8af4 100644
--- a/drivers/clk/clk-stm32mp1.c
+++ b/drivers/clk/clk-stm32mp1.c
@@ -1076,14 +1076,10 @@ static int clk_divider_rtc_set_rate(struct clk_hw *hw, unsigned long rate,
 
 static int clk_divider_rtc_determine_rate(struct clk_hw *hw, struct clk_rate_request *req)
 {
-	unsigned long best_parent_rate = req->best_parent_rate;
+	if (req->best_parent_hw == clk_hw_get_parent_by_index(hw, HSE_RTC))
+		return clk_divider_ops.determine_rate(hw, req);
 
-	if (req->best_parent_hw == clk_hw_get_parent_by_index(hw, HSE_RTC)) {
-		req->rate = clk_divider_ops.round_rate(hw, req->rate, &best_parent_rate);
-		req->best_parent_rate = best_parent_rate;
-	} else {
-		req->rate = best_parent_rate;
-	}
+	req->rate = req->best_parent_rate;
 
 	return 0;
 }
-- 
2.32.0

