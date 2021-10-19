Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C76432ECF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234378AbhJSHFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40145 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234275AbhJSHFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634626970;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oL6/cVcuaDrSgWzB854zcRW5Ti8DFEqrr605igM6rZM=;
        b=YhMoHArrKn9AYQxtstzCTfKszdCJotKjyS3UNmuNmHuAXLA35hdnkgRPIxzJvREnR+AGGY
        zxQ5dXv6oHZi6vp98kHMDMcEZ5N7uS8S+GFt1dThXUSslu+jqoBfHXlW9qegPFVxxlATOV
        qa8CjdQPJxmF3pJycXxTq/WuoiiGfG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-283-1O-IDf2AO4SHYIVIPDsOqA-1; Tue, 19 Oct 2021 03:02:47 -0400
X-MC-Unique: 1O-IDf2AO4SHYIVIPDsOqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD17091272;
        Tue, 19 Oct 2021 07:02:45 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-155.pek2.redhat.com [10.72.12.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3AEC970956;
        Tue, 19 Oct 2021 07:02:11 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH V3 01/10] virtio-blk: validate num_queues during probe
Date:   Tue, 19 Oct 2021 15:01:43 +0800
Message-Id: <20211019070152.8236-2-jasowang@redhat.com>
In-Reply-To: <20211019070152.8236-1-jasowang@redhat.com>
References: <20211019070152.8236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If an untrusted device neogitates BLK_F_MQ but advertises a zero
num_queues, the driver may end up trying to allocating zero size
buffers where ZERO_SIZE_PTR is returned which may pass the checking
against the NULL. This will lead unexpected results.

Fixing this by failing the probe in this case.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/block/virtio_blk.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 9b3bd083b411..10bc0879e618 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -497,6 +497,10 @@ static int init_vq(struct virtio_blk *vblk)
 				   &num_vqs);
 	if (err)
 		num_vqs = 1;
+	if (!err && !num_vqs) {
+		dev_err(&vdev->dev, "MQ advertisted but zero queues reported\n");
+		return -EINVAL;
+	}
 
 	num_vqs = min_t(unsigned int, nr_cpu_ids, num_vqs);
 
-- 
2.25.1

