Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E8A3B26B3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Jun 2021 07:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230180AbhFXFWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 01:22:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42509 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230099AbhFXFWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 01:22:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624512030;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=9I6ZeJomjlhkqRugtuXqkaRQhLuB+Ag3tADX4BpIQmM=;
        b=gLLQyew/IcbvvTKoQqlpZN6fus5heWSduEVVisJ8dk2jY1dRz6JUA5uWmnsKvjayK7icBh
        OCzEyZo2qOVWZ2a2Rv2lbgU/c24IQ5oMdscJTNA3XWaA008XIsUM6g9yGmp+d2zZMdsqXF
        /X8hh7ZyB/pDW1CrgFd7N6Y/xb0d1SI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-eLdzURe7OOGWLLj4S2QzQA-1; Thu, 24 Jun 2021 01:20:26 -0400
X-MC-Unique: eLdzURe7OOGWLLj4S2QzQA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 067BC802C8F;
        Thu, 24 Jun 2021 05:20:25 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-82.pek2.redhat.com [10.72.12.82])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DE8A91971B;
        Thu, 24 Jun 2021 05:20:18 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, x86@kernel.org, rientjes@google.com,
        rppt@linux.ibm.com, thomas.lendacky@amd.com, brijesh.singh@amd.com,
        kexec@lists.infradead.org, bhe@redhat.com
Subject: [PATCH 2/2] dma-pool: allow user to disable atomic pool
Date:   Thu, 24 Jun 2021 13:20:10 +0800
Message-Id: <20210624052010.5676-3-bhe@redhat.com>
In-Reply-To: <20210624052010.5676-1-bhe@redhat.com>
References: <20210624052010.5676-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the current code, three atomic memory pools are provided,
atomic_pool_kernel, atomic_pool_dma, atomic_pool_dma32, initialized
with flag GFP_KERNEL, GFP_KERNEL|GFP_DMA, GFP_KERNEL|GFP_DMA32.
And they are always enabled, even though 'coherent_pool=0' is
specified in kernel command line.

In some cases, atomic pool may not be needed. And worse, it even will
cause problem. E.g in kdump kernel of x86_64, it will cause OOM for
atomic_pool_dma initialization. Because there isn't available memory
for buddy allocatory in DMA zone of kdump kernel since commit
f1d4d47c5851 ("x86/setup: Always reserve the first 1M of RAM"). 
The OOM will cause panic if panic_on_oom is added into kdump kernel.

So change code to adjust the existing coherent_pool to allow user
to disable atomic pool by specifying 'coherent_pool=0'.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 kernel/dma/pool.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

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

