Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC5C40F30E
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239988AbhIQHUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:20:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239280AbhIQHUa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:20:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D4EBC061764
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:08 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id c22so26413510edn.12
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wl11DlKlNyvhQ8erJMZQ1RQ0qDLlZusNJJjYA1Hcr3A=;
        b=Pr0vngvFUri3QPkHko5YI9B49OzXFsUQd4PNO2EvnI8d1EunfyxaArxCx7xEAkrZI7
         z2fENpmVfmJHAkXCynBjoyjBS9ksBRNW5M8OVQtZlqzKgimclnoGqDVtrYMUe8F/EYHB
         /+LugVLejjs2ZDxecRp9qgQZzd6AiiYZxmSb7tMgqK4xmuFYfmZvjFdW9qz1GA0pyXXI
         c7Q9j13SgrlPb36mdn+t7wBKsgmE1tF0wqTLbBBbqU2dX/I4vpjN+2DU+eUzj5txCtjN
         MtyUWF3I1ZGE9DQ4RbElRNMyVD/0TeiCXmdnyayTRopi5B0onOXnu/AV89VkOzuYB103
         RgCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wl11DlKlNyvhQ8erJMZQ1RQ0qDLlZusNJJjYA1Hcr3A=;
        b=Ix6/g7jQcjSDG4OCLA1RBL/A9OnpnFb5qNt76TP4ntQAz1BkMv2YwAZXof4ZFxA1OL
         qfx/abFs/wVdh87Q6nAmnJezlER0EycGSxZz/rX6toGMvseta0hAr4hTkFlyCHzyaTSv
         Xr3aLPRexaOhS9NGXpXTCsVQRkf5I8GC+hE3FfRhMmqoFVBGjg9kyEY9NffYM21cmd7D
         UM2rol04skiRkzCTSJhCJG0NX/ualRe2MM8DX/hpsGKxKY84tlNz5cbr1iUgi6e9fWNN
         ODM/QOScsbAR/IQopucPsZPI/zH/dXgtH8peUnrfiu5VI6v7PJlmHq2o5UKbdvCJtpfu
         q+DQ==
X-Gm-Message-State: AOAM530B4Ln5caFtCRv2fTMRUPYTdu5qFhCr8b4RpdLMwP5+OEwMK6iQ
        ii28lbpWSw+e1hYWA7YEMwI=
X-Google-Smtp-Source: ABdhPJwcdJFIonQKGRMHMHrG7ZQSkl4JaGbDJB8HvtwOfECRHq0ad0QLva7kfrMSI4xA7rvRMROKtQ==
X-Received: by 2002:aa7:c588:: with SMTP id g8mr10488568edq.331.1631863147008;
        Fri, 17 Sep 2021 00:19:07 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:19:06 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 05/19] staging: r8188eu: remove the helpers of usb_write8()
Date:   Fri, 17 Sep 2021 09:18:23 +0200
Message-Id: <20210917071837.10926-6-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_write8() and usb_write8() and embed their
code into the caller (i.e., rtw_write8()).

_rtw_write8() is a mere redefinition of rtw_write8() and it is unneeded.
usb_write8() was the only functions assigned to the (*_usb_write8) pointer,
so we can simply remove it and make a direct call.

This patch is in preparation for the _io_ops structure removal.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_io.c       | 15 ---------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 10 +++++++---
 drivers/staging/r8188eu/include/rtw_io.h    |  4 +---
 3 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index cb24500cbc6e..69ab6e24a4b7 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -34,21 +34,6 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
 #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
 
-int _rtw_write8(struct adapter *adapter, u32 addr, u8 val)
-{
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	int (*_write8)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
-	int ret;
-
-	_write8 = pintfhdl->io_ops._write8;
-
-	ret = _write8(pintfhdl, addr, val);
-
-
-	return RTW_STATUS_CODE(ret);
-}
-
 int _rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 {
 	struct io_priv *pio_priv = &adapter->iopriv;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 39fd9994787d..69e64863a5d1 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -133,11 +133,16 @@ u32 rtw_read32(struct adapter *adapter, u32 addr)
 	return le32_to_cpu(data);
 }
 
-static int usb_write8(struct intf_hdl *pintfhdl, u32 addr, u8 val)
+int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
+	struct io_priv *pio_priv = &adapter->iopriv;
+	struct intf_hdl *pintfhdl = &pio_priv->intf;
 	u16 wvalue = (u16)(addr & 0x0000ffff);
+	int ret;
+
+	ret = usbctrl_vendorreq(pintfhdl, wvalue, &val, 1, REALTEK_USB_VENQT_WRITE);
 
-	return usbctrl_vendorreq(pintfhdl, wvalue, &val, 1, REALTEK_USB_VENQT_WRITE);
+	return RTW_STATUS_CODE(ret);
 }
 
 static int usb_write16(struct intf_hdl *pintfhdl, u32 addr, u16 val)
@@ -545,7 +550,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
 	pops->_read_port = &usb_read_port;
-	pops->_write8 = &usb_write8;
 	pops->_write16 = &usb_write16;
 	pops->_write32 = &usb_write32;
 	pops->_writeN = &usb_writeN;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index c53d9c8bd9a7..3b229027f094 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -252,7 +252,7 @@ void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port_cancel(struct adapter *adapter);
 
-int _rtw_write8(struct adapter *adapter, u32 addr, u8 val);
+int rtw_write8(struct adapter *adapter, u32 addr, u8 val);
 int _rtw_write16(struct adapter *adapter, u32 addr, u16 val);
 int _rtw_write32(struct adapter *adapter, u32 addr, u32 val);
 int _rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata);
@@ -271,8 +271,6 @@ void _rtw_write_port_cancel(struct adapter *adapter);
 	_rtw_read_port((adapter), (addr), (cnt), (mem))
 #define rtw_read_port_cancel(adapter) _rtw_read_port_cancel((adapter))
 
-#define  rtw_write8(adapter, addr, val)					\
-	_rtw_write8((adapter), (addr), (val))
 #define  rtw_write16(adapter, addr, val)				\
 	_rtw_write16((adapter), (addr), (val))
 #define  rtw_write32(adapter, addr, val)				\
-- 
2.33.0

