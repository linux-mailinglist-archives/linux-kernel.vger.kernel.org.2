Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CB440CE95
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhIOVNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232590AbhIOVMz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:12:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29482C0613E1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:33 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id g21so8572292edw.4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lrOb1WvonI/5W8DvRhrpAXx8lPRifSOpe2+CoRGYEhw=;
        b=m0gx1huGcFepDDAhhA5pz4+A1pt7/Gl/L/dQZ6zD6lA/2SkVbW6HCMVU18s2UThNfS
         aZVTUnrJtz74Q21Rgv5rGoO7+c9gaVKQR9LELrdqCnipSab1PZ1588ezarEKrstdwXBv
         T6q1hk8Drqrd7Y0J3odYIHHBjyUnQV19J1GPmpY+LVQox6eGbF+/WRX4C4fGogxoL19D
         N7bWBIPCYx2NaAif6U6MdJI9t89pIp/t5cm6Jh81efX/tonf2m15oTomftv3yRmkYjKi
         qHif/bL/P1+/aN/MIlPWoO9el9RSMdtrv0SfRx4SDdPWxhi4Qlm75m5haiFYrcNWyWjp
         fP9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lrOb1WvonI/5W8DvRhrpAXx8lPRifSOpe2+CoRGYEhw=;
        b=wGbSNlldQ24bcq12OrC7Z+AOZJx6Se0yLd70oPv6dNmoGKVyVHtPH0NsXi7HHGdt8l
         ZhAcoUHybIPoRIezLG7OAHvZqVBbRxWRIZ5k6WvFtyf2+PyMWEK2spJSO1t2NrA371aI
         VkzC4adnN/5KI3GCtmKm+TAOA+0rRnyLPXROVL8jxgWGtpVe9Uu0kXY62H3zjAZF9vCb
         aFwFQ6jYKDxdqDF2f1efWHEl1Gqqz2l6jwMmf3HzVGAWasHYlWgqv546Uj9RXMOgnMg4
         2PEO2KpK1Xp6JsdPomLbuoBh4r7Ly8oAwI8OvF8C1W7yrhV2gNUJ9Ho81b+M2560EcCo
         YV0g==
X-Gm-Message-State: AOAM533nb9o/mLGWv9w/X2LQvIFFkJieL6kCR4kPxn2QBi1C6tIAOICt
        bHb/j4UaQTaSuh1g939hUXc=
X-Google-Smtp-Source: ABdhPJyY/7rAI5skBxNrlX+k3QzD4Uitve1B+kjF2iQWCul6Cv2EH0ltiFNp449ygvQFE1qLU/WnBw==
X-Received: by 2002:a50:eb4a:: with SMTP id z10mr2288256edp.142.1631740291781;
        Wed, 15 Sep 2021 14:11:31 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:31 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 11/19] staging: r8188eu: remove the helpers of usb_read_port_cancel()
Date:   Wed, 15 Sep 2021 23:10:55 +0200
Message-Id: <20210915211103.18001-12-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915211103.18001-1-fmdefrancesco@gmail.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Remove the unnecessary _rtw_read_port_cancel() and usb_read_port_cancel()
and embed their code into the caller (i.e., rtw_read_port_cancel()).

_rtw_read_port_cancel() is a mere redefinition of rtw_read_port_cancel()
and it is unneeded. usb_read_port_cancel() was the only functions assigned
to the (*_usb_read_port_cancel) pointer, so we can simply remove it and
make a direct call.

This patch is in preparation for the _io_ops structure removal.

Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_io.c           | 11 -----------
 drivers/staging/r8188eu/hal/usb_ops_linux.c     |  1 -
 drivers/staging/r8188eu/include/rtw_io.h        |  3 +--
 drivers/staging/r8188eu/include/usb_ops_linux.h |  2 --
 drivers/staging/r8188eu/os_dep/usb_ops_linux.c  |  6 ++----
 5 files changed, 3 insertions(+), 20 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_io.c b/drivers/staging/r8188eu/core/rtw_io.c
index 3a5e9dbfcb12..a57742057a65 100644
--- a/drivers/staging/r8188eu/core/rtw_io.c
+++ b/drivers/staging/r8188eu/core/rtw_io.c
@@ -75,17 +75,6 @@ int _rtw_write32_async(struct adapter *adapter, u32 addr, u32 val)
 	return RTW_STATUS_CODE(ret);
 }
 
-void _rtw_read_port_cancel(struct adapter *adapter)
-{
-	void (*_read_port_cancel)(struct intf_hdl *pintfhdl);
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-
-	_read_port_cancel = pintfhdl->io_ops._read_port_cancel;
-
-	if (_read_port_cancel)
-		_read_port_cancel(pintfhdl);
-}
 
 u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem, int timeout_ms)
 {
diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 4fea21c0f7af..1865a26142bc 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -562,7 +562,6 @@ void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
 {
 
 	memset((u8 *)pops, 0, sizeof(struct _io_ops));
-	pops->_read_port_cancel = &usb_read_port_cancel;
 	pops->_write_port_cancel = &usb_write_port_cancel;
 
 }
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index f2b1978b6e80..56e17e2a7ee2 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -250,7 +250,7 @@ u16 rtw_read16(struct adapter *adapter, u32 addr);
 u32 rtw_read32(struct adapter *adapter, u32 addr);
 void _rtw_read_mem(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
 u32 rtw_read_port(struct adapter *adapter, u32 addr, u32 cnt, u8 *pmem);
-void _rtw_read_port_cancel(struct adapter *adapter);
+void rtw_read_port_cancel(struct adapter *adapter);
 
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val);
 int rtw_write16(struct adapter *adapter, u32 addr, u16 val);
@@ -267,7 +267,6 @@ u32 _rtw_write_port_and_wait(struct adapter *adapter, u32 addr, u32 cnt,
 			     u8 *pmem, int timeout_ms);
 void _rtw_write_port_cancel(struct adapter *adapter);
 
-#define rtw_read_port_cancel(adapter) _rtw_read_port_cancel((adapter))
 
 #define rtw_write8_async(adapter, addr, val)				\
 	_rtw_write8_async((adapter), (addr), (val))
diff --git a/drivers/staging/r8188eu/include/usb_ops_linux.h b/drivers/staging/r8188eu/include/usb_ops_linux.h
index bdc596fe5854..186c6b7628dc 100644
--- a/drivers/staging/r8188eu/include/usb_ops_linux.h
+++ b/drivers/staging/r8188eu/include/usb_ops_linux.h
@@ -28,8 +28,6 @@
 
 unsigned int ffaddr2pipehdl(struct dvobj_priv *pdvobj, u32 addr);
 
-void usb_read_port_cancel(struct intf_hdl *pintfhdl);
-
 void usb_write_port_cancel(struct intf_hdl *pintfhdl);
 
 #endif
diff --git a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
index 36ef06f88fdd..a98ffdf92ed4 100644
--- a/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/os_dep/usb_ops_linux.c
@@ -31,12 +31,10 @@ struct zero_bulkout_context {
 	void *padapter;
 };
 
-void usb_read_port_cancel(struct intf_hdl *pintfhdl)
+void rtw_read_port_cancel(struct adapter *padapter)
 {
 	int i;
-	struct recv_buf *precvbuf;
-	struct adapter	*padapter = pintfhdl->padapter;
-	precvbuf = (struct recv_buf *)padapter->recvpriv.precv_buf;
+	struct recv_buf *precvbuf = (struct recv_buf *)padapter->recvpriv.precv_buf;
 
 	DBG_88E("%s\n", __func__);
 
-- 
2.33.0

