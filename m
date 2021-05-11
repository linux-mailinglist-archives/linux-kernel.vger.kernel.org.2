Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16B1637A17F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 May 2021 10:15:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhEKIQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 May 2021 04:16:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52353 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230399AbhEKIQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 May 2021 04:16:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620720949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocDukjE+ETfkil4lwgB/1NevCvBsNFpSh9oxdOLOnGs=;
        b=Ojvp4rx0gN6fJcOONtvqw7Fp9KSijdB5RpRY3g70pbBM3Qd2MCZTlSTgSG59I6/KfcrqVS
        5uoR3qCP95Ke1+3OfEQfvd/0tLxZOAS57/6Ss4iR/caa9/E2FS5kMveJfGa87J9VazvJrO
        zcuddoRFg+FKkR7K1EQBx5wk1/PlctQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-583-JXL3I89NPKKfdnA3xBJHEg-1; Tue, 11 May 2021 04:15:47 -0400
X-MC-Unique: JXL3I89NPKKfdnA3xBJHEg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0261C1008061;
        Tue, 11 May 2021 08:15:46 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-91.ams2.redhat.com [10.36.115.91])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 752585D6D1;
        Tue, 11 May 2021 08:15:40 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>
Subject: [PATCH resend v2 1/5] mm: make variable names for populate_vma_page_range() consistent
Date:   Tue, 11 May 2021 10:15:30 +0200
Message-Id: <20210511081534.3507-2-david@redhat.com>
In-Reply-To: <20210511081534.3507-1-david@redhat.com>
References: <20210511081534.3507-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
index cb3c5e0a7799..bbf1c1274983 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -354,7 +354,7 @@ void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
 
 #ifdef CONFIG_MMU
 extern long populate_vma_page_range(struct vm_area_struct *vma,
-		unsigned long start, unsigned long end, int *nonblocking);
+		unsigned long start, unsigned long end, int *locked);
 extern void munlock_vma_pages_range(struct vm_area_struct *vma,
 			unsigned long start, unsigned long end);
 static inline void munlock_vma_pages_all(struct vm_area_struct *vma)
-- 
2.30.2

