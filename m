Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E47936E1E3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 01:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240200AbhD1Ww0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Apr 2021 18:52:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45789 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240090AbhD1WwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Apr 2021 18:52:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619650286;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pvGdUvHXhr1/W39+miDgJTu6lUz1WoLUPPok+oPerLQ=;
        b=XlTb4m4FKeMtamtqxwhqt1mcW/97ruDqfrfqXnboehVLiecmy84q+/uM53Y/QGS/2EDZix
        Qit4cCtTnMvJywuoSukqJLnSeVzpTqVDO5GqRel5q3jwKJCk5QWkGvV1zMJHx8tYVOATxB
        jbafAd+NU4HZ/BONiJKOoIlnFH6hCkg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-ExzIh0WxMF6RRc4WD0P_zA-1; Wed, 28 Apr 2021 18:51:24 -0400
X-MC-Unique: ExzIh0WxMF6RRc4WD0P_zA-1
Received: by mail-qv1-f72.google.com with SMTP id el4-20020ad459c40000b029019a47ec7a9dso25549915qvb.21
        for <linux-kernel@vger.kernel.org>; Wed, 28 Apr 2021 15:51:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pvGdUvHXhr1/W39+miDgJTu6lUz1WoLUPPok+oPerLQ=;
        b=oxulFFFC/7K/tfl2VeqokTz/FgSGeG3AstMNiF1boKtAD8kSloPxONmU4CxDApwKq5
         mma/Xmry/kKIWCRFSwm5CsRtXv+fQKkmaRylHRI7mpU/x6WGlnGMe/PDVSWtCSGv4Abs
         wiLGRpZ4w6RnE1C8ABj+kQXJ1dHzbUAJR0QkvbbODmA9sj8olsCKMp8Rzk9T9LLUocG+
         LvSQqhgdfldOqjaShkXdROESHqUYC2pib/mSUE4ht2U8AGgM1TxDr0CRsWUnB3u0Ns5t
         ZfYY3pPsLNJYMMFctGgg9t2gpAVaQtLg6ywt+uFl7BTlp/J05QEA5G9zdEtUWrZlbfCe
         K/6g==
X-Gm-Message-State: AOAM533AyxDiUX3Xtag2wTD4XBB6LyTF6Pm5owDb1zDN4JyQOQcEomCK
        oyxSJJ42KS/RB30kTiuNIRONguy92qP4l+5V/kRbXY1sVVXwCcP2AqPcFhYiLvusqEmOYrUFmAg
        nqFqq4th/HRo7vxIDDHVq/MtL
X-Received: by 2002:a05:620a:74b:: with SMTP id i11mr22108318qki.445.1619650284093;
        Wed, 28 Apr 2021 15:51:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwEgCtCU64i2kK9aQbDrUJjCGfyCMRzR2OuJxyRzNOzWF+EO1/lGcK/SKkGiPz+jvxPbchFA==
X-Received: by 2002:a05:620a:74b:: with SMTP id i11mr22108292qki.445.1619650283835;
        Wed, 28 Apr 2021 15:51:23 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id 191sm897459qkk.31.2021.04.28.15.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 15:51:23 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jerome Glisse <jglisse@redhat.com>
Subject: [PATCH 6/6] userfaultfd/selftests: Add pagemap uffd-wp test
Date:   Wed, 28 Apr 2021 18:50:30 -0400
Message-Id: <20210428225030.9708-7-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210428225030.9708-1-peterx@redhat.com>
References: <20210428225030.9708-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add one anonymous specific test to start using pagemap.  With pagemap support,
we can directly read the uffd-wp bit from pgtable without triggering any fault,
so it's easier to do sanity checks in unit tests.

Meanwhile this test also leverages the newly introduced MADV_PAGEOUT madvise
function to test swap ptes with uffd-wp bit set, and across fork()s.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 154 +++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 6339aeaeeff8b..93eae095b61e6 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -1170,6 +1170,144 @@ static int userfaultfd_minor_test(void)
 	return stats.missing_faults != 0 || stats.minor_faults != nr_pages;
 }
 
