Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1BB136B8AB
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:07:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhDZSHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234229AbhDZSG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:06:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BE7AC061574
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:06:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id e2so25056815plh.8
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yvvWfDpwWO3ix59OkIRp3h1Jl4vMPwqFCck+Jadu5y4=;
        b=DTKiwqgmSXVkLSB4mUHqG7bKxdVDlE9X6RM0AXRf3lPDkYbiDQlvBtxhU1MzIZ2yOR
         NzPrK1Ou0/OLl8XYcEiQ1GEN6YjxGKNR3ecMRTToV56L2XRTimm16m6uJrJWVJuf60Hn
         Z+jjJFQArDSaySvk+rWBfuYKI4fj56E13sfsI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvvWfDpwWO3ix59OkIRp3h1Jl4vMPwqFCck+Jadu5y4=;
        b=ptgBpdfD/a7bgqArNuCUTjAa8kb6wB3uGPLVLfxZSGqywiZr1I9eEAHuQ5nEiO6mco
         7lt0lHqvxeVy1XCYDtsbAxNEA/iBlvU0Ms+ZeahUQrpb9U6wIstjqzLxlg5gnOW7n132
         UNo1GuLKhIkWm+UkxVWrfodtmPl/UgEZcoP4zOzyJQWseLublAA6WHzJKvWDZygofFQs
         6stE9oXrj7eZfaSka+WSvJeMDS54aeCcyhogY5wA4odz0UpMKO4kA87ofgjwDwJ8Xqcz
         zza1/4dqDzAu0sIlfEYhoSFxvtbqB2PTGg8fMYAY5qAzeUavdGVm7MphPd3kzPTJ0qLa
         P3IQ==
X-Gm-Message-State: AOAM531wT3g1BpWPIz+ZRqQb2F6SHwXjVTCPn0Id3612sG1VVCDdWYkK
        6zSIHoL9tAexm9P6zFhiyHY7Sw==
X-Google-Smtp-Source: ABdhPJzkd9NmqETqvyFyb8gmDUYMADNOsweB44ohK3fCHQERLhb4U1n/2bncb2/2smPep5BwqyvE/g==
X-Received: by 2002:a17:90a:7893:: with SMTP id x19mr23411762pjk.3.1619460375770;
        Mon, 26 Apr 2021 11:06:15 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id j7sm326835pfd.129.2021.04.26.11.06.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 11:06:15 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Will Drewry <wad@chromium.org>, Alban Crequy <alban@kinvolk.io>
Subject: [PATCH RESEND 1/5] seccomp: Refactor notification handler to prepare for new semantics
Date:   Mon, 26 Apr 2021 11:06:06 -0700
Message-Id: <20210426180610.2363-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210426180610.2363-1-sargun@sargun.me>
References: <20210426180610.2363-1-sargun@sargun.me>
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

