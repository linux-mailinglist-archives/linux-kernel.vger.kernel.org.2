Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEE823E577A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 11:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239328AbhHJJuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 05:50:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58709 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239318AbhHJJtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 05:49:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628588945;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=XzR6lWp82u27j51uOwaAZXbU9KDrDW0NXcWuJSzfma4=;
        b=FumeNwqjXfyTSsXnAsGtbUQQsGPdiEwtcCPd/MTaa6aNTf1hzFaxokUv6lKKaOxaxkSgTT
        zU6s7wWozF+mxO89LvTDDLg57AoXoBFltDC1b3uAcURSnDcJsjC3GqWlsQy6O/IniRk+VX
        Zbh9eUW8VfiUwhdIEXK3cFqe22+8S6k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-GKyu86l7Mde9uXBLYsrEWw-1; Tue, 10 Aug 2021 05:49:02 -0400
X-MC-Unique: GKyu86l7Mde9uXBLYsrEWw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 42EB6107ACF5;
        Tue, 10 Aug 2021 09:49:00 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-79.pek2.redhat.com [10.72.12.79])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B2D8D10013C1;
        Tue, 10 Aug 2021 09:48:55 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, rppt@linux.ibm.com,
        Baoquan He <bhe@redhat.com>
Subject: [RFC PATCH v2 3/5] mm_zone: add function to check if managed dma zone exists
Date:   Tue, 10 Aug 2021 17:48:33 +0800
Message-Id: <20210810094835.13402-4-bhe@redhat.com>
In-Reply-To: <20210810094835.13402-1-bhe@redhat.com>
References: <20210810094835.13402-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some places of the current kernel, it assumes that dma zone must have
managed pages if CONFIG_ZONE_DMA is enabled. While this is not always true.
E.g in kdump kernel of x86_64, only low 1M is presented and locked down
at very early stage of boot, so that there's no managed pages at all in
DMA zone. This exception will always cause page allocation failure if page
is requested from DMA zone.

Here add function has_managed_dma() and the relevant helper functions to
check if there's DMA zone with managed pages. It will be used in later
patches.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/mmzone.h | 21 +++++++++++++++++++++
 mm/page_alloc.c        | 11 +++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index fcb535560028..e3cd23fc5f64 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -975,6 +975,18 @@ static inline bool zone_is_zone_device(struct zone *zone)
 }
 #endif
 
+#ifdef CONFIG_ZONE_DMA
+static inline bool zone_is_dma(struct zone *zone)
+{
+	return zone_idx(zone) == ZONE_DMA;
+}
+#else
+static inline bool zone_is_dma(struct zone *zone)
+{
+	return false;
+}
+#endif
+
 /*
  * Returns true if a zone has pages managed by the buddy allocator.
  * All the reclaim decisions have to use this function rather than
@@ -1023,6 +1035,7 @@ static inline int is_highmem_idx(enum zone_type idx)
 #endif
 }
 
+bool has_managed_dma(void);
 /**
  * is_highmem - helper function to quickly check if a struct zone is a
  *              highmem zone or not.  This is an attempt to keep references
@@ -1108,6 +1121,14 @@ extern struct zone *next_zone(struct zone *zone);
 			; /* do nothing */		\
 		else
 
+#define for_each_managed_zone(zone)		        \
+	for (zone = (first_online_pgdat())->node_zones; \
+	     zone;					\
+	     zone = next_zone(zone))			\
+		if (!managed_zone(zone))		\
+			; /* do nothing */		\
+		else
+
 static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 {
 	return zoneref->zone;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3e97e68aef7a..45dd1295416a 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9441,4 +9441,15 @@ bool take_page_off_buddy(struct page *page)
 	spin_unlock_irqrestore(&zone->lock, flags);
 	return ret;
 }
+
+bool has_managed_dma(void)
+{
+	struct zone *zone;
+
+	for_each_managed_zone(zone) {
+		if (zone_is_dma(zone))
+			return true;
+	}
+	return false;
+}
 #endif
-- 
2.17.2

