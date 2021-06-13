Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99CC13A5ABE
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 00:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232187AbhFMWDd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 18:03:33 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:35359 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232119AbhFMWDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 18:03:32 -0400
Received: by mail-lj1-f177.google.com with SMTP id n17so17441108ljg.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJgviWmzWfor8SMzjMEV7S/Xf7moSv9Xz3WoTzx0rUs=;
        b=c3OT5EbehKbUkpqQh1MFMpCIedzjYibGIQqIjbNFoE9JNYo4e1SpmH5vPp02V3EhKo
         btTXeiE1YC16QYyUMlNU4uYRAsUgnFL1z3/kbq75Ebh5jyqMhG7Fl/jkoNtvWvkp1VKY
         bpHE8gP7auJZyAMiSDG5wSWUiu3l3JP+LsYR3jbMD3U4pUAmj4UbRLTexIX9IxnRsff8
         y4cgV6USipE6AdmWqg2GEQ7VxvcXmMNxZ1SeNQXhCSNSUDaH3hfldkpt6Ny7bkGrQdTl
         g1Jx2oxpoJNMQTu5uyQz2gOpPZ/vkHqNdD6wBnc29PGELu7J1xqSgAuWF5ycclnv3uNl
         rA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJgviWmzWfor8SMzjMEV7S/Xf7moSv9Xz3WoTzx0rUs=;
        b=ZqW5/xFtzjWKlZGMNZINfeiP+e+8iIcSrugpVFu+1bQRz3lZn3KRpmZPMM9vuB/MWY
         ooGBpx2Q2quOhF5Fw9sCCb+Awn5H1c8pRI3RWB0IhMUKHQSY9UhCh18NpXPNeEIdx4QN
         vuBBF3NZKtN3125vLHS3uFsLyc4y6OgUo3lnmb8w43OwIdSpyiSZQALAvT9FLSXu9LZY
         w9D4V1AMwZG8cQ63lN/lehhtVtAzmwrAhqNHusu3rVOQkWvG468YHYKwTBoN+LUyS0Do
         JqisWKOS3sBn01gTG4jZBsvh/1XyxtamtohOu0sQKP4PEht6YDEWr8T48xQu/Y++1GNI
         hMbw==
X-Gm-Message-State: AOAM531rwHWRqVlSEw429Z6LbmFnGlmMyT7rW+gEArcN+7RBZm8+NaDi
        /JK/5BHwGtcmPIxhedHu7FU=
X-Google-Smtp-Source: ABdhPJy0pPevgx09PW6J7p6pHNDmZpXH61+Hkex7gD7XTRFPXxPPvf+YjpestZwt9jfcstqsIF0gVg==
X-Received: by 2002:a2e:9a0d:: with SMTP id o13mr11277155lji.440.1623621616011;
        Sun, 13 Jun 2021 15:00:16 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.24])
        by smtp.gmail.com with ESMTPSA id y13sm195081lfg.247.2021.06.13.15.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 15:00:15 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH 2/3] staging: rtl8712: fix error handling in r871xu_drv_init
Date:   Mon, 14 Jun 2021 01:00:13 +0300
Message-Id: <febb00f72354449bb4d305f373d6d2f47e539ab4.1623620630.git.paskripkin@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1623620630.git.paskripkin@gmail.com>
References: <cover.1623620630.git.paskripkin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Previous error handling path was unique for all
possible errors and there was unnecessary branching.
Also, one step for freeing drv_sw was missing. All
these problems was fixed by restructuring error
handling path.

Also, moved out free_netdev() from r8712_free_drv_sw() for
correct error handling.

Fixes: 2865d42c78a9 ("staging: r8712u: Add the new driver to the mainline kernel")
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/rtl8712/os_intfs.c |  4 ----
 drivers/staging/rtl8712/usb_intf.c | 22 +++++++++++++---------
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/staging/rtl8712/os_intfs.c b/drivers/staging/rtl8712/os_intfs.c
index 0c3ae8495afb..2214aca09730 100644
--- a/drivers/staging/rtl8712/os_intfs.c
+++ b/drivers/staging/rtl8712/os_intfs.c
@@ -328,8 +328,6 @@ int r8712_init_drv_sw(struct _adapter *padapter)
 
 void r8712_free_drv_sw(struct _adapter *padapter)
 {
-	struct net_device *pnetdev = padapter->pnetdev;
-
 	r8712_free_cmd_priv(&padapter->cmdpriv);
 	r8712_free_evt_priv(&padapter->evtpriv);
 	r8712_DeInitSwLeds(padapter);
@@ -339,8 +337,6 @@ void r8712_free_drv_sw(struct _adapter *padapter)
 	_r8712_free_sta_priv(&padapter->stapriv);
 	_r8712_free_recv_priv(&padapter->recvpriv);
 	mp871xdeinit(padapter);
-	if (pnetdev)
-		free_netdev(pnetdev);
 }
 
 static void enable_video_mode(struct _adapter *padapter, int cbw40_value)
diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index c482a6d1998b..f97830049fc8 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -361,7 +361,7 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 	/* step 1. */
 	pnetdev = r8712_init_netdev();
 	if (!pnetdev)
-		goto error;
+		goto put_dev;
 	padapter = netdev_priv(pnetdev);
 	disable_ht_for_spec_devid(pdid, padapter);
 	pdvobjpriv = &padapter->dvobjpriv;
@@ -383,12 +383,12 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 
 	status = padapter->dvobj_init(padapter);
 	if (status != _SUCCESS)
-		goto error;
+		goto free_netdev;
 
 	/* step 4. */
 	status = r8712_init_drv_sw(padapter);
 	if (status)
-		goto error;
+		goto dvobj_deinit;
 	/* step 5. read efuse/eeprom data and get mac_addr */
 	{
 		int i, offset;
@@ -568,17 +568,20 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 	}
 	/* step 6. Load the firmware asynchronously */
 	if (rtl871x_load_fw(padapter))
-		goto error;
+		goto deinit_drv_sw;
 	spin_lock_init(&padapter->lock_rx_ff0_filter);
 	mutex_init(&padapter->mutex_start);
 	return 0;
-error:
+
+deinit_drv_sw:
+	r8712_free_drv_sw(padapter);
+dvobj_deinit:
+	padapter->dvobj_deinit(padapter);
+free_netdev:
+	free_netdev(pnetdev);
+put_dev:
 	usb_put_dev(udev);
 	usb_set_intfdata(pusb_intf, NULL);
-	if (padapter && padapter->dvobj_deinit)
-		padapter->dvobj_deinit(padapter);
-	if (pnetdev)
-		free_netdev(pnetdev);
 	return -ENODEV;
 }
 
@@ -610,6 +613,7 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
 		r8712_stop_drv_timers(padapter);
 		r871x_dev_unload(padapter);
 		r8712_free_drv_sw(padapter);
+		free_netdev(pnetdev);
 
 		/* decrease the reference count of the usb device structure
 		 * when disconnect
-- 
2.32.0

