Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D29B45CC9F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 19:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350887AbhKXTCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 14:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbhKXTBx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 14:01:53 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34595C061746
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:58:43 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id l8so3704926qtk.6
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 10:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c8O4w4nNPT48Gz0ug3bIri+YOWUNMewgSmQGxvpFnas=;
        b=LEPblEdbTMxrbKN35oBufL867FsoCNA/nV/tHj4hwBCsprMCXbNk+GtDRAa9UHe/hO
         CpjryhYp9QjFwcpG2Soe1Ly7qQb1jZGZZxC/3hcEnWihYika6GYh4TjyajuXqRU0noQ0
         PFsQn8jexN4t3at883m8Z4moCvw2KMtpvsETu4NnJFlQKJAEcamh/8dOGuIzfpbHyX8w
         lp9ldPtS678svFM8YQEivq+ksZwGZ76Ft71Ua9HpTheovrv6DTcgpIdh9kcLhJSj0h53
         rU4wLOL0EzNopsMtn+aAwSNvsusJbGOq/XySZ8SjwxBH7s7d8PU52IyQiAK4mMfxc1im
         iSOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c8O4w4nNPT48Gz0ug3bIri+YOWUNMewgSmQGxvpFnas=;
        b=2OM2/DFD230gEpfJUdZxvD1RkPITo2p2jkXD/LQMttFICFRTnT8k4EtPuZEpxS/V9c
         xURRIrhOI4JRGIhdK4c34D7r3bo+VZEGXsq1I2fBy/LedoRfncS+ZaS/G4W9T+wemV/n
         qtKfCDTk2ZA035apWpot2vxeT3nvv8eT2LqEwTA8cTEIpr/mkh7IRqesns//MO9g97Nr
         sycIoDbqO4tirSOHlM7ZPxanlI/3+/eQ8KqxS+Q03LpyIn9YIvHTQ9o6c/OTEiTfAIew
         Evt3Vwd2A+X273CPc7qNcdrYKJpz5OMH0BcWPYBpvO71M1EPYO2KkMa9OrrNfhBg+Aos
         Zg1Q==
X-Gm-Message-State: AOAM5311qXgwD6R9fym4XtNX+/Eeuj6DLttfF0wD8egCFsAPipavDzKi
        Rng9WNUd9I3gSuCUshnwUYk=
X-Google-Smtp-Source: ABdhPJwi0QsIpPMyyN2YfjBQZcNe66urLapq29ZrTQ6Gar5CnAHDLAYsvG7j8AZiMPs+QWIWUe1LJw==
X-Received: by 2002:ac8:588e:: with SMTP id t14mr1267458qta.437.1637780322392;
        Wed, 24 Nov 2021 10:58:42 -0800 (PST)
Received: from hasanalmaruf-mbp.thefacebook.com ([2620:10d:c091:480::1:a1b0])
        by smtp.gmail.com with ESMTPSA id r16sm315775qkp.42.2021.11.24.10.58.41
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Nov 2021 10:58:42 -0800 (PST)
From:   Hasan Al Maruf <hasan3050@gmail.com>
X-Google-Original-From: Hasan Al Maruf <hasanalmaruf@fb.com>
To:     dave.hansen@linux.intel.com, ying.huang@intel.com,
        yang.shi@linux.alibaba.com, mgorman@techsingularity.net,
        riel@surriel.com, hannes@cmpxchg.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] active LRU-based promotion to avoid ping-pong
Date:   Wed, 24 Nov 2021 13:58:30 -0500
Message-Id: <80a0cfd545a01ce0470a727cb961a5e0a1532d48.1637778851.git.hasanalmaruf@fb.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <cover.1637778851.git.hasanalmaruf@fb.com>
References: <cover.1637778851.git.hasanalmaruf@fb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Whenever a remote hint-fault happens on a page, the default NUMA
balancing promotes the page without checking its state. As a result,
cold pages with very infrequent accesses, can still be the promotion
candidates. Once promoted to the local node, these type of pages may
shortly become the demotion candidate if the toptier nodes are always
under pressure. Thus, promotion traffics generated from infrequently
accessed pages can easily fill up the toptier node's reclaimed free
spaces and eventually generate a higher demotion traffic for the non-
toptier node. This demotion-promotion ping-pong causes unnecessary
traffic over the memory nodes and can negatively impact on the
performance of memory bound applications.

To solve this ping-pong issue, instead of instant promotion, we check
a page's age through its position in the LRU list. If the faulted page
is in inactive LRU, then we don't instantly consider the page as the
promotion candidate as it might be an infrequently accessed pages. We
only consider the faulted pages that are in the active LRUs (either
of anon or file active LRU) as the promotion candidate. This approach
significantly reduce the promotion traffic and always maintain a
satisfactory amount of free memory on the toptier node to support both
new allocations and promotion from non-tortier nodes.

Signed-off-by: Hasan Al Maruf <hasanalmaruf@fb.com>
---
 mm/memory.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index 314fe3b2f462..1c76f074784a 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4202,6 +4202,19 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 
 	last_cpupid = page_cpupid_last(page);
 	page_nid = page_to_nid(page);
+
+	/* Only migrate pages that are active on non-toptier node */
+	if (numa_promotion_tiered_enabled &&
+		!node_is_toptier(page_nid) &&
+		!PageActive(page)) {
+		count_vm_numa_event(NUMA_HINT_FAULTS);
+		if (page_nid == numa_node_id())
+			count_vm_numa_event(NUMA_HINT_FAULTS_LOCAL);
+		mark_page_accessed(page);
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
+		goto out;
+	}
+
 	target_nid = numa_migrate_prep(page, vma, vmf->address, page_nid,
 			&flags);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-- 
2.30.2

