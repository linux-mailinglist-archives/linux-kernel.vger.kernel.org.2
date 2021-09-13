Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B3F40842F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 07:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237209AbhIMFz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 01:55:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237183AbhIMFz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 01:55:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631512481;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JEx0s8/aKXt0XKMD6l6fHz2qIfkUzAG/Tkrbj3E9G4I=;
        b=DH86yepjZNfnfqn9RkkAaI5B0WKZyvLxg+/AOt5/zSdq8GJPYn4RgFMmGaC0u3xwPowlWU
        wRfabEbTbZD/2mm3InitwdQX0bw868mKBmG4Au65761V9ShnEU/EaLF2vbMcnM2il9RaKC
        huxG8joPEwOJJLLSUPEWAWnoVCYpE0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-301-Mr5BwugGMlCO3EwREBRr5A-1; Mon, 13 Sep 2021 01:54:37 -0400
X-MC-Unique: Mr5BwugGMlCO3EwREBRr5A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 30A808145FF;
        Mon, 13 Sep 2021 05:54:36 +0000 (UTC)
Received: from localhost.localdomain (ovpn-13-146.pek2.redhat.com [10.72.13.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 615D15F706;
        Mon, 13 Sep 2021 05:54:33 +0000 (UTC)
From:   Jason Wang <jasowang@redhat.com>
To:     mst@redhat.com, jasowang@redhat.com
Cc:     virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, f.hetzelt@tu-berlin.de,
        david.kaplan@amd.com, konrad.wilk@oracle.com,
        Amit Shah <amit@kernel.org>
Subject: [PATCH 3/9] virtio-console: switch to use .validate()
Date:   Mon, 13 Sep 2021 13:53:47 +0800
Message-Id: <20210913055353.35219-4-jasowang@redhat.com>
In-Reply-To: <20210913055353.35219-1-jasowang@redhat.com>
References: <20210913055353.35219-1-jasowang@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch switches to use validate() to filter out the features that
is not supported by the rproc.

Cc: Amit Shah <amit@kernel.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 drivers/char/virtio_console.c | 41 ++++++++++++++++++++++-------------
 1 file changed, 26 insertions(+), 15 deletions(-)

diff --git a/drivers/char/virtio_console.c b/drivers/char/virtio_console.c
index 7eaf303a7a86..daeed31df622 100644
--- a/drivers/char/virtio_console.c
+++ b/drivers/char/virtio_console.c
@@ -1172,9 +1172,7 @@ static void resize_console(struct port *port)
 
 	vdev = port->portdev->vdev;
 
-	/* Don't test F_SIZE at all if we're rproc: not a valid feature! */
-	if (!is_rproc_serial(vdev) &&
-	    virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
+	if (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE))
 		hvc_resize(port->cons.hvc, port->cons.ws);
 }
 
@@ -1981,6 +1979,29 @@ static void virtcons_remove(struct virtio_device *vdev)
 	kfree(portdev);
 }
 
+static int virtcons_validate(struct virtio_device *vdev)
+{
+	if (is_rproc_serial(vdev)) {
+		/* Don't test F_SIZE at all if we're rproc: not a
+		 * valid feature! */
+		__virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_SIZE);
+		/* Don't test MULTIPORT at all if we're rproc: not a
+		 * valid feature! */
+		__virtio_clear_bit(vdev, VIRTIO_CONSOLE_F_MULTIPORT);
+	}
+
+	/* We only need a config space if features are offered */
+	if (!vdev->config->get &&
+	    (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
+	     || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
+		dev_err(&vdev->dev, "%s failure: config access disabled\n",
+			__func__);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * Once we're further in boot, we get probed like any other virtio
  * device.
@@ -1996,15 +2017,6 @@ static int virtcons_probe(struct virtio_device *vdev)
 	bool multiport;
 	bool early = early_put_chars != NULL;
 
-	/* We only need a config space if features are offered */
-	if (!vdev->config->get &&
-	    (virtio_has_feature(vdev, VIRTIO_CONSOLE_F_SIZE)
-	     || virtio_has_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT))) {
-		dev_err(&vdev->dev, "%s failure: config access disabled\n",
-			__func__);
-		return -EINVAL;
-	}
-
 	/* Ensure to read early_put_chars now */
 	barrier();
 
@@ -2031,9 +2043,7 @@ static int virtcons_probe(struct virtio_device *vdev)
 	multiport = false;
 	portdev->max_nr_ports = 1;
 
-	/* Don't test MULTIPORT at all if we're rproc: not a valid feature! */
-	if (!is_rproc_serial(vdev) &&
-	    virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
+	if (virtio_cread_feature(vdev, VIRTIO_CONSOLE_F_MULTIPORT,
 				 struct virtio_console_config, max_nr_ports,
 				 &portdev->max_nr_ports) == 0) {
 		multiport = true;
@@ -2210,6 +2220,7 @@ static struct virtio_driver virtio_console = {
 	.driver.name =	KBUILD_MODNAME,
 	.driver.owner =	THIS_MODULE,
 	.id_table =	id_table,
+	.validate = 	virtcons_validate,
 	.probe =	virtcons_probe,
 	.remove =	virtcons_remove,
 	.config_changed = config_intr,
-- 
2.25.1

