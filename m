Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 207B5357D8A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Apr 2021 09:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbhDHHsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Apr 2021 03:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbhDHHsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Apr 2021 03:48:05 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E62FFC061760
        for <linux-kernel@vger.kernel.org>; Thu,  8 Apr 2021 00:47:54 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id q5so1184020pfh.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Apr 2021 00:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=cyd1TO42KxdvcksUboP1vrADRv/z/6+I2iUfLJ43Yyw=;
        b=gu4CIrb4pMCx57faV0GmT1dqxw8bCEP9KdEkXOfCIzBZ7S8p/n3HoVxFlqQVa52jm6
         yPm/FeAW6tf6pKpsuRj9ANuTOA6LQKYULOJ0oAXQbA/IJOvBh7F7AKixVER9fW/QbUaI
         Q4fzGnhLQY/FGzoosTOMgx600g5Prhv1eHivqGK8emRmARPG2PMQEmCD8A2Hn81orl6m
         PJbJcUWDSuVmxQcIXfO8YKUznzJ0e7ameQDQD6DKLrCHyNzYNQzRBnbBCM6HB90TO3Lk
         QSu0YOw5qDxMX6YZKb5FelIIApaTo7Nv/XoLT/6Cm4GkrnSRAsvk5Z5qn4kTnT7RQXzr
         UF4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=cyd1TO42KxdvcksUboP1vrADRv/z/6+I2iUfLJ43Yyw=;
        b=nXkNFff5s2ZqUGB8ZOMW/fi48SzqEElNlcA2Zy6C9FD//e0SeLd76S3DZPVMddtXwd
         ja2R5B/JWFQpTQs3oYiPLD84QGtNnUztMBoz11gW+kYUzsmrZdmD8/9OBvblBvY/I4Te
         XWKuAF/gM1HNdjVH+sm3ChXrECfPnDnHr8S7IPVUicBy6UMqcYKYn0f7axfXmqNleqDV
         2U+PeDBnEJ0eTFmoH2F+42GB89Tni39EaBWJx3iysFSKgDe8bYqe2//N2hE3BnbLUg0V
         dCQezVMWvK4R5eW8F86BAnGP/f9+Ukq/hfJs8DZpt7PgrKrEHX4ZL+H2YBiG5oc7pNlm
         iAjg==
X-Gm-Message-State: AOAM531WW8qnAHXzAatWHbwiCtPZab4fl9A1l2+pUhBEwWjV8YCS47sv
        24Oy/yvp5fNMhMeZYF2oODQ=
X-Google-Smtp-Source: ABdhPJy6kzep4AA8UGP+4t/x1BgySCoGHmZQbIj/22oR+qYpL0Itd2PnPwArbwH1JDqXHKhGCPuQqg==
X-Received: by 2002:a65:66d9:: with SMTP id c25mr6712735pgw.359.1617868074362;
        Thu, 08 Apr 2021 00:47:54 -0700 (PDT)
Received: from kali ([152.57.40.190])
        by smtp.gmail.com with ESMTPSA id p2sm23715948pgm.24.2021.04.08.00.47.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 00:47:54 -0700 (PDT)
Date:   Thu, 8 Apr 2021 13:17:49 +0530
From:   Mitali Borkar <mitaliborkar810@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com, mitali_s@me.iitr.ac.in
Subject: [PATCH] staging: rtl8712: removed unnecessary blank line
Message-ID: <YG61JYTdl1HQKcGj@kali>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cleanup patch for CHECK: blank lines aren't necessary after an open
brace '{'
Reported by checkpatch

Signed-off-by: Mitali Borkar <mitaliborkar810@gmail.com>
---
 drivers/staging/rtl8712/usb_intf.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8712/usb_intf.c b/drivers/staging/rtl8712/usb_intf.c
index dc21e7743349..9038570fb949 100644
--- a/drivers/staging/rtl8712/usb_intf.c
+++ b/drivers/staging/rtl8712/usb_intf.c
@@ -36,7 +36,6 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 static void r871xu_dev_remove(struct usb_interface *pusb_intf);
 
 static const struct usb_device_id rtl871x_usb_id_tbl[] = {
-
 /* RTL8188SU */
 	/* Realtek */
 	{USB_DEVICE(0x0BDA, 0x8171)},
@@ -441,7 +440,7 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 
 			for (i = 0, offset = 0; i < 128; i += 8, offset++)
 				r8712_efuse_pg_packet_read(padapter, offset,
-						     &pdata[i]);
+							   &pdata[i]);
 
 			if (!r8712_initmac || !mac_pton(r8712_initmac, mac)) {
 				/* Use the mac address stored in the Efuse
@@ -561,10 +560,10 @@ static int r871xu_drv_init(struct usb_interface *pusb_intf,
 			 */
 			mac[0] &= 0xFE;
 			dev_info(&udev->dev,
-				"r8712u: MAC Address from user = %pM\n", mac);
+				 "r8712u: MAC Address from user = %pM\n", mac);
 		} else {
 			dev_info(&udev->dev,
-				"r8712u: MAC Address from efuse = %pM\n", mac);
+				 "r8712u: MAC Address from efuse = %pM\n", mac);
 		}
 		ether_addr_copy(pnetdev->dev_addr, mac);
 	}
-- 
2.30.2

