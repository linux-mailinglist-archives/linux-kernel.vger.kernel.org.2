Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE8934650F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 17:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhCWQ07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 12:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbhCWQ0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 12:26:23 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AC0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:26:23 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id f26so1525080qtq.17
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 09:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=XPRq1W/wuES2HJCP2WXgJHm10YoXyWPHE5kWVTMZXI4=;
        b=Z2BuAR3KJ1S3vRUxnuAIr23jCEDLS3JCMZT54LNGkWacyQ5/tTVzFNsfhXV/iifyf0
         UMYh70Gvk7dGWuubbFlPUZmxni1D3bn7Dbes24AkjDkZIhRl9yC61pAzMKtkgENZx4kq
         P+PBjD9MqmAGYbHpeZ0eXb0f2gJQaARF2P4aw6hlq0gtwPIEulhe3cHJ+VyoIZZawZ6X
         399Z71YgRFMGdFR4U7X7D4jxBeOCuP19SB37meORrEb9mLXtGlOBevosPF7Sp/OENwcK
         uCCiXL/7rQjdgagMSw6Cd2396aEhXZvrYrO7PQ1RO0jnYXmc/nKMcko3Wd22ptqvvEdb
         OK6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=XPRq1W/wuES2HJCP2WXgJHm10YoXyWPHE5kWVTMZXI4=;
        b=KVxf5Q0vBAAIZkYO7xkrGu0WnwcygPZK+X1yXwZsbD++7R7kCK8VXJ6+rbI5bfRMR3
         nNTXQKrqoThIcpzeZ6lpIpGdKoSm0gQuBcFbmGENLcCfiKuP0wdmxmJGn9LZCGMy2pRs
         Pt9mFXzmIfQwM7YVxo1FLH+yOif/6e/ev9y5bJdjJ+TakFWsi+9sPmtJdOw02QnLAN8R
         bbwqFUKPK8iBAkl+KRc4vJc9pLGUBXe2KlV4SPNqvQ3UsX4n0W0JRivUdKWME/XNULlM
         whwW9Q5+1vsGfhfL5CRO0QudHM3QwqNpkhPWVY6EBWL0RTHeZTVhWiodNA27/n9qdY+t
         tvxg==
X-Gm-Message-State: AOAM5334ND1JGhn9jblj+7pBPvqSKHAxDi/CO1XgVB/lsN1UvulHzO8o
        f89WgZljX2vO+jo6Q6/zxyAcYkKTm1ES
X-Google-Smtp-Source: ABdhPJyGdN/dicqW1iEYZxwWdGQCRoITAp4US/P7dcpV3ycZ/tXYuvuxuUYPrt1uW3ocUDX9KfMawrcaeZ3W
X-Received: from bg.sfo.corp.google.com ([2620:15c:8:10:b5cc:cacb:2875:ae6e])
 (user=bgeffon job=sendgmr) by 2002:a05:6214:80a:: with SMTP id
 df10mr6038618qvb.46.1616516782596; Tue, 23 Mar 2021 09:26:22 -0700 (PDT)
Date:   Tue, 23 Mar 2021 09:26:10 -0700
In-Reply-To: <20210323162611.2398613-1-bgeffon@google.com>
Message-Id: <20210323162611.2398613-3-bgeffon@google.com>
Mime-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com> <20210323162611.2398613-1-bgeffon@google.com>
X-Mailer: git-send-email 2.31.0.rc2.261.g7f71774620-goog
Subject: [PATCH v4 3/3] selftests: Add a MREMAP_DONTUNMAP selftest for shmem
From:   Brian Geffon <bgeffon@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Brian Geffon <bgeffon@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andy Lutomirski <luto@amacapital.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Sonny Rao <sonnyrao@google.com>,
        Minchan Kim <minchan@kernel.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Dmitry Safonov <dima@arista.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Alejandro Colomar <alx.manpages@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This test extends the current mremap tests to validate that
the MREMAP_DONTUNMAP operation can be performed on shmem mappings.

Signed-off-by: Brian Geffon <bgeffon@google.com>
---
 tools/testing/selftests/vm/mremap_dontunmap.c | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/tools/testing/selftests/vm/mremap_dontunmap.c b/tools/testing/selftests/vm/mremap_dontunmap.c
index 3a7b5ef0b0c6..f01dc4a85b0b 100644
--- a/tools/testing/selftests/vm/mremap_dontunmap.c
+++ b/tools/testing/selftests/vm/mremap_dontunmap.c
@@ -127,6 +127,57 @@ static void mremap_dontunmap_simple()
 	       "unable to unmap source mapping");
 }
 
+// This test validates that MREMAP_DONTUNMAP on a shared mapping works as expected.
+static void mremap_dontunmap_simple_shmem()
+{
+	unsigned long num_pages = 5;
+
+	int mem_fd = memfd_create("memfd", MFD_CLOEXEC);
+	BUG_ON(mem_fd < 0, "memfd_create");
+
+	BUG_ON(ftruncate(mem_fd, num_pages * page_size) < 0,
+			"ftruncate");
+
+	void *source_mapping =
+	    mmap(NULL, num_pages * page_size, PROT_READ | PROT_WRITE,
+		 MAP_FILE | MAP_SHARED, mem_fd, 0);
+	BUG_ON(source_mapping == MAP_FAILED, "mmap");
+
+	BUG_ON(close(mem_fd) < 0, "close");
+
+	memset(source_mapping, 'a', num_pages * page_size);
+
+	// Try to just move the whole mapping anywhere (not fixed).
+	void *dest_mapping =
+	    mremap(source_mapping, num_pages * page_size, num_pages * page_size,
+		   MREMAP_DONTUNMAP | MREMAP_MAYMOVE, NULL);
+	if (dest_mapping == MAP_FAILED && errno == EINVAL) {
+		// Old kernel which doesn't support MREMAP_DONTUNMAP on shmem.
+		BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
+			"unable to unmap source mapping");
+		return;
+	}
+
+	BUG_ON(dest_mapping == MAP_FAILED, "mremap");
+
+	// Validate that the pages have been moved, we know they were moved if
+	// the dest_mapping contains a's.
+	BUG_ON(check_region_contains_byte
+	       (dest_mapping, num_pages * page_size, 'a') != 0,
+	       "pages did not migrate");
+
+	// Because the region is backed by shmem, we will actually see the same
+	// memory at the source location still.
+	BUG_ON(check_region_contains_byte
+	       (source_mapping, num_pages * page_size, 'a') != 0,
+	       "source should have no ptes");
+
+	BUG_ON(munmap(dest_mapping, num_pages * page_size) == -1,
+	       "unable to unmap destination mapping");
+	BUG_ON(munmap(source_mapping, num_pages * page_size) == -1,
+	       "unable to unmap source mapping");
+}
+
 // This test validates MREMAP_DONTUNMAP will move page tables to a specific
 // destination using MREMAP_FIXED, also while validating that the source
 // remains intact.
@@ -300,6 +351,7 @@ int main(void)
 	BUG_ON(page_buffer == MAP_FAILED, "unable to mmap a page.");
 
 	mremap_dontunmap_simple();
+	mremap_dontunmap_simple_shmem();
 	mremap_dontunmap_simple_fixed();
 	mremap_dontunmap_partial_mapping();
 	mremap_dontunmap_partial_mapping_overwrite();
-- 
2.31.0.rc2.261.g7f71774620-goog