+#define BIT_ULL(nr)                   (1ULL << (nr))
+#define PM_SOFT_DIRTY                 BIT_ULL(55)
+#define PM_MMAP_EXCLUSIVE             BIT_ULL(56)
+#define PM_UFFD_WP                    BIT_ULL(57)
+#define PM_FILE                       BIT_ULL(61)
+#define PM_SWAP                       BIT_ULL(62)
+#define PM_PRESENT                    BIT_ULL(63)
+
+static int pagemap_open(void)
+{
+	int fd = open("/proc/self/pagemap", O_RDONLY);
+
+	if (fd < 0)
+		err("open pagemap");
+
+	return fd;
+}
+
+static uint64_t pagemap_read_vaddr(int fd, void *vaddr)
+{
+	uint64_t value;
+	int ret;
+
+	ret = pread(fd, &value, sizeof(uint64_t),
+		    ((uint64_t)vaddr >> 12) * sizeof(uint64_t));
+	if (ret != sizeof(uint64_t))
+		err("pread() on pagemap failed");
+
+	return value;
+}
+
+/* This macro let __LINE__ works in err() */
+#define  pagemap_check_wp(value, wp) do {				\
+		if (!!(value & PM_UFFD_WP) != wp)			\
+			err("pagemap uffd-wp bit error: 0x%"PRIx64, value); \
+	} while (0)
+
+static int pagemap_test_fork(bool present)
+{
+	pid_t child = fork();
+	uint64_t value;
+	int fd, result;
+
+	if (!child) {
+		/* Open the pagemap fd of the child itself */
+		fd = pagemap_open();
+		value = pagemap_read_vaddr(fd, area_dst);
+		/*
+		 * After fork() uffd-wp bit should be gone as long as we're
+		 * without UFFD_FEATURE_EVENT_FORK
+		 */
+		pagemap_check_wp(value, false);
+		/* Succeed */
+		exit(0);
+	}
+	waitpid(child, &result, 0);
+	return result;
+}
+
+static void userfaultfd_pagemap_test(unsigned int test_pgsize)
+{
+	struct uffdio_register uffdio_register;
+	int pagemap_fd;
+	uint64_t value;
+
+	/* Pagemap tests uffd-wp only */
+	if (!test_uffdio_wp)
+		return;
+
+	/* Not enough memory to test this page size */
+	if (test_pgsize > nr_pages * page_size)
+		return;
+
+	printf("testing uffd-wp with pagemap (pgsize=%u): ", test_pgsize);
+	/* Flush so it doesn't flush twice in parent/child later */
+	fflush(stdout);
+
+	uffd_test_ops->release_pages(area_dst);
+
+	if (test_pgsize > page_size) {
+		/* This is a thp test */
+		if (madvise(area_dst, nr_pages * page_size, MADV_HUGEPAGE))
+			err("madvise(MADV_HUGEPAGE) failed");
+	} else if (test_pgsize == page_size) {
+		/* This is normal page test; force no thp */
+		if (madvise(area_dst, nr_pages * page_size, MADV_NOHUGEPAGE))
+			err("madvise(MADV_NOHUGEPAGE) failed");
+	}
+
+	if (userfaultfd_open(0))
+		err("userfaultfd_open");
+
+	uffdio_register.range.start = (unsigned long) area_dst;
+	uffdio_register.range.len = nr_pages * page_size;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+		err("register failed");
+
+	pagemap_fd = pagemap_open();
+
+	/* Touch the page */
+	*area_dst = 1;
+	wp_range(uffd, (uint64_t)area_dst, test_pgsize, true);
+	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	pagemap_check_wp(value, true);
+	/* Make sure uffd-wp bit dropped when fork */
+	if (pagemap_test_fork(true))
+		err("Detected stall uffd-wp bit in child");
+
+	/* Exclusive required or PAGEOUT won't work */
+	if (!(value & PM_MMAP_EXCLUSIVE))
+		err("multiple mapping detected: 0x%"PRIx64, value);
+
+	if (madvise(area_dst, test_pgsize, MADV_PAGEOUT))
+		err("madvise(MADV_PAGEOUT) failed");
+
+	/* Uffd-wp should persist even swapped out */
+	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	pagemap_check_wp(value, true);
+	/* Make sure uffd-wp bit dropped when fork */
+	if (pagemap_test_fork(false))
+		err("Detected stall uffd-wp bit in child");
+
+	/* Unprotect; this tests swap pte modifications */
+	wp_range(uffd, (uint64_t)area_dst, page_size, false);
+	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	pagemap_check_wp(value, false);
+
+	/* Fault in the page from disk */
+	*area_dst = 2;
+	value = pagemap_read_vaddr(pagemap_fd, area_dst);
+	pagemap_check_wp(value, false);
+
+	close(pagemap_fd);
+	close(uffd);
+	printf("done\n");
+}
+
 static int userfaultfd_stress(void)
 {
 	void *area;
@@ -1341,6 +1479,22 @@ static int userfaultfd_stress(void)
 	}
 
 	close(uffd);
+
+	if (test_type == TEST_ANON) {
+		/*
+		 * shmem/hugetlb won't be able to run since they have different
+		 * behavior on fork() (file-backed memory normally drops ptes
+		 * directly when fork), meanwhile the pagemap test will verify
+		 * pgtable entry of fork()ed child.
+		 */
+		userfaultfd_pagemap_test(page_size);
+		/*
+		 * Hard-code for x86_64 for now for 2M THP, as x86_64 is
+		 * currently the only one that supports uffd-wp
+		 */
+		userfaultfd_pagemap_test(page_size * 512);
+	}
+
 	return userfaultfd_zeropage_test() || userfaultfd_sig_test()
 		|| userfaultfd_events_test() || userfaultfd_minor_test();
 }
-- 
2.26.2

