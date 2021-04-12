Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F0F235D3F8
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 01:31:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344174AbhDLX21 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Apr 2021 19:28:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36535 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344157AbhDLX20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Apr 2021 19:28:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618270087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BIlUvHrSpn5Lb9pAOjajK4yBauPRJvKURvgmPYRmI9U=;
        b=EVwrnIGuISKh4H81MYxa7AT1TAxrwkSqVoV9jFCM44tIaDEdmQ+m2nGexdY2dVnp5DU8q8
        PdxQSe2FnIn5hnft/8a/yx5g8WzQfLqIPmJUwkupmXRht+V2WtGbEJwKGYHeKlnmFbjBeN
        EiCvqLos+CQQBftgVk/CqTT+w7HwdTs=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-511-_hEjnrhCPd6o6YHdguGQFw-1; Mon, 12 Apr 2021 19:28:06 -0400
X-MC-Unique: _hEjnrhCPd6o6YHdguGQFw-1
Received: by mail-qv1-f69.google.com with SMTP id n3so9006412qvr.8
        for <linux-kernel@vger.kernel.org>; Mon, 12 Apr 2021 16:28:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BIlUvHrSpn5Lb9pAOjajK4yBauPRJvKURvgmPYRmI9U=;
        b=oUPw+P0/zeCp13nXig0tOYjw7YyCKVEwvkV85qTexfaJFNRPdpxfZEx/lg8xdn3PNs
         f8h3+D4oAfgo7HSKeIlI0A1RKF46zqLtEhNLIDsC8rh1FsGGwy10KTNdfHOp80J1VOCB
         kGpU3DQtMt7b2gSh5MIbwR/VpjKTcxUPRd72GfNBPH59SeKAuW8FVJDdNCv31lkHzx3h
         Z3OAqGuewMyHaejOO6hpqH6C4nqosE4wOYh5nUAUkX/VV5naDJNewZbpgZtcDdcUSJz6
         i1E0vyu1pmfI3X6RHOyu/EI3z86ZEjp5dyK/zsrA9o4OrdQPLe/XEEKdtrkzHUAp8/z+
         o/fg==
X-Gm-Message-State: AOAM532V0+EcJuIibbjnqf9LSuRS4AlzZwG0vfQEf8rRfcUUrNuZJCgd
        /V8htpQKv6lEO7PfYWnsFs8q6HLi6Yq7Uj+LyBYCj7RdXwBPVbFNS27WOGoKMM5QFLmZnA6IcCH
        n5obv00scaN+HNRTXFsi6lIKI
X-Received: by 2002:a05:6214:20e9:: with SMTP id 9mr29562362qvk.36.1618270084634;
        Mon, 12 Apr 2021 16:28:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLcGWN5a0nCYPjy8ijR51JC6ki/iJj8NH+LPRfP33rK0sQmOdOvtDicXdxvh/zhCNhBza65g==
X-Received: by 2002:a05:6214:20e9:: with SMTP id 9mr29562330qvk.36.1618270084107;
        Mon, 12 Apr 2021 16:28:04 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-88-174-93-75-154.dsl.bell.ca. [174.93.75.154])
        by smtp.gmail.com with ESMTPSA id y29sm8958925qtm.13.2021.04.12.16.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 16:28:02 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v2 5/5] userfaultfd/selftests: Unify error handling
Date:   Mon, 12 Apr 2021 19:27:53 -0400
Message-Id: <20210412232753.1012412-6-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210412232753.1012412-1-peterx@redhat.com>
References: <20210412232753.1012412-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce err()/_err() and replace all the different ways to fail the program,
mostly "fprintf" and "perror" with tons of exit() calls. Always stop the test
program at any failure.

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 556 ++++++++---------------
 1 file changed, 187 insertions(+), 369 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index da2374bda5a3..6339aeaeeff8 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -140,11 +140,18 @@ static void usage(void)
 	exit(1);
 }
 
-#define uffd_error(code, fmt, ...)                                             \
-	do {                                                                   \
-		fprintf(stderr, fmt, ##__VA_ARGS__);                           \
-		fprintf(stderr, ": %" PRId64 "\n", (int64_t)(code));           \
-		exit(1);                                                       \
+#define _err(fmt, ...)						\
+	do {							\
+		int ret = errno;				\
+		fprintf(stderr, "ERROR: " fmt, ##__VA_ARGS__);	\
+		fprintf(stderr, " (errno=%d, line=%d)\n",	\
+			ret, __LINE__);				\
+	} while (0)
+
+#define err(fmt, ...)				\
+	do {					\
+		_err(fmt, ##__VA_ARGS__);	\
+		exit(1);			\
 	} while (0)
 
 static void uffd_stats_reset(struct uffd_stats *uffd_stats,
@@ -193,44 +200,28 @@ static void uffd_stats_report(struct uffd_stats *stats, int n_cpus)
 	printf("\n");
 }
 
-static int anon_release_pages(char *rel_area)
+static void anon_release_pages(char *rel_area)
 {
-	int ret = 0;
-
-	if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED)) {
-		perror("madvise");
-		ret = 1;
-	}
-
-	return ret;
+	if (madvise(rel_area, nr_pages * page_size, MADV_DONTNEED))
+		err("madvise(MADV_DONTNEED) failed");
 }
 
 static void anon_allocate_area(void **alloc_area)
 {
-	if (posix_memalign(alloc_area, page_size, nr_pages * page_size)) {
-		fprintf(stderr, "out of memory\n");
-		*alloc_area = NULL;
-	}
+	if (posix_memalign(alloc_area, page_size, nr_pages * page_size))
+		err("posix_memalign() failed");
 }
 
 static void noop_alias_mapping(__u64 *start, size_t len, unsigned long offset)
 {
 }
 
-/* HugeTLB memory */
-static int hugetlb_release_pages(char *rel_area)
+static void hugetlb_release_pages(char *rel_area)
 {
-	int ret = 0;
-
 	if (fallocate(huge_fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
-				rel_area == huge_fd_off0 ? 0 :
-				nr_pages * page_size,
-				nr_pages * page_size)) {
-		perror("fallocate");
-		ret = 1;
-	}
-
-	return ret;
+		      rel_area == huge_fd_off0 ? 0 : nr_pages * page_size,
+		      nr_pages * page_size))
+		err("fallocate() failed");
 }
 
 static void hugetlb_allocate_area(void **alloc_area)
