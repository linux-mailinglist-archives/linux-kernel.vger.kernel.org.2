Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47ED33FEA8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhCRFSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhCRFRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:17:49 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF9BC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:17:49 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id t16so2607080qvr.12
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dsml87g6Pp88SlV7XsY7Ib54S5fj8LPXDlFvLHiKovM=;
        b=W/IMIlp9TCG5NrfqrYzA2PSxv8J4MDKxQqq+AEcn7wsfP0z4p2mh+Q+PxN3nrL9Yr0
         f2QdLDv/8aeFzvfrJ9RiX/T0Nz8w0aMc6mVJvALeTe+HprSSkg0Wl09IlnWC8WzQebEB
         wYH0Vkzl/izcyr2IOqD379T1Qx0fUjFQRPvcE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dsml87g6Pp88SlV7XsY7Ib54S5fj8LPXDlFvLHiKovM=;
        b=ud96FLr43LpnW4sIlAKXx8Nv7EzUk/loo1ix9fk0zLCyq2F59i9qSJzJD2itYKLr7M
         rDzMsIlu829TuZ05n0tzVNqinSaA/5wL22CzOoa7hDKmGR2LygL6j4yMIevYuDXy7k3V
         N3L8Ou7SfgEPVcFB3ydJlDeKLI8SiH6nigwWtcwCrKGj3odx5z7j93xXDgqBnKBIiwf/
         xPjeO5jiI1hOgCsfDpTir1oweRKs8yf3xY7uDjHUl4ynkZy8qHmktCp5rIGEWBOt23xz
         duaWUowadmQuQuVAtWtLCcjnqn/8SOWcWJCFNIHj66yKChOcUJeIIh4Y8vdOyFApWn+q
         82MA==
X-Gm-Message-State: AOAM533Ip9sEvXXlvzivl/NmwZoASXXsoLSpEzsGE+FE4g3eZ/b2yiZp
        G2Iht+Fq+t95V2iaabgKiHPCIQ+fXoY8yfYh
X-Google-Smtp-Source: ABdhPJxx7CH3Rql4qCdW2ilOtkhczhBECGES9VcuROQ3CNe73ehaia76pZYLc7vmeBhEa66jThu0hA==
X-Received: by 2002:a05:6214:248a:: with SMTP id gi10mr2524836qvb.35.1616044668403;
        Wed, 17 Mar 2021 22:17:48 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id m16sm937852qkm.100.2021.03.17.22.17.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 22:17:47 -0700 (PDT)
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
Subject: [PATCH 5/5] selftests/seccomp: Add test for atomic addfd+send
Date:   Wed, 17 Mar 2021 22:17:33 -0700
Message-Id: <20210318051733.2544-6-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210318051733.2544-1-sargun@sargun.me>
References: <20210318051733.2544-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This just adds a test to verify that when using the new introduced flag
to ADDFD, a valid fd is added and returned as the syscall result.

Signed-off-by: Rodrigo Campos <rodrigo@kinvolk.io>
Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 48ad53030d5a..f7242294a2d5 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -239,6 +239,10 @@ struct seccomp_notif_addfd {
 #define SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE	(1UL << 0) /* Prevent task from being interrupted */
 #endif
 
+#ifndef SECCOMP_ADDFD_FLAG_SEND
+#define SECCOMP_ADDFD_FLAG_SEND	(1UL << 1) /* Addfd and return it, atomically */
+#endif
+
 struct seccomp_notif_addfd_small {
 	__u64 id;
 	char weird[4];
@@ -3980,8 +3984,14 @@ TEST(user_notification_addfd)
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
 
@@ -4064,6 +4074,30 @@ TEST(user_notification_addfd)
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
@@ -4124,6 +4158,10 @@ TEST(user_notification_addfd_rlimit)
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

