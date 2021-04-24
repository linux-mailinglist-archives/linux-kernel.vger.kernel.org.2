Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D09D436A042
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbhDXJD0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234596AbhDXJDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:18 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A7B8C06174A
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:40 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id x7so50644053wrw.10
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=F/iRqZNCmCgxmpFbtmmNVS6lXC39KZ3FxTpPWN6Xmdw=;
        b=kkETIbPAMKrWgB3GJLegv/n7bkOYFzk2F9EyimD5MsOVsT6V4+Agkm29HbC3UdZIZQ
         KmHJcU/b9m0rZKTWV9McwfuNtOm9MkbdNVVwv67LfC+9Pcly4ey0VxW41Z2DlhtkM5R5
         sfzTjC7h1YRRzZzAaC3+7WTr4AIhGgmEca3lxL0fylAUebfI64zaY6LJpKh6pROdgZFO
         h4as3dC/ZMRrjmEphWU70CReFRyi9a5H3dNdJpo1htICfqEdlpkd2Lh3+fd3g4fjXKtJ
         +Zd6bzYmGfNtIWSQ5ePfAmj+OTtnrVUQ9V7j2if1YkwBd2ZdH8U/w578ZB4Jdlh25fNV
         vXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=F/iRqZNCmCgxmpFbtmmNVS6lXC39KZ3FxTpPWN6Xmdw=;
        b=t/c5FJEUEEHJfTYtBGw+3Ezz/b+mVtQQa0OQQ18NeUIZR1updsOn95H16AMjXjjCpS
         NTONGlXDWz8OtmhKUxDav8I2U9R3ewBOXZ5GOvvV7qe7NbELngl16SgrXO/oUkXXwgNp
         F+da0bHV4QxKFjy/puWHPA2HGHJw1Wvo3uyFWdOnpBG4QoAYV4bG8gZsw5iiWmQ3coOO
         sL5XnE/+bt3moZs76BQ7/YFlk7PMuvjeJaCYkRzA4eDbIlSiwPHeWA3Dcj9aymxdo89s
         lTD+WFIl04B/EN5YpasCepAvPRkNkyMeci9rBZMJQMShvdvoq321Xt4cZSuFOE5MQ0F2
         qugg==
X-Gm-Message-State: AOAM531VLKmHhO2TI3VtVnTCUvWEn6UhUQRXkAgH3P2dbJfC45j4nlA0
        eK5BonD5XljD55+qyR6JR72/iPX67cfX7Q==
X-Google-Smtp-Source: ABdhPJwuChLrSMelNjxtMt9YStvxO4QP1m10Zlt/FsdYxnPDfnkoKltZdpnIMXZbhU57mU/Aw7IojQ==
X-Received: by 2002:a05:6000:1789:: with SMTP id e9mr10083140wrg.110.1619254958990;
        Sat, 24 Apr 2021 02:02:38 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id l5sm12377999wro.4.2021.04.24.02.02.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:02:38 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 02/50] staging: rtl8723bs: replace DBG_871X_SEL log macro with netdev_dbg()
Date:   Sat, 24 Apr 2021 11:01:45 +0200
Message-Id: <9e6a1e4dc8962bfd58375be98619c76e8e28febe.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
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