@@ -243,20 +234,16 @@ static void hugetlb_allocate_area(void **alloc_area)
 			   MAP_HUGETLB,
 			   huge_fd, *alloc_area == area_src ? 0 :
 			   nr_pages * page_size);
-	if (*alloc_area == MAP_FAILED) {
-		perror("mmap of hugetlbfs file failed");
-		goto fail;
-	}
+	if (*alloc_area == MAP_FAILED)
+		err("mmap of hugetlbfs file failed");
 
 	if (map_shared) {
 		area_alias = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 				  MAP_SHARED | MAP_HUGETLB,
 				  huge_fd, *alloc_area == area_src ? 0 :
 				  nr_pages * page_size);
-		if (area_alias == MAP_FAILED) {
-			perror("mmap of hugetlb file alias failed");
-			goto fail_munmap;
-		}
+		if (area_alias == MAP_FAILED)
+			err("mmap of hugetlb file alias failed");
 	}
 
 	if (*alloc_area == area_src) {
@@ -267,16 +254,6 @@ static void hugetlb_allocate_area(void **alloc_area)
 	}
 	if (area_alias)
 		*alloc_area_alias = area_alias;
-
-	return;
-
-fail_munmap:
-	if (munmap(*alloc_area, nr_pages * page_size) < 0) {
-		perror("hugetlb munmap");
-		exit(1);
-	}
-fail:
-	*alloc_area = NULL;
 }
 
 static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset)
@@ -292,33 +269,24 @@ static void hugetlb_alias_mapping(__u64 *start, size_t len, unsigned long offset
 	*start = (unsigned long) area_dst_alias + offset;
 }
 
-/* Shared memory */
-static int shmem_release_pages(char *rel_area)
+static void shmem_release_pages(char *rel_area)
 {
-	int ret = 0;
-
-	if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE)) {
-		perror("madvise");
-		ret = 1;
-	}
-
-	return ret;
+	if (madvise(rel_area, nr_pages * page_size, MADV_REMOVE))
+		err("madvise(MADV_REMOVE) failed");
 }
 
 static void shmem_allocate_area(void **alloc_area)
 {
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
 			   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
-	if (*alloc_area == MAP_FAILED) {
-		fprintf(stderr, "shared memory mmap failed\n");
-		*alloc_area = NULL;
-	}
+	if (*alloc_area == MAP_FAILED)
+		err("mmap of memfd failed");
 }
 
 struct uffd_test_ops {
 	unsigned long expected_ioctls;
 	void (*allocate_area)(void **alloc_area);
-	int (*release_pages)(char *rel_area);
+	void (*release_pages)(char *rel_area);
 	void (*alias_mapping)(__u64 *start, size_t len, unsigned long offset);
 };
 
@@ -373,11 +341,8 @@ static void wp_range(int ufd, __u64 start, __u64 len, bool wp)
 	/* Undo write-protect, do wakeup after that */
 	prms.mode = wp ? UFFDIO_WRITEPROTECT_MODE_WP : 0;
 
-	if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms)) {
-		fprintf(stderr, "clear WP failed for address 0x%" PRIx64 "\n",
-			(uint64_t)start);
-		exit(1);
-	}
+	if (ioctl(ufd, UFFDIO_WRITEPROTECT, &prms))
+		err("clear WP failed: address=0x%"PRIx64, (uint64_t)start);
 }
 
 static void continue_range(int ufd, __u64 start, __u64 len)
@@ -388,12 +353,9 @@ static void continue_range(int ufd, __u64 start, __u64 len)
 	req.range.len = len;
 	req.mode = 0;
 
-	if (ioctl(ufd, UFFDIO_CONTINUE, &req)) {
-		fprintf(stderr,
-			"UFFDIO_CONTINUE failed for address 0x%" PRIx64 "\n",
-			(uint64_t)start);
-		exit(1);
-	}
+	if (ioctl(ufd, UFFDIO_CONTINUE, &req))
+		err("UFFDIO_CONTINUE failed for address 0x%" PRIx64,
+		    (uint64_t)start);
 }
 
 static void *locking_thread(void *arg)
