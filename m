Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB9DC375D5F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 May 2021 01:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhEFX0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 May 2021 19:26:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:30006 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231509AbhEFX0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 May 2021 19:26:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620343543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T2/Kp/6DMcvb66SGLUrQ0litwe4gG/CMDxNGXzk5jHI=;
        b=hxfQO9oYrnBLp1BQTXbPwa5K9IvpRQKLp2nYiHWtKjCBdhIlcz9rknpujtjDWTRMmUv54W
        PaIrIpJhlJvv5cq1U7p481zkrz+XlKBbRqbHCYgUfS0PcYzvb/Et5DgDqTymYnBXgaLycM
        S07qXw0y0EeLE5vxeluv5LHMytYqVp4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-GyIYjMJjOQGhhxP4u8bEPg-1; Thu, 06 May 2021 19:25:42 -0400
X-MC-Unique: GyIYjMJjOQGhhxP4u8bEPg-1
Received: by mail-qt1-f197.google.com with SMTP id y10-20020a05622a004ab029019d4ad3437cso4580053qtw.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 May 2021 16:25:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T2/Kp/6DMcvb66SGLUrQ0litwe4gG/CMDxNGXzk5jHI=;
        b=i/W8u3PF/PNfRNGJmK8lRk9eKNmAQ6hX+D4FeR06w2CJjzWUFYQxg0L0H/FUu+Xl4e
         05mTW2SrTQeRic5A7aFkj1SVMJ7vu2ZOxQCO20enQSZ+QI0TwoLXntLPQUK43SV7nz2p
         /OBZdRGRNpWg5ub67SWUjR1thpKmqT3MlgC2jbc/5IVT1iACGkfLf7UnkdhB9ZnQmXvf
         xW7zvlLsKm4Q9oZR9uzuSGKowcffKuSEX8NDnj4IUi/1OL02k1biMeQdfPrQh7yuIJHP
         myLTknKvZcaV/sFjIqCQwKVg40FKqah1YEn24vj6MAfzY4c+8/eUSuhvJT+mtD9kqd1Q
         PIsA==
X-Gm-Message-State: AOAM531sFL3B5yWTbA6vqwvi/6sfb+mQwsJC7r/xM/7pjR1K+8WVRp2e
        Z730wNBUeYBidoXf5JBn2q1/LrhhiAgafNZ7OSDvrvXxr/IDo6KVQLSILrhBLwI0kq5bz82jTYR
        VjiPjlXCjxLxV1vMWcTC3sGSq
X-Received: by 2002:ac8:5fd4:: with SMTP id k20mr6521803qta.239.1620343541630;
        Thu, 06 May 2021 16:25:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiu2OYXRhtEUQX7rvGo4YfZRmLbpxFTcAg2tSwrt6j14FGtqU73BnoVhIbOEEpZWoT1F1fFQ==
X-Received: by 2002:ac8:5fd4:: with SMTP id k20mr6521788qta.239.1620343541343;
        Thu, 06 May 2021 16:25:41 -0700 (PDT)
Received: from t490s.redhat.com (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id q13sm1605026qkn.10.2021.05.06.16.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 16:25:40 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Michal Hocko <mhocko@suse.com>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [PATCH 1/3] mm/gup_benchmark: Support threading
Date:   Thu,  6 May 2021 19:25:35 -0400
Message-Id: <20210506232537.165788-2-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210506232537.165788-1-peterx@redhat.com>
References: <20210506232537.165788-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a new parameter "-j N" to support concurrent gup test.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/gup_test.c | 94 ++++++++++++++++++---------
 1 file changed, 63 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/vm/gup_test.c b/tools/testing/selftests/vm/gup_test.c
index 1e662d59c502a..3f0fcc697c3fc 100644
--- a/tools/testing/selftests/vm/gup_test.c
+++ b/tools/testing/selftests/vm/gup_test.c
@@ -6,6 +6,7 @@
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/types.h>
+#include <pthread.h>
 #include "../../../../mm/gup_test.h"
 
 #define MB (1UL << 20)
@@ -15,6 +16,12 @@
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
@@ -34,17 +41,55 @@ static char *cmd_to_str(unsigned long cmd)
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
+	int filed, i, opt, nr_pages = 1, thp = -1, write = 1, threads = 1;
 	int flags = MAP_PRIVATE, touch = 0;
 	char *file = "/dev/zero";
+	pthread_t *tid;
 	char *p;
 
-	while ((opt = getopt(argc, argv, "m:r:n:F:f:abctTLUuwWSHpz")) != -1) {
+	while ((opt = getopt(argc, argv, "m:r:n:F:f:abcj:tTLUuwWSHpz")) != -1) {
 		switch (opt) {
 		case 'a':
 			cmd = PIN_FAST_BENCHMARK;
@@ -74,6 +119,9 @@ int main(int argc, char **argv)
 			/* strtol, so you can pass flags in hex form */
 			gup.gup_flags = strtol(optarg, 0, 0);
 			break;
+		case 'j':
+			threads = atoi(optarg);
+			break;
 		case 'm':
 			size = atoi(optarg) * MB;
 			break;
@@ -154,8 +202,8 @@ int main(int argc, char **argv)
 	if (write)
 		gup.gup_flags |= FOLL_WRITE;
 
-	fd = open("/sys/kernel/debug/gup_test", O_RDWR);
-	if (fd == -1) {
+	gup_fd = open("/sys/kernel/debug/gup_test", O_RDWR);
+	if (gup_fd == -1) {
 		perror("open");
 		exit(1);
 	}
@@ -185,32 +233,16 @@ int main(int argc, char **argv)
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
+	tid = malloc(sizeof(pthread_t) * threads);
+	if (!tid) {
+		perror("malloc()");
+		exit(1);
 	}
+	for (i = 0; i < threads; i++)
+		pthread_create(&tid[i], NULL, gup_thread, &gup);
+	for (i = 0; i < threads; i++)
+		pthread_join(tid[i], NULL);
+	free(tid);
 
 	return 0;
 }
-- 
2.31.1

