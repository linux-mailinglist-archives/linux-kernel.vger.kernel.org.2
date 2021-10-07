Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8370425ABB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Oct 2021 20:27:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234200AbhJGS3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 14:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhJGS3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 14:29:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC2AC061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 11:27:17 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r18so26563667edv.12
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 11:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SmpE1IpRP4ds4WyBoMNj8Wpe0Ma3ytWERO5DPvhqcjQ=;
        b=obYy1aObdIbeFFjGmxGVDMaEYF1QmTH2aVhoksWgbl+5t4gEF68C4NUYzjxAWd07cR
         KyagZi2Je8KatJsIXEeQc5SS3CXC54to3zwmXdbaV9eQu0FBuQU9asNPmWgDLRpce17h
         PSKod0kSSaMZisbaSBzSXhtSAnDa+xSf0d6F8SbmR4EqYNkcRGPo6HADBX+M0tyDXDox
         OschQVVZLbxn0ev3BNeeQQKF9CefYcWBnArb+oipTYNqR2f4um0QHA99achuP+QFJjXb
         yfVPkiPwB2GU3Yib8Gynjl7r20sB7IT6WptB0s6mbrytwAnR7ZmCQ1xIztij4RIov57F
         LDNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SmpE1IpRP4ds4WyBoMNj8Wpe0Ma3ytWERO5DPvhqcjQ=;
        b=y0ABqBr1WNbNNLmRgrDoH5Mwq+3ZU7qiO6XnBvhNQtOpiwG1V+ghN21l3KVDuRn1/3
         pAfof96nJfQtqOTq4Mmo8fwT8tNjZ7Jgf8yAwc2S22DnX9hDbFOPZVMAOxMNkyBv461n
         MmgyRcJ0Vi7oMmKfEkytKQYMi+UyAlb61r6nd8mlZLC7+510NiwLaqy5GmIkyLTTSTs3
         cm6yy/th4hioI+LipC93Wn4mePnJdCwBHRI9WwtaOW2cil+s1smewg50BeIWPCedgtRF
         St8ytfYGc7WvLCSs3napFiXpv7e4T8iHBBSnJ1mw3zRwGQlnK33OyprjQrXisgrKg/7E
         G1Mg==
X-Gm-Message-State: AOAM531cxDcv9AzJrt+I5KpEjOIj82GSoA+Tlnlm45ByDGn3D3o5aw3y
        Ukm4sANx9H9iKks37NRK4A==
X-Google-Smtp-Source: ABdhPJyqit0HgsCSIiJttEfLdZrfNuiEiIVeitGdcKi1aSrLsM9PTl6lFudQjKee4Uh2xudOLUXiSA==
X-Received: by 2002:a05:6402:510b:: with SMTP id m11mr8539431edd.82.1633631236576;
        Thu, 07 Oct 2021 11:27:16 -0700 (PDT)
Received: from localhost.localdomain ([46.53.254.50])
        by smtp.gmail.com with ESMTPSA id v19sm69151ejx.26.2021.10.07.11.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Oct 2021 11:27:16 -0700 (PDT)
Date:   Thu, 7 Oct 2021 21:27:14 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     akpm@linux-foundation.org
Cc:     christian.brauner@ubuntu.com, ebiederm@xmission.com,
        fweimer@redhat.com, keescook@chromium.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] proc: test that /proc/*/task doesn't contain "0"
Message-ID: <YV88AnVzHxPafQ9o@localhost.localdomain>
References: <20210929232038.o0_ct-q8J%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210929232038.o0_ct-q8J%akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 tools/testing/selftests/proc/.gitignore  |    1 
 tools/testing/selftests/proc/Makefile    |    2 
 tools/testing/selftests/proc/proc-tid0.c |   81 +++++++++++++++++++++++++++++++
 3 files changed, 84 insertions(+)

--- a/tools/testing/selftests/proc/.gitignore
+++ b/tools/testing/selftests/proc/.gitignore
@@ -11,6 +11,7 @@
 /proc-self-syscall
 /proc-self-wchan
 /proc-subset-pid
+/proc-tid0
 /proc-uptime-001
 /proc-uptime-002
 /read
--- a/tools/testing/selftests/proc/Makefile
+++ b/tools/testing/selftests/proc/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0-only
 CFLAGS += -Wall -O2 -Wno-unused-function
 CFLAGS += -D_GNU_SOURCE
+LDFLAGS += -pthread
 
 TEST_GEN_PROGS :=
 TEST_GEN_PROGS += fd-001-lookup
@@ -13,6 +14,7 @@ TEST_GEN_PROGS += proc-self-map-files-002
 TEST_GEN_PROGS += proc-self-syscall
 TEST_GEN_PROGS += proc-self-wchan
 TEST_GEN_PROGS += proc-subset-pid
+TEST_GEN_PROGS += proc-tid0
 TEST_GEN_PROGS += proc-uptime-001
 TEST_GEN_PROGS += proc-uptime-002
 TEST_GEN_PROGS += read
new file mode 100644
--- /dev/null
+++ b/tools/testing/selftests/proc/proc-tid0.c
@@ -0,0 +1,81 @@
+/*
+ * Copyright (c) 2021 Alexey Dobriyan <adobriyan@gmail.com>
+ *
+ * Permission to use, copy, modify, and distribute this software for any
+ * purpose with or without fee is hereby granted, provided that the above
+ * copyright notice and this permission notice appear in all copies.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
+ * WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
+ * ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
+ * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
+ * ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
+ * OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
+ */
+// Test that /proc/*/task never contains "0".
+#include <sys/types.h>
+#include <dirent.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <pthread.h>
+
+static pid_t pid = -1;
+
+static void atexit_hook(void)
+{
+	if (pid > 0) {
+		kill(pid, SIGKILL);
+	}
+}
+
+static void *f(void *_)
+{
+	return NULL;
+}
+
+static void sigalrm(int _)
+{
+	exit(0);
+}
+
+int main(void)
+{
+	pid = fork();
+	if (pid == 0) {
+		/* child */
+		while (1) {
+			pthread_t pth;
+			pthread_create(&pth, NULL, f, NULL);
+			pthread_join(pth, NULL);
+		}
+	} else if (pid > 0) {
+		/* parent */
+		atexit(atexit_hook);
+
+		char buf[64];
+		snprintf(buf, sizeof(buf), "/proc/%u/task", pid);
+
+		signal(SIGALRM, sigalrm);
+		alarm(1);
+
+		while (1) {
+			DIR *d = opendir(buf);
+			struct dirent *de;
+			while ((de = readdir(d))) {
+				if (strcmp(de->d_name, "0") == 0) {
+					exit(1);
+				}
+			}
+			closedir(d);
+		}
+
+		return 0;
+	} else {
+		perror("fork");
+		return 1;
+	}
+}
