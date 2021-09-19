Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95BF1410DE3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:55:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233824AbhISX4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbhISXzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:33 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E098AC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:06 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id eg28so31054787edb.1
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Tc3T6heCxZqW05/CSeGigfVkKIeuPYK64e+EOdX8yk=;
        b=qeZwCS8QzFM7A5lvYq8vRYbQWYJsFcUJyUNqC4e80miNyI6xOwa7ysrocZSPnZED1M
         bzl4XmbvD57QvzLY44CZwU7toh6Z0zl/2bQxtHnhVS9uk67vOvYlynYZdemccs3dBzSB
         ChlgqyKACBivLYAFxY0F7kwRP6tA9nAzO2lgzjJTIb3Rn/cQVYtXZe0W8SjJu9l7W9uz
         u6+pcppoMSgOLI88nfckM75W99upUOyxCDd95usPEwPnOL02htEWp/Hwd25hU2hqu1by
         9dmMUQn6xvJnHx5DI75ETXDnBIgE8KJ5XMHB7bTuCvfDNvkGT1Iut9iSmDBZDHPZtkVT
         JxCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Tc3T6heCxZqW05/CSeGigfVkKIeuPYK64e+EOdX8yk=;
        b=2Mp7sEFpbn4q30mtaLhEx2bRxY30qOP6F3VdzNLraW/KitaPuXw9o2RJaSEJQZ8xV1
         W3nz/0RX/9hhcz8vsZ4Juy2RU6MigHo89iKUvnBoeYhg1BdeT9oEZvfMM9ODU0SbCoa0
         6ajMQv5tnzfXQuvP0X756oen+UW4myysxs4cMssY2C35Kt6eDl3Izx3VIRvhzFmgW6b7
         sU+yx6muYAT6xvXKiiBMOLqaFECOx3/O/FrrZiWBG2wYHGPQYYclOllcX1KnkZPzFrq9
         gTp5lQUdmqyKwIm1/ex0Y8gc05kH6t00g/30E+iYqC5kplFNr7iNDE/Pea5ZCfnrQlKb
         jOBQ==
X-Gm-Message-State: AOAM531p+QBeaieTeOJ1+Yi5uZiz5Wabe3Pa5P5x1DNQNWv0MXQbhAyA
        +aT78zwnO1gMzOrxIOBoUbU=
X-Google-Smtp-Source: ABdhPJzIeF3/pu1mKfDIHTgr9G+Taq5GmXMSHgAN74dQpeYYQ5M9jmfBIrtpYJ0GXTioKBPQ52qq+g==
X-Received: by 2002:a05:6402:847:: with SMTP id b7mr26458200edz.242.1632095644822;
        Sun, 19 Sep 2021 16:54:04 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:04 -0700 (PDT)
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
Subject: [PATCH v8 02/19] staging: r8188eu: reorder declarations in usbctrl_vendorreq()
Date:   Mon, 20 Sep 2021 01:53:39 +0200
Message-Id: <20210919235356.4151-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder variables declarations according to the "Reverse Xmas Tree"
style.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 3bfae4bd4a1e..e06aea92c8d2 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -13,10 +13,10 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 	struct adapter *adapt = intfhdl->padapter;
 	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
+	int vendorreq_times = 0;
 	unsigned int pipe;
 	int status = 0;
 	u8 *io_buf;
-	int vendorreq_times = 0;
 
 	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
 		status = -EPERM;
-- 
2.33.0

