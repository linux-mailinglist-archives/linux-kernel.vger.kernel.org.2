Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676DA3F3432
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Aug 2021 21:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbhHTTCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 15:02:22 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21315 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhHTTCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 15:02:17 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1629486093; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=E/SUOsDx4J8OBPzvPApxO6YMpQU43dX2d/sB+/3L3kip5QtsjPVKqY/Cq9peSfXlp/+VB/yJee6FsOdYtu99MPfxVN7wWITwkWj1W7kk5B/TsuOve/lpkVcyudHP4cmWhn9UraioN6YU674hAHL8JHsvX94xwfMAJ24S+3dfZQQ=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1629486093; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=VaQmeh3iUml0keMU5L20GSOBE+eGSZMMUKfwK5JVQFk=; 
        b=Peup9wk841gDkpHQaNH+RA/+qfommeoOcBobBlL6nC5mvNZ44WPNFd22BlRFx5uRonRAwikjcxK+Kzx1iBfbBunmxKNHBb8LGksvlzRW1aKPimIHOz8GJQb7c7LMNDsQmcw7gcIdO9rI7D56BrmtwLg1fCbM7h+paZosvBHnNC0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1629486093;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=VaQmeh3iUml0keMU5L20GSOBE+eGSZMMUKfwK5JVQFk=;
        b=g93pIeyh5RKl/VInfGt90Kjq0koeLOlSjNXDspEc8JnrmdRNZPhojjvSq0SFlP5c
        qW1AyO0/B2gHosC6E4Zyx+wNJw/EwLpiT7ziNiQ/M4yPusNEbhKLFk3qM35QTZf+su1
        ObaFQZYFO5gcKhtON+dfKyvNVirU44eiX+IporvU=
Received: from localhost.localdomain (106.51.111.164 [106.51.111.164]) by mx.zohomail.com
        with SMTPS id 1629486091929496.66891212896655; Fri, 20 Aug 2021 12:01:31 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v4 1/2] usbip: give back URBs for unsent unlink requests during cleanup
Date:   Sat, 21 Aug 2021 00:31:21 +0530
Message-Id: <20210820190122.16379-2-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210820190122.16379-1-mail@anirudhrb.com>
References: <20210820190122.16379-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In vhci_device_unlink_cleanup(), the URBs for unsent unlink requests are
not given back. This sometimes causes usb_kill_urb to wait indefinitely
for that urb to be given back. syzbot has reported a hung task issue [1]
for this.

To fix this, give back the urbs corresponding to unsent unlink requests
(unlink_tx list) similar to how urbs corresponding to unanswered unlink
requests (unlink_rx list) are given back.

[1]: https://syzkaller.appspot.com/bug?id=08f12df95ae7da69814e64eb5515d5a85ed06b76

Reported-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
Tested-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---
 drivers/usb/usbip/vhci_hcd.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 4ba6bcdaa8e9..190bd3d1c1f0 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -957,8 +957,32 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
 	spin_lock(&vdev->priv_lock);
 
 	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
+		struct urb *urb;
+
+		/* give back urb of unsent unlink request */
 		pr_info("unlink cleanup tx %lu\n", unlink->unlink_seqnum);
+
+		urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
+		if (!urb) {
+			list_del(&unlink->list);
+			kfree(unlink);
+			continue;
+		}
+
+		urb->status = -ENODEV;
+
+		usb_hcd_unlink_urb_from_ep(hcd, urb);
+
 		list_del(&unlink->list);
+
+		spin_unlock(&vdev->priv_lock);
+		spin_unlock_irqrestore(&vhci->lock, flags);
+
+		usb_hcd_giveback_urb(hcd, urb, urb->status);
+
+		spin_lock_irqsave(&vhci->lock, flags);
+		spin_lock(&vdev->priv_lock);
+
 		kfree(unlink);
 	}
 
-- 
2.26.2

