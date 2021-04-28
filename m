Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31ADC36E1DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232622AbhD1Wvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhD1Wvw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:51:52 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D276DC06138B
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:51:05 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id b15so503902pfl.4
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=Qg/pOOpCXVrcOXltjV8Nl6uzz/ZyHLz57cagQobvrqo=;
        b=Xr8jzcqEm3KrdsvU+y00f3Xl8rhTkfxXyWuJB9QOTWUaQvVsbZoGdSDJI9p+Jdkbkq
         3xDOEEklMNn8iR0Qnw8kOCcFYgAIQPzXqAkhYKiwZyqiQ9cN+2S5Qma9Y5gFB7bVN8Wj
         f5Im/8lfJNWxBMxIeRhbE6N9YwuzQJEojewUCa7evEFbA2PPToMYDuFWGGNv507xBUqZ
         1rm8NBGItYo3YLovhzhvLgFiKulkoIW+eqR8qLkFpgzMqEr1hie2Paa24R4TBwlWDCgn
         icT4bF7mH/nlo04shGkEhNuioNpjsvtGpTAs0txxHjjBcUvvFLHc8f/DWhz3ocPWFbQ+
         TD4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Qg/pOOpCXVrcOXltjV8Nl6uzz/ZyHLz57cagQobvrqo=;
        b=Wb5LC56cLVQRAWdwNIG3IFlNNSR8eWuycihMvoGs59BXADGB6NuaCXBuLL65okIhaq
         SzE0eM1oRl7PjhCou9+Cgg22RyY8KzDXIf6j5dmQHr7+Becc9geHRZLwzZBMSVZMoTgU
         aDIg9dsb7YRRetvSHdl+PmUymmTOBBb/rt1PJQ7EoUKUsH0ryvKJ+MSGDg7agp4PGoZr
         E/aaQ7sjJSpn55oG0Ohjph2WFp5dLgdpXeXdvyv29oCCd+9AhFj1V7u+xpna6DHhYgpw
         aOHoMJaugVxXkaI9RaQ6oII58rk0ZP27IxhC72kfGijyqUjtCTnChqYU5CDT8iojCMmX
         9RIw==
X-Gm-Message-State: AOAM533mMKrhAa8SZAMjGCEu+DG3A0reEQOi4yiz9mXpefpzixQJ+i3a
        qFeoqzAfS/7m5n7qjoHbtLI=
X-Google-Smtp-Source: ABdhPJz6zrPWSXd8OfWJF5mXtwSR6r9809EVsmAwHoN8fP8L3yKphF/HQDWZTEm3SMKkiy/GMhvJ/g==
X-Received: by 2002:a63:4442:: with SMTP id t2mr29888762pgk.232.1619650265191;
        Wed, 28 Apr 2021 15:51:05 -0700 (PDT)
Received: from wuchi.mioffice.cn ([2408:8607:1b00:a:4a4d:7eff:feb5:2e68])
        by smtp.gmail.com with ESMTPSA id y1sm2673949pjt.26.2021.04.28.15.51.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:51:04 -0700 (PDT)
From:   Chi Wu <wuchi.zero@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, tj@kernel.org
Subject: [PATCH] mm/page-writeback: Fix performance when BDI's share of ratio is 0.
Date:   Thu, 29 Apr 2021 06:50:46 +0800
Message-Id: <20210428225046.16301-1-wuchi.zero@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix performance when BDI's share of ratio is 0.

The issue is similar to commit 74d369443325 ("writeback: Fix
performance regression in wb_over_bg_thresh()").

Balance_dirty_pages and the writeback worker will also disagree on
whether writeback when a BDI uses BDI_CAP_STRICTLIMIT and BDI's share
of the thresh ratio is zero.

For example, A thread on cpu0 writes 32 pages and then
balance_dirty_pages, it will wake up background writeback and pauses
because wb_dirty > wb->wb_thresh = 0 (share of thresh ratio is zero).
A thread may runs on cpu0 again because scheduler prefers pre_cpu.
Then writeback worker may runs on other cpus(1,2..) which causes the
value of wb_stat(wb, WB_RECLAIMABLE) in wb_over_bg_thresh is 0 and does
not writeback and returns.

Thus, balance_dirty_pages keeps looping, sleeping and then waking up the
worker who will do nothing. It remains stuck in this state until the
writeback worker hit the right dirty cpu or the dirty pages expire.

The fix that we should get the wb_stat_sum radically when thresh is low.

Signed-off-by: Chi Wu <wuchi.zero@gmail.com>
---
 mm/page-writeback.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 0062d5c57d41..bd7052295246 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -1945,6 +1945,8 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 	struct dirty_throttle_control * const gdtc = &gdtc_stor;
 	struct dirty_throttle_control * const mdtc = mdtc_valid(&mdtc_stor) ?
 						     &mdtc_stor : NULL;
+	unsigned long reclaimable;
+	unsigned long thresh;
 
 	/*
 	 * Similar to balance_dirty_pages() but ignores pages being written
@@ -1957,8 +1959,13 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 	if (gdtc->dirty > gdtc->bg_thresh)
 		return true;
 
-	if (wb_stat(wb, WB_RECLAIMABLE) >
-	    wb_calc_thresh(gdtc->wb, gdtc->bg_thresh))
+	thresh = wb_calc_thresh(gdtc->wb, gdtc->bg_thresh);
+	if (thresh < 2 * wb_stat_error())
+		reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
+	else
+		reclaimable = wb_stat(wb, WB_RECLAIMABLE);
+
+	if (reclaimable > thresh)
 		return true;
 
 	if (mdtc) {
@@ -1972,8 +1979,13 @@ bool wb_over_bg_thresh(struct bdi_writeback *wb)
 		if (mdtc->dirty > mdtc->bg_thresh)
 			return true;
 
-		if (wb_stat(wb, WB_RECLAIMABLE) >
-		    wb_calc_thresh(mdtc->wb, mdtc->bg_thresh))
+		thresh = wb_calc_thresh(mdtc->wb, mdtc->bg_thresh);
+		if (thresh < 2 * wb_stat_error())
+			reclaimable = wb_stat_sum(wb, WB_RECLAIMABLE);
+		else
+			reclaimable = wb_stat(wb, WB_RECLAIMABLE);
+
+		if (reclaimable > thresh)
 			return true;
 	}
 
-- 
2.17.1

