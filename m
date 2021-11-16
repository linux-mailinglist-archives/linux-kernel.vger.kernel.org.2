Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A559945334A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 14:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236912AbhKPN5p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 08:57:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39100 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236916AbhKPN5Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 08:57:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637070859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=LVBTm2cLG7alqW0oIHq3ofGGY2ENw2S7kG/TEcnQIDE=;
        b=KfiQDiexCtbjVxuDhhw8F8Xv6izvfZcREkXeD2kx/hzGJixbfiG9bmPHOLr7R7Z63njVMK
        3FNs1bHu/95H7MGTfg9owJXWyljW9NGiXCUlvocJsnIkSTfikv4JE7GAmDn/7emedX39Nt
        fzPdqtPR7lgmmEudgQIqtNWFJljzqYI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-403-l2umVZfVOGWmwzImnVkGEQ-1; Tue, 16 Nov 2021 08:54:16 -0500
X-MC-Unique: l2umVZfVOGWmwzImnVkGEQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F4881006AA2;
        Tue, 16 Nov 2021 13:54:15 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F70560BD8;
        Tue, 16 Nov 2021 13:54:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH] mm: Export PageHeadHuge()
From:   David Howells <dhowells@redhat.com>
To:     willy@infradead.org
Cc:     linux-mm@kvack.org, torvalds@linux-foundation.org,
        dhowells@redhat.com, linux-kernel@vger.kernel.org
Date:   Tue, 16 Nov 2021 13:54:13 +0000
Message-ID: <163707085314.3221130.14783857863702203440.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Export PageHeadHuge() - it's used by folio_test_hugetlb() and thence by
folio_file_page() and folio_contains().

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-mm@kvack.org
---

 mm/hugetlb.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index e09159c957e3..16f2e5d5f1a9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1852,6 +1852,7 @@ int PageHeadHuge(struct page *page_head)
 
 	return page_head[1].compound_dtor == HUGETLB_PAGE_DTOR;
 }
+EXPORT_SYMBOL(PageHeadHuge);
 
 /*
  * Find and lock address space (mapping) in write mode.


