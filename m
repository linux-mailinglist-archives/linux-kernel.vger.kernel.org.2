Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6E43E24B1
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 10:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243293AbhHFIEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 04:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:25419 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242910AbhHFIEU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 04:04:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628237045;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=reMcVUzbZuKNRGHwcS00YNubJE12yexOy3BvjExRkVM=;
        b=Q2KPe1GE5nM5UZIPAWIlKIVB8xkM5DXp1mDn3FW2LGB81PjbfrOBskEWKbuO2gq0NnLSup
        Ee7Wk5GRNbKOBsQ8BPntu3ZwjJmOOtWIEOO6xJJVBf1gHJTr3OcrWukhMt5BC650cH0iKl
        LRklKJiUtHkdqqx40xaVhL3WlzgWBzc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-MedePmHHNVaFUiTRGVq_iw-1; Fri, 06 Aug 2021 04:04:03 -0400
X-MC-Unique: MedePmHHNVaFUiTRGVq_iw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 97DAE180FCCA;
        Fri,  6 Aug 2021 08:04:02 +0000 (UTC)
Received: from localhost (ovpn-13-152.pek2.redhat.com [10.72.13.152])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6C7FA60BF4;
        Fri,  6 Aug 2021 08:03:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 5/7] loop: improve loop_process_work
Date:   Fri,  6 Aug 2021 16:03:00 +0800
Message-Id: <20210806080302.298297-6-ming.lei@redhat.com>
In-Reply-To: <20210806080302.298297-1-ming.lei@redhat.com>
References: <20210806080302.298297-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index 6e5c55d4552b..c322d6468ee7 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -2238,21 +2238,26 @@ static void loop_process_work(struct loop_worker *worker,
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