@@ -412,10 +374,8 @@ static void *locking_thread(void *arg)
 			seed += cpu;
 		bzero(&rand, sizeof(rand));
 		bzero(&randstate, sizeof(randstate));
-		if (initstate_r(seed, randstate, sizeof(randstate), &rand)) {
-			fprintf(stderr, "srandom_r error\n");
-			exit(1);
-		}
+		if (initstate_r(seed, randstate, sizeof(randstate), &rand))
+			err("initstate_r failed");
 	} else {
 		page_nr = -bounces;
 		if (!(bounces & BOUNCE_RACINGFAULTS))
@@ -424,16 +384,12 @@ static void *locking_thread(void *arg)
 
 	while (!finished) {
 		if (bounces & BOUNCE_RANDOM) {
-			if (random_r(&rand, &rand_nr)) {
-				fprintf(stderr, "random_r 1 error\n");
-				exit(1);
-			}
+			if (random_r(&rand, &rand_nr))
+				err("random_r failed");
 			page_nr = rand_nr;
 			if (sizeof(page_nr) > sizeof(rand_nr)) {
-				if (random_r(&rand, &rand_nr)) {
-					fprintf(stderr, "random_r 2 error\n");
-					exit(1);
-				}
+				if (random_r(&rand, &rand_nr))
+					err("random_r failed");
 				page_nr |= (((unsigned long) rand_nr) << 16) <<
 					   16;
 			}
@@ -442,12 +398,9 @@ static void *locking_thread(void *arg)
 		page_nr %= nr_pages;
 		pthread_mutex_lock(area_mutex(area_dst, page_nr));
 		count = *area_count(area_dst, page_nr);
-		if (count != count_verify[page_nr]) {
-			fprintf(stderr,
-				"page_nr %lu memory corruption %Lu %Lu\n",
-				page_nr, count,
-				count_verify[page_nr]); exit(1);
-		}
+		if (count != count_verify[page_nr])
+			err("page_nr %lu memory corruption %llu %llu",
+			    page_nr, count, count_verify[page_nr]);
 		count++;
 		*area_count(area_dst, page_nr) = count_verify[page_nr] = count;
 		pthread_mutex_unlock(area_mutex(area_dst, page_nr));
@@ -464,22 +417,21 @@ static void retry_copy_page(int ufd, struct uffdio_copy *uffdio_copy,
 				     offset);
 	if (ioctl(ufd, UFFDIO_COPY, uffdio_copy)) {
 		/* real retval in ufdio_copy.copy */
-		if (uffdio_copy->copy != -EEXIST) {
-			uffd_error(uffdio_copy->copy,
-				   "UFFDIO_COPY retry error");
-		}
-	} else
-		uffd_error(uffdio_copy->copy, "UFFDIO_COPY retry unexpected");
+		if (uffdio_copy->copy != -EEXIST)
+			err("UFFDIO_COPY retry error: %"PRId64,
+			    (int64_t)uffdio_copy->copy);
+	} else {
+		err("UFFDIO_COPY retry unexpected: %"PRId64,
+		    (int64_t)uffdio_copy->copy);
+	}
 }
 
 static int __copy_page(int ufd, unsigned long offset, bool retry)
 {
 	struct uffdio_copy uffdio_copy;
 
-	if (offset >= nr_pages * page_size) {
-		fprintf(stderr, "unexpected offset %lu\n", offset);
-		exit(1);
-	}
+	if (offset >= nr_pages * page_size)
+		err("unexpected offset %lu\n", offset);
 	uffdio_copy.dst = (unsigned long) area_dst + offset;
 	uffdio_copy.src = (unsigned long) area_src + offset;
 	uffdio_copy.len = page_size;
@@ -491,9 +443,10 @@ static int __copy_page(int ufd, unsigned long offset, bool retry)
 	if (ioctl(ufd, UFFDIO_COPY, &uffdio_copy)) {
 		/* real retval in ufdio_copy.copy */
 		if (uffdio_copy.copy != -EEXIST)
-			uffd_error(uffdio_copy.copy, "UFFDIO_COPY error");
+			err("UFFDIO_COPY error: %"PRId64,
+			    (int64_t)uffdio_copy.copy);
 	} else if (uffdio_copy.copy != page_size) {
-		uffd_error(uffdio_copy.copy, "UFFDIO_COPY unexpected copy");
+		err("UFFDIO_COPY error: %"PRId64, (int64_t)uffdio_copy.copy);
 	} else {
 		if (test_uffdio_copy_eexist && retry) {
 			test_uffdio_copy_eexist = false;
@@ -522,11 +475,10 @@ static int uffd_read_msg(int ufd, struct uffd_msg *msg)
 		if (ret < 0) {
 			if (errno == EAGAIN)
 				return 1;
-			perror("blocking read error");
+			err("blocking read error");
 		} else {
-			fprintf(stderr, "short read\n");
+			err("short read");
 		}
-		exit(1);
 	}
 
 	return 0;
@@ -537,10 +489,8 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
 {
 	unsigned long offset;
 
-	if (msg->event != UFFD_EVENT_PAGEFAULT) {
-		fprintf(stderr, "unexpected msg event %u\n", msg->event);
-		exit(1);
-	}
+	if (msg->event != UFFD_EVENT_PAGEFAULT)
+		err("unexpected msg event %u", msg->event);
 
 	if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WP) {
 		/* Write protect page faults */
@@ -571,10 +521,8 @@ static void uffd_handle_page_fault(struct uffd_msg *msg,
 		stats->minor_faults++;
 	} else {
 		/* Missing page faults */
-		if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE) {
-			fprintf(stderr, "unexpected write fault\n");
-			exit(1);
-		}
+		if (msg->arg.pagefault.flags & UFFD_PAGEFAULT_FLAG_WRITE)
+			err("unexpected write fault");
 
 		offset = (char *)(unsigned long)msg->arg.pagefault.address - area_dst;
 		offset &= ~(page_size-1);
@@ -601,32 +549,20 @@ static void *uffd_poll_thread(void *arg)
 
 	for (;;) {
 		ret = poll(pollfd, 2, -1);
-		if (!ret) {
-			fprintf(stderr, "poll error %d\n", ret);
-			exit(1);
-		}
-		if (ret < 0) {
-			perror("poll");
-			exit(1);
-		}
+		if (ret <= 0)
+			err("poll error: %d", ret);
 		if (pollfd[1].revents & POLLIN) {
-			if (read(pollfd[1].fd, &tmp_chr, 1) != 1) {
-				fprintf(stderr, "read pipefd error\n");
-				exit(1);
-			}
+			if (read(pollfd[1].fd, &tmp_chr, 1) != 1)
+				err("read pipefd error");
 			break;
 		}
-		if (!(pollfd[0].revents & POLLIN)) {
-			fprintf(stderr, "pollfd[0].revents %d\n",
-				pollfd[0].revents);
-			exit(1);
-		}
+		if (!(pollfd[0].revents & POLLIN))
+			err("pollfd[0].revents %d", pollfd[0].revents);
 		if (uffd_read_msg(uffd, &msg))
 			continue;
 		switch (msg.event) {
 		default:
-			fprintf(stderr, "unexpected msg event %u\n",
-				msg.event); exit(1);
+			err("unexpected msg event %u\n", msg.event);
 			break;
 		case UFFD_EVENT_PAGEFAULT:
 			uffd_handle_page_fault(&msg, stats);
@@ -640,10 +576,8 @@ static void *uffd_poll_thread(void *arg)
 			uffd_reg.range.start = msg.arg.remove.start;
 			uffd_reg.range.len = msg.arg.remove.end -
 				msg.arg.remove.start;
-			if (ioctl(uffd, UFFDIO_UNREGISTER, &uffd_reg.range)) {
-				fprintf(stderr, "remove failure\n");
-				exit(1);
-			}
+			if (ioctl(uffd, UFFDIO_UNREGISTER, &uffd_reg.range))
+				err("remove failure");
 			break;
 		case UFFD_EVENT_REMAP:
 			area_dst = (char *)(unsigned long)msg.arg.remap.to;
@@ -746,9 +680,7 @@ static int stress(struct uffd_stats *uffd_stats)
 	 * UFFDIO_COPY without writing zero pages into area_dst
 	 * because the background threads already completed).
 	 */
-	if (uffd_test_ops->release_pages(area_src))
-		return 1;
-
+	uffd_test_ops->release_pages(area_src);
 
 	finished = 1;
 	for (cpu = 0; cpu < nr_cpus; cpu++)
@@ -758,10 +690,8 @@ static int stress(struct uffd_stats *uffd_stats)
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		char c;
 		if (bounces & BOUNCE_POLL) {
-			if (write(pipefd[cpu*2+1], &c, 1) != 1) {
-				fprintf(stderr, "pipefd write error\n");
-				return 1;
-			}
+			if (write(pipefd[cpu*2+1], &c, 1) != 1)
+				err("pipefd write error");
 			if (pthread_join(uffd_threads[cpu],
 					 (void *)&uffd_stats[cpu]))
 				return 1;
@@ -861,10 +791,8 @@ static int faulting_process(int signal_test)
 		memset(&act, 0, sizeof(act));
 		act.sa_sigaction = sighndl;
 		act.sa_flags = SA_SIGINFO;
-		if (sigaction(SIGBUS, &act, 0)) {
-			perror("sigaction");
-			return 1;
-		}
+		if (sigaction(SIGBUS, &act, 0))
+			err("sigaction");
 		lastnr = (unsigned long)-1;
 	}
 
@@ -874,10 +802,8 @@ static int faulting_process(int signal_test)
 
 		if (signal_test) {
 			if (sigsetjmp(*sigbuf, 1) != 0) {
-				if (steps == 1 && nr == lastnr) {
-					fprintf(stderr, "Signal repeated\n");
-					return 1;
-				}
+				if (steps == 1 && nr == lastnr)
+					err("Signal repeated");
 
 				lastnr = nr;
 				if (signal_test == 1) {
@@ -902,12 +828,9 @@ static int faulting_process(int signal_test)
 		}
 
 		count = *area_count(area_dst, nr);
-		if (count != count_verify[nr]) {
-			fprintf(stderr,
-				"nr %lu memory corruption %Lu %Lu\n",
-				nr, count,
-				count_verify[nr]);
-	        }
+		if (count != count_verify[nr])
+			err("nr %lu memory corruption %llu %llu\n",
+			    nr, count, count_verify[nr]);
 		/*
 		 * Trigger write protection if there is by writing
 		 * the same value back.
@@ -923,18 +846,14 @@ static int faulting_process(int signal_test)
 
 	area_dst = mremap(area_dst, nr_pages * page_size,  nr_pages * page_size,
 			  MREMAP_MAYMOVE | MREMAP_FIXED, area_src);
-	if (area_dst == MAP_FAILED) {
-		perror("mremap");
-		exit(1);
-	}
+	if (area_dst == MAP_FAILED)
+		err("mremap");
 
 	for (; nr < nr_pages; nr++) {
 		count = *area_count(area_dst, nr);
 		if (count != count_verify[nr]) {
-			fprintf(stderr,
-				"nr %lu memory corruption %Lu %Lu\n",
-				nr, count,
-				count_verify[nr]); exit(1);
+			err("nr %lu memory corruption %llu %llu\n",
+			    nr, count, count_verify[nr]);
 		}
 		/*
 		 * Trigger write protection if there is by writing
@@ -943,15 +862,11 @@ static int faulting_process(int signal_test)
 		*area_count(area_dst, nr) = count;
 	}
 
-	if (uffd_test_ops->release_pages(area_dst))
-		return 1;
+	uffd_test_ops->release_pages(area_dst);
 
-	for (nr = 0; nr < nr_pages; nr++) {
-		if (my_bcmp(area_dst + nr * page_size, zeropage, page_size)) {
-			fprintf(stderr, "nr %lu is not zero\n", nr);
-			exit(1);
-		}
-	}
+	for (nr = 0; nr < nr_pages; nr++)
+		if (my_bcmp(area_dst + nr * page_size, zeropage, page_size))
+			err("nr %lu is not zero", nr);
 
 	return 0;
 }
@@ -964,13 +879,12 @@ static void retry_uffdio_zeropage(int ufd,
 				     uffdio_zeropage->range.len,
 				     offset);
 	if (ioctl(ufd, UFFDIO_ZEROPAGE, uffdio_zeropage)) {
-		if (uffdio_zeropage->zeropage != -EEXIST) {
-			uffd_error(uffdio_zeropage->zeropage,
-				   "UFFDIO_ZEROPAGE retry error");
-		}
+		if (uffdio_zeropage->zeropage != -EEXIST)
+			err("UFFDIO_ZEROPAGE error: %"PRId64,
+			    (int64_t)uffdio_zeropage->zeropage);
 	} else {
-		uffd_error(uffdio_zeropage->zeropage,
-			   "UFFDIO_ZEROPAGE retry unexpected");
+		err("UFFDIO_ZEROPAGE error: %"PRId64,
+		    (int64_t)uffdio_zeropage->zeropage);
 	}
 }
 
@@ -983,10 +897,8 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 
 	has_zeropage = uffd_test_ops->expected_ioctls & (1 << _UFFDIO_ZEROPAGE);
 
-	if (offset >= nr_pages * page_size) {
-		fprintf(stderr, "unexpected offset %lu\n", offset);
-		exit(1);
-	}
+	if (offset >= nr_pages * page_size)
+		err("unexpected offset %lu", offset);
 	uffdio_zeropage.range.start = (unsigned long) area_dst + offset;
 	uffdio_zeropage.range.len = page_size;
 	uffdio_zeropage.mode = 0;
@@ -994,14 +906,13 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 	res = uffdio_zeropage.zeropage;
 	if (ret) {
 		/* real retval in ufdio_zeropage.zeropage */
-		if (has_zeropage) {
-			uffd_error(res, "UFFDIO_ZEROPAGE %s",
-				   res == -EEXIST ? "-EEXIST" : "error");
-		} else if (res != -EINVAL)
-			uffd_error(res, "UFFDIO_ZEROPAGE not -EINVAL");
+		if (has_zeropage)
+			err("UFFDIO_ZEROPAGE error: %"PRId64, (int64_t)res);
+		else if (res != -EINVAL)
+			err("UFFDIO_ZEROPAGE not -EINVAL");
 	} else if (has_zeropage) {
 		if (res != page_size) {
-			uffd_error(res, "UFFDIO_ZEROPAGE unexpected");
+			err("UFFDIO_ZEROPAGE unexpected size");
 		} else {
 			if (test_uffdio_zeropage_eexist && retry) {
 				test_uffdio_zeropage_eexist = false;
@@ -1011,7 +922,7 @@ static int __uffdio_zeropage(int ufd, unsigned long offset, bool retry)
 			return 1;
 		}
 	} else
-		uffd_error(res, "UFFDIO_ZEROPAGE succeeded");
+		err("UFFDIO_ZEROPAGE succeeded");
 
 	return 0;
 }
@@ -1030,8 +941,7 @@ static int userfaultfd_zeropage_test(void)
 	printf("testing UFFDIO_ZEROPAGE: ");
 	fflush(stdout);
 
-	if (uffd_test_ops->release_pages(area_dst))
-		return 1;
+	uffd_test_ops->release_pages(area_dst);
 
 	if (userfaultfd_open(0))
 		return 1;
@@ -1040,25 +950,16 @@ static int userfaultfd_zeropage_test(void)
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
 	if (test_uffdio_wp)
 		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
-		fprintf(stderr, "register failure\n");
-		exit(1);
-	}
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+		err("register failure");
 
 	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) !=
-	    expected_ioctls) {
-		fprintf(stderr,
-			"unexpected missing ioctl for anon memory\n");
-		exit(1);
-	}
+	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls)
+		err("unexpected missing ioctl for anon memory");
 
-	if (uffdio_zeropage(uffd, 0)) {
-		if (my_bcmp(area_dst, zeropage, page_size)) {
-			fprintf(stderr, "zeropage is not zero\n");
-			exit(1);
-		}
-	}
+	if (uffdio_zeropage(uffd, 0))
+		if (my_bcmp(area_dst, zeropage, page_size))
+			err("zeropage is not zero");
 
 	close(uffd);
 	printf("done.\n");
@@ -1078,8 +979,7 @@ static int userfaultfd_events_test(void)
 	printf("testing events (fork, remap, remove): ");
 	fflush(stdout);
 
-	if (uffd_test_ops->release_pages(area_dst))
-		return 1;
+	uffd_test_ops->release_pages(area_dst);
 
 	features = UFFD_FEATURE_EVENT_FORK | UFFD_FEATURE_EVENT_REMAP |
 		UFFD_FEATURE_EVENT_REMOVE;
@@ -1092,41 +992,28 @@ static int userfaultfd_events_test(void)
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
 	if (test_uffdio_wp)
 		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
-		fprintf(stderr, "register failure\n");
-		exit(1);
-	}
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+		err("register failure");
 
 	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls) {
-		fprintf(stderr, "unexpected missing ioctl for anon memory\n");
-		exit(1);
-	}
+	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls)
+		err("unexpected missing ioctl for anon memory");
 
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats)) {
-		perror("uffd_poll_thread create");
-		exit(1);
-	}
+	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
+		err("uffd_poll_thread create");
 
 	pid = fork();
