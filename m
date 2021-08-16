Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93B873ED8E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Aug 2021 16:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232130AbhHPO0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Aug 2021 10:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36304 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231755AbhHPO0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Aug 2021 10:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629123944;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfJ17b00++bWuSHxnMjiXEwJtyWC6f0LPnUvtr2zO94=;
        b=OooNVXZqtHGZc9GqsZOJyONGUVVVutgpqhW5SIUUvJ03Di+h4N/cDCU77hQUUr/CjK1w8z
        cxtZZ0sH0o5wHXoeZI0IROTDNTiqBGmm4VWTWG0Q9C9O4s7Q7wMHUV0D0Z34D34QvQi0hL
        FF74zXD0SflJjl6d+J0WzCngTGji90Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-OaNHpWQ-Mna__9B2ypxbvQ-1; Mon, 16 Aug 2021 10:25:43 -0400
X-MC-Unique: OaNHpWQ-Mna__9B2ypxbvQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A207087D549;
        Mon, 16 Aug 2021 14:25:41 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.85])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAB7619C46;
        Mon, 16 Aug 2021 14:25:30 +0000 (UTC)
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
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org
Subject: [PATCH v2 3/3] kernel/resource: cleanup and optimize iomem_is_exclusive()
Date:   Mon, 16 Aug 2021 16:25:05 +0200
Message-Id: <20210816142505.28359-4-david@redhat.com>
In-Reply-To: <20210816142505.28359-1-david@redhat.com>
References: <20210816142505.28359-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's clean it up a bit, reusing for_each_resource() and avoiding
traversing subtrees we are not interested in.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/resource.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index f57a14617c49..7e59b57afa56 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -1759,10 +1759,9 @@ static int strict_iomem_checks;
  */
 bool iomem_is_exclusive(u64 addr)
 {
-	struct resource *p = &iomem_resource;
-	bool err = false;
-	loff_t l;
+	bool skip_children = false, err = false;
 	int size = PAGE_SIZE;
+	struct resource *p;
 
 	if (!strict_iomem_checks)
 		return false;
@@ -1770,15 +1769,19 @@ bool iomem_is_exclusive(u64 addr)
 	addr = addr & PAGE_MASK;
 
 	read_lock(&resource_lock);
-	for (p = p->child; p ; p = r_next(NULL, p, &l)) {
+	for_each_resource(&iomem_resource, p, skip_children) {
 		/*
 		 * We can probably skip the resources without
 		 * IORESOURCE_IO attribute?
 		 */
 		if (p->start >= addr + size)
 			break;
-		if (p->end < addr)
+		if (p->end < addr) {
+			skip_children = true;
 			continue;
+		}
+		skip_children = false;
+
 		/*
 		 * A resource is exclusive if IORESOURCE_EXCLUSIVE is set
 		 * or CONFIG_IO_STRICT_DEVMEM is enabled and the
-- 
2.31.1

