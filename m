Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 415BB37679E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 17:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237834AbhEGPHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 11:07:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31917 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235720AbhEGPHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 11:07:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620399962;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2pOtOZv489j8EE/2pWOw3CG9r3znR3tk6XqlrWP3ILs=;
        b=DnFMziIlW4tbR/wpanIJOYo4u4FWjNH4cP3IOSpZz4hAYh6f0cMj2SRtV3uhM+/NizXZ/Z
        ULbdCtVrzMgL3pNSHNogqeriepLRKzXV3FM6LQ1Uri6Q5jQ+1gVwLkvQN3hfKkArQ0lhND
        /hAYp/S9QTLgkFWIsBeJ8GKQmfeQgf0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-8uH10et8P4ylfrtAs7fzMw-1; Fri, 07 May 2021 11:06:00 -0400
X-MC-Unique: 8uH10et8P4ylfrtAs7fzMw-1
Received: by mail-qk1-f198.google.com with SMTP id o14-20020a05620a130eb02902ea53a6ef80so6236548qkj.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 May 2021 08:06:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2pOtOZv489j8EE/2pWOw3CG9r3znR3tk6XqlrWP3ILs=;
        b=Gqen9OzVMJcpRuxCXFv7SXjDXreBwAZK77KVBF6w3ZoGixtCTQrMW0lRAF9aa6rsoX
         J82BV/84VVQzcrVphmZlQVB00Hchss4uqr1bzwXqYnl89RGppSopPvowEcSzIZEXv05T
         Gbb8uM2oYKPsiKoqQkzN+d+em3wVHVf6JbNFGdHcUJRXxGEzgJFasipohvO7zeCkjxYz
         G+le7RjwPYx3epBoLBCjTK5cvcRc0IJbpPu+Xjrsab4UkZzHUKGsukMuVrMhtb0sNNHw
         lSadXOvsPWEGYgCyMT7SMwA99XPSlkbJnHnmSsfCEqW+rnAPxojcXoo1bkGaZorq+BEV
         RnCg==
X-Gm-Message-State: AOAM531v9IhvLAPwWTKjNKCT5xBXPMdoqL79D2BCczn9FP87Ttzuqe8Q
        yPqx+lwdwHt+h+TiqQ3zeCR5xPrPVZ5CudUhOQyDNfkgeKGVFUo7Zm3opTSCuWcV98gHEFVsmdT
        8xDciMcyxy4vVoQkC8CXTvKsC
X-Received: by 2002:a05:622a:1049:: with SMTP id f9mr9871140qte.140.1620399960186;
        Fri, 07 May 2021 08:06:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwYyMQF6ihKctiWDD8i/xGdzEjnVrEZ2QGcB1BPY2LE+yfrEeYxK3caSAS8BZnFREdCJoRALA==
X-Received: by 2002:a05:622a:1049:: with SMTP id f9mr9871104qte.140.1620399959849;
        Fri, 07 May 2021 08:05:59 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id c141sm950456qke.12.2021.05.07.08.05.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 May 2021 08:05:58 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>, John Hubbard <jhubbard@nvidia.com>,
        peterx@redhat.com, Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jann Horn <jannh@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v2 1/3] mm/gup_benchmark: Support threading
Date:   Fri,  7 May 2021 11:05:51 -0400
Message-Id: <20210507150553.208763-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210507150553.208763-1-peterx@redhat.com>
References: <20210507150553.208763-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new parameter "-j N" to support concurrent gup test.

Reviewed-by: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/gup_test.c | 96 ++++++++++++++++++---------
 1 file changed, 65 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
index 1e662d59c502a..fe043f67798b0 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -6,6 +6,8 @@
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <pthread.h>
+#include <assert.h>
 #include "../../../../mm/gup_test.h"
 
 #define MB (1UL << 20)
@@ -15,6 +17,12 @@
 #define FOLL_WRITE	0x01	/* check pte is writable */
 #define FOLL_TOUCH	0x02	/* mark page accessed */
 
