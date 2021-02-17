Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0716E31E312
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Feb 2021 00:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbhBQXh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Feb 2021 18:37:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51129 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232783AbhBQXhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Feb 2021 18:37:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613604955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DOLBpO+jIc7m6kTzABHfMZhxUnbe7uQo4h61IVSpjcg=;
        b=OJ61kkM2Ul6iuLexMh3tNBXygEYWF5HUIReGh4eY6QYPIrASKcvskwlfLCNNtirrRD3jnC
        ZRfB6I312kpHpZmP1rvLz542FNpbTnRXW6bU1iUbS0orPIgeoCSE6kMyh1l6q5vRsCZ6Ap
        nAwMwYwsdnq6KcVggpXxItbCXvsJjJw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-132-46jfCvHYPdCQMH9rLYaPqw-1; Wed, 17 Feb 2021 18:35:53 -0500
X-MC-Unique: 46jfCvHYPdCQMH9rLYaPqw-1
Received: by mail-qt1-f198.google.com with SMTP id r18so72667qta.19
        for <linux-kernel@vger.kernel.org>; Wed, 17 Feb 2021 15:35:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DOLBpO+jIc7m6kTzABHfMZhxUnbe7uQo4h61IVSpjcg=;
        b=ts2tGwxqY+B4X5qb6YAgmu7954gKz88Y3wVSDc6vNV+hB3nlqUnQPRHkkaOb8cVZqE
         aIxi/YqtLSYnZCrG9Z24L6yXjz9gqRbGiOj0befap9wACS/lwdDw8zaosLwxhWEcmXMn
         LdW6Z6OsKSYjdQ3F8qvJbKQ6+nBY8R2h/wPPTQAyRq8bbGteT5J7L73BFo1jpnY90hEt
         VVyIwfLMY20yK/Op6TLPYsC5sSFUQELks940wnQ/dJXWCuZNmfKzJJc2+c1PJOsD6qYS
         P93/xvfyqFdJPn1mglm5tMJW6I1F9yIodv+gbLtun/+5Ib2f6K2vPjcIpXVA8JuL948p
         0v6g==
X-Gm-Message-State: AOAM5312/BT5U+r1vd8cdDrh4mVB6AAhU+eqMaM3l59OouO1m0k4QQaS
        HPmtVfYAoCsoKnUQblK8ay/uO4Pd79IoO+RYUFQpWhmMBdgRKmHSqeGaljAJmSaOrhQGUDPmM3J
        /719U4FZTHjzCXwioeuTOlOUB
X-Received: by 2002:ac8:149a:: with SMTP id l26mr1755903qtj.210.1613604953405;
        Wed, 17 Feb 2021 15:35:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzkPF9IdEx/0qho199ZELPwh7tKPt6adZyOrtuP5Au+UOQSOmMOTUV01IpIZiH6otG3JNuBHw==
X-Received: by 2002:ac8:149a:: with SMTP id l26mr1755887qtj.210.1613604953196;
        Wed, 17 Feb 2021 15:35:53 -0800 (PST)
Received: from xz-x1.redhat.com (bras-vprn-toroon474qw-lp130-20-174-93-89-182.dsl.bell.ca. [174.93.89.182])
        by smtp.gmail.com with ESMTPSA id o5sm2739622qkh.59.2021.02.17.15.35.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Feb 2021 15:35:52 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Gal Pressman <galpress@amazon.com>,
        Matthew Wilcox <willy@infradead.org>,
        Wei Zhang <wzam@amazon.com>, peterx@redhat.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jann Horn <jannh@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Andrea Arcangeli <aarcange@redhat.com>, Jan Kara <jack@suse.cz>
Subject: [PATCH v5 2/5] hugetlg: Break earlier in add_reservation_in_range() when we can
Date:   Wed, 17 Feb 2021 18:35:44 -0500
Message-Id: <20210217233547.93892-3-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210217233547.93892-1-peterx@redhat.com>
References: <20210217233547.93892-1-peterx@redhat.com>
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
index e302ed715839..2ba4ea4ab46e 100644
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

