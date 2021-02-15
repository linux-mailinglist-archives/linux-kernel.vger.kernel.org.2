Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 235B631B93A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Feb 2021 13:29:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbhBOM2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Feb 2021 07:28:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25636 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230388AbhBOMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Feb 2021 07:23:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613391717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iREUH3qcwe+8CMwRTYNN3sl03Q+aaxvnMDnwGmHEACo=;
        b=Adseck3FofC8RNjfDbvcSeQLAQAOhYvbxd1XWA8JxN5EyMfMwR1E/Bcq55D5W79kOTbaQ0
        yOt4oMaUtCdMWlWmSCpknmpxeF9/hD2uYIJEDGg/VNZALicgMF2NppNqfxQE0kxLB727G+
        KsEGlzTXJvfdCN0Zj8mheC3oZ7sRUGE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-0zyx5x9gNme3xLrVJohpQA-1; Mon, 15 Feb 2021 07:21:56 -0500
X-MC-Unique: 0zyx5x9gNme3xLrVJohpQA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EBDE4192CC43;
        Mon, 15 Feb 2021 12:21:54 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-89.ams2.redhat.com [10.36.114.89])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D81C72BFEC;
        Mon, 15 Feb 2021 12:21:52 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Marek Kedzierski <mkedzier@redhat.com>,
        Hui Zhu <teawater@gmail.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v1 1/2] virtio-mem: don't read big block size in SBM
Date:   Mon, 15 Feb 2021 13:21:42 +0100
Message-Id: <20210215122143.27608-2-david@redhat.com>
In-Reply-To: <20210215122143.27608-1-david@redhat.com>
References: <20210215122143.27608-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are reading the a BBM (Big Block Mode) value while in SBM (Sub Block
Mode) while initializing. Fortunately, vm->bbm.bb_size maps to some counter
in the vm->sbm.mb_count array, which is 0 at that point in time.

No harm done; still, this was unintended and is not future-proof.

Fixes: 4ba50cd3355d ("virtio-mem: Big Block Mode (BBM) memory hotplug")
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Marek Kedzierski <mkedzier@redhat.com>
Cc: Hui Zhu <teawater@gmail.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 9fc9ec4a25f5..6d4e01c4e2fa 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2409,6 +2409,10 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		dev_warn(&vm->vdev->dev,
 			 "Some memory is not addressable. This can make some memory unusable.\n");
 
+	/* Prepare the offline threshold - make sure we can add two blocks. */
+	vm->offline_threshold = max_t(uint64_t, 2 * memory_block_size_bytes(),
+				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
+
 	/*
 	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
 	 * pageblock_nr_pages pages. This:
@@ -2453,14 +2457,11 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		addr = vm->addr + vm->bbm.bb_size - 1;
 		vm->bbm.first_bb_id = virtio_mem_phys_to_bb_id(vm, addr);
 		vm->bbm.next_bb_id = vm->bbm.first_bb_id;
-	}
 
-	/* Prepare the offline threshold - make sure we can add two blocks. */
-	vm->offline_threshold = max_t(uint64_t, 2 * memory_block_size_bytes(),
-				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
-	/* In BBM, we also want at least two big blocks. */
-	vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
-				      vm->offline_threshold);
+		/* Make sure we can add two big blocks. */
+		vm->offline_threshold = max_t(uint64_t, 2 * vm->bbm.bb_size,
+					      vm->offline_threshold);
+	}
 
 	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
 	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
-- 
2.29.2

