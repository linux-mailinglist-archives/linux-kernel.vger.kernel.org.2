Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77050370270
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:52:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbhD3Uuy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:50:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231265AbhD3Uug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:50:36 -0400
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40FE4C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:49:47 -0700 (PDT)
Received: by mail-qv1-xf2d.google.com with SMTP id jm10so2911608qvb.5
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:49:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vfAsECn/fzRz8G1nJMm0ods0ajgpdWjB1GxnEL0hfI8=;
        b=tBbq4HtjyvEahKkAMBaoBEwoyZPbBrrg3UmsWUO+c+Qq7ICQjcbVNB9vFrv/s14QNj
         j27Vgs4LxA9g40TLXRLaCDxLS9rgrFESOlF4ziTq/B/qAV27XQ8QwUoHUlPUPJRTAgaL
         ZzZcbjbYLBpeGYRSPigkvZRSopYnf0ffRdtBo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfAsECn/fzRz8G1nJMm0ods0ajgpdWjB1GxnEL0hfI8=;
        b=ZgzHs52gYuC6wIoN0g0BfRsyrGtpJvqv4gZ8hdzlrR0ZomCrny8De8Butrw9qT92//
         9G4+Qwdl4SgYskP91GOb130eYUF/rTx7i7Ba1X3yjXV3eNEVmOmrHACfmgE96Vj/zTNf
         gZ8tKlBW/OOAdhmzv0ebtsia29N87BQne7bU05pO0Wk1VBcCRnZ1OucluGxsa00cJRvd
         NaSK6dIqkqzG/O2DAjB55wdEfbDCDZQIde4CbyIG0U+2dcsQ5F80oqhKw/OGc7899NId
         7unwoN2WRXVB5dRSJytj4WMH3FVnKCfoZ52T4eKs6njJc0meFUpxHeZu8DI+zE/dxlf8
         Vtwg==
X-Gm-Message-State: AOAM532Xwu+xRa9BXRhaUjqUI7YXB6ycZkMGjYiRwH3NHPJcvtstOErJ
        eP6dIy6H962CI6iW2ko+ew2zPg==
X-Google-Smtp-Source: ABdhPJw322k/IFXM9qiK9oswYTOjH5nXj+Lc8BRL3hVcRdzYjiMoVeqD7LN8zD6rHBzprEnx0KFjQA==
X-Received: by 2002:a0c:9e0f:: with SMTP id p15mr7500368qve.27.1619815786387;
        Fri, 30 Apr 2021 13:49:46 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id z17sm3161960qtf.10.2021.04.30.13.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:49:45 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH v2 1/5] seccomp: Refactor notification handler to prepare for new semantics
Date:   Fri, 30 Apr 2021 13:49:35 -0700
Message-Id: <20210430204939.5152-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210430204939.5152-1-sargun@sargun.me>
References: <20210430204939.5152-1-sargun@sargun.me>
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

Rodrigo Campos also identified a bug that can result in addfd causing
an early return, when the supervisor didn't actually handle the syscall [1].

[1]: https://lore.kernel.org/lkml/20210413160151.3301-1-rodrigo@kinvolk.io/

Fixes: 7cf97b125455 ("seccomp: Introduce addfd ioctl to seccomp user notifier")
Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 kernel/seccomp.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 1d60fc2c9987..93684cc63285 100644
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

