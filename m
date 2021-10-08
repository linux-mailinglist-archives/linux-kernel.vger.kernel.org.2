Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5182D426E89
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbhJHQVf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Oct 2021 12:21:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57893 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229525AbhJHQVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Oct 2021 12:21:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633709976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sKT1idpTNkVhaBOIkuTT61/rDCOAntRvXZQwZuQU3No=;
        b=aqH7LGabNcfcKwc+5j61uoSX/Ey4HSAEFSlP46zg+jzpY0yp3BaRUlBzYI8JN38R45xl61
        UadWIt+IbPbZgQFUMUPrQBQA26zgjs1hmR7qCGdHOgw+p14nb7LCDnMe6rf+Df8JNgCBaC
        751t4SG7CDnQpdiyS9R74s9AcWN1Su0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-604-r3xsNQnzNTybxq7lRkzWSw-1; Fri, 08 Oct 2021 12:19:35 -0400
X-MC-Unique: r3xsNQnzNTybxq7lRkzWSw-1
Received: by mail-wr1-f70.google.com with SMTP id d13-20020adfa34d000000b00160aa1cc5f1so7714051wrb.14
        for <linux-kernel@vger.kernel.org>; Fri, 08 Oct 2021 09:19:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKT1idpTNkVhaBOIkuTT61/rDCOAntRvXZQwZuQU3No=;
        b=ZJEr/gVSCoqV+4nujYue5mEAjL4tcDW+T+bvZ27Bi3VQ3p96PTqh8FQyFWRIH/A124
         Ilr93GfkNLI3BC55DlEw5EEZ5lr2yaDqOHLcZsDXAm5Flij52Lp7HCSn8oLmz/P6HjI8
         t8mH8n6BBHJa+ddAP8JyZf3xFpfxahDaVhWDAocoWdWwVZ7aktsbmn3Uvy16PZpEdquf
         NbTgGVYr/m0ljhEVWBJv5WUYrneQx266i3AEWGT6KpBaCYTx1EI9aLJQr09NaneIO4GZ
         ugT31Uf2OV4u0u1vwS6xbBqbYVbWGVrww1fShUkFJXP5ZOMbXk3IVhP2UzHnwn/hF6ft
         9paA==
X-Gm-Message-State: AOAM530HhGe70vjfEa+f0FRcQFzKKWLgDMTl3Y+SWa7KcOe1zWvilJw6
        Bk+l/rp24EnIIc6I8YcC4YfajDp0hQgPqGbdXyhxtebBkO8VeKF9c8oVx7Vi6eRFI63FSbT9tuY
        pXTNUvuxioNfZ346SX0m8A+Qt
X-Received: by 2002:a7b:c0da:: with SMTP id s26mr4467326wmh.58.1633709974149;
        Fri, 08 Oct 2021 09:19:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyajDwkhy5l3/UOB/lGC0lTJWJcdm20ijXtf9vCwLnu+uMQULK/wCDkF1fE82BbhRGEJC15RA==
X-Received: by 2002:a7b:c0da:: with SMTP id s26mr4467307wmh.58.1633709973984;
        Fri, 08 Oct 2021 09:19:33 -0700 (PDT)
Received: from vian.redhat.com ([2a0c:5a80:1d03:b900:c3d1:5974:ce92:3123])
        by smtp.gmail.com with ESMTPSA id f184sm2901753wmf.22.2021.10.08.09.19.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 09:19:33 -0700 (PDT)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        frederic@kernel.org, tglx@linutronix.de, peterz@infradead.org,
        mtosatti@redhat.com, nilal@redhat.com, mgorman@suse.de,
        linux-rt-users@vger.kernel.org, vbabka@suse.cz, cl@linux.com,
        paulmck@kernel.org, ppandit@redhat.com,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>
Subject: [RFC 1/3] mm/page_alloc: Simplify __rmqueue_pcplist()'s arguments
Date:   Fri,  8 Oct 2021 18:19:20 +0200
Message-Id: <20211008161922.942459-2-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008161922.942459-1-nsaenzju@redhat.com>
References: <20211008161922.942459-1-nsaenzju@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both users of __rmqueue_pcplist() use the same means to extract the
right list from their per-cpu lists: calculate the index based on the
page's migratetype and order. This data is already being passed to
__rmqueue_pcplist(), so centralize the list extraction process inside
the function.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 mm/page_alloc.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index b37435c274cf..dd89933503b4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3600,11 +3600,13 @@ static inline
 struct page *__rmqueue_pcplist(struct zone *zone, unsigned int order,
 			int migratetype,
 			unsigned int alloc_flags,
-			struct per_cpu_pages *pcp,
-			struct list_head *list)
+			struct per_cpu_pages *pcp)
 {
+	struct list_head *list;
 	struct page *page;
 
+	list = &pcp->lists[order_to_pindex(migratetype, order)];
+
 	do {
 		if (list_empty(list)) {
 			int batch = READ_ONCE(pcp->batch);
@@ -3643,7 +3645,6 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 			unsigned int alloc_flags)
 {
 	struct per_cpu_pages *pcp;
-	struct list_head *list;
 	struct page *page;
 	unsigned long flags;
 
@@ -3656,8 +3657,7 @@ static struct page *rmqueue_pcplist(struct zone *preferred_zone,
 	 */
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
 	pcp->free_factor >>= 1;
-	list = &pcp->lists[order_to_pindex(migratetype, order)];
-	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp, list);
+	page = __rmqueue_pcplist(zone, order, migratetype, alloc_flags, pcp);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 	if (page) {
 		__count_zid_vm_events(PGALLOC, page_zonenum(page), 1);
@@ -5202,7 +5202,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	struct zone *zone;
 	struct zoneref *z;
 	struct per_cpu_pages *pcp;
-	struct list_head *pcp_list;
 	struct alloc_context ac;
 	gfp_t alloc_gfp;
 	unsigned int alloc_flags = ALLOC_WMARK_LOW;
@@ -5278,7 +5277,6 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 	/* Attempt the batch allocation */
 	local_lock_irqsave(&pagesets.lock, flags);
 	pcp = this_cpu_ptr(zone->per_cpu_pageset);
-	pcp_list = &pcp->lists[order_to_pindex(ac.migratetype, 0)];
 
 	while (nr_populated < nr_pages) {
 
@@ -5288,8 +5286,7 @@ unsigned long __alloc_pages_bulk(gfp_t gfp, int preferred_nid,
 			continue;
 		}
 
-		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags,
-								pcp, pcp_list);
+		page = __rmqueue_pcplist(zone, 0, ac.migratetype, alloc_flags, pcp);
 		if (unlikely(!page)) {
 			/* Try and get at least one page */
 			if (!nr_populated)
-- 
2.31.1

