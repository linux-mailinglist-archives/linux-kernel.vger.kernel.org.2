Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4132244FFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Nov 2021 09:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237644AbhKOIKT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 03:10:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21608 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236473AbhKOIHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 03:07:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636963462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4fjb0FATaPAZrC5jaWcL/YcRV73dv6wRjJXclwNYe0A=;
        b=TbXrwHecfoJ2dfJpwu8uDbDYDzHyw2fI/seeffoxm+ZO8CaLYilnap+Zz3cWwca0mJCIja
        lboWijRPm6malHDi2LiEbQbCuQQgNlMO0TfmSA+k2oE+DQwvLgNJhzpti5XuOcU0AMluFT
        HoSlTNdJZLu3Ilb0TftL7pp1l71SUi8=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-uW_dCalTMI6C8AQivBJRNg-1; Mon, 15 Nov 2021 03:04:21 -0500
X-MC-Unique: uW_dCalTMI6C8AQivBJRNg-1
Received: by mail-pj1-f72.google.com with SMTP id x18-20020a17090a789200b001a7317f995cso8234480pjk.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Nov 2021 00:04:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4fjb0FATaPAZrC5jaWcL/YcRV73dv6wRjJXclwNYe0A=;
        b=J1blzv6UFqn6UE60dakNdVSAssK0yu0bpu3RCASHL50QDzaZmXY3oZZQDdlnv521SL
         GjyGPF6xAmp+lhyBTauJWWmq01Dh/Nfv7WzfbayeSHo7bUj2RtHNbKob/Lqh91LW1X7n
         a0iMuL4BCsIXIivbPyGn2F/9LTF3uIpb6ssTwKppBtfsDAGQLflWHPH210sVyjLpMzx3
         rqiXLb3bbMygitkCiU34iIIwjAAgh1q25/s1Vf1+YBL/a699KzpsspzIMYlTCPQH3sBh
         r+IXWpU0L8HsUBtMoJe/U2taU3C6G5BppxAibHOw/lqh1oYABFzAm1h1RrcB6E/ElA5C
         v72Q==
X-Gm-Message-State: AOAM5337RgsdOz5+hyYVwMsHFPO3bNLgw6MjFJzmo8wRbXapMiMZ0XKM
        rVyEhcyIGsPP9l5XqALc/vMprXbKeHF2VRTI6Gx/J4+I7a7vrkgR/s+WXPY+ELxCkPKWPXP64zr
        PqbvE+UFykQ1FjHxRpsaQznTb
X-Received: by 2002:a05:6a00:1ad0:b0:49f:d04e:78da with SMTP id f16-20020a056a001ad000b0049fd04e78damr32260441pfv.77.1636963459928;
        Mon, 15 Nov 2021 00:04:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwYov+lN99bqz8/ojCZuJTialWNO5qsxTAc2MyPy6CwRqTAK/GxA7hVywDwqPIq9fwS60hHOg==
X-Received: by 2002:a05:6a00:1ad0:b0:49f:d04e:78da with SMTP id f16-20020a056a001ad000b0049fd04e78damr32260406pfv.77.1636963459693;
        Mon, 15 Nov 2021 00:04:19 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.89])
        by smtp.gmail.com with ESMTPSA id d24sm13594745pfn.62.2021.11.15.00.04.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Nov 2021 00:04:19 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Nadav Amit <nadav.amit@gmail.com>, peterx@redhat.com,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jerome Glisse <jglisse@redhat.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v6 23/23] selftests/uffd: Enable uffd-wp for shmem/hugetlbfs
Date:   Mon, 15 Nov 2021 16:04:06 +0800
Message-Id: <20211115080406.75377-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211115075522.73795-1-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After we added support for shmem and hugetlbfs, we can turn uffd-wp test on
always now.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 tools/testing/selftests/vm/userfaultfd.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tools/testing/selftests/vm/userfaultfd.c b/tools/testing/selftests/vm/userfaultfd.c
index 64845be3971d..232cc6083039 100644
--- a/tools/testing/selftests/vm/userfaultfd.c
+++ b/tools/testing/selftests/vm/userfaultfd.c
@@ -81,7 +81,7 @@ static int test_type;
 static volatile bool test_uffdio_copy_eexist = true;
 static volatile bool test_uffdio_zeropage_eexist = true;
 /* Whether to test uffd write-protection */
-static bool test_uffdio_wp = false;
+static bool test_uffdio_wp = true;
 /* Whether to test uffd minor faults */
 static bool test_uffdio_minor = false;
 
@@ -1588,8 +1588,6 @@ static void set_test_type(const char *type)
 	if (!strcmp(type, "anon")) {
 		test_type = TEST_ANON;
 		uffd_test_ops = &anon_uffd_test_ops;
-		/* Only enable write-protect test for anonymous test */
-		test_uffdio_wp = true;
 	} else if (!strcmp(type, "hugetlb")) {
 		test_type = TEST_HUGETLB;
 		uffd_test_ops = &hugetlb_uffd_test_ops;
-- 
2.32.0

