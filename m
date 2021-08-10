Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEDDB3D8992
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jul 2021 10:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234697AbhG1IRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jul 2021 04:17:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32765 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233541AbhG1IRA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jul 2021 04:17:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627460219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XaHhZdld2uT9t1jzd/55yboqLAJcBICUO4soO6lmV0I=;
        b=Xd2ttokCBph+SIR79H0IWZMCacaUDCC5ttUrLoDRKcBhPRKtR33nCe5sfOTR6pXImsyY74
        aVfTNZ5FtgIuvsn4CmSK3uoHK+6t1yoOLeTqY1SLIVEy49FgsYnY8Qaicz8CK0HcOevEZm
        XM47V1+3/qr88GR8n9dD019RwX2m+Tg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-46sV33bpOq-y-F_pDCjHrg-1; Wed, 28 Jul 2021 04:16:58 -0400
X-MC-Unique: 46sV33bpOq-y-F_pDCjHrg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8FE1E800050;
        Wed, 28 Jul 2021 08:16:56 +0000 (UTC)
Received: from localhost (ovpn-13-99.pek2.redhat.com [10.72.13.99])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C75360862;
        Wed, 28 Jul 2021 08:16:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        Ming Lei <ming.lei@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH V2 1/7] mm: memcontrol: add helper of memcg_get_e_css
Date:   Wed, 28 Jul 2021 16:16:32 +0800
Message-Id: <20210728081638.1500953-2-ming.lei@redhat.com>
In-Reply-To: <20210728081638.1500953-1-ming.lei@redhat.com>
References: <20210728081638.1500953-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

And helper of memcg_get_e_css() so that the consumer needn't to
call cgroup_get_e_css(cgroup, &memory_cgrp_subsys) directly, since
&memory_cgrp_subsys has to be used in case that MEMCG is enabled.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/memcontrol.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
index bfe5c486f4ad..67c35793fdce 100644
--- a/include/linux/memcontrol.h
+++ b/include/linux/memcontrol.h
@@ -1101,6 +1101,10 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 						gfp_t gfp_mask,
 						unsigned long *total_scanned);
 
+static inline struct cgroup_subsys_state *memcg_get_e_css(struct cgroup *cgrp)
+{
+	return cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
+}
 #else /* CONFIG_MEMCG */
 
 #define MEM_CGROUP_ID_SHIFT	0
@@ -1456,6 +1460,10 @@ unsigned long mem_cgroup_soft_limit_reclaim(pg_data_t *pgdat, int order,
 {
 	return 0;
 }
+static inline struct cgroup_subsys_state *memcg_get_e_css(struct cgroup *cgrp)
+{
+	return NULL;
+}
 #endif /* CONFIG_MEMCG */
 
 static inline void __inc_lruvec_kmem_state(void *p, enum node_stat_item idx)
-- 
2.31.1

