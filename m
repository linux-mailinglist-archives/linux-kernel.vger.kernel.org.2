Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2B053EBC07
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233262AbhHMS0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:26:35 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21389 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbhHMS0e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:26:34 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1628879164; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=VtledMqoj4buK1l6XqV9NZhWH8bpS6vX6CinaxKBwtphmi7DzvQjKFvPWZEvmboTfa+N8nPxpJnZkzZkYhJHWdiZWtuCZW3aYiiMRU1Gd6hWSeXh8LmqUqmWUbLMiDotAu2T+T45CMo2aqSpFX6/KHRpnaKKY6KEDC7DJVE3kJw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1628879164; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=b2I2aydOcN7RGQlpbBtHwZwGygVFKfRrP8IbdWl2eSI=; 
        b=fc/MLx5Ath7BdGAM6yOrkbrNJehYGNxkofKJ808fpLqNETdmT6PZxynZx8qJFshhEY/uhFlNuI4sFFzgKDcHcmCFsvvq8UTXI3r/eWncjsVW+cfsoUCM7uh8HwNZUSneEvodZP2AX1O104iyGnEWVGT+psSNOTscR8b+dpOvOqE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1628879164;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=b2I2aydOcN7RGQlpbBtHwZwGygVFKfRrP8IbdWl2eSI=;
        b=guLIaS4cPL3vl+m/qKiUyZO3EWdIlgK3j67X/CpLAJe1Vb72EkHd6Dj/KiuHC6Un
        xDyFaRuT2fVNS6jOKFdraq9p5XdeEOUJGqFkI7kqLQaacariFqU4xG4gPtC5ou4v7LO
        SMYSr4ze76NGiIIVRu2pYDTf0MwfgnqxLy30VUHg=
Received: from localhost.localdomain (49.207.58.140 [49.207.58.140]) by mx.zohomail.com
        with SMTPS id 1628879163555621.7556704124663; Fri, 13 Aug 2021 11:26:03 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
Subject: [PATCH v3 1/2] usbip: give back URBs for unsent unlink requests during cleanup
Date:   Fri, 13 Aug 2021 23:55:07 +0530
Message-Id: <20210813182508.28127-2-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210813182508.28127-1-mail@anirudhrb.com>
References: <20210813182508.28127-1-mail@anirudhrb.com>
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
 drivers/usb/usbip/vhci_hcd.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 4ba6bcdaa8e9..6f3f374d4bbc 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -957,8 +957,34 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
 	spin_lock(&vdev->priv_lock);
 
 	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
+		struct urb *urb;
+
+		/* give back URB of unsent unlink request */
 		pr_info("unlink cleanup tx %lu\n", unlink->unlink_seqnum);
+
+		urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
+		if (!urb) {
+			pr_info("the urb (seqnum %lu) was already given back\n",
+				unlink->unlink_seqnum);
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

