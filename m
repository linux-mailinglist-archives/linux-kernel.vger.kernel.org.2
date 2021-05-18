Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 757083881BF
	for <lists+linux-kernel@lfdr.de>; Tue, 18 May 2021 22:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352287AbhERU6j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 May 2021 16:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:47569 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230157AbhERU6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 May 2021 16:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621371440;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=os9Jf6J1kMn1gZUBBCbgzerMPhCA2LxWWK/nSdgqiLA=;
        b=g+dVgVDrpdhNdOGo9Jte+XeQfjC5V1WMiEZvSbYGBUzbaPZuqNhsILowxyEX8sYqKcs3ve
        P7pzbQoQBKhNFTIAT0nFwofvn7ugioIjB9ntRumAAx5KMSV22hbW3T8T1MY4bA9hDkBpvA
        UZ/lywFXmosb5oyZ93qGRSWoBeHovJM=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-wf9ntZ3mP369onZGXiVLdQ-1; Tue, 18 May 2021 16:57:18 -0400
X-MC-Unique: wf9ntZ3mP369onZGXiVLdQ-1
Received: by mail-qk1-f198.google.com with SMTP id g184-20020a3784c10000b02902e385de9adaso8123332qkd.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 May 2021 13:57:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=os9Jf6J1kMn1gZUBBCbgzerMPhCA2LxWWK/nSdgqiLA=;
        b=Dxytf1UHw0sfabzFxaE3fk0Cohz3xle4nNg+YYnCD8xhEMyKcNmKOp/44v2jvPzoBJ
         cDk8Mw242vETljJQl8gcNzh5ejYrfVSXTl7TITA+87Vk3UOcZE0yKw/sWBhriX9jF+nJ
         z9qge08u/QHxZoq7ov0JOUxYrcXu7c945/5W0hW8D5w+JWvWsVXahF9dcfklOBHF6ZgO
         TEjSesShk/R8P9SQ4R4JOxy7/kSZkHURyeIoylyjXEOydoUlNXmLNEgqN8voDQz+ApuU
         uLpuytqlKIWVeebMaWxszQcIjU5lbYbyVJiuWz7nTB16MTAVlZvzU+T5UkW1kv3Icw5T
         GDDA==
X-Gm-Message-State: AOAM532fCKT2O50dWBJ5IqoPaAhMj2OrHHnd5d13ytihY9ulo5Q0mgtK
        qLkqfzA1NuAkTzYUEhWUbVgBfDwtJwiA6D9BCQ7uR4ohDt0VSUgrZJ+NnIqIdTftkkakU9sUSEL
        /arcxLu9rwhooHrbjQXc+pSIg
X-Received: by 2002:a0c:fd44:: with SMTP id j4mr8481108qvs.12.1621371437467;
        Tue, 18 May 2021 13:57:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxPbtPTS7GA1DjU4twlKSNhyrANpoU7alV6mW8IiMGHJyAqzzJ6TCOkFpMmZKf7mBAGJ5Mb2g==
X-Received: by 2002:a0c:fd44:: with SMTP id j4mr8481084qvs.12.1621371437207;
        Tue, 18 May 2021 13:57:17 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id 64sm2637797qkn.87.2021.05.18.13.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 May 2021 13:57:16 -0700 (PDT)
Date:   Tue, 18 May 2021 16:57:14 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Joe Perches <joe@perches.com>,
        Lokesh Gidra <lokeshgidra@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Shaohua Li <shli@fb.com>, Shuah Khan <shuah@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Wang Qing <wangqing@vivo.com>, linux-api@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        Brian Geffon <bgeffon@google.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Mina Almasry <almasrymina@google.com>,
        Oliver Upton <oupton@google.com>
Subject: Re: [PATCH v5 09/10] userfaultfd/selftests: reinitialize test
 context in each test
Message-ID: <YKQqKrl+/cQ1utrb@t490s>
References: <20210427225244.4326-1-axelrasmussen@google.com>
 <20210427225244.4326-10-axelrasmussen@google.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="D6+R1HeMtL7GYPqG"
Content-Disposition: inline
In-Reply-To: <20210427225244.4326-10-axelrasmussen@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--D6+R1HeMtL7GYPqG
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Apr 27, 2021 at 03:52:43PM -0700, Axel Rasmussen wrote:
> Currently, the context (fds, mmap-ed areas, etc.) are global. Each test
> mutates this state in some way, in some cases really "clobbering it"
> (e.g., the events test mremap-ing area_dst over the top of area_src, or
> the minor faults tests overwriting the count_verify values in the test
> areas). We run the tests in a particular order, each test is careful to
> make the right assumptions about its starting state, etc.
> 
> But, this is fragile. It's better for a test's success or failure to not
> depend on what some other prior test case did to the global state.
> 
> To that end, clear and reinitialize the test context at the start of
> each test case, so whatever prior test cases did doesn't affect future
> tests.
> 
> This is particularly relevant to this series because the events test's
> mremap of area_dst screws up assumptions the minor fault test was
> relying on. This wasn't a problem for hugetlb, as we don't mremap in
> that case.
> 
> Signed-off-by: Axel Rasmussen <axelrasmussen@google.com>

Hi, Andrew,

There's a conflict on the uffd test case with v5.13-rc1-mmots-2021-05-13-17-23
between this patch and the uffd pagemap series, so I think we may need to queue
another fixup patch (to be squashed into this patch of Axel's) which is
attached.

Thanks,

-- 
Peter Xu

--D6+R1HeMtL7GYPqG
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment;
	filename="0001-fixup-userfaultfd-selftests-reinitialize-test-contex.patch"

From 745402175cc5670475df8e6c6bd03b6268f4175d Mon Sep 17 00:00:00 2001
From: Peter Xu <peterx@redhat.com>
Date: Tue, 18 May 2021 16:50:36 -0400
Subject: [PATCH] fixup! userfaultfd/selftests: reinitialize test context in
 each test

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index c4150b4fbd17..f78816130c7f 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -1326,7 +1326,7 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 	/* Flush so it doesn't flush twice in parent/child later */
 	fflush(stdout);
 
-	uffd_test_ops->release_pages(area_dst);
+	uffd_test_ctx_init(0);
 
 	if (test_pgsize > page_size) {
 		/* This is a thp test */
@@ -1338,9 +1338,6 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 			err("madvise(MADV_NOHUGEPAGE) failed");
 	}
 
-	if (userfaultfd_open(0))
-		err("userfaultfd_open");
-
 	uffdio_register.range.start = (unsigned long) area_dst;
 	uffdio_register.range.len = nr_pages * page_size;
 	uffdio_register.mode = UFFDIO_REGISTER_MODE_WP;
@@ -1383,7 +1380,6 @@ static void userfaultfd_pagemap_test(unsigned int test_pgsize)
 	pagemap_check_wp(value, false);
 
 	close(pagemap_fd);
-	close(uffd);
 	printf("done\n");
 }
 
-- 
2.31.1


--D6+R1HeMtL7GYPqG--

