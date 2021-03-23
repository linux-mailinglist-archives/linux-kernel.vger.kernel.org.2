Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92F7534543F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 01:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbhCWAvw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 20:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:43334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231700AbhCWAvF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 20:51:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1616460664;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XCYwl192EbRTTqhTN6RAwmcLAOqLyfsZgbfALtQItf4=;
        b=CYMwJFZni1QfsPNcoNsjRza0rIJSHAcbD1PaBMxUikaGQeFfXElcO77evRNoBp3cY0a0U9
        rV7DHz88V5pxRcfJGcjUA7qQ8pdVH3Q0mR507GyXYWhq+7VdJqXCQCMGmbO7OCDnbUnqnT
        oi2VJVUR2JQr4GktOecqf2wHAa/tkug=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-S74Aj0lPMRmdYsk7NmGtDQ-1; Mon, 22 Mar 2021 20:51:02 -0400
X-MC-Unique: S74Aj0lPMRmdYsk7NmGtDQ-1
Received: by mail-qk1-f197.google.com with SMTP id u5so812923qkj.10
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 17:51:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XCYwl192EbRTTqhTN6RAwmcLAOqLyfsZgbfALtQItf4=;
        b=h5G7ISpeXeaI1xp/NzLCxjYEyBFv5qliaPIOHj0wj4uzFl+DW8CnhI9jL35/awapt8
         KCN3DaLe6cxCAJQfB5UAGQN9/zdR8NP5aQ1N11wefF+TN99JQcyY43WM4lDEZwoZFG+P
         l5hGgZkoK6TP+Lr5uhpgd/ZF2zp5cz/fF45VZZX1VZantY/nqx8AgpZ/sUMHchnHzM5H
         bymPyjotrLKXhFM2BNlsu0v1hocRdBHUaIH01PxUAhJ8uPrYpgw0rRQenhgw+Z77O1F7
         tZi3A3X4FFmhKgj+NxjhEGfk3ML1xkzlCdpoybmQH10BYcZ9INczcBY6gsxb/2NmenE1
         uK3w==
X-Gm-Message-State: AOAM532vIvVZR7y2vcStIZypy1E2jL77YNKijzDk8S0eNwez4t8wiZkM
        sUHi2EPfkOPFLhXwsr8T7blUxBSzKb19SXGT4jhlK4lRP6WGsNME/9UTx6zbHoHsl9/troTczYD
        a7a8HQY6l/BFI5nRx9HBJCs13
X-Received: by 2002:a0c:aa45:: with SMTP id e5mr2400651qvb.44.1616460662156;
        Mon, 22 Mar 2021 17:51:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzz8+ectXkImQeBvED857DjCH8Njpx7f7CDz4cyDPiZa49fT5ITS2E9jSS61/fmqfTmNpQtdw==
X-Received: by 2002:a0c:aa45:: with SMTP id e5mr2400634qvb.44.1616460661914;
        Mon, 22 Mar 2021 17:51:01 -0700 (PDT)
Received: from localhost.localdomain (bras-base-toroon474qw-grc-82-174-91-135-175.dsl.bell.ca. [174.91.135.175])
        by smtp.gmail.com with ESMTPSA id i8sm9816695qtj.16.2021.03.22.17.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 17:51:01 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Jerome Glisse <jglisse@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Axel Rasmussen <axelrasmussen@google.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 23/23] userfaultfd/selftests: Enable uffd-wp for shmem/hugetlbfs
Date:   Mon, 22 Mar 2021 20:50:59 -0400
Message-Id: <20210323005059.36084-1-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210323004912.35132-1-peterx@redhat.com>
References: <20210323004912.35132-1-peterx@redhat.com>
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
index 1f5f9362ec7b..5fa9a506ded5 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -80,7 +80,7 @@ static int test_type;
 static volatile bool test_uffdio_copy_eexist = true;
 static volatile bool test_uffdio_zeropage_eexist = true;
 /* Whether to test uffd write-protection */
-static bool test_uffdio_wp = false;
+static bool test_uffdio_wp = true;
 
 static bool map_shared;
 static int shm_fd;
@@ -319,6 +319,9 @@ struct uffd_test_ops {
 					 (1 << _UFFDIO_ZEROPAGE) | \
 					 (1 << _UFFDIO_WRITEPROTECT))
 
+#define HUGETLB_EXPECTED_IOCTLS		((1 << _UFFDIO_WAKE) |	\
+					 (1 << _UFFDIO_COPY))
+
 static struct uffd_test_ops anon_uffd_test_ops = {
 	.expected_ioctls = ANON_EXPECTED_IOCTLS,
 	.allocate_area	= anon_allocate_area,
@@ -334,7 +337,7 @@ static struct uffd_test_ops shmem_uffd_test_ops = {
 };
 
 static struct uffd_test_ops hugetlb_uffd_test_ops = {
-	.expected_ioctls = UFFD_API_RANGE_IOCTLS_BASIC & ~(1 << _UFFDIO_CONTINUE),
+	.expected_ioctls = HUGETLB_EXPECTED_IOCTLS,
 	.allocate_area	= hugetlb_allocate_area,
 	.release_pages	= hugetlb_release_pages,
 	.alias_mapping = hugetlb_alias_mapping,
@@ -1433,8 +1436,6 @@ static void set_test_type(const char *type)
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

