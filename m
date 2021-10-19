Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD1C5434056
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Oct 2021 23:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhJSVTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Oct 2021 17:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbhJSVTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Oct 2021 17:19:46 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8A5C06161C
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 14:17:33 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id n8so10394201lfk.6
        for <linux-kernel@vger.kernel.org>; Tue, 19 Oct 2021 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bpFxd53CAHYKczCq3v4lVV5jmE8IcTlnWv6pG2Lu9o=;
        b=EBjNC78e8rjQLzrT+3EwmXYI7ewO6+H2OvqRqC1CqQBzgNM/oseUGJKsqwgicvRFRT
         ZzOrC5a+yHZbO53LnkJNeYKml6VBXPa0pj/D2+kQd0HHO4N0DN6iO6P0S1hRB7ckpYbk
         1NL0GymoU1VCBF2ElQqHM2bzI2KYaQsTuzvJhLifrZPe/e9RfX5kbH1YrEN7aPAfU5+o
         p5yPrFwulH+APr9tGw+cTBNw6LHyPh+fhzyWVSHCRtf6p6UapSo3tyRBhVBg6excEYum
         NJqqU7tKDlMr3roY/sdz+/QDC6tEM4x4cXyBqvaUzwFHrnR3S4+97mduWqunoHMeezeb
         f5NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1bpFxd53CAHYKczCq3v4lVV5jmE8IcTlnWv6pG2Lu9o=;
        b=tawO2SFelj0OdJzitbqHXvyP8SGPhssnk/cOhahQ3RUwVw93sXEzhsxBzGbuTJiwDX
         l1ib/GzzatHOHAxslVxoadhuKHebnBV1Mh3Sm5P9SqzRNNKNovQxS68YQax7VP1VSD28
         QX0CjSGME2mV/nijhH8o7MzGVT6Z+bqTU1167UxD/AulT7dz4BR+XEyu6QmO4KrsVKzH
         OcM736fJydyVu3vXfjgnyJ8AHgahrM4HAf6o5ct5gBIJHGWMt9UJK8ekI+DWFTd9KOX5
         VU2VI997z0OeeaNt5q6Hv/u+grZ0gp3YNgmQc3nMGJDLsNyB3yA3XJpB8DeIrzWUYU5E
         OHgg==
X-Gm-Message-State: AOAM530Tgxpbm35EY+xjAOqu0S5lFLnYfD4yZI+YmWmGx3HdyhLzxSTA
        s+ZFCgBtEQwn6TPvVzXNxkM=
X-Google-Smtp-Source: ABdhPJx+vyVxhDReZopMlegXcwMMh6dclK8RubwcAqbTMekYgokYz0PBPX6npDBV/In1+xKXNOA8uA==
X-Received: by 2002:ac2:4c42:: with SMTP id o2mr8379327lfk.504.1634678251628;
        Tue, 19 Oct 2021 14:17:31 -0700 (PDT)
Received: from localhost.localdomain ([94.103.235.181])
        by smtp.gmail.com with ESMTPSA id p16sm22330lfa.266.2021.10.19.14.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:17:31 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, hridayhegde1999@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        syzbot+c55162be492189fb4f51@syzkaller.appspotmail.com
Subject: [PATCH] staging: rtl8712: fix use-after-free in rtl8712_dl_fw
Date:   Wed, 20 Oct 2021 00:17:18 +0300
Message-Id: <20211019211718.26354-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syzbot reported use-after-free in rtl8712_dl_fw(). The problem was in
race condition between r871xu_dev_remove() ->ndo_open() callback.

It's easy to see from crash log, that driver accesses released firmware
in ->ndo_open() callback. It may happen, since driver was releasing
firmware _before_ unregistering netdev. Fix it by moving
unregister_netdev() before cleaning up resources.

Call Trace:
...
 rtl871x_open_fw drivers/staging/rtl8712/hal_init.c:83 [inline]
 rtl8712_dl_fw+0xd95/0xe10 drivers/staging/rtl8712/hal_init.c:170
 rtl8712_hal_init drivers/staging/rtl8712/hal_init.c:330 [inline]
 rtl871x_hal_init+0xae/0x180 drivers/staging/rtl8712/hal_init.c:394
 netdev_open+0xe6/0x6c0 drivers/staging/rtl8712/os_intfs.c:380
 __dev_open+0x2bc/0x4d0 net/core/dev.c:1484

Freed by task 1306:
...
 release_firmware+0x1b/0x30 drivers/base/firmware_loader/main.c:1053
 r871xu_dev_remove+0xcc/0x2c0 drivers/staging/rtl8712/usb_intf.c:599
 usb_unbind_interface+0x1d8/0x8d0 drivers/usb/core/driver.c:458

Fixes: 8c213fa59199 ("staging: r8712u: Use asynchronous firmware loading")
Reported-and-tested-by: syzbot+c55162be492189fb4f51@syzkaller.appspotmail.com
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/rtl8712/usb_intf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index 505ebeb643dc..cae04272deff 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -595,12 +595,12 @@ static void r871xu_dev_remove(struct usb_interface *pusb_intf)
 
 	/* never exit with a firmware callback pending */
 	wait_for_completion(&padapter->rtl8712_fw_ready);
+	if (pnetdev->reg_state != NETREG_UNINITIALIZED)
+		unregister_netdev(pnetdev); /* will call netdev_close() */
 	usb_set_intfdata(pusb_intf, NULL);
 	release_firmware(padapter->fw);
 	if (drvpriv.drv_registered)
 		padapter->surprise_removed = true;
-	if (pnetdev->reg_state != NETREG_UNINITIALIZED)
-		unregister_netdev(pnetdev); /* will call netdev_close() */
 	r8712_flush_rwctrl_works(padapter);
 	r8712_flush_led_works(padapter);
 	udelay(1);
-- 
2.33.1

