Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 227A339B1C5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 07:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbhFDFEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 01:04:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28496 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229452AbhFDFEu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 01:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622782984;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=+hDkFi5ZYUZ3jBb2V5PsH7ZZDofu/h3dA2rI7yC8vcI=;
        b=X7oy00rv40CC7eCPoHaaFuRVQuKHemFqCT97vkarN1tCxeIBtOXbnva1eFr8kSfEQWi1dQ
        YRINTDKQMEbAKsKgEjx+saHEkiLk4t8H6bxaBNlDRC2aFAl4dPGcIrNRwQcOuYK6t38INH
        j98YY35KF4HAEM8/aN29MxDdCyVQr9o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-564-bfAASkkwO5ODTcXbC1j1hw-1; Fri, 04 Jun 2021 01:03:00 -0400
X-MC-Unique: bfAASkkwO5ODTcXbC1j1hw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E206D8042AD;
        Fri,  4 Jun 2021 05:02:59 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-212.pek2.redhat.com [10.72.12.212])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A234E5E275;
        Fri,  4 Jun 2021 05:02:53 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, elic@nvidia.com, parav@nvidia.com
Subject: [PATCH] vdpa: mandate 1.0 device
Date:   Fri,  4 Jun 2021 13:02:51 +0800
Message-Id: <20210604050251.57834-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch mandates 1.0 for vDPA devices. The plan is never to support
transitional devices for vDPA devices in the future.

The reasons are:

- To have the semantic of normative statement in the virtio spec and
  eliminate the burden of transitional device for both vDPA bus and
  vDPA parent
- Eliminate the efforts for dealing with endian conversion in the
  management tool
- Mandate vDPA vendor to ship modern device instead of transitional
  device which is easily broken and unsafe
- Transitional device never work since the first day of vDPA

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 include/linux/vdpa.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/vdpa.h b/include/linux/vdpa.h
index f311d227aa1b..11dd05b805a7 100644
--- a/include/linux/vdpa.h
+++ b/include/linux/vdpa.h
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <linux/interrupt.h>
 #include <linux/vhost_iotlb.h>
+#include <uapi/linux/virtio_config.h>
 
 /**
  * struct vdpa_calllback - vDPA callback definition.
@@ -328,6 +329,11 @@ static inline int vdpa_set_features(struct vdpa_device *vdev, u64 features)
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