-	if (pid < 0) {
-		perror("fork");
-		exit(1);
-	}
+	if (pid < 0)
+		err("fork");
 
 	if (!pid)
 		exit(faulting_process(0));
 
 	waitpid(pid, &err, 0);
-	if (err) {
-		fprintf(stderr, "faulting process failed\n");
-		exit(1);
-	}
-
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c)) {
-		perror("pipe write");
-		exit(1);
-	}
+	if (err)
+		err("faulting process failed");
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+		err("pipe write");
 	if (pthread_join(uffd_mon, NULL))
 		return 1;
 
@@ -1151,8 +1038,7 @@ static int userfaultfd_sig_test(void)
 	printf("testing signal delivery: ");
 	fflush(stdout);
 
-	if (uffd_test_ops->release_pages(area_dst))
-		return 1;
+	uffd_test_ops->release_pages(area_dst);
 
 	features = UFFD_FEATURE_EVENT_FORK|UFFD_FEATURE_SIGBUS;
 	if (userfaultfd_open(features))
@@ -1164,57 +1050,41 @@ static int userfaultfd_sig_test(void)
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
 	if (test_uffdio_wp)
 		uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
-		fprintf(stderr, "register failure\n");
-		exit(1);
-	}
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+		err("register failure");
 
 	expected_ioctls = uffd_test_ops->expected_ioctls;
