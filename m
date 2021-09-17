Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 836F640F30C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 09:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239835AbhIQHUm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 03:20:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239102AbhIQHU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 03:20:28 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D311C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:06 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v5so26115864edc.2
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 00:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r4tfD0qLqmh0kcgDs81nzng46vV0A9oUGqCARNn/cG0=;
        b=hOfnQzjvvMzW+oONu0D7+C5IjZuCDAdcwN1wZhCUXdichyUAShOmzh8Yl+MLnHJsQy
         /6kwsko8Kf9mQmF73rBI2UGmf9wIhkN1anWfrKxybpOhnPQXNoSrwbZpLTj/dVAfa2c/
         uuOC7DujwGleGOoIhviFIZL4XOFR3YUQeHMMTS0mMkW1YKjX4VbEf51LlCVlJtb1Socs
         pwPv6sxWArufP28ri+qMKQ4C+cOHX/sCRcaHU9xiDnT27w28B/zoDvDnRlYnk1YRw+PT
         9AUY7n12tslph+AOM4DvchAJNU/GCuaKZ93a0k4TlfnuYn+ZjlBCRZ63/pcYP76AVo3d
         SdoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r4tfD0qLqmh0kcgDs81nzng46vV0A9oUGqCARNn/cG0=;
        b=SXw93A4XUlDVKBULpNtgt3n6JDsOBN+9V/3RCItCWEqNOAfbEu0kKbct2cfKZ3q3JB
         yIOe9z2Plnrpuen0v5nStt27LE5U5PuDdO20IBkBjLFfkBsgE/KufVXLYaGmsqS0jFmG
         azeEjE82mO6YoEdcmnEsOJCtpQ2zsSCXbywEoAIaOU9mt2yFH8NsuVyLg6P0cXA41UK+
         VON2vKgXj430Jf8OyyK3s3HvVls1ZGS7QUOSbJZvfgDFZo6QukU8c/tYr74OYcRV/QDI
         3RCnvU283yANStwdvtzNlqaLwmv4PARs96Km6RwO0c/bph5yfs07xSJ8EsC7dQwSGgFy
         FBYw==
X-Gm-Message-State: AOAM533FN4Z/9QJWDha3933fw84pFOoLKvtUS07oaav5Xa19kx6nndHy
        NpFT//Srshaz5DGO13ahJIQ=
X-Google-Smtp-Source: ABdhPJwrogZIEuAwB3Jli9clHQCHr2bzHoWN83qtxc10p2wM+7eRhHq0Sbv9kSgwjQnIhUWt5uPRig==
X-Received: by 2002:a17:906:d04d:: with SMTP id bo13mr10560978ejb.351.1631863144396;
        Fri, 17 Sep 2021 00:19:04 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id q19sm2297140edc.74.2021.09.17.00.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 00:19:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v7 03/19] staging: r8188eu: remove the helpers of rtw_read16()
Date:   Fri, 17 Sep 2021 09:18:21 +0200
Message-Id: <20210917071837.10926-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210917071837.10926-1-fmdefrancesco@gmail.com>
References: <20210917071837.10926-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_read16() and usb_read16() and embed their
code into the caller (i.e., rtw_read16()).

_rtw_read16() is a mere redefinition of rtw_read16() and it is unneeded.
usb_read16() was the only functions assigned to the (*_usb_read16) pointer,
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
index 4c43b6d00178..b5d1c8e52b22 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -34,20 +34,6 @@ jackson@realtek.com.tw
 #define rtw_cpu_to_le16(val)		cpu_to_le16(val)
 #define rtw_cpu_to_le32(val)		cpu_to_le32(val)
 
-u16 _rtw_read16(struct adapter *adapter, u32 addr)
-{
-	u16 r_val;
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct	intf_hdl		*pintfhdl = &pio_priv->intf;
-	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr);
-
-	_read16 = pintfhdl->io_ops._read16;
-
-	r_val = _read16(pintfhdl, addr);
-
-	return r_val;
-}
-
 u32 _rtw_read32(struct adapter *adapter, u32 addr)
 {
 	u32 r_val;
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 8389deeb1182..8b4fc014d93a 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -109,8 +109,10 @@ u8 rtw_read8(struct adapter *adapter, u32 addr)
 	return data;
 }
 
-static u16 usb_read16(struct intf_hdl *pintfhdl, u32 addr)
+u16 rtw_read16(struct adapter *adapter, u32 addr)
 {
+	struct io_priv *pio_priv = &adapter->iopriv;
+	struct intf_hdl *pintfhdl = &pio_priv->intf;
 	u16 wvalue = (u16)(addr & 0x0000ffff);
 	__le32 data;
 
@@ -540,7 +542,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 {
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
-	pops->_read16 = &usb_read16;
 	pops->_read32 = &usb_read32;
 	pops->_read_port = &usb_read_port;
 	pops->_write8 = &usb_write8;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 9dc32f7bcae8..527503d3ecc8 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -246,7 +246,7 @@ void _rtw_attrib_read(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_attrib_write(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 
 u8 rtw_read8(struct adapter *adapter, u32 addr);
-u16 _rtw_read16(struct adapter *adapter, u32 addr);
+u16 rtw_read16(struct adapter *adapter, u32 addr);
 u32 _rtw_read32(struct adapter *adapter, u32 addr);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 void _rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
@@ -267,7 +267,6 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 			     u8 *pmem, int timeout_ms);
 void _rtw_write_port_cancel(struct adapter *adapter);
 
-#define rtw_read16(adapter, addr) _rtw_read16((adapter), (addr))
 #define rtw_read32(adapter, addr) _rtw_read32((adapter), (addr))
 #define rtw_read_port(adapter, addr, cnt, mem)				\
 	_rtw_read_port((adapter), (addr), (cnt), (mem))
-- 
2.33.0

