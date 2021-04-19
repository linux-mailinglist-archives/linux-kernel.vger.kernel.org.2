Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E80BE364557
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Apr 2021 15:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238899AbhDSNzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Apr 2021 09:55:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238414AbhDSNze (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Apr 2021 09:55:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618840504;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ocDukjE+ETfkil4lwgB/1NevCvBsNFpSh9oxdOLOnGs=;
        b=Ev1Nmb/eMgRU38RbjqJia0l6IWL3Ce/NRWPX+SVyvhcp8gEGC3FbSuvS9Xa4hCCybwdVB1
        8kuxdLA9zkd8OZTh8CFjr1kZRgimkUFgUBiExA4Dk5Xy1aobvpTuuk5su5LJIA9d+LR64d
        hoEzbvriXBvHIDVZhyzq18jo0k5r+Ms=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-584-01XwmXn6NWGUoLbDX2M9NA-1; Mon, 19 Apr 2021 09:55:00 -0400
X-MC-Unique: 01XwmXn6NWGUoLbDX2M9NA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9AB53EC1A3;
        Mon, 19 Apr 2021 13:54:58 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-67.ams2.redhat.com [10.36.115.67])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 715D810429F0;
        Mon, 19 Apr 2021 13:54:56 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, Peter Xu <peterx@redhat.com>
Subject: [PATCH v2 1/5] mm: make variable names for populate_vma_page_range() consistent
Date:   Mon, 19 Apr 2021 15:54:39 +0200
Message-Id: <20210419135443.12822-2-david@redhat.com>
In-Reply-To: <20210419135443.12822-1-david@redhat.com>
References: <20210419135443.12822-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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

