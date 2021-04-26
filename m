Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0410736B8B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Apr 2021 20:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234287AbhDZSHO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Apr 2021 14:07:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbhDZSHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Apr 2021 14:07:06 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA5EC06175F
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:06:21 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id f6-20020a17090a6546b029015088cf4a1eso5764344pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Apr 2021 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X6rX98hDfmwMvXNLYGLENiBjXrMNx3f1cVY9RbI6yg0=;
        b=O7G+JeIXayDNkXmfUzuLpkBvyA0+i+YAiu+ONggStuJ90PCRVFHBB7ssGmkC7PLhqF
         cx7xn5iiunf4FK4prQDhpUchjkMSnI3UvnO/fpLzIbU02VKtj55Vv7nCshDlIM68noVU
         hd6Jh2LXxpFcZ/3dI0AxOV8kdGVf8fAR08+zI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X6rX98hDfmwMvXNLYGLENiBjXrMNx3f1cVY9RbI6yg0=;
        b=CXf6QsnBAXzSccPJU55kET7PBJPiPKL6YK6Mk+82Ei+rUKRGZEBhkkeFHXtJcGiYgK
         j9+vFtFl+Wg9AEFWIvdE5EhxOtCCeNGd0prH6hfOZA2mlDVAxwjhzQaZPaI+TT9j1hD8
         +5G1V5bYcvfQR4OGAJXXDBkKC75+hFyGDpRQ5U9REWNgqhivfsFEb3BNguJ1U/RZ9cpD
         NKshgMi4neKuFdRRRgIsfzAkjPl7QPnIN7IP8GNEn3nvDkIauY4sOgv8WVzJ+gftfN5R
         bWMCA8XyaG+vM7BTLdoaeacSnSlT9XSFGXize0RVT9bI/p/bdZjZ+A9AEO96fMTCzrgd
         kELw==
X-Gm-Message-State: AOAM5338AP8SqEji7RiZQnI32mVj1YC1q/p3Lxyha/KVvdmVZV49nm5d
        BNZjvCy8z1WRD2s+wPb/LDv+yA==
X-Google-Smtp-Source: ABdhPJxac+qneaPoiDM++eOdU6qvTBl1VlpL4cLhCGu1W4aN2kj+jIllJrl+2QYEkF3ULEPQPY0arg==
X-Received: by 2002:a17:90b:30c3:: with SMTP id hi3mr9150037pjb.235.1619460381235;
        Mon, 26 Apr 2021 11:06:21 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id j7sm326835pfd.129.2021.04.26.11.06.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 11:06:20 -0700 (PDT)
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
Subject: [PATCH RESEND 3/5] selftests/seccomp: Add test for wait killable notifier
Date:   Mon, 26 Apr 2021 11:06:08 -0700
Message-Id: <20210426180610.2363-4-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210426180610.2363-1-sargun@sargun.me>
References: <20210426180610.2363-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a test for the positive case of the wait killable notifier,
in testing that when the feature is activated the process acts as
expected -- in not terminating on a non-fatal signal, and instead
queueing it up. There is already a test case for normal handlers
and preemption.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
---
 tools/testing/selftests/seccomp/seccomp_bpf.c | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 98c3b647f54d..34140ce2ab21 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -235,6 +235,10 @@ struct seccomp_notif_addfd {
 };
 #endif
 
+#ifndef SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE
+#define SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE	(1UL << 0) /* Prevent task from being interrupted */
+#endif
+
 struct seccomp_notif_addfd_small {
 	__u64 id;
 	char weird[4];
@@ -4135,6 +4139,66 @@ TEST(user_notification_addfd_rlimit)
 	close(memfd);
 }
 
+TEST(user_notification_signal_wait_killable)
+{
+	pid_t pid;
+	long ret;
+	int status, listener, sk_pair[2];
+	struct seccomp_notif req = {
+		.flags = SECCOMP_USER_NOTIF_FLAG_WAIT_KILLABLE,
+	};
+	struct seccomp_notif_resp resp = {};
+	char c;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	ASSERT_EQ(socketpair(PF_LOCAL, SOCK_SEQPACKET, 0, sk_pair), 0);
+	ASSERT_EQ(fcntl(sk_pair[0], F_SETFL, O_NONBLOCK), 0);
+
+	listener = user_notif_syscall(__NR_gettid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		close(sk_pair[0]);
+		handled = sk_pair[1];
+		if (signal(SIGUSR1, signal_handler) == SIG_ERR) {
+			perror("signal");
+			exit(1);
+		}
+
+		ret = syscall(__NR_gettid);
+		exit(!(ret == 42));
+	}
+	close(sk_pair[1]);
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	EXPECT_EQ(kill(pid, SIGUSR1), 0);
+	/* Make sure we didn't get a signal */
+	EXPECT_EQ(read(sk_pair[0], &c, 1), -1);
+	/* Make sure the notification is still alive */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ID_VALID, &req.id), 0);
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = 42;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(0, WEXITSTATUS(status));
+	/* Check we eventually received the signal */
+	EXPECT_EQ(read(sk_pair[0], &c, 1), 1);
+}
+
+
 /*
  * TODO:
  * - expand NNP testing
-- 
2.25.1

