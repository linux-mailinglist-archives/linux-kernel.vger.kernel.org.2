Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644764171CB
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:27:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbhIXM3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343564AbhIXM3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:08 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AA46C061760
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:34 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id dj4so35528285edb.5
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Hrq8qAkDRRaqGN1vEGaa6t8c3H8UpeRh5p4OUisxCY8=;
        b=EjtoV1/hpElVhAmNF/pdC7dpbgZ7IGRT/JT93CfUYO/PV6vklBLNhRXnJ7Br7xdTVC
         3sTZr2XfB/MyVhuK7R/Yf/k2x/jNyK0hmNcsNb78knE6E5/02jmpeJpmzmVjWBEz4tp2
         GOl05YELbPnVX6o/HunUJYs103hOC2XVe39GDewidrab4Kci5OgdDSU5X1Z4K2EuRKBc
         HvNqiYI8r+h8kWuSS39GGDucOV+Z5pBGhnOxrDdWojTUEsdsMeGGhveAfaG79bBWIAfH
         gObXTM1enNq+esRQiRZM/ahE64paDQeWphfLaOv3ZjGBl3ABE7jWol9ERLkw65Yp100+
         Ki0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Hrq8qAkDRRaqGN1vEGaa6t8c3H8UpeRh5p4OUisxCY8=;
        b=OPHTJSOnkeu3TmSsIWN9tHA/vVt5fnKEAXxW2X+v3TR5Ep6BsN14wdtxrOyVXK/Kdh
         eCi7XKvjFysWozRRPqdo4CTcqI3qKQ5gKqorfhv+HMkUCvwPDZHotu5oVW1CTda0f9ng
         P+ip/AWBd2k7iH1q+XWhpL0h/2fxZUvICwyEL83tHgPkyJJPo/8IQ06ZZ4+oApZl9mB4
         6s2DS2utTHIgymRNSgKCFbGVk+DdmpwvvSBOjV9EVywSzzEw9J/KTJ4t+L6djWKB1/Ck
         FPzGN+EVjyL/k8Q9TPP73JgT1cWUDt+E3yIsNDIQmIU728VL5Deu37FO8iwuowk5/FSW
         a/5A==
X-Gm-Message-State: AOAM531lWD8jgz4mfj6B3UxTp/OYrSBja/7+rntFggKhIbp7EH8NsdgC
        aI6Ht32nz3BKdJefY9S/DXU=
X-Google-Smtp-Source: ABdhPJzi41fORyuvY66vdQBPJrLz8f7CS0ogmMxHi0kPyJARRBbtPw35BMvaI6LTradfL4eCzXdeqA==
X-Received: by 2002:a50:be82:: with SMTP id b2mr4643142edk.56.1632486453027;
        Fri, 24 Sep 2021 05:27:33 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v10 05/16] staging: r8188eu: remove a comment from usbctrl_vendorreq()
Date:   Fri, 24 Sep 2021 14:26:54 +0200
Message-Id: <20210924122705.3781-6-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unnecessary comment from usbctrl_vendorreq().

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 35d268c5cd7f..5c9613cc2415 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -70,10 +70,8 @@ static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 l
 			} else {
 				/* status != len && status >= 0 */
 				if (status > 0) {
-					if (requesttype == REALTEK_USB_VENQT_READ) {
-						/*  For Control read transfer, we have to copy the read data from io_buf to data. */
+					if (requesttype == REALTEK_USB_VENQT_READ)
 						memcpy(data, io_buf,  len);
-					}
 				}
 			}
 
-- 
2.33.0

