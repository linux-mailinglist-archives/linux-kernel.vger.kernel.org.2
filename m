Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C63A3E411F
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 09:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233593AbhHIHwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 03:52:12 -0400
Received: from relay.sw.ru ([185.231.240.75]:58636 "EHLO relay.sw.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233558AbhHIHwJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 03:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=virtuozzo.com; s=relay; h=Content-Type:MIME-Version:Date:Message-ID:Subject
        :From; bh=mGHCmUBVtvGkrk3hZTW9nEpmEe7bL+y6TyOwWlgp52s=; b=Ef0RqscTUPW5j7jTgxS
        ucOGykVjk+DzLTmCGNBtEwO1q5DP3AoVEZUEILeZMOOdrmdHsq9SS3oPFOYDrTdtQFCpwRevYk/MG
        Lc/IwbemORjzNItaKJK3T4xC+T7n7IcNkOHjlP3BXPeGQ+xJKq2VWQkaVNPYb+N1qZQiqkeYUu4=;
Received: from [10.93.0.56]
        by relay.sw.ru with esmtp (Exim 4.94.2)
        (envelope-from <vvs@virtuozzo.com>)
        id 1mD04Y-006p2o-TJ; Mon, 09 Aug 2021 10:51:46 +0300
From:   Vasily Averin <vvs@virtuozzo.com>
Subject: [PATCH] mm: use in_task() in alloc_pages()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, kernel@openvz.org
Message-ID: <96b9726a-4e43-bcf3-a27f-8fb7aa4a170b@virtuozzo.com>
Date:   Mon, 9 Aug 2021 10:51:45 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

obsoleted in_interrupt() includes task context with enabled BH,
it's better to use in_task() instead.

Signed-off-by: Vasily Averin <vvs@virtuozzo.com>
---
 mm/mempolicy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index e32360e..2f8ee67 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -2231,7 +2231,7 @@ struct page *alloc_pages(gfp_t gfp, unsigned order)
 	struct mempolicy *pol = &default_policy;
 	struct page *page;
 
-	if (!in_interrupt() && !(gfp & __GFP_THISNODE))
+	if (in_task() && !(gfp & __GFP_THISNODE))
 		pol = get_task_policy(current);
 
 	/*
-- 
1.8.3.1

