Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F1D3CF4C5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 08:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbhGTGJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 02:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237553AbhGTGHv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 02:07:51 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60FCC061762
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 23:48:08 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d9so7560664pfv.4
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 23:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=s1uZNvfYU0GpljT1GvWNKfoOHLQiAyxeoEdgPFxn/sU=;
        b=YP2gSP4GeBIWZ2DD34PTJuchrpSXDkpXWx8eZFMBXUAFdS8BMX3kkyu4jubuFOuFsf
         yxXN0ibtl0SF5goswfSSyJhYdJK1PWUBm0zjSj8dgcacafV7TAsKztEetZTFbLVwHUpp
         Df5yjMJ2iQlqkW6JDiPOLMUb3lkILU91h6ruLWu+1D82eQP+3CxQSmdkjEHjUPm+MTrk
         mg7zUFvjqrqFO+TgcaWoAkuyEe+fjDSQkDkJ3lAGNxCP/PMQWHIxZvPVw10zMcDfR8CC
         8jeMG2QHrPycx9bw6bqmim5i74rSJCyqUadFT/dSQO+qTSCW4nbJDodjs6ScOR7yhgp3
         4sug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=s1uZNvfYU0GpljT1GvWNKfoOHLQiAyxeoEdgPFxn/sU=;
        b=XHUmV6vH5OiSQm2Gr5T1qgmxNc+4Pm+REzN8PI3f3SALDmeDr9cV3bGkbqj63g5Kl/
         9afmXRyk0rB5gPNe32uzWVzCEzS+FIK5jNOOlo79VGiGtw482gyVD6GSJSr3F3uy0QqB
         vpTB8fxoaoXhdAekZxqDAaugktKnP+N7+4xyKTxPqe8RJrf6lyaXN5IdCDZ5IJeWqU4Y
         8skh1bXyYtFXipAs9WD/UAJXf6QZJaqQrjFC36GJ0p0j6yCjqnD2vnWeqXY36NII1Z2g
         MkQfyI00hanrZh2NLWrq8tTljaOaKs2I5FVVo42n1jwlCcm61Uqp4ZvsyAj7ED6oAQRl
         vh6g==
X-Gm-Message-State: AOAM533p9HJQKiEvuNCPTkEOV6pWN4QhoX0E4ZqBeWYrAHy5FLwe66nx
        G5pwfdAHEwLoc39NHyBrg3Q=
X-Google-Smtp-Source: ABdhPJx8w9gFLgZZuYbzwzjexB4rjChaujMR3kJT2/1cdIcVHid5J3ryWhB8zAlRnhlkteIr7gdT+A==
X-Received: by 2002:a63:4726:: with SMTP id u38mr28781872pga.275.1626763688503;
        Mon, 19 Jul 2021 23:48:08 -0700 (PDT)
Received: from bj03382pcu.spreadtrum.com ([117.18.48.102])
        by smtp.gmail.com with ESMTPSA id s7sm21379039pfk.12.2021.07.19.23.48.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jul 2021 23:48:08 -0700 (PDT)
From:   Huangzhaoyang <huangzhaoyang@gmail.com>
To:     Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Nitin Gupta <ngupta@vflare.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] driver: zram: fix wrong counting on pages_store
Date:   Tue, 20 Jul 2021 14:47:38 +0800
Message-Id: <1626763658-27748-1-git-send-email-huangzhaoyang@gmail.com>
X-Mailer: git-send-email 1.7.9.5
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

It makes the statistic confused when counting pages_store in during writeback.
pages_store should just reflect the swapped pages on ZRAM, while bd_writes be
responsible for writeback things.

Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
---
 drivers/block/zram/zram_drv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index cf8deec..6bdaa9d 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -765,7 +765,6 @@ static ssize_t writeback_store(struct device *dev,
 		zram_set_flag(zram, index, ZRAM_WB);
 		zram_set_element(zram, index, blk_idx);
 		blk_idx = 0;
-		atomic64_inc(&zram->stats.pages_stored);
 		spin_lock(&zram->wb_limit_lock);
 		if (zram->wb_limit_enable && zram->bd_wb_limit > 0)
 			zram->bd_wb_limit -=  1UL << (PAGE_SHIFT - 12);
-- 
1.9.1

