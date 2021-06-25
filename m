Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1923B39D9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 01:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbhFXXtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 19:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37051 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232968AbhFXXtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 19:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624578421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Ur+3f6ByoCtX7yhFwFNR3bC9UT9UhNVvdQagfYQi4Q=;
        b=fz5BBlskziw10XEJmuFlfT0zXkd7FvJEaZHf3AGSOpJAM+qb6VBLK8jpIqBxnY3+D8W/8a
        PqfwB93RTqDJCoTIMpfHc62pP1YMWW1fLwYwIA0PIBFJJt+fVvVozkhjRIx1ul6q4moGdG
        6Ap9YOt1drQ63/fPnr9rhIpvHezOq5c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-4qo-28SxN9qoCiIivXw5sQ-1; Thu, 24 Jun 2021 19:46:57 -0400
X-MC-Unique: 4qo-28SxN9qoCiIivXw5sQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 36EB818414A1;
        Thu, 24 Jun 2021 23:46:56 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-70.bne.redhat.com [10.64.54.70])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EF71760871;
        Thu, 24 Jun 2021 23:46:45 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, alexander.duyck@gmail.com,
        david@redhat.com, mst@redhat.com, akpm@linux-foundation.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v4 4/4] virtio_balloon: Specify page reporting order if needed
Date:   Fri, 25 Jun 2021 09:47:10 +0800
Message-Id: <20210625014710.42954-5-gshan@redhat.com>
In-Reply-To: <20210625014710.42954-1-gshan@redhat.com>
References: <20210625014710.42954-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/virtio/virtio_balloon.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 510e9318854d..47dce91f788c 100644
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
+		 * Ideally, the page reporting order is selected based on the
+		 * host's base page size. However, it needs more work to report
+		 * that value. The hard-coded order would be fine currently.
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

