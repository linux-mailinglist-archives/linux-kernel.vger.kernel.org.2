Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57776431605
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 12:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbhJRK2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbhJRK2A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 06:28:00 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAF4C061768
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:25:49 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id 21so10874625plo.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 03:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4TEz7LJ2e38nXsVuu+zdOOkjk9dhX/V4fwPw2l4XlU8=;
        b=ub/RlTdG7co0/yi8PJViCio5eWgEkacfTivaJLn549E9iS0zviJGG12Dr92T5aXkX9
         FpkFTZaMBaVuia1mx0M5Yi8MHLWcYuhyuiTgGR0/8cCxTZzE750BFwjQOInpT6bL0FzV
         u4WxRe6JP56/oZvvyQU0eEmCbEUPf7MgpvC21cFIgkxkZgOAjxCwIclhhYADSvC3ocpY
         M1YcBGg212mUSEKw5OHFaRumoPa08MN4O2xyQia5Umdu5q8vefIJdHMvMLT40oMihUWL
         NfwYKViGWehBL5FjuPHPgzohD5kpenSIMwjOBG/wDuxc2zEDFyypKwAxOkeFM0lqWzC1
         Iytw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4TEz7LJ2e38nXsVuu+zdOOkjk9dhX/V4fwPw2l4XlU8=;
        b=dR+HMQRHmAhcDhwuOSe8UUGhLp3keKXwBZiQ0F0DLZwFccnhNn8b+XZ6Q8YcQBQIrG
         DcH6dJnXM0fm0TK3I3zhHFBNZfE09GVfiop/wszvrFCcM32XJa4Ja7HFeuum5Iwedl2s
         x/sYz64Y/0tsLsT+svazPiDcUjhz+YGaxxbgEPuXRuZx7+pWJ0oQCcmxUyGS/h1xIRUE
         H4O2Ej3HfqYk3+c48js59gUmitXESvuqa8bENhbvs9Jx1xsY2w7+PviZgN5XoMWLZQzJ
         GXctwdQoFC9zNPysAFz9l57LeGfCgHpRanIy5Lw8nwFbLYIqNx9++WCUqlQRBJckcwxE
         B6ng==
X-Gm-Message-State: AOAM531uLt+ZL4e2KryM8aV7kTX+/JaTFvExwsNO8XQm/4GsrqnBuqZ+
        Y0Mhxq6moF0aXvAdQFUykU7/Vg==
X-Google-Smtp-Source: ABdhPJzwnPmdmCAEs1NVmhdD8qEYCyVLFFUGm6I894CH7brAEpIkoeA+Wg8DD4fMyzrgHEpFVGBF2A==
X-Received: by 2002:a17:90b:4d84:: with SMTP id oj4mr32326261pjb.58.1634552748657;
        Mon, 18 Oct 2021 03:25:48 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id nn14sm12762232pjb.27.2021.10.18.03.25.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 18 Oct 2021 03:25:48 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org, 21cnbao@gmail.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v6 4/5] selftests: vm: add a hugetlb test case
Date:   Mon, 18 Oct 2021 18:20:42 +0800
Message-Id: <20211018102043.78685-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20211018102043.78685-1-songmuchun@bytedance.com>
References: <20211018102043.78685-1-songmuchun@bytedance.com>
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
 tools/testing/selftests/vm/.gitignore         |   1 +
 tools/testing/selftests/vm/Makefile           |   1 +
 tools/testing/selftests/vm/hugepage-vmemmap.c | 144 ++++++++++++++++++++++++++
 tools/testing/selftests/vm/run_vmtests.sh     |  11 ++
 4 files changed, 157 insertions(+)
 create mode 100644 tools/testing/selftests/vm/hugepage-vmemmap.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index 2e7e86e85282..3b5faec3c04f 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -2,6 +2,7 @@
 hugepage-mmap
 hugepage-mremap
 hugepage-shm
+hugepage-vmemmap
 khugepaged
 map_hugetlb
 map_populate
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index 1607322a112c..7d100a7dc462 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -31,6 +31,7 @@ TEST_GEN_FILES += hmm-tests
 TEST_GEN_FILES += hugepage-mmap
 TEST_GEN_FILES += hugepage-mremap
 TEST_GEN_FILES += hugepage-shm
+TEST_GEN_FILES += hugepage-vmemmap
 TEST_GEN_FILES += khugepaged
 TEST_GEN_FILES += madv_populate
 TEST_GEN_FILES += map_fixed_noreplace
diff --git a/tools/testing/selftests/vm/hugepage-vmemmap.c b/tools/testing/selftests/vm/hugepage-vmemmap.c
new file mode 100644
index 000000000000..557bdbd4f87e
--- /dev/null
+++ b/tools/testing/selftests/vm/hugepage-vmemmap.c
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
diff --git a/tools/testing/selftests/vm/run_vmtests.sh b/tools/testing/selftests/vm/run_vmtests.sh
index 45e803af7c77..745f86e7a086 100755
--- a/tools/testing/selftests/vm/run_vmtests.sh
+++ b/tools/testing/selftests/vm/run_vmtests.sh
@@ -108,6 +108,17 @@ else
 	echo "[PASS]"
 fi
 
+echo "------------------------"
+echo "running hugepage-vmemmap"
+echo "------------------------"
+./hugepage-vmemmap
+if [ $? -ne 0 ]; then
+	echo "[FAIL]"
+	exitcode=1
+else
+	echo "[PASS]"
+fi
+
 echo "NOTE: The above hugetlb tests provide minimal coverage.  Use"
 echo "      https://github.com/libhugetlbfs/libhugetlbfs.git for"
 echo "      hugetlb regression testing."
-- 
2.11.0

