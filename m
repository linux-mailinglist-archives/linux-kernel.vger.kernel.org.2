Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630953EEB72
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Aug 2021 13:18:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239726AbhHQLSs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Aug 2021 07:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbhHQLSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Aug 2021 07:18:47 -0400
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6481C061764
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:18:14 -0700 (PDT)
Received: by mail-pl1-x632.google.com with SMTP id e19so24514211pla.10
        for <linux-kernel@vger.kernel.org>; Tue, 17 Aug 2021 04:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EEINe84h82Nr8cZPHhst9BqdEgCODyBcfNaQJApgh3c=;
        b=nXaliWRfwpXvPL3GxGSlKTabL7eVqO2kuJYOhhDUPHiJb+IvHcYXJhkuZn5VpEv24e
         fjSLUpBpB9WgtOry8NZENHjKFv5MeKKYZU3NTuF87A7hNc/UVn4QXwxcQlxaZO/RiLxx
         36Dg/jZ97BBsAA/eGvuphn2InziQs3K4TTatfC7V4VQAOWurefWq2JM68MFXc2tH9Gda
         jZOSfZFPb4Y97rxVuQtotGYriTwEuUpZTHDhx24RsFUUoZZCGEvC0IDP/isOBSn8o7lh
         fI0cLNjCyms73Kva6h3yvjXLe0tNIg35I/IgJLpXL4oWgpDJaq1kyz/clNvQ9o4ZSwP5
         /C0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EEINe84h82Nr8cZPHhst9BqdEgCODyBcfNaQJApgh3c=;
        b=FPMvt1UH8Kp8H75MolEi/4/bZkJWFnQN9pYrq2LnLzIRGXsy7DShyMlTJ1s42tDiQE
         zQFwsvUNcBd0dmiPrFJJq2duK2Q/oYoYAXUS2VdPbdh+ijkXCps8Ycpzryzhh/xmKnY9
         oteLwSy7uUUZ6l/idu5A6ppRmoL+lmRtsD8FTF0jheGrGoUoBGaX3H8kk6HKoDesQPV0
         HQjs4AbxqW0a/wNQqZG5eW8CAedOACyyR4T0v/0FkGzVzmXxlacJrclqmGG/ALxME2qy
         8nNtTHF/0LO5sr+6/vcklWaNirvPC7sS2jbxdYrmcIipsjUvcvowrQ+h52VhI5hrDxxw
         rVdg==
X-Gm-Message-State: AOAM530HAlMEtrWgy47IK38QH2ORhDqJi3is4E6MZ7kxbVV3PgEPqacR
        bE6ikhClIaiwBYFwEiroLs2DZdzzIEo=
X-Google-Smtp-Source: ABdhPJzCQIA53dVTliTYPmcdn7D5ISJB3/1je7FgP8UvwE5Wo1rM01LzE8Kht0CktWhPXSzCLXrLjQ==
X-Received: by 2002:a17:902:9b90:b029:12d:5ce1:4d99 with SMTP id y16-20020a1709029b90b029012d5ce14d99mr2391870plp.37.1629199093806;
        Tue, 17 Aug 2021 04:18:13 -0700 (PDT)
Received: from localhost ([47.251.3.230])
        by smtp.gmail.com with ESMTPSA id y6sm1969532pjr.48.2021.08.17.04.18.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Aug 2021 04:18:13 -0700 (PDT)
From:   Lai Jiangshan <jiangshanlai@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     lizefan.x@bytedance.com, lizhe.67@bytedance.com,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: [PATCH 3/6] workqueue: Change the code of calculating work_flags in insert_wq_barrier()
Date:   Tue, 17 Aug 2021 09:32:36 +0800
Message-Id: <20210817013239.3921-4-jiangshanlai@gmail.com>
X-Mailer: git-send-email 2.19.1.6.gb485710b
In-Reply-To: <20210817013239.3921-1-jiangshanlai@gmail.com>
References: <CAJhGHyBsn+rqVQzNqRw2RxtpHyrpQpa0kMtU1RcZP7TCbC6dqg@mail.gmail.com>
 <20210817013239.3921-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lai Jiangshan <laijs@linux.alibaba.com>

Add a local var @work_flags to calculate work_flags step by step, so that
we don't need to squeeze several flags in only the last line of code.

Parepare for next patch to add a bit to barrier work item's flag.  Not
squshing this to next patch makes it clear that what it will have changed.

No functional change intended.

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 kernel/workqueue.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 0a4fae7cb918..55fc2d1688d9 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -2660,8 +2660,8 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 			      struct wq_barrier *barr,
 			      struct work_struct *target, struct worker *worker)
 {
+	unsigned int work_flags = work_color_to_flags(WORK_NO_COLOR);
 	struct list_head *head;
-	unsigned int linked = 0;
 
 	/*
 	 * debugobject calls are safe here even with pool->lock locked
@@ -2687,13 +2687,12 @@ static void insert_wq_barrier(struct pool_workqueue *pwq,
 
 		head = target->entry.next;
 		/* there can already be other linked works, inherit and set */
-		linked = *bits & WORK_STRUCT_LINKED;
+		work_flags |= *bits & WORK_STRUCT_LINKED;
 		__set_bit(WORK_STRUCT_LINKED_BIT, bits);
 	}
 
 	debug_work_activate(&barr->work);
-	insert_work(pwq, &barr->work, head,
-		    work_color_to_flags(WORK_NO_COLOR) | linked);
+	insert_work(pwq, &barr->work, head, work_flags);
 }
 
 /**
-- 
2.19.1.6.gb485710b

