Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43CEC40F30A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239418AbhIQHUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239175AbhIQHU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:20:26 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEFEC061766
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:02 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id v5so26115424edc.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yJI98UjymPB2rvnJRuU0V27mA2rDRntDh8d+JjB2Rmw=;
        b=MMiPrc46ARlv7GDAvvhk2rtNG189r6B0jfhKSTh02kf3yCuK87AdMvOBtJhkKEj5TF
         EKMc94e8DbSZ4FBx/QCACBWsQTNpFaPKWX8YwugyKDeHUU++FuS1qK1HG7jpTSViZxeU
         JkRs6yY+VXUolFOFdxN1QDwfC44tTMtkFvFzX2fVLBI1OnPQztLcex5vZ0uN+kIJ6vEU
         E9UK3fu6u0aByDYUKmKcDp6HQgWLgxmKEJUxwDAlfD9rWQ8UoNRV6mJ0hR7oHo7AwIj5
         rSJ4IDzzv4YuPxfMgeVppk/Gjfsl2C7+tG9i7s6L6MNrUyOlZdJ/A8bUgjvNT55qMsay
         4kmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yJI98UjymPB2rvnJRuU0V27mA2rDRntDh8d+JjB2Rmw=;
        b=3vENVCyEM0thTd9lkCRKrKszzs+26dBzS6ft1yYLmpVliMyiUzPBzZDDKrRz9CCyEa
         hYGeQY2dhUCJ2W6BZkl6vhNGX7gIITzGsRJpoxWZoWgrGB9Elr0ry4NQ384E5Jblsoyq
         UAH1GRumvRYKzjTej8DuKTuH+MPJLPXmdgbEDVxMEhVul/2AnVLrrvtmQXKWnj7FZY/S
         eFa0vvF394SLHr9/Rem4VVSXK1A3yVKGksTMyXqahgnsLpdGl17WoxpXcDMKL+VB4Bps
         csSDmzQOJEWqJhvBG0+80yJY0M0zL/fC+8S4SI9SzhAP+OpshhW5ndjl2z/JaWZFMTSW
         3png==
X-Gm-Message-State: AOAM531Bx/Xtfp0pzpp2cbO4KYV1bPnlNYeuSC9XXpoejIo5HMLfjRL5
        LpgSZ/ahErTj/1C+QRPPHX4=
X-Google-Smtp-Source: ABdhPJwu6psFNZZKxiCfKfzOXHc0YLevLdQHYHSoOZ4JmMPJuNP8bqAoyYJ7BCHQChQLINVhANjrOA==
X-Received: by 2002:a50:9d42:: with SMTP id j2mr11042350edk.330.1631863141018;
        Fri, 17 Sep 2021 00:19:01 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:19:00 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 02/19] staging: r8188eu: remove the helpers of rtw_read8()
Date:   Fri, 17 Sep 2021 09:18:20 +0200
Message-Id: <20210917071837.10926-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_read8() and usb_read8() and embed their
code into the caller (i.e., rtw_read8()).

_rtw_read8() is a mere redefinition of rtw_read8() and it is unneeded.
usb_read8() was the only functions assigned to (*_usb_read8) pointer,
so we can simply remove it and make a direct call.

This patch is in preparation for the _io_ops structure removal.

Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_io.c       | 14 --------------
 drivers/staging/r8188eu/hal/usb_ops_linux.c |  5 +++--
 drivers/staging/r8188eu/include/rtw_io.h    |  3 +--
 3 files changed, 4 insertions(+), 18 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index e6f377377ab2..4c43b6d00178 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -34,20 +34,6 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
 #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
 
-u8 _rtw_read8(struct adapter *adapter, u32 addr)
-{
-	u8 r_val;
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl *pintfhdl = &pio_priv->intf;
-	u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr);
-
-
-	_read8 = pintfhdl->io_ops._read8;
-	r_val = _read8(pintfhdl, addr);
-
-	return r_val;
-}
-
 u16 _rtw_read16(struct adapter *adapter, u32 addr)
 {
 	u16 r_val;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 7f30b00b3ce6..8389deeb1182 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -97,8 +97,10 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	return status;
 }
 
-static u8 usb_read8(struct intf_hdl *pintfhdl, u32 addr)
+u8 rtw_read8(struct adapter *adapter, u32 addr)
 {
+	struct io_priv *pio_priv = &adapter->iopriv;
+	struct intf_hdl *pintfhdl = &pio_priv->intf;
 	u16 wvalue = (u16)(addr & 0x0000ffff);
 	u8 data;
 
@@ -538,7 +540,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 {
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
-	pops->_read8 = &usb_read8;
 	pops->_read16 = &usb_read16;
 	pops->_read32 = &usb_read32;
 	pops->_read_port = &usb_read_port;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 5ef89c72cc83..9dc32f7bcae8 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -245,7 +245,7 @@ void unregister_intf_hdl(struct intf_hdl *pintfhdl);
 void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
-u8 _rtw_read8(struct adapter *adapter, u32 addr);
+u8 rtw_read8(struct adapter *adapter, u32 addr);
 u16 _rtw_read16(struct adapter *adapter, u32 addr);
 u32 _rtw_read32(struct adapter *adapter, u32 addr);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
@@ -267,7 +267,6 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 			     u8 *pmem, int timeout_ms);
 void _rtw_write_port_cancel(struct adapter *adapter);
 
-#define rtw_read8(adapter, addr) _rtw_read8((adapter), (addr))
 #define rtw_read16(adapter, addr) _rtw_read16((adapter), (addr))
 #define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))
 #define rtw_read_port(adapter, addr, cnt, mem)				\
-- 
2.33.0

