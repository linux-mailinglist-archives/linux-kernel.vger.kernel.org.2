Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9AF641AF39
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Sep 2021 14:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240811AbhI1Mos (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Sep 2021 08:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240786AbhI1Moo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Sep 2021 08:44:44 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B21FC061740
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:43:05 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id y5so11653499pll.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Sep 2021 05:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/sS8htj/D1lJKYWboIkf/9D9ISm975jzQKVeLPct0Xw=;
        b=wtKl2pgZDkoQX5MX43vHvagr8lQd9eM6gkI8n6WC1o6qVMy7JQn0Ti/dDnt6LGk95v
         beTCzorvpH0KA1bpDpBL5gSP8S+UEdLRd3/ufTnA318NHdl7NM6YZUIR1IE+gxGCPTyt
         bigGXMJ96QOB+ySjM2T/KRci+7c6Hx0TGl7UwRGfBabb3cJfldThapjrV7xlL4cjK6nV
         JLkWGVRvOTLiTl6WJTOim4rjf+JGshB7M7d4lYGBx8Zs+YjSb6hyKQRQNx72iMfKo4Ut
         YohqhAMM0X7Vm5u8x3u3EPXKaLDNbfcrfVjCr9FgE9t9C0pBOhqVr7XE9FCc49gbDcX8
         a0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/sS8htj/D1lJKYWboIkf/9D9ISm975jzQKVeLPct0Xw=;
        b=dG9DmrI0+miC8MdRNiTx2r3NUVN5O1mBskT3a6SD1LKppPROeiUypkRAxlxf6DtDGR
         j9TJV6qyS+ydx1hmC8uAckWHDKaQNlohGJE9aWNcLHHd6tJ3cytNMqdxsNZKSLL9MuxQ
         j4l9xBeTNGg+5SqtfdkmqYaRz3Wq9QAjqVmbxX06Qfumk4bg6Gjo7xCoP4nl1/8mG1F6
         EkquAWJPhB8y6zgtgYtQGpvrYi5tFoJvEga+ngP5g237MslMXBzH3mNpi+V3Mj86RUxT
         I1E1/KgChj6OrYQ6X3r9rRurzg1enjq9Sq22IQwitTn8huYdduKsXcEDEC/unHaxzD1g
         J6vw==
X-Gm-Message-State: AOAM531J4yImlWumdo2+zki6pmSepWlY7+qfXOfE89FK2fk7lWSUj5au
        +uzw12GM9ik9+97JrRjzyXrgfg==
X-Google-Smtp-Source: ABdhPJzmblQcsy7sdwWegCRtN8Mb+0dlWz1VVjSS92r/Fmn7jyyh7y4VGtXqQgT0gf3ONCbWaYP+Wg==
X-Received: by 2002:a17:903:1d0:b0:13d:aaea:a35d with SMTP id e16-20020a17090301d000b0013daaeaa35dmr4876102plh.78.1632832984789;
        Tue, 28 Sep 2021 05:43:04 -0700 (PDT)
Received: from localhost.localdomain ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id s17sm10055287pge.50.2021.09.28.05.42.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Sep 2021 05:43:04 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v5 4/5] selftests: vm: add a hugetlb test case
Date:   Tue, 28 Sep 2021 20:41:51 +0800
Message-Id: <20210928124152.33634-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210928124152.33634-1-songmuchun@bytedance.com>
References: <20210928124152.33634-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the head vmemmap page frame associated with each HugeTLB page is
reused, we should hide the PG_head flag of tail struct page from the
user. Add a tese case to check whether it is work properly. The test
steps are as follows.

  1) alloc 2MB hugeTLB
  2) get each page frame
  3) apply those APIs in each page frame
  4) Those APIs work completely the same as before.

Reading the flags of a page by /proc/kpageflags is done in
stable_page_flags(), which has invoked PageHead(), PageTail(),
PageCompound() and compound_head(). If those APIs work properly, the
head page must have 15 and 17 bits set. And tail pages must have 16
and 17 bits set but 15 bit unset. Those flags are checked in
check_page_flags().

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>
---
 tools/testing/selftests/vm/vmemmap_hugetlb.c | 144 +++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 tools/testing/selftests/vm/vmemmap_hugetlb.c

