Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DC8D416875
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 01:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243572AbhIWX0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 19:26:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51489 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235628AbhIWX0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 19:26:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632439517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OWRAOD1kkJz6XiLKgu5hMtfHp+8QmnStWvfGHKzXlyc=;
        b=Wr3SIZjYeKpBAdXEqHAKLFcdCA5WochYFrB/UjnnUoO1ZZVdx+ADJN7oxq9WTVoMswFOo2
        WZEiup0qo8S+shpQWgeasK6fc3VNy/Wt/zpoAN+gFzcusoi34CAA5xcRDnWv4lzdaCWr1I
        16/pLeCnGWzUHoz39KGjfgnAzffzSNs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-517-3cV8sqWhM1SBJi_04eItKw-1; Thu, 23 Sep 2021 19:25:15 -0400
X-MC-Unique: 3cV8sqWhM1SBJi_04eItKw-1
Received: by mail-qk1-f198.google.com with SMTP id w17-20020ae9e511000000b00431497430b7so27194405qkf.12
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 16:25:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OWRAOD1kkJz6XiLKgu5hMtfHp+8QmnStWvfGHKzXlyc=;
        b=SxKIkMfBuov1tqbdcbcfLNBoPcleHCLt1M1/W0GygT1O2ITul+8FvnDUdMA61A9L5i
         gRb9rKOMBGNnQ64bYwkrRES3qX518DIWNzVhcb07pMxy2+AsWVUCd+R9WsNyCGwmNekT
         e84/mjjFoIeE55CKgc1SpBH+8myNqgrP95MIN8mDJVq0yVDiGbFZRnZ56Jrp6SUJvCO8
         jFdtNE7/s5/d1I+SUveuhoVmxiB4ldM4Hw/kT2dOqa2KgnP3TJ5YQq/irwRHFGarxPDg
         H2Mgg0P/ySyC8FB37ILQ06tx6onsqPbUX9wIWCkiTFrWp5cNeq1jGS0tMDSXoVFvVrsd
         fvow==
X-Gm-Message-State: AOAM531LUAzUQoBw0xM055RtN1YjxDIuxsdX89LNdgqCH+E8WzxUHHhS
        S3NWRBYQDoqBaZn7u/4t/rjq8Kg+5pbRZ5lk5JXABJLTfNVa/ZfIFGCJUEP1vtxThT1g1a6pnxC
        JbeQ+P5UucBAxoifCgDH9H1pC
X-Received: by 2002:ac8:1090:: with SMTP id a16mr1290805qtj.297.1632439515393;
        Thu, 23 Sep 2021 16:25:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy364R1AwTCp7sR65ye1IseTJYrbscmW58fi4R3hUU0BoOV0BwbaQiLicMBWVS9rIkTkrmN4A==
X-Received: by 2002:ac8:1090:: with SMTP id a16mr1290769qtj.297.1632439515055;
        Thu, 23 Sep 2021 16:25:15 -0700 (PDT)
Received: from t490s.redhat.com ([2607:fea8:56a2:9100::d3ec])
        by smtp.gmail.com with ESMTPSA id q192sm5170112qka.93.2021.09.23.16.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 16:25:14 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>, Li Wang <liwan@redhat.com>
Subject: [PATCH] mm/userfaultfd: selftests: Fix memory corruption with thp enabled
Date:   Thu, 23 Sep 2021 19:25:12 -0400
Message-Id: <20210923232512.210092-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In RHEL's gating selftests we've encountered memory corruption in the uffd
event test even with upstream kernel:

        # ./userfaultfd anon 128 4
        nr_pages: 32768, nr_pages_per_cpu: 32768
        bounces: 3, mode: rnd racing read, userfaults: 6240 missing (6240) 14729 wp (14729)
        bounces: 2, mode: racing read, userfaults: 1444 missing (1444) 28877 wp (28877)
        bounces: 1, mode: rnd read, userfaults: 6055 missing (6055) 14699 wp (14699)
        bounces: 0, mode: read, userfaults: 82 missing (82) 25196 wp (25196)
        testing uffd-wp with pagemap (pgsize=4096): done
        testing uffd-wp with pagemap (pgsize=2097152): done
        testing events (fork, remap, remove): ERROR: nr 32427 memory corruption 0 1 (errno=0, line=963)
        ERROR: faulting process failed (errno=0, line=1117)

