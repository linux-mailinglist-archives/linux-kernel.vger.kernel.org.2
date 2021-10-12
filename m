Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71E33429BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 05:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232114AbhJLDLn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 23:11:43 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:35768 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232082AbhJLDLg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 23:11:36 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 2DFD522034;
        Tue, 12 Oct 2021 03:09:33 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 125D313B4E;
        Tue, 12 Oct 2021 03:09:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XxvuNWv8ZGHgUAAAMHmgww
        (envelope-from <dave@stgolabs.net>); Tue, 12 Oct 2021 03:09:31 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] perf bench futex, wake: Fixlets for futex_wait return checks
Date:   Mon, 11 Oct 2021 20:09:14 -0700
Message-Id: <20211012030914.101944-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Avoid checking against EINTR which has for a very long time no longer
been the case for spurious wakeups. Properly use EAGAIN instead - albeit
there should be no error scenarios in these workloads.

- Do not bogusly check syscall(2) return, but instead rely on errno.

- Use warn() instead of warnx() for we want an appended message.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/futex-requeue.c       |  4 ++--
 tools/perf/bench/futex-wake-parallel.c | 13 +++++++++++--
 tools/perf/bench/futex-wake.c          | 11 ++++++++++-
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index 97fe31fd3a23..ef09ca189e47 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -97,7 +97,7 @@ static void *workerfn(void *arg __maybe_unused)
 
 			if (ret && errno != EAGAIN) {
 				if (!params.silent)
-					warnx("futex_wait");
+					warn("futex_wait");
 				break;
 			}
 		} else {
@@ -111,7 +111,7 @@ static void *workerfn(void *arg __maybe_unused)
 
 			if (ret && errno != EAGAIN) {
 				if (!params.silent)
-					warnx("futex_wait_requeue_pi");
+					warn("futex_wait_requeue_pi");
 				break;
 			}
 		}
diff --git a/tools/perf/bench/futex-wake-parallel.c b/tools/perf/bench/futex-wake-parallel.c
index e970e6b9ad53..76b57eac2375 100644
--- a/tools/perf/bench/futex-wake-parallel.c
+++ b/tools/perf/bench/futex-wake-parallel.c
@@ -132,9 +132,18 @@ static void *blocked_workerfn(void *arg __maybe_unused)
 	pthread_cond_wait(&thread_worker, &thread_lock);
 	pthread_mutex_unlock(&thread_lock);
 
-	while (1) { /* handle spurious wakeups */
-		if (futex_wait(&futex, 0, NULL, futex_flag) != EINTR)
+	while (1) {
+		int ret;
+
+		ret = futex_wait(&futex, 0, NULL, futex_flag);
+		if (!ret)
+			break;
+
+		if (ret && errno != EAGAIN) {
+			if (!params.silent)
+				warn("futex_wait");
 			break;
+		}
 	}
 
 	pthread_exit(NULL);
diff --git a/tools/perf/bench/futex-wake.c b/tools/perf/bench/futex-wake.c
index 77f058a47790..8e99b506d4f0 100644
--- a/tools/perf/bench/futex-wake.c
+++ b/tools/perf/bench/futex-wake.c
@@ -73,8 +73,17 @@ static void *workerfn(void *arg __maybe_unused)
 	pthread_mutex_unlock(&thread_lock);
 
 	while (1) {
-		if (futex_wait(&futex1, 0, NULL, futex_flag) != EINTR)
+		int ret;
+
+		ret = futex_wait(&futex1, 0, NULL, futex_flag);
+		if (!ret)
+			break;
+
+		if (ret && errno != EAGAIN) {
+			if (!params.silent)
+				warn("futex_wait");
 			break;
+		}
 	}
 
 	pthread_exit(NULL);
-- 
2.26.2