+static unsigned long cmd = GUP_FAST_BENCHMARK;
+static int gup_fd, repeats = 1;
+static unsigned long size = 128 * MB;
+/* Serialize prints */
+static pthread_mutex_t print_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 static char *cmd_to_str(unsigned long cmd)
 {
 	switch (cmd) {
@@ -34,17 +42,55 @@ static char *cmd_to_str(unsigned long cmd)
 	return "Unknown command";
 }
 
+void *gup_thread(void *data)
+{
+	struct gup_test gup = *(struct gup_test *)data;
+	int i;
+
+	/* Only report timing information on the *_BENCHMARK commands: */
+	if ((cmd == PIN_FAST_BENCHMARK) || (cmd == GUP_FAST_BENCHMARK) ||
+	     (cmd == PIN_LONGTERM_BENCHMARK)) {
+		for (i = 0; i < repeats; i++) {
+			gup.size = size;
+			if (ioctl(gup_fd, cmd, &gup))
+				perror("ioctl"), exit(1);
+
+			pthread_mutex_lock(&print_mutex);
+			printf("%s: Time: get:%lld put:%lld us",
+			       cmd_to_str(cmd), gup.get_delta_usec,
+			       gup.put_delta_usec);
+			if (gup.size != size)
+				printf(", truncated (size: %lld)", gup.size);
+			printf("\n");
+			pthread_mutex_unlock(&print_mutex);
+		}
+	} else {
+		gup.size = size;
+		if (ioctl(gup_fd, cmd, &gup)) {
+			perror("ioctl");
+			exit(1);
+		}
+
+		pthread_mutex_lock(&print_mutex);
+		printf("%s: done\n", cmd_to_str(cmd));
+		if (gup.size != size)
+			printf("Truncated (size: %lld)\n", gup.size);
+		pthread_mutex_unlock(&print_mutex);
+	}
+
+	return NULL;
+}
+
 int main(int argc, char **argv)
 {
 	struct gup_test gup = { 0 };
-	unsigned long size = 128 * MB;
-	int i, fd, filed, opt, nr_pages = 1, thp = -1, repeats = 1, write = 1;
-	unsigned long cmd = GUP_FAST_BENCHMARK;
+	int filed, i, opt, nr_pages = 1, thp = -1, write = 1, nthreads = 1, ret;
 	int flags = MAP_PRIVATE, touch = 0;
 	char *file = "/dev/zero";
+	pthread_t *tid;
 	char *p;
 
-	while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHpz")) != -1) {
+	while ((opt = getopt(argc, argv, "m:r:n:F:f:abcj:tTLUuwWSHpz")) != -1) {
 		switch (opt) {
 		case 'a':
 			cmd = PIN_FAST_BENCHMARK;
@@ -74,6 +120,9 @@ int main(int argc, char **argv)
 			/* strtol, so you can pass flags in hex form */
 			gup.gup_flags = strtol(optarg, 0, 0);
 			break;
+		case 'j':
+			nthreads = atoi(optarg);
+			break;
 		case 'm':
 			size = atoi(optarg) * MB;
 			break;
@@ -154,8 +203,8 @@ int main(int argc, char **argv)
 	if (write)
 		gup.gup_flags |= FOLL_WRITE;
 
-	fd = open("/sys/kernel/debug/gup_test", O_RDWR);
-	if (fd == -1) {
+	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
+	if (gup_fd == -1) {
 		perror("open");
 		exit(1);
 	}
@@ -185,32 +234,17 @@ int main(int argc, char **argv)
 			p[0] = 0;
 	}
 
-	/* Only report timing information on the *_BENCHMARK commands: */
-	if ((cmd == PIN_FAST_BENCHMARK) || (cmd == GUP_FAST_BENCHMARK) ||
-	     (cmd == PIN_LONGTERM_BENCHMARK)) {
-		for (i = 0; i < repeats; i++) {
-			gup.size = size;
-			if (ioctl(fd, cmd, &gup))
-				perror("ioctl"), exit(1);
-
-			printf("%s: Time: get:%lld put:%lld us",
-			       cmd_to_str(cmd), gup.get_delta_usec,
-			       gup.put_delta_usec);
-			if (gup.size != size)
-				printf(", truncated (size: %lld)", gup.size);
-			printf("\n");
-		}
-	} else {
-		gup.size = size;
-		if (ioctl(fd, cmd, &gup)) {
-			perror("ioctl");
-			exit(1);
-		}
-
-		printf("%s: done\n", cmd_to_str(cmd));
-		if (gup.size != size)
-			printf("Truncated (size: %lld)\n", gup.size);
+	tid = malloc(sizeof(pthread_t) * nthreads);
+	assert(tid);
+	for (i = 0; i < nthreads; i++) {
+		ret = pthread_create(&tid[i], NULL, gup_thread, &gup);
+		assert(ret == 0);
+	}
+	for (i = 0; i < nthreads; i++) {
+		ret = pthread_join(tid[i], NULL);
+		assert(ret == 0);
 	}
+	free(tid);
 
 	return 0;
 }
-- 
2.31.1

