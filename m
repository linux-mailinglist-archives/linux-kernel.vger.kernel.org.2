Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A6D8A3B9149
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 13:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236271AbhGALt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 07:49:26 -0400
Received: from smtp1.axis.com ([195.60.68.17]:63953 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236230AbhGALtZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 07:49:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1625140015;
  x=1656676015;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hBC7lTy6FHyGqO0SQzntsJ4n9KAu05Qu1gGf+/akR6U=;
  b=NLbU5VeyIEqhffe5/tP0RoMASIq5H52Dbnv+GN+BeTS05p1u+hPNvvDA
   z9eInJyXI3g0ftFPUruSDvqtGIGSjmiBifk0iK+1kthr6hkKE+ATqct0Z
   j9kCUQnVXPERjrwMPzEXttq9rVvlr2RgyXaojdHYv119COadW1eGvkyvV
   ga565TZjKRtKsKXmDyX4f3D+n4mVMNNMQ5sMMyN+qqqYGUFnzYbHR03yU
   TH8bdoAxegF+BLoVKcWRzB1tyrHVRyoIR6K3RgIf8xh1zg7ljMm+lq0on
   TbiG6tT2noVwKSKMjqTgvpC4qtgwAaRXWhHkRinCXWSgfT26+ZAy9KuYM
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>
CC:     <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        <virtualization@lists.linux-foundation.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] virtio_vdpa: reject invalid vq indices
Date:   Thu, 1 Jul 2021 13:46:52 +0200
Message-ID: <20210701114652.21956-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not call vDPA drivers' callbacks with vq indicies larger than what
the drivers indicate that they support.  vDPA drivers do not bounds
check the indices.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/virtio/virtio_vdpa.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
index e28acf482e0c..e9b9dd03f44a 100644
--- a/drivers/virtio/virtio_vdpa.c
+++ b/drivers/virtio/virtio_vdpa.c
@@ -149,6 +149,9 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsigned int index,
 	if (!name)
 		return NULL;
 
+	if (index >= vdpa->nvqs)
+		return ERR_PTR(-ENOENT);
+
 	/* Queue shouldn't already be set up. */
 	if (ops->get_vq_ready(vdpa, index))
 		return ERR_PTR(-ENOENT);
-- 
2.28.0

