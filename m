Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5065C33C303
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 18:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235448AbhCOQ7P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 12:59:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29159 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234778AbhCOQ6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 12:58:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615827532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Q6aA+wae6vAkyvGM3B2yBBd2LbIPXzseOAaDvzuOi6I=;
        b=Tjv+m3dhWUGEloV548JnvQhK97uPYsb955y/BueNGYJozv0mMIbLmmz1QNFhnVgOGCLHuB
        LXFn82rHmF7ZidzF1tHFotK5Tweh/nD6c5XChMmglHDSeDXwl/d9tWhhOma3r7eTV5hVMn
        NO/VQyYI4/4gD68fcB/V9GDpj8Rshw8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-D-w66EmSPqSuN1XRmkNOXA-1; Mon, 15 Mar 2021 12:58:40 -0400
X-MC-Unique: D-w66EmSPqSuN1XRmkNOXA-1
Received: by mail-wm1-f72.google.com with SMTP id b20so2750083wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Mar 2021 09:58:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Q6aA+wae6vAkyvGM3B2yBBd2LbIPXzseOAaDvzuOi6I=;
        b=VTXgD4KojJSGDFYKi1aEy+52veouBmCKEoTAzcpPXYryT3XkajWY8YNV3Zqqj1BOWU
         soYFz2doU7dtwXKdJITgWxwaQekr8mQeJ6Vp9qZVUnmYcSvbObSjbg9r/kwxknVHE0Pi
         4rRQrj78mYmCtSkz4lcjAxy4tPx4JopX05OM1YDMWcfxdQVR0BWIYhDzxohKOuo2Xbpq
         wUYMvZ6A2Xvvjolp0pT5g2TbuwsdSJc0jXwj8/ZxCXWr7SQMvVaBqdwnJCNU84Sh80hb
         OP0wI5XFGdjuV8YMebuCr6q0PARTGaHu52uiUtE8c4n3sjeOgCytfRrgPRKgtBU83aKE
         RvxQ==
X-Gm-Message-State: AOAM530NUvK+Ba7I1Co/oZhB1d1vVjfkX/Cs46FrMxHNeg6TCLC6SuO5
        xZURpiLMOWPmP2dnryN9OlVS5c3rho33MdymUotpbeDhDuy8ocW9gGmVP6kXF/J0JMkh9IRdygr
        7RvlnrCieB4NP95eVXDjDFXo=
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr566287wrj.185.1615827518993;
        Mon, 15 Mar 2021 09:58:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxf8ZZkQAvzrafu/QCYVzh/aotrIe8BtfHIGGCSksBVGk9W497j1C6xZhgVqF3BvGiPeDV/+w==
X-Received: by 2002:adf:cd8c:: with SMTP id q12mr566275wrj.185.1615827518814;
        Mon, 15 Mar 2021 09:58:38 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id n1sm555664wro.36.2021.03.15.09.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 09:58:38 -0700 (PDT)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/page_alloc: try oom if reclaim is unable to make forward progress
Date:   Mon, 15 Mar 2021 16:58:37 +0000
Message-Id: <20210315165837.789593-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the situation where direct reclaim is required to make progress for
compaction but no_progress_loops is already over the limit of
MAX_RECLAIM_RETRIES consider invoking the oom killer.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 mm/page_alloc.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7a2c89b21115..8d748b1b8d1e 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4181,6 +4181,16 @@ __alloc_pages_direct_compact(gfp_t gfp_mask, unsigned int order,
 	return NULL;
 }
 
+static inline bool
+should_try_oom(int no_progress_loops,
+		enum compact_result last_compact_result)
+{
+	if (no_progress_loops > MAX_RECLAIM_RETRIES && last_compact_result
+			== COMPACT_SKIPPED)
+		return true;
+	return false;
+}
+
 static inline bool
 should_compact_retry(struct alloc_context *ac, int order, int alloc_flags,
 		     enum compact_result compact_result,
@@ -4547,10 +4557,11 @@ should_reclaim_retry(gfp_t gfp_mask, unsigned order,
 	 * Make sure we converge to OOM if we cannot make any progress
 	 * several times in the row.
 	 */
-	if (*no_progress_loops > MAX_RECLAIM_RETRIES) {
-		/* Before OOM, exhaust highatomic_reserve */
-		return unreserve_highatomic_pageblock(ac, true);
-	}
+	if (*no_progress_loops > MAX_RECLAIM_RETRIES)
+		result false;
+	/* Last chance before OOM, try draining highatomic_reserve once */
+	else if (*no_progress_loops == MAX_RECLAIM_RETRIES)
+		return unreserve_highatomic_pageblock(ac, true)
 
 	/*
 	 * Keep reclaiming pages while there is a chance this will lead
@@ -4822,6 +4833,8 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 				 did_some_progress > 0, &no_progress_loops))
 		goto retry;
 
+	if (should_try_oom(no_progress_loops, compact_result))
+		goto oom:
 	/*
 	 * It doesn't make any sense to retry for the compaction if the order-0
 	 * reclaim is not able to make any progress because the current
@@ -4839,6 +4852,7 @@ __alloc_pages_slowpath(gfp_t gfp_mask, unsigned int order,
 	if (check_retry_cpuset(cpuset_mems_cookie, ac))
 		goto retry_cpuset;
 
+oom:
 	/* Reclaim has failed us, start killing things */
 	page = __alloc_pages_may_oom(gfp_mask, order, ac, &did_some_progress);
 	if (page)
-- 
2.26.2

