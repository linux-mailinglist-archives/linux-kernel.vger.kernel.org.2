Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C929C32A28A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Mar 2021 15:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381578AbhCBIFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 03:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381467AbhCBHwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 02:52:39 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B539C061756
        for <linux-kernel@vger.kernel.org>; Mon,  1 Mar 2021 23:51:59 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id jx13so1384099pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Mar 2021 23:51:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bN47ivXpj44uDd+eS3oalq3hN35mGLxDMbSM9awpui4=;
        b=mOHNIk33N/Al/PiTr00q7RDSsuGzMRDRAmd9NGq9RAqYfYUJbxkGX1VZBr2LV59kP0
         j8rs4nsr5TrheqZ0pQoR7/KN6hcf0wP/+2z9Chun7np6J9IL0TwC/ljV3tzkXcsWU1Je
         J/KUaFSogO2KJ+wQMEOvWDYkNGQxSi+T4if/fixRQfLvATHf3uAmUOuEeU0tAzB3l4lC
         RZNMzfIg4s0Nl2Yz+c4wtb0pAyZW4sHjBfLlLqC6gqg78iHD27EgXO9+j9JgopGZkLG/
         Gn8S32tUa7DvtRIS8OA2j4ufRgd4qq9Yo5t3FC5dTOe6ktFMAEFjSpsFyffV5mvzN4me
         3pHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bN47ivXpj44uDd+eS3oalq3hN35mGLxDMbSM9awpui4=;
        b=Rfe5+cuPDQqBgeLEN8/vM/5WZs7gYjoDobmF85r95gt28f4CNVN0FujyvRMZKM5rJ8
         YLYJfnQ3p2KEpweLSS70HpJzuawfTWjoUm0ofZANF1XrEcQCYxMoEZCVBgAEJC+/+caZ
         tt9gMUwpoALuEOOjLLZe8EhILFgNdVyOH8aYyGX71rJhga7mg/2l8mcBJi7Cm14t2Kx9
         giVVxSeOPbCRqZ1FSb9xGqoJAVxO1h3djqRjGsndfIxz6IvQq5/L39ZflPAyTLTmkp+j
         60sOIvJATqYycFVyo4G3Bfp//dYUrUQtHP7Zy3HQBIrdtJicVtGaCBcAeZTLt8hK83S4
         1u3Q==
X-Gm-Message-State: AOAM532ZO5GpcCyDqIaZrUWcmIVazPHqytYcKb55m+TIJsJdcizS5Ve0
        KErFEvfF+8Wr0iG0vSkMvu2RBA==
X-Google-Smtp-Source: ABdhPJzbM4dnCe6mmqojgqbf1UfONZSWTjxhXlo2OLP9vvEl2c8I5Qbsv2mKExNkdx14Eix/BMt7+A==
X-Received: by 2002:a17:90b:4a03:: with SMTP id kk3mr3010892pjb.206.1614671518544;
        Mon, 01 Mar 2021 23:51:58 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id x14sm8602717pff.122.2021.03.01.23.51.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Mar 2021 23:51:57 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     guro@fb.com, hannes@cmpxchg.org, mhocko@kernel.org,
        akpm@linux-foundation.org, shakeelb@google.com
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH] mm: memcontrol: fix kernel stack account
Date:   Tue,  2 Mar 2021 15:37:33 +0800
Message-Id: <20210302073733.8928-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alloc_thread_stack_node() cannot guarantee that allocated stack pages
are in the same node when CONFIG_VMAP_STACK. Because we do not specify
__GFP_THISNODE to __vmalloc_node_range(). Fix it by caling
mod_lruvec_page_state() for each page one by one.

Fixes: 991e7673859e ("mm: memcontrol: account kernel stack per node")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 kernel/fork.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index d66cd1014211..6e2201feb524 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -379,14 +379,19 @@ static void account_kernel_stack(struct task_struct *tsk, int account)
 	void *stack = task_stack_page(tsk);
 	struct vm_struct *vm = task_stack_vm_area(tsk);
 
+	if (vm) {
+		int i;
 
-	/* All stack pages are in the same node. */
-	if (vm)
-		mod_lruvec_page_state(vm->pages[0], NR_KERNEL_STACK_KB,
-				      account * (THREAD_SIZE / 1024));
-	else
+		BUG_ON(vm->nr_pages != THREAD_SIZE / PAGE_SIZE);
+
+		for (i = 0; i < THREAD_SIZE / PAGE_SIZE; i++)
+			mod_lruvec_page_state(vm->pages[i], NR_KERNEL_STACK_KB,
+					      account * (PAGE_SIZE / 1024));
+	} else {
+		/* All stack pages are in the same node. */
 		mod_lruvec_kmem_state(stack, NR_KERNEL_STACK_KB,
 				      account * (THREAD_SIZE / 1024));
+	}
 }
 
 static int memcg_charge_kernel_stack(struct task_struct *tsk)
-- 
2.11.0

