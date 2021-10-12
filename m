Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B419429E12
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233475AbhJLGzM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:55:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26033 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232499AbhJLGzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:55:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634021588;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJsTI+KFL7pLeFRyp+qdwZwuj18SjbP5mzSynYjMDJA=;
        b=EpE0RAw4JyhWlsXqSF9LoWWUXRec/1BHGNPCaOVvRTuG9CZiYgL+WoZXI2zlI3GwFYHvts
        nw0PzAY5T8bSmcWjquUsZDfGy3vy4QIHRiO/76YqPt0a+mtKrcS8x5keZHt5OPKmZ0lMAy
        93jvj6i9AAz5PiNU7cqaTfEgO7KZISM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-Ilt41PedPdW4I3NghXfcqA-1; Tue, 12 Oct 2021 02:53:07 -0400
X-MC-Unique: Ilt41PedPdW4I3NghXfcqA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2BE23101F7C1;
        Tue, 12 Oct 2021 06:52:40 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-111.pek2.redhat.com [10.72.13.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7C7A25F4E0;
        Tue, 12 Oct 2021 06:52:37 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: [PATCH V2 02/12] virtio: add doc for validate() method
Date:   Tue, 12 Oct 2021 14:52:17 +0800
Message-Id: <20211012065227.9953-3-jasowang@redhat.com>
In-Reply-To: <20211012065227.9953-1-jasowang@redhat.com>
References: <20211012065227.9953-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds doc for validate() method.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/virtio.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index 41edbc01ffa4..0cd8685aeba4 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -152,6 +152,7 @@ size_t virtio_max_dma_size(struct virtio_device *vdev);
  * @feature_table_size: number of entries in the feature table array.
  * @feature_table_legacy: same as feature_table but when working in legacy mode.
  * @feature_table_size_legacy: number of entries in feature table legacy array.
+ * @validate: optional function to do early checks
  * @probe: the function to call when a device is found.  Returns 0 or -errno.
  * @scan: optional function to call after successful probe; intended
  *    for virtio-scsi to invoke a scan.
-- 
2.25.1

