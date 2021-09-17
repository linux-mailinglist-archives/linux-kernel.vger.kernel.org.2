Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6190340F097
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 05:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244266AbhIQDzf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 23:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244137AbhIQDzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 23:55:09 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0A8C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:53:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id 17so8318755pgp.4
        for <linux-kernel@vger.kernel.org>; Thu, 16 Sep 2021 20:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TGoc9aaZ7sLEp8beTZ83fWsgv448hw3NlquoSI1tIpc=;
        b=GrlOcIkjOttoNyt9uAxssEzdAPK+Ix7mxC24S50e1mwslq3/78CCkciFGik4DFV4cj
         Y26NzVH8UJlpOlNkU/9SwKWFgxgh4qhr2wD91IMhRSDTnoTz6Ndt6HgDNtwDGBTvfWhJ
         Y2LYmib9j4LBm4lws5DnlY9sYToL9pHZ0ni3HlDaeIJ5RqtTbdPacjySTSihcJ6lfe0t
         K9AkebQQ+zc3L+RUgtH2IeC4aUtiVhUub242sasjLXsqIN1M3yWbR9Ii9mZ3/Lo2FPBg
         RJA5vtvHTP+M1k92Jj8dQjOqy7QtDPitcmAe2FHbVbxPxkw3vNUCbB6+wXj7fQjMRTnU
         m/qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TGoc9aaZ7sLEp8beTZ83fWsgv448hw3NlquoSI1tIpc=;
        b=Kxk7FeBmHcASGTol3UIcj6J1cSzajMLPFVsF82CfVRf6uv0uzKwmtD0MgB4648et+0
         M3P6SmdUAPzAa9zSue+ICqCgDWNfOCdHHmtGD9vaWcD7iNEC18zjSGu9llJOjLrh4JLX
         R3OUbVmzjFCfBXkiEWMo7zycNp+Y6dJJxtZNql4hqvslYnbZmH/6j+vfZhlXX5fa5fDP
         yNK9yTR+/2WfWkov2BfNNU05RsDzYWf5HW/63sHJsPlJaHc1YW4wsr9DtrrOPKHCcc8V
         WF7OGRc+hDKofK6SxX2Z4DnfKG/zAkNo5ORnfmPfBb3LJLyLnVg31tmvICoJ5ljlzgow
         wiOQ==
X-Gm-Message-State: AOAM531swshZ8Ns2p5oBOQjzjHhG2Wu+oRfjYwLFVd061ZMcoeKViSpr
        sT9Fx03Wl70ss0GKnfexji2JOw==
X-Google-Smtp-Source: ABdhPJw2rjqGkq6uMfbea6Dab9P9fY632YnCXZwAHBuNh8LPnCu/F6CXuSUOsP/hlCtD6TkiLwoP0g==
X-Received: by 2002:aa7:9ac2:0:b0:443:a477:6684 with SMTP id x2-20020aa79ac2000000b00443a4776684mr4713577pfp.25.1631850821179;
        Thu, 16 Sep 2021 20:53:41 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.226])
        by smtp.gmail.com with ESMTPSA id g12sm8997704pja.28.2021.09.16.20.53.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 16 Sep 2021 20:53:40 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     mike.kravetz@oracle.com, akpm@linux-foundation.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, chenhuang5@huawei.com, bodeddub@amazon.com,
        corbet@lwn.net, willy@infradead.org
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        smuchun@gmail.com, zhengqi.arch@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH RESEND v2 4/4] selftests: vm: add a hugetlb test case
Date:   Fri, 17 Sep 2021 11:48:15 +0800
Message-Id: <20210917034815.80264-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20210917034815.80264-1-songmuchun@bytedance.com>
References: <20210917034815.80264-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the head vmemmap page frame associated with each HugeTLB page is
reused, we should hide the PG_head flag of tail struct page from the
user. Add a tese case to check whether it is work properly.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 tools/testing/selftests/vm/vmemmap_hugetlb.c | 139 +++++++++++++++++++++++++++
 1 file changed, 139 insertions(+)
 create mode 100644 tools/testing/selftests/vm/vmemmap_hugetlb.c

diff --git a/tools/testing/selftests/vm/vmemmap_hugetlb.c b/tools/testing/selftests/vm/vmemmap_hugetlb.c
new file mode 100644
index 000000000000..b6e945bf4053
--- /dev/null
+++ b/tools/testing/selftests/vm/vmemmap_hugetlb.c
@@ -0,0 +1,139 @@
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

