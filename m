Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5EF3146CC
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Feb 2021 04:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbhBIDF4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 22:05:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29165 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230316AbhBIDFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 22:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612839758;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Co5gWVPolRGWSV6qsroagZOgnBTQI/bBXcBdWtmnAnQ=;
        b=IQH3xpriJb/j/PvH6U9dervKZI5fPGLkSHjeYkV+3uMeitl96UXS7+Wh7F3RepVkXS1yg4
        UUcqtujkOW5g2FuWtbGSQAdXF0jXFf68GihPPFk8/OF2kNcYfMGYdPs0TN3qdyWkW3cT34
        +h0N03qO9lwjG1GyoA5bXRLLCsTUUpg=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-G0PD5cvHOmGk7n3RZgAqow-1; Mon, 08 Feb 2021 22:02:36 -0500
X-MC-Unique: G0PD5cvHOmGk7n3RZgAqow-1
Received: by mail-qt1-f200.google.com with SMTP id v22so3924168qto.16
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 19:02:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Co5gWVPolRGWSV6qsroagZOgnBTQI/bBXcBdWtmnAnQ=;
        b=aDVyEtCj3b+WlZgDyHhE6q8k1kVWNXGoUvxcUx1bNXCagOrszKKy9NAZ4+eYmRRrAH
         DkivFdJFSmKFFIaOQRj4or0RFtyJWrRe8cNjN1WnSqEt36yLt6tmXBZoStlQpola0rU2
         nmPRZCsk81Mkwl3nmpqw30rSu8xKNDwjRbE8VJDFelKw8srgcCiIBwjFA2LRS+fP9VYn
         9dZRLzTXWkPao+1E5LyqyZWZSIR63p8Zo5j2dtYD5BP94CwHLGZuGT5vV4Ax8NhQMC7I
         HfrQbjm2u1sqepn/GhdeG6UQj+tJYoYGVmf74fAig1ivIqiABiV/XaJCTjXxd1B1VWs/
         H1Cw==
X-Gm-Message-State: AOAM533WuFWWJ6z+3E7UEmHcrptKm03PLLEsBCli3gkQCgH7vRsz7hcj
        ANf6oK5Q+JC8vBz3c+EHowum/diJPm4t4lzY7LTQETNIZ251sk6iNEoGRcoD5Jfrdz/0188Ul+A
        UEeHAxnkfeb3ty3XMUZpqquyg
X-Received: by 2002:a37:9bcb:: with SMTP id d194mr20914249qke.217.1612839756158;
        Mon, 08 Feb 2021 19:02:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz2pULQFQQt0HU+IE5y/rbbIFYnrd2LL3d0zubsXk3enhPFegynpvAbmbfc+/W5MTm1VEszLA==
X-Received: by 2002:a37:9bcb:: with SMTP id d194mr20914224qke.217.1612839755945;
        Mon, 08 Feb 2021 19:02:35 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id z20sm17078830qki.93.2021.02.08.19.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 19:02:35 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        David Gibson <david@gibson.dropbear.id.au>,
        Kirill Shutemov <kirill@shutemov.name>,
        Christoph Hellwig <hch@lst.de>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Gal Pressman <galpress@amazon.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        peterx@redhat.com, Jan Kara <jack@suse.cz>,
        Wei Zhang <wzam@amazon.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v4 2/5] hugetlg: Break earlier in add_reservation_in_range() when we can
Date:   Mon,  8 Feb 2021 22:02:26 -0500
Message-Id: <20210209030229.84991-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210209030229.84991-1-peterx@redhat.com>
References: <20210209030229.84991-1-peterx@redhat.com>
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

