Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF6F83F07FD
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 17:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239703AbhHRPYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 11:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239494AbhHRPXz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 11:23:55 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3211C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 08:23:20 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id t66so3488761qkb.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 08:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sh1SraHVKaCYA/y70zjirB3iehLFCX2xZsdhvuOQh88=;
        b=XkMCbtl+eZtb55uTMetMU9KUOhB+qRnNM3uZXlAmeZpddXY/wZoe7XofhB7B4YBokQ
         hhEjjVEdsH6mx04H5ujrwzMJ6HIj6pulZY6nEFceFaV0Br4kFhSfbqsltefjakyHov3F
         Pk2kGoGug/UenLupgEIV4BQuovuILRp8Tb5UNkgnx0b4hEMTetWtjgIHk4GSYZLmTvHR
         O8NW9kh6mj+qkJDHIGGK97Z+pYsHIZRLXcrzNpKtTwCYYSMTGBn1jeYWevdsk9E4duGS
         s1bjLw3cdagRos9fVdXF2EEyOhGFEGshTbqGvTxK//NRnHhUytk+U1EywV252QHDpdbK
         Pt2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Sh1SraHVKaCYA/y70zjirB3iehLFCX2xZsdhvuOQh88=;
        b=cYshuDG0uIqOGk7asqCdj83UDv5OyATZkPskNSDGYzUm4JgS2ht8AvsWLgTuF07G34
         SR4al2mC7aY17v5EAj3kmw22ZDus9B6Cr39gacShj0BoTWKwEqOAMzvftUw3S/XPeUn5
         JLLlikE6hOTwYoc1xh+nd8uiaPzbmC1JeNaHEIDXqghHbXrlusMT8b514ZkraijGkv3l
         rf5oXdSQV0daohoHVHIY7l3FxrHVlEckJRsmyCQsubSNiR+HbaPWjZxqUwUYqnBJ0ioe
         sIBlbUzNuEG8xVm1hHEzhVgY/gS4g8rQg4x2AUCsKT8CWOi4SdlNSB/m0k7YRkzixW7X
         wjtA==
X-Gm-Message-State: AOAM530TFXpDCLn0m2r3hjkqJV9ftS87rZkw5MOPlVRuQ44EQs4ODpBs
        5ZQiXtqXT/BzElIc0RE1sPInoqT8lsgN0A==
X-Google-Smtp-Source: ABdhPJxVogDZb0BxpUKcYfpDQa7/1wYIvo2KElxVcSRIGrKNLK7arzO2wONNyCE3QM/KXusnIvwWEw==
X-Received: by 2002:a37:b4d:: with SMTP id 74mr8195759qkl.92.1629300199808;
        Wed, 18 Aug 2021 08:23:19 -0700 (PDT)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id v27sm42407qkj.129.2021.08.18.08.23.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Aug 2021 08:23:19 -0700 (PDT)
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Rik van Riel <riel@surriel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: [PATCH] mm: vmscan: fix missing psi annotation for node_reclaim()
Date:   Wed, 18 Aug 2021 11:24:57 -0400
Message-Id: <20210818152457.35846-1-hannes@cmpxchg.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In a debugging session the other day, Rik noticed that node_reclaim()
was missing memstall annotations. This means we'll miss pressure and
lost productivity resulting from reclaim on an overloaded local NUMA
node when vm.zone_reclaim_mode is enabled.

There haven't been any reports, but that's likely because
vm.zone_reclaim_mode hasn't been a commonly used feature recently, and
the intersection between such setups and psi users is probably
nil. Although, secondary memory such as CXL-connected DIMMS,
persistent memory etc. and the page demotion patches that handle them
(https://lore.kernel.org/lkml/20210401183216.443C4443@viggo.jf.intel.com/)
could soon make this a more common codepath again.

Reported-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>
---
 mm/vmscan.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 701106e1829c..8ec4412c6116 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -4424,11 +4424,13 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 		.may_swap = 1,
 		.reclaim_idx = gfp_zone(gfp_mask),
 	};
+	unsigned long pflags;
 
 	trace_mm_vmscan_node_reclaim_begin(pgdat->node_id, order,
 					   sc.gfp_mask);
 
 	cond_resched();
+	psi_memstall_enter(&pflags);
 	fs_reclaim_acquire(sc.gfp_mask);
 	/*
 	 * We need to be able to allocate from the reserves for RECLAIM_UNMAP
@@ -4453,6 +4455,7 @@ static int __node_reclaim(struct pglist_data *pgdat, gfp_t gfp_mask, unsigned in
 	current->flags &= ~PF_SWAPWRITE;
 	memalloc_noreclaim_restore(noreclaim_flag);
 	fs_reclaim_release(sc.gfp_mask);
+	psi_memstall_leave(&pflags);
 
 	trace_mm_vmscan_node_reclaim_end(sc.nr_reclaimed);
 
-- 
2.32.0

