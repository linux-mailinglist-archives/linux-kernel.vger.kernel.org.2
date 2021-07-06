Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 414E53BC5CE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 06:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhGFEz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 00:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhGFEz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 00:55:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76BD4C061574
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jul 2021 21:53:17 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id y4so18379291pfi.9
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jul 2021 21:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=dec2ufKN6YYQDXwU/Q4zEmz75veKreDLcQE2uMYR8Ho=;
        b=ngdLb2G6197+5RKV76YLasp+pQkM2SN+Zp2NyPvD3lOl9PTV3j9XDBKGKiULFxeJV6
         cJZollxH6I8i5lDroogTK09zCAolvDRoBhnvnqzFvwKWqj8+PSWsBHaPgDIH670+4uZB
         4X9Q3s7KoVsfTEYGfZKqMUoyglVF+v7ezSRtlsg92IymjzFL3M6to+t5rqo3zTd5iO/+
         jKFiA0Hj52hKNUsf7KJlAa4e/MRuvFuZ1MsY/3hon8mzj3XlVywk6ETwA7R8f0v0dKm8
         yZ5nHxzGxf14m870AWPwbAPj0OqH226eJinxj71GjJlXqi05B0VYACcjr2yWgSCi8MkO
         wVkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=dec2ufKN6YYQDXwU/Q4zEmz75veKreDLcQE2uMYR8Ho=;
        b=g5y4MYyFrVeNVNDUkwvqRc3QxzjnOb6TIW726mGDv5w8BnQrFrvAY08rlkdm66e0kT
         fBOaX+A4tuNmrXzGImTVPBuRdEO4v13dezHSTYbxjJMB5CyhwnxYWO0z6EK1Eywbfsud
         QuhFqg6fecUwXBnj2XHryVnU527OhivFoqrHBxerXxEbnzTeZkrvOz+CwbdRZVr4OX/r
         xJ/MXYAs910Em7BUoWY9t2p/fe3hz+vpa6HdGHrIs2U/AJahHY4+aPxBHysGK/q12EUM
         sU4JQhJzp030SvzG4xIP8CiMQKK3IQcm02XcExCtO/MH1zIO71aOjGW+2I0GkATNApvN
         WBzg==
X-Gm-Message-State: AOAM531ASuC9cwSZd6gUny+ALF9cNvD3nVoM67hu963oDQVBxIhadSi/
        +c/2iQNbvCag7l9XjoZwDmE=
X-Google-Smtp-Source: ABdhPJztaRsXhdjXwPZFRT4DUEEobxCtZ6s4UozByA17s+6u2LqIUdYO41ivWe4TrE5XQShnWJqJPQ==
X-Received: by 2002:a62:1d84:0:b029:304:5af1:65f6 with SMTP id d126-20020a621d840000b02903045af165f6mr18334338pfd.80.1625547197028;
        Mon, 05 Jul 2021 21:53:17 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.xiaomi.com ([209.9.72.215])
        by smtp.gmail.com with ESMTPSA id d23sm12613364pjd.25.2021.07.05.21.53.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Jul 2021 21:53:16 -0700 (PDT)
From:   Yehan Xu <yehanxu1@gmail.com>
To:     peterz@infradead.org, mingo@redhat.com, will@kernel.org
Cc:     longman@redhat.com, boqun.feng@gmail.com,
        linux-kernel@vger.kernel.org, xuyehan <xuyehan@xiaomi.com>
Subject: [PATCH] locking/rwsem: Remove an unused parameter of rwsem_wake()
Date:   Tue,  6 Jul 2021 12:50:43 +0800
Message-Id: <1625547043-28103-1-git-send-email-yehanxu1@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: xuyehan <xuyehan@xiaomi.com>

The 2nd parameter 'count' is not used in this function.
The places where the function is called are also modified.

Signed-off-by: xuyehan <xuyehan@xiaomi.com>
---
 kernel/locking/rwsem.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/locking/rwsem.c b/kernel/locking/rwsem.c
index 16bfbb1..8a595b6 100644
--- a/kernel/locking/rwsem.c
+++ b/kernel/locking/rwsem.c
@@ -1165,7 +1165,7 @@ rwsem_down_write_slowpath(struct rw_semaphore *sem, int state)
  * handle waking up a waiter on the semaphore
  * - up_read/up_write has decremented the active part of count if we come here
  */
-static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem, long count)
+static struct rw_semaphore *rwsem_wake(struct rw_semaphore *sem)
 {
 	unsigned long flags;
 	DEFINE_WAKE_Q(wake_q);
@@ -1297,7 +1297,7 @@ static inline void __up_read(struct rw_semaphore *sem)
 	if (unlikely((tmp & (RWSEM_LOCK_MASK|RWSEM_FLAG_WAITERS)) ==
 		      RWSEM_FLAG_WAITERS)) {
 		clear_nonspinnable(sem);
-		rwsem_wake(sem, tmp);
+		rwsem_wake(sem);
 	}
 }
 
@@ -1319,7 +1319,7 @@ static inline void __up_write(struct rw_semaphore *sem)
 	rwsem_clear_owner(sem);
 	tmp = atomic_long_fetch_add_release(-RWSEM_WRITER_LOCKED, &sem->count);
 	if (unlikely(tmp & RWSEM_FLAG_WAITERS))
-		rwsem_wake(sem, tmp);
+		rwsem_wake(sem);
 }
 
 /*
-- 
2.7.4

