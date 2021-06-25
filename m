Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67ED63B3B17
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 05:15:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbhFYDR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 23:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbhFYDRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 23:17:25 -0400
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D383C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 20:15:05 -0700 (PDT)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 72770806B6;
        Fri, 25 Jun 2021 15:15:00 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1624590900;
        bh=ktThmXty8YAzG1eQJh2MVeDGxBBLur6M3Jhb6X4oIMk=;
        h=From:To:Cc:Subject:Date;
        b=FngkMnEECzBa+M0Bju4CTW6nUeF/55ak+jZhoZb8MquKsjJgPYfyPvMegNdyNjPuU
         6Lb43jIIdqbx5w3SWFS1u5F1fsNDW5oYwpkki+u6KOOL9ceiC50KlXNCkhT+R0c7p9
         OCV1PHy4PF7UL7VIRua1twThxzlZnSuih4zXGKPSpuE84+KfKISO+S8r/4p6Xf5yXK
         ODJzBkSeKWXCSX0w2zmuvDR0ABZQ0o7KAdDQ3fkpZrmpkgc7yg2BsvlcGY0Mzvy6se
         nimg0D72OZ/ZpWMGvH8qc+1dTvlR89uHU0AstrptiGAVSQnO1I3FgraCy6XYDjTlDA
         uJfBfxE8oqS1w==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B60d54a340000>; Fri, 25 Jun 2021 15:15:00 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.25])
        by pat.atlnz.lc (Postfix) with ESMTP id 550BA13EE13;
        Fri, 25 Jun 2021 15:15:00 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
        id 506A5340CEC; Fri, 25 Jun 2021 15:15:00 +1200 (NZST)
From:   Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To:     gregkh@linuxfoundation.org, yangyingliang@huawei.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH] usb: max-3421: Prevent corruption of freed memory
Date:   Fri, 25 Jun 2021 15:14:56 +1200
Message-Id: <20210625031456.8632-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.3 cv=IOh89TnG c=1 sm=1 tr=0 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=r6YtysWOX24A:10 a=Ih58b2DSK4Og19acf1kA:9 a=tZlN334bbdxLhB9B:21 a=29jYiaooX7ZjB_0x:21
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MAX-3421 USB driver remembers the state of the USB toggles for a
device/endpoint. To save SPI writes, this was only done when a new
device/endpoint was being used. Unfortunately, if the old device was
removed, this would cause writes to freed memory.

To fix this, a simpler scheme is used. The toggles are read from
hardware when a URB is completed, and the toggles are always written to
hardware when any URB transaction is started. This will cause a few more
SPI transactions, but no causes kernel panics.