It can be easily reproduced when global thp enabled, which is the default for
RHEL.

It's also known as a side effect of commit 0db282ba2c12 ("selftest: use mmap
instead of posix_memalign to allocate memory", 2021-07-23), which is imho right
itself on using mmap() to make sure the addresses will be untagged even on arm.

The problem is, for each test we allocate buffers using two allocate_area()
calls.  We assumed these two buffers won't affect each other, however they
could, because mmap() could have found that the two buffers are near each other
and having the same VMA flags, so they got merged into one VMA.

It won't be a big problem if thp is not enabled, but when thp is agressively
enabled it means when initializing the src buffer it could accidentally setup
part of the dest buffer too when there's a shared THP that overlaps the two
regions.  Then some of the dest buffer won't be able to be trapped by
userfaultfd missing mode, then it'll cause memory corruption as described.

To fix it, do release_pages() after initializing the src buffer.

Since the previous two release_pages() calls are after uffd_test_ctx_clear()
which will unmap all the buffers anyway (which is stronger than release pages;
as unmap() also tear town pgtables), drop them as they shouldn't really be
anything useful.

We can mark the Fixes tag upon 0db282ba2c12 as it's reported to only happen
there, however the real "Fixes" IMHO should be 8ba6e8640844, as before that
commit we'll always do explicit release_pages() before registration of uffd,
and 8ba6e8640844 changed that logic by adding extra unmap/map and we didn't
release the pages at the right place.  Meanwhile I don't have a solid glue
anyway on whether posix_memalign() could always avoid triggering this bug,
hence it's safer to attach this fix to commit 8ba6e8640844.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
Cc: Nadav Amit <nadav.amit@gmail.com>
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1994931
Fixes: 8ba6e8640844 ("userfaultfd/selftests: reinitialize test context in each test")
Reported-by: Li Wang <liwan@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 10ab56c2484a..60aa1a4fc69b 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -414,9 +414,6 @@ static void uffd_test_ctx_init_ext(uint64_t *features)
 	uffd_test_ops->allocate_area((void **)&area_src);
 	uffd_test_ops->allocate_area((void **)&area_dst);
 
-	uffd_test_ops->release_pages(area_src);
-	uffd_test_ops->release_pages(area_dst);
-
 	userfaultfd_open(features);
 
 	count_verify = malloc(nr_pages * sizeof(unsigned long long));
@@ -437,6 +434,26 @@ static void uffd_test_ctx_init_ext(uint64_t *features)
 		*(area_count(area_src, nr) + 1) = 1;
 	}
 
+	/*
+	 * After initialization of area_src, we must explicitly release pages
+	 * for area_dst to make sure it's fully empty.  Otherwise we could have
+	 * some area_dst pages be errornously initialized with zero pages,
+	 * hence we could hit memory corruption later in the test.
+	 *
+	 * One example is when THP is globally enabled, above allocate_area()
+	 * calls could have the two areas merged into a single VMA (as they
+	 * will have the same VMA flags so they're mergeable).  When we
+	 * initialize the area_src above, it's possible that some part of
+	 * area_dst could have been faulted in via one huge THP that will be
+	 * shared between area_src and area_dst.  It could cause some of the
+	 * area_dst won't be trapped by missing userfaults.
+	 *
+	 * This release_pages() will guarantee even if that happened, we'll
+	 * proactively split the thp and drop any accidentally initialized
+	 * pages within area_dst.
+	 */
+	uffd_test_ops->release_pages(area_dst);
+
 	pipefd = malloc(sizeof(int) * nr_cpus * 2);
 	if (!pipefd)
 		err("pipefd");
-- 
2.31.1

