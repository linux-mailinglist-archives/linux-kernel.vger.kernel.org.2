Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC3183CADC1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 22:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245755AbhGOUUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jul 2021 16:20:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243259AbhGOUUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jul 2021 16:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626380225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uq4QT2ZrcVHt/byJv1ujYeldpYEbg+Q7RaFfi3UPyeE=;
        b=dJGr+9tWcxJVFOrSAQvCbvanYXD6Uv3lCpmWCe+1ftX2HeyWHofQpXgtTBhyy9it1nx84b
        lqdzP7TeM7Gc6d1M8tUrUWv6Z5bZhGYbd6srcTB0TfFXfdFnZTEvilvGHz8tvgjk/wAiuz
        gBpjem8E4NdTrdRvpi7B0c2Vy/aaADQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-fhEItCVHPOK5dcsHuMxfcg-1; Thu, 15 Jul 2021 16:17:04 -0400
X-MC-Unique: fhEItCVHPOK5dcsHuMxfcg-1
Received: by mail-qt1-f197.google.com with SMTP id q1-20020a05622a0301b029025f76cabdfcso1863711qtw.15
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jul 2021 13:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uq4QT2ZrcVHt/byJv1ujYeldpYEbg+Q7RaFfi3UPyeE=;
        b=Ti70jTdWgMSx4XFp+1Q5ojDZqCFNZ0MiCIMO2pAuFHNx6hOgOjO7a3XFx5clTo2C0v
         6gHWR8L+lCOk712xjDM630z5+M55SociliWu1QV13Yj3wGELgdE+X8bVXnpbqAavKVcm
         bUm7XPGrZs31WkXTnFgqAJjZJv22sIfEpizN8j2YbfNSOcb9RKx1O02W1TgcmoTt3X8k
         EsNa4jJbpnFDfc+S8ng+81ZbZfgQ1oLGJShO3bjobF2QtKwwfBaNuryn2O6tgL+1QVST
         XJUCX69BON/qUSS3YM7XiissoOWv0JO6Y2o462SKzdpSMAPPEE05ztnQrGki3XOWlv0d
         lXkw==
X-Gm-Message-State: AOAM532GdpUW4NCVJLrycaWEVUnJy6yjUhoPcPmZILEW9JeAcAGgj4nM
        KT3rl0hfL6NPF8l2FtMTQMRIYN+2EDuqsg3NNqf+hmPl2eF0zcaSfLCaFS8xNmRkxoXgsFoT1DI
        gMkh9s7aGiY7CBKD7fsPMUTXb4VNzqyB8w/m3oSf2dATIlRUjYaXhq3RGHUAHtoq6jJcayhX5fw
        ==
X-Received: by 2002:a37:b6c1:: with SMTP id g184mr5710199qkf.270.1626380223335;
        Thu, 15 Jul 2021 13:17:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxbrAZNsiD+WlVjbF9Hym0cG86ASuwEdZaLrSJFs5JIIdeDGCjL1LWLBPqqYUg16c6SiTTW7g==
X-Received: by 2002:a37:b6c1:: with SMTP id g184mr5710162qkf.270.1626380223071;
        Thu, 15 Jul 2021 13:17:03 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id w6sm471188qtt.36.2021.07.15.13.17.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jul 2021 13:17:02 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, peterx@redhat.com,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Tiberiu Georgescu <tiberiu.georgescu@nutanix.com>,
        Hugh Dickins <hughd@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH v5 26/26] userfaultfd/selftests: Enable uffd-wp for shmem/hugetlbfs
Date:   Thu, 15 Jul 2021 16:16:59 -0400
Message-Id: <20210715201659.212234-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210715201422.211004-1-peterx@redhat.com>
References: <20210715201422.211004-1-peterx@redhat.com>
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

