Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B304032049B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Feb 2021 10:11:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbhBTJHR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Feb 2021 04:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBTJFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Feb 2021 04:05:52 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB5CC06178B
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 01:05:09 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o38so6898193pgm.9
        for <linux-kernel@vger.kernel.org>; Sat, 20 Feb 2021 01:05:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8uhnHjYHLCuhTU6M3tfoU1v40Q35VuY6aG3sX6eVDyc=;
        b=oINI3a66W+i5evnFiC1om4CrVR+l4Dpl+FfnJV+aaKdHq3y6KNMlz9d8BHcvismR1o
         TMdbrTK+OIStNUQmh34wgpmb5ZEytU6iiCHDxeYr4f7s5BNeVaTOhgnlSUpnQ8LhceEg
         1NPwYqN7MIAsH1qXtKrPrHXew0IfX4dO9qxL8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8uhnHjYHLCuhTU6M3tfoU1v40Q35VuY6aG3sX6eVDyc=;
        b=uQlkIjInOblHcv1cQej70Dox3WGCoCPhfY/0C4tXYuakVE9Fo9XTpq5BFM8vXlE7mK
         mN2C4vayloQhmTx2KeM48HXP35ZzeYYh5wlU5vPVPiREDGcsAw5unRgjnngcxx5jbddI
         HYUX1n2LlnBtex+elr6WO4j3Lo+GbX1ihZHEDXQ07vZVyPcVZUP41GE9WzFGSdh8ofgz
         0mBEQT5/67ALh+6yVXGl8M6DvCl8QAhhfTm7jFPoAO9wyBfANRR4ATRzQ3GnnMjhn/6Y
         AMzHvZqp41x5/AJ1EXGH1gaq3o7FUk0qiN0Dk/cQmG9wijq4/YK4vZNgJpJfZYkBCvfK
         DoOQ==
X-Gm-Message-State: AOAM531aMqJMV19hx1l2oNzgaxhcOnUbwt6Sn85PFvT/IPi3WTsZ7Sj5
        vQfcbkVMk1jLV7UePhZRtVIc9w7ZxTRoEsps
X-Google-Smtp-Source: ABdhPJy7IJ3VExxrUSvVAdN94MbvRPMYPuPR64fdVczeGXWZEVGDUkRzOl/nwi6OdECSi4zyGTVDUw==
X-Received: by 2002:a62:342:0:b029:1ed:b5f:d075 with SMTP id 63-20020a6203420000b02901ed0b5fd075mr5751870pfd.62.1613811909311;
        Sat, 20 Feb 2021 01:05:09 -0800 (PST)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id g62sm12226727pgc.32.2021.02.20.01.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Feb 2021 01:05:09 -0800 (PST)
From:   Sargun Dhillon <sargun@sargun.me>
To:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Containers <containers@lists.linux-foundation.org>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        =?UTF-8?q?Mauricio=20V=C3=A1squez=20Bernal?= <mauricio@kinvolk.io>,
        Rodrigo Campos <rodrigo@kinvolk.io>,
        Tycho Andersen <tycho@tycho.pizza>,
        Giuseppe Scrivano <gscrivan@redhat.com>
Subject: [RFC PATCH 3/3] selftests/seccomp: Add test for wait killable notifier
Date:   Sat, 20 Feb 2021 01:05:02 -0800
Message-Id: <20210220090502.7202-4-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210220090502.7202-1-sargun@sargun.me>
References: <20210220090502.7202-1-sargun@sargun.me>
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
 tools/testing/selftests/seccomp/seccomp_bpf.c | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 26c72f2b61b1..a8ef4558d673 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -4139,6 +4139,66 @@ TEST(user_notification_addfd_rlimit)
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

