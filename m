Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF36393721
	for <lists+linux-kernel@lfdr.de>; Thu, 27 May 2021 22:24:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236884AbhE0U0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 May 2021 16:26:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:55487 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236555AbhE0UZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 May 2021 16:25:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622147035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uq4QT2ZrcVHt/byJv1ujYeldpYEbg+Q7RaFfi3UPyeE=;
        b=FZTxNBvpTr/Ga04GkNtXwe/Dbds5oYUHayrqFGVfOEzJcOXdJqcGUuCi7wbggMxktO22x+
        nj8UIYUWd/40fpmkdGjn3+q4ACL14T9oVM41Iusc0NkjY1B6ShzzyrvOCeXEV21nscGWXC
        Tu5uH++7cHPfeBZPg+zH/l3luD4qMM0=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-7NtOck53P_GvZI-VBHXh1g-1; Thu, 27 May 2021 16:23:54 -0400
X-MC-Unique: 7NtOck53P_GvZI-VBHXh1g-1
Received: by mail-qt1-f199.google.com with SMTP id b20-20020ac87fd40000b02901e1370c5e12so853244qtk.17
        for <linux-kernel@vger.kernel.org>; Thu, 27 May 2021 13:23:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uq4QT2ZrcVHt/byJv1ujYeldpYEbg+Q7RaFfi3UPyeE=;
        b=VkQ0z5KD0C5BKIls/zhkKnYDEwScw1bZmU3pAaHXHM0yxUcvsruUSHh0UnY3sZhB81
         hDiMpLOvsB0i3ogkHb7a9x588aVRbghHOKwHBfjywjaqw9o6fbvgw2koBZ8upZT9FgSX
         6GyHmD8CuCbNFfUrMZfoe/pJvH4TpvvQ5yDD9AuEf2fD2NFtzK556Bh5OaUPwTvf7syv
         NuunT9cBwkKBSOgNjHLhgOg1p9rPDVnQWAxWm2lV+11vPoogG4o3pPGBHtkkyEF/tJMa
         M5eU1MhyVQVoLLL91JKIgVOiAOx2p48xHO5imLsYDDJW2RL4Pnx6JUoiJX/f0kByyLbF
         FHgA==
X-Gm-Message-State: AOAM531mB55y2QeeqOhNjiLNk/zb4CJ3J+Dj6pQ8xg5xls/ikpfTonf2
        z/PaHGraVK8U4vfiZYOGXNWtfZXA93XbygQrYkPrEbYEmHbIVRuBK2VuM4bnlBarBYmGwp0T7Kw
        ohGrQyNxy4sZaLTfJ/kT7gnjNQqlokznJT/ACKSydovinC1tZSQLvpMck22chVSTbT5/26UxXdw
        ==
X-Received: by 2002:ac8:5484:: with SMTP id h4mr360844qtq.338.1622147033063;
        Thu, 27 May 2021 13:23:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3zi5PoIwHGhlPFnbYVnDOeLkXM0Dn9r4qegg3oaBy1B1xbjvo3TJ2sVyd9Gu8IcG8naBLlA==
X-Received: by 2002:ac8:5484:: with SMTP id h4mr360813qtq.338.1622147032703;
        Thu, 27 May 2021 13:23:52 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id w4sm1981299qki.57.2021.05.27.13.23.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 13:23:52 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>, peterx@redhat.com,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>
Subject: [PATCH v3 27/27] userfaultfd/selftests: Enable uffd-wp for shmem/hugetlbfs
Date:   Thu, 27 May 2021 16:23:48 -0400
Message-Id: <20210527202348.32406-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210527201927.29586-1-peterx@redhat.com>
References: <20210527201927.29586-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After we added support for shmem and hugetlbfs, we can turn uffd-wp test on
always now.

Define HUGETLB_EXPECTED_IOCTLS to avoid using UFFD_API_RANGE_IOCTLS_BASIC,
because UFFD_API_RANGE_IOCTLS_BASIC is normally a superset of capabilities,
while the test may not satisfy them all.  E.g., when hugetlb registered without
minor mode, then we need to explicitly remove _UFFDIO_CONTINUE.  Same thing to
uffd-wp, as we'll need to explicitly remove _UFFDIO_WRITEPROTECT if not
registered with uffd-wp.

For the long term, we may consider dropping UFFD_API_* macros completely from
uapi/linux/userfaultfd.h header files, because it may cause kernel header
update to easily break userspace.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index e363bdaff59d..015f2df8ece4 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -80,7 +80,7 @@ static int test_type;
 static volatile bool test_uffdio_copy_eexist = true;
 static volatile bool test_uffdio_zeropage_eexist = true;
 /* Whether to test uffd write-protection */
-static bool test_uffdio_wp = false;
+static bool test_uffdio_wp = true;
 /* Whether to test uffd minor faults */
 static bool test_uffdio_minor = false;
 
@@ -320,6 +320,9 @@ struct uffd_test_ops {
 					 (1 << _UFFDIO_ZEROPAGE) | \
 					 (1 << _UFFDIO_WRITEPROTECT))
 
+#define HUGETLB_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) |	\
+					 (1 << _UFFDIO_COPY))
+
 static struct uffd_test_ops anon_uffd_test_ops = {
 	.expected_ioctls = ANON_EXPECTED_IOCTLS,
 	.allocate_area	= anon_allocate_area,
@@ -335,7 +338,7 @@ static struct uffd_test_ops shmem_uffd_test_ops = {
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-	.expected_ioctls = UFFD_API_RANGE_IOCTLS_BASIC & ~(1 << _UFFDIO_CONTINUE),
+	.expected_ioctls = HUGETLB_EXPECTED_IOCTLS,
 	.allocate_area	= hugetlb_allocate_area,
 	.release_pages	= hugetlb_release_pages,
 	.alias_mapping = hugetlb_alias_mapping,
@@ -1580,8 +1583,6 @@ static void set_test_type(const char *type)
 	if (!strcmp(type, "anon")) {
 		test_type = TEST_ANON;
 		uffd_test_ops = &anon_uffd_test_ops;
-		/* Only enable write-protect test for anonymous test */
-		test_uffdio_wp = true;
 	} else if (!strcmp(type, "hugetlb")) {
 		test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
-- 
2.31.1

