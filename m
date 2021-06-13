Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A74E93A5ACC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Jun 2021 00:42:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhFMWoL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Jun 2021 18:44:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbhFMWoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Jun 2021 18:44:09 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FB3C061766
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:41:56 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id n7so6189169wri.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Jun 2021 15:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KSeVsKOu6HH1o/MIL3siYbrI0hhkRLBWbeJlrOImcMY=;
        b=OM6v4dHTP9Ow+GDzH7XxcbKdJeAmiGi5Xfwj4pFP5dJmYd6vEO23sWZhDU+MGyhhZG
         NzWSvAFVOdbFhoYEmS6ToHXNgosrTkZ3bKrd8fHzCtdvE2q6hlClEgqOdAX3J86I9+Ul
         hccdK/JeEcvrUc2YGWImAMWMsZtValirjeqfQbdR3I1MdsHO3hC3DCjIe98N+duJA4tr
         r9C0zc9NtxQboYyVZ/EQquRZu1kUS2ngmW1XxTQyOdH3rwFlNzCHQB9VkLz2L0OqucnC
         sQ42HuYQg9CeovOEe/DA9m18s3jrgl1PoSY/la+9mmmUQuWde+xhIR6uuToAxwQ2hiZs
         3DtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KSeVsKOu6HH1o/MIL3siYbrI0hhkRLBWbeJlrOImcMY=;
        b=hlJtLwq0Nur7S7XkU5QhlK5J51BLuceIh7DvRm0SV21VpzVjm9MoAwaDohyhn6afCL
         pHjwVN0QCt9NYkacTwVC/yXeVUK2dJ8FvX6DpEtLJrCzZCbScDHF21JFIf4gbDDO/sll
         a8WSeRyg+G3MS20uU0kaumj7NkDNxnnLD5jIqQRBpF+FbxuPzE3t3nerhMN4O8BQvBlk
         Z6vPkbz0uVw2tFqsQWPjddrOlOD0+d9EQON6HT6/33G6veKsXO8EPeJ9RZsize4Jy0YO
         65YVc2Juinm+/VboMLG6E0E56RIdI/bV0ULfQEZlVsWUNHJhrLB+bQ5BF9qUuhdHSsZI
         AYAw==
X-Gm-Message-State: AOAM533vOIbwmOhRgV3pudAqusRLOpW6Pn7nizpQhiNGPXPBE89gUDHN
        VqPPm9xMEyffh2xagO/NZALD6w==
X-Google-Smtp-Source: ABdhPJwggUecIQku6gTscoNboWvWEBqZm8KMRY4oJkDzdvSmaEcoSsqU/ed+nuYUXjby1HOmWs7GFw==
X-Received: by 2002:a5d:694b:: with SMTP id r11mr15767286wrw.168.1623624114500;
        Sun, 13 Jun 2021 15:41:54 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id w11sm15120618wrv.89.2021.06.13.15.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Jun 2021 15:41:54 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, insafonov@gmail.com,
        linux@roeck-us.net, straube.linux@gmail.com, liushixin2@huawei.com,
        gustavoars@kernel.org, christophe.jaillet@wanadoo.fr,
        yepeilin.cs@gmail.com, dan.carpenter@oracle.com, martin@kaiser.cx,
        simon.fodin@gmail.com, romain.perier@gmail.com,
        apais@linux.microsoft.com, mh12gx2825@gmail.com
Subject: [PATCH 3/3] staging: rtl8188eu: remove core/rtw_debug.c
Date:   Sun, 13 Jun 2021 23:41:47 +0100
Message-Id: <20210613224147.1045-4-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210613224147.1045-1-phil@philpotter.co.uk>
References: <20210613224147.1045-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove core/rtw_debug.c and its associated definitions in
include/rtw_debug.h, as well as modifying the makefile. This file's
functions may have been intended to be hooked up in procfs, but as
they are unused, they are dead code and better to remove.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/Makefile            |   1 -
 drivers/staging/rtl8188eu/core/rtw_debug.c    | 187 ------------------
 drivers/staging/rtl8188eu/include/rtw_debug.h |  25 ---
 3 files changed, 213 deletions(-)
 delete mode 100644 drivers/staging/rtl8188eu/core/rtw_debug.c