-	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls) {
-		fprintf(stderr, "unexpected missing ioctl for anon memory\n");
-		exit(1);
-	}
+	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls)
+		err("unexpected missing ioctl for anon memory");
 
-	if (faulting_process(1)) {
-		fprintf(stderr, "faulting process failed\n");
-		exit(1);
-	}
+	if (faulting_process(1))
+		err("faulting process failed");
 
-	if (uffd_test_ops->release_pages(area_dst))
-		return 1;
+	uffd_test_ops->release_pages(area_dst);
 
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats)) {
-		perror("uffd_poll_thread create");
-		exit(1);
-	}
+	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
+		err("uffd_poll_thread create");
 
 	pid = fork();
-	if (pid < 0) {
-		perror("fork");
-		exit(1);
-	}
+	if (pid < 0)
+		err("fork");
 
 	if (!pid)
 		exit(faulting_process(2));
 
 	waitpid(pid, &err, 0);
-	if (err) {
-		fprintf(stderr, "faulting process failed\n");
-		exit(1);
-	}
-
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c)) {
-		perror("pipe write");
-		exit(1);
-	}
+	if (err)
+		err("faulting process failed");
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+		err("pipe write");
 	if (pthread_join(uffd_mon, (void **)&userfaults))
 		return 1;
 
 	printf("done.\n");
 	if (userfaults)
