Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65F4F3E99C0
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Aug 2021 22:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhHKUhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Aug 2021 16:37:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32693 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231786AbhHKUhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Aug 2021 16:37:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628714200;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p6LHuy13nKs4bZicpGZZauB7ft7dST8UEGnG3gy9DN8=;
        b=CkGxclVG3pHshZRvoKuDO8pJhBY7TF7JPGOlVTxlFefLxaEkpJ76fW6eUIC9QpX5MWWYot
        bY0cMjAlMAtJoNV2031j8TI/3bfQb5A/FSYChGDFW/Ivd4SbGt9IzB97DoOFxienL4HwvX
        Mp8K9u4Ob2bOq552K90cZhayDV32Skw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-592-QSB5eX08MEuIOl7_aCX0kQ-1; Wed, 11 Aug 2021 16:36:36 -0400
X-MC-Unique: QSB5eX08MEuIOl7_aCX0kQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BDEF8799EC;
        Wed, 11 Aug 2021 20:36:35 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.112])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 154021B46B;
        Wed, 11 Aug 2021 20:36:31 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hanjun Guo <guohanjun@huawei.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: [PATCH v1 3/3] kernel/resource: cleanup and optimize iomem_is_exclusive()
Date:   Wed, 11 Aug 2021 22:36:12 +0200
Message-Id: <20210811203612.138506-4-david@redhat.com>
In-Reply-To: <20210811203612.138506-1-david@redhat.com>
References: <20210811203612.138506-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's clean it up a bit, removing the unnecessary usage of r_next() by
next_resource(), and use next_range_resource() in case we are not
interested in a certain subtree.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/resource.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index 2938cf520ca3..ea853a075a83 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1754,9 +1754,8 @@ static int strict_iomem_checks;
  */
 bool iomem_is_exclusive(u64 addr)
 {
-	struct resource *p = &iomem_resource;
+	struct resource *p;
 	bool err = false;
-	loff_t l;
 	int size = PAGE_SIZE;
 
 	if (!strict_iomem_checks)
@@ -1765,27 +1764,31 @@ bool iomem_is_exclusive(u64 addr)
 	addr = addr & PAGE_MASK;
 
 	read_lock(&resource_lock);
-	for (p = p->child; p ; p = r_next(NULL, p, &l)) {
+	for (p = iomem_resource.child; p ;) {
 		/*
 		 * We can probably skip the resources without
 		 * IORESOURCE_IO attribute?
 		 */
 		if (p->start >= addr + size)
 			break;
-		if (p->end < addr)
+		if (p->end < addr) {
+			/* No need to consider children */
+			p = next_resource_skip_children(p);
 			continue;
+		}
+
 		/*
 		 * A resource is exclusive if IORESOURCE_EXCLUSIVE is set
 		 * or CONFIG_IO_STRICT_DEVMEM is enabled and the
 		 * resource is busy.
 		 */
-		if ((p->flags & IORESOURCE_BUSY) == 0)
-			continue;
-		if (IS_ENABLED(CONFIG_IO_STRICT_DEVMEM)
-				|| p->flags & IORESOURCE_EXCLUSIVE) {
+		if (p->flags & IORESOURCE_BUSY &&
+		    (IS_ENABLED(CONFIG_IO_STRICT_DEVMEM) ||
+		     p->flags & IORESOURCE_EXCLUSIVE)) {
 			err = true;
 			break;
 		}
+		p = next_resource(p);
 	}
 	read_unlock(&resource_lock);
 
-- 
2.31.1

