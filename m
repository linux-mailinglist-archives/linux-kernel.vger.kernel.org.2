Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC453A5ACF
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 00:43:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232211AbhFMWpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 18:45:11 -0400
Received: from mail-wm1-f48.google.com ([209.85.128.48]:52984 "EHLO
        mail-wm1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbhFMWpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 18:45:10 -0400
Received: by mail-wm1-f48.google.com with SMTP id f17so11005444wmf.2
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Isv5W8SGDip5PWWs67KiL0JeNgzRX7W2d1GezPhOQ4s=;
        b=MSUCZc6wV2LWHIY7drAM1uf7ygqdRzqsJgK50h1p1zTMXr1QzOq5ix6BztCVKLb+6I
         n2fECSa39a/MtJ4K19yXypKmKz7J9j/8oj/Rrc+asRoapUqdGrLA2vQa/KdKJd2ZRtu8
         413W7MOKT/y60hqCsA/blFtqVlg1QRd/iPaNC3NecWez+38p3DPVILI9KBdGVboOJ4u7
         OSZlGKUNhOiChrwFOQokq1gY/uBE04M/ndqbH0zjIHU/m2xXYjCtYV9DbGsYa0xd9qfJ
         Lyp9rNhydeq8PaPUBPbclIpEZM1vW2J5gH0Z+fSrc1n1TsNT4H0RDHVHe+Kka038nCEA
         6C+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Isv5W8SGDip5PWWs67KiL0JeNgzRX7W2d1GezPhOQ4s=;
        b=aUgNofkLEYjYsMxnZH0993QsjXfqLsNSRe0TTTmNiRL7qMQaOU4D503sG+eIoUU3lN
         GG1nOmgaQOBkeBIEq9NupuUOmE3xaUrOzBdM+ltpq3omzqkdEYBoTtsxa5Gr3SickQ+t
         LmdG6AoQRtPFFDYP7SN8p9bidqvLao85OqCs6PJGFlCvN7P8ri8A2iO0cJyGLr5tDjWV
         m/hbmqLAXXozL/62JI3QrF4cZtn4hCLW2QkWvo3Xv96Qvz8CxxosnwvOtL7L2b1i2Y1/
         grYTzrP/9JP1SJ4DEUqS1E94mUE29Z1Qc2qsSFLo78m6okQxik6KIu+qyWEHjgQJ2/vw
         z7xg==
X-Gm-Message-State: AOAM5335JKYe3laZdJ/qjKLvMKIrUSqMkPmyNFTNh2nmwzOGCqRWGyok
        /sDypad0EaMCtkCGbWbVm66c8a+HghZiHGYc
X-Google-Smtp-Source: ABdhPJylowid0p5eaYzXujksQ2AlXFcyGWBkLNNaIUnsMRn3mgkP+i8rzGDIAHE5lE+439D5+OXKWg==
X-Received: by 2002:a05:600c:3581:: with SMTP id p1mr27143058wmq.109.1623624112731;
        Sun, 13 Jun 2021 15:41:52 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id w11sm15120618wrv.89.2021.06.13.15.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 15:41:52 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, insafonov@gmail.com,
        linux@roeck-us.net, straube.linux@gmail.com, liushixin2@huawei.com,
        gustavoars@kernel.org, christophe.jaillet@wanadoo.fr,
        yepeilin.cs@gmail.com, dan.carpenter@oracle.com, martin@kaiser.cx,
        simon.fodin@gmail.com, romain.perier@gmail.com,
        apais@linux.microsoft.com, mh12gx2825@gmail.com
Subject: [PATCH 1/3] staging: rtl8188eu: convert DBG_88E calls in core/rtw_efuse.c
Date:   Sun, 13 Jun 2021 23:41:45 +0100
Message-Id: <20210613224147.1045-2-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210613224147.1045-1-phil@philpotter.co.uk>
References: <20210613224147.1045-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert all calls to the DBG_88E macro in core/rtw_efuse.c into
netdev_dbg calls. The DBG_88E macro is unnecessary, as visibility of
debug messages can be controlled more precisely by just using debugfs.
It is important to keep these messages still, as they are displayable
via a kernel module parameter when using DBG_88E.

Also modify efuse_phymap_to_logical function signature to pass through
a struct net_device pointer, so that we can use it to call netdev_dbg
in this function too.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_efuse.c | 27 ++++++++++++++--------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_efuse.c b/drivers/staging/rtl8188eu/core/rtw_efuse.c
index 9bb3ec0cd62f..019796c0f1af 100644
--- a/drivers/staging/rtl8188eu/core/rtw_efuse.c
+++ b/drivers/staging/rtl8188eu/core/rtw_efuse.c
@@ -72,7 +72,7 @@ static void efuse_power_switch(struct adapter *pAdapter, u8 write, u8 pwrstate)
 }
 
 static void
-efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
+efuse_phymap_to_logical(struct net_device *dev, u8 *phymap, u16 _offset, u16 _size_byte, u8 *pbuf)
 {
 	u8 *efuseTbl = NULL;
 	u8 rtemp8;
@@ -92,7 +92,7 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 		      sizeof(void *) + EFUSE_MAX_WORD_UNIT * sizeof(u16),
 		      GFP_KERNEL);
 	if (!tmp) {
-		DBG_88E("%s: alloc eFuseWord fail!\n", __func__);
+		netdev_dbg(dev, "alloc eFuseWord fail!\n");
 		goto eFuseWord_failed;
 	}
 	for (i = 0; i < EFUSE_MAX_SECTION_88E; i++)
@@ -113,7 +113,9 @@ efuse_phymap_to_logical(u8 *phymap, u16 _offset, u16 _size_byte, u8  *pbuf)
 		efuse_utilized++;
 		eFuse_Addr++;
 	} else {
-		DBG_88E("EFUSE is empty efuse_Addr-%d efuse_data =%x\n", eFuse_Addr, rtemp8);
+		netdev_dbg(dev,
+			   "EFUSE is empty efuse_Addr-%d efuse_data =%x\n",
+			   eFuse_Addr, rtemp8);
 		goto exit;
 	}
 
@@ -220,7 +222,7 @@ static void efuse_read_phymap_from_txpktbuf(
 	if (bcnhead < 0) /* if not valid */
 		bcnhead = usb_read8(adapter, REG_TDECTRL + 1);
 
-	DBG_88E("%s bcnhead:%d\n", __func__, bcnhead);
+	netdev_dbg(adapter->pnetdev, "bcnhead:%d\n", bcnhead);
 
 	usb_write8(adapter, REG_PKT_BUFF_ACCESS_CTRL, TXPKT_BUF_SELECT);
 
@@ -232,8 +234,10 @@ static void efuse_read_phymap_from_txpktbuf(
 		usb_write8(adapter, REG_TXPKTBUF_DBG, 0);
 		start = jiffies;
 		while (!(reg_0x143 = usb_read8(adapter, REG_TXPKTBUF_DBG)) &&
-		       jiffies_to_msecs(jiffies - start) < 1000) {
-			DBG_88E("%s polling reg_0x143:0x%02x, reg_0x106:0x%02x\n", __func__, reg_0x143, usb_read8(adapter, 0x106));
+			jiffies_to_msecs(jiffies - start) < 1000) {
+			netdev_dbg(adapter->pnetdev,
+				   "polling reg_0x143:0x%02x, reg_0x106:0x%02x\n",
+				   reg_0x143, usb_read8(adapter, 0x106));
 			usleep_range(1000, 2000);
 		}
 
@@ -255,7 +259,9 @@ static void efuse_read_phymap_from_txpktbuf(
 
 			limit = min_t(u16, len - 2, limit);
 
-			DBG_88E("%s len:%u, lenbak:%u, aaa:%u, aaabak:%u\n", __func__, len, lenbak, aaa, aaabak);
+			netdev_dbg(adapter->pnetdev,
+				   "len:%u, lenbak:%u, aaa:%u, aaabak:%u\n",
+				   len, lenbak, aaa, aaabak);
 
 			memcpy(pos, ((u8 *)&lo32) + 2, (limit >= count + 2) ? 2 : limit - count);
 			count += (limit >= count + 2) ? 2 : limit - count;
@@ -278,7 +284,7 @@ static void efuse_read_phymap_from_txpktbuf(
 		i++;
 	}
 	usb_write8(adapter, REG_PKT_BUFF_ACCESS_CTRL, DISABLE_TRXPKT_BUF_ACCESS);
-	DBG_88E("%s read count:%u\n", __func__, count);
+	netdev_dbg(adapter->pnetdev, "read count:%u\n", count);
 	*size = count;
 }
 
@@ -294,7 +300,7 @@ static s32 iol_read_efuse(struct adapter *padapter, u8 txpktbuf_bndy, u16 offset
 	status = iol_execute(padapter, CMD_READ_EFUSE_MAP);
 	if (status == _SUCCESS)
 		efuse_read_phymap_from_txpktbuf(padapter, txpktbuf_bndy, physical_map, &size);
-	efuse_phymap_to_logical(physical_map, offset, size_byte, logical_map);
+	efuse_phymap_to_logical(padapter->pnetdev, physical_map, offset, size_byte, logical_map);
 	return status;
 }
 
@@ -432,7 +438,8 @@ int Efuse_PgPacketRead(struct adapter *pAdapter, u8 offset, u8 *data)
 						hoffset = ((tmp_header & 0xE0) >> 5) | ((efuse_data & 0xF0) >> 1);
 						hworden = efuse_data & 0x0F;
 					} else {
-						DBG_88E("Error, All words disabled\n");
+						netdev_dbg(pAdapter->pnetdev,
+							   "Error, All words disabled\n");
 						efuse_addr++;
 						continue;
 					}
-- 
2.30.2

