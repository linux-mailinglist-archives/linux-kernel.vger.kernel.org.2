Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626D537026A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 22:50:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236086AbhD3Uuz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 16:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236028AbhD3Uuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 16:50:40 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B430C06174A
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:49:51 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id x8so570643qkl.2
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 13:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9ZU5d3woFMizJa7hiEgUjcAVtlOmWstlkDGKvmjbXqM=;
        b=QPAms99dn45GAuRk046FFMVa45Tf8pkF5QIqjFZkhIrthvRkqRo91U2CwADexIeh5G
         wiAKOaOEOY3XTRs/DzIuVMhZAsi/ugSKtDwPcJmen2LQ3kz7O6DEex0lsM/5UAocqqUl
         BPgYUJIhaSyt5ab5zfn1Bdn/lZfpUo8UamGO0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9ZU5d3woFMizJa7hiEgUjcAVtlOmWstlkDGKvmjbXqM=;
        b=b6lUPwwXMZSn/LC8ccEiO0+NZ+YHyxM7prTXpaqhuAijdBepSvjszXEsi38ds6oMnQ
         9JWgdMy8dPGP4Ew8S3nB80C8OzJBu4NHdD/8/ayzBvbaZy3fjoR9mrTN+4DSG0xZ5jSI
         SMBckVHDw/vpcjrKBtfmjI3YRSQ71V+glNHQwYBu3d2LDvhnsqHMryE/EuWLPjrERpDS
         vOFoCWmj8kJeG8ZygIT7Y6yThDt5lGhG5hucLr9CqsZbsLseWuGhV9pCId0Cny1jtK67
         peGs+j6AF64gJXr74Vdqy2DMpWmGWmIIBrLp3nDXtMtW3roWT/tCWTKJVnK7196v76s7
         q62A==
X-Gm-Message-State: AOAM531W4glOEA2VcOnhsQBjlmSuFQ66lTSXNHEXiNJO1rgL5aYm8Qjd
        3gxSefvll+73y6LehRBWyDZ44Q==
X-Google-Smtp-Source: ABdhPJxheZUFnAHw0netMHI17prQLKD/673UzLLY2CfWEKNMpE1TwDlxdL8wzG3jd7M2z7vwfg0aVg==
X-Received: by 2002:a37:4389:: with SMTP id q131mr7432209qka.255.1619815790404;
        Fri, 30 Apr 2021 13:49:50 -0700 (PDT)
