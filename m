Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319F042CA4B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 21:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238970AbhJMTp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 15:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237738AbhJMTpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 15:45:55 -0400
Received: from mail-vk1-xa4a.google.com (mail-vk1-xa4a.google.com [IPv6:2607:f8b0:4864:20::a4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E009C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:43:52 -0700 (PDT)
Received: by mail-vk1-xa4a.google.com with SMTP id w124-20020a1fc682000000b0029aceaf35b2so1485235vkf.19
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 12:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=183/Dmjt3t68g4lFUKc/z0kQhgqiT+FGVOpT95Nq0kM=;
        b=OdGvP6ktVCKze2jdgpC/LCWFtjsxfSQgs7UTA6ebaiBpzoW1WqKoiQuVcC1bpMOVCC
         i8KclRSPtGW5OeUbj5IuaiJMHVf+Aez8zx2pNI57ISq82CQEZoyEfTvyVn69C7OEgxcq
         gYafOMRueWW7YY9aES2dtBfRhYz2FKebug+0VXHFfQQmiSeBII857IcocA5kBECykSGf
         2GkjXZ6uaf8Cfr/+DRwDyeZ8LEcsNG7p5vjscSWG25J6V8xiOkH3N4tw4bBj2JybPT+T
         C0YERN2BSBkhnSnncR/BTcYXjo3x6SnZTPdlui6ZcHcyYMBORDh8TxIwvTdhaGjJnzNF
         J4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=183/Dmjt3t68g4lFUKc/z0kQhgqiT+FGVOpT95Nq0kM=;
        b=atfyR1qY24V3fJMEsbQlbu3q7n7xAxZSJoSSnjRlKTFsxvPZVwB1BaF3Qo3xBPRkh3
         x0FmCWiyvBQqQXoJaJ/M7okWkQZ4aDeMKRJgUSSnwCjs1uYeNOdPCFQq+0ltJeSizNCN
         m1NNp7tkf+20lGuKBapXshVYQfrpU/ZPolYf5SaQYkzkTHNCTdxMMAFyjeRPPb4LYKG/
         nGEuCMTxNhIKNnteByFQHdRmOImbRAAsGB3iFgoD3V8LFvJ/Rep793heh2TRx0dcN+HD
         I0gHROKNVpWMJ23EMEbvQNNnRCnNDNe3oAchPVT5Y/nqfdXaQPr3jCHwF7w+DwKPNt8/
         W5BQ==
X-Gm-Message-State: AOAM533HP4+j+tKpJfmcG00018QjT1onmCKhVgBqjDdXTlnrGfEZIaqK
        amRVr8+SEyU2Lo/kO6DfK98QrLeb7ZNYjA==
X-Google-Smtp-Source: ABdhPJxKgR5GsmM54dHnMT2mXYgy1E7okQ+e1f6zKR1mUBMieg+tg2mRtJZ0uTCGaMOdR75/PYQyN+Wp/FppFA==
X-Received: from shakeelb.svl.corp.google.com ([2620:15c:2cd:202:10e1:c2e0:9039:1a50])
 (user=shakeelb job=sendgmr) by 2002:a67:e416:: with SMTP id
 d22mr1407296vsf.41.1634154231281; Wed, 13 Oct 2021 12:43:51 -0700 (PDT)
Date:   Wed, 13 Oct 2021 12:43:38 -0700
Message-Id: <20211013194338.1804247-1-shakeelb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH] memcg: page_alloc: skip bulk allocator for __GFP_ACCOUNT
From:   Shakeel Butt <shakeelb@google.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Uladzislau Rezki <urezki@gmail.com>,
        Vasily Averin <vvs@virtuozzo.com>,
        Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Shakeel Butt <shakeelb@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in
__vmalloc_area_node()") switched to bulk page allocator for order 0
allocation backing vmalloc. However bulk page allocator does not support
__GFP_ACCOUNT allocations and there are several users of
kvmalloc(__GFP_ACCOUNT).

For now make __GFP_ACCOUNT allocations bypass bulk page allocator. In
future if there is workload that can be significantly improved with the
bulk page allocator with __GFP_ACCCOUNT support, we can revisit the
decision.

Fixes: 5c1f4e690eec ("mm/vmalloc: switch to bulk allocator in __vmalloc_area_node()")
Signed-off-by: Shakeel Butt <shakeelb@google.com>
---
 mm/page_alloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 668edb16446a..b3acad4615d3 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -5215,6 +5215,10 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
 	int nr_populated = 0, nr_account = 0;
 
+	/* Bulk allocator does not support memcg accounting. */
+	if (unlikely(gfp & __GFP_ACCOUNT))
+		goto out;
+
 	/*
 	 * Skip populated array elements to determine if any pages need
 	 * to be allocated before disabling IRQs.
-- 
2.33.0.882.g93a45727a2-goog

