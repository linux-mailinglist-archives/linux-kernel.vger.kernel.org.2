Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B019C38C639
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 14:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbhEUMJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 08:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhEUMJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 08:09:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA4CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:08:29 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id n6-20020a17090ac686b029015d2f7aeea8so7230808pjt.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 05:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQ/WekuR1RGoY4zmcpocpvZYk1dMpxlcgxwJmavsB/o=;
        b=mhwUJb3t73WsVeIhnkrLra6VbEc0SwtvuQN+3omwPqC+n6BFjia4kopSyjgpBytKeQ
         6ZLz2Vi8xvUjDZgyZR8L7ZD3WmjW2DZbLIDDY4G0LFkvVZ/pqjKNayevtBYs3ECcTeHA
         bVxksR8wQr+wjueFSBl2hZmT55/c3aKm4vBSt1uvDimgQYcKBN1UZVdSjiTc2T/nhIpY
         /PnlS6Gm+dOTSjF20XdtZuKVTQy4scROtDy3N9GdalR5XSwEVyXjDATYE405adhsc8eF
         ok8lYSlVWQPhzZNCGKF+BbGGNTx17fP0t/90RdYwLy1UDar/vB2BksYUneLNqqOdgJNu
         Qxmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=gQ/WekuR1RGoY4zmcpocpvZYk1dMpxlcgxwJmavsB/o=;
        b=I83D3QyNhnYQke3TzSIhGCGSKKQqAPMlSGCpZimImvbv4vjbJGA7HMgPrFXu20F5Ra
         1HKFFwLLvO4n5Cl3/GUoA77/KRAaYXjgv/B2ZHRMg0WshrzaQoQQlQ281hlVSapG+oOl
         GlxLeAeEksjGVFpOGhXXoYfP3/ozlIn+LkbSCQIIn++VlRSozhYn3Gd0J5QRYYumXUbx
         RA4CcI0JjD0NO53tM+h1/kYvoPW02blENtp03cJbwGZ93qLe0Iil6c68OCrRwuUBMwa6
         G2erFFo4O6VTvO2htXs5k1RKiouMDZjiLucYF9I1k0l69XSEWzwAy127rZTj7Ea+hRm9
         8CmQ==
X-Gm-Message-State: AOAM532Je/m7XjbG86Nm3ARrDpqDJ9iEVigRzFCr9DL7qkMo3OtGo2Ts
        Hb0IYHUWwJ8nXrmDfRKjwsw=
X-Google-Smtp-Source: ABdhPJz/xJk2duV8Ct8z6sBVcUjJY6IdRaJ0hW9unm8XnkD0kmQHQBodHMQIyY549nR2x+SoOJ6E2Q==
X-Received: by 2002:a17:90a:17a6:: with SMTP id q35mr10726348pja.118.1621598908113;
        Fri, 21 May 2021 05:08:28 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.20])
        by smtp.gmail.com with ESMTPSA id 69sm4338947pfx.115.2021.05.21.05.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 05:08:27 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, rkovhaev@gmail.com,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
Subject: [PATCH] staging: rtl8712: Fix memory leak in r8712_init_recv_priv
Date:   Fri, 21 May 2021 20:08:11 +0800
Message-Id: <20210521120811.516339-1-mudongliangabcd@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

r871xu_dev_remove failed to call r8712_free_drv_sw() and free the
resource (e.g., struct urb) due to the failure of firmware loading.

Fix this by invoking r8712_free_drv_sw at the failure site.

Reported-by: syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
Fixes: b4383c971bc5 ("staging: rtl8712: handle firmware load failure")
Signed-off-by: Dongliang Mu <mudongliangabcd@gmail.com>
---
 drivers/staging/rtl8712/usb_intf.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index dc21e7743349..a5190b4250ce 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -589,7 +589,7 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
  */
 static void r871xu_dev_remove(struct usb_interface *pusb_intf)
 {
-	struct net_device *pnetdev = usb_get_intfdata(pusb_intf);
+	struct net_device *pnetdev, *newpnetdev = usb_get_intfdata(pusb_intf);
 	struct usb_device *udev = interface_to_usbdev(pusb_intf);
 
 	if (pnetdev) {
@@ -597,9 +597,9 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
 
 		/* never exit with a firmware callback pending */
 		wait_for_completion(&padapter->rtl8712_fw_ready);
-		pnetdev = usb_get_intfdata(pusb_intf);
+		newpnetdev = usb_get_intfdata(pusb_intf);
 		usb_set_intfdata(pusb_intf, NULL);
-		if (!pnetdev)
+		if (!newpnetdev)
 			goto firmware_load_fail;
 		release_firmware(padapter->fw);
 		if (drvpriv.drv_registered)
@@ -625,6 +625,13 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
 	 */
 	if (udev->state != USB_STATE_NOTATTACHED)
 		usb_reset_device(udev);
+	if (pnetdev) {
+		struct _adapter *padapter = netdev_priv(pnetdev);
+		/* Stop driver mlme relation timer */
+		//r8712_stop_drv_timers(padapter);
+		//r871x_dev_unload(padapter);
+		r8712_free_drv_sw(padapter);
+	}
 }
 
 static int __init r8712u_drv_entry(void)
-- 
2.25.1