diff --git a/drivers/staging/rtl8188eu/Makefile b/drivers/staging/rtl8188eu/Makefile
index 7da911c2ab89..28b936e8be0a 100644
--- a/drivers/staging/rtl8188eu/Makefile
+++ b/drivers/staging/rtl8188eu/Makefile
@@ -2,7 +2,6 @@
 r8188eu-y :=				\
 		core/rtw_ap.o		\
 		core/rtw_cmd.o		\
-		core/rtw_debug.o	\
 		core/rtw_efuse.o	\
 		core/rtw_ieee80211.o	\
 		core/rtw_ioctl_set.o	\
diff --git a/drivers/staging/rtl8188eu/core/rtw_debug.c b/drivers/staging/rtl8188eu/core/rtw_debug.c
deleted file mode 100644
index 1060837fe463..000000000000
--- a/drivers/staging/rtl8188eu/core/rtw_debug.c
+++ /dev/null
@@ -1,187 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-#define _RTW_DEBUG_C_
-
-#include <rtw_debug.h>
-#include <usb_ops_linux.h>
-
-int proc_get_drv_version(char *page, char **start,
-			 off_t offset, int count,
-			 int *eof, void *data)
-{
-	int len = 0;
-
-	len += scnprintf(page + len, count - len, "%s\n", DRIVERVERSION);
-
-	*eof = 1;
-	return len;
-}
-
-int proc_get_write_reg(char *page, char **start,
-		       off_t offset, int count,
-		       int *eof, void *data)
-{
-	*eof = 1;
-	return 0;
-}
-
-int proc_set_write_reg(struct file *file, const char __user *buffer,
-		       unsigned long count, void *data)
-{
-	struct net_device *dev = data;
-	struct adapter *padapter = netdev_priv(dev);
-	char tmp[32];
-	u32 addr, val, len;
-
-	if (count < 3) {
-		DBG_88E("argument size is less than 3\n");
-		return -EFAULT;
-	}
-
-	if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {
-		int num = sscanf(tmp, "%x %x %x", &addr, &val, &len);
-
-		if (num !=  3) {
-			DBG_88E("invalid write_reg parameter!\n");
-			return count;
-		}
-		switch (len) {
-		case 1:
-			usb_write8(padapter, addr, (u8)val);
-			break;
-		case 2:
-			usb_write16(padapter, addr, (u16)val);
-			break;
-		case 4:
-			usb_write32(padapter, addr, val);
-			break;
-		default:
-			DBG_88E("error write length =%d", len);
-			break;
-		}
-	}
-	return count;
-}
-
-static u32 proc_get_read_addr = 0xeeeeeeee;
-static u32 proc_get_read_len = 0x4;
-
-int proc_get_read_reg(char *page, char **start,
-		      off_t offset, int count,
-		      int *eof, void *data)
-{
-	struct net_device *dev = data;
-	struct adapter *padapter = netdev_priv(dev);
-
-	int len = 0;
-
-	if (proc_get_read_addr == 0xeeeeeeee) {
-		*eof = 1;
-		return len;
-	}
-
-	switch (proc_get_read_len) {
-	case 1:
-		len += scnprintf(page + len, count - len, "usb_read8(0x%x)=0x%x\n",
-				 proc_get_read_addr, usb_read8(padapter, proc_get_read_addr));
-		break;
-	case 2:
-		len += scnprintf(page + len, count - len, "usb_read16(0x%x)=0x%x\n",
-				 proc_get_read_addr, usb_read16(padapter, proc_get_read_addr));
-		break;
-	case 4:
-		len += scnprintf(page + len, count - len, "usb_read32(0x%x)=0x%x\n",
-				 proc_get_read_addr, usb_read32(padapter, proc_get_read_addr));
-		break;
-	default:
-		len += scnprintf(page + len, count - len, "error read length=%d\n",
-				 proc_get_read_len);
-		break;
-	}
-
-	*eof = 1;
-	return len;
-}
-
-int proc_set_read_reg(struct file *file, const char __user *buffer,
-		      unsigned long count, void *data)
-{
-	char tmp[16];
-	u32 addr, len;
-
-	if (count < 2) {
-		DBG_88E("argument size is less than 2\n");
-		return -EFAULT;
-	}
-
-	if (buffer && !copy_from_user(tmp, buffer, sizeof(tmp))) {
-		int num = sscanf(tmp, "%x %x", &addr, &len);
-
-		if (num !=  2) {
-			DBG_88E("invalid read_reg parameter!\n");
-			return count;
-		}
-
-		proc_get_read_addr = addr;
-
-		proc_get_read_len = len;
-	}
-
-	return count;
-}
-
-int proc_get_adapter_state(char *page, char **start,
-			   off_t offset, int count,
-			   int *eof, void *data)
-{
-	struct net_device *dev = data;
-	struct adapter *padapter = netdev_priv(dev);
-	int len = 0;
-
-	len += scnprintf(page + len, count - len, "bSurpriseRemoved=%d, bDriverStopped=%d\n",
-			 padapter->bSurpriseRemoved,
-			 padapter->bDriverStopped);
-
-	*eof = 1;
-	return len;
-}
-
-int proc_get_best_channel(char *page, char **start,
-			  off_t offset, int count,
-			  int *eof, void *data)
-{
-	struct net_device *dev = data;
-	struct adapter *padapter = netdev_priv(dev);
-	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
-	int len = 0;
-	u32 i, best_channel_24G = 1, index_24G = 0;
-
-	for (i = 0; pmlmeext->channel_set[i].ChannelNum != 0; i++) {
-		if (pmlmeext->channel_set[i].ChannelNum == 1)
-			index_24G = i;
-	}
-
-	for (i = 0; pmlmeext->channel_set[i].ChannelNum != 0; i++) {
-		/*  2.4G */
-		if (pmlmeext->channel_set[i].ChannelNum == 6) {
-			if (pmlmeext->channel_set[i].rx_count < pmlmeext->channel_set[index_24G].rx_count) {
-				index_24G = i;
-				best_channel_24G = pmlmeext->channel_set[i].ChannelNum;
-			}
-		}
-
-		/*  debug */
-		len += scnprintf(page + len, count - len, "The rx cnt of channel %3d = %d\n",
-				 pmlmeext->channel_set[i].ChannelNum,
-				 pmlmeext->channel_set[i].rx_count);
-	}
-
-	len += scnprintf(page + len, count - len, "best_channel_24G = %d\n", best_channel_24G);
-
-	*eof = 1;
-	return len;
-}
diff --git a/drivers/staging/rtl8188eu/include/rtw_debug.h b/drivers/staging/rtl8188eu/include/rtw_debug.h
index 7e2be1ba80fb..2fd6151bf698 100644
--- a/drivers/staging/rtl8188eu/include/rtw_debug.h
+++ b/drivers/staging/rtl8188eu/include/rtw_debug.h
@@ -85,29 +85,4 @@ extern u32 GlobalDebugLevel;
 		}							\
 	} while (0)
 
-int proc_get_drv_version(char *page, char **start,
-			 off_t offset, int count,
-			 int *eof, void *data);
-
-int proc_get_write_reg(char *page, char **start,
-		       off_t offset, int count,
-		       int *eof, void *data);
-
-int proc_set_write_reg(struct file *file, const char __user *buffer,
-		       unsigned long count, void *data);
-int proc_get_read_reg(char *page, char **start,
-		      off_t offset, int count,
-		      int *eof, void *data);
-
-int proc_set_read_reg(struct file *file, const char __user *buffer,
-		      unsigned long count, void *data);
-
-int proc_get_adapter_state(char *page, char **start,
-			   off_t offset, int count,
-			   int *eof, void *data);
-
-int proc_get_best_channel(char *page, char **start,
-			  off_t offset, int count,
-			  int *eof, void *data);
-
 #endif	/* __RTW_DEBUG_H__ */
-- 
2.30.2

