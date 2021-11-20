Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66C7A457B0B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 05:09:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhKTEMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 23:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236788AbhKTEMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 23:12:18 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C04DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:09:15 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id d24so21553489wra.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 20:09:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kiak5w7UT68spBHraOMkJh4lsniVEsvlZVE/3JjHALY=;
        b=biiyq7txpYlfSxPIMbxAhVf16LfubeFTYzh3qyUvtnEoMeSvYgf9TncqNZQhKvX546
         JuZ3ixlCHb+QexBxhx8Y49buBpWxVvQ9ifdGYOsshY3x2T6SefWETqn2oviFMD1JJOyn
         yJS8vBlVuPvRl5oT04umXjVA6JWtw3B/FHcXV45mm8tkc64PjOVqOeWA8E5ediRwMvB8
         QU2gTQBQeRyw81ay//JsQSpFCPuEYJvwf562o948gj/Ruj6SouDiRUkyyp2VGHBPIRh/
         JqKSDhJKxszGjBbxx2n0Msdi/uvCZdaCxJtxQtnnGeP5xuzHpQoZxI861Xt0M9qUm+XZ
         74WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kiak5w7UT68spBHraOMkJh4lsniVEsvlZVE/3JjHALY=;
        b=eJ7Gs/zEvpXXMQl1bIUPE58Ldl6bmQ8t39fu6h+r22B1saBLLfltQegx46T5YWiwzi
         UBRiAd7LFMiUYruqQwbctlkupvtWAlba82pFadrE8zi00vvBuIJrhRVB6Cdx9vyNFsMa
         qQ/bzynhuKLi860/leNASmEuTFenlJq15swb0Aucxj/PkG07h6M7gxHBauSWQ4w7os28
         TUfM4q3l5oc0OsC781D25KLIen25qL/tRMq6LBoxOC4aasuoFgWRjFu8b2GoNOL8QmmZ
         Z4xTiN6f14brImTQ0tORZpFWwRfhVECeWNsFDGRC0QKz/iqVo1ccA8oe5Sy1h3iHa1QA
         tzLQ==
X-Gm-Message-State: AOAM530rk9U3cD71/EWHm4gYe/OBEgv9pHFbbD40a97J2o0rL2V/uSSg
        kZwLtAgCBTxRe0ZkSWBFNZFH6ky2pRPGLQ==
X-Google-Smtp-Source: ABdhPJyoxbehvM3XhFsMss8J8aMxX4u/J+cCSiLKQDmsUPECyBnJ0KZfuikEUJ6MhNGZcS4Mox/kBg==
X-Received: by 2002:a05:6000:15c8:: with SMTP id y8mr14030936wry.55.1637381353863;
        Fri, 19 Nov 2021 20:09:13 -0800 (PST)
Received: from localhost.localdomain ([197.49.250.127])
        by smtp.gmail.com with ESMTPSA id h2sm1497132wrz.23.2021.11.19.20.09.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 20:09:13 -0800 (PST)
From:   Sohaib Mohamed <sohaib.amhmd@gmail.com>
To:     jolsa@redhat.com
Cc:     acme@kernel.org, irogers@google.com, jolsa@kernel.org,
        linux-kernel@vger.kernel.org, namhyung@kernel.org,
        sohaib.amhmd@gmail.com, songliubraving@fb.com
