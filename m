Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77791379381
	for <lists+linux-kernel@lfdr.de>; Mon, 10 May 2021 18:15:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhEJQQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 May 2021 12:16:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57799 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231246AbhEJQQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 May 2021 12:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620663331;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=/I69q7HiZoit2OObK95SvLKEjN8YdPjb7FgV80ugf+k=;
        b=bF70TG42qsr9xMKcs/wmqQDdARB3JnceAMpZLowOLzeKkZrlAXeau/a15uPhKpTlg0ZHt/
        a9jjoHGBJUBh0dDsldW85wh8GGxaSOf2qMP9egZh4+iRI3yPZe/d4hyf5Qs3mbTJnkwdXS
        IuyItBylb+kRe9KWL/xjsu4ePc5ReZI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-QTn26Y4xOfCBw73am4k6hw-1; Mon, 10 May 2021 12:15:26 -0400
X-MC-Unique: QTn26Y4xOfCBw73am4k6hw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D782C8049D6;
        Mon, 10 May 2021 16:15:24 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.196.4])
        by smtp.corp.redhat.com (Postfix) with SMTP id B2BE960DBA;
        Mon, 10 May 2021 16:15:23 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon, 10 May 2021 18:15:24 +0200 (CEST)
Date:   Mon, 10 May 2021 18:15:22 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] remove the pointless BUG_ON(!task) from wake_up_q()
Message-ID: <20210510161522.GA32644@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

because it looks very confusing (to me at least). It is equivalent to
BUG_ON(node == offsetof(struct task_struct, wake_q)), unlikely this is
what we actually want to check.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
---
 kernel/sched/core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5226cc26a095..61d1d85bb93d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -585,7 +585,6 @@ void wake_up_q(struct wake_q_head *head)
 		struct task_struct *task;
 
 		task = container_of(node, struct task_struct, wake_q);
-		BUG_ON(!task);
 		/* Task can safely be re-inserted now: */
 		node = node->next;
 		task->wake_q.next = NULL;
-- 
2.25.1.362.g51ebf55


