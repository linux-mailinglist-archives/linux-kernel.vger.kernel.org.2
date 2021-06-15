Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE2213A72EC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:18:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231888AbhFOATt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbhFOATg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:19:36 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C73F7C0613A3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:17:17 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id u14so18550553qvq.6
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q+dPttmMyciTXFOPYAL6qRFQp+Ymdpxi5WbFu60FU2k=;
        b=s78uR1lVFwa3TujWx8mIuXsy4oGdGP/Ikem45F74mXUOfW+8ym67QP2A1yX5i7iX2o
         ZrDDoCum2/Xyu+3DTLYondvqcQOiT0CTG/XnE+a1zwBoZQjAgOOm26FnNXTgkjX90zzK
         ZaghiJP+a7SU6tRV75p2wLgFG4rNkH0VdJpnTAHFJgB215GoltwsFf1eFz3zNZBmS1AU
         ph4c1vZ+G8aog6ee1kEPSSac+Jv+O3by7BtmbvxUJR5bQWlLNbeeaWEqYXuRYqOmW6IA
         NDxMHy4taphr/TuxFh0vV39vPAXmeQycR+iYbo5GR+ES6kXAz887WbBLFP4fDac713nN
         t72w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q+dPttmMyciTXFOPYAL6qRFQp+Ymdpxi5WbFu60FU2k=;
        b=f2So+vNLoaH6/h9CM6pGltKTZBHkycMkOHl2dz7ATVKoD7ie0Tuc5p9wOp9t12TZ3L
         bpmGdSUWHpY6fdUnzKLlc4X7y2qaw2+oTsdvjVpwd3VTUU53h67ZqaUDeB1Bgyej7SZa
         yo91d2SPwgUEIzs3gMI07A5SMVr3XIqzSOURTe0wYVKZ5qJzktVQKR4BCqhxEveEnbY8
         5F5rs/379JYtKcVBnsUg4+Hlm+1XSGehKMI0e/jr3HFWcaaT0DXFmiyzkfvy3RaLoHsf
         m1FbK0qQqIKWRIw4bZGj6OIAx1fAwpkIUirG8n1HtLOnHbHbTRKqrHOj5fJmyD0he/x3
         AZiw==
X-Gm-Message-State: AOAM532TndTERG7bdZ8k8T/DSnVZHHKxhmUq1g2a/kUlomc4C2ORjHPA
        H1zlitRK+fXPELtzPJfaPv9stHvnul8Debdb
X-Google-Smtp-Source: ABdhPJwZRSlcFD41ojPRmXX+48l7XQmESSIkr6YuHQ+Vuq5WGBgNXlWiSedRXCXMd9rss1ZcBDTrtg==
X-Received: by 2002:a05:6214:10e9:: with SMTP id q9mr1789498qvt.45.1623716236995;
        Mon, 14 Jun 2021 17:17:16 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:17:16 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 27/28] staging: rtl8188eu: remove core/rtw_debug.c
Date:   Tue, 15 Jun 2021 01:15:06 +0100
Message-Id: <20210615001507.1171-28-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove core/rtw_debug.c as all the functions contained within it are
entirely unused, and modify the Makefile to remove it as a build
requirement. Also remove the function declarations from
include/rtw_debug.h - this is part of an ongoing effort to purge
dead/unused code and cleanup this driver. This has the helpful
side effect of removing all DBG_88E macro calls within this file
as well.

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

