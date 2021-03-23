Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4101534678E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:26:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhCWS0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:26:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhCWSZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:25:36 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B25FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:25:36 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id f20so2495722pgj.6
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 11:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Jnif/0NMg0aeEcah82nrTBoEGi2KuieYH+LfZPYXFBE=;
        b=PldZbFVYUScrEaM4fON0VI8wT/uoJ0m9q4USAq66I9zTqtbvN0b2BCRhGvFYBN9Klb
         qTKc+IDs2lxZJX91+OO/C2Arg0LESyb+wG9JTuavSWrd3XIF8gtw8aGaRuWY2G9ThSgx
         MfOMqSCyNIcmjTIXhWOG/TomexRy7h9Lk62RkrFndBF7v3aTuqlBnIa6agqgr12AFp6C
         EzLYzlUY772suahK8F1rZZz5WX5RbelvOgRtffBxmhnFZ7U3bmZZtDEc+LX6mV/d4NLJ
         sX02cjYjKZxAs3ZFeUDMeGEebT80IGGrtGvlGpW88WlvGscoNyKUoPRA1EUg+tCXpc6s
         DskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jnif/0NMg0aeEcah82nrTBoEGi2KuieYH+LfZPYXFBE=;
        b=Pnn5OK9jRU0QNuNJboUte1j664BZaDEtV6HFclOZegCzSCE63YSo3FeSEmVWD+rGY1
         K6GuDlTPVnbu7GMeNvHQEgbe6IWfxThajTz+AgBKqrRDG42RCy/SeQGOsnQaJncG+mGq
         hGvuE9oXL2kR1GDDpn8/DDlBwoDD90zkZqZmZa8ld1IeTn8dHghmgEd/Scn2Goe+Uq/m
         aBbb9o12r7TQAtt0dDydLlZDWyJF9awFQdNsyAhwHM+tdPGlanP6DeOaEM59ms3CD4f3
         aJcd2iAWt7da9UqqQoZBuM5pcsk+co2XeQqYDCP7uIr+VXVkFJVtq4Mtd/VYho67OKad
         6W9Q==
X-Gm-Message-State: AOAM532D567ssyECk0ODTZCyoChU44HLll2sRn1WssO/WEsz2B7EQHsy
        QWpU09NIT0gqU2AlJ5gEwyvZqXW3Hbq5
X-Google-Smtp-Source: ABdhPJyWykqMLa09jI3ZYxwNtA+a7AHn2stPGV6XWbBnfIDJN88tDaF9BM0f32yrEgfWtxVJX4Gyd9cPVVKv
X-Received: from bg.sfo.corp.google.com ([2620:15c:8:10:b047:e98d:2134:b4dd])
 (user=bgeffon job=sendgmr) by 2002:a17:902:b908:b029:e6:3e0a:b3cc with SMTP
 id bf8-20020a170902b908b02900e63e0ab3ccmr7328154plb.68.1616523936041; Tue, 23
 Mar 2021 11:25:36 -0700 (PDT)
Date:   Tue, 23 Mar 2021 11:25:19 -0700
In-Reply-To: <20210323182520.2712101-1-bgeffon@google.com>
Message-Id: <20210323182520.2712101-3-bgeffon@google.com>
Mime-Version: 1.0
References: <20210303175235.3308220-1-bgeffon@google.com> <20210323182520.2712101-1-bgeffon@google.com>
X-Mailer: git-send-email 2.31.0.291.g576ba9dcdaf-goog
Subject: [PATCH v5 3/3] selftests: Add a MREMAP_DONTUNMAP selftest for shmem
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
2.31.0.291.g576ba9dcdaf-goog

