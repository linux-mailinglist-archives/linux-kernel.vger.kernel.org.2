Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D116370966
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 02:20:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbhEBAUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 May 2021 20:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhEBAT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 May 2021 20:19:58 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDFEC06174A
        for <linux-kernel@vger.kernel.org>; Sat,  1 May 2021 17:19:08 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id r13so939172qvm.7
        for <linux-kernel@vger.kernel.org>; Sat, 01 May 2021 17:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vfAsECn/fzRz8G1nJMm0ods0ajgpdWjB1GxnEL0hfI8=;
        b=fpbZq7C8+zvIV2lES2K6x9lsB7pyHmvs4Yxy9DkSMbsmefAzZD0E/RgPvUXyJdb6Q+
         TKiP2DEq/Pxqu7/7b055o0hEv0TFebGCinfp9yJUuVm05BmUcNSiL/BkcfH9VT/J9oaq
         JotWx2+KQ5biyK6x3pTn80D1Wzv4ta3gS2qzs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vfAsECn/fzRz8G1nJMm0ods0ajgpdWjB1GxnEL0hfI8=;
        b=ClAFq2KHAZHEQEIkJ+mMasrse9bymcQaTd5zA1lkLA26iTtlF36wH1ibQUD4+xIeqh
         3CJqfiasfCQswliTmWxuRrdO1ijeBdJYNSpJm42tiOddTIvev57OmzOTcboHlSfwIX3z
         ZeAS7cEswPENsU130Q2SCBwJMPuftMfVrEtqMxwinDfN4g9fqWjheIpxgWLfUuhx4NlT
         xZJVe+1AzuZVBREXD/5GvGjvFN2XtE5xII81Ey9XCP3gXAQDzbWrTtSeIPRuBZw76k7a
         Id2R1w5DfiBDV7tP2zhowMVh+TLMFSE5AInkTfj1HYCxF9y8W9+x2cWQeNKjQM4vBinX
         v6UQ==
X-Gm-Message-State: AOAM531qRpjQRnDFOn27/GehMx0VXOP+QOnjAV5OzwM2SNqFbxka+lqZ
        T37frFhpAM79B3YTKNePjEpTPw==
X-Google-Smtp-Source: ABdhPJwNAfn4+E6CCzyl/D25KYz95m1jhCAOsy1DssEolXqjzMVufdUNRmGSHjVvoBu+pvuBtTZmrA==
X-Received: by 2002:a05:6214:2503:: with SMTP id gf3mr12604871qvb.61.1619914747252;
        Sat, 01 May 2021 17:19:07 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id p5sm5146067qkh.135.2021.05.01.17.19.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 May 2021 17:19:06 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux.dev>,
        Tycho Andersen <tycho@tycho.pizza>,
        Andy Lutomirski <luto@kernel.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@linux.microsoft.com>
Subject: [PATCH 2/4] seccomp: Refactor notification handler to prepare for new semantics
Date:   Sat,  1 May 2021 17:18:49 -0700
Message-Id: <20210502001851.3346-3-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210502001851.3346-1-sargun@sargun.me>
References: <20210502001851.3346-1-sargun@sargun.me>
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

