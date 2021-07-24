Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16B13D49FD
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 22:56:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhGXUPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jul 2021 16:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbhGXUPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jul 2021 16:15:16 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B07C061575
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:55:47 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id hs23so8993617ejc.13
        for <linux-kernel@vger.kernel.org>; Sat, 24 Jul 2021 13:55:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=6uCQCRQPCT19AFCHKSbasFjoqzaU46ALDrk/HwseUHg=;
        b=d6yJVNEypat1rndFBJKM+v3nmwf5LgBiY9J9EAAmJmBw8dCk87cUQ6CDMpwu6E1MEk
         byFxlzKDGImIzhWoOkjmih/B9MzEa1fy9cIq/NzoDk4apMOKzn8tKQ6SAi68Zcy99GYg
         CnmhgIealop1K18b7c0bnN8xUCt04pB66ldwZ1AtjaHo1esCpvaH4kcaxKTB2DJB2ID5
         c0ln3RY/M41H67hbMm+OEQ2PsQabujMK4bMYJH3fuF0+8lJkfKjq3QYjzE0WAkecOFUr
         tHZH5lN3/mFmHYcyPdm7G3Qd4/0U1ZZdHoqqdHxYGN9PB+F0L3KSZgHHOM+z2u+QrWh7
         heBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=6uCQCRQPCT19AFCHKSbasFjoqzaU46ALDrk/HwseUHg=;
        b=nSwfL92c6DawZVj43m9jscjMnfRB5FxU1YvbZuU29vObAvvKbHrRP4qitBYKf9dBjU
         OuLQuai/xRw+7U4eiHjIZk8sKcq/DFXrd7v+gtg7s0JNm67inMx0mOb7gC2KqFeW3Lm5
         jOi82DcpAVI+SFtH2hvh963lRSHQIk863ZS72LCo0k/uel+FIWZQYmku0ewSpfbru11q
         UWA5MX8ADvR98mw3gK0QI1ORKAggP1TcATUH6Z/zNF5/dVngFrdjJyq5kQwPdCFqVL2G
         bauUhoXypdzZgaUVAhl8C4GELbMsIeMeCsBB6YyS4SpNuW7lcVARBja6pzZOeQGRP8ft
         6+QA==
X-Gm-Message-State: AOAM533DSKUQMD3D5ZqJBEIog1Qsl1a/T+EZqvNCA8q6pZvzn3ry+py+
        vRXvxryFqcJt9sICGxYWGSY=
X-Google-Smtp-Source: ABdhPJxc89QyHL4WWFW8E1PJmzYDAd71rLOlZ4bVOYb6DwnUrgGzA1xEho8+HXz3ikCwMxxGSz/gOQ==
X-Received: by 2002:a17:906:cb8b:: with SMTP id mf11mr10382461ejb.297.1627160146271;
        Sat, 24 Jul 2021 13:55:46 -0700 (PDT)
Received: from pc ([196.235.233.206])
        by smtp.gmail.com with ESMTPSA id x13sm14569817edv.40.2021.07.24.13.55.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Jul 2021 13:55:45 -0700 (PDT)
Date:   Sat, 24 Jul 2021 21:55:42 +0100
From:   Salah Triki <salah.triki@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        Ross Schmidt <ross.schm.dev@gmail.com>,
        Marco Cesati <marcocesati@gmail.com>,
        Brother Matthew De Angelis <matthew.v.deangelis@gmail.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Ivan Safonov <insafonov@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] tablet: acecad: update the reference count of the usb
 interface structure
Message-ID: <20210724205542.GA549014@pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use usb_get_intf() and usb_put_intf() in order to update the reference
count of the usb interface structure.

Signed-off-by: Salah Triki <salah.triki@gmail.com>
---
 drivers/input/tablet/acecad.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/input/tablet/acecad.c b/drivers/input/tablet/acecad.c
index a38d1fe97334..85fe134a30ee 100644
--- a/drivers/input/tablet/acecad.c
+++ b/drivers/input/tablet/acecad.c
@@ -151,7 +151,7 @@ static int usb_acecad_probe(struct usb_interface *intf, const struct usb_device_
 		goto fail2;
 	}
 
-	acecad->intf = intf;
+	acecad->intf = usb_get_intf(intf);
 	acecad->input = input_dev;
 
 	if (dev->manufacturer)
@@ -236,6 +236,9 @@ static void usb_acecad_disconnect(struct usb_interface *intf)
 	input_unregister_device(acecad->input);
 	usb_free_urb(acecad->irq);
 	usb_free_coherent(udev, 8, acecad->data, acecad->data_dma);
+
+	usb_put_intf(acecad->intf);
+
 	kfree(acecad);
 }
 
-- 
2.25.1

