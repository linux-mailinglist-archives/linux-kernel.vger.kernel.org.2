Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E6343AFCC1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 07:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230332AbhFVFvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Jun 2021 01:51:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26862 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230204AbhFVFvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jun 2021 01:51:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624340947;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FVr7/h9402355q6HHHAllRECQ2atnyfzJmw26OaKxo0=;
        b=LVQOG5kyI1826A1BURXGXpqv3f9eYlNhgK/0NntQPShP02kFpIXcUVG7p21QD62YAeySvN
        89syhQrq4eZzVveYQH9vliLbKwjgQSptGUkZd07vcr08o+q/rIaTKhV49iEWp3Fu1ieUIQ
        ckfkeTGbWHDI8cyF2hR9/c4JOYG/htY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-4zWT-7k1MwmE6BeQ6qDK5g-1; Tue, 22 Jun 2021 01:49:06 -0400
X-MC-Unique: 4zWT-7k1MwmE6BeQ6qDK5g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64BCC100B3B4;
        Tue, 22 Jun 2021 05:49:04 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-84.bne.redhat.com [10.64.54.84])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CF225D9DE;
        Tue, 22 Jun 2021 05:48:51 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        david@redhat.com, mst@redhat.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v2 3/3] virtio_balloon: Specify page reporting order if needed
Date:   Tue, 22 Jun 2021 15:49:26 +0800
Message-Id: <20210622074926.333223-4-gshan@redhat.com>
In-Reply-To: <20210622074926.333223-1-gshan@redhat.com>
References: <20210622074926.333223-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The page reporting won't be triggered if the freeing page can't come
up with a free area, whose size is equal or bigger than the threshold
(page reporting order). The default page reporting order, equal to
@pageblock_order, is too huge on some architectures to trigger page
reporting. One example is ARM64 when 64KB base page size is used.

      PAGE_SIZE:          64KB
      pageblock_order:    13       (512MB)
      MAX_ORDER:          14

This specifies the page reporting order to 5 (2MB) for this specific
case so that page reporting can be triggered.

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 drivers/virtio/virtio_balloon.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 510e9318854d..fd419780cc23 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -993,6 +993,23 @@ static int virtballoon_probe(struct virtio_device *vdev)
 			goto out_unregister_oom;
 		}
 
+		/*
+		 * The default page reporting order is @pageblock_order, which
+		 * corresponds to 512MB in size on ARM64 when 64KB base page
+		 * size is used. The page reporting won't be triggered if the
+		 * freeing page can't come up with a free area like that huge.
+		 * So we specify the page reporting order to 5, corresponding
+		 * to 2MB. It helps to avoid THP splitting if 4KB base page
+		 * size is used by host.
+		 *
+		 * Ideallh, the page reporting order is selected based on the
+		 * host's base page size. However, it needs more work to report
+		 * that value. The hardcoded order would be fine currently.
+		 */
+#if defined(CONFIG_ARM64) && defined(CONFIG_ARM64_64K_PAGES)
+		vb->pr_dev_info.order = 5;
+#endif
+
 		err = page_reporting_register(&vb->pr_dev_info);
 		if (err)
 			goto out_unregister_oom;
-- 
2.23.0

