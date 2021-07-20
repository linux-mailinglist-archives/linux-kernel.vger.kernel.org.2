Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73B83D0211
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 21:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhGTSeY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 14:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhGTSeR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 14:34:17 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C402EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 12:14:53 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id qb4so35882820ejc.11
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 12:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=Bc9gy94qC9rscZGR5m8mbB7/n1Nej4pUFVOuf9gSdY8=;
        b=klAL4pxG7P3cgzkoz/cUqjRD6gOCQTnKUD1U7jOhQa+DS5P70ZTc8dTO5g5cAHifEr
         3nHDNMl9LR7GI5AE6hRy2TuC5QMeHf4bX0V0Hhd8DhpfK7vz07HvsX8DypmsbHGryI4y
         77WEUQm0ew9yzjGNI2PYB5vp8dDt2nDUSn/hw8Rl/Kg+cZt5X2q9wHnjhnFAmdlx3itl
         9G8RaoH3JN+AGyUWUwm/5ZfSq8v7jh1evjE7Agwj8K6sz1xcmjMNipOzY7SVj+pWlSuZ
         kqNwT2nP62omHHbVeG8XmR9EkrLv0+FG7JjuMO+ca5/IcI9N5uRtBsYOLofkSlCkCxVf
         sRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=Bc9gy94qC9rscZGR5m8mbB7/n1Nej4pUFVOuf9gSdY8=;
        b=XEsqutaJZcOUhX/c9NKLuH2YoczT4b8qXpLJbOeD0zso1kWx6+KfU9hfovv4hhMA5v
         h5hi0RC0kGsTA6j8yAYWJZnsBS/Lt442CEXBRHORutHfK4G0NtZmhPFQu43D6xeHdxks
         TWKqoK+voK17Ui3M76gbq3jkAZcf4yhT1a/W5GUO4OG542WGtmg+BoZFapPGnUDh5PvE
         4kUCJ/NkwkKZJb1STEGQjreDEtqnqvm7xHUeryooiohlRXP80FrQnsoD4xbbu5+nnXvP
         IrArJYDH/zKh8l+IGBXGBTdBkzmT1RsWK6Huk+O8aHx+74oGtCt0a5xS71+fg6Qy7YLa
         PrTQ==
X-Gm-Message-State: AOAM5304eGozPZtBX4VWSXz1XPpSSRvDt9mS4QaOQ4Y9Kejm/+HPdz2v
        LuHXP31Mm841CaKDGCW+68I=
X-Google-Smtp-Source: ABdhPJyX5p3pEYof2nuWx/FrWMt00l9Is1g45OqM/Yz268CEUTnKNnHRVRnLdyLJ9JXugFNFxf9PXA==
X-Received: by 2002:a17:906:a94:: with SMTP id y20mr34758977ejf.399.1626808492110;
        Tue, 20 Jul 2021 12:14:52 -0700 (PDT)
Received: from localhost.localdomain ([5.176.2.85])
        by smtp.gmail.com with ESMTPSA id o23sm7487524ejc.124.2021.07.20.12.14.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 12:14:51 -0700 (PDT)
