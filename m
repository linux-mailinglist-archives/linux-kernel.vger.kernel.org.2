Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6120E33EF33
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Mar 2021 12:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbhCQLHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Mar 2021 07:07:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28188 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231220AbhCQLHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Mar 2021 07:07:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615979233;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U7QOfp9p+MzchxKLedHrk5Ttc2LJwpbyQQVruehX39E=;
        b=OfiHIwW4dwSsi+p1/bruKOtdKCnzfkDBXQJbmrPP08SvGsLruuf30/qxp1WLGIi5aTR+dS
        +uSaQNFKWvIKyxj3VY6/ujxYRqSeRsyfJZD7vWlH/FgrkURVwUzYjtcraFFBC8p5MyCKZA
        IqGEFfEXvui8svZAuYY1uBR+teDscS4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-vdCnRWS5NzqFClh5tkwGvg-1; Wed, 17 Mar 2021 07:07:11 -0400
X-MC-Unique: vdCnRWS5NzqFClh5tkwGvg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DB3E18C8C00;
        Wed, 17 Mar 2021 11:07:10 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-124.ams2.redhat.com [10.36.112.124])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D8D726C32F;
        Wed, 17 Mar 2021 11:07:04 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v1 1/5] mm: make variable names for populate_vma_page_range() consistent
Date:   Wed, 17 Mar 2021 12:06:40 +0100
Message-Id: <20210317110644.25343-2-david@redhat.com>
In-Reply-To: <20210317110644.25343-1-david@redhat.com>
References: <20210317110644.25343-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's make the variable names in the function declaration match the
variable names used in the definition.

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Peter Xu <peterx@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/internal.h b/mm/internal.h
index 1432feec62df..3f22c4ceb7b5 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -334,7 +334,7 @@ void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
 
 #ifdef CONFIG_MMU
 extern long populate_vma_page_range(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, int *nonblocking);
+		unsigned long start, unsigned long end, int *locked);
 extern void munlock_vma_pages_range(struct vm_area_struct *vma,
 			unsigned long start, unsigned long end);
 static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
-- 
2.29.2

