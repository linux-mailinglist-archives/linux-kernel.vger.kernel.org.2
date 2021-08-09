Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369253E3F0B
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 06:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233039AbhHIEdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 00:33:52 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:59006 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232956AbhHIEdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 00:33:42 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9309721EF7;
        Mon,  9 Aug 2021 04:33:21 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B4F7E13398;
        Mon,  9 Aug 2021 04:33:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id yCCuIg+wEGEfDQAAMHmgww
        (envelope-from <dave@stgolabs.net>); Mon, 09 Aug 2021 04:33:19 +0000
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     acme@kernel.org
Cc:     mingo@redhat.com, peterz@infradead.org, tglx@linutronix.de,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave@stgolabs.net, Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH 5/7] perf/bench-futex, requeue: Add --broadcast option
Date:   Sun,  8 Aug 2021 21:32:59 -0700
Message-Id: <20210809043301.66002-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210809043301.66002-1-dave@stgolabs.net>
References: <20210809043301.66002-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Such that all threads are requeued to uaddr2 in a single
futex_cmp_requeue(), unlike the default, which is 1.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 tools/perf/bench/futex-requeue.c | 4 ++++
 tools/perf/bench/futex.h         | 1 +
 2 files changed, 5 insertions(+)

diff --git a/tools/perf/bench/futex-requeue.c b/tools/perf/bench/futex-requeue.c
index 88cb7e2a6729..80f40ee92b53 100644
--- a/tools/perf/bench/futex-requeue.c
+++ b/tools/perf/bench/futex-requeue.c
@@ -52,6 +52,7 @@ static const struct option options[] = {
 	OPT_BOOLEAN( 's', "silent",   &params.silent, "Silent mode: do not display data/details"),
 	OPT_BOOLEAN( 'S', "shared",   &params.fshared, "Use shared futexes instead of private ones"),
 	OPT_BOOLEAN( 'm', "mlockall", &params.mlockall, "Lock all current and future memory"),
+	OPT_BOOLEAN( 'B', "broadcast", &params.broadcast, "Requeue all threads at once"),
 	OPT_END()
 };
 
@@ -153,6 +154,9 @@ int bench_futex_requeue(int argc, const char **argv)
 	if (params.nrequeue > params.nthreads)
 		params.nrequeue = params.nthreads;
 
+	if (params.broadcast)
+		params.nrequeue = params.nthreads;
+
 	printf("Run summary [PID %d]: Requeuing %d threads (from [%s] %p to %p), "
 	       "%d at a time.\n\n",  getpid(), params.nthreads,
 	       params.fshared ? "shared":"private", &futex1, &futex2, params.nrequeue);
diff --git a/tools/perf/bench/futex.h b/tools/perf/bench/futex.h
index 1c8fa469993f..36f158650edf 100644
--- a/tools/perf/bench/futex.h
+++ b/tools/perf/bench/futex.h
@@ -21,6 +21,7 @@ struct bench_futex_parameters {
 	bool fshared;
 	bool mlockall;
 	bool multi; /* lock-pi */
+	bool broadcast; /* requeue */
 	unsigned int runtime; /* seconds*/
 	unsigned int nthreads;
 	unsigned int nfutexes;
-- 
2.26.2

