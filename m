Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 646F732BF7A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835517AbhCCSDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382271AbhCCPWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 10:22:23 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C4BC0613D7
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 07:20:41 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id e9so4540456pjj.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 07:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5BvSISNhyiieS6Lt7CkKj6ditEHD5Qh9Vwt8EfVWXaI=;
        b=AC8g6MSjZGIE4W/r1GP/Q8/kgf2bEobGyNGvPoinV0YoH5VxUL6wEzkIB2LCKPp3J7
         OKs01DB71uw8cUyPz21jLqGSmbmJJxfOji3OFTFjbLtrkeTOV0SXsdeP/O5LXkxkaa8P
         Reag2RY4NIpbC/2NLqOLBRXFXK2/tiU+L0+qcy0ioOd1dsx7ds51NhEfEjrAaDSyjAZQ
         zMdw70j7x8gHk1OiSHlX2/cu21kDztcmT063t6LJyxwdwIZZH1+HI/66wffOy5a7dOOf
         2iPZwnql10jU5gVl+CYoGZ3dFaC2jpLuam4xXNuYN1xr1f60y4uoa8DwxV2X4nBPQQt7
         x9ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5BvSISNhyiieS6Lt7CkKj6ditEHD5Qh9Vwt8EfVWXaI=;
        b=caQKyvwl+0TfJS8e7g3uHtU0BSssMAHFqJXTeapQGXMa20IYa/LFksXhF0i+YGpZcB
         dOPWGduPAFB3MenO/a5Reqbu/ebWnfRloSYDnf66CHLCjNd5oL/U2x+IVSJaBRHuVlnC
         gY0ynNWoQAcYpYPsoHjuh7yv3n8u3bJAM8cezh5Yj4L79eBuOmwuBKhHqPXBL3MAQ2UC
         pG3F3PGJjh4QGxbW8sTQOf5ZhMnFjZQ4cfwzl5g9VMFWoiZn1artUX5oAWuAIXGgBOM+
         9ztNuc/UBUD3xu5gXEhBH0gxfUV3X+nX1r9EDuhSYpH3UI2MWEZCPMcx1EgFiD9xxtTc
         +jsw==
X-Gm-Message-State: AOAM530sLFVmj0DiQqxHC/oplVLi3ukx656j4dAQP/MDQjcI3pfhMzWX
        apTurl6svju8P91mNJ7HfDcWPg==
X-Google-Smtp-Source: ABdhPJxbduSs8tHWr7wI6ECwWf+FCbh9A7S3QvnvVsKmTl3CPDHLjx+5wUEyLPYuHJvhU/W56EzkGA==
X-Received: by 2002:a17:902:9783:b029:e5:bfa2:dc24 with SMTP id q3-20020a1709029783b02900e5bfa2dc24mr5109006plp.70.1614784841479;
        Wed, 03 Mar 2021 07:20:41 -0800 (PST)
Received: from localhost.bytedance.net ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id u15sm23848588pfk.128.2021.03.03.07.20.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 07:20:41 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>
Subject: [PATCH v3] mm: memcontrol: fix kernel stack account
Date:   Wed,  3 Mar 2021 23:18:43 +0800
Message-Id: <20210303151843.81156-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For simplification 991e7673859e ("mm: memcontrol: account kernel stack
per node") has changed the per zone vmalloc backed stack pages
accounting to per node. By doing that we have lost a certain precision
because those pages might live in different NUMA nodes. In the end
NR_KERNEL_STACK_KB exported to the userspace might be over estimated on
some nodes while underestimated on others. But this is not a real world
problem, just a problem found by reading the code. So there is no actual
data to showing how much impact it has on users.

This doesn't impose any real problem to correctnes of the kernel
behavior as the counter is not used for any internal processing but it
can cause some confusion to the userspace.

Address the problem by accounting each vmalloc backing page to its own
node.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Michal Hocko <mhocko@suse.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
---
Changelog in v3:
 - Remove BUG_ON().
 - Update commit log.

Changelog in v2:
 - Rework commit log suggested by Michal.

 Thanks to Michal and Shakeel for review.

 kernel/fork.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d66cd1014211..242fdad6972b 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -379,14 +379,17 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 	void *stack = task_stack_page(tsk);
 	struct vm_struct *vm = task_stack_vm_area(tsk);
 
+	if (vm) {
+		int i;
 
-	/* All stack pages are in the same node. */
-	if (vm)
-		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
-				      account * (THREAD_SIZE / 1024));
-	else
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+			mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
+					      account * (PAGE_SIZE / 1024));
+	} else {
+		/* All stack pages are in the same node. */
 		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
 				      account * (THREAD_SIZE / 1024));
+	}
 }
 
 static int memcg_charge_kernel_stack(struct task_struct *tsk)
-- 
2.11.0

