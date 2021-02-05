Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C136B31118A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Feb 2021 20:54:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233025AbhBESLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Feb 2021 13:11:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32745 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233161AbhBEPUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Feb 2021 10:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612544462;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Co5gWVPolRGWSV6qsroagZOgnBTQI/bBXcBdWtmnAnQ=;
        b=F9I4UrJHrcHkwkIkEoQEZGYoBXZit/X3qcyNoC5c75qeKeigtU2FWk8h/7Hfs4KwDMmqtl
        w5RP3HUgikaf4vy2kzHbtLJVvDwHIt78EMFgLiPlprp8SemO6Ka4z9Na6JiBuYYLuPpaqR
        RZmeh+q+U6mzAhzmE68RM0HE72QFB5o=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-kvvM53MLMdeAQ_KpZE43HQ-1; Fri, 05 Feb 2021 11:53:35 -0500
X-MC-Unique: kvvM53MLMdeAQ_KpZE43HQ-1
Received: by mail-qk1-f199.google.com with SMTP id 70so6355560qkh.4
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 08:53:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Co5gWVPolRGWSV6qsroagZOgnBTQI/bBXcBdWtmnAnQ=;
        b=DBWgQ13Ga9b+hYGynP5VXbs6fvoYI2YA6c/kEw91DftjITzAIjFCwhU0keWcQSSsLA
         huRF4BQAOgr/mk44QupORm7KxV0uK6hHNrXAfuV3NdfYZqf9wbevPA5BXW91JNQ2x4V7
         koDqcQeov5UQhWiQFL3IfjtdJWBXwdDCoEr6w9eFHeIsL2dlYLCeXXsSMFFKC8TcK5M1
         LJ2/8YlYb33tJmPn6rjfGVD2lyjtoWJ30KU2n45qdcUQEXdVwHUJS2b+FOyH7FrGsowC
         3tb1mo6FhhadSkxn6vplGXmZDMIMP9YpFmNRzY9m8ODghmGOVnwn20qIa3vIsHA+KVus
         qSRw==
X-Gm-Message-State: AOAM5309egyIvEngMiEb3a2mB4hDRGiq3AKAJN03fLSrmLAKXbcuRPW8
        dZzinYxHCmeS3x+xo4G0KZNwqj+uwOmyMQl1UMOh6hIUP4UXDA5yzM7AkeLvSzg1IsxxXvkRrnC
        YTwl5Psa8AXcBqJ4QcNtWc16B
X-Received: by 2002:aed:3aa2:: with SMTP id o31mr822972qte.353.1612544014513;
        Fri, 05 Feb 2021 08:53:34 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyKc6PYm/orcl/kVkLHYNyCRK5wd2QouIxAqDztwVwMw7bYTeEXrpzk1qdQmoRBmevHeSICGw==
X-Received: by 2002:aed:3aa2:: with SMTP id o31mr822948qte.353.1612544014300;
        Fri, 05 Feb 2021 08:53:34 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id 12sm9618893qkg.39.2021.02.05.08.53.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 08:53:33 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Gal Pressman <galpress@amazon.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jann Horn <jannh@google.com>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Mike Kravetz <mike.kravetz@oracle.com>, peterx@redhat.com,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Wei Zhang <wzam@amazon.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3 2/5] hugetlg: Break earlier in add_reservation_in_range() when we can
Date:   Fri,  5 Feb 2021 11:54:03 -0500
Message-Id: <20210205165406.4655-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210205165406.4655-1-peterx@redhat.com>
References: <20210205165406.4655-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All the regions maintained in hugetlb reserved map is inclusive on "from" but
exclusive on "to".  We can break earlier even if rg->from==t because it already
means no possible intersection.

This does not need a Fixes in all cases because when it happens (rg->from==t)
we'll not break out of the loop while we should, however the next thing we'd do
is still add the last file_region we'd need and quit the loop in the next
round.  So this change is not a bugfix (since the old code should still run
okay iiuc), but we'd better still touch it up to make it logically sane.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 mm/hugetlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index ec8e29c805fe..71ccec5c3817 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -387,7 +387,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 		/* When we find a region that starts beyond our range, we've
 		 * finished.
 		 */
-		if (rg->from > t)
+		if (rg->from >= t)
 			break;
 
 		/* Add an entry for last_accounted_offset -> rg->from, and
-- 
2.26.2

