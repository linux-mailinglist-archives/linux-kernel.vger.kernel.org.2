Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C980B3E4181
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 10:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbhHIIXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 04:23:54 -0400
Received: from relay.sw.ru ([185.231.240.75]:33552 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233918AbhHIIXw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 04:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=rZYbYIu955Y7hbPYqYijgiSxa3DY4s64eyftIBXNDoQ=; b=A4J6Igvn/OmmYPUyuM9
        0JxUZ0FQUQeoNPPC++M0k8ce6h5nvQaRwNkoUWYPNBx0YW9THcnNGkOJZ32XLBIqL1kPLV1JwGAO4
        HJe1gLXVzpLYPHu7j+5OeFrDTRlMKYOz6OFbqHRAvleaANC+8uxKtfz1Asjz0go551YbplWhs9A=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mD0ZG-006p7c-Ux; Mon, 09 Aug 2021 11:23:30 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] mm: use in_task() in __gfp_pfmemalloc_flags()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
Message-ID: <f748aef6-9def-bea1-de7f-5ff88d7b3285@virtuozzo.com>
Date:   Mon, 9 Aug 2021 11:23:29 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

obsoleted in_interrupt() include task context with disabled BH,
it's better to use in_task() instead.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/page_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 856b175..4291639 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4733,7 +4733,7 @@ static inline int __gfp_pfmemalloc_flags(gfp_t gfp_mask)
 		return ALLOC_NO_WATERMARKS;
 	if (in_serving_softirq() && (current->flags & PF_MEMALLOC))
 		return ALLOC_NO_WATERMARKS;
-	if (!in_interrupt()) {
+	if (in_task()) {
 		if (current->flags & PF_MEMALLOC)
 			return ALLOC_NO_WATERMARKS;
 		else if (oom_reserves_allowed(current))
-- 
1.8.3.1

