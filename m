Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9D233FEAC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:24:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhCRFSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhCRFRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:17:41 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64242C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:17:40 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id t4so913307qkp.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tjrc14KmBB1hkBJdqFGZfVa5j4ziojEzWH0yoigYsOQ=;
        b=BNDcO1YQkqtwOJ5vW/Mrq2utCF9JzSRrfjmYKYU69Hp/kEYiCaBycCDBwmV5BuoMQO
         rKRJCrd4qQnCF4qTntd9IrMJb+Vl9OuODGVDBmsZspBIHhOsyobRMpkoy+CBIpu/dTlg
         YBr1i0jPuGK01INjVtNtbWBSYC3gti7EPy6ng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tjrc14KmBB1hkBJdqFGZfVa5j4ziojEzWH0yoigYsOQ=;
        b=qFb/2Zc7hxpChlk9KkwtjTkdTIyYHr9XISqVUPy9p6K6fP/3xQqQy6PutICxtgl2UQ
         C09eDVA3VgAa0Jg8Beg+RdxjH4hUAQ8Jm8l+I7vcx50Rs0whDmp77cJ4yMka2wIJnfi2
         wueyTaZVbPsJExrrdflswiWc04M+AR7+IqKBE97O3lLzYi1aKvQl50x7qP82cnGbDyU/
         40C+Z5qvNVO3JyEKR5MzFo/JBqCtFq60a3Rl3ub36iaCdq15p0ZzPyCPUa1x2yMXYTxB
         vWPFLe57GHy8BrRL3LR56W0wLTJzqMxEVj04kOoRnb+7TGj9POFMkzVS6zTn471YirYH
         vlZg==
X-Gm-Message-State: AOAM533E8VAk1cDuXB5vzsog6EdpFIcU45H/y5Sz2iN5l41PP4QkxFHl
        sN0cjVetB5iuTREi6lm0S0tMQA==
X-Google-Smtp-Source: ABdhPJy1MFxgXQBRX0shqkm/qaDX7yKageM7zHeBypvJ6vyFd/8W9qhypZNWkvCYpxOy65V5W+P/VQ==
X-Received: by 2002:a37:a8cc:: with SMTP id r195mr2754430qke.86.1616044659537;
        Wed, 17 Mar 2021 22:17:39 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id m16sm937852qkm.100.2021.03.17.22.17.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 22:17:38 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH 1/5] seccomp: Refactor notification handler to prepare for new semantics
Date:   Wed, 17 Mar 2021 22:17:29 -0700
Message-Id: <20210318051733.2544-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210318051733.2544-1-sargun@sargun.me>
References: <20210318051733.2544-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This refactors the user notification code to have a do / while loop around
the completion condition. This has a small change in semantic, in that
previously we ignored addfd calls upon wakeup if the notification had been
responded to, but instead with the new change we check for an outstanding
addfd calls prior to returning to userspace.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 kernel/seccomp.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 952dc1c90229..b48fb0a29455 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1098,28 +1098,30 @@ static int seccomp_do_user_notification(int this_syscall,
 
 	up(&match->notif->request);
 	wake_up_poll(&match->wqh, EPOLLIN | EPOLLRDNORM);
-	mutex_unlock(&match->notify_lock);
 
 	/*
 	 * This is where we wait for a reply from userspace.
 	 */
-wait:
-	err = wait_for_completion_interruptible(&n.ready);
-	mutex_lock(&match->notify_lock);
-	if (err == 0) {
-		/* Check if we were woken up by a addfd message */
+	do {
+		mutex_unlock(&match->notify_lock);
+		err = wait_for_completion_interruptible(&n.ready);
+		mutex_lock(&match->notify_lock);
+		if (err != 0)
+			goto interrupted;
+
 		addfd = list_first_entry_or_null(&n.addfd,
 						 struct seccomp_kaddfd, list);
-		if (addfd && n.state != SECCOMP_NOTIFY_REPLIED) {
+		/* Check if we were woken up by a addfd message */
+		if (addfd)
 			seccomp_handle_addfd(addfd);
-			mutex_unlock(&match->notify_lock);
-			goto wait;
-		}
-		ret = n.val;
-		err = n.error;
-		flags = n.flags;
-	}
 
+	}  while (n.state != SECCOMP_NOTIFY_REPLIED);
+
+	ret = n.val;
+	err = n.error;
+	flags = n.flags;
+
+interrupted:
 	/* If there were any pending addfd calls, clear them out */
 	list_for_each_entry_safe(addfd, tmp, &n.addfd, list) {
 		/* The process went away before we got a chance to handle it */
-- 
2.25.1

