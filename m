Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7763D0C4B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jul 2021 12:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236198AbhGUJa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jul 2021 05:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237365AbhGUJVP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jul 2021 05:21:15 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82218C0613DB
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:01:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id qa36so2344846ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jul 2021 03:01:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version;
        bh=86ljqv5t4ZJg9qP2L4KJ/buTsBjbtoSiB6SYR0p8Wt4=;
        b=vc5HgWHtRmbjMtSrwYzBoz6kFDSKs0ESNzJYwgF9BsAYjwlVYsK+eBkcriczpwrI44
         z/5teBy5u0M6Mpg4wtZHMA5dQke+NIXceWUleItFFw0ALJniJ+T0uh+fWvVOBUvYR1xk
         Pr9LvWLUfgJINVI3gJO2K2XoPpZ0Dmonbipd2iFLraNWpgOz5ph/ng3nCBB8pxmVzR8E
         Y6wHX+i5ZqMbCTc/1FdVf1diS1p01lSjuRERFA4LozSeBXyxT8qu4a3oxKyaG28Yw2NT
         olyCvMUDd7sQyya9uGUNLgN4HlX+j9y71A1vXVZemruOZ0RfQVge6ynok2EYfxARor39
         iBhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version;
        bh=86ljqv5t4ZJg9qP2L4KJ/buTsBjbtoSiB6SYR0p8Wt4=;
        b=TRhra5Tf+5ysIX0FnjXQRQHfOCXM/HhXHJjnynhSWY8kIIUJgWoDnhIe2iG1OjoXp9
         E4RkicZ0fMP6i6b2I+WZFLD2vUp3MBoHxun+xoV1B4eKZjws69dkap1AlKn/p1U35cou
         h5StYckKTooxfzR14LwLkJSIIL0UZsaBnq8UcuklUDTNsFkRcqIuQssgHDbVRbnOId4+
         8bDT2OiVndnM8Rq3dc1EH+v9eHTIAkdl8bLflcKnu/PaN2RCn1pAy8dxluzQ7BpqCmoA
         atSkvi95iaxZmcu98JTemzuUJWAnZcFMNwalbR2JKW98XOiBSClU8TTJFNuUIlRWCoKv
         gsSA==
X-Gm-Message-State: AOAM530KAbruGMGiiH9txoG1RVq4hRbd5Is2UEVrtc7FYZ0cRsqMgv9Z
        5x0JzKltNkrKHXG7ffrkoDg=
X-Google-Smtp-Source: ABdhPJyA5qUQWcyYupKyJBgjDnhX+fO/kYCtUTXULhtJpsjzjwb88jQ8601JzdSlL/R6C6/P4YwZxg==
X-Received: by 2002:a17:906:b796:: with SMTP id dt22mr37981136ejb.448.1626861709075;
        Wed, 21 Jul 2021 03:01:49 -0700 (PDT)
Received: from localhost.localdomain ([176.30.109.247])
        by smtp.gmail.com with ESMTPSA id g23sm3017357ejm.26.2021.07.21.03.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jul 2021 03:01:48 -0700 (PDT)
Date:   Wed, 21 Jul 2021 13:01:43 +0300
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     syzbot <syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com>
Cc:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, hridayhegde1999@gmail.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        rkovhaev@gmail.com, straube.linux@gmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] KASAN: use-after-free Read in r871xu_dev_remove
Message-ID: <20210721130143.396c1626@gmail.com>
In-Reply-To: <00000000000087b4c305c6f8a243@google.com>
References: <00000000000087b4c305c6f8a243@google.com>
X-Mailer: Claws Mail 3.17.8git77 (GTK+ 2.24.33; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/m98DrfmMSDLi1ZKFccsq02G"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--MP_/m98DrfmMSDLi1ZKFccsq02G
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Mon, 12 Jul 2021 20:14:24 -0700
syzbot <syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com> wrote:

> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    92510a7f Add linux-next specific files for 20210709
> git tree:       linux-next
> console output:
> https://syzkaller.appspot.com/x/log.txt?x=16c50180300000 kernel
> config:  https://syzkaller.appspot.com/x/.config?x=505de2716f052686
> dashboard link:
> https://syzkaller.appspot.com/bug?extid=5872a520e0ce0a7c7230 syz
> repro:
> https://syzkaller.appspot.com/x/repro.syz?x=1639a73c300000 C
> reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15fcd5e4300000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the
> commit: Reported-by:
> syzbot+5872a520e0ce0a7c7230@syzkaller.appspotmail.com
> 
> usb 1-1: USB disconnect, device number 14
> ==================================================================
> BUG: KASAN: use-after-free in __lock_acquire+0x3d86/0x54a0
> kernel/locking/lockdep.c:4885 Read of size 8 at addr ffff888038bbce28
> by task kworker/1:2/4393
> 

And let's test it with this repro as well.


#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


With regards,
Pavel Skripkin

--MP_/m98DrfmMSDLi1ZKFccsq02G
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

--MP_/m98DrfmMSDLi1ZKFccsq02G--
