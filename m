Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34A793E577C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239484AbhHJJu3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:50:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30176 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239314AbhHJJtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628588938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=RdY91bgYW5z7h5YowPXujpqtlKk0AVHYp/0WWPiO348=;
        b=Pf94kZmEo69Dovpb/no51ZLBHOP8+sTMbAZXFiInM+iicjJtDJcDjhiR1tfPhjKuG2PSEf
        3HEfWgKp4p1Mb3VPijQ3VuDF2x3NFl+CU2xJ2hqp1D6dtAcuMNA7DvRHwqf2qd0do6LNpy
        K2MHsK0MAXYBEjadj+qY3ZkOcwP/VGM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-95-Og_HG3m-OgSC2e-x0COdxQ-1; Tue, 10 Aug 2021 05:48:57 -0400
X-MC-Unique: Og_HG3m-OgSC2e-x0COdxQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 25D53107ACF5;
        Tue, 10 Aug 2021 09:48:55 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9A7181036D05;
        Tue, 10 Aug 2021 09:48:50 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, rppt@linux.ibm.com,
        Baoquan He <bhe@redhat.com>
Subject: [RFC PATCH v2 2/5] dma-pool: allow user to disable atomic pool
Date:   Tue, 10 Aug 2021 17:48:32 +0800
Message-Id: <20210810094835.13402-3-bhe@redhat.com>
In-Reply-To: <20210810094835.13402-1-bhe@redhat.com>
References: <20210810094835.13402-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current code, three atomic memory pools are always created,
atomic_pool_kernel|dma|dma32, even though 'coherent_pool=0' is
specified in kernel command line. In fact, atomic pool is only
necessary when CONFIG_DMA_DIRECT_REMAP=y or mem_encrypt_active=y
which are needed on few ARCHes.

So change code to allow user to disable atomic pool by specifying
'coherent_pool=0'.

Meanwhile, update the relevant document in kernel-parameter.txt.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 3 ++-
 kernel/dma/pool.c                               | 7 +++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 970ed65db89f..620d38b5ce2d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -653,7 +653,8 @@
 
 	coherent_pool=nn[KMG]	[ARM,KNL]
 			Sets the size of memory pool for coherent, atomic dma
-			allocations. Otherwise the default size will be scaled
+			allocations. A value of 0 disables the three atomic
+			memory pool. Otherwise the default size will be scaled
 			with memory capacity, while clamped between 128K and
 			1 << (PAGE_SHIFT + MAX_ORDER-1).
 
diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
index 5f84e6cdb78e..5a85804b5beb 100644
--- a/kernel/dma/pool.c
+++ b/kernel/dma/pool.c
@@ -21,7 +21,7 @@ static struct gen_pool *atomic_pool_kernel __ro_after_init;
 static unsigned long pool_size_kernel;
 
 /* Size can be defined by the coherent_pool command line */
-static size_t atomic_pool_size;
+static unsigned long atomic_pool_size = -1;
 
 /* Dynamic background expansion when the atomic pool is near capacity */
 static struct work_struct atomic_pool_work;
@@ -188,11 +188,14 @@ static int __init dma_atomic_pool_init(void)
 {
 	int ret = 0;
 
+	if (!atomic_pool_size)
+		return 0;
+
 	/*
 	 * If coherent_pool was not used on the command line, default the pool
 	 * sizes to 128KB per 1GB of memory, min 128KB, max MAX_ORDER-1.
 	 */
-	if (!atomic_pool_size) {
+	if (atomic_pool_size == -1) {
 		unsigned long pages = totalram_pages() / (SZ_1G / SZ_128K);
 		pages = min_t(unsigned long, pages, MAX_ORDER_NR_PAGES);
 		atomic_pool_size = max_t(size_t, pages << PAGE_SHIFT, SZ_128K);
-- 
2.17.2

