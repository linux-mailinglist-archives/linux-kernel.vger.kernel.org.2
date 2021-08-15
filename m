Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707713EC7A7
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Aug 2021 08:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233937AbhHOGMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Aug 2021 02:12:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbhHOGM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Aug 2021 02:12:29 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CB3C061764
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 23:12:00 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso27387200pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 14 Aug 2021 23:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fftJnEfxURxmLnjNiehf0RW0huZ6+SyHBdzxTuKx/o=;
        b=KlA7Owpqb9wMdALMfkbP245eOzJFTm+0iGL2VPl3Wxz88HOSFRIDB2fPBAU63yl8XQ
         MRcq7HRId8I60hE+m/yDu/nrCMgejvGdy3si6xT+KNGsPgP1RKFXAMqnZNPPal2Lc19n
         T0Biwxep/8TPjTt/r4TcYZFg8eOZ1EzLMrtiZZz5hMZcxXn0vAIcf1OLY8XWVkfam5RW
         d6Dq3QySxMfR0gzmS6OLJCWEdMXJedhsrUq5hkQzY4iWWzXELSXsZXBypuNtR4dyHqYH
         tmqEQVcDd4wXJipyTAV3UO3O/4kK4oxYMNtWK/0I3Z0poRD7Lfe42kNQDv+173W+RVhB
         pRGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fftJnEfxURxmLnjNiehf0RW0huZ6+SyHBdzxTuKx/o=;
        b=UgGLTyZtG3xTyXeoYiiWR5XTBHpP28DysDeJS+16F0QpUk2h1snzeXd/MHdUakCIal
         ARF89bd7loqjlHGinbfLP1jMGC/9/RDoi+x3qCjXdUOdise+v/M3lVGGRv8zYu3jguci
         JLz6O1we6AjZzD9po06uvGCPwJl2OeGHSSmV/mv57Ag52Zh1bDrmBzJGUoRg1vW5+RkZ
         AkAfsmJGoHXIl91j0i2wo/X4gEYHjgcXi3IBYbSB63prdvQwea5ZKixG35KDnisblBz3
         1mvlJcnCyb9GzW+/1Kf0DoHHtprdnChTraKqch+1T0k1S7q3d/2k9MgCAAIkppOQ7UO2
         3pcA==
X-Gm-Message-State: AOAM530IptPqfkNMaymMVDm7K/0Q5PztL4Y+bL/Nk8/KIm96lyzvLSCR
        rzZdDqsTdY0nffOkLGrHJeG/MA==
X-Google-Smtp-Source: ABdhPJzyvz7gCADthYV1BjySpsAiZPwYmlM4MhA+cOfI2OWRpSc3quL5Vlt3qKxLLb4neUPAPcW5gg==
X-Received: by 2002:a05:6a00:b95:b0:3e0:f3f4:6214 with SMTP id g21-20020a056a000b9500b003e0f3f46214mr10084426pfj.5.1629007919961;
        Sat, 14 Aug 2021 23:11:59 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.228])
        by smtp.gmail.com with ESMTPSA id h24sm6012565pjv.3.2021.08.14.23.11.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Aug 2021 23:11:57 -0700 (PDT)
From:   yanghui <yanghui.def@bytedance.com>
To:     akpm@linux-foundation.org, willy@infradead.org,
        songmuchun@bytedance.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        yanghui <yanghui.def@bytedance.com>
Subject: [PATCH v3] mm/mempolicy: fix a race between offset_il_node and mpol_rebind_task
Date:   Sun, 15 Aug 2021 14:10:34 +0800
Message-Id: <20210815061034.84309-1-yanghui.def@bytedance.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Servers happened below panic:
Kernel version:5.4.56
BUG: unable to handle page fault for address: 0000000000002c48
RIP: 0010:__next_zones_zonelist+0x1d/0x40
[264003.977696] RAX: 0000000000002c40 RBX: 0000000000100dca RCX: 0000000000000014
[264003.977872] Call Trace:
[264003.977888]  __alloc_pages_nodemask+0x277/0x310
[264003.977908]  alloc_page_interleave+0x13/0x70
[264003.977926]  handle_mm_fault+0xf99/0x1390
[264003.977951]  __do_page_fault+0x288/0x500
[264003.977979]  ? schedule+0x39/0xa0
[264003.977994]  do_page_fault+0x30/0x110
[264003.978010]  page_fault+0x3e/0x50

The reason of panic is that MAX_NUMNODES is passd in the third parameter
in function __alloc_pages_nodemask(preferred_nid). So if to access
zonelist->zoneref->zone_idx in __next_zones_zonelist the panic will happen.

In offset_il_node(), first_node() return nid from pol->v.nodes, after
this other threads may changed pol->v.nodes before next_node().
This race condition will let next_node return MAX_NUMNODES.So put
pol->nodes in a local variable.

The race condition is between offset_il_node and cpuset_change_task_nodemask:
CPU0:                                     CPU1:
alloc_pages_vma()
  interleave_nid(pol,)
    offset_il_node(pol,)
      first_node(pol->v.nodes)            cpuset_change_task_nodemask
                      //nodes==0xc          mpol_rebind_task
                                              mpol_rebind_policy
                                                mpol_rebind_nodemask(pol,nodes)
                      //nodes==0x3
      next_node(nid, pol->v.nodes)//return MAX_NUMNODES

Signed-off-by: yanghui <yanghui.def@bytedance.com>
---
Changes in v2:
	1.Fix WRITE_ONCE/READ_ONCE can't deal with more than sizeof(long) bits data. 
Changes in v3:
	1.Modify some wrong comments.

 mm/mempolicy.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e32360e90274..54f6eaff18c5 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1965,17 +1965,26 @@ unsigned int mempolicy_slab_node(void)
  */
 static unsigned offset_il_node(struct mempolicy *pol, unsigned long n)
 {
-	unsigned nnodes = nodes_weight(pol->nodes);
-	unsigned target;
+	nodemask_t nodemask = pol->nodes;
+	unsigned int target, nnodes;
 	int i;
 	int nid;
+	/*
+	 * The barrier will stabilize the nodemask in a register or on
+	 * the stack so that it will stop changing under the code.
+	 *
+	 * Between first_node() and next_node(), pol->nodes could be changed
+	 * by other threads. So we put pol->nodes in a local stack.
+	 */
+	barrier();
 
+	nnodes = nodes_weight(nodemask);
 	if (!nnodes)
 		return numa_node_id();
 	target = (unsigned int)n % nnodes;
-	nid = first_node(pol->nodes);
+	nid = first_node(nodemask);
 	for (i = 0; i < target; i++)
-		nid = next_node(nid, pol->nodes);
+		nid = next_node(nid, nodemask);
 	return nid;
 }
 
-- 
2.20.1

