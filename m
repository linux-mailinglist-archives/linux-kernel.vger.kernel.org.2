Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4462E411709
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 16:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232060AbhITOcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 10:32:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:40053 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229768AbhITOcC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 10:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632148235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OPXHqY9VOL97jpGsR9CxoGVxdCxjVyj0nMigqpjV/2w=;
        b=IpL29n+DgDAgL6hZ281qtFTLYfdZEYwLthed8QTySqSGdDHS2gJOiZzAs/2JaOMEetE+yY
        8Az+1A/xCt+SlreNiVrQZ0U8RmlnA6+WyPw87iVmyWW71iB1XtZGgrB0zyKXpnTGLBjK0f
        YlaQTZfqAPluRtgHvX55REsCt+WraKo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-erBAtSQmMLWTTu5FHcrD1Q-1; Mon, 20 Sep 2021 10:30:34 -0400
X-MC-Unique: erBAtSQmMLWTTu5FHcrD1Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7936A1030C24;
        Mon, 20 Sep 2021 14:30:32 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.236])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD69360C17;
        Mon, 20 Sep 2021 14:29:21 +0000 (UTC)
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
Subject: [PATCH v5 1/3] kernel/resource: clean up and optimize iomem_is_exclusive()
Date:   Mon, 20 Sep 2021 16:28:54 +0200
Message-Id: <20210920142856.17758-2-david@redhat.com>
In-Reply-To: <20210920142856.17758-1-david@redhat.com>
References: <20210920142856.17758-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We end up traversing subtrees of ranges we are not interested in; let's
optimize this case, skipping such subtrees, cleaning up the function a bit.

For example, in the following configuration (/proc/iomem):

00000000-00000fff : Reserved
00001000-00057fff : System RAM
00058000-00058fff : Reserved
00059000-0009cfff : System RAM
0009d000-000fffff : Reserved
   000a0000-000bffff : PCI Bus 0000:00
   000c0000-000c3fff : PCI Bus 0000:00
   000c4000-000c7fff : PCI Bus 0000:00
   000c8000-000cbfff : PCI Bus 0000:00
   000cc000-000cffff : PCI Bus 0000:00
   000d0000-000d3fff : PCI Bus 0000:00
   000d4000-000d7fff : PCI Bus 0000:00
   000d8000-000dbfff : PCI Bus 0000:00
   000dc000-000dffff : PCI Bus 0000:00
   000e0000-000e3fff : PCI Bus 0000:00
   000e4000-000e7fff : PCI Bus 0000:00
   000e8000-000ebfff : PCI Bus 0000:00
   000ec000-000effff : PCI Bus 0000:00
   000f0000-000fffff : PCI Bus 0000:00
     000f0000-000fffff : System ROM
00100000-3fffffff : System RAM
40000000-403fffff : Reserved
   40000000-403fffff : pnp 00:00
40400000-80a79fff : System RAM
...

We don't have to look at any children of "0009d000-000fffff :
Reserved" if we can just skip these 15 items directly because the parent
range is not of interest.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 kernel/resource.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/resource.c b/kernel/resource.c
index ca9f5198a01f..2999f57da38c 100644
--- a/kernel/resource.c
+++ b/kernel/resource.c
@@ -73,6 +73,18 @@ static struct resource *next_resource(struct resource *p)
 	return p->sibling;
 }
 
+static struct resource *next_resource_skip_children(struct resource *p)
+{
+	while (!p->sibling && p->parent)
+		p = p->parent;
+	return p->sibling;
+}
+
+#define for_each_resource(_root, _p, _skip_children) \
+	for ((_p) = (_root)->child; (_p); \
+	     (_p) = (_skip_children) ? next_resource_skip_children(_p) : \
+				       next_resource(_p))
+
 static void *r_next(struct seq_file *m, void *v, loff_t *pos)
 {
 	struct resource *p = v;
@@ -1712,10 +1724,9 @@ static int strict_iomem_checks;
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
@@ -1723,15 +1734,19 @@ bool iomem_is_exclusive(u64 addr)
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

