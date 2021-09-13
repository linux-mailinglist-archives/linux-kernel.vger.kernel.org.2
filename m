Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E548E408430
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237215AbhIMF4B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:56:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40402 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237196AbhIMFz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:55:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631512482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/QbFmrEsChXEIMzJ7DSys3s2nwcppdzH8aCGPBxMJA=;
        b=LMfby1Qp9xr7VEF3lvLQ2XUiMlADB+FdJ23NPguGqA0o7kNu0g1HMJ19/9Q2IipqqjXDUy
        w6np8Gi/xzy7ItZ2DIKFkqgBeqMmEAC4ByodcEYQ3xPqLKNJV5cZX5VSSL9vFq/2uoUdYQ
        nePMBfZjW0kGpwo2l1DXXYMia1IzUdo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-61-BkzRnxRuMk-OuTo3MdO9LQ-1; Mon, 13 Sep 2021 01:54:40 -0400
X-MC-Unique: BkzRnxRuMk-OuTo3MdO9LQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 89A421084681;
        Mon, 13 Sep 2021 05:54:39 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B29F65C25A;
        Mon, 13 Sep 2021 05:54:36 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Amit Shah <amit@kernel.org>
Subject: [PATCH 4/9] virtio_console: validate max_nr_ports before trying to use it
Date:   Mon, 13 Sep 2021 13:53:48 +0800
Message-Id: <20210913055353.35219-5-jasowang@redhat.com>
In-Reply-To: <20210913055353.35219-1-jasowang@redhat.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We calculate nr_ports based on the max_nr_ports:

nr_queues = use_multiport(portdev) ? (nr_ports + 1) * 2 : 2;

If the device advertises a large max_nr_ports, we will end up with a
integer overflow. Fixing this by validating the max_nr_ports
advertised by the device in .validate() and clear the MULTIPORT is
it's greater than 0x8000 (which is guaranteed be safe).

Cc: Amit Shah <amit@kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/char/virtio_console.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index daeed31df622..ef13763699c0 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -28,6 +28,7 @@
 #include "../tty/hvc/hvc_console.h"
 
 #define is_rproc_enabled IS_ENABLED(CONFIG_REMOTEPROC)
+#define VIRTCONS_MAX_PORTS 0x8000
 
 /*
  * This is a global struct for storing common data for all the devices
@@ -1981,6 +1982,8 @@ static void virtcons_remove(struct virtio_device *vdev)
 
 static int virtcons_validate(struct virtio_device *vdev)
 {
+	u32 max_nr_ports;
+
 	if (is_rproc_serial(vdev)) {
 		/* Don't test F_SIZE at all if we're rproc: not a
 		 * valid feature! */
@@ -1999,6 +2002,13 @@ static int virtcons_validate(struct virtio_device *vdev)
 		return -EINVAL;
 	}
 
+	if (virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
+				 struct virtio_console_config, max_nr_ports,
+				 &max_nr_ports) == 0) {
+		if (max_nr_ports == 0 || max_nr_ports > VIRTCONS_MAX_PORTS)
+			__virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_MULTIPORT);
+	}
+
 	return 0;
 }
 
-- 
2.25.1

