Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEB443E8FF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 21:30:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhJ1Tc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 15:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhJ1TcZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 15:32:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE739C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:29:57 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id 8D97B1F435C9
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 2/2] selftests: futex: Add FUTEX_LOCK_PI2 for timeout test
Date:   Thu, 28 Oct 2021 16:29:36 -0300
Message-Id: <20211028192936.81640-3-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211028192936.81640-1-andrealmeid@collabora.com>
References: <20211028192936.81640-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit bf22a6976897 ("futex: Provide FUTEX_LOCK_PI2 to support clock
selection"), there's a new operation that supports CLOCK_MONOTONIC and
CLOCK_REALTIME. Test the timeout interface of FUTEX_LOCK_PI2 operation.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 .../futex/functional/futex_wait_timeout.c          | 14 +++++++++++++-
 tools/testing/selftests/futex/include/futextest.h  | 14 ++++++++++++++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
index 3651ce17beeb..c64967c787ca 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -125,7 +125,7 @@ int main(int argc, char *argv[])
 	}
 
 	ksft_print_header();
-	ksft_set_plan(9);
+	ksft_set_plan(11);
 	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=%ldns\n", timeout_ns);
@@ -182,6 +182,18 @@ int main(int argc, char *argv[])
 	res = futex_lock_pi(&futex_pi, NULL, 0, FUTEX_CLOCK_REALTIME);
 	test_timeout(res, &ret, "futex_lock_pi invalid timeout flag", ENOSYS);
 
+	/* FUTEX_LOCK_PI2 with CLOCK_REALTIME */
+	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex_lock_pi2(&futex_pi, &to, 0, FUTEX_CLOCK_REALTIME);
+	test_timeout(res, &ret, "futex_lock_pi2 realtime", ETIMEDOUT);
+
+	/* FUTEX_LOCK_PI2 with CLOCK_MONOTONIC */
+	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
+		return RET_FAIL;
+	res = futex_lock_pi2(&futex_pi, &to, 0, 0);
+	test_timeout(res, &ret, "futex_lock_pi2 monotonic", ETIMEDOUT);
+
 	/* futex_waitv with CLOCK_MONOTONIC */
 	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
 		return RET_FAIL;
diff --git a/tools/testing/selftests/futex/include/futextest.h b/tools/testing/selftests/futex/include/futextest.h
index ddbcfc9b7bac..9a0bd96d354b 100644
--- a/tools/testing/selftests/futex/include/futextest.h
+++ b/tools/testing/selftests/futex/include/futextest.h
@@ -38,6 +38,9 @@ typedef volatile u_int32_t futex_t;
 #ifndef FUTEX_CMP_REQUEUE_PI
 #define FUTEX_CMP_REQUEUE_PI		12
 #endif
+#ifndef FUTEX_PI2
+#define FUTEX_PI2			13
+#endif
 #ifndef FUTEX_WAIT_REQUEUE_PI_PRIVATE
 #define FUTEX_WAIT_REQUEUE_PI_PRIVATE	(FUTEX_WAIT_REQUEUE_PI | \
 					 FUTEX_PRIVATE_FLAG)
@@ -124,6 +127,17 @@ futex_lock_pi(futex_t *uaddr, struct timespec *timeout, int detect,
 	return futex(uaddr, FUTEX_LOCK_PI, detect, timeout, NULL, 0, opflags);
 }
 
+/**
+ * futex_lock_pi2() - block on uaddr as a PI mutex
+ * @detect:	whether (1) or not (0) to perform deadlock detection
+ */
+static inline int
+futex_lock_pi2(futex_t *uaddr, struct timespec *timeout, int detect,
+	       int opflags)
+{
+	return futex(uaddr, FUTEX_LOCK_PI2, detect, timeout, NULL, 0, opflags);
+}
+
 /**
  * futex_unlock_pi() - release uaddr as a PI mutex, waking the top waiter
  */
-- 
2.33.1

