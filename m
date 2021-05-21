Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73F4B38CAEE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 May 2021 18:25:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbhEUQ1A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 May 2021 12:27:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234758AbhEUQ05 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 May 2021 12:26:57 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CEBEC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:25:33 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id lx17-20020a17090b4b11b029015f3b32b8dbso5841503pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 May 2021 09:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCj0Vj0/aEOSeqE1QBcXcL/Py2Jrh8/U+HcmsMEdhBE=;
        b=T75N1lghG4u7QkKxhi4qohHgR1xioMjwOwJlcZq4twmw+bTpnVdRCZ1dPKaGxe1vuN
         wY+YUXWtgnjIgMCtm8ShVyVVGlDgX2QyMtRuWElkh3J0q2/1OnPeUyq1uAQVUUgjbZ7m
         O9VFBBDCUOY+rfByDhCVOnyGRGopnHEcTs/kL+a5QRtaor7GOGUioPJ3KgEuumV08maA
         K6hU03jp9Wi6SEg2Ca+HRLnpOB9nPF6qkwPRCt8WkfmbOdGyASV88aN7D9jRq3cUYcJP
         kFMMVgOfWC8C3wn5UHFRIaZ/9cFVegJSD+L/uUw2kmNRsMe2fmE201jy2uKaILXmAjZC
         1jaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lCj0Vj0/aEOSeqE1QBcXcL/Py2Jrh8/U+HcmsMEdhBE=;
        b=IDw7QjpoQZqUoNdTzg8Z8eecv2hgLKJ8bC3k9ctawO6/V/s1jnE2SWAHhi3BvBDyKR
         JYTj3DRGA7d7VaFrccLl3D1AldMVp5f4ULqycdwsa3ibn8uXBJlTRnOvl5uKhD06ODXw
         3UqjhqdfVz9pllJkjLyDKm8Tg85wQPMBy8EMSDpe+7o3OjGSaXwOZt6LwZRRdtGgGqnx
         aBKOrjbnAdOEOPMrEOXwIIVl4seT5dLMZHuCD0Ilt/2xiw51iF/SIvFz+LZf/kKINAlD
         5LNgcZ2+4FknSSoV++C7YjB+otWXP/EDTYQ2QG2KB8pvXG7nxuezMXl5ZTmA7gi7PWrH
         BRcw==
X-Gm-Message-State: AOAM530vYWEuYqAZWx59OIsV7GXmY8XwBtAb4LVc6UHkhF8CLhyLHuwY
        jqKsD7xGM7UQJ24DzJuDpV0=
X-Google-Smtp-Source: ABdhPJwp6UIeyFlj1XdEPIz+zbSIck1hMoR25LSacMqM4MahKtAgw4IdcheGg6wMZjzKmnU6McALig==
X-Received: by 2002:a17:902:728c:b029:f6:6aff:4d66 with SMTP id d12-20020a170902728cb02900f66aff4d66mr8229086pll.20.1621614333031;
        Fri, 21 May 2021 09:25:33 -0700 (PDT)
Received: from localhost.localdomain ([45.135.186.20])
        by smtp.gmail.com with ESMTPSA id y17sm4544845pfb.183.2021.05.21.09.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 May 2021 09:25:31 -0700 (PDT)
From:   Dongliang Mu <mudongliangabcd@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, rkovhaev@gmail.com,
        straube.linux@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Dongliang Mu <mudongliangabcd@gmail.com>,
        syzbot+1c46f3771695bccbdb3a@syzkaller.appspotmail.com
Subject: [PATCH v2] staging: rtl8712: Fix memory leak in r8712_init_recv_priv
Date:   Sat, 22 May 2021 00:25:19 +0800
Message-Id: <20210521162519.677074-1-mudongliangabcd@gmail.com>
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
v1->v2: fix the initialization of pnetdev

 drivers/staging/rtl8712/usb_intf.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index dc21e7743349..57e773464e18 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -593,13 +593,14 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
 	struct usb_device *udev = interface_to_usbdev(pusb_intf);
 
 	if (pnetdev) {
+		struct net_device *newpnetdev = NULL;
 		struct _adapter *padapter = netdev_priv(pnetdev);
 
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
@@ -625,6 +626,10 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
 	 */
 	if (udev->state != USB_STATE_NOTATTACHED)
 		usb_reset_device(udev);
+	if (pnetdev) {
+		struct _adapter *padapter = netdev_priv(pnetdev);
+		r8712_free_drv_sw(padapter);
+	}
 }
 
 static int __init r8712u_drv_entry(void)
-- 
2.25.1

