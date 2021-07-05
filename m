Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA463BBB56
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jul 2021 12:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhGEKlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jul 2021 06:41:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhGEKlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jul 2021 06:41:08 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07075C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 03:38:32 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id m7-20020ad450470000b02902b767e59d49so2529169qvq.19
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 03:38:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=IGdOeKuUWgjZXs+/OzVZm4qLwJ1bVY9XzV5XRDS7Slk=;
        b=uWq6a/+AsN9sKSHYaIC/2GMkF/WGw5iy00TuGCWqSnzI0RnCljlhywUszemp4nPEuI
         kpq83xEOpdLCr+R5pIwOH8SxSwqLtFnTe+IfQNz7fLK46A2rkwFbDQT39Req7Mfux3B7
         k7upz2s+FS25zdvlPLTkc48YDU2s76Rh9iHWScSakdenoBtGQbgyMsG65Nu7UNuDhkfd
         GNQqm1y2wR0A0EN6AHInn/+wsZVZM9ieJPZRflm0xAIxuq9M6sV0hF3+lufpnQBFJnv7
         mnLChNgIqFGqEKKjh5iwjCdToYBFaFCSExbtxJAe7bO8SuzmTw5VVdXnVWcRQRwnNX3l
         2vZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=IGdOeKuUWgjZXs+/OzVZm4qLwJ1bVY9XzV5XRDS7Slk=;
        b=mLaaKOg3dap8S8hNDSPVE5b9iqOhryY35xkb78EFb7omni5JBEETwt6VPGevDl3qyF
         5EA9/glhQly4oxYbz7a7GCTGd8xWfyfTdAwe/N/Rts8aW1CJ1fKPJZ26zJD3ipKtinSs
         AYai2JxTAhf7jVt4tiz0w3aCEqSbl8zHjfPViIMz6WgMJsXkeZQ1Tg/DOn01V9Bx7o44
         wnmMkQMSJPtTIqLSz7aAY8N1axGB8/wGvgVAjJXxq+6IBlAZqcYgsoHjWTSib0gaFZBP
         ofF/PpXgjV2NU1NrRrknHsHat87I55IgDi/Bog4lUCn/YeRzHZlqdk43s8ijqOlY3F9j
         4deQ==
X-Gm-Message-State: AOAM530JXvOMeQ8SR7u0e9/LS+75EChPWqIC4HJM8hS294RyP4I7A1GB
        8eOCO/Cz9ewscNH/jPZd0g3KZLcLYA==
X-Google-Smtp-Source: ABdhPJzXkKdnm3ZihoHytmojHy2P+zdHbx66PXDMYmG5rBgkY+gGzlJ3/h9ZhbCNcILjCwjA5kIhfGt8bg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:dddd:647c:7745:e5f7])
 (user=elver job=sendgmr) by 2002:a05:6214:1244:: with SMTP id
 q4mr12258497qvv.50.1625481511074; Mon, 05 Jul 2021 03:38:31 -0700 (PDT)
Date:   Mon,  5 Jul 2021 12:38:06 +0200
Message-Id: <20210705103806.2339467-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.32.0.93.g670b81a890-goog
Subject: [PATCH] Revert "mm/page_alloc: make should_fail_alloc_page() static"
From:   Marco Elver <elver@google.com>
To:     elver@google.com, akpm@linux-foundation.org
Cc:     glider@google.com, dvyukov@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>, bpf@vger.kernel.org,
        Mel Gorman <mgorman@techsingularity.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit f7173090033c70886d925995e9dfdfb76dbb2441.

Commit 76cd61739fd1 ("mm/error_inject: Fix allow_error_inject function
signatures") explicitly made should_fail_alloc_page() non-static, due to
worries of remaining compiler optimizations in the absence of function
side-effects while being noinline.

Furthermore, kernel/bpf/verifier.c pushes should_fail_alloc_page onto
the btf_non_sleepable_error_inject BTF IDs set, which when enabling
CONFIG_DEBUG_INFO_BTF results in an error at the BTFIDS stage:

  FAILED unresolved symbol should_fail_alloc_page

To avoid the W=1 warning, add a function declaration right above the
function itself, with a comment it is required in a BTF IDs set.

Fixes: f7173090033c ("mm/page_alloc: make should_fail_alloc_page() static")
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 mm/page_alloc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index d6e94cc8066c..16e71d48d84e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3831,7 +3831,13 @@ static inline bool __should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 
 #endif /* CONFIG_FAIL_PAGE_ALLOC */
 
-static noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
+/*
+ * should_fail_alloc_page() is only called by page_alloc.c, however, is also
+ * included in a BTF IDs set and must remain non-static. Declare it to avoid a
+ * "missing prototypes" warning, and make it clear this is intentional.
+ */
+bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order);
+noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
 {
 	return __should_fail_alloc_page(gfp_mask, order);
 }
-- 
2.32.0.93.g670b81a890-goog

