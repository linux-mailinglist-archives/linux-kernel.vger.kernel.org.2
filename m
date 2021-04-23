Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26832369544
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242872AbhDWO7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242783AbhDWO71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:27 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEE7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:46 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x7so48671890wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/iRqZNCmCgxmpFbtmmNVS6lXC39KZ3FxTpPWN6Xmdw=;
        b=Lstd56lwaDm+NDZ8FCqag0buthMnw89j+qBz4lqDoOz9Jp5qbWTOhPGA7u7zBb9KPf
         FUooqBEZRwCaHI7MkTOyihg/MOog3bQHoiB6q4T909ds1a/+NxTh5eDLgevYHUbvdWPs
         //ugm3/GC5mRCL+gMuPpmXvBnmf5eTG2slbHPIzeFp8WlUe/2aaIHRtRWzDY1iKJfpYa
         GWdZSl2zAbzrngoJkh0S+1IU2YRZF30JKhsvbLSb/gB7P6fseaFvYkAD9iYQVVN0/vlN
         8DBOGv9E4BP7yshfX/GwqTnQcbulsoU2YIxE0PLwD1kOVPj7+A7PQfA2yOpHnZhHU0up
         fSYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/iRqZNCmCgxmpFbtmmNVS6lXC39KZ3FxTpPWN6Xmdw=;
        b=PzonCaP8kCZHbI65u3j2PShBy8bjHiTNmaFwfO8KqK5CfsOvs5qzWjm8Ly5kZ5P2no
         /pYZmEAAC8vUeVYe0Uo14WRryE+3tU5e93zrEsJjJMVF/Ablnk6JcWRYiwzm5uwNQPlX
         4Srqa69p9L7FQD9AqhzBOaNo5M71ee5/v8jy91Z8d3BX0wv2LHy/hjkm1oZZCaO0pVKU
         YfD8LIBB8giOaAtdPnEI2wX1yUuXD44Ttj+0KNi8Rl8uRFDKpNJ8GngsqNrDhVBoI3a+
         xT+ty91hqEf6x2TwRcGKNoYFgRTuNRZDtyV3oi/qprqB47XYBrG8X0xRcWpdO+LiA+pL
         1ztQ==
X-Gm-Message-State: AOAM5318deJ4aD3ENCUoxo4lJZ/+PH7yWyzkwRQPvQukrEVL8td8o/ti
        tJZVjpoIs5Ee0d5+ecqSroRFUio5F68=
X-Google-Smtp-Source: ABdhPJyXG5UOS9dkjHZYC4OHZGQ+16R7j+25bKuVMzTn/GcVepTH59hgh4J237N6dvWuF+pFlDqTFA==
X-Received: by 2002:a5d:400d:: with SMTP id n13mr5193739wrp.372.1619189925539;
        Fri, 23 Apr 2021 07:58:45 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id a7sm9480868wrn.50.2021.04.23.07.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:58:45 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 02/49] staging: rtl8723bs: replace DBG_871X_SEL log macro with netdev_dbg()
Date:   Fri, 23 Apr 2021 16:57:53 +0200
Message-Id: <9e6a1e4dc8962bfd58375be98619c76e8e28febe.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace DBG_871X_SEL log macro with the net device driver
recommended netdev_dbg().

This macro by default does a raw printk, and the alternative
behaviour, never triggered is a seq_print() call.

So replace with netdev_dbg().

The operation has been done with the following semantic patch
script:

@@
expression sel;
expression list args;
identifier padapter;
identifier func;
@@

func(..., struct adapter *padapter, ...) {
	<...
-	DBG_871X_SEL(sel, args);
+	netdev_dbg(padapter->pnetdev, args);
	...>

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 0ee0190c09d7..a43fa38cae62 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -23,9 +23,10 @@ void mac_reg_dump(void *sel, struct adapter *adapter)
 	for (i = 0x0; i < 0x800; i += 4) {
 		if (j%4 == 1)
 			netdev_dbg(adapter->pnetdev, "0x%03x", i);
-		DBG_871X_SEL(sel, " 0x%08x ", rtw_read32(adapter, i));
+		netdev_dbg(adapter->pnetdev, " 0x%08x ",
+			   rtw_read32(adapter, i));
 		if ((j++)%4 == 0)
-			DBG_871X_SEL(sel, "\n");
+			netdev_dbg(adapter->pnetdev, "\n");
 	}
 }
 
@@ -37,9 +38,10 @@ void bb_reg_dump(void *sel, struct adapter *adapter)
 	for (i = 0x800; i < 0x1000 ; i += 4) {
 		if (j%4 == 1)
 			netdev_dbg(adapter->pnetdev, "0x%03x", i);
-		DBG_871X_SEL(sel, " 0x%08x ", rtw_read32(adapter, i));
+		netdev_dbg(adapter->pnetdev, " 0x%08x ",
+			   rtw_read32(adapter, i));
 		if ((j++)%4 == 0)
-			DBG_871X_SEL(sel, "\n");
+			netdev_dbg(adapter->pnetdev, "\n");
 	}
 }
 
@@ -64,9 +66,9 @@ void rf_reg_dump(void *sel, struct adapter *adapter)
 			value = rtw_hal_read_rfreg(adapter, path, i, 0xffffffff);
 			if (j%4 == 1)
 				netdev_dbg(adapter->pnetdev, "0x%02x ", i);
-			DBG_871X_SEL(sel, " 0x%08x ", value);
+			netdev_dbg(adapter->pnetdev, " 0x%08x ", value);
 			if ((j++)%4 == 0)
-				DBG_871X_SEL(sel, "\n");
+				netdev_dbg(adapter->pnetdev, "\n");
 		}
 	}
 }
-- 
2.20.1

