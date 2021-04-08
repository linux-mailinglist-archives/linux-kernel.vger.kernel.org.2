Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CE5D357E04
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 10:27:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229690AbhDHI1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 04:27:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52227 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229539AbhDHI1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 04:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617870421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tp5v2YH5Yi9li+KSzkJrd9m6gNC6HOE1WkYusKD5XUE=;
        b=hFlA6QY2Dvv/iD8Bo64MaqHVwmMAmaP/5tjzOBx9jhdvL8cNPhfWORWW+vwX4VbOi3Xdkb
        bojm6iOjGf3wTAvwKRDlO3l+wWjfBCU4HwJW+w+vfEIwi8OPVuVBbJD80093L9P1H5TO/R
        CMDeC4fiT2EXFHalRwUPeQ0IhgNuPFM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-KQFmKFSkMIuDB2PSmWulJg-1; Thu, 08 Apr 2021 04:26:59 -0400
X-MC-Unique: KQFmKFSkMIuDB2PSmWulJg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 687C36D241;
        Thu,  8 Apr 2021 08:26:58 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-53.pek2.redhat.com [10.72.13.53])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 147DB5D9CC;
        Thu,  8 Apr 2021 08:26:51 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Cc:     parav@nvidia.com, elic@nvidia.com
Subject: [RFC PATCH] vdpa: mandate 1.0 device
Date:   Thu,  8 Apr 2021 16:26:48 +0800
Message-Id: <20210408082648.20145-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch mandates 1.0 for vDPA devices. The goal is to have the
semantic of normative statement in the virtio spec and eliminate the
burden of transitional device for both vDPA bus and vDPA parent.

uAPI seems fine since all the vDPA parent mandates
VIRTIO_F_ACCESS_PLATFORM which implies 1.0 devices.

For legacy guests, it can still work since Qemu will mediate when
necessary (e.g doing the endian conversion).

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index 0fefeb976877..cfde4ec999b4 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/vhost_iotlb.h>
+#include <uapi/linux/virtio_config.h>
 
 /**
  * vDPA callback definition.
@@ -317,6 +318,11 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
 {
         const struct vdpa_config_ops *ops = vdev->config;
 
+        /* Mandating 1.0 to have semantics of normative statements in
+         * the spec. */
+        if (!(features & BIT_ULL(VIRTIO_F_VERSION_1)))
+		return -EINVAL;
+
 	vdev->features_valid = true;
         return ops->set_features(vdev, features);
 }
-- 
2.25.1

