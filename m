Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 885D03E2F2F
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Aug 2021 20:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242753AbhHFSRq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Aug 2021 14:17:46 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21356 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237391AbhHFSRn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Aug 2021 14:17:43 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1628273841; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=j1uYsaOnVwADfra9cAnq1vMPUty/IN1OdWi/u2netOYaVLS8WfP2KBJFo7UQx0siKzSsjrC1MVlQtcWyML/2OgFhdswroFpl27xbkn82wgyyFBbce9kGsZEfEQJFMjlz4rtSGdlTIQ8kh/6oXjDfrHL/sRBUHPJ/3Bfz21eW1yU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1628273841; h=Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=wIZHSlWXbrNe2rwmZf7eFgX/iCxTUKxDTVlcmAcr1Ag=; 
        b=nma5a8PyUCS3ocmPm6C/WjSTrHhl2XXHDTstVYNVUz4ZBbG5S4/MznzmlYXk6ro99EBaUtCoDVQIO8RCCS8XXO9vVuD+5qDb2UCk47B2ja0YN1XEu7NRk8XTkxN7RbRxvg1PvS9GqlLBSzjQl3e9F/cnKHHEB4EENuo5IhYzY3E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1628273841;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
        bh=wIZHSlWXbrNe2rwmZf7eFgX/iCxTUKxDTVlcmAcr1Ag=;
        b=QsuCH48BF/59cBuyk0eqrt3VnhHOPFggMFrkZ/m+GdQyW8kffBK7azmr5vwQsEoV
        KrmZ5+LuCws00vtGJXqfC4c9c6hsSEIgeqyxXO3u5MBs3T/h33++/W8Oy2y2NITKi5T
        nWGcokZKzxdo4Dw3adojlSj4K/5oJ8Wu6T1DSyMU=
Received: from localhost.localdomain (106.51.104.154 [106.51.104.154]) by mx.zohomail.com
        with SMTPS id 16282738279641019.1462176919549; Fri, 6 Aug 2021 11:17:07 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Anirudh Rayabharam <mail@anirudhrb.com>,
        syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] usbip: give back URBs for unsent unlink requests during cleanup
Date:   Fri,  6 Aug 2021 23:43:35 +0530
Message-Id: <20210806181335.2078-1-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
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
requests (unlink_rx list) are given back. Since the code is almost the
same, extract it into a new function and call it for both unlink_rx and
unlink_tx lists.

[1]: https://syzkaller.appspot.com/bug?id=08f12df95ae7da69814e64eb5515d5a85ed06b76

Reported-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
Tested-by: syzbot+74d6ef051d3d2eacf428@syzkaller.appspotmail.com
Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---

Changes in v2:
Use WARN_ON() instead of BUG() when unlink_list is neither unlink_tx nor
unlink_rx.

v1: https://lore.kernel.org/lkml/20210806164015.25263-1-mail@anirudhrb.com/

---
 drivers/usb/usbip/vhci_hcd.c | 45 +++++++++++++++++++++++++-----------
 1 file changed, 32 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 4ba6bcdaa8e9..67e638f4c455 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -945,7 +945,8 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	return 0;
 }
 
-static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
+static void __vhci_cleanup_unlink_list(struct vhci_device *vdev,
+		struct list_head *unlink_list)
 {
 	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
 	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
@@ -953,23 +954,23 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
 	struct vhci_unlink *unlink, *tmp;
 	unsigned long flags;
 
+	if (WARN(unlink_list != &vdev->unlink_tx
+				&& unlink_list != &vdev->unlink_rx,
+			"Invalid list passed to __vhci_cleanup_unlink_list\n"))
+		return;
+
 	spin_lock_irqsave(&vhci->lock, flags);
 	spin_lock(&vdev->priv_lock);
 
-	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
-		pr_info("unlink cleanup tx %lu\n", unlink->unlink_seqnum);
-		list_del(&unlink->list);
-		kfree(unlink);
-	}
-
-	while (!list_empty(&vdev->unlink_rx)) {
+	list_for_each_entry_safe(unlink, tmp, unlink_list, list) {
 		struct urb *urb;
 
-		unlink = list_first_entry(&vdev->unlink_rx, struct vhci_unlink,
-			list);
-
-		/* give back URB of unanswered unlink request */
-		pr_info("unlink cleanup rx %lu\n", unlink->unlink_seqnum);
+		if (unlink_list == &vdev->unlink_tx)
+			pr_info("unlink cleanup tx %lu\n",
+					unlink->unlink_seqnum);
+		else
+			pr_info("unlink cleanup rx %lu\n",
+					unlink->unlink_seqnum);
 
 		urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
 		if (!urb) {
@@ -1001,6 +1002,24 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
 	spin_unlock_irqrestore(&vhci->lock, flags);
 }
 
+static inline void vhci_cleanup_unlink_tx(struct vhci_device *vdev)
+{
+	__vhci_cleanup_unlink_list(vdev, &vdev->unlink_tx);
+}
+
+static inline void vhci_cleanup_unlink_rx(struct vhci_device *vdev)
+{
+	__vhci_cleanup_unlink_list(vdev, &vdev->unlink_rx);
+}
+
+static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
+{
+	/* give back URBs of unsent unlink requests */
+	vhci_cleanup_unlink_tx(vdev);
+	/* give back URBs of unanswered unlink requests */
+	vhci_cleanup_unlink_rx(vdev);
+}
+
 /*
  * The important thing is that only one context begins cleanup.
  * This is why error handling and cleanup become simple.
-- 
2.26.2

