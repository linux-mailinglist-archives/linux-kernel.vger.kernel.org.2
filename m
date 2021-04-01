Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2630F350C7D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 04:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbhDACRI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 22:17:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233102AbhDACQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 22:16:52 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 842FFC061763
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 19:16:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id w9so4348810ybw.7
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 19:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=EdylIR7+stbNhjEXK8dV5HwE4QZqh9PwApyPp+QxuSY=;
        b=TLLcEGrtg1EzKDU1ONElskZnf8TljiwRA5z4zQSFjgDWD+6Yb7z2QEq0DZwSsjI1tl
         v0v0IGW9LMqnS7xFdEzvkvsRQ/HCBEuTeL0buKzWaXnmGwS2pe4IQApxeJ4dGqic9M4y
         BaQ+H9Hqe5jXNK+PlOR6brAZ3k09R/FdPGxX464Q6NnOMjeMlk7IA6hxs8Rs6+jUUhIR
         rlar8GQls8+YYGDr5zY5zPlijN2NreIhOnL7x5IV2QmQUexXYOPaTRCbtnWZ4a3vr/n/
         YBnmQrfv7q8sNGuW95tM4Wd2bxC8zNRB5M055MBfkWyiW436O67Es3q3CmHYekTfsOah
         9VvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=EdylIR7+stbNhjEXK8dV5HwE4QZqh9PwApyPp+QxuSY=;
        b=BRRZlaITj0qCUDW+4D92idfLamAls6C5pGDyireLi8CyE5fGZ+F8vLziGPIJvz57W/
         1TWXeuv3R1stk40n+pzZ50drLBxQ3zk7pnpoNhWKY6DGAmDMCUzMNQRAnBs31k4+BB4p
         urlxvByx2Zy6xcwE/QE1fVJolMQaf88lWdAanIC3pEx5YreT5Yoov4rYJooKbbVEM3cd
         mlqOMaU0LMKJnab3xQeib+XygroYIoyoLBzZzFR8y47KbZI1vl4z2LOPR62CJ0/+ZvVr
         VO4fWitA6PMZZ7hHRqWtoRRFgSIKUS2zqGLvzX1EsMXzO18Qh7JhejCFsLgKIvbLkJoU
         o5mQ==
X-Gm-Message-State: AOAM533QrZ40lJJ1AYXByUkE4Pm+eHusukuYIxEjVsEtHbsjzfvBt8U8
        IGJB1WwX3ztgBXyFsCAU3tEsspFlV2g=
X-Google-Smtp-Source: ABdhPJzFjJJJjbV7B6qbOLgEtEulybMwZdpPzXYIWNR+4Fi8ubkuKI0/HJ5rWnx+1ZxiSBdQ8C+cQ2mN6vk=
X-Received: from legoland2.mtv.corp.google.com ([2620:15c:211:1:658a:a0c1:1f30:4141])
 (user=varmam job=sendgmr) by 2002:a25:424c:: with SMTP id p73mr8794991yba.192.1617243411741;
 Wed, 31 Mar 2021 19:16:51 -0700 (PDT)
Date:   Wed, 31 Mar 2021 19:16:45 -0700
Message-Id: <20210401021645.2609047-1-varmam@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v2] fs: Improve eventpoll logging to stop indicting timerfd
From:   Manish Varma <varmam@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Manish Varma <varmam@google.com>,
        Kelly Rossmoyer <krossmo@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

timerfd doesn't create any wakelocks, but eventpoll can.  When it does,
it names them after the underlying file descriptor, and since all
timerfd file descriptors are named "[timerfd]" (which saves memory on
systems like desktops with potentially many timerfd instances), all
wakesources created as a result of using the eventpoll-on-timerfd idiom
are called... "[timerfd]".

However, it becomes impossible to tell which "[timerfd]" wakesource is
affliated with which process and hence troubleshooting is difficult.

This change addresses this problem by changing the way eventpoll
wakesources are named:

1) the top-level per-process eventpoll wakesource is now named "epoll:P"
(instead of just "eventpoll"), where P, is the PID of the creating
process.
2) individual per-underlying-filedescriptor eventpoll wakesources are
now named "epollitemN:P.F", where N is a unique ID token and P is PID
of the creating process and F is the name of the underlying file
descriptor.

All together that should be splitted up into a change to eventpoll and
timerfd (or other file descriptors).

Co-developed-by: Kelly Rossmoyer <krossmo@google.com>
Signed-off-by: Kelly Rossmoyer <krossmo@google.com>
Signed-off-by: Manish Varma <varmam@google.com>
---
 fs/eventpoll.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fs/eventpoll.c b/fs/eventpoll.c
index 7df8c0fa462b..8d3369a02633 100644
--- a/fs/eventpoll.c
+++ b/fs/eventpoll.c
@@ -297,6 +297,7 @@ static LIST_HEAD(tfile_check_list);
 
 static long long_zero;
 static long long_max = LONG_MAX;
+static atomic_t wakesource_create_id  = ATOMIC_INIT(0);
 
 struct ctl_table epoll_table[] = {
 	{
@@ -1451,15 +1452,23 @@ static int ep_create_wakeup_source(struct epitem *epi)
 {
 	struct name_snapshot n;
 	struct wakeup_source *ws;
+	pid_t task_pid;
+	char buf[64];
+	int id;
+
+	task_pid = task_pid_nr(current);
 
 	if (!epi->ep->ws) {
-		epi->ep->ws = wakeup_source_register(NULL, "eventpoll");
+		snprintf(buf, sizeof(buf), "epoll:%d", task_pid);
+		epi->ep->ws = wakeup_source_register(NULL, buf);
 		if (!epi->ep->ws)
 			return -ENOMEM;
 	}
 
+	id = atomic_inc_return(&wakesource_create_id);
 	take_dentry_name_snapshot(&n, epi->ffd.file->f_path.dentry);
-	ws = wakeup_source_register(NULL, n.name.name);
+	snprintf(buf, sizeof(buf), "epollitem%d:%d.%s", id, task_pid, n.name.name);
+	ws = wakeup_source_register(NULL, buf);
 	release_dentry_name_snapshot(&n);
 
 	if (!ws)
-- 
2.31.0.291.g576ba9dcdaf-goog

