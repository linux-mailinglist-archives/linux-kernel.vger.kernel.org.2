Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C1BA33EE46
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 11:26:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbhCQK0X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 06:26:23 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:14362 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229864AbhCQK0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 06:26:00 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4F0mTp2N28z9s02;
        Wed, 17 Mar 2021 18:23:58 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.174) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Wed, 17 Mar 2021 18:25:40 +0800
From:   Li Huafei <lihuafei1@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>, <jolsa@redhat.com>
CC:     <linux-kernel@vger.kernel.org>, <yangjihong1@huawei.com>,
        <xukuohai@huawei.com>, <zhangjinhao2@huawei.com>,
        <lihuafei1@huawei.com>
Subject: [PATCH 1/2] ftrace: Update ftrace_ops->next pointer with rcu_assign_pointer()
Date:   Wed, 17 Mar 2021 18:25:28 +0800
Message-ID: <20210317102529.226734-2-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210317102529.226734-1-lihuafei1@huawei.com>
References: <20210317102529.226734-1-lihuafei1@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.174]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The unregistered ftrace_ops may be freed by the caller, so we should use
rcu_assign_pointer() in remove_ftrace_ops() to remove the ftrace_ops,
which ensures that no more users will reference the ftrace_ops after
synchronize_rcu() is called.

Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 kernel/trace/ftrace.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4d8e35575549..2e315a145d20 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -282,7 +282,7 @@ static int remove_ftrace_ops(struct ftrace_ops __rcu **list,
 			lockdep_is_held(&ftrace_lock)) == ops &&
 	    rcu_dereference_protected(ops->next,
 			lockdep_is_held(&ftrace_lock)) == &ftrace_list_end) {
-		*list = &ftrace_list_end;
+		rcu_assign_pointer(*list, &ftrace_list_end);
 		return 0;
 	}
 
@@ -293,7 +293,7 @@ static int remove_ftrace_ops(struct ftrace_ops __rcu **list,
 	if (*p != ops)
 		return -1;
 
-	*p = (*p)->next;
+	rcu_assign_pointer(*p, (*p)->next);
 	return 0;
 }
 
-- 
2.17.1

