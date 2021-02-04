Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0C630F9A2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 18:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbhBDR0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 12:26:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25372 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238535AbhBDR0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 12:26:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612459480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4j9zpih3Ykwem+k26aYRkULpCXmZClGuMDmmSgi8w0A=;
        b=e9JaO/w0KPBNxB+Lwu5yjfQ2FMl43/nE8SYrMsKVIxscwp8jMFZJsOcO/m0sLGFtt4akFA
        sGIgoaM7Vllf69/8DrhLa5pIEoOGEqpN1Knt3TpEKTuA6An3Mo5I1PpxS/wVug0gcm9nIH
        4mnIADWI4bhAKPAmdv59Fz4xW0Jn8sI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-o2Nj-lmQOB2Y9X-alkiFkw-1; Thu, 04 Feb 2021 12:24:37 -0500
X-MC-Unique: o2Nj-lmQOB2Y9X-alkiFkw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 625298799ED;
        Thu,  4 Feb 2021 17:24:35 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-213.ams2.redhat.com [10.36.113.213])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EA8B35C3FD;
        Thu,  4 Feb 2021 17:24:30 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     Stefano Garzarella <sgarzare@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>, kvm@vger.kernel.org,
        Laurent Vivier <lvivier@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Max Gurtovoy <mgurtovoy@nvidia.com>,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH v3 13/13] vdpa_sim_blk: handle VIRTIO_BLK_T_GET_ID
Date:   Thu,  4 Feb 2021 18:22:30 +0100
Message-Id: <20210204172230.85853-14-sgarzare@redhat.com>
In-Reply-To: <20210204172230.85853-1-sgarzare@redhat.com>
References: <20210204172230.85853-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle VIRTIO_BLK_T_GET_ID request, always answering the
"vdpa_blk_sim" string.

Acked-by: Jason Wang <jasowang@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
v2:
- made 'vdpasim_blk_id' static [Jason]
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index 2652a499fb34..4e4112dda616 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -37,6 +37,7 @@
 #define VDPASIM_BLK_VQ_NUM	1
 
 static struct vdpasim *vdpasim_blk_dev;
+static char vdpasim_blk_id[VIRTIO_BLK_ID_BYTES] = "vdpa_blk_sim";
 
 static bool vdpasim_blk_check_range(u64 start_sector, size_t range_size)
 {
@@ -152,6 +153,20 @@ static bool vdpasim_blk_handle_req(struct vdpasim *vdpasim,
 		}
 		break;
 
+	case VIRTIO_BLK_T_GET_ID:
+		bytes = vringh_iov_push_iotlb(&vq->vring, &vq->in_iov,
+					      vdpasim_blk_id,
+					      VIRTIO_BLK_ID_BYTES);
+		if (bytes < 0) {
+			dev_err(&vdpasim->vdpa.dev,
+				"vringh_iov_push_iotlb() error: %zd\n", bytes);
+			status = VIRTIO_BLK_S_IOERR;
+			break;
+		}
+
+		pushed += bytes;
+		break;
+
 	default:
 		dev_warn(&vdpasim->vdpa.dev,
 			 "Unsupported request type %d\n", type);
-- 
2.29.2

