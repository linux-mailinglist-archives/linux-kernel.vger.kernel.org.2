Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B734043E8FE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Oct 2021 21:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231157AbhJ1TcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Oct 2021 15:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231140AbhJ1TcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Oct 2021 15:32:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27DE0C061570
        for <linux-kernel@vger.kernel.org>; Thu, 28 Oct 2021 12:29:55 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: tonyk)
        with ESMTPSA id E863C1F4303F
From:   =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        linux-kernel@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>
Cc:     =?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@collabora.com>
Subject: [PATCH 1/2] selftests: futex: Make futex_waitv's invalid clockid test more robust
Date:   Thu, 28 Oct 2021 16:29:35 -0300
Message-Id: <20211028192936.81640-2-andrealmeid@collabora.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211028192936.81640-1-andrealmeid@collabora.com>
References: <20211028192936.81640-1-andrealmeid@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If we use NULL for *waiters, we may be triggering a different error
path. Use a valid value for this arguments to make sure that the invalid
clockid is the one triggering the EINVAL return.

Signed-off-by: André Almeida <andrealmeid@collabora.com>
---
 tools/testing/selftests/futex/functional/futex_waitv.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/testing/selftests/futex/functional/futex_waitv.c
index a94337f677e1..336b04dacd0e 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -217,12 +217,17 @@ int main(int argc, char *argv[])
 	}
 
 	/* Testing an invalid clockid */
+	waitv[0].uaddr = (uintptr_t)&futexes[0];
+	waitv[0].flags = FUTEX_PRIVATE_FLAG | FUTEX_32;
+	waitv[0].val = 0;
+	waitv[0].__reserved = 0;
+
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
 		error("gettime64 failed\n", errno);
 
 	to.tv_sec++;
 
-	res = futex_waitv(NULL, NR_FUTEXES, 0, &to, CLOCK_TAI);
+	res = futex_waitv(waitv, 1, 0, &to, CLOCK_TAI);
 	if (res == EINVAL) {
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
-- 
2.33.1

