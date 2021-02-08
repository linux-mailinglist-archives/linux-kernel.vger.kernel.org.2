Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 352F8313D9C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 19:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhBHSdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 13:33:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:35373 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233139AbhBHQTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 11:19:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612801071;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CFslgI4BdX7W8W1Jxi7aVjgoo9QpMFhu3ejcV0QAAXo=;
        b=elUaNjopgJm77Yby7BQafYflUS1Qs40zHajO3D1MOvE5PhSyJte280244Xsx2eZWgHNzPX
        L+TiQfCguZ4WFpeK9HNszJsOxbE7PMOPTHZHsqo3jHrdWPLU/mceQKmi9GMA0e164nVI/l
        fBLNtwCayuTB4hTQIlicDEFocQ20eHY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-80-D4XTqdr-N8OYL04EYtxZsQ-1; Mon, 08 Feb 2021 11:17:49 -0500
X-MC-Unique: D4XTqdr-N8OYL04EYtxZsQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA5261966321;
        Mon,  8 Feb 2021 16:17:47 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-115-25.ams2.redhat.com [10.36.115.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 59D5A19C59;
        Mon,  8 Feb 2021 16:17:42 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     virtualization@lists.linux-foundation.org
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Parav Pandit <parav@nvidia.com>, Eli Cohen <elic@nvidia.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Date:   Mon,  8 Feb 2021 17:17:41 +0100
Message-Id: <20210208161741.104939-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's legal to have 'offset + len' equal to
sizeof(struct virtio_net_config), since 'ndev->config' is a
'struct virtio_net_config', so we can safely copy its content under
this condition.

Fixes: 1a86b377aa21 ("vdpa/mlx5: Add VDPA driver for supported mlx5 devices")
Cc: stable@vger.kernel.org
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 drivers/vdpa/mlx5/net/mlx5_vnet.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/vdpa/mlx5/net/mlx5_vnet.c b/drivers/vdpa/mlx5/net/mlx5_vnet.c
index dc88559a8d49..10e9b09932eb 100644
--- a/drivers/vdpa/mlx5/net/mlx5_vnet.c
+++ b/drivers/vdpa/mlx5/net/mlx5_vnet.c
@@ -1820,7 +1820,7 @@ static void mlx5_vdpa_get_config(struct vdpa_device *vdev, unsigned int offset,
 	struct mlx5_vdpa_dev *mvdev = to_mvdev(vdev);
 	struct mlx5_vdpa_net *ndev = to_mlx5_vdpa_ndev(mvdev);
 
-	if (offset + len < sizeof(struct virtio_net_config))
+	if (offset + len <= sizeof(struct virtio_net_config))
 		memcpy(buf, (u8 *)&ndev->config + offset, len);
 }
 
-- 
2.29.2

