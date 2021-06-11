Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC2353A3C48
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 08:52:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhFKGx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Jun 2021 02:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbhFKGxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jun 2021 02:53:54 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724B4C061574
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 23:51:46 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id w9so16011611qvi.13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 23:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=utYdXs56qPMmZxOut4t6zsusEfRCADS6Mqu+t+Uy1DU=;
        b=omQ/5S9VVOsjIhGHZ78HhhEKrkRxisE/sZBKGF70wbRD0GCn/JYD4uviXVbBVLdXOr
         rV01BSFlRv0p+U3dR9rBqL7T8Ud3AsctYyqWdCfaYxaq+M8m+rN4Q+ULcxAEot01zzWc
         +ASfMefK5vHwXgiHYuhIfU38JPg+LKchzUBbamObdQfQ8RM9a3AWKaB+B9IfKITGFDDO
         vDYutIiLi5oVrEaJQTERI4Fqo158Jy6VcFwCD/FpYphqSOokKlHIGxtxs3BuEwtwMI6K
         lv3dfmOpMkha3ADZphRD4J3YLZIkTxQHDBxGIqbyjMkSWyaYc0Nb8gvqPxtiL/0fYtNu
         SsVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=utYdXs56qPMmZxOut4t6zsusEfRCADS6Mqu+t+Uy1DU=;
        b=L5xMuMYnyi06tmzEdXudd5nDeP5OydQpKJoQ+ch93EE56s5wnGt/FpGVyJ72yqwJFq
         mhDIoRbbgaqCXCOYBFiEpe2LGyQp6rDqLL0L6hZ7LYdXnTPJqGSums46PxXbL5g1h9bw
         7sfd+xCrxWrBcbHUAiY8ODgq5jfsAfdQgrs9qd8mEjWprxR2Z1woOIarbJkt6gyq4yyJ
         zDJvibEhMsLQRG4qGOzbPbDL7S1aFiwdQkTF9K2kB0uhTHGusmmWSxtK1sIciSm9YVXy
         fPuGty/q4Rw4SqhSETNH+Rnv9t5+78RpPtMCbm9vHM1p99P5F3hFSVRpDxNggomF7Cnp
         yrKA==
X-Gm-Message-State: AOAM5300MFTM5mpm2dp31nydA92io5+4peVCmgs7QFbE/JLaTUeKnp/n
        iVrxuWCYgyQDK5iMLK+InEs=
X-Google-Smtp-Source: ABdhPJy7r56J38XiF5fbOLSgCN8euN3ov6s2MNJCzELkU2IHugvwFop/pYrPtZ9FU8BBS/IKqb5aPA==
X-Received: by 2002:ad4:576e:: with SMTP id r14mr3390982qvx.20.1623394305659;
        Thu, 10 Jun 2021 23:51:45 -0700 (PDT)
Received: from 192.168.3.10 ([50.236.19.102])
        by smtp.gmail.com with ESMTPSA id d23sm3663677qto.74.2021.06.10.23.51.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Jun 2021 23:51:45 -0700 (PDT)
From:   chengkaitao <pilgrimtao@gmail.com>
X-Google-Original-From: chengkaitao <chengkaitao@didiglobal.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, smcdef@gmail.com,
        chengkaitao <pilgrimtao@gmail.com>
Subject: [PATCH] mm: delete duplicate order checking, when stealing whole pageblock
Date:   Fri, 11 Jun 2021 14:38:34 +0800
Message-Id: <20210611063834.11871-1-chengkaitao@didiglobal.com>
X-Mailer: git-send-email 2.14.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: chengkaitao <pilgrimtao@gmail.com>

1. Already has (order >= pageblock_order / 2) here, we don't neet
(order >= pageblock_order)
2. set function can_steal_fallback to inline

Signed-off-by: chengkaitao <pilgrimtao@gmail.com>
---
 mm/page_alloc.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index ded02d867491..180081fe711b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -2619,18 +2619,8 @@ static void change_pageblock_range(struct page *pageblock_page,
  * is worse than movable allocations stealing from unmovable and reclaimable
  * pageblocks.
  */
-static bool can_steal_fallback(unsigned int order, int start_mt)
+static inline bool can_steal_fallback(unsigned int order, int start_mt)
 {
-	/*
-	 * Leaving this order check is intended, although there is
-	 * relaxed order check in next check. The reason is that
-	 * we can actually steal whole pageblock if this condition met,
-	 * but, below check doesn't guarantee it and that is just heuristic
-	 * so could be changed anytime.
-	 */
-	if (order >= pageblock_order)
-		return true;
-
 	if (order >= pageblock_order / 2 ||
 		start_mt == MIGRATE_RECLAIMABLE ||
 		start_mt == MIGRATE_UNMOVABLE ||
-- 
2.14.1

