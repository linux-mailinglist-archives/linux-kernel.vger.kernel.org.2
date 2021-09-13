Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595F340842C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237187AbhIMFzx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:55:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20977 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237076AbhIMFzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:55:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631512477;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NJsTI+KFL7pLeFRyp+qdwZwuj18SjbP5mzSynYjMDJA=;
        b=apPdgHSPgfyDUlFNg+nq2SXHeaMSts/sHKV3cbLDTapMgDNQglUYszI0Rc1gxmDb7QXf6A
        VIaIQj1AC/4K0NTeasCwEVcp1NzmvYBgWxxy/LSXFuvmdzMUmo/oP4jWX2kcW1rPR1XOnU
        RwmE8Ppzpz0p1qpqh4Cc08w0YBIDWhc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-adSM7QBtOmaM2Y14rbbKXg-1; Mon, 13 Sep 2021 01:54:34 -0400
X-MC-Unique: adSM7QBtOmaM2Y14rbbKXg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2431362F9;
        Mon, 13 Sep 2021 05:54:32 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4901E5C3E0;
        Mon, 13 Sep 2021 05:54:22 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com
Subject: [PATCH 2/9] virtio: add doc for validate() method
Date:   Mon, 13 Sep 2021 13:53:46 +0800
Message-Id: <20210913055353.35219-3-jasowang@redhat.com>
In-Reply-To: <20210913055353.35219-1-jasowang@redhat.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
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