Subject: [PATCH] Fixup: perf bench: Fix two memory leaks detected with ASan
Date:   Sat, 20 Nov 2021 06:08:54 +0200
Message-Id: <20211120040854.95169-1-sohaib.amhmd@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YZev7KClb/ud43Lc@krava>
References: <YZev7KClb/ud43Lc@krava>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes: 92723ea0f11d ("perf bench: Fix two memory leaks detected with
ASan")

This patch fixes the previous patch which frees the ctx before
the thread finishes the work. This break -t option.

This patch stores all overwritten pointers in a global vars then free
them at the end of the program.

Tests:
$ perf bench sched messaging -g 1 -l 100 -t
$ perf bench sched messaging -g 1 -l 100
$ perf bench sched all

Signed-off-by: Sohaib Mohamed <sohaib.amhmd@gmail.com>
---
 tools/perf/bench/sched-messaging.c | 39 +++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/tools/perf/bench/sched-messaging.c b/tools/perf/bench/sched-messaging.c
index 488f6e6ba1a5..f60dc9c36f4e 100644
--- a/tools/perf/bench/sched-messaging.c
+++ b/tools/perf/bench/sched-messaging.c
@@ -30,11 +30,15 @@
 #include <linux/time64.h>

 #define DATASIZE 100
+#define GROUPS_NUM 10
+#define FD_NUM 20

 static bool use_pipes = false;
 static unsigned int nr_loops = 100;
 static bool thread_mode = false;
-static unsigned int num_groups = 10;
+static unsigned int num_groups = GROUPS_NUM;
+static unsigned int num_fds = FD_NUM;
+static unsigned int total_counter; /* num_groups * num_fds */

 struct sender_context {
 	unsigned int num_fds;
@@ -50,6 +54,9 @@ struct receiver_context {
 	int wakefd;
 };

+struct receiver_context *ctx_arr[FD_NUM*GROUPS_NUM];
+struct sender_context *snd_ctx_arr[FD_NUM*GROUPS_NUM];
+
 static void fdpair(int fds[2])
 {
 	if (use_pipes) {
@@ -190,29 +197,30 @@ static void reap_worker(pthread_t id)

 /* One group of senders and receivers */
 static unsigned int group(pthread_t *pth,
-		unsigned int num_fds,
+		unsigned int num_fd,
 		int ready_out,
 		int wakefd)
 {
 	unsigned int i;
 	struct sender_context *snd_ctx = malloc(sizeof(struct sender_context)
-			+ num_fds * sizeof(int));
+			+ num_fd * sizeof(int));

 	if (!snd_ctx)
 		err(EXIT_FAILURE, "malloc()");

-	for (i = 0; i < num_fds; i++) {
+	for (i = 0; i < num_fd; i++) {
 		int fds[2];
 		struct receiver_context *ctx = malloc(sizeof(*ctx));

 		if (!ctx)
 			err(EXIT_FAILURE, "malloc()");

+		total_counter++;

 		/* Create the pipe between client and server */
 		fdpair(fds);

-		ctx->num_packets = num_fds * nr_loops;
+		ctx->num_packets = num_fd * nr_loops;
 		ctx->in_fds[0] = fds[0];
 		ctx->in_fds[1] = fds[1];
 		ctx->ready_out = ready_out;
@@ -223,24 +231,28 @@ static unsigned int group(pthread_t *pth,
 		snd_ctx->out_fds[i] = fds[1];
 		if (!thread_mode)
 			close(fds[0]);
+
+		ctx_arr[total_counter] = ctx;
 	}

 	/* Now we have all the fds, fork the senders */
-	for (i = 0; i < num_fds; i++) {
+	for (i = 0; i < num_fd; i++) {
 		snd_ctx->ready_out = ready_out;
 		snd_ctx->wakefd = wakefd;
-		snd_ctx->num_fds = num_fds;
+		snd_ctx->num_fds = num_fd;

-		pth[num_fds+i] = create_worker(snd_ctx, (void *)sender);
+		pth[num_fd+i] = create_worker(snd_ctx, (void *)sender);
 	}

 	/* Close the fds we have left */
 	if (!thread_mode)
-		for (i = 0; i < num_fds; i++)
+		for (i = 0; i < num_fd; i++)
 			close(snd_ctx->out_fds[i]);

+	snd_ctx_arr[total_counter] = snd_ctx;
+
 	/* Return number of children to reap */
-	return num_fds * 2;
+	return num_fd * 2;
 }

 static const struct option options[] = {
@@ -262,7 +274,6 @@ int bench_sched_messaging(int argc, const char **argv)
 {
 	unsigned int i, total_children;
 	struct timeval start, stop, diff;
-	unsigned int num_fds = 20;
 	int readyfds[2], wakefds[2];
 	char dummy;
 	pthread_t *pth_tab;
@@ -287,6 +298,7 @@ int bench_sched_messaging(int argc, const char **argv)
 		if (read(readyfds[0], &dummy, 1) != 1)
 			err(EXIT_FAILURE, "Reading for readyfds");

+
 	gettimeofday(&start, NULL);

 	/* Kick them off */
@@ -323,6 +335,11 @@ int bench_sched_messaging(int argc, const char **argv)
 		break;
 	}

+	/* Free malloc's */
+	for (i = 0; i < FD_NUM * GROUPS_NUM; i++) {
+		free(ctx_arr[i]);
+		free(snd_ctx_arr[i]);
+	}
 	free(pth_tab);

 	return 0;
--
2.25.1

