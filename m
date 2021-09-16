Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52EA540D783
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 12:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236956AbhIPKfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 06:35:51 -0400
Received: from foss.arm.com ([217.140.110.172]:36054 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236877AbhIPKft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 06:35:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 08DF01063;
        Thu, 16 Sep 2021 03:34:29 -0700 (PDT)
Received: from e120937-lin.home (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 69F7C3F5A1;
        Thu, 16 Sep 2021 03:34:25 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux-foundation.org,
        virtio-dev@lists.oasis-open.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        Jonathan.Cameron@Huawei.com, f.fainelli@gmail.com,
        etienne.carriere@linaro.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, cristian.marussi@arm.com,
        igor.skalkin@opensynergy.com, peter.hilber@opensynergy.com,
        alex.bennee@linaro.org, jean-philippe@linaro.org,
        mikhail.golubev@opensynergy.com, anton.yakovlev@opensynergy.com,
        Vasyl.Vavrychuk@opensynergy.com, Tryshnivskyy@opensynergy.com,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [PATCH 3/3] firmware: arm_scmi: Add proper barriers to scmi virtio device
Date:   Thu, 16 Sep 2021 11:33:36 +0100
Message-Id: <20210916103336.7243-3-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210916103336.7243-1-cristian.marussi@arm.com>
References: <20210916103336.7243-1-cristian.marussi@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only one single SCMI Virtio device is currently supported by this driver
and it is referenced using a static global variable which is initialized
once for all during probing and nullified at virtio device removal.

Add proper SMP barriers to protect accesses to such device reference to
ensure that the initialzation state of such device is correctly observed by
all PEs at any time.

Return -EBUSY, instead of -EINVAL, and a descriptive error message if more
than one SCMI Virtio device is ever found and probed.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
---
 drivers/firmware/arm_scmi/virtio.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/firmware/arm_scmi/virtio.c b/drivers/firmware/arm_scmi/virtio.c
index 633b5bc379a4..3671986ea056 100644
--- a/drivers/firmware/arm_scmi/virtio.c
+++ b/drivers/firmware/arm_scmi/virtio.c
@@ -389,8 +389,11 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 	struct virtqueue *vqs[VIRTIO_SCMI_VQ_MAX_CNT];
 
 	/* Only one SCMI VirtiO device allowed */
-	if (scmi_vdev)
-		return -EINVAL;
+	if (scmi_vdev) {
+		dev_err(dev,
+			"One SCMI Virtio device was already initialized: only one allowed.\n");
+		return -EBUSY;
+	}
 
 	have_vq_rx = scmi_vio_have_vq_rx(vdev);
 	vq_cnt = have_vq_rx ? VIRTIO_SCMI_VQ_MAX_CNT : 1;
@@ -433,7 +436,8 @@ static int scmi_vio_probe(struct virtio_device *vdev)
 	}
 
 	vdev->priv = channels;
-	scmi_vdev = vdev;
+	/* Ensure initialized scmi_vdev is visible */
+	smp_store_mb(scmi_vdev, vdev);
 
 	return 0;
 }
@@ -449,7 +453,8 @@ static void scmi_vio_remove(struct virtio_device *vdev)
 	 */
 	vdev->config->reset(vdev);
 	vdev->config->del_vqs(vdev);
-	scmi_vdev = NULL;
+	/* Ensure scmi_vdev is visible as NULL */
+	smp_store_mb(scmi_vdev, NULL);
 }
 
 static int scmi_vio_validate(struct virtio_device *vdev)
-- 
2.17.1

