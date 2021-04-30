Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7DF37026E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236040AbhD3Uuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235950AbhD3Uuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:50:44 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8EF7C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:49:55 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id y12so52605058qtx.11
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:49:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yd8KWtQAvkY0SPkWFn+RWMjh2rwrInFMPxMpFUWurrE=;
        b=F1Fmjqa0/NusbR+Xv3n5bLeQ5mNO0RhmFeHGo5tnNqj9ZfhueTpPQk1E5tf6xiSuKW
         UCloCAh/kBxToeq90qh5s8KXh3Y7gI7qTEc9pJaM+sDzOHmUm6PJWSo5OazZhioJ6JC7
         0rvMRYj3XCCyfOUBh7h0u3NFWuUXr4IQg5Ccw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yd8KWtQAvkY0SPkWFn+RWMjh2rwrInFMPxMpFUWurrE=;
        b=C7+4H7YedDfVygU78rKNcnCm74Crd4fBVF2AkRyURbpt+qyov2prrlEdMkaZ2zQ3gV
         UJ7L6abCVvyFOBy8Fq0ENaKB8HzN9csvLn2Yp6prk8RroSWoUFoAry31V6Vd5nmNn4/X
         9Ycp3q1RcmTU3YPur0DB5P834A+DGbG5zP1f6hObKUWJDMexvQQIZQCgubV+d2IF8FuC
         D9cb5Bij21izzyMESxHPUbRGFJHMO7eF2KY4Oj8J4/EVpB+wMSh7nMJQlL1sroF7JWUh
         oT1eX7T32SSx3QL/AqXT6Ybbz1VZpZlf6+XQiRW/5MHRhBUKR56O5XMq/bhd8jWg6jlf
         tqpQ==
X-Gm-Message-State: AOAM531VM3e79pevaJu5yRFL5G4WXON8RSOUrgVdRYME3VUpKcPNdciv
        oZX3T1kQqTHXi1xxjbbNWYTNNQ==
X-Google-Smtp-Source: ABdhPJwPNEazDuUTgXNovxew7UYAfs57u0+1fz00ZZuZ+0WqbmiT/GQSwTseAr7VyiPS51h/CrxTvw==
X-Received: by 2002:ac8:46d4:: with SMTP id h20mr5991932qto.355.1619815794735;
        Fri, 30 Apr 2021 13:49:54 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id z17sm3161960qtf.10.2021.04.30.13.49.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:49:53 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Rodrigo Campos <rodrigo@kinvolk.io>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Andy Lutomirski <luto@kernel.org>,
        Sargun Dhillon <sargun@sargun.me>
Subject: [PATCH v2 5/5] selftests/seccomp: Add test for atomic addfd+send
Date:   Fri, 30 Apr 2021 13:49:39 -0700
Message-Id: <20210430204939.5152-6-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210430204939.5152-1-sargun@sargun.me>
References: <20210430204939.5152-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Rodrigo Campos <rodrigo@kinvolk.io>

This just adds a test to verify that when using the new introduced flag
to ADDFD, a valid fd is added and returned as the syscall result.

Signed-off-by: Rodrigo Campos <rodrigo@kinvolk.io>
Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 9a72ba8bb4f7..be911809212f 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -240,6 +240,10 @@ struct seccomp_notif_addfd {
 #define SECCOMP_IOCTL_NOTIF_SET_WAIT_KILLABLE	SECCOMP_IOW(4, __u64)
 #endif
 
+#ifndef SECCOMP_ADDFD_FLAG_SEND
+#define SECCOMP_ADDFD_FLAG_SEND	(1UL << 1) /* Addfd and return it, atomically */
+#endif
+
 struct seccomp_notif_addfd_small {
 	__u64 id;
 	char weird[4];
@@ -3981,8 +3985,14 @@ TEST(user_notification_addfd)
 	ASSERT_GE(pid, 0);
 
 	if (pid == 0) {
+		/* fds will be added and this value is expected */
 		if (syscall(__NR_getppid) != USER_NOTIF_MAGIC)
 			exit(1);
+
+		/* Atomic addfd+send is received here. Check it is a valid fd */
+		if (fcntl(syscall(__NR_getppid), F_GETFD) == -1)
+			exit(1);
+
 		exit(syscall(__NR_getppid) != USER_NOTIF_MAGIC);
 	}
 
@@ -4061,6 +4071,30 @@ TEST(user_notification_addfd)
 	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
 	ASSERT_EQ(addfd.id, req.id);
 
+	/* Verify we can do an atomic addfd and send */
+	addfd.newfd = 0;
+	addfd.flags = SECCOMP_ADDFD_FLAG_SEND;
+	fd = ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd);
+
+	/* Child has fds 0-6 and 42 used, we expect the lower fd available: 7 */
+	EXPECT_EQ(fd, 7);
+	EXPECT_EQ(filecmp(getpid(), pid, memfd, fd), 0);
+
+	/*
+	 * This sets the ID of the ADD FD to the last request plus 1. The
+	 * notification ID increments 1 per notification.
+	 */
+	addfd.id = req.id + 1;
+
+	/* This spins until the underlying notification is generated */
+	while (ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd) != -1 &&
+	       errno != -EINPROGRESS)
+		nanosleep(&delay, NULL);
+
+	memset(&req, 0, sizeof(req));
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	ASSERT_EQ(addfd.id, req.id);
+
 	resp.id = req.id;
 	resp.error = 0;
 	resp.val = USER_NOTIF_MAGIC;
@@ -4121,6 +4155,10 @@ TEST(user_notification_addfd_rlimit)
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
 	EXPECT_EQ(errno, EMFILE);
 
+	addfd.flags = SECCOMP_ADDFD_FLAG_SEND;
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
+	EXPECT_EQ(errno, EMFILE);
+
 	addfd.newfd = 100;
 	addfd.flags = SECCOMP_ADDFD_FLAG_SETFD;
 	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ADDFD, &addfd), -1);
-- 
2.25.1

