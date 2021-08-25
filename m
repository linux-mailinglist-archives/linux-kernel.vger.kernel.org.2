Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA493F72EE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 12:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239830AbhHYKZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 06:25:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238463AbhHYKZM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 06:25:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629887066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=WVyb3Uv0Tbq8Di9FJJZjAihDGm9Mo6ze8JS8vqgSS3g=;
        b=XYWSr8XXRwANGZRrpX6GagasDyWMkqYCBUz6zmmhEzYRs2SMdnooLP4iNB79VsRDDvx4NU
        ZG05CPkBei6N+Qin0jsEKJgCavxa+6eIi1Xj0sI7dIGiuhf/TUJo09tpLfqeydrw+lspDw
        BJ8bZDnoAblcICqqePW0wYQC/mUd5wM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-plshk3JbP2qnDyiPWsUHPQ-1; Wed, 25 Aug 2021 06:24:25 -0400
X-MC-Unique: plshk3JbP2qnDyiPWsUHPQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 09F2ADF8AC;
        Wed, 25 Aug 2021 10:24:24 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.193.23])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83E545C1D1;
        Wed, 25 Aug 2021 10:24:16 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        virtualization@lists.linux-foundation.org
Subject: [PATCH v1] virtio-mem: fix sleeping in RCU read side section in virtio_mem_online_page_cb()
Date:   Wed, 25 Aug 2021 12:24:15 +0200
Message-Id: <20210825102415.7516-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

virtio_mem_set_fake_offline() might sleep now, and we call it under
rcu_read_lock(). To fix it, simply move the rcu_read_unlock() further
up, as we're done with the device.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Fixes: 6cc26d77613a: "virtio-mem: use page_offline_(start|end) when setting PageOffline()
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---

The problematic commit is in v5.14-rc1 .. v5.14-rc7, but it suspect
might be too late for v5.14.

The original commit went upstream via Andrews tree, we could take this fix
via Andrews tree as well or via the vhost tree (MST), I don't particularly
care. (putting Linus on CC just in case)

---
 drivers/virtio/virtio_mem.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 09ed55de07d7..b91bc810a87e 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1242,12 +1242,19 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
 			do_online = virtio_mem_bbm_get_bb_state(vm, id) !=
 				    VIRTIO_MEM_BBM_BB_FAKE_OFFLINE;
 		}
+
+		/*
+		 * virtio_mem_set_fake_offline() might sleep, we don't need
+		 * the device anymore. See virtio_mem_remove() how races
+		 * between memory onlining and device removal are handled.
+		 */
+		rcu_read_unlock();
+
 		if (do_online)
 			generic_online_page(page, order);
 		else
 			virtio_mem_set_fake_offline(PFN_DOWN(addr), 1 << order,
 						    false);
-		rcu_read_unlock();
 		return;
 	}
 	rcu_read_unlock();
-- 
2.31.1

