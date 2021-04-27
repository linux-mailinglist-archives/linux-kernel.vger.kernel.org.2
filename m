Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB3F736C95D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Apr 2021 18:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238860AbhD0QZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Apr 2021 12:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54768 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237497AbhD0QQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Apr 2021 12:16:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619540166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cr+5e1VLs/HzikgCvktprPaWi0mBnwkwdmGII74N+nI=;
        b=BLqcwTQlp/Y98h2AHlxti9Q1FK3u/Tl4h2bfiExoQmfsXFKnGZLcbt6g20F1jYEEI75CEB
        qt8513L5HfOTk4Zk6hD92utUSgqvzgOUrrBQCrhn4qdnzKect/m++vQfTL4JMK65bai9FT
        cpntPWOYWTbRbfr4eVzlyKNLokdnrAk=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-439-uzGCrtMYPKmpx-gmFy7OoQ-1; Tue, 27 Apr 2021 12:14:02 -0400
X-MC-Unique: uzGCrtMYPKmpx-gmFy7OoQ-1
Received: by mail-qt1-f197.google.com with SMTP id z5-20020a05622a0285b02901b943be06b5so15528164qtw.17
        for <linux-kernel@vger.kernel.org>; Tue, 27 Apr 2021 09:14:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cr+5e1VLs/HzikgCvktprPaWi0mBnwkwdmGII74N+nI=;
        b=IlhYhwKyGrxR3516nCkVxEj4gfrrgaFa87RJ81WEdjvS7R9keA9aFcakamvyN64hwS
         5XfwL8FGqkmgOWUqwYIQfuLCu2Ujh/7kNTpbxbZJ07QIXu/H3ORcdXPDEiLJFaRcT34H
         nFWIX1LlrTRnVegTYmdZaHNvrIZBKfypSCTzI58fUjcLOEhIbl9p3u2cTCL8NVFJ1y7r
         sb26PR6sBD+p6EHYvmYZL4TbKrYCPSBDOVbsaWzdK1suJjH9DXAoWYRUBXC/HmKc1hqs
         EZjn1OYtFS8w+Ta79xWavf8y+eUo+Ed5Bb7LbAbRIUJTkgP0f+vw1e8Uj3ABw7Ch89h8
         RkCg==
X-Gm-Message-State: AOAM533Hczrs8T1cc5u1uefB6YBw8ceXQLaertyr+9onMKkDYpC7Gv+S
        iIigZwiYM63MQjWf9DUYqYcZEBs2u27vwF3eUBIbUhApeU57z9m3ICYrawYNoUmCVQ1Vxx+p0lA
        wIK+XBqUGQic2UVYa7c1rWF0x
X-Received: by 2002:a05:620a:74b:: with SMTP id i11mr14332413qki.445.1619540041875;
        Tue, 27 Apr 2021 09:14:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw5lVjxxW5hAwO00BZZT8kxy+y40eQhnQFXe208ItbjEc0IxNxi5grm6oA/Uy+P+8egT9t04g==
X-Received: by 2002:a05:620a:74b:: with SMTP id i11mr14332387qki.445.1619540041643;
        Tue, 27 Apr 2021 09:14:01 -0700 (PDT)
Received: from xz-x1.redhat.com (bras-base-toroon474qw-grc-77-184-145-104-227.dsl.bell.ca. [184.145.104.227])
        by smtp.gmail.com with ESMTPSA id v66sm3103621qkd.113.2021.04.27.09.14.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 09:14:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v2 24/24] userfaultfd/selftests: Enable uffd-wp for shmem/hugetlbfs
Date:   Tue, 27 Apr 2021 12:13:17 -0400
Message-Id: <20210427161317.50682-25-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210427161317.50682-1-peterx@redhat.com>
References: <20210427161317.50682-1-peterx@redhat.com>
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
index 6339aeaeeff8b..cfa6c0e960e6a 100644
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
 
@@ -299,6 +299,9 @@ struct uffd_test_ops {
 					 (1 << _UFFDIO_ZEROPAGE) | \
 					 (1 << _UFFDIO_WRITEPROTECT))
 
+#define HUGETLB_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) |	\
+					 (1 << _UFFDIO_COPY))
+
 static struct uffd_test_ops anon_uffd_test_ops = {
 	.expected_ioctls = ANON_EXPECTED_IOCTLS,
 	.allocate_area	= anon_allocate_area,
@@ -314,7 +317,7 @@ static struct uffd_test_ops shmem_uffd_test_ops = {
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-	.expected_ioctls = UFFD_API_RANGE_IOCTLS_BASIC & ~(1 << _UFFDIO_CONTINUE),
+	.expected_ioctls = HUGETLB_EXPECTED_IOCTLS,
 	.allocate_area	= hugetlb_allocate_area,
 	.release_pages	= hugetlb_release_pages,
 	.alias_mapping = hugetlb_alias_mapping,
@@ -1374,8 +1377,6 @@ static void set_test_type(const char *type)
 	if (!strcmp(type, "anon")) {
 		test_type = TEST_ANON;
 		uffd_test_ops = &anon_uffd_test_ops;
-		/* Only enable write-protect test for anonymous test */
-		test_uffdio_wp = true;
 	} else if (!strcmp(type, "hugetlb")) {
 		test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
-- 
2.26.2

