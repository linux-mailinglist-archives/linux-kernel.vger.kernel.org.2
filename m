Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D41E545DFFA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 18:47:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349418AbhKYRuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Nov 2021 12:50:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41029 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243584AbhKYRsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Nov 2021 12:48:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637862294;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=e7BvKG8FTSCUywCGOxNtwP0noXjOs1TD9Frr4bEkwQo=;
        b=O2aSF/RD7Oq8atMYDNJbtbEOj9wgCr5m6KvCvhsog9CeK1uk3zQ3rxOOusIu2xDhKU+hL0
        2risWaKQmETVCQx+qSN60/vWDvWKaYVSz2gbZ5Ssx/i9M9b3OITnIqIZ9EvPaotGoQFA0d
        aDZsvfGlo/VUXwe52H3nhlkHM/o11c8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-454-A8bCljkBPYeDh0CDGNfeKg-1; Thu, 25 Nov 2021 12:44:52 -0500
X-MC-Unique: A8bCljkBPYeDh0CDGNfeKg-1
Received: by mail-ed1-f72.google.com with SMTP id w18-20020a056402071200b003e61cbafdb4so6009891edx.4
        for <linux-kernel@vger.kernel.org>; Thu, 25 Nov 2021 09:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=e7BvKG8FTSCUywCGOxNtwP0noXjOs1TD9Frr4bEkwQo=;
        b=xXsmIJViVP7zgulaSiuFWCE3IOgV1Xg7k87xTcvBuhX45RJSfouOZ8pWY7G3YXlgwK
         AX2ZiPsWvEcJo+9BCnn9rarWtK9Gx0x3V11RgoQCS4mg7nEojVj9IPldG3ppE7lPx80V
         JZV2zuEF6ZquKUAOyl8JQxWUZiVdIjZhzG1pYs+FV26a+Rw3aRm7/zWRBJU+PxTzAMZR
         UeLOXz0evCRR8f4MMuXrJ+1YXRD6kmPYvEqm72pkKsdMJ5K5GAPkL1fBnMRCENMEbd1N
         /NfMqop7LNC54SxmM3xdZVag1BciDwOp/3POpXKx+VBQUDE50mP8ns8FavCChA8ITytX
         sNzQ==
X-Gm-Message-State: AOAM531cEpMQ+VHwGp/jAAMl4d5PRhCRZv4dJSBrxB14YBBtHGFvxVnl
        1R/VWkf4XbDoKD+fYHwzl6kkg5cUDcmY+5wdgjtgp0KFcmcSH8MF+HFtN+C/m+EiAlSNDx5DaGI
        dlaMEgBH3aSl//qdt3dBBUnFqsEbPiF55R5Ib5/7RZZluVGJXHSe9vbEXTNITbBdwlF2Ipg==
X-Received: by 2002:a05:6402:26c5:: with SMTP id x5mr41644321edd.198.1637862291252;
        Thu, 25 Nov 2021 09:44:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpwEn3VYvVMPaGoZd0qGJp74+cDdsbX2UWjVLjI4yEEPSqkH08d/TIHMG/MWFEShL7tUlQ4g==
X-Received: by 2002:a05:6402:26c5:: with SMTP id x5mr41644274edd.198.1637862291043;
        Thu, 25 Nov 2021 09:44:51 -0800 (PST)
Received: from redhat.com ([176.12.197.47])
        by smtp.gmail.com with ESMTPSA id og14sm1925383ejc.107.2021.11.25.09.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 09:44:50 -0800 (PST)
Date:   Thu, 25 Nov 2021 12:44:48 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        linux-bluetooth@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211125174200.133230-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Device removal is clearly out of virtio spec: it attempts to remove
unused buffers from a VQ before invoking device reset. To fix, make
open/close NOPs and do all cleanup/setup in probe/remove.

The cost here is a single skb wasted on an unused bt device - which
seems modest.

NB: with this fix in place driver still suffers from a race condition if
an interrupt triggers while device is being reset. Work on a fix for
that issue is in progress.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Note: completely untested, in particular the device isn't supported in QEMU.
Please do not queue directly - please help review and test and ack,
and I will queue this together with reset fixes.
Thanks!


 drivers/bluetooth/virtio_bt.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/virtio_bt.c b/drivers/bluetooth/virtio_bt.c
index 24a9258962fa..aea33ba9522c 100644
--- a/drivers/bluetooth/virtio_bt.c
+++ b/drivers/bluetooth/virtio_bt.c
@@ -50,8 +50,11 @@ static int virtbt_add_inbuf(struct virtio_bluetooth *vbt)
 
 static int virtbt_open(struct hci_dev *hdev)
 {
-	struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
+	return 0;
+}
 
+static int virtbt_open_vdev(struct virtio_bluetooth *vbt)
+{
 	if (virtbt_add_inbuf(vbt) < 0)
 		return -EIO;
 
@@ -61,7 +64,11 @@ static int virtbt_open(struct hci_dev *hdev)
 
 static int virtbt_close(struct hci_dev *hdev)
 {
-	struct virtio_bluetooth *vbt = hci_get_drvdata(hdev);
+	return 0;
+}
+
+static int virtbt_close_vdev(struct virtio_bluetooth *vbt)
+{
 	int i;
 
 	cancel_work_sync(&vbt->rx);
@@ -351,8 +358,14 @@ static int virtbt_probe(struct virtio_device *vdev)
 		goto failed;
 	}
 
+	virtio_device_ready(vdev);
+	if (virtbt_open_vdev(vbt))
+		goto open_failed;
+
 	return 0;
 
+open_failed:
+	hci_free_dev(hdev);
 failed:
 	vdev->config->del_vqs(vdev);
 	return err;
@@ -365,6 +378,7 @@ static void virtbt_remove(struct virtio_device *vdev)
 
 	hci_unregister_dev(hdev);
 	vdev->config->reset(vdev);
+	virtbt_close_vdev(vbt);
 
 	hci_free_dev(hdev);
 	vbt->hdev = NULL;
-- 
MST

