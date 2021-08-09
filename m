Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1423E4425
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 12:47:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbhHIKrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 06:47:24 -0400
Received: from relay.sw.ru ([185.231.240.75]:48882 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234773AbhHIKq1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 06:46:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=+MinV0OqyhZKB/6ILPnbXLBy7PE/pthP+8hU4YA1Y5w=; b=Evb/rDmJ0dSj1YQsIh4
        jnW17qSVSdOiX7CtxlAxi9jOg2BJGgs4iDCg2Gey45lgxrgFfjJ26dTLDHkZa1pNlsqSXDm8/b6/6
        //83YZGr+vS5g7kqcA+kdB6Y/Gb3fKagw4sWivHtSPrd72gjSFc5ihPHntbLUpeT7mp4Sj2xowc=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mD2nA-006q0n-VV; Mon, 09 Aug 2021 13:46:00 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] mm: use in_task() in mempolicy_slab_node()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
Message-ID: <984ee771-4834-21da-801f-c15c18ddf4d1@virtuozzo.com>
Date:   Mon, 9 Aug 2021 13:46:00 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Obsoleted in_intrrupt() include task context with disabled BH,
it's better to use in_task() instead.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 2f8ee67..f436c53 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1922,7 +1922,7 @@ unsigned int mempolicy_slab_node(void)
 	struct mempolicy *policy;
 	int node = numa_mem_id();
 
-	if (in_interrupt())
+	if (!in_task())
 		return node;
 
 	policy = current->mempolicy;
-- 
1.8.3.1