Date:   Tue, 20 Jul 2021 22:14:45 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     syzbot <syzbot+cc699626e48a6ebaf295@syzkaller.appspotmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, hridayhegde1999@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        rkovhaev@gmail.com, straube.linux@gmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in do_wait_for_common
Message-ID: <20210720221445.7d022a9e@gmail.com>
In-Reply-To: <00000000000047c76a05c78f9ab1@google.com>
References: <20210720141039.3d4ddcfe@gmail.com>
        <00000000000047c76a05c78f9ab1@google.com>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/GYVYLLw7LHQibNxOyWG2q9k"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/GYVYLLw7LHQibNxOyWG2q9k
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 20 Jul 2021 08:21:06 -0700
syzbot <syzbot+cc699626e48a6ebaf295@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still
> triggering an issue: possible deadlock in flush_workqueue
> 
> usb 6-1: r8712u: Loading firmware from "rtlwifi/rtl8712u.bin"
> usb 6-1: Direct firmware load for rtlwifi/rtl8712u.bin failed with
> error -2 usb 6-1: Falling back to sysfs fallback for:
> rtlwifi/rtl8712u.bin usb 6-1: r8712u: Firmware request failed
> ============================================
> WARNING: possible recursive locking detected
> 5.14.0-rc2-syzkaller #0 Not tainted
> --------------------------------------------
> kworker/0:3/3159 is trying to acquire lock:
> ffff888011064d38 ((wq_completion)events){+.+.}-{0:0}, at:
> flush_workqueue+0x15c/0x1750 kernel/workqueue.c:2787
> 
> but task is already holding lock:
> ffff888011064d38 ((wq_completion)events){+.+.}-{0:0}, at:
> process_one_work+0x7aa/0x10c0 kernel/workqueue.c:2249
> 
> other info that might help us debug this:
>  Possible unsafe locking scenario:
> 
>        CPU0
>        ----
>   lock((wq_completion)events);
>   lock((wq_completion)events);
> 
>  *** DEADLOCK ***
> 
>  May be due to missing lock nesting notation
> 
> 5 locks held by kworker/0:3/3159:
>  #0: ffff888011064d38 ((wq_completion)events){+.+.}-{0:0}, at:
> process_one_work+0x7aa/0x10c0 kernel/workqueue.c:2249 #1:
> ffffc900021d7d20 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at:
> process_one_work+0x7e8/0x10c0 kernel/workqueue.c:2251 #2:
> ffff8881467d4220 (&dev->mutex){....}-{3:3}, at: device_lock
> include/linux/device.h:754 [inline] #2: ffff8881467d4220
> (&dev->mutex){....}-{3:3}, at: rtl871x_load_fw_fail
> drivers/staging/rtl8712/hal_init.c:43 [inline] #2: ffff8881467d4220
> (&dev->mutex){....}-{3:3}, at: rtl871x_load_fw_cb+0x102/0x130
> drivers/staging/rtl8712/hal_init.c:56 #3: ffff8880363da220
> (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:754
> [inline] #3: ffff8880363da220 (&dev->mutex){....}-{3:3}, at:
> __device_driver_lock drivers/base/dd.c:1028 [inline] #3:
> ffff8880363da220 (&dev->mutex){....}-{3:3}, at:
> device_release_driver_internal+0xc1/0x7b0 drivers/base/dd.c:1229 #4:
> ffff8880308211a8 (&dev->mutex){....}-{3:3}, at: device_lock
> include/linux/device.h:754 [inline] #4: ffff8880308211a8
> (&dev->mutex){....}-{3:3}, at: __device_driver_lock
> drivers/base/dd.c:1028 [inline] #4: ffff8880308211a8
> (&dev->mutex){....}-{3:3}, at:
> device_release_driver_internal+0xc1/0x7b0 drivers/base/dd.c:1229
> 
> stack backtrace:
> CPU: 0 PID: 3159 Comm: kworker/0:3 Not tainted 5.14.0-rc2-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine,
> BIOS Google 01/01/2011 Workqueue: events request_firmware_work_func
> Call Trace:
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1ae/0x29f lib/dump_stack.c:105
>  __lock_acquire+0x2615/0x6100 kernel/locking/lockdep.c:4853
>  lock_acquire+0x182/0x4a0 kernel/locking/lockdep.c:5625
>  flush_workqueue+0x178/0x1750 kernel/workqueue.c:2787
>  flush_scheduled_work include/linux/workqueue.h:597 [inline]
>  r871xu_dev_remove+0x159/0x420 drivers/staging/rtl8712/usb_intf.c:604
>  usb_unbind_interface+0x1f2/0x860 drivers/usb/core/driver.c:458
>  __device_release_driver drivers/base/dd.c:1201 [inline]
>  device_release_driver_internal+0x51e/0x7b0 drivers/base/dd.c:1232
>  bus_remove_device+0x2fd/0x410 drivers/base/bus.c:529
>  device_del+0x6e1/0xc10 drivers/base/core.c:3540
>  usb_disable_device+0x407/0x800 drivers/usb/core/message.c:1419
>  usb_set_configuration+0x42b/0x2100 drivers/usb/core/message.c:2027
>  usb_unbind_device+0x6b/0x170 drivers/usb/core/driver.c:309
>  __device_release_driver drivers/base/dd.c:1201 [inline]
>  device_release_driver_internal+0x51e/0x7b0 drivers/base/dd.c:1232
>  rtl871x_load_fw_fail drivers/staging/rtl8712/hal_init.c:45 [inline]
>  rtl871x_load_fw_cb+0x10a/0x130 drivers/staging/rtl8712/hal_init.c:56
>  request_firmware_work_func+0x175/0x250
> drivers/base/firmware_loader/main.c:1081
> process_one_work+0x833/0x10c0 kernel/workqueue.c:2276
> worker_thread+0xac1/0x1320 kernel/workqueue.c:2422
> kthread+0x453/0x480 kernel/kthread.c:319 ret_from_fork+0x1f/0x30
> arch/x86/entry/entry_64.S:295
> 


Hmm, did't notice this could happen. From my point of view,
flush_scheduled_work() can be replaced with flush_work() for all
scheduled works in this driver.



#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master



 
With regards,
Pavel Skripkin

--MP_/GYVYLLw7LHQibNxOyWG2q9k
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename=0001-staging-rtl8712-rewrite-error-handling.patch

From c308b591df7d984b2b17c8cbd578907d152b9930 Mon Sep 17 00:00:00 2001
From: Pavel Skripkin <paskripkin@gmail.com>
Date: Tue, 20 Jul 2021 14:05:02 +0300
Subject: [PATCH] staging: rtl8712: rewrite error handling

/* .... */

Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/rtl8712/hal_init.c        | 30 ++++++++-----
 drivers/staging/rtl8712/rtl8712_led.c     |  8 ++++
 drivers/staging/rtl8712/rtl871x_led.h     |  1 +
 drivers/staging/rtl8712/rtl871x_pwrctrl.c |  8 ++++
 drivers/staging/rtl8712/rtl871x_pwrctrl.h |  1 +
 drivers/staging/rtl8712/usb_intf.c        | 51 ++++++++++-------------
 6 files changed, 61 insertions(+), 38 deletions(-)

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
diff --git a/drivers/staging/rtl8712/rtl8712_led.c b/drivers/staging/rtl8712/rtl8712_led.c
index 5901026949f2..d5fc9026b036 100644
--- a/drivers/staging/rtl8712/rtl8712_led.c
+++ b/drivers/staging/rtl8712/rtl8712_led.c
@@ -1820,3 +1820,11 @@ void LedControl871x(struct _adapter *padapter, enum LED_CTL_MODE LedAction)
 		break;
 	}
 }
