Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626F83C93D2
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jul 2021 00:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbhGNW2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jul 2021 18:28:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40513 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237149AbhGNW2e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jul 2021 18:28:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626301541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Uq4QT2ZrcVHt/byJv1ujYeldpYEbg+Q7RaFfi3UPyeE=;
        b=gk6gMyozUawIZaXoXHSpI2DIz3LDT5aNGHD1Eajj1PNYW0TxauLC1jNgcc89rHJ6OZLQzT
        hX1tFJPeAD5MUK8qmxQRBow6+BGwJMFGmyPjQLnA5/Cp9GXp6C2B/dkIonX53m+JNxin7l
        ij6f2Nl26TAGyWihGBfso+jFaX+1fLc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-Pcq0FE6ZPwOfUiWhnACGJg-1; Wed, 14 Jul 2021 18:25:40 -0400
X-MC-Unique: Pcq0FE6ZPwOfUiWhnACGJg-1
Received: by mail-qk1-f198.google.com with SMTP id i190-20020a3786c70000b02903b54f40b442so2361675qkd.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jul 2021 15:25:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uq4QT2ZrcVHt/byJv1ujYeldpYEbg+Q7RaFfi3UPyeE=;
        b=LnMX8Pr7jkBQ83O4UnLVIBCJlpVDCPZZoeYheWU2qUh73kr20rWK4l0rxgw3Fqx/Yn
         W1b5SyQt84dRdP0zo9tMS4y+5XG5qvA/GpcNCChU3W94cuRltaU56LNtiCHeK365VdLF
         uhnZzxSoODuAwukSKnC9M5F+NpsbLfVxr4MX7NEiV+OnWsYYQSrsEJD4hyFmcWrJ4DsC
         fikXVU70SqXmr2cVct5kHuqPDMx1jwXMY3V92212EUsHBX7QjeZ/NEnrxLxb6ENBEf1A
         sAQ93K9fQu8B96Px5L1UcCy/PgqqL2PhYvX9JLMVs1bEso1bnnyCrYff+Tg7FAOY3bh3
         Jlmw==
X-Gm-Message-State: AOAM5331TaLworbKSeT0p1NIg6VPdfPZOuxh0ewp8iJkjG2+FR1xAe4e
        fVQBGndur63DF2dwat7z4XILfGPt9pKIJcKaozLOgPhKxbRHaONL8QGXIZ+b9Lwe205DFVOghm3
        hT7W2YvuFgzSSenAaYL9GfGEm
X-Received: by 2002:ae9:ea18:: with SMTP id f24mr221975qkg.177.1626301540430;
        Wed, 14 Jul 2021 15:25:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwKWio2waCxeqg1e164RijCKEKXk6rILIQsIZLa2XpqKIZLo+ivNYlFqZ2GZR+4gVoFHCbOFQ==
X-Received: by 2002:ae9:ea18:: with SMTP id f24mr221946qkg.177.1626301540222;
        Wed, 14 Jul 2021 15:25:40 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-65-184-144-111-238.dsl.bell.ca. [184.144.111.238])
        by smtp.gmail.com with ESMTPSA id j22sm1213396qtj.60.2021.07.14.15.25.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:25:39 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        Jerome Glisse <jglisse@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v4 26/26] userfaultfd/selftests: Enable uffd-wp for shmem/hugetlbfs
Date:   Wed, 14 Jul 2021 18:25:36 -0400
Message-Id: <20210714222536.49397-1-peterx@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210714222117.47648-1-peterx@redhat.com>
References: <20210714222117.47648-1-peterx@redhat.com>
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