-		fprintf(stderr, "Signal test failed, userfaults: %ld\n",
-			userfaults);
+		err("Signal test failed, userfaults: %ld", userfaults);
 	close(uffd);
+
 	return userfaults != 0;
 }
 
@@ -1236,8 +1106,7 @@ static int userfaultfd_minor_test(void)
 	printf("testing minor faults: ");
 	fflush(stdout);
 
-	if (uffd_test_ops->release_pages(area_dst))
-		return 1;
+	uffd_test_ops->release_pages(area_dst);
 
 	if (userfaultfd_open_ext(&features))
 		return 1;
@@ -1251,17 +1120,13 @@ static int userfaultfd_minor_test(void)
 	uffdio_register.range.start = (unsigned long)area_dst_alias;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_MINOR;
-	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
-		fprintf(stderr, "register failure\n");
-		exit(1);
-	}
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+		err("register failure");
 
 	expected_ioctls = uffd_test_ops->expected_ioctls;
 	expected_ioctls |= 1 << _UFFDIO_CONTINUE;
-	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls) {
-		fprintf(stderr, "unexpected missing ioctl(s)\n");
-		exit(1);
-	}
+	if ((uffdio_register.ioctls & expected_ioctls) != expected_ioctls)
+		err("unexpected missing ioctl(s)");
 
 	/*
 	 * After registering with UFFD, populate the non-UFFD-registered side of
@@ -1272,10 +1137,8 @@ static int userfaultfd_minor_test(void)
 		       page_size);
 	}
 
-	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats)) {
-		perror("uffd_poll_thread create");
-		exit(1);
-	}
+	if (pthread_create(&uffd_mon, &attr, uffd_poll_thread, &stats))
+		err("uffd_poll_thread create");
 
 	/*
 	 * Read each of the pages back using the UFFD-registered mapping. We
@@ -1284,26 +1147,19 @@ static int userfaultfd_minor_test(void)
 	 * page's contents, and then issuing a CONTINUE ioctl.
 	 */
 
