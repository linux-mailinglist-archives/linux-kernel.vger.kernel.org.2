Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78BBC3F0F89
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 02:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbhHSAlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 20:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235069AbhHSAlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 20:41:14 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7431CC061764
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 17:40:39 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id k5-20020a05620a414500b003d5da483eafso51440qko.22
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 17:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:cc;
        bh=TeGN/kXie9Vzo9VueC+BGQrr/KQ+7A4D5jkhas0G/0Q=;
        b=adUZXbh6+srbb7WIsCmdHokaLSCd+1KqPIDa2F9OoL+5SvRi9l8IXt+lWD9asiSZMX
         sW3e8/oPA5bNIL4ZO+0nsLZOV92BvuW1Oq4xx2v7fTTJOEBpuznz/mfzO4V32Yzyg67Y
         MVtWNVqOYmoV7lGVeG349iChcEwrXFni7/qkkXxcBfmi3xwvuITLz5K1C0YNlO64kjEa
         uOK0/8HvmZICQVQHk+bmgoQGoCmRV5ine8jMDFXDbKeV4wXHPOFl2WwLOmZ0IGp2fnRu
         poaSdLbZ5YhZkjfLybEYn+nVaYvBPvd3E3CHHn4Epmk4lfdZZ82V4FIonxb3TQL6pyUB
         XXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=TeGN/kXie9Vzo9VueC+BGQrr/KQ+7A4D5jkhas0G/0Q=;
        b=cfPzECNa2bKQfou8a8U68Zf/Dp9N9sBMyQzPLivVUFA1iuiQAzhFY2TxY/Ii3qtFdN
         aWN2vqZ9w+9mLQgxhPKqkPfVw20uigMF0TtsHAxYuGo8r+esbpSdvxqp1NIGuINwnKmq
         CHnN4aBvPcx5tP0lHzUpzaA24A5+20hcA7gkmUBIC4laQo1cR0PNTQtEOobrJQ7aRkYF
         05/eJxMgU5N1Djehtk2GZ7FAIZCN74MlsaB2C+9zkLQRUFLgKnEmpVGrp+kdBWE1mnyk
         t5K5sintKoGbqiNaSnwJqsG6afesczq3KOflKEZN8sPvv40RHoUoKM4dn190jR+BiTLh
         QLIA==
X-Gm-Message-State: AOAM533cJOkDOo4PUDPm92qyDAUdXPMxAGG51Wb2pyVmQTUSo4/5vsVW
        po1UyLhczfcNcVSyybO3VA9DozdPMYDt3RHJYg==
X-Google-Smtp-Source: ABdhPJxL6fHE1CzlBQV8UQH1+8NPb3E5JqTl3nOziEZm+MLMbqyqgXgEZSfTKq/Km8Wnvi3nARLDxshqsz1jGt8bRw==
X-Received: from almasrymina.svl.corp.google.com ([2620:15c:2cd:202:c56d:4854:9e72:932c])
 (user=almasrymina job=sendgmr) by 2002:a0c:b216:: with SMTP id
 x22mr11890140qvd.55.1629333638683; Wed, 18 Aug 2021 17:40:38 -0700 (PDT)
Date:   Wed, 18 Aug 2021 17:40:26 -0700
In-Reply-To: <20210819004026.3639293-1-almasrymina@google.com>
Message-Id: <20210819004026.3639293-2-almasrymina@google.com>
Mime-Version: 1.0
References: <20210819004026.3639293-1-almasrymina@google.com>
X-Mailer: git-send-email 2.33.0.rc1.237.g0d66db33f3-goog
Subject: [PATCH v3 2/2] mm, hugepages: Add hugetlb vma mremap() test
From:   Mina Almasry <almasrymina@google.com>
Cc:     Mina Almasry <almasrymina@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ken Chen <kenchen@google.com>,
        Chris Kennelly <ckennelly@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Mina Almasry <almasrymina@google.com>

Cc: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org
Cc: Ken Chen <kenchen@google.com>
Cc: Chris Kennelly <ckennelly@google.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Kirill Shutemov <kirill@shutemov.name>
---
 tools/testing/selftests/vm/.gitignore        |   1 +
 tools/testing/selftests/vm/Makefile          |   1 +
 tools/testing/selftests/vm/hugepage-mremap.c | 165 +++++++++++++++++++
 3 files changed, 167 insertions(+)
 create mode 100644 tools/testing/selftests/vm/hugepage-mremap.c

diff --git a/tools/testing/selftests/vm/.gitignore b/tools/testing/selftests/vm/.gitignore
index b02eac613fdda..2e7e86e852828 100644
--- a/tools/testing/selftests/vm/.gitignore
+++ b/tools/testing/selftests/vm/.gitignore
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 hugepage-mmap
+hugepage-mremap
 hugepage-shm
 khugepaged
 map_hugetlb
diff --git a/tools/testing/selftests/vm/Makefile b/tools/testing/selftests/vm/Makefile
index d9605bd10f2de..1607322a112c9 100644
--- a/tools/testing/selftests/vm/Makefile
+++ b/tools/testing/selftests/vm/Makefile
@@ -29,6 +29,7 @@ TEST_GEN_FILES = compaction_test
 TEST_GEN_FILES += gup_test
 TEST_GEN_FILES += hmm-tests
 TEST_GEN_FILES += hugepage-mmap
