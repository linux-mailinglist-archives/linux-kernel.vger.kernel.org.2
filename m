Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4454732A2E1
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:59:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238870AbhCBIfW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:35:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234733AbhCBIUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 03:20:39 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2229C061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 00:19:54 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id u11so11558661plg.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 00:19:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SDK+ajP5jBELnVhiWbUw5itoPVWVT0C+pRbdXA2pXzw=;
        b=M3wbBHDNI7w7ke6LqBh7MD9RPOf01wSC97wdKQu8q/EV8CoQAYCAM5Uz6qMUDtCjlB
         VKUdBCfqVmvLMBlHAFw/cxYqPbEPz3v5na3AuCoqbgYbRQJ8kQ63GP36LAPlcC8u+eFa
         Pkp8UeN6hz2syWJWH+RjC/NInThhKhUk3G0G5Kae/UC4hlKG4eRpRNcU5LO8MxEOTuzD
         0VcAWzogWN0HbGOSEolJcws8s0ShmixujgKl1EB/eZRBtCJlpf2jDuAEaXYlQGnFYzer
         Qm5g8vntBUDyn68OfHHlapgG6k8I2bkXdDWzJnAnIN+JKHmiJTYbrqRfJsgwZbpAu8kJ
         2tqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SDK+ajP5jBELnVhiWbUw5itoPVWVT0C+pRbdXA2pXzw=;
        b=tVNxMiPfbVkDUEun4cDOFszU6xe/jzS18PG41wqZFnUSITWHZ1pyyFga7GPJg6yz5c
         oDwZugotMohkyk2XEvmUKfoijaocw65OASaPtnAt5ikAFQwI9jjVlavnsRj6j4O6DLYv
         PYrVlz9AfXM3iGStlJ5I8nv4/touEh8ImFkWGFd9tFJbyiiRTqn74N3RxETP4nwwEVsh
         2RtOy/A2PfH3yFt9cL+h63z3Wj93fA+YUfGeX/ys1FIffcKKEHhDfrWPCWfOlXMiEqJb
         84RPQ7VagWMdiL34ogNukiawIjag01kjU/XsSr3VSsM1Z3Ill3LEP/fLzdyAcDhzCTKQ
         FhpA==
X-Gm-Message-State: AOAM5334WL7O5j29Lr5JP/vHodTNsDM6I2dKV/rLmuZQJ/K6yQJlQ0BL
        Q9ocg3AIsPRJJy5qP6E2DfYSmw==
X-Google-Smtp-Source: ABdhPJyB3ADWISJa4UEPElc5MoA53ychWV9OqL0XQVQ3l/BtTJlO7Ggf2HeajEQSQxgg06tQnj/wXQ==
X-Received: by 2002:a17:902:7d83:b029:e4:45ca:5407 with SMTP id a3-20020a1709027d83b02900e445ca5407mr19052690plm.57.1614673194229;
        Tue, 02 Mar 2021 00:19:54 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id j20sm2157781pjn.27.2021.03.02.00.19.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Mar 2021 00:19:53 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: fix root_mem_cgroup charging
Date:   Tue,  2 Mar 2021 16:18:23 +0800
Message-Id: <20210302081823.9849-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CPU0:                                   CPU1:

objcg = get_obj_cgroup_from_current();
obj_cgroup_charge(objcg);
                                        memcg_reparent_objcgs();
                                            xchg(&objcg->memcg, root_mem_cgroup);
    // memcg == root_mem_cgroup
    memcg = obj_cgroup_memcg(objcg);
    __memcg_kmem_charge(memcg);
        // Do not charge to the root memcg
        try_charge(memcg);

If the objcg->memcg is reparented to the root_mem_cgroup,
obj_cgroup_charge() can pass root_mem_cgroup as the first
parameter to here. The root_mem_cgroup is skipped in the
try_charge(). So the page counters of it do not update.

When we uncharge this, we will decrease the page counters
(e.g. memory and memsw) of the root_mem_cgroup. This will
cause the page counters of the root_mem_cgroup to be out
of balance. Fix it by charging the page to the
root_mem_cgroup unconditional.

Fixes: bf4f059954dc ("mm: memcg/slab: obj_cgroup API")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/memcontrol.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/memcontrol.c b/mm/memcontrol.c
index 2db2aeac8a9e..edf604824d63 100644
--- a/mm/memcontrol.c
+++ b/mm/memcontrol.c
@@ -3078,6 +3078,19 @@ static int __memcg_kmem_charge(struct mem_cgroup *memcg, gfp_t gfp,
 	if (ret)
 		return ret;
 
+	/*
+	 * If the objcg->memcg is reparented to the root_mem_cgroup,
+	 * obj_cgroup_charge() can pass root_mem_cgroup as the first
+	 * parameter to here. We should charge the page to the
+	 * root_mem_cgroup unconditional to keep it's page counters
+	 * balance.
+	 */
+	if (unlikely(mem_cgroup_is_root(memcg))) {
+		page_counter_charge(&memcg->memory, nr_pages);
+		if (do_memsw_account())
+			page_counter_charge(&memcg->memsw, nr_pages);
+	}
+
 	if (!cgroup_subsys_on_dfl(memory_cgrp_subsys) &&
 	    !page_counter_try_charge(&memcg->kmem, nr_pages, &counter)) {
 
-- 
2.11.0

