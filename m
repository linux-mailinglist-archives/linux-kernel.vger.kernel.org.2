Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E86320498
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 10:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbhBTJHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 04:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhBTJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 04:05:52 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC1EC061786
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 01:05:07 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id c19so5136456pjq.3
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 01:05:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tjrc14KmBB1hkBJdqFGZfVa5j4ziojEzWH0yoigYsOQ=;
        b=VrmIW4+UneAFMDsqqeTSeilJ1bQ+cHdOwjwUqt/cKvsegQ8I0zT+sJyX7gTuRxJu+w
         eVe0IEEI8CST+5I3eVOuQYNIxWkwBRN9S/G67l3kbrbRf5DZVqhKG92F1er9hT+YOW7f
         KBEjh5Fo8NGNzaCImKL02HfC/OjpH3f7I/rdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tjrc14KmBB1hkBJdqFGZfVa5j4ziojEzWH0yoigYsOQ=;
        b=bG7chV2tBonIm3QhoJgW/gnr3Ib+69YIRLf7kgIL2/iAXTG0x1kEkvhTjQxcdgdAqo
         cSNy8d16amYI3E8oixAyv8T6yiXRW4RZk9Aq+rpB/AnNVvP+j8n7ajRLQWyBlfXI1CGO
         DrI7f4eIQFILYngh6jSPc0tqYf2dnJj2GfN35AAPwQ1fy4eeHZhVsjtaV/NNYrHrXJtN
         KUAinKXkgqoB3rzgUeE89dHwMJ3jDUfqpV4HAFFRH82LYcAhN8pchZ4ri4jvlWCzq11K
         v159UdIJi8cggCWYpRQjh+cbHsKrq1iLoTosRQUP/gfa1z8ZueqQAmwsxH2Ab5jz4SML
         Oadw==
X-Gm-Message-State: AOAM531XzAMnBr/XKGnW++kOneTwbUI5GCJhhifVtszMsaaNPD23HpuG
        1i3n1RUZkJ5u5oZPcj3FpbNJOg==
X-Google-Smtp-Source: ABdhPJz094JJ3xmfNfxZv/GeQsB+caBUOMeT6Va+aC9jLEd0bc46PTH++lh23Bl+esNQq6LVFOJcCQ==
X-Received: by 2002:a17:90a:1a0b:: with SMTP id 11mr12819117pjk.58.1613811907058;
        Sat, 20 Feb 2021 01:05:07 -0800 (PST)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id g62sm12226727pgc.32.2021.02.20.01.05.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 01:05:06 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: [RFC PATCH 1/3] seccomp: Refactor notification handler to prepare for new semantics
Date:   Sat, 20 Feb 2021 01:05:00 -0800
Message-Id: <20210220090502.7202-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210220090502.7202-1-sargun@sargun.me>
References: <20210220090502.7202-1-sargun@sargun.me>
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

