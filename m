Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 023843CF8A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 13:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237761AbhGTKaX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 06:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236530AbhGTKaK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 06:30:10 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00916C061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 04:10:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id gb6so33711908ejc.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 04:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=DbQL2V/qxGBuOMm7gRfy63d65S6HYcp6rkNS92Cwz2U=;
        b=ViWJZJlK3Cgq75iKHCkTV9klgIlk2YqLMHMJHIsY7iRQrdD/niNVNY7h6uiAZoWNEs
         dgB5Z9QFfW3w5EbQFv+qnocw6Se77SlGQ/6WOR8XpVRIqSHnEjszP0DYZjVdStdAE97p
         DElUaifds91qCuE4wSj0ku07MhsgLrsrO47/M2lqUHdY+QK1aKhRTjfYeBZFZLw/PvMG
         GjLoLU7CWl9ceyCx/x0oqL7wGl3Akyzm/SQsERzINtOnNdw4dMs0cXOmtIzaFUOxEyJ9
         j5bipLMq3BVhjaMdUv8+t/ejrDNE6XTdvTTBAFdZmbPBVFdatnc1T+VGFkeDO2Vo5vt4
         VrJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=DbQL2V/qxGBuOMm7gRfy63d65S6HYcp6rkNS92Cwz2U=;
        b=EKk9w3qHNynvuTbLj78vUGr7hbNsD8hTnHe3wwJy0tkpbzqL7sxGdLm+zU3L25Zscq
         noywy3vheS01luFWMrQW5Li2zjLiXU/7sHleoQfYlCLnj71hAYZLIHraCydhNL8EoYSe
         1xbcrl/MffP/3oigXRESYC/j6TVSTpnO66iU8NUWbo+2UgO+/ogdPFT7vwKe3EStglwb
         LRy2XfaQFj1hcg1aabiZtQwCjr3DFoONUscj7MVd6obRtDfBcItVpZWfdFxU9QE7jzld
         1yLlNQQ4il3EtyVNnmZg3YUZy68ONcPAg2UdelbuYt0p32NJeBTpmQWLaHRub4bDKYyD
         fTjw==
X-Gm-Message-State: AOAM5303x2uTqpu77vKy0PAyDHbgvDRMcJFhBX2HIRkIbKhv6z0mh09t
        BYHY4LqNSz7j+Z9D7YVBydI=
X-Google-Smtp-Source: ABdhPJzj7Hq2FFyx0ImvYxgA4teHimZ2/yhaqqPUp2deRqGxC6e2sLgifVTxyoC+ZMRhdjL8M+6hVA==
X-Received: by 2002:a17:907:11d0:: with SMTP id va16mr33186026ejb.87.1626779446406;
        Tue, 20 Jul 2021 04:10:46 -0700 (PDT)
Received: from localhost.localdomain ([5.176.2.85])
        by smtp.gmail.com with ESMTPSA id s20sm3790709eji.116.2021.07.20.04.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 04:10:46 -0700 (PDT)
Date:   Tue, 20 Jul 2021 14:10:39 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     syzbot <syzbot+cc699626e48a6ebaf295@syzkaller.appspotmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, hridayhegde1999@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        rkovhaev@gmail.com, straube.linux@gmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in do_wait_for_common
Message-ID: <20210720141039.3d4ddcfe@gmail.com>
In-Reply-To: <0000000000008678f205c77a1b93@google.com>
References: <0000000000008678f205c77a1b93@google.com>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/tHQva+=wLE02vuD.qIVo_S2"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/tHQva+=wLE02vuD.qIVo_S2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 19 Jul 2021 06:42:25 -0700
syzbot <syzbot+cc699626e48a6ebaf295@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    8096acd7442e Merge tag 'net-5.14-rc2' of
> git://git.kernel... git tree:       upstream
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=167ca94a300000 kernel
> config:  https://syzkaller.appspot.com/x/.config?x=5294764a378649cb
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=cc699626e48a6ebaf295
> compiler:       Debian clang version 11.0.1-2 syz repro:
> https://syzkaller.appspot.com/x/repro.syz?x=14d68024300000 C
> reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e4f180300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit: Reported-by:
> syzbot+cc699626e48a6ebaf295@syzkaller.appspotmail.com
> 
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in debug_spin_lock_before
> kernel/locking/spinlock_debug.c:83 [inline] BUG: KASAN:
> slab-out-of-bounds in do_raw_spin_lock+0x4f5/0x8e0
> kernel/locking/spinlock_debug.c:112 Read of size 4 at addr
> ffff88802b46ce14 by task kworker/0:6/8471
> 

I don't see any reason behind doing clean up stuff in firmware
callback. In my prevoius patch to this driver I fixed memory leak and, I
believed, that this approach won't trigger anything else... 

Let's just call device_release_driver() under parent lock in case of
firmware load failure and see if it works.

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


With regards,
Pavel Skripkin

--MP_/tHQva+=wLE02vuD.qIVo_S2
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-staging-rtl8712-rewrite-error-handling.patch