Fixes: 2d53139f3162 ("Add support for using a MAX3421E chip as a host dri=
ver.")
Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 drivers/usb/host/max3421-hcd.c | 44 +++++++++++-----------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/drivers/usb/host/max3421-hcd.c b/drivers/usb/host/max3421-hc=
d.c
index afd9174d83b1..abceca1c9c0f 100644
--- a/drivers/usb/host/max3421-hcd.c
+++ b/drivers/usb/host/max3421-hcd.c
@@ -153,8 +153,6 @@ struct max3421_hcd {
 	 */
 	struct urb *curr_urb;
 	enum scheduling_pass sched_pass;
-	struct usb_device *loaded_dev;	/* dev that's loaded into the chip */
-	int loaded_epnum;		/* epnum whose toggles are loaded */
 	int urb_done;			/* > 0 -> no errors, < 0: errno */
 	size_t curr_len;
 	u8 hien;
@@ -492,39 +490,17 @@ max3421_set_speed(struct usb_hcd *hcd, struct usb_d=
evice *dev)
  * Caller must NOT hold HCD spinlock.
  */
 static void
-max3421_set_address(struct usb_hcd *hcd, struct usb_device *dev, int epn=
um,
-		    int force_toggles)
+max3421_set_address(struct usb_hcd *hcd, struct usb_device *dev, int epn=
um)
 {
-	struct max3421_hcd *max3421_hcd =3D hcd_to_max3421(hcd);
-	int old_epnum, same_ep, rcvtog, sndtog;
-	struct usb_device *old_dev;
+	int rcvtog, sndtog;
 	u8 hctl;
=20
-	old_dev =3D max3421_hcd->loaded_dev;
-	old_epnum =3D max3421_hcd->loaded_epnum;
-
-	same_ep =3D (dev =3D=3D old_dev && epnum =3D=3D old_epnum);
-	if (same_ep && !force_toggles)
-		return;
-
-	if (old_dev && !same_ep) {
-		/* save the old end-points toggles: */
-		u8 hrsl =3D spi_rd8(hcd, MAX3421_REG_HRSL);
-
-		rcvtog =3D (hrsl >> MAX3421_HRSL_RCVTOGRD_BIT) & 1;
-		sndtog =3D (hrsl >> MAX3421_HRSL_SNDTOGRD_BIT) & 1;
-
-		/* no locking: HCD (i.e., we) own toggles, don't we? */
-		usb_settoggle(old_dev, old_epnum, 0, rcvtog);
-		usb_settoggle(old_dev, old_epnum, 1, sndtog);
-	}
 	/* setup new endpoint's toggle bits: */
 	rcvtog =3D usb_gettoggle(dev, epnum, 0);
 	sndtog =3D usb_gettoggle(dev, epnum, 1);
 	hctl =3D (BIT(rcvtog + MAX3421_HCTL_RCVTOG0_BIT) |
 		BIT(sndtog + MAX3421_HCTL_SNDTOG0_BIT));
=20
-	max3421_hcd->loaded_epnum =3D epnum;
 	spi_wr8(hcd, MAX3421_REG_HCTL, hctl);
=20
 	/*
@@ -532,7 +508,6 @@ max3421_set_address(struct usb_hcd *hcd, struct usb_d=
evice *dev, int epnum,
 	 * address-assignment so it's best to just always load the
 	 * address whenever the end-point changed/was forced.
 	 */
-	max3421_hcd->loaded_dev =3D dev;
 	spi_wr8(hcd, MAX3421_REG_PERADDR, dev->devnum);
 }
=20
@@ -667,7 +642,7 @@ max3421_select_and_start_urb(struct usb_hcd *hcd)
 	struct max3421_hcd *max3421_hcd =3D hcd_to_max3421(hcd);
 	struct urb *urb, *curr_urb =3D NULL;
 	struct max3421_ep *max3421_ep;
-	int epnum, force_toggles =3D 0;
+	int epnum;
 	struct usb_host_endpoint *ep;
 	struct list_head *pos;
 	unsigned long flags;
@@ -777,7 +752,6 @@ max3421_select_and_start_urb(struct usb_hcd *hcd)
 			usb_settoggle(urb->dev, epnum, 0, 1);
 			usb_settoggle(urb->dev, epnum, 1, 1);
 			max3421_ep->pkt_state =3D PKT_STATE_SETUP;
-			force_toggles =3D 1;
 		} else
 			max3421_ep->pkt_state =3D PKT_STATE_TRANSFER;
 	}
@@ -785,7 +759,7 @@ max3421_select_and_start_urb(struct usb_hcd *hcd)
 	spin_unlock_irqrestore(&max3421_hcd->lock, flags);
=20
 	max3421_ep->last_active =3D max3421_hcd->frame_number;
-	max3421_set_address(hcd, urb->dev, epnum, force_toggles);
+	max3421_set_address(hcd, urb->dev, epnum);
 	max3421_set_speed(hcd, urb->dev);
 	max3421_next_transfer(hcd, 0);
 	return 1;
@@ -1380,6 +1354,16 @@ max3421_urb_done(struct usb_hcd *hcd)
 		status =3D 0;
 	urb =3D max3421_hcd->curr_urb;
 	if (urb) {
+		/* save the old end-points toggles: */
+		u8 hrsl =3D spi_rd8(hcd, MAX3421_REG_HRSL);
+		int rcvtog =3D (hrsl >> MAX3421_HRSL_RCVTOGRD_BIT) & 1;
+		int sndtog =3D (hrsl >> MAX3421_HRSL_SNDTOGRD_BIT) & 1;
+		int epnum =3D usb_endpoint_num(&urb->ep->desc);
+
+		/* no locking: HCD (i.e., we) own toggles, don't we? */
+		usb_settoggle(urb->dev, epnum, 0, rcvtog);
+		usb_settoggle(urb->dev, epnum, 1, sndtog);
+
 		max3421_hcd->curr_urb =3D NULL;
 		spin_lock_irqsave(&max3421_hcd->lock, flags);
 		usb_hcd_unlink_urb_from_ep(hcd, urb);
--=20
2.32.0