-	if (posix_memalign(&expected_page, page_size, page_size)) {
-		fprintf(stderr, "out of memory\n");
-		return 1;
-	}
+	if (posix_memalign(&expected_page, page_size, page_size))
+		err("out of memory");
 
 	for (p = 0; p < nr_pages; ++p) {
 		expected_byte = ~((uint8_t)(p % ((uint8_t)-1)));
 		memset(expected_page, expected_byte, page_size);
 		if (my_bcmp(expected_page, area_dst_alias + (p * page_size),
-			    page_size)) {
-			fprintf(stderr,
-				"unexpected page contents after minor fault\n");
-			exit(1);
-		}
+			    page_size))
+			err("unexpected page contents after minor fault");
 	}
 
-	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c)) {
-		perror("pipe write");
-		exit(1);
-	}
+	if (write(pipefd[1], &c, sizeof(c)) != sizeof(c))
+		err("pipe write");
 	if (pthread_join(uffd_mon, NULL))
 		return 1;
 
@@ -1321,7 +1177,6 @@ static int userfaultfd_stress(void)
 	unsigned long nr;
 	struct uffdio_register uffdio_register;
 	unsigned long cpu;
-	int err;
 	struct uffd_stats uffd_stats[nr_cpus];
 
 	uffd_test_ops->allocate_area((void **)&area_src);
@@ -1366,10 +1221,8 @@ static int userfaultfd_stress(void)
 		}
 	}
 
-	if (posix_memalign(&area, page_size, page_size)) {
-		fprintf(stderr, "out of memory\n");
-		return 1;
-	}
+	if (posix_memalign(&area, page_size, page_size))
+		err("out of memory");
 	zeropage = area;
 	bzero(zeropage, page_size);
 
@@ -1378,7 +1231,6 @@ static int userfaultfd_stress(void)
 	pthread_attr_init(&attr);
 	pthread_attr_setstacksize(&attr, 16*1024*1024);
 
-	err = 0;
 	while (bounces--) {
 		unsigned long expected_ioctls;
 
@@ -1407,25 +1259,18 @@ static int userfaultfd_stress(void)
 		uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
 		if (test_uffdio_wp)
 			uffdio_register.mode |= UFFDIO_REGISTER_MODE_WP;
-		if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
-			fprintf(stderr, "register failure\n");
-			return 1;
-		}
+		if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+			err("register failure");
 		expected_ioctls = uffd_test_ops->expected_ioctls;
 		if ((uffdio_register.ioctls & expected_ioctls) !=
-		    expected_ioctls) {
-			fprintf(stderr,
-				"unexpected missing ioctl for anon memory\n");
-			return 1;
-		}
+		    expected_ioctls)
+			err("unexpected missing ioctl for anon memory");
 
 		if (area_dst_alias) {
 			uffdio_register.range.start = (unsigned long)
 				area_dst_alias;
-			if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register)) {
-				fprintf(stderr, "register failure alias\n");
-				return 1;
-			}
+			if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+				err("register failure alias");
 		}
 
 		/*
@@ -1452,8 +1297,7 @@ static int userfaultfd_stress(void)
 		 * MADV_DONTNEED only after the UFFDIO_REGISTER, so it's
 		 * required to MADV_DONTNEED here.
 		 */