From 754dff1a4e90cf0b41ab4dc3a06226738385476f Mon Sep 17 00:00:00 2001
From: Pavel Skripkin <paskripkin@gmail.com>
Date: Tue, 20 Jul 2021 14:05:02 +0300
Subject: [PATCH] staging: rtl8712: rewrite error handling

/* .... */

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/rtl8712/hal_init.c | 30 ++++++++++++------
 drivers/staging/rtl8712/usb_intf.c | 50 +++++++++++++-----------------
 2 files changed, 42 insertions(+), 38 deletions(-)

diff --git a/drivers/staging/rtl8712/hal_init.c b/drivers/staging/rtl8712/hal_init.c
index 22974277afa0..4eff3fdecdb8 100644
--- a/drivers/staging/rtl8712/hal_init.c
+++ b/drivers/staging/rtl8712/hal_init.c
@@ -29,21 +29,31 @@
 #define FWBUFF_ALIGN_SZ 512
 #define MAX_DUMP_FWSZ (48 * 1024)
 
+static void rtl871x_load_fw_fail(struct _adapter *adapter)
+{
+	struct usb_device *udev = adapter->dvobjpriv.pusbdev;
+	struct device *dev = &udev->dev;
+	struct device *parent = dev->parent;
+
+	complete(&adapter->rtl8712_fw_ready);
+
+	dev_err(&udev->dev, "r8712u: Firmware request failed\n");
+
+	if (parent)
+		device_lock(parent);
+
+	device_release_driver(dev);
+
+	if (parent)
+		device_unlock(parent);
+}
+
 static void rtl871x_load_fw_cb(const struct firmware *firmware, void *context)
 {
 	struct _adapter *adapter = context;
 
 	if (!firmware) {
-		struct usb_device *udev = adapter->dvobjpriv.pusbdev;
-		struct usb_interface *usb_intf = adapter->pusb_intf;
-
-		dev_err(&udev->dev, "r8712u: Firmware request failed\n");
-		usb_put_dev(udev);
-		usb_set_intfdata(usb_intf, NULL);
-		r8712_free_drv_sw(adapter);
-		adapter->dvobj_deinit(adapter);
-		complete(&adapter->rtl8712_fw_ready);
-		free_netdev(adapter->pnetdev);
+		rtl871x_load_fw_fail(adapter);
 		return;
 	}
 	adapter->fw = firmware;
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 2434b13c8b12..6440febfd08d 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -591,35 +591,29 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
 {
 	struct net_device *pnetdev = usb_get_intfdata(pusb_intf);
 	struct usb_device *udev = interface_to_usbdev(pusb_intf);
+	struct _adapter *padapter = netdev_priv(pnetdev);
+
+	/* never exit with a firmware callback pending */
+	wait_for_completion(&padapter->rtl8712_fw_ready);
+	usb_set_intfdata(pusb_intf, NULL);
+	release_firmware(padapter->fw);
+	if (drvpriv.drv_registered)
+		padapter->surprise_removed = true;
+	if (pnetdev->reg_state != NETREG_UNINITIALIZED)
+		unregister_netdev(pnetdev); /* will call netdev_close() */
+	flush_scheduled_work();
+	udelay(1);
+	/* Stop driver mlme relation timer */
+	r8712_stop_drv_timers(padapter);
+	r871x_dev_unload(padapter);
+	r8712_free_drv_sw(padapter);
+	free_netdev(pnetdev);
+
+	/* decrease the reference count of the usb device structure
+	 * when disconnect
+	 */
+	usb_put_dev(udev);
 
-	if (pnetdev) {
-		struct _adapter *padapter = netdev_priv(pnetdev);
-
-		/* never exit with a firmware callback pending */
-		wait_for_completion(&padapter->rtl8712_fw_ready);
-		pnetdev = usb_get_intfdata(pusb_intf);
-		usb_set_intfdata(pusb_intf, NULL);
-		if (!pnetdev)
-			goto firmware_load_fail;
-		release_firmware(padapter->fw);
-		if (drvpriv.drv_registered)
-			padapter->surprise_removed = true;
-		if (pnetdev->reg_state != NETREG_UNINITIALIZED)
-			unregister_netdev(pnetdev); /* will call netdev_close() */
-		flush_scheduled_work();
-		udelay(1);
-		/* Stop driver mlme relation timer */
-		r8712_stop_drv_timers(padapter);
-		r871x_dev_unload(padapter);
-		r8712_free_drv_sw(padapter);
-		free_netdev(pnetdev);
-
-		/* decrease the reference count of the usb device structure
-		 * when disconnect
-		 */
-		usb_put_dev(udev);
-	}
-firmware_load_fail:
 	/* If we didn't unplug usb dongle and remove/insert module, driver
 	 * fails on sitesurvey for the first time when device is up.
 	 * Reset usb port for sitesurvey fail issue.
-- 
2.32.0


--MP_/tHQva+=wLE02vuD.qIVo_S2--
