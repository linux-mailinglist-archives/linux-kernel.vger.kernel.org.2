Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65271320D39
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Feb 2021 20:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhBUTnC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Feb 2021 14:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbhBUTnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Feb 2021 14:43:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A16C061574
        for <linux-kernel@vger.kernel.org>; Sun, 21 Feb 2021 11:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=u0pp3pCOXyFx4HcM+EazRcDG24U5Ejg58GS3gMTfMZ0=; b=C7jUF8JP2h9k8W51QsIx4q6vX4
        qa/Q+Uu5XQyOpBukK6FV9xz5KloxPhZftUWmLRq8vLhouWFZRISg0yk9ckjHWwBpwMBatn9+REiGm
        LVEXLgQnraSbMBK6MtzYWlOitUDYvToe/GHuKth6CFAjDqLLEr7YjpTUvGICDOzb+G2yVWcS7nzyp
        ULfeTVRfelzRZ5bCEa8mE3mOCz2C0GjI/AxJ1L/Y4iNReUn6K3Fs5I3rUzVhbwlIHaI+pQUCsl5dq
        yv8DCgL+GVoMdMe4Kya9P9YS+vqlGm29zZQuTwuyJ8DvwTWEMZAjakv3QnMwa43v0Y1BRkj04ABoL
        X87w+kUw==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lDucP-005fea-Qt; Sun, 21 Feb 2021 19:42:15 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-kernel@vger.kernel.org, Michal Hocko <mhocko@suse.com>
Subject: [PATCH] mm: Use rcu_dereference in in_vfork
Date:   Sun, 21 Feb 2021 19:42:06 +0000
Message-Id: <20210221194207.1351703-1-willy@infradead.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix a sparse warning by using rcu_dereference().  Technically this is a
bug and a sufficiently aggressive compiler could reload the `real_parent'
pointer outside the protection of the rcu lock (and access freed memory),
but I think it's pretty unlikely to happen.

Fixes: b18dc5f291c0 ("mm, oom: skip vforked tasks from being selected")
Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 include/linux/sched/mm.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 1ae08b8462a4..90b2a0bce11c 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -140,7 +140,8 @@ static inline bool in_vfork(struct task_struct *tsk)
 	 * another oom-unkillable task does this it should blame itself.
 	 */
 	rcu_read_lock();
-	ret = tsk->vfork_done && tsk->real_parent->mm == tsk->mm;
+	ret = tsk->vfork_done &&
+			rcu_dereference(tsk->real_parent)->mm == tsk->mm;
 	rcu_read_unlock();
 
 	return ret;
-- 
2.29.2

