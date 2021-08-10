Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6183E3F0C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 06:33:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbhHIEdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 00:33:54 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:60864 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232993AbhHIEdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 00:33:44 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E19271FD86;
        Mon,  9 Aug 2021 04:33:23 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E1CA013398;
        Mon,  9 Aug 2021 04:33:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id cPN0LBGwEGEfDQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 09 Aug 2021 04:33:21 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 6/7] perf/bench-futex, requeue: Robustify futex_wait() handling
Date:   Sun,  8 Aug 2021 21:33:00 -0700
Message-Id: <20210809043301.66002-7-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210809043301.66002-1-dave@stgolabs.net>
References: <20210809043301.66002-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not assume success and account for EAGAIN or any other return value,
however unlikely.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/futex-requeue.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index 80f40ee92b53..e4892ba6864f 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -76,6 +76,8 @@ static void print_summary(void)
 
 static void *workerfn(void *arg __maybe_unused)
 {
+	int ret;
+
 	pthread_mutex_lock(&thread_lock);
 	threads_starting--;
 	if (!threads_starting)
@@ -83,7 +85,18 @@ static void *workerfn(void *arg __maybe_unused)
 	pthread_cond_wait(&thread_worker, &thread_lock);
 	pthread_mutex_unlock(&thread_lock);
 
-	futex_wait(&futex1, 0, NULL, futex_flag);
+	while (1) {
+		ret = futex_wait(&futex1, 0, NULL, futex_flag);
+		if (!ret)
+			break;
+
+		if (ret && errno != EAGAIN) {
+			if (!params.silent)
+				warn("futex_wait");
+			break;
+		}
+	}
+
 	return NULL;
 }
 
-- 
2.26.2

