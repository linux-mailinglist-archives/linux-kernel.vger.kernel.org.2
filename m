Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3CA732BCC9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244448AbhCCOr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 09:47:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843015AbhCCKXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:23:50 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7148DC08EB27
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 01:41:27 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id m6so15883313pfk.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 01:41:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HuoFzrfHBgRpGB1S/Pm90uFoEaWpFEXI5cv//wG4H2s=;
        b=Xr6ER+bksZxkJbMXLoySGxJaEmmcYGK3nmHQapWxz3W7BTIa8Y+vTnfB6r/G+HFBqt
         DEJtMk6baSN0IO1VhtSHxnr9HFL+mXL30chhMwpW2HSGa1meGo3N44SyxDSzST4IbA8h
         qVTWdIctGswX7OumTWDziApBZqlzcCzNP6Skst0zK+ex8KotHXi7KTUc/lAm6uGod8vL
         EEGYX3KI+2ovo+s3zh+bsp+8VJTGE6A2GvX0/Wh9jsGo2EcQd2SX4g1QMwd8GVdWXXq/
         pXL214erEC2KeZQVnfHESUCmOzYRkcvBJZxfDgaXemkAdCv6iC2DjQ8LniDyopVb4ZIY
         B94Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=HuoFzrfHBgRpGB1S/Pm90uFoEaWpFEXI5cv//wG4H2s=;
        b=FwjCWqhPqMSK1CmdTVSgqrXl/+FCzODdfdsWb7kdV2zfpZXXfjOl2cUnXj9UoHboIO
         OQ0YnwqapaG663ODOyncf61B2MahecD1jpCuC6GXJrCFCPqJYwK6JC4xgYcZePOeltpS
         PHtJn0VMPHLSdiWWYRoycw5pUfAW5gv8GprVny94MsavJm1ZdA6+B6orgYl4outx16Aw
         vbIR01qCsekakiHGJSZlvg4alEVTEGkAuM1zaMrrA8JMIlcM6xfjkfcuXw+F6aZrtfSf
         BrWeDSPE9jhjd2a7uwtX9TkvbtdfDWSrHWwl6cBbUWkJddT4KFocvysW/nNobaDJTe85
         eDnA==
X-Gm-Message-State: AOAM530+LhyK5hDPGVyv7kNq35dlrpZSu8St4cgODqbBrkfPhJhjRjho
        MlkmE78PNSKCpq6Sbl9fXz+yDQ==
X-Google-Smtp-Source: ABdhPJxf4CEDONXrnyzwQQbOoexCzNLf9VH258dboqUGrOOFaod19GbchLPaEuPlDKJSwM5iWYBC1g==
X-Received: by 2002:a63:5b57:: with SMTP id l23mr4313299pgm.445.1614764487006;
        Wed, 03 Mar 2021 01:41:27 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id u66sm26346459pfc.72.2021.03.03.01.41.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Mar 2021 01:41:26 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2] mm: memcontrol: fix kernel stack account
Date:   Wed,  3 Mar 2021 17:39:56 +0800
Message-Id: <20210303093956.72318-1-songmuchun@bytedance.com>
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
some nodes while underestimated on others.

This doesn't impose any real problem to correctnes of the kernel
behavior as the counter is not used for any internal processing but it
can cause some confusion to the userspace.

Address the problem by accounting each vmalloc backing page to its own
node.

Fixes: 991e7673859e ("mm: memcontrol: account kernel stack per node")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Shakeel Butt <shakeelb@google.com>
---
Changelog in v2:
 - Rework commit log suggested by Michal.

 Thanks to Michal and Shakeel for review.

 kernel/fork.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d66cd1014211..6e2201feb524 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -379,14 +379,19 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 	void *stack = task_stack_page(tsk);
 	struct vm_struct *vm = task_stack_vm_area(tsk);
 
+	if (vm) {
+		int i;
 
-	/* All stack pages are in the same node. */
-	if (vm)
-		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
-				      account * (THREAD_SIZE / 1024));
-	else
+		BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
+
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

