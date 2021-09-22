Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6803641462A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 12:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbhIVK26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 06:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234916AbhIVK25 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 06:28:57 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5636BC061756
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:27:27 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id r7so1135480pjo.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 03:27:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2WShyFWb04L9WEAJIMbiQ1oAuqmUubIidKcAA6z6qHc=;
        b=cmX7TscVl7FShFFSBOdOXLSIvnSRAK2+duMaOxUohUqToHBQ4DZTIo8CNMXeSIcXCh
         QlbB3FsrvQ+luQXw0SxtwUvA2Jh/CS10+n+7p6uQj7YLQDwSgDQZYO7oqJxRMcmD2JDB
         tpyL9E4o0GqjwEGdPz5Fg8CL8URUpWBI4KefN/Mgz8HjQDFe510Ix2aazYtQjUWFqdzJ
         nrIHZxfacZX995iYpQbwxAM6f9SjeIH5XvhBRLhsiiAPPybW2b3eP1R7osUTLWfxGrAW
         nSYPCLmEml+3OcrnZriVdgIOAGCE8crbypeYn/lgHwyj5+Xe6OtrCfkNq/d2HKhaV/g0
         fnhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2WShyFWb04L9WEAJIMbiQ1oAuqmUubIidKcAA6z6qHc=;
        b=k1gzu+IFfeXGWDG5kvQWGT/8J60MsihrtLVjwbr6LtR6veo8B+pPuIT3/d+2NqXY8X
         NTwnBbe7drDrXzeikTvul6IKYSQyfj+51b3oCPdngva//BIxDtgfEXopAf4cngmCng2F
         2c6Dcp9VZdyz83POEyPcR1JOmn8OebKy3UNBOBdsbEPp4bynX2/ZkLbf0cSh+OwTM+bZ
         dgm5RqNTBy6PwZoX/Y6p60KD9Oq6ooWd6yhCjneHe+5Wyo5drRdesQ1oL1fU9rQverUe
         PcVmuYG0UH6UqlPSrRUXfvlH706q1XqqK88SnDdpUx7o6Hrp3qJd6KRlfeXDW7o6mkbj
         MMbQ==
X-Gm-Message-State: AOAM531I7MSDjfoxJriZ1mVbzGipx6K/bCG1PpjpHxCuu+O+5drJn/MS
        +0KnpMy+GD4B6FIDOyRlZOsBHA==
X-Google-Smtp-Source: ABdhPJwdS5Kmj5jx1TOgHHJcAJ4Oj6w5rtx3g+FopqrNg7Ovjt492uI9o2342vDaynECyHxNmd9l8w==
X-Received: by 2002:a17:90a:345:: with SMTP id 5mr10185110pjf.189.1632306446871;
        Wed, 22 Sep 2021 03:27:26 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.255])
        by smtp.gmail.com with ESMTPSA id s89sm1821929pjj.43.2021.09.22.03.27.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Sep 2021 03:27:26 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 4/4] selftests: vm: add a hugetlb test case
Date:   Wed, 22 Sep 2021 18:24:11 +0800
Message-Id: <20210922102411.34494-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210922102411.34494-1-songmuchun@bytedance.com>
References: <20210922102411.34494-1-songmuchun@bytedance.com>
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
---
 tools/testing/selftests/vm/vmemmap_hugetlb.c | 144 +++++++++++++++++++++++++++
 1 file changed, 144 insertions(+)
 create mode 100644 tools/testing/selftests/vm/vmemmap_hugetlb.c

diff --git a/tools/testing/selftests/vm/vmemmap_hugetlb.c b/tools/testing/selftests/vm/vmemmap_hugetlb.c
new file mode 100644
index 000000000000..4cc74dd4c333
--- /dev/null
+++ b/tools/testing/selftests/vm/vmemmap_hugetlb.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * A test case of using hugepage memory in a user application using the
+ * mmap system call with MAP_HUGETLB flag.  Before running this program
+ * make sure the administrator has allocated enough default sized huge
+ * pages to cover the 2 MB allocation.
+ *
+ * For ia64 architecture, Linux kernel reserves Region number 4 for hugepages.
+ * That means the addresses starting with 0x800000... will need to be
+ * specified.  Specifying a fixed address is not required on ppc64, i386
+ * or x86_64.
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
+/* Only ia64 requires this */
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

