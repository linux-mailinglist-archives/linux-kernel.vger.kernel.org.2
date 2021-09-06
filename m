Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD7D40154C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 05:47:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbhIFDsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Sep 2021 23:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbhIFDsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Sep 2021 23:48:11 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01464C061575
        for <linux-kernel@vger.kernel.org>; Sun,  5 Sep 2021 20:47:08 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e7so5417061pgk.2
        for <linux-kernel@vger.kernel.org>; Sun, 05 Sep 2021 20:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fftJnEfxURxmLnjNiehf0RW0huZ6+SyHBdzxTuKx/o=;
        b=TfA0WDbUFHaZfHvm3PYlKKYwkRLysiF/NZG0t3L7yMmQspKOl2FWoV69dajjXVgVU+
         yLVcbRpwgVWcvfRhAmDfHN0VdR51oYSbFY7knC9EjmeqkMscKMHmyvQjITqfCyVmFGs9
         cw6GYvzZSg6xWRTAtXUCfUmUkA0CCcqWuE6WsXjcamPHrk8l1KJG8Hy/ZiSRcKQy+r1u
         FjhpPxnHLZlH5lTjK+Q4c3vKZ1g+ropq2JN1oYSMBYldy5Iy+irRFfdI6qeNgkRkJYuu
         TjBYBjz/amTboViNMqk9c73sh9pbMeI1UE3H4KxWqDyp7reGONQ3/fmfMUnxIVssd1Ub
         gRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3fftJnEfxURxmLnjNiehf0RW0huZ6+SyHBdzxTuKx/o=;
        b=pY2BZLb2V/sYYzo6h6z9rnK3P7yinj6ibcHq9An/n4wsWiMAkSMX/eZQejTQuymHGb
         aVdXBSZs1l/6ZEeg7D0U24ropheOKTBaybyPVQ/eZeKGGJ8HRt/Ookkn7B7yTbzH82jS
         6Y9r7bgLmpfw5/a6P8kFdYbrOiaTnfbLKe+euSpwBHQ4h3t/Kyqu99dv3slIJeoi0Qee
         jielBw09KWUQcEI9NogW0Lunh8K5aqUftByKHqwJKzuLE3O5LeKePy+SxKHNOpss4XJ3
         QEu+FAtDoeVCTfK/IP+OlMni+8WJ+RRijGXikKQAkyEko/WKQMZ1xyinbQipKib56WjY
         UB7w==
X-Gm-Message-State: AOAM532fiTmsRj0khI2Ie3TDdAxtuUwDttMD9y+Hxdm7lw2CZz02kWgv
        aX9uhH5lfb8klm9UwUS5QW73uA==
X-Google-Smtp-Source: ABdhPJwrsSAYh0ecu95UAEBYKRWrifyqcsR2KmtRTzK0Q3YuNI9tnSnGfYsAlFdnr1ze5jzmP/PVtw==
X-Received: by 2002:a63:ec45:: with SMTP id r5mr10368048pgj.440.1630900027510;
        Sun, 05 Sep 2021 20:47:07 -0700 (PDT)
Received: from C02D84JPML85.bytedance.net ([61.120.150.73])
        by smtp.gmail.com with ESMTPSA id t22sm5566162pfg.109.2021.09.05.20.47.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 05 Sep 2021 20:47:07 -0700 (PDT)
From:   yanghui <yanghui.def@bytedance.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        songmuchun@bytedance.com, yanghui <yanghui.def@bytedance.com>
Subject: [RESEND PATCH v3] mm/mempolicy: fix a race between offset_il_node and mpol_rebind_task
Date:   Mon,  6 Sep 2021 11:46:58 +0800
Message-Id: <20210906034658.48721-1-yanghui.def@bytedance.com>
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
