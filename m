Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9030F408429
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237163AbhIMFzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:55:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230390AbhIMFzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:55:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631512468;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JVcoRs6vCll2DBs4INaAB12noZulXuAcHA8wZRFtb1U=;
        b=QyJLW6ThrytGYLpwGIE2bg3F5cC0GRBwQwbTUZqA1rkjo3VLTYv4jDXIWkQ39IBZ1VecEZ
        onqWvr4LVYEnOJq4+dMSUnVYrUkrI7oZ2/cC/a5eINFh6525cJOaxmILXL0kb3zNJpAJCw
        ffajBQEV/psbWVBxQ/OO+e1dGUsSw9g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-OS7aoxwvNNiFl-nb5TlXsQ-1; Mon, 13 Sep 2021 01:54:23 -0400
X-MC-Unique: OS7aoxwvNNiFl-nb5TlXsQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 04001800FF3;
        Mon, 13 Sep 2021 05:54:22 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6AF7C5C23A;
        Mon, 13 Sep 2021 05:54:11 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 1/9] virtio-blk: validate num_queues during probe
Date:   Mon, 13 Sep 2021 13:53:45 +0800
Message-Id: <20210913055353.35219-2-jasowang@redhat.com>
In-Reply-To: <20210913055353.35219-1-jasowang@redhat.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an untrusted device neogitates BLK_F_MQ but advertises a zero
num_queues, the driver may end up trying to allocating zero size
buffers where ZERO_SIZE_PTR is returned which may pass the checking
against the NULL. This will lead unexpected results.

Fixing this by using single queue if num_queues is zero.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/block/virtio_blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index e574fbf5e6df..f130d12df4b9 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -498,7 +498,8 @@ static int init_vq(struct virtio_blk *vblk)
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
 				   struct virtio_blk_config, num_queues,
 				   &num_vqs);
-	if (err)
+	/* We need at least on virtqueue */
+	if (err || !num_vqs)
 		num_vqs = 1;
 
 	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
-- 
2.25.1