-		if (uffd_test_ops->release_pages(area_dst))
-			return 1;
+		uffd_test_ops->release_pages(area_dst);
 
 		uffd_stats_reset(uffd_stats, nr_cpus);
 
@@ -1467,33 +1311,22 @@ static int userfaultfd_stress(void)
 				 nr_pages * page_size, false);
 
 		/* unregister */
-		if (ioctl(uffd, UFFDIO_UNREGISTER, &uffdio_register.range)) {
-			fprintf(stderr, "unregister failure\n");
-			return 1;
-		}
+		if (ioctl(uffd, UFFDIO_UNREGISTER, &uffdio_register.range))
+			err("unregister failure");
 		if (area_dst_alias) {
 			uffdio_register.range.start = (unsigned long) area_dst;
 			if (ioctl(uffd, UFFDIO_UNREGISTER,
-				  &uffdio_register.range)) {
-				fprintf(stderr, "unregister failure alias\n");
-				return 1;
-			}
+				  &uffdio_register.range))
+				err("unregister failure alias");
 		}
 
 		/* verification */
-		if (bounces & BOUNCE_VERIFY) {
-			for (nr = 0; nr < nr_pages; nr++) {
-				if (*area_count(area_dst, nr) != count_verify[nr]) {
-					fprintf(stderr,
-						"error area_count %Lu %Lu %lu\n",
-						*area_count(area_src, nr),
-						count_verify[nr],
-						nr);
-					err = 1;
-					bounces = 0;
-				}
-			}
-		}
+		if (bounces & BOUNCE_VERIFY)
+			for (nr = 0; nr < nr_pages; nr++)
+				if (*area_count(area_dst, nr) != count_verify[nr])
+					err("error area_count %llu %llu %lu\n",
+					    *area_count(area_src, nr),
+					    count_verify[nr], nr);
 
 		/* prepare next bounce */
 		tmp_area = area_src;
@@ -1507,9 +1340,6 @@ static int userfaultfd_stress(void)
 		uffd_stats_report(uffd_stats, nr_cpus);
 	}
 
-	if (err)
-		return err;
-
 	close(uffd);
 	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
 		|| userfaultfd_events_test() || userfaultfd_minor_test();
@@ -1560,7 +1390,7 @@ static void set_test_type(const char *type)
 		test_type = TEST_SHMEM;
 		uffd_test_ops = &shmem_uffd_test_ops;
 	} else {
-		fprintf(stderr, "Unknown test type: %s\n", type); exit(1);
+		err("Unknown test type: %s", type);
 	}
 
 	if (test_type == TEST_HUGETLB)
@@ -1568,15 +1398,11 @@ static void set_test_type(const char *type)
 	else
 		page_size = sysconf(_SC_PAGE_SIZE);
 
-	if (!page_size) {
-		fprintf(stderr, "Unable to determine page size\n");
-		exit(2);
-	}
+	if (!page_size)
+		err("Unable to determine page size");
 	if ((unsigned long) area_count(NULL, 0) + sizeof(unsigned long long) * 2
-	    > page_size) {
-		fprintf(stderr, "Impossible to run this test\n");
-		exit(2);
-	}
+	    > page_size)
+		err("Impossible to run this test");
 }
 
 static void sigalrm(int sig)
@@ -1593,10 +1419,8 @@ int main(int argc, char **argv)
 	if (argc < 4)
 		usage();
 
-	if (signal(SIGALRM, sigalrm) == SIG_ERR) {
-		fprintf(stderr, "failed to arm SIGALRM");
-		exit(1);
-	}
+	if (signal(SIGALRM, sigalrm) == SIG_ERR)
+		err("failed to arm SIGALRM");
 	alarm(ALARM_INTERVAL_SECS);
 
 	set_test_type(argv[1]);
@@ -1605,13 +1429,13 @@ int main(int argc, char **argv)
 	nr_pages_per_cpu = atol(argv[2]) * 1024*1024 / page_size /
 		nr_cpus;
 	if (!nr_pages_per_cpu) {
-		fprintf(stderr, "invalid MiB\n");
+		_err("invalid MiB");
 		usage();
 	}
 
 	bounces = atoi(argv[3]);
 	if (bounces <= 0) {
-		fprintf(stderr, "invalid bounces\n");
+		_err("invalid bounces");
 		usage();
 	}
 	nr_pages = nr_pages_per_cpu * nr_cpus;
@@ -1620,16 +1444,10 @@ int main(int argc, char **argv)
 		if (argc < 5)
 			usage();
 		huge_fd = open(argv[4], O_CREAT | O_RDWR, 0755);
-		if (huge_fd < 0) {
-			fprintf(stderr, "Open of %s failed", argv[3]);
-			perror("open");
-			exit(1);
-		}
-		if (ftruncate(huge_fd, 0)) {
-			fprintf(stderr, "ftruncate %s to size 0 failed", argv[3]);
-			perror("ftruncate");
-			exit(1);
-		}
+		if (huge_fd < 0)
+			err("Open of %s failed", argv[4]);
+		if (ftruncate(huge_fd, 0))
+			err("ftruncate %s to size 0 failed", argv[4]);
 	}
 	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
 	       nr_pages, nr_pages_per_cpu);
-- 
2.26.2

