Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEEB429E1B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Oct 2021 08:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233787AbhJLGz1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 02:55:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232499AbhJLGzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 02:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634021593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j/QbFmrEsChXEIMzJ7DSys3s2nwcppdzH8aCGPBxMJA=;
        b=f8ixkVGPNf6upSA1QI/5tdgLon6d+uHn2Kc3S4ZgqEcfw+M6L1cFKeEpnxnHn5wM9NG56K
        fhPB21KA3X4f+U2eZ5Z6Ojd8DIDSZJtOMKxMSlkQfhz5cW2cwQSoMA2jHUUWNj5J4iLjdw
        kynIqcLPgE1jZaY9bmHGq0tjMzKMn2o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-8OP0pBBSOC29e6d-W96EvQ-1; Tue, 12 Oct 2021 02:53:11 -0400
X-MC-Unique: 8OP0pBBSOC29e6d-W96EvQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0B17210144FB;
        Tue, 12 Oct 2021 06:52:47 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-111.pek2.redhat.com [10.72.13.111])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 48BC05F4E0;
        Tue, 12 Oct 2021 06:52:43 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Amit Shah <amit@kernel.org>
Subject: [PATCH V2 04/12] virtio_console: validate max_nr_ports before trying to use it
Date:   Tue, 12 Oct 2021 14:52:19 +0800
Message-Id: <20211012065227.9953-5-jasowang@redhat.com>
In-Reply-To: <20211012065227.9953-1-jasowang@redhat.com>
References: <20211012065227.9953-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

