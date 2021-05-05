Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59115374912
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 22:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233796AbhEEUHp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 16:07:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49724 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233800AbhEEUHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 16:07:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620245206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=GObYidJPOxqa39RCGKtF8EH7OG9xQ65JoyiaTRpSe4I=;
        b=JSw5lM5nsX7TGEy38DjwnmKE2Sy9T5GQ2645ws9DxRt99bA6RfQvgLRoWsgNhPVZ2GorJ0
        Pg3B1byi/4GZB8X0Jm7fXsA2Fug7yP1eUf+OChJdFIwA9xglCphK9heZV+DQm/AIH3Nvlt
        1IASKGlnkuUSKcvORF6z9+G2h91sdTQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-AMamAWPhPeW0_g-6xgUE0A-1; Wed, 05 May 2021 16:06:42 -0400
X-MC-Unique: AMamAWPhPeW0_g-6xgUE0A-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5899E10066E5;
        Wed,  5 May 2021 20:06:40 +0000 (UTC)
Received: from llong.com (ovpn-117-4.rdu2.redhat.com [10.10.117.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D03A410016FD;
        Wed,  5 May 2021 20:06:38 +0000 (UTC)
From:   Waiman Long <longman@redhat.com>
To:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vlastimil Babka <vbabka@suse.cz>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Waiman Long <longman@redhat.com>
Subject: [PATCH v4 3/3] mm: memcg/slab: Disable cache merging for KMALLOC_NORMAL caches
Date:   Wed,  5 May 2021 16:06:10 -0400
Message-Id: <20210505200610.13943-4-longman@redhat.com>
In-Reply-To: <20210505200610.13943-1-longman@redhat.com>
References: <20210505200610.13943-1-longman@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The KMALLOC_NORMAL (kmalloc-<n>) caches are for unaccounted objects only
when CONFIG_MEMCG_KMEM is enabled. To make sure that this condition
remains true, we will have to prevent KMALOC_NORMAL caches to merge
with other kmem caches. This is now done by setting its refcount to -1
right after its creation.

Suggested-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Waiman Long <longman@redhat.com>
---
 mm/slab_common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index bbaf41a7c77e..a0ff8e1d8b67 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -841,6 +841,13 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 					kmalloc_info[idx].name[type],
 					kmalloc_info[idx].size, flags, 0,
 					kmalloc_info[idx].size);
+
+	/*
+	 * If CONFIG_MEMCG_KMEM is enabled, disable cache merging for
+	 * KMALLOC_NORMAL caches.
+	 */
+	if (IS_ENABLED(CONFIG_MEMCG_KMEM) && (type == KMALLOC_NORMAL))
+		kmalloc_caches[type][idx]->refcount = -1;
 }
 
 /*
-- 
2.18.1

