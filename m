Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 512ED34E54F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 12:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231552AbhC3KVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 06:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbhC3KUp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 06:20:45 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2412C061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:20:44 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id m7so11378965pgj.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 03:20:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mcUfJURbaW0/pk8mnMuxrluSpP/XrND4LfgaV4Zkidk=;
        b=PsPsxTwX9RegUj+h72lWw56jPXRtpLCx/YV8Qn7VSIrVh4YWoCvlIbbwkN/7NNwyk+
         dEMKW9ogd4Z0M8+Q822sY3pwhvICGO7iYNVOTGuVy53sxIaZ5KdqsI/WyR8ZgDw/TYDO
         o9jDHfwYW556VZbS0jJiRkNIjf7VfjVCkG/JwgNweU4W9+4pV1T1VvsbCXUx4ypeLAG7
         ptxVNfOszwBVySCntGTnWvJEL51GfJ1+AGDD2Q15o40rANP/n04vEDnimelG2SNYxHLB
         RRVF6fqkddY0HI70W3cBM7jVmBMcqlRDEzt1to5Y3q1g9Bn7CpWUR3Hwkx+oNtusgEa5
         Uelw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mcUfJURbaW0/pk8mnMuxrluSpP/XrND4LfgaV4Zkidk=;
        b=awmXMLaRlXSab3AJIPoeADBvdub0JPC7v+oJ+3LmHhuRQpQ5IPuZ2M32DVB2tGqlDQ
         D7ClAMrP5yx7kEUkR/5y/Akm/+2UsAThKAaurg0kS6SY/mM3PzzQ2nFfWU7PxUIF8H+E
         R4ejQYm9xeFa1OeTP1EOEm+zjs5OBmLJiveclZSEhhX4/JW1rAMGC2ucrA20ql7eNmgb
         QsnXF+6bCbnS4iHBPz3YlLz13475yjHIzFvLGyqm9mMF6P9zqIleSzqfvTTLZA0sesgB
         91nZzsnFlb68BoXjFchyB9FB0FhAdEWjM3FJXND/TJfnfVOQkCjlpypBAf0dIPbxRcLL
         ESTQ==
X-Gm-Message-State: AOAM530tpMdW6duZ5wN/+dpINnDdwB209Mzi8oVvuFeXKDOuZbgmXGtr
        JsI5rdjyihgB5rlLIo65Wgy+vw==
X-Google-Smtp-Source: ABdhPJx1NdxoJRBW9S7K0gOi/pa+6k+EGwxyShNbEsEIgqn2JJqbABL3/JMzYOnVkpIcYjvuvyEtHQ==
X-Received: by 2002:a65:5308:: with SMTP id m8mr26343234pgq.266.1617099644225;
        Tue, 30 Mar 2021 03:20:44 -0700 (PDT)
Received: from localhost.localdomain ([2408:8445:ad30:68d8:c87f:ca1b:dc00:4730])
        by smtp.gmail.com with ESMTPSA id k10sm202259pfk.205.2021.03.30.03.20.33
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Mar 2021 03:20:43 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com,
        vdavydov.dev@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        duanxiongchun@bytedance.com, Muchun Song <songmuchun@bytedance.com>
Subject: [RFC PATCH 01/15] mm: memcontrol: fix page charging in page replacement
Date:   Tue, 30 Mar 2021 18:15:17 +0800
Message-Id: <20210330101531.82752-2-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210330101531.82752-1-songmuchun@bytedance.com>
References: <20210330101531.82752-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The pages aren't accounted at the root level, so do not charge the page
to the root memcg in page replacement. Although we do not display the
value (mem_cgroup_usage) so there shouldn't be any actual problem, but
there is a WARN_ON_ONCE in the page_counter_cancel(). Who knows if it
will trigger? So it is better to fix it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 249bf6b4d94c..d0c4f6e91e17 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -6936,9 +6936,11 @@ void mem_cgroup_migrate(struct page *oldpage, struct page *newpage)
 	/* Force-charge the new page. The old one will be freed soon */
 	nr_pages = thp_nr_pages(newpage);
 
-	page_counter_charge(&memcg->memory, nr_pages);
-	if (do_memsw_account())
-		page_counter_charge(&memcg->memsw, nr_pages);
+	if (!mem_cgroup_is_root(memcg)) {
+		page_counter_charge(&memcg->memory, nr_pages);
+		if (do_memsw_account())
+			page_counter_charge(&memcg->memsw, nr_pages);
+	}
 
 	css_get(&memcg->css);
 	commit_charge(newpage, memcg);
-- 
2.11.0

