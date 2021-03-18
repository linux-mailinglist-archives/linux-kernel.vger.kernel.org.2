Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2A6333FEAA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbhCRFSK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbhCRFRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:17:45 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5615EC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:17:45 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id r14so3214271qtt.7
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X0lenJHcLasaYBI5lFBTMBv4qon9BxbpynoG3q+hE3g=;
        b=oxJaPnYDKT+7znFR/6BDGPow/x9iKeGlhNvZeYxFyxCFPQZHXYPcDogLe+Rf9ciV9P
         Sald5NV+uvkJtJYGSuvVrB/YszxNzfV2gd3/lXKRkyQXfHjmxWkRHuJsFIFKX62wQJ3b
         2+lz0/J0T71MZzRSzeM3rr9GLPbwbO6aokGSI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X0lenJHcLasaYBI5lFBTMBv4qon9BxbpynoG3q+hE3g=;
        b=A9N6bGIjHpL8p4Iho2Bt1obaZz/cCh8o2hDWWvSdgZVKait9wERO6N6WdFohk57LUx
         HWOm2qamjoKxiGfYkN2SQxpQIdbeZ8iOqs9eAoY+4S06TbrLNg9zuke7lEBBpKna7jh8
         cchnvTbZTwmnr9u0gytGn6ZuqLR9rBSv6ocwFY1GQd38yW1hFP+kAPJ+Q/TSjC0ANzNr
         0IdKbnaJ0gjrtMUoURS3d+cUoZsXKElvLuk543WLs6noFvxMdrUxw+QAESHSYDvjLzvJ
         4c5ZrT7WYItc51GD1unMjQOHjddumoWHiZSqoLRKaLmRf5JPm0EQvyuLLSh9+ZpG6rY/
         dxOg==
X-Gm-Message-State: AOAM530dRvwv4aFYXk7SWkQ10he0v4jEHNuBZD7ldKd+sC+lFFBOwK8B
        EGIQIGwFZRmOCiy8oqb65J8chA==
X-Google-Smtp-Source: ABdhPJwGYjEfrpQtVdRRxk7+sO+hOVsV94Gqlg+m+AVLeI8glz8fqp4QxrdN/ybmrfLUXJCg2NGhsA==
X-Received: by 2002:aed:29e5:: with SMTP id o92mr2186045qtd.29.1616044664409;
        Wed, 17 Mar 2021 22:17:44 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id m16sm937852qkm.100.2021.03.17.22.17.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Mar 2021 22:17:43 -0700 (PDT)
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
Subject: [PATCH 3/5] selftests/seccomp: Add test for wait killable notifier
Date:   Wed, 17 Mar 2021 22:17:31 -0700
Message-Id: <20210318051733.2544-4-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210318051733.2544-1-sargun@sargun.me>
References: <20210318051733.2544-1-sargun@sargun.me>
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
index 26c72f2b61b1..48ad53030d5a 100644
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
@@ -4139,6 +4143,66 @@ TEST(user_notification_addfd_rlimit)
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

