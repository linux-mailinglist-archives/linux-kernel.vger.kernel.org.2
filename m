Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8660E410DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233929AbhISX4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233665AbhISXzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:33 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B868C061760
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:07 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id c21so53627562edj.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0HeSFyYPFTepArePe3je7Z+vfgzfAoaNBDxBw/Ndyzs=;
        b=FL9TVx4cqktQFF+xa3di7lqsy5dVVXHw/Kog4h1EQm2EqmrGp1zXeNll9dontHbvSu
         SwTNRj2JHifdj5bzNRBQLIVVsQhETtvu0YnWzAFP7Ii4Hcf5L9Xp1VBmpJwUrhazGIBG
         OgkIHsSsD4U1EW9F//NOlyVGIHUAHUYGyCcyrBX4HFtjmOemH98VbSSJyGV314YD3WAB
         wSADurfBX88YufcT2Si4WIOgMhQ/FQ5jBKrDOTamH8Lv98+PT97Ko8J51fu8LLP/ppQd
         eOVPuKyKjXcBqWktQjhXr+a1XEvp7SVxZbPNmOjuty4GWtC8tSZ5s/zFU+9u+f+4Ui5/
         GR7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0HeSFyYPFTepArePe3je7Z+vfgzfAoaNBDxBw/Ndyzs=;
        b=JJp22PFi6eBxHMEY/M5csqzzZSmXuvCJISDccT9D/NxTtv/lg0BjffmuNVPapTJOuS
         AFi6w+ZAZIkBUbUOpewbr/VmKFupx1bEoKNjFF+U4Uo+RsQHJLOa2R+IxnKfczb93pYq
         dCrVl6e6LfEDjSyGG3AoFywJeFArfpnR8Lsq96fBO8/mBTbk9m54IXIAjRPldBSosnTx
         4aKom2BF+Q1DzGJVny6r7iZOMDfyq2RRMDcDcmd11KHWF4qOGjzQHtIjcUyTGwLfiWaT
         gjGJHFPNvRYC3RlgPe40SAppuGTW1RzchCkx9wc0Ivb6YgB6cXZLlRowtrqN77xor6KM
         9TEA==
X-Gm-Message-State: AOAM531ZTqhY7JMZKLPujRdFFRW7QprtMfB9EAO9KGZNEO2o3gkyVt3P
        1siXKXQQ7U9qyrSjwY+YpGw=
X-Google-Smtp-Source: ABdhPJwHWKpa6ltK4B+EVKBKZcKE4DeUQfRnvHj6oqj+NN6G6CnReWt8hVRRMvCJE8lqmW2PtwAdSw==
X-Received: by 2002:a17:906:e094:: with SMTP id gh20mr26538221ejb.252.1632095646108;
        Sun, 19 Sep 2021 16:54:06 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v8 03/19] staging: r8188eu: remove unnecessary test in usbctrl_vendorreq()
Date:   Mon, 20 Sep 2021 01:53:40 +0200
Message-Id: <20210919235356.4151-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary test for "!io_buf" in usbctrl_vendorreq(). Remove the
no more used "release_mutex:" label.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index e06aea92c8d2..d92bdcc3716d 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -34,12 +34,6 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 	/*  Acquire IO memory for vendorreq */
 	io_buf = dvobjpriv->usb_vendor_req_buf;
 
-	if (!io_buf) {
-		DBG_88E("[%s] io_buf == NULL\n", __func__);
-		status = -ENOMEM;
-		goto release_mutex;
-	}
-
 	if (requesttype == REALTEK_USB_VENQT_READ)
 		pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
 	else
@@ -91,7 +85,7 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
 			break;
 	}
-release_mutex:
+
 	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
 exit:
 	return status;
-- 
2.33.0

