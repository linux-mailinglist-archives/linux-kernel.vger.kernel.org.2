Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EF53D0C48
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 12:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237912AbhGUJaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbhGUJQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:16:41 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 391B6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 02:57:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id hr1so2386314ejc.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 02:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=NuNIkqlCWjta6X7v6jKsSLzY0Zy0Zo+62taPcEqLl7Y=;
        b=FNdG8UlYUk87fGjJMjmIJkHHjmV+wBlUPKw02udlD/20pEvKDqCT1Dmoqf4XkA/IOD
         +GS0I98Jmmu33Q4I1dMTkJVxGtvtFw2NFbu7r31N5tqZsmYZkAmynZ+BXFcKdLcTMwE/
         iINv+U4/OMS7At2dxBzmtIMzapI26yNdsXjLrO2tw98+ygerchdK82YQ8YFyT15WPnKf
         YElDlRbbWeGmDdOC/jSJlb0tvSy7Iv89c28Xisr18uJzwAB4rhwTGa7FPfsnh2HaTKyA
         UdNKNmuFTeoFUb8Ns+4y5DdK5Cdr1j8p0CReMqORm6WsZkihuq/yS5c4bQQCm8bT1O2U
         1CTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=NuNIkqlCWjta6X7v6jKsSLzY0Zy0Zo+62taPcEqLl7Y=;
        b=srYhlmbzdg5st84SokGTTNU2dRyLwDa4ttwZ8q1py7ehXtzDCUuPY65Z3N721CoeAW
         7Y+tWhdyrEN21EpLoF/em/YlYSuvHHw+OuWPXTxUnvNNu3BULydmQHrB/jUQ3oUYFmUI
         IB/frGqblSI3bkfLT19Wu2RX0CZKjcjrT06A5Tmeok9koBkVdPEQ6OHbuHyfjdpQ1PZH
         ZCzAJaTYOYIAZCTiYtK18lE5GI9rrKC9s2PpdMAZZWGjhhJkn9RF8EDrQuXqUhU88iLO
         Lact4bgT3WP/Dzr/spbJJnDS2LAWwwZ4x7kX7wEaCrjQr27rMNcJ2y1hubhGlw6Ep847
         bDDw==
X-Gm-Message-State: AOAM530g8vQPnllG8CMw2XRMC5sVN1OiUjJhSH7K8NyY6xV3gRt8FJ9n
        i1CMigjjaX1XRYWUBMIX1/o=
X-Google-Smtp-Source: ABdhPJwyZ36Q+t7teA75/OrxZdqBeMUVgKbEWHOzP0iGcp0jlXUsqouFbUzjyJxhksBDm8ji96eKFA==
X-Received: by 2002:a17:907:a079:: with SMTP id ia25mr9624559ejc.515.1626861436618;
        Wed, 21 Jul 2021 02:57:16 -0700 (PDT)
Received: from localhost.localdomain ([176.30.109.247])
        by smtp.gmail.com with ESMTPSA id n11sm8286283ejg.111.2021.07.21.02.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 02:57:16 -0700 (PDT)
Date:   Wed, 21 Jul 2021 12:57:10 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     syzbot <syzbot+cc699626e48a6ebaf295@syzkaller.appspotmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, hridayhegde1999@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        rkovhaev@gmail.com, straube.linux@gmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: slab-out-of-bounds Read in do_wait_for_common
Message-ID: <20210721125710.1a1c041f@gmail.com>
In-Reply-To: <0000000000001950a705c795515d@google.com>
References: <20210720221445.7d022a9e@gmail.com>
        <0000000000001950a705c795515d@google.com>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/aiVyBEGmZlfOaj=Rqpq3zFn"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/aiVyBEGmZlfOaj=Rqpq3zFn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Tue, 20 Jul 2021 15:10:08 -0700
syzbot <syzbot+cc699626e48a6ebaf295@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still
> triggering an issue: BUG: sleeping function called from invalid
> context in lock_sock_nested
> 
> BUG: sleeping function called from invalid context at
> net/core/sock.c:3161 in_atomic(): 1, irqs_disabled(): 0, non_block:
> 0, pid: 8824, name: syz-executor.2 1 lock held by syz-executor.2/8824:
>  #0: ffffffff8d89c920 (hci_sk_list.lock){++++}-{2:2}, at:
> hci_sock_dev_event+0x2b6/0x630 net/bluetooth/hci_sock.c:763


Ok, it is not related to my fix. Picking up Tetsuo patch to get
Reported-and-tested tag. 


#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


With regards,
Pavel Skripkin

--MP_/aiVyBEGmZlfOaj=Rqpq3zFn
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=2patches.patch

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
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
index b04a5a02ecf3..786a06a232fd 100644
--- a/net/bluetooth/hci_sock.c
+++ b/net/bluetooth/hci_sock.c
@@ -760,10 +760,18 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
 		struct sock *sk;
 
 		/* Detach sockets from device */
+restart:
 		read_lock(&hci_sk_list.lock);
 		sk_for_each(sk, &hci_sk_list.head) {
+			/* This sock_hold(sk) is safe, for bt_sock_unlink(sk)
+			 * is not called yet.
+			 */
+			sock_hold(sk);
+			read_unlock(&hci_sk_list.lock);
 			lock_sock(sk);
-			if (hci_pi(sk)->hdev == hdev) {
+			write_lock(&hci_sk_list.lock);
+			/* Check that bt_sock_unlink(sk) is not called yet. */
+			if (sk_hashed(sk) && hci_pi(sk)->hdev == hdev) {
 				hci_pi(sk)->hdev = NULL;
 				sk->sk_err = EPIPE;
 				sk->sk_state = BT_OPEN;
@@ -771,7 +779,27 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event)
 
 				hci_dev_put(hdev);
 			}
+			write_unlock(&hci_sk_list.lock);
 			release_sock(sk);
+			read_lock(&hci_sk_list.lock);
+			/* If bt_sock_unlink(sk) is not called yet, we can
+			 * continue iteration. We can use __sock_put(sk) here
+			 * because hci_sock_release() will call sock_put(sk)
+			 * after bt_sock_unlink(sk).
+			 */
+			if (sk_hashed(sk)) {
+				__sock_put(sk);
+				continue;
+			}
+			/* Otherwise, we need to restart iteration, for the
+			 * next socket pointed by sk->next might be already
+			 * gone. We can't use __sock_put(sk) here because
+			 * hci_sock_release() might have already called
+			 * sock_put(sk) after bt_sock_unlink(sk).
+			 */
+			read_unlock(&hci_sk_list.lock);
+			sock_put(sk);
+			goto restart;
 		}
 		read_unlock(&hci_sk_list.lock);
 	}

--MP_/aiVyBEGmZlfOaj=Rqpq3zFn--
