Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00B530F56D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 15:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236922AbhBDOxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 09:53:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32985 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236886AbhBDOwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:52:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612450243;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BFhiSabHbTK6awvWbCXdRee7Kg5oltAX0WknJbnHBPY=;
        b=Qc/n4OxYVnj0HpHUkAGyh23if2dWgUigEK2c52lUP/80AaxtwLIfi748jjA8cNT3EXH/Ya
        WVoIGm6sWFw3KV6+v1jACpEDrM8IvtkcIj6hlEuZux5IiYVqO+eryCNyYz5if6wSMmwSpT
        H4U3hLg+Oa1rce7YHBzFGsk1p+8TZzo=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-170-8gQO7cEYOPefJxKAyFDEyw-1; Thu, 04 Feb 2021 09:50:39 -0500
X-MC-Unique: 8gQO7cEYOPefJxKAyFDEyw-1
Received: by mail-qt1-f197.google.com with SMTP id m21so2731766qtp.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:50:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BFhiSabHbTK6awvWbCXdRee7Kg5oltAX0WknJbnHBPY=;
        b=MYku1y5iQZkC3x2Tc0ZuFqMjgDgcX2byc6TiJP7xrmywrfjBUNFSTB8PeQDU/QiqYE
         atMJYymlf81N7HU2OMCGATk/Ob2MOlaXViJzLSO93hC2jMXS5D07H8h0ORchQEkOF5Od
         1NNkD8g8nLqLMCLlOvkzxyvOgiNcrRdngCqiKDQUPf60yAxNC+rARSiNcB9n3yXahYO4
         mUUPp6mNoTFfAYqYbfV+RCtaEZE028oLDuJn+2bArQyE+GcTBaeUnokx3WuCYE7VN+aD
         wb2NtXVc250/pntOanH3Ixbo6ruN77h/9HuyJ39YlXjR2D7Pc/5LV03ijAXIdQQZAFcD
         EOfQ==
X-Gm-Message-State: AOAM533irv+vCvg0C0z+hyFZdRYKKQYGq10xcJrCE9JP9WL7I6LWcpKl
        x5YvuxyAmfOLZJR7z036M/sPdaGHdsOVsZEPCwoWDMTSm3Clc62NifHQ3i0KOLf2g8BavxAnArM
        T6KBcPb9mK9yZXQLwwWNw0+Qp
X-Received: by 2002:a0c:ea22:: with SMTP id t2mr7988231qvp.49.1612450239370;
        Thu, 04 Feb 2021 06:50:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyPUkNyHWb+UWJMNEc3cGhB+rAC8gjZRsIwVoa3hAW/lFIuyqXBQa1vuvjUS9s3w6r1pDZpIg==
X-Received: by 2002:a0c:ea22:: with SMTP id t2mr7988208qvp.49.1612450239176;
        Thu, 04 Feb 2021 06:50:39 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id e14sm4697589qte.18.2021.02.04.06.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 06:50:38 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Kirill Shutemov <kirill@shutemov.name>,
        Wei Zhang <wzam@amazon.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        Gal Pressman <galpress@amazon.com>, Jan Kara <jack@suse.cz>,
        Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        David Gibson <david@gibson.dropbear.id.au>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 2/4] hugetlg: Break earlier in add_reservation_in_range() when we can
Date:   Thu,  4 Feb 2021 09:50:31 -0500
Message-Id: <20210204145033.136755-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210204145033.136755-1-peterx@redhat.com>
References: <20210204145033.136755-1-peterx@redhat.com>
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
index d2859c2aecc9..9e6ea96bf33b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -377,7 +377,7 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 		/* When we find a region that starts beyond our range, we've
 		 * finished.
 		 */
-		if (rg->from > t)
+		if (rg->from >= t)
 			break;
 
 		/* Add an entry for last_accounted_offset -> rg->from, and
-- 
2.26.2