+
+void r8712_flush_led_works(struct _adapter *padapter)
+{
+	struct led_priv *pledpriv = &padapter->ledpriv;
+
+	flush_work(&pledpriv->SwLed0.BlinkWorkItem);
+	flush_work(&pledpriv->SwLed1.BlinkWorkItem);
+}
diff --git a/drivers/staging/rtl8712/rtl871x_led.h b/drivers/staging/rtl8712/rtl871x_led.h
index ee19c873cf01..2f0768132ad8 100644
--- a/drivers/staging/rtl8712/rtl871x_led.h
+++ b/drivers/staging/rtl8712/rtl871x_led.h
@@ -112,6 +112,7 @@ struct led_priv {
 void r8712_InitSwLeds(struct _adapter *padapter);
 void r8712_DeInitSwLeds(struct _adapter *padapter);
 void LedControl871x(struct _adapter *padapter, enum LED_CTL_MODE LedAction);
+void r8712_flush_led_works(struct _adapter *padapter);
 
 #endif
 
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.c b/drivers/staging/rtl8712/rtl871x_pwrctrl.c
index 23cff43437e2..cd6d9ff0bebc 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.c
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.c
@@ -224,3 +224,11 @@ void r8712_unregister_cmd_alive(struct _adapter *padapter)
 	}
 	mutex_unlock(&pwrctrl->mutex_lock);
 }
+
+void r8712_flush_rwctrl_works(struct _adapter *padapter)
+{
+	struct pwrctrl_priv *pwrctrl = &padapter->pwrctrlpriv;
+
+	flush_work(&pwrctrl->SetPSModeWorkItem);
+	flush_work(&pwrctrl->rpwm_workitem);
+}
diff --git a/drivers/staging/rtl8712/rtl871x_pwrctrl.h b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
index bf6623cfaf27..b35b9c7920eb 100644
--- a/drivers/staging/rtl8712/rtl871x_pwrctrl.h
+++ b/drivers/staging/rtl8712/rtl871x_pwrctrl.h
@@ -108,5 +108,6 @@ void r8712_cpwm_int_hdl(struct _adapter *padapter,
 void r8712_set_ps_mode(struct _adapter *padapter, uint ps_mode,
 			uint smart_ps);
 void r8712_set_rpwm(struct _adapter *padapter, u8 val8);
+void r8712_flush_rwctrl_works(struct _adapter *padapter);
 
 #endif  /* __RTL871X_PWRCTRL_H_ */
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 2434b13c8b12..505ebeb643dc 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -591,35 +591,30 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
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
+	r8712_flush_rwctrl_works(padapter);
+	r8712_flush_led_works(padapter);
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


--MP_/GYVYLLw7LHQibNxOyWG2q9k--
