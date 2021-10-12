Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9121429E11
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:53:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbhJLGzI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:55:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232499AbhJLGzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:55:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634021585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+K4kt6jiYyHpuZzO5X/M+fhiiJdrYmcNWNspSWWUPP8=;
        b=I0YEVeOJ8qgKxTLZQMhBFD9A0tmBoSizFTd65hpvwRNowj3Bn7H3QjhlxGdqvc6UKIlkfB
        4h53x3Hv/ZjzanRPvDo69fKpN6sTaBJ+/oSJWX4pUBHBshDObS25kVN8SFKB8a5y3PCiYT
        Nod/SBcKPSksEBz8dlZvcmELlQmoQRE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-563-lX42bIKgOCOkpdi63T3AdQ-1; Tue, 12 Oct 2021 02:53:02 -0400
X-MC-Unique: lX42bIKgOCOkpdi63T3AdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ED362824FBB;
        Tue, 12 Oct 2021 06:52:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-111.pek2.redhat.com [10.72.13.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4949E5F4EA;
        Tue, 12 Oct 2021 06:52:33 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH V2 01/12] virtio-blk: validate num_queues during probe
Date:   Tue, 12 Oct 2021 14:52:16 +0800
Message-Id: <20211012065227.9953-2-jasowang@redhat.com>
In-Reply-To: <20211012065227.9953-1-jasowang@redhat.com>
References: <20211012065227.9953-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
Cc: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/block/virtio_blk.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9b3bd083b411..9deff01a38cb 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -495,7 +495,8 @@ static int init_vq(struct virtio_blk *vblk)
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_MQ,
 				   struct virtio_blk_config, num_queues,
 				   &num_vqs);
-	if (err)
+	/* We need at least one virtqueue */
+	if (err || !num_vqs)
 		num_vqs = 1;
 
 	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
-- 
2.25.1

