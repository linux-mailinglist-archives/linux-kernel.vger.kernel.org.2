Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 191BD432ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 09:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234382AbhJSHFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 03:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41292 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234381AbhJSHFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 03:05:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634626979;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g3A+EbDWBFX+qusok6WMO60ZKB5OaNFcZR/Wkd3ITzA=;
        b=I19gqx0SUpBb9jWUD+ZXnW8qAG7v5ftdIt7TPkRqak4RSD6C06/eBfU16b/B+Md43O5xkg
        aBz5lrb0tHFVe26JfJKxk7wnYgdJtPFzvCM39IQeq+hGkNviWdR0mkSVPLAayCs6vg7daY
        ddpaM9uHfGRBgkrBkhuX72Tl6TPpFF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-D_P53SEiO-6Wyx22rKSHzQ-1; Tue, 19 Oct 2021 03:02:56 -0400
X-MC-Unique: D_P53SEiO-6Wyx22rKSHzQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 171FB100C660;
        Tue, 19 Oct 2021 07:02:55 +0000 (UTC)
Received: from localhost.localdomain (ovpn-12-155.pek2.redhat.com [10.72.12.155])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 524B47092B;
        Tue, 19 Oct 2021 07:02:46 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Amit Shah <amit@kernel.org>
Subject: [PATCH V3 02/10] virtio_console: validate max_nr_ports before trying to use it
Date:   Tue, 19 Oct 2021 15:01:44 +0800
Message-Id: <20211019070152.8236-3-jasowang@redhat.com>
In-Reply-To: <20211019070152.8236-1-jasowang@redhat.com>
References: <20211019070152.8236-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We calculate nr_ports based on the max_nr_ports:

nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;

If the device advertises a large max_nr_ports, we will end up with a
integer overflow. Fixing this by validating the max_nr_ports and fail
the probe for invalid max_nr_ports in this case.

Cc: Amit Shah <amit@kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/char/virtio_console.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7eaf303a7a86..660c5c388c29 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -28,6 +28,7 @@
 #include "../tty/hvc/hvc_console.h"
 
 #define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
+#define VIRTCONS_MAX_PORTS 0x8000
 
 /*
  * This is a global struct for storing common data for all the devices
@@ -2036,6 +2037,14 @@ static int virtcons_probe(struct virtio_device *vdev)
 	    virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
 				 struct virtio_console_config, max_nr_ports,
 				 &portdev->max_nr_ports) == 0) {
+		if (portdev->max_nr_ports == 0 ||
+		    portdev->max_nr_ports > VIRTCONS_MAX_PORTS) {
+			dev_err(&vdev->dev,
+				"Invalidate max_nr_ports %d",
+				portdev->max_nr_ports);
+			err = -EINVAL;
+			goto free;
+		}
 		multiport = true;
 	}
 
-- 
2.25.1