diff --git a/tools/testing/selftests/vm/vmemmap_hugetlb.c b/tools/testing/selftests/vm/vmemmap_hugetlb.c
new file mode 100644
index 000000000000..557bdbd4f87e
--- /dev/null
+++ b/tools/testing/selftests/vm/vmemmap_hugetlb.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A test case of using hugepage memory in a user application using the
+ * mmap system call with MAP_HUGETLB flag.  Before running this program
+ * make sure the administrator has allocated enough default sized huge
+ * pages to cover the 2 MB allocation.
+ */
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+
+#define MAP_LENGTH		(2UL * 1024 * 1024)
+
+#ifndef MAP_HUGETLB
+#define MAP_HUGETLB		0x40000	/* arch specific */
+#endif
+
+#define PAGE_SIZE		4096
+
+#define PAGE_COMPOUND_HEAD	(1UL << 15)
+#define PAGE_COMPOUND_TAIL	(1UL << 16)
+#define PAGE_HUGE		(1UL << 17)
+
+#define HEAD_PAGE_FLAGS		(PAGE_COMPOUND_HEAD | PAGE_HUGE)
+#define TAIL_PAGE_FLAGS		(PAGE_COMPOUND_TAIL | PAGE_HUGE)
+
+#define PM_PFRAME_BITS		55
+#define PM_PFRAME_MASK		~((1UL << PM_PFRAME_BITS) - 1)
+
+/*
+ * For ia64 architecture, Linux kernel reserves Region number 4 for hugepages.
+ * That means the addresses starting with 0x800000... will need to be
+ * specified.  Specifying a fixed address is not required on ppc64, i386
+ * or x86_64.
+ */
+#ifdef __ia64__
+#define MAP_ADDR		(void *)(0x8000000000000000UL)
+#define MAP_FLAGS		(MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB | MAP_FIXED)
+#else
+#define MAP_ADDR		NULL
+#define MAP_FLAGS		(MAP_PRIVATE | MAP_ANONYMOUS | MAP_HUGETLB)
+#endif
+
+static void write_bytes(char *addr, size_t length)
+{
+	unsigned long i;
+
+	for (i = 0; i < length; i++)
+		*(addr + i) = (char)i;
+}
+
+static unsigned long virt_to_pfn(void *addr)
+{
+	int fd;
+	unsigned long pagemap;
+
+	fd = open("/proc/self/pagemap", O_RDONLY);
+	if (fd < 0)
+		return -1UL;
+
+	lseek(fd, (unsigned long)addr / PAGE_SIZE * sizeof(pagemap), SEEK_SET);
+	read(fd, &pagemap, sizeof(pagemap));
+	close(fd);
+
+	return pagemap & ~PM_PFRAME_MASK;
+}
+
+static int check_page_flags(unsigned long pfn)
+{
+	int fd, i;
+	unsigned long pageflags;
+
+	fd = open("/proc/kpageflags", O_RDONLY);
+	if (fd < 0)
+		return -1;
+
+	lseek(fd, pfn * sizeof(pageflags), SEEK_SET);
+
+	read(fd, &pageflags, sizeof(pageflags));
+	if ((pageflags & HEAD_PAGE_FLAGS) != HEAD_PAGE_FLAGS) {
+		close(fd);
+		printf("Head page flags (%lx) is invalid\n", pageflags);
+		return -1;
+	}
+
+	/*
+	 * pages other than the first page must be tail and shouldn't be head;
+	 * this also verifies kernel has correctly set the fake page_head to tail
+	 * while hugetlb_free_vmemmap is enabled.
+	 */
+	for (i = 1; i < MAP_LENGTH / PAGE_SIZE; i++) {
+		read(fd, &pageflags, sizeof(pageflags));
+		if ((pageflags & TAIL_PAGE_FLAGS) != TAIL_PAGE_FLAGS ||
+		    (pageflags & HEAD_PAGE_FLAGS) == HEAD_PAGE_FLAGS) {
+			close(fd);
+			printf("Tail page flags (%lx) is invalid\n", pageflags);
+			return -1;
+		}
+	}
+
+	close(fd);
+
+	return 0;
+}
+
+int main(int argc, char **argv)
+{
+	void *addr;
+	unsigned long pfn;
+
+	addr = mmap(MAP_ADDR, MAP_LENGTH, PROT_READ | PROT_WRITE, MAP_FLAGS, -1, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	/* Trigger allocation of HugeTLB page. */
+	write_bytes(addr, MAP_LENGTH);
+
+	pfn = virt_to_pfn(addr);
+	if (pfn == -1UL) {
+		munmap(addr, MAP_LENGTH);
+		perror("virt_to_pfn");
+		exit(1);
+	}
+
+	printf("Returned address is %p whose pfn is %lx\n", addr, pfn);
+
+	if (check_page_flags(pfn) < 0) {
+		munmap(addr, MAP_LENGTH);
+		perror("check_page_flags");
+		exit(1);
+	}
+
+	/* munmap() length of MAP_HUGETLB memory must be hugepage aligned */
+	if (munmap(addr, MAP_LENGTH)) {
+		perror("munmap");
+		exit(1);
+	}
+
+	return 0;
+}
-- 
2.11.0

