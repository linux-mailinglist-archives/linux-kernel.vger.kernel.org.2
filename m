Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 971C934B234
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 23:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhCZWej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 18:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbhCZWeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 18:34:18 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14ABC0613AA;
        Fri, 26 Mar 2021 15:34:18 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id t18so3234977pjs.3;
        Fri, 26 Mar 2021 15:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WKzFQKlrYE7WDOm7fsBHNHjTK+tvjtUZfYxbxTBy7Ls=;
        b=n9QMapMo6dKf+eZvsPGdvLJg9O+IHws/kBQO2GR87tPbzlBCGzUHUZweIpeSUgZDSv
         0Ko7pn7XU6GF3oSjUqERsVlK13rrVq5BAX6R6NYB8N0cqNydz4Kvbu7nErIC1FAWI12E
         TReyepi144I977t9FwaHUQfSCS/gVE05VqVBFnNx37nBtSksbVRSa9ApEVDIHgmwIub0
         4ZsM8CtjEw0azrslpzjhTNlT+lvMRE8hOLW5BhFcx0cHp9AIiphi6gnSmXsK9G1JOXGZ
         RLayS9DL76deKq2Vdl/aHPSTysbtsyrRrK0EyBCiM7ob1wswv1X7dqxSRnENyWbLtVKO
         XYlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WKzFQKlrYE7WDOm7fsBHNHjTK+tvjtUZfYxbxTBy7Ls=;
        b=j+AdwmikfDh024gE6A18Nr7VV59K9u00DknYAIllvWIG7rrYn8mpCJ+5lc8FOhzNor
         5jRInXx3XBUYxkts23+SfWYlwsN+dv3Gw3LH+9mHPXgE2XyqQkR0SsdQ00lu3Q+YIG1g
         SKOCXN7UIagz+KZJOqjdKMxDnfRBjGYFbkOtSN6xvGjycwjJQFD77HU/1Wx5Cz4fKEOL
         wF8NUCV6oCZ3+94xQqcu33cJW/rkSkDcXHGfXJg7NuEFcJ1v1nKRsmSzum00k41sPqPm
         dntQ4XVSrCZ2mbvqfl/Kzh9x2sjhTvF5PwmYeMAFrklOf1gE2nkpoREjy2R2jXxdI5MX
         ZcMA==
X-Gm-Message-State: AOAM533SY6Dxl4MmIdkLoKFv7lMUkfYy5EFHoaI6ot/z9JzyIxIgGdN7
        MlmDg56K1RUN6FNjtjH80Fc=
X-Google-Smtp-Source: ABdhPJwBLkaLKeO06WscA+kESLuxv6QHBTaXpIzQrP1RrwWXsQ5Ovpoh5iShes6+IxQhT6h70ojTrg==
X-Received: by 2002:a17:902:a406:b029:e6:78c4:71c8 with SMTP id p6-20020a170902a406b02900e678c471c8mr16962733plq.17.1616798058096;
        Fri, 26 Mar 2021 15:34:18 -0700 (PDT)
Received: from localhost.localdomain ([49.207.194.205])
        by smtp.gmail.com with ESMTPSA id c193sm10136262pfc.180.2021.03.26.15.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Mar 2021 15:34:17 -0700 (PDT)
From:   Anant Thazhemadam <anant.thazhemadam@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Anant Thazhemadam <anant.thazhemadam@gmail.com>,
        Johan Hovold <johan@kernel.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 2/3] usb: misc: ezusb: update to use usb_control_msg_send()
Date:   Sat, 27 Mar 2021 04:02:50 +0530
Message-Id: <20210326223251.753952-3-anant.thazhemadam@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210326223251.753952-1-anant.thazhemadam@gmail.com>
References: <20210326223251.753952-1-anant.thazhemadam@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The newer usb_control_msg_{send|recv}() API ensures that a short read is
treated as an error, data can be used off the stack, and raw usb pipes need
not be created in the calling functions.
For this reason, the instance of usb_control_msg() has been replaced with
usb_control_msg_send() appropriately.

Signed-off-by: Anant Thazhemadam <anant.thazhemadam@gmail.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/misc/ezusb.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/usb/misc/ezusb.c b/drivers/usb/misc/ezusb.c
index f058d8029761..78aaee56c2b7 100644
--- a/drivers/usb/misc/ezusb.c
+++ b/drivers/usb/misc/ezusb.c
@@ -31,24 +31,12 @@ static const struct ezusb_fx_type ezusb_fx1 = {
 static int ezusb_writememory(struct usb_device *dev, int address,
 				unsigned char *data, int length, __u8 request)
 {
-	int result;
-	unsigned char *transfer_buffer;
-
 	if (!dev)
 		return -ENODEV;
 
-	transfer_buffer = kmemdup(data, length, GFP_KERNEL);
-	if (!transfer_buffer) {
-		dev_err(&dev->dev, "%s - kmalloc(%d) failed.\n",
-							__func__, length);
-		return -ENOMEM;
-	}
-	result = usb_control_msg(dev, usb_sndctrlpipe(dev, 0), request,
+	return usb_control_msg_send(dev, 0, request,
 				 USB_DIR_OUT | USB_TYPE_VENDOR | USB_RECIP_DEVICE,
-				 address, 0, transfer_buffer, length, 3000);
-
-	kfree(transfer_buffer);
-	return result;
+				 address, 0, data, length, 3000, GFP_KERNEL);
 }
 
 static int ezusb_set_reset(struct usb_device *dev, unsigned short cpucs_reg,
-- 
2.25.1

