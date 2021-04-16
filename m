Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1F9361929
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Apr 2021 07:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238683AbhDPFQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Apr 2021 01:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbhDPFQo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Apr 2021 01:16:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65656C061574
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:16:19 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id em21-20020a17090b0155b029014e204a81e6so5850022pjb.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Apr 2021 22:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uQtbD7P4vc1vn6sj+rqk5iopinYS+ejCLWKURjwvog0=;
        b=mRtbHxsAw7+QrX8ggNXOLMpdmdVUi7Qf1Lpa81SHEUBjmwEClOHj/sH4gvAYCq8zPZ
         xWibDLFCrAzBmZDv70d88yqFQse8c9LDa2GH++SJosfSXH710S1MN91bD9nh5dZhoJ+Z
         k0lLVEqXe3+hW7vEtcqBkSlhNOw9VTcVBej93UknAw8Nnf+qblXwim/FTZBj8ayS/sT2
         9NOkyYaLvrpYcu5oKbIJ7zcZJgeAmkEZyf5w8lja3um9r8ULyUkEgRgQ0hnfg7qKs0Eq
         F5EShwqc6drtDgM19zTdg9A10CWl1boL9f0t+t3Bg3N9uDCy5PRtVitu16kREDAQyi/E
         XbHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uQtbD7P4vc1vn6sj+rqk5iopinYS+ejCLWKURjwvog0=;
        b=Hz6WoUy0YSNYVseOuubdihzqh7QgpZSsZgWyzWgyO255s7FMMrN8je7TGnxN5ieWha
         ikYIQiIeJTjPIWUHfSuzrhycDeMr5K9eGQWbxDBRxhpdoDI/maQKGmJOqXsJ8pk4iNsS
         oA35NTIomtlrg3uEkgZ2/7ZJVJW5IpOkhcx4lYas6KG3t3p1PtWWbt3Q+gO1De9T7Nc1
         /O7lwW1d0OcKhl8834gL2d6IJwFNKGqtiS8gHVy4Kfnd/1GXf6oTiDvqZZUW1G1SojV2
         g6DikslF5jJi0JvWzgwFCpmtw0v2wss7lLB6Nfn1wUNysfXQLWaAyK0zgM5jLJv2EAFQ
         Pd4A==
X-Gm-Message-State: AOAM532cuDrFaJCYz+8N8gWWfBqvWV940TxSMXt/+YukiVPvsvBaWrVe
        Yuxi2IOerdXSVSnG99ByrTwI2kGr80iAonzJ
X-Google-Smtp-Source: ABdhPJzsgKapGnuNFn0l7TP15/XU9x0NbvQ/D9jy8GoSu4oybHVT5scnv3+3n7GIFQav84toXIR3Nw==
X-Received: by 2002:a17:902:c948:b029:e9:8f01:fa8e with SMTP id i8-20020a170902c948b02900e98f01fa8emr7765675pla.37.1618550179022;
        Thu, 15 Apr 2021 22:16:19 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.235])
        by smtp.gmail.com with ESMTPSA id j7sm3518540pfd.129.2021.04.15.22.16.13
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 15 Apr 2021 22:16:18 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v2 8/8] mm: vmscan: remove noinline_for_stack
Date:   Fri, 16 Apr 2021 13:14:07 +0800
Message-Id: <20210416051407.54878-9-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210416051407.54878-1-songmuchun@bytedance.com>
References: <20210416051407.54878-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The noinline_for_stack is introduced by commit 666356297ec4 ("vmscan:
set up pagevec as late as possible in shrink_inactive_list()"), its
purpose is to delay the allocation of pagevec as late as possible to
save stack memory. But the commit 2bcf88796381 ("mm: take pagevecs off
reclaim stack") replace pagevecs by lists of pages_to_free. So we do
not need noinline_for_stack, just remove it (let the compiler decide
whether to inline).

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Roman Gushchin <guro@fb.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
---
 mm/vmscan.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 2bc5cf409958..2d2727b78df9 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -2014,8 +2014,8 @@ static int too_many_isolated(struct pglist_data *pgdat, int file,
  *
  * Returns the number of pages moved to the given lruvec.
  */
-static unsigned noinline_for_stack move_pages_to_lru(struct lruvec *lruvec,
-						     struct list_head *list)
+static unsigned int move_pages_to_lru(struct lruvec *lruvec,
+				      struct list_head *list)
 {
 	int nr_pages, nr_moved = 0;
 	LIST_HEAD(pages_to_free);
@@ -2095,7 +2095,7 @@ static int current_may_throttle(void)
  * shrink_inactive_list() is a helper for shrink_node().  It returns the number
  * of reclaimed pages
  */
-static noinline_for_stack unsigned long
+static unsigned long
 shrink_inactive_list(unsigned long nr_to_scan, struct lruvec *lruvec,
 		     struct scan_control *sc, enum lru_list lru)
 {
-- 
2.11.0

