Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9174538B4DB
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 19:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233990AbhETRDS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 13:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhETRDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 13:03:16 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F392FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:01:54 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id k127so16882195qkc.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 May 2021 10:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GnCcM4kag0zi75Uj3XnSUlN1BTLRGuzOS27Epni0zmo=;
        b=eak30O+kEa209QuEDAZAJMFUbuAf2bsnMkD8l28owJBdDM/gZzDyLdO6bbWJTTHFBs
         A/OoRkWEINWzols+VuxAtmCddsz6VIaJGwfcEAveNenaOTEg8QJ7XH0eD+El4ZEYmJe3
         5X6h1rS6gpu/aqmZhEXJwcXWQf/DhXGzVP99D4obEySNIGPfWg9u8QtJXsxHOQx4OD8r
         tqrOQJrz9pZNNfsgJEb/hM/ULv5nSidgffjAAkXAn79jnNpetxan/l/WW4+hv121+A7r
         wjmygZ7y70h7nqBJuic3ByMxT0A6m7wD1LB8kEfisi33s4BD0ZhMnQwnQztTG3a+AaK6
         Teqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=GnCcM4kag0zi75Uj3XnSUlN1BTLRGuzOS27Epni0zmo=;
        b=ZqALsFzeDqXprc7QDEP+k0d2VjRJO8SVB/zvthmh6dUt1FOkHNc9jYHX0ByuYGaiGi
         LpglX5v9kvJ+5ik47TPCdFuiMhqh8O3Vfmgo821k+oDWljYjkwv11/s9e5FwT3vZxmTQ
         VT0kmOhVF3651kX95B5Bb+9gMQkLrfVHibtDpcdB860WxA6RdjtO8Sw85CmjkMiwif6m
         QmmPUzWtu7Vq8Qipiw7ZDVHv3hC7xT/vvfmZtIgt3/GeuF015xXeY1j78K0JJtjECn47
         0YSqxBdan+fG2VZ6xnIEys0xsjEYcV2YtnfIQtsq146qE7Il0AAno0Zj7h4ObiAW9F9s
         aP0w==
X-Gm-Message-State: AOAM53218rPxLGdCSJBtmdIiKQ0hA40HADzAnwaJ/XpGQPPwE949fEYK
        D3R8ATzoqXuWp0WT5KvxjIw=
X-Google-Smtp-Source: ABdhPJz11VyJYws//1N5g3k2MC2R6i3xdtq9pyvWSXk86cGaGETPxPxkxvumfeOimd/jIXh5ADP8hA==
X-Received: by 2002:a37:9b51:: with SMTP id d78mr6195648qke.441.1621530114179;
        Thu, 20 May 2021 10:01:54 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id y8sm2312647qtn.61.2021.05.20.10.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 May 2021 10:01:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Derek Kiernan <derek.kiernan@xilinx.com>
Cc:     Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michal Simek <michal.simek@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH] misc: xilinx-sdfec: Check if file->private_data is NULL
Date:   Thu, 20 May 2021 10:01:50 -0700
Message-Id: <20210520170150.1615956-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

container_of() only returns NULL if the passed pointer is NULL _and_
the embedded element is the first element of the structure. Even if that
is the case, testing against it is misleading and possibly dangerous
because the position of the embedded element may change. Explicitly
check if the parameter is NULL and bail out if so instead of checking
the result of container_of().

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
RFC:

The NULL check in the poll function is likely unnecessary. Interestingly,
there is no NULL check in the ioctl function, even though there is a
similar container_of() in that function. However, I do not feel
comfortable enough to change the functionality of this code and drop
the check entirely.

 drivers/misc/xilinx_sdfec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/xilinx_sdfec.c b/drivers/misc/xilinx_sdfec.c
index 23c8448a9c3b..0a3721d31dea 100644
--- a/drivers/misc/xilinx_sdfec.c
+++ b/drivers/misc/xilinx_sdfec.c
@@ -1011,11 +1011,11 @@ static __poll_t xsdfec_poll(struct file *file, poll_table *wait)
 	__poll_t mask = 0;
 	struct xsdfec_dev *xsdfec;
 
-	xsdfec = container_of(file->private_data, struct xsdfec_dev, miscdev);
-
-	if (!xsdfec)
+	if (!file->private_data)
 		return EPOLLNVAL | EPOLLHUP;
 
+	xsdfec = container_of(file->private_data, struct xsdfec_dev, miscdev);
+
 	poll_wait(file, &xsdfec->waitq, wait);
 
 	/* XSDFEC ISR detected an error */
-- 
2.25.1

