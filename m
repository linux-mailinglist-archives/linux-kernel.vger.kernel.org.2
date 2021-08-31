Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E77B53FCE7E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Aug 2021 22:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241232AbhHaUXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Aug 2021 16:23:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35845 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241176AbhHaUWy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Aug 2021 16:22:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630441318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wqg7D3FC9auIBFcU2SSAaYGoCdAzL4jmjQ2lkd2nezM=;
        b=BJAjI4YiUB0jJGbVZdF0ExhedOI37UHeMLLyNTo6DWN7MqfnnaQ+DRA+c8P6xi9zj8Rwfi
        7bh0i3/4H2xMu0F6vCc/mHCl+uR7MESRC+445qYzox8nH8HkdY4XKcmxVfDUq+PBZ6ZRgl
        FC+MPV80vCJgNivl8m8lcjlEZBTmDcY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-J4ykyLZXM0KYRL9GZANEGA-1; Tue, 31 Aug 2021 16:21:57 -0400
X-MC-Unique: J4ykyLZXM0KYRL9GZANEGA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7E7AA107ACF5
        for <linux-kernel@vger.kernel.org>; Tue, 31 Aug 2021 20:21:56 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4209618649;
        Tue, 31 Aug 2021 20:21:53 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 1/3] kernel/resource: clean up and optimize iomem_is_exclusive()
Date:   Tue, 31 Aug 2021 22:21:39 +0200
Message-Id: <20210831202141.13846-2-david@redhat.com>
In-Reply-To: <20210831202141.13846-1-david@redhat.com>
References: <20210831202141.13846-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We end up traversing subtrees of ranges we are not interested in; let's
optimize this case, skipping such subtrees, cleaning up the function a bit.

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

