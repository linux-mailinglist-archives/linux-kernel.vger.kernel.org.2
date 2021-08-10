Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBE153D899B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbhG1IRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44795 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235198AbhG1IRW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627460240;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hwh6aUdGy6GdjesgVgKIb/g5hwOkFlCeOkL45Bn/jkI=;
        b=dvrxpLqz1aRrs6L3h+mkT530ylz0kTqgndQmVxk8CRVlWeUGXTAqivYGcyQF/ObbcdVInZ
        133ISd9QakF9uqDtOqiuErugeI4D0WBzhOLuaZVIfEa0HD9PZvlJQtSLqVF4QNUwUEEP47
        rLEWpPQKmUPxKwuTvc3IW7QA2YJ4tm0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-dcrYKHfnPaChe1T48t4b0g-1; Wed, 28 Jul 2021 04:17:19 -0400
X-MC-Unique: dcrYKHfnPaChe1T48t4b0g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36EF81006C80;
        Wed, 28 Jul 2021 08:17:18 +0000 (UTC)
Received: from localhost (ovpn-13-99.pek2.redhat.com [10.72.13.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A88C369CB7;
        Wed, 28 Jul 2021 08:17:13 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V2 5/7] loop: improve loop_process_work
Date:   Wed, 28 Jul 2021 16:16:36 +0800
Message-Id: <20210728081638.1500953-6-ming.lei@redhat.com>
In-Reply-To: <20210728081638.1500953-1-ming.lei@redhat.com>
References: <20210728081638.1500953-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid to acquire the spinlock for handling every loop command, and hold
lock once for taking all commands.

Acked-by: Dan Schatzberg <schatzberg.dan@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/loop.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 4c524c72d976..74682c0f3f86 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2174,21 +2174,26 @@ static void loop_process_work(struct loop_worker *worker,
 {
 	int orig_flags = current->flags;
 	struct loop_cmd *cmd;
+	LIST_HEAD(list);
 
 	current->flags |= PF_LOCAL_THROTTLE | PF_MEMALLOC_NOIO;
+
 	spin_lock(&lo->lo_work_lock);
-	while (!list_empty(cmd_list)) {
-		cmd = container_of(
-			cmd_list->next, struct loop_cmd, list_entry);
-		list_del(cmd_list->next);
-		spin_unlock(&lo->lo_work_lock);
+ again:
+	list_splice_init(cmd_list, &list);
+	spin_unlock(&lo->lo_work_lock);
 
-		loop_handle_cmd(cmd);
-		cond_resched();
+	while (!list_empty(&list)) {
+		cmd = list_first_entry(&list, struct loop_cmd, list_entry);
+		list_del_init(&cmd->list_entry);
 
-		spin_lock(&lo->lo_work_lock);
+		loop_handle_cmd(cmd);
 	}
 
+	spin_lock(&lo->lo_work_lock);
+	if (!list_empty(cmd_list))
+		goto again;
+
 	/*
 	 * We only add to the idle list if there are no pending cmds
 	 * *and* the worker will not run again which ensures that it
-- 
2.31.1

