Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36B513EBC0B
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 20:27:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233277AbhHMS12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 14:27:28 -0400
Received: from sender4-of-o53.zoho.com ([136.143.188.53]:21395 "EHLO
        sender4-of-o53.zoho.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233276AbhHMS0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 14:26:42 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1628879172; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=U6IBDmJ5WLEkTyWX8Cwz67YvkIgzhQkYtyObb9so/FhTiwe5a/JL28dvOYQlaO0a+Qrerpv+a7Qiy2Ygxu2xI2otwyQdpFvGr0ObBK1urn2RD88LeGEdMdgLaU6hgR+1yb2NwtFOEVmy7Qc1pP9r+E3c973L5/OiU6VY0DZdxVg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1628879172; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=VT9prQakObj76qkfJx3PmUtiBqU9r7m5dMmTl99Pvzk=; 
        b=LXG6x8dq+6B2uktz0UEVXDAZoSfZpVT6LxyPLCvL8Nx9mD4vsMpNkGpWlDsBEVy1f5TwjJYmVx5zsxKa7dOwhEwvRzP3ypSsEzF5lTiL3HwoT7oUMG7nZ8m6R/PHw54vwwwSgaAvbiUb97HZf3MeJfi/RQxJylj6haqeNxa+AjA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=anirudhrb.com;
        spf=pass  smtp.mailfrom=mail@anirudhrb.com;
        dmarc=pass header.from=<mail@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1628879172;
        s=zoho; d=anirudhrb.com; i=mail@anirudhrb.com;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
        bh=VT9prQakObj76qkfJx3PmUtiBqU9r7m5dMmTl99Pvzk=;
        b=nvVhmZ+GdWG9ee6GBX51mJsdCYfDSgVdR/EiuwCqImJILqbbEE/pET3tQ3RjV/0m
        C9EgdqMaPYr8gkp41Pbk26qVGsgLx5IeyYGEGA88r/IPgTpBb/RUYYpC2qDnYXztaAA
        d2tNEZmI1nTx+WCD/JIAE+BOjqAg0s/r7JAzd//c=
Received: from localhost.localdomain (49.207.58.140 [49.207.58.140]) by mx.zohomail.com
        with SMTPS id 1628879170666216.37574659773452; Fri, 13 Aug 2021 11:26:10 -0700 (PDT)
From:   Anirudh Rayabharam <mail@anirudhrb.com>
To:     valentina.manea.m@gmail.com, shuah@kernel.org,
        gregkh@linuxfoundation.org
Cc:     Anirudh Rayabharam <mail@anirudhrb.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [PATCH v3 2/2] usbip: eliminate duplicate code in vhci_device_unlink_cleanup
Date:   Fri, 13 Aug 2021 23:55:08 +0530
Message-Id: <20210813182508.28127-3-mail@anirudhrb.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210813182508.28127-1-mail@anirudhrb.com>
References: <20210813182508.28127-1-mail@anirudhrb.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cleanup code for unlink_tx and unlink_rx lists is almost the same.
So, extract it into a new function and call it for both unlink_rx and
unlink_tx.

Signed-off-by: Anirudh Rayabharam <mail@anirudhrb.com>
---
 drivers/usb/usbip/vhci_hcd.c | 57 ++++++++++++------------------------
 1 file changed, 18 insertions(+), 39 deletions(-)

diff --git a/drivers/usb/usbip/vhci_hcd.c b/drivers/usb/usbip/vhci_hcd.c
index 6f3f374d4bbc..b142508b46ce 100644
--- a/drivers/usb/usbip/vhci_hcd.c
+++ b/drivers/usb/usbip/vhci_hcd.c
@@ -945,7 +945,8 @@ static int vhci_urb_dequeue(struct usb_hcd *hcd, struct urb *urb, int status)
 	return 0;
 }
 
-static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
+static void vhci_cleanup_unlink_list(struct vhci_device *vdev,
+		struct list_head *unlink_list)
 {
 	struct vhci_hcd *vhci_hcd = vdev_to_vhci_hcd(vdev);
 	struct usb_hcd *hcd = vhci_hcd_to_hcd(vhci_hcd);
@@ -956,46 +957,15 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
 	spin_lock_irqsave(&vhci->lock, flags);
 	spin_lock(&vdev->priv_lock);
 
-	list_for_each_entry_safe(unlink, tmp, &vdev->unlink_tx, list) {
+	list_for_each_entry_safe(unlink, tmp, unlink_list, list) {
 		struct urb *urb;
 
-		/* give back urb of unsent unlink request */
-		pr_info("unlink cleanup tx %lu\n", unlink->unlink_seqnum);
-
-		urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
-		if (!urb) {
-			pr_info("the urb (seqnum %lu) was already given back\n",
-				unlink->unlink_seqnum);
-			list_del(&unlink->list);
-			kfree(unlink);
-			continue;
-		}
-
-		urb->status = -ENODEV;
-
-		usb_hcd_unlink_urb_from_ep(hcd, urb);
-
-		list_del(&unlink->list);
-
-		spin_unlock(&vdev->priv_lock);
-		spin_unlock_irqrestore(&vhci->lock, flags);
-
-		usb_hcd_giveback_urb(hcd, urb, urb->status);
-
-		spin_lock_irqsave(&vhci->lock, flags);
-		spin_lock(&vdev->priv_lock);
-
-		kfree(unlink);
-	}
-
-	while (!list_empty(&vdev->unlink_rx)) {
-		struct urb *urb;
-
-		unlink = list_first_entry(&vdev->unlink_rx, struct vhci_unlink,
-			list);
-
-		/* give back URB of unanswered unlink request */
-		pr_info("unlink cleanup rx %lu\n", unlink->unlink_seqnum);
+		if (unlink_list == &vdev->unlink_tx)
+			pr_info("unlink cleanup tx %lu\n",
+					unlink->unlink_seqnum);
+		else
+			pr_info("unlink_cleanup rx %lu\n",
+					unlink->unlink_seqnum);
 
 		urb = pickup_urb_and_free_priv(vdev, unlink->unlink_seqnum);
 		if (!urb) {
@@ -1027,6 +997,15 @@ static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
 	spin_unlock_irqrestore(&vhci->lock, flags);
 }
 
+static void vhci_device_unlink_cleanup(struct vhci_device *vdev)
+{
+	/* give back URB of unsent unlink request */
+	vhci_cleanup_unlink_list(vdev, &vdev->unlink_tx);
+
+	/* give back URB of unanswered unlink request */
+	vhci_cleanup_unlink_list(vdev, &vdev->unlink_rx);
+}
+
 /*
  * The important thing is that only one context begins cleanup.
  * This is why error handling and cleanup become simple.
-- 
2.26.2

