Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA80640CE91
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232427AbhIOVMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232324AbhIOVMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:12:43 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5A38C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v5so8455707edc.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUJSGDbnVaSW6IkF1hmLWYJune4CPKV8br/bhPi+Sss=;
        b=TQiMvAHwzjJHywiki8D9LBMFHZY2WFXJi71o9Vb+FdyNaLQqN41HWQseWWFZ0qiciS
         EYvgubqcvCHM7w07E6/bBV0UlTueJxcWR/K2KianhQ/Rj57cTBOfgacXdOkFwlKByigc
         a8fBpXaCLHRrgrT4rba8rbi92h4X0C/CKGqa2XezV9G9sPKpqoV3zD5uraRMmBfNA/Rw
         HH1oVDg8mo+0MQbBpkSnwa2+a4/mHNSw8PfO+2uITOgzyhyX7znWkkR7lxo2bcpndarD
         fgIqY3f5f52iQ8t2/cpCBG4v1C74EF1LstFjM2gMxcpbO3+PUnPADmKwDtc566tpF5/l
         /xpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UUJSGDbnVaSW6IkF1hmLWYJune4CPKV8br/bhPi+Sss=;
        b=SyR8FAe72OvaopDghkV33VstJSQndvJqdcqMzzmZ9QSy6uarLHI+8ZlpNcTDxtlyF0
         /G8pFvhOZdmkYUckplolthrNcq/i5uQOvHn6KIwMzDw+XHiW7qy5fNM4+3d2A02fuHcR
         DuX2X+/c7KxDGcoYWWrR1ny4elv5z17HyHGuCY/t7laJKgEa9voK27TjGJG3oumEdBgz
         qvhLJgd0V5oA19P7pgCE7IKs2CI2AuMI95CFeyvK6/e27RMHnl21W2pHZCu2wVPw/xZh
         GOgPrKEudaRzXinvV9j9+hKY/PbrzsbQsACkY/3/M5eI6n3IsCoDUjH9PsLCyO1wqQMQ
         SC4Q==
X-Gm-Message-State: AOAM531z5LzUWuZ8fny0LcVxakxo11VSqzcXyluW1wC3lhR8S2eDEHov
        3OzbUkm6wANam9gy/FLGwi8=
X-Google-Smtp-Source: ABdhPJyl40srkGXoFTQw32YRSiLmZuG/+dq4Nz7srWLi+Voz/dcQ6VanIbGVDrYGuXj3Qunuj++7Jg==
X-Received: by 2002:a05:6402:134d:: with SMTP id y13mr2218465edw.264.1631740282388;
        Wed, 15 Sep 2021 14:11:22 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:21 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 04/19] staging: r8188eu: remove the helpers of rtw_read32()
Date:   Wed, 15 Sep 2021 23:10:48 +0200
Message-Id: <20210915211103.18001-5-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915211103.18001-1-fmdefrancesco@gmail.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_readr32() and usb_read32() and embed their
code into the caller (i.e., rtw_read32()).

_rtw_read32() is a mere redefinition of rtw_read32() and it is unneeded.
usb_read32() was the only functions assigned to the (*_usb_read32) pointer,
so we can simply remove it and make a direct call.

This patch is in preparation for the _io_ops structure removal.

Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_io.c       | 14 --------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c |  5 +++--
 drivers/staging/r8188eu/include/rtw_io.h    |  3 +--
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index b5d1c8e52b22..cb24500cbc6e 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -34,20 +34,6 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
 #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
 
-u32 _rtw_read32(struct adapter *adapter, u32 addr)
-{
-	u32 r_val;
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	u32	(*_read32)(struct intf_hdl *pintfhdl, u32 addr);
-
-	_read32 = pintfhdl->io_ops._read32;
-
-	r_val = _read32(pintfhdl, addr);
-
-	return r_val;
-}
-
 int _rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 8b4fc014d93a..39fd9994787d 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -121,8 +121,10 @@ u16 rtw_read16(struct adapter *adapter, u32 addr)
 	return (u16)(le32_to_cpu(data) & 0xffff);
 }
 
-static u32 usb_read32(struct intf_hdl *pintfhdl, u32 addr)
+u32 rtw_read32(struct adapter *adapter, u32 addr)
 {
+	struct io_priv *pio_priv = &adapter->iopriv;
+	struct intf_hdl *pintfhdl = &pio_priv->intf;
 	u16 wvalue = (u16)(addr & 0x0000ffff);
 	__le32 data;
 
@@ -542,7 +544,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 {
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
-	pops->_read32 = &usb_read32;
 	pops->_read_port = &usb_read_port;
 	pops->_write8 = &usb_write8;
 	pops->_write16 = &usb_write16;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 527503d3ecc8..c53d9c8bd9a7 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -247,7 +247,7 @@ void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
 u8 rtw_read8(struct adapter *adapter, u32 addr);
 u16 rtw_read16(struct adapter *adapter, u32 addr);
-u32 _rtw_read32(struct adapter *adapter, u32 addr);
+u32 rtw_read32(struct adapter *adapter, u32 addr);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port_cancel(struct adapter *adapter);
@@ -267,7 +267,6 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 			     u8 *pmem, int timeout_ms);
 void _rtw_write_port_cancel(struct adapter *adapter);
 
-#define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))
 #define rtw_read_port(adapter, addr, cnt, mem)				\
 	_rtw_read_port((adapter), (addr), (cnt), (mem))
 #define rtw_read_port_cancel(adapter) _rtw_read_port_cancel((adapter))
-- 
2.33.0