+TEST_GEN_FILES += hugepage-mremap
 TEST_GEN_FILES += hugepage-shm
 TEST_GEN_FILES += khugepaged
 TEST_GEN_FILES += madv_populate
diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
new file mode 100644
index 0000000000000..a68e13cbac777
--- /dev/null
+++ b/tools/testing/selftests/vm/hugepage-mremap.c
@@ -0,0 +1,165 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * hugepage-mremap:
+ *
+ * Example of remapping huge page memory in a user application using the
+ * mremap system call.  Before running this application, make sure that the
+ * administrator has mounted the hugetlbfs filesystem (on some directory
+ * like /mnt) using the command mount -t hugetlbfs nodev /mnt. In this
+ * example, the app is requesting memory of size 10MB that is backed by
+ * huge pages.
+ *
+ */
+
+#define _GNU_SOURCE
+#include <stdlib.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <fcntl.h> /* Definition of O_* constants */
+#include <sys/syscall.h> /* Definition of SYS_* constants */
+#include <unistd.h>
+#include <linux/userfaultfd.h>
+#include <sys/ioctl.h>
+
+#define LENGTH (1UL * 1024 * 1024 * 1024)
+
+#define PROTECTION (PROT_READ | PROT_WRITE | PROT_EXEC)
+#define FLAGS (MAP_SHARED | MAP_ANONYMOUS)
+
+static void check_bytes(char *addr)
+{
+	printf("First hex is %x\n", *((unsigned int *)addr));
+}
+
+static void write_bytes(char *addr)
+{
+	unsigned long i;
+
+	for (i = 0; i < LENGTH; i++)
+		*(addr + i) = (char)i;
+}
+
+static int read_bytes(char *addr)
+{
+	unsigned long i;
+
+	check_bytes(addr);
+	for (i = 0; i < LENGTH; i++)
+		if (*(addr + i) != (char)i) {
+			printf("Mismatch at %lu\n", i);
+			return 1;
+		}
+	return 0;
+}
+
+static void register_region_with_uffd(char *addr, size_t len)
+{
+	long uffd; /* userfaultfd file descriptor */
+	struct uffdio_api uffdio_api;
+	struct uffdio_register uffdio_register;
+
+	/* Create and enable userfaultfd object. */
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd == -1) {
+		perror("userfaultfd");
+		exit(1);
+	}
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api) == -1) {
+		perror("ioctl-UFFDIO_API");
+		exit(1);
+	}
+
+	/* Create a private anonymous mapping. The memory will be
+	 * demand-zero paged--that is, not yet allocated. When we
+	 * actually touch the memory, it will be allocated via
+	 * the userfaultfd.
+	 */
+
+	addr = mmap(NULL, len, PROT_READ | PROT_WRITE,
+		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (addr == MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	printf("Address returned by mmap() = %p\n", addr);
+
+	/* Register the memory range of the mapping we just created for
+	 * handling by the userfaultfd object. In mode, we request to track
+	 * missing pages (i.e., pages that have not yet been faulted in).
+	 */
+
+	uffdio_register.range.start = (unsigned long)addr;
+	uffdio_register.range.len = len;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register) == -1) {
+		perror("ioctl-UFFDIO_REGISTER");
+		exit(1);
+	}
+}
+
+int main(void)
+{
+	int ret = 0;
+
+	int fd = open("/mnt/huge/test", O_CREAT | O_RDWR, 0755);
+
+	if (fd < 0) {
+		perror("Open failed");
+		exit(1);
+	}
+
+	/* mmap to a PUD aligned address to hopefully trigger pmd sharing. */
+	unsigned long suggested_addr = 0x7eaa40000000;
+	void *haddr = mmap((void *)suggested_addr, LENGTH, PROTECTION,
+			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
+	printf("Returned address is %p\n", haddr);
+	if (haddr == MAP_FAILED) {
+		perror("mmap1");
+		exit(1);
+	}
+
+	/* mmap again to a dummy address to hopefully trigger pmd sharing. */
+	suggested_addr = 0x7daa40000000;
+	void *daddr = mmap((void *)suggested_addr, LENGTH, PROTECTION,
+			   MAP_HUGETLB | MAP_SHARED | MAP_POPULATE, fd, 0);
+	printf("Returned address is %p\n", daddr);
+	if (daddr == MAP_FAILED) {
+		perror("mmap3");
+		exit(1);
+	}
+
+	suggested_addr = 0x7faa40000000;
+	void *vaddr =
+		mmap((void *)suggested_addr, LENGTH, PROTECTION, FLAGS, -1, 0);
+	printf("Returned address is %p\n", vaddr);
+	if (vaddr == MAP_FAILED) {
+		perror("mmap2");
+		exit(1);
+	}
+
+	register_region_with_uffd(haddr, LENGTH);
+
+	void *addr = mremap(haddr, LENGTH, LENGTH,
+			    MREMAP_MAYMOVE | MREMAP_FIXED, vaddr);
+	if (addr == MAP_FAILED) {
+		perror("mremap");
+		exit(1);
+	}
+
+	printf("Returned address is %p\n", addr);
+	check_bytes(addr);
+	write_bytes(addr);
+	ret = read_bytes(addr);
+
+	munmap(addr, LENGTH);
+
+	return ret;
+}
-- 
2.33.0.rc1.237.g0d66db33f3-goog

