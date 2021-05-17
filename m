Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 238A9383DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 21:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234830AbhEQTky (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 15:40:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234750AbhEQTkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 15:40:42 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 937B5C061573
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:39:25 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id q6so4252238pjj.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 May 2021 12:39:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Nyceh4v/u73eL9ZfugXsj2VXRRlfSGYCZ8L9xP6N9v8=;
        b=qmMI1tdiguzLzSViMkp+Ff6aUGNvPHpXTUNpL8r6ruaeAlLXugEAnt3aVTQPyfQIYY
         swdZUTegn399+mE3neiJHtsEabuJdPbasFhTMx1yEnMU7QpTMGoo2T8JEPH/D7cmNs4o
         wP7CVFSax+DPYBQu/OBfZo2m9HzSc/atqD7+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Nyceh4v/u73eL9ZfugXsj2VXRRlfSGYCZ8L9xP6N9v8=;
        b=PlZswAojzxq6wuPX1cOwp3ojb+U5rXqYKtpbKPY9nqkbmMVks0ChCFriz756spxen0
         2A6ZJVQt9a351uOou+oLS6Iz7iQ2iYogCXLhM17xPQ3wF0Vbn6Nv14FEtn4hqx9w5lRz
         TkEeQeG6uH9NYDNolFMrb/UosJdWfsTVNj/4ly5BcbaAPCYSgmU9Bn1SUv/g3rM/uV3p
         r49l8P1nEBCwY2ZobzovnxoXTGTbNApdwusNmUTirIk4AvKK0eu8uDsro45Wpp3KC4AI
         w80jP8ESW7vJ5Qe0axpAJ501bBaHC8yzhmn3z68M6BcswC013yUQVktf7di3l18JNnB7
         XzEg==
X-Gm-Message-State: AOAM532oRomlWssLkz/EnAd8jBIXqKONsCNpPrkca8+Bug2w3GoRKu5N
        SN4TwBXN+NC+6EcSbR6Q2x4GNQ==
X-Google-Smtp-Source: ABdhPJwC6YgRWYJ9pA5MPWw85Dz8urOqHGvqhQ63FEIFIcQYomPQ9KHNtLpwT5ijHJJ0tZpIhVOGYQ==
X-Received: by 2002:a17:90a:d496:: with SMTP id s22mr1093306pju.146.1621280364865;
        Mon, 17 May 2021 12:39:24 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id r11sm11132110pgl.34.2021.05.17.12.39.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 May 2021 12:39:24 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>, containers@lists.linux.dev,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH v2 2/4] seccomp: Refactor notification handler to prepare for new semantics
Date:   Mon, 17 May 2021 12:39:06 -0700
Message-Id: <20210517193908.3113-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210517193908.3113-1-sargun@sargun.me>
References: <20210517193908.3113-1-sargun@sargun.me>
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
an early return, when the supervisor didn't actually handle the
syscall [1].

[1]: https://lore.kernel.org/lkml/20210413160151.3301-1-rodrigo@kinvolk.io/

Fixes: 7cf97b125455 ("seccomp: Introduce addfd ioctl to seccomp user notifier")
Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Acked-by: Tycho Andersen <tycho@tycho.pizza>
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