Received: from ubuntu.netflix.com (136-25-20-203.cab.webpass.net. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id z17sm3161960qtf.10.2021.04.30.13.49.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 13:49:49 -0700 (PDT)
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
Subject: [PATCH v2 3/5] selftests/seccomp: Add test for wait killable notifier
Date:   Fri, 30 Apr 2021 13:49:37 -0700
Message-Id: <20210430204939.5152-4-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210430204939.5152-1-sargun@sargun.me>
References: <20210430204939.5152-1-sargun@sargun.me>
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
 tools/testing/selftests/seccomp/seccomp_bpf.c | 152 ++++++++++++++++++
 1 file changed, 152 insertions(+)

diff --git a/tools/testing/selftests/seccomp/seccomp_bpf.c b/tools/testing/selftests/seccomp/seccomp_bpf.c
index 98c3b647f54d..9a72ba8bb4f7 100644
--- a/tools/testing/selftests/seccomp/seccomp_bpf.c
+++ b/tools/testing/selftests/seccomp/seccomp_bpf.c
@@ -235,6 +235,11 @@ struct seccomp_notif_addfd {
 };
 #endif
 
+#ifndef SECCOMP_IOCTL_NOTIF_SET_WAIT_KILLABLE
+/* Set flag to prevent non-fatal signal preemption */
+#define SECCOMP_IOCTL_NOTIF_SET_WAIT_KILLABLE	SECCOMP_IOW(4, __u64)
+#endif
+
 struct seccomp_notif_addfd_small {
 	__u64 id;
 	char weird[4];
@@ -4135,6 +4140,153 @@ TEST(user_notification_addfd_rlimit)
 	close(memfd);
 }
 
+/* Parses /proc/$PID/status, and stores the state and shdpnd */
+static void parse_status(pid_t pid, char *state, long long *shdpnd)
+{
+	char *line = NULL;
+	char proc_path[100] = {0};
+	size_t len = 0;
+	FILE *f;
+
+	snprintf(proc_path, sizeof(proc_path), "/proc/%d/status", pid);
+	f = fopen(proc_path, "r");
+	if (f == NULL)
+		ksft_exit_fail_msg("%s - Could not open %s\n",
+				   strerror(errno), proc_path);
+
+	while (getline(&line, &len, f) != -1) {
+		if (strstr(line, "State")) {
+			if (sscanf(line, "State:\t%c", state) != 1)
+				ksft_exit_fail_msg("Couldn't parse state %s\n",
+						   line);
+		}
+
+		if (strstr(line, "ShdPnd")) {
+			if (sscanf(line, "ShdPnd:\t%llx", shdpnd) != 1)
+				ksft_exit_fail_msg("Couldn't parse shdpnd %s\n",
+						   line);
+		}
+	}
+
+	free(line);
+	fclose(f);
+}
+
+TEST(user_notification_signal_wait_killable)
+{
+	struct seccomp_notif_resp resp = {};
+	struct seccomp_notif req = {};
+	int status, listener;
+	long long sigpnd;
+	char state;
+	pid_t pid;
+	long ret;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	listener = user_notif_syscall(__NR_gettid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		sigset_t mask;
+
+		sigemptyset(&mask);
+		sigaddset(&mask, SIGUSR1);
+
+		EXPECT_EQ(sigprocmask(SIG_BLOCK, &mask, NULL), 0);
+
+		/* Check once for wait_killable */
+		if (syscall(__NR_gettid) != 42)
+			exit(1);
+
+		EXPECT_EQ(SIGUSR1, sigwaitinfo(&mask, NULL));
+
+		exit(42);
+	}
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+
+	/* Wait interruptible should be in sleep */
+	parse_status(pid, &state, &sigpnd);
+	ASSERT_EQ(state, 'S');
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_WAIT_KILLABLE, &req.id), 0);
+	EXPECT_EQ(kill(pid, SIGUSR1), 0);
+
+	/* Check for transition to "disk sleep" -- async (or timeout) */
+	do {
+		usleep(100);
+		parse_status(pid, &state, &sigpnd);
+	} while (state != 'D');
+	EXPECT_EQ(sigpnd, (1 << (SIGUSR1 - 1)));
+
+	/* Make sure idempotency is handled correctly */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_WAIT_KILLABLE, &req.id), -1);
+	EXPECT_EQ(errno, EALREADY);
+
+	resp.id = req.id;
+	resp.error = 0;
+	resp.val = 42;
+
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SEND, &resp), 0);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFEXITED(status));
+	EXPECT_EQ(42, WEXITSTATUS(status));
+}
+
+
+TEST(user_notification_signal_wait_killable_kill)
+{
+	struct seccomp_notif req = {};
+	int status, listener;
+	long long sigpnd;
+	char state;
+	pid_t pid;
+	long ret;
+
+	ret = prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
+	ASSERT_EQ(0, ret) {
+		TH_LOG("Kernel does not support PR_SET_NO_NEW_PRIVS!");
+	}
+
+	listener = user_notif_syscall(__NR_gettid,
+				      SECCOMP_FILTER_FLAG_NEW_LISTENER);
+	ASSERT_GE(listener, 0);
+
+	pid = fork();
+	ASSERT_GE(pid, 0);
+
+	if (pid == 0) {
+		syscall(__NR_gettid);
+		exit(1);
+	}
+
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_RECV, &req), 0);
+	ASSERT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_SET_WAIT_KILLABLE, &req.id), 0);
+	do {
+		usleep(100);
+		parse_status(pid, &state, &sigpnd);
+	} while (state != 'D');
+
+	EXPECT_EQ(kill(pid, SIGKILL), 0);
+
+	EXPECT_EQ(waitpid(pid, &status, 0), pid);
+	EXPECT_EQ(true, WIFSIGNALED(status));
+	EXPECT_EQ(9, WTERMSIG(status));
+
+	/* Make sure the notification is invalidated properly */
+	EXPECT_EQ(ioctl(listener, SECCOMP_IOCTL_NOTIF_ID_VALID, &req.id), -1);
+}
+
+
 /*
  * TODO:
  * - expand NNP testing
-- 
2.25.1

