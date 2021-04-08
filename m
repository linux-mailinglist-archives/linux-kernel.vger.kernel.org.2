Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8EBB35907F
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Apr 2021 01:44:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbhDHXoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 19:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbhDHXnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 19:43:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18920C0613D9
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 16:43:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y13so3532793ybk.20
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 16:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5FNNG5JC3AqKoqOHTe9pY2QoEFbztQ33Z0RnEe1qU+U=;
        b=MVh7wJOhgi98eYTGizGpz0fXWcVL+XnU2Bk/6XennU2H8x3R8rGMIne2hUKtCj7Utt
         eSnfsyszk2SbhoLSlZrWVVaFCCE7eaBnQ5J6l6ckDfRSG9fS/h8IJOb2SOBzCo+3dzXO
         OI5agAhrI80ggOIT0sOcuShvr7PEtN1+4RgvSo8SRj1RNTLRThXzJHJy50V71YkNGiD9
         f7ZtDNsM7B929F/Nlvn4FMe3RNuU30g+glCgh228xH0CsSWOBiGHHZU6aC8fvpXBG+A4
         YDSpjEpnYdXYiLnrlVIbzlruOiCQaHz9PQyrr0dhO27DBYS4e6MULLi4YA+jYY3tlHTb
         Wg/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5FNNG5JC3AqKoqOHTe9pY2QoEFbztQ33Z0RnEe1qU+U=;
        b=Q6gLb/2a0Df3IqXxu/kQ9TJQTfp6AHRMTMYMlbC3a68rJKY1o+Re1YNRbk7nQs5Iij
         EmdpK5SOrzbc1Kw69zNtAyN+Es4Z4OlJ4PCRftq5S8I/Kb3b4FhuaHmR9J93hlVC4Jae
         alqy9SFsY5MkR41uYNYzBz76JIykjnzSijJ2zZ7UBbWg1P9TOI5W1FPa1M/PryGphQRP
         +EaSppk/hYHuxUGRPKuSbO00cvLLA9/HHB4nD+8UWih+nOjwcTA74Jqo3LqbBp5uWoy9
         EDlcLA7xG/V2w4Si1RRoe4UJNhnVq6WrC9Go6NBKoeI1R93oKV+Kb3jm9F2ITg9uPr0p
         P+0Q==
X-Gm-Message-State: AOAM530+f86vBcyj3SZqLseThP/QtXgh4IYtD9III8eTN3v+h0lsmCFa
        rN/BCCg0G5vCQxv0vopvLuYTbfbGcZyBQ0XUOE9F
X-Google-Smtp-Source: ABdhPJyHO2FVkr1CboGpSzUwiSg/3NdbiftgLdqxWDrb4ETSP7JCT+1vBZ/v/JbVEtqQcUZRebwBFwQE6Qi+5WAlsHtN
X-Received: from ajr0.svl.corp.google.com ([2620:15c:2cd:203:3d06:d00f:a626:675a])
 (user=axelrasmussen job=sendgmr) by 2002:a25:ad89:: with SMTP id
 z9mr15823267ybi.267.1617925420343; Thu, 08 Apr 2021 16:43:40 -0700 (PDT)
Date:   Thu,  8 Apr 2021 16:43:23 -0700
In-Reply-To: <20210408234327.624367-1-axelrasmussen@google.com>
Message-Id: <20210408234327.624367-6-axelrasmussen@google.com>
Mime-Version: 1.0
References: <20210408234327.624367-1-axelrasmussen@google.com>
X-Mailer: git-send-email 2.31.1.295.g9ea45b61b8-goog
Subject: [PATCH 5/9] userfaultfd/selftests: use memfd_create for shmem test type
From:   Axel Rasmussen <axelrasmussen@google.com>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Colascione <dancol@google.com>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Peter Xu <peterx@redhat.com>, Shaohua Li <shli@fb.com>,
        Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>
Cc:     linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, Axel Rasmussen <axelrasmussen@google.com>,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparatory commit. In the future, we want to be able to setup
alias mappings for area_src and area_dst in the shmem test, like we do
in the hugetlb_shared test. With a VMA obtained via
mmap(MAP_ANONYMOUS | MAP_SHARED), it isn't clear how to do this.

So, mmap() with an fd, so we can create alias mappings. Use memfd_create
instead of actually passing in a tmpfs path like hugetlb does, since
it's more convenient / simpler to run, and works just as well.

Future commits will:

1. Setup the alias mappings.
2. Extend our tests to actually take advantage of this, to test new
   userfaultfd behavior being introduced in this series.

Also, a small fix in the area we're changing: when the hugetlb setup
fails in main(), pass in the right argv[] so we actually print out the
hugetlb file path.

Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 310fc617c383..b0af88b258d7 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -85,6 +85,7 @@ static bool test_uffdio_wp = false;
 static bool test_uffdio_minor = false;
 
 static bool map_shared;
+static int shm_fd;
 static int huge_fd;
 static char *huge_fd_off0;
 static unsigned long long *count_verify;
@@ -278,10 +279,13 @@ static void shmem_release_pages(char *rel_area)
 
 static void shmem_allocate_area(void **alloc_area)
 {
+	unsigned long offset =
+		alloc_area == (void **)&area_src ? 0 : nr_pages * page_size;
+
 	*alloc_area = mmap(NULL, nr_pages * page_size, PROT_READ | PROT_WRITE,
-			   MAP_ANONYMOUS | MAP_SHARED, -1, 0);
+			   MAP_SHARED, shm_fd, offset);
 	if (*alloc_area == MAP_FAILED)
-		err("shared memory mmap failed");
+		err("mmap of memfd failed");
 }
 
 struct uffd_test_ops {
@@ -1446,6 +1450,16 @@ int main(int argc, char **argv)
 			err("Open of %s failed", argv[4]);
 		if (ftruncate(huge_fd, 0))
 			err("ftruncate %s to size 0 failed", argv[4]);
+	} else if (test_type == TEST_SHMEM) {
+		shm_fd = memfd_create(argv[0], 0);
+		if (shm_fd < 0)
+			err("memfd_create");
+		if (ftruncate(shm_fd, nr_pages * page_size * 2))
+			err("ftruncate");
+		if (fallocate(shm_fd,
+			      FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE, 0,
+			      nr_pages * page_size * 2))
+			err("fallocate");
 	}
 	printf("nr_pages: %lu, nr_pages_per_cpu: %lu\n",
 	       nr_pages, nr_pages_per_cpu);
-- 
2.31.1.295.g9ea45b61b8-goog

