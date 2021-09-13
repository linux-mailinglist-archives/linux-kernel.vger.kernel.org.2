Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8D05409BEA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346877AbhIMSNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346859AbhIMSNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:13:20 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3D03C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:12:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id b10so16267440ejg.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oCwFE7RlpohUzsVclO1Mfc+Ruua42hQz+WxuURxB9HE=;
        b=WGLUI6iJMH9jQlVCYNTZOF9jPZTwbEYXxrXeHFtHTzSszjec9rk/Pm4oFZlCy6W5Uo
         VwjPk95K1I45Nln6G+8FeuHl5Rwvc8JVcX5irMDesUdZFZI0nSmyEbc3PcHILHyfRRqK
         K92GvrxRDRVdbMaGxn1ty22tq5j9ZF1ssShv76e7vDqhlGVg6/xeoAtE7NnsS+vEl88o
         z5xDuAWKzdF6+3qI6nhOV7Df/UUGkTphyQbsLNDU1WC98fm0JhyBiipp9ixMM/ghhmMt
         lrcYubisMRW20FWN2MdXdDeNWjd3WHmMen9dk9RVJUbVDYi93Syf28uujFfHqJRLtTX/
         t6jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oCwFE7RlpohUzsVclO1Mfc+Ruua42hQz+WxuURxB9HE=;
        b=dSKiwgjbvizIq/zxK3lxLCxnGPWXqW+r2ScKYKJoLPz1Ud3qH7rlG0opgOM8E6hjNp
         yuYWgwGDfhOqxPupZ2Y7bDMPtNDMpOgMQpFJhJy/6REk+zFzJC+v/LFzMln+3rUqyR3R
         Cw6CsdWGu35TqrgsFZdhqnHLsY2/YCWj3p0pTw+N3w/sUbYuq/q3kNYGNEi2exoRowOl
         2vxZx1QS1CsaklmVhI3jFIIOg+UYpSvNusWwyY51fg6/pvwSEuIB3jloF/LbzlqDkSie
         RUzArWxqINoW0Dc/W5q6OgyaP35qtlOONcqJ1JoTHWVrzavvcVzlzGSsD9syOACsZfdM
         W1Eg==
X-Gm-Message-State: AOAM530O1SMHp+qHogfnmnVQ/UyySDw3FZG3tLSRQ5F2hob9PPsLn26A
        45D6E9cipKX7N/1PCaTSFtk=
X-Google-Smtp-Source: ABdhPJyhPIHx8GETrNWEFiqS/7fVcRNZ/AcdVbKZw3EntBkWbPKQyH09WsqBNB0zGdpXk6WjrQW+Wg==
X-Received: by 2002:a17:906:686:: with SMTP id u6mr13680121ejb.569.1631556722456;
        Mon, 13 Sep 2021 11:12:02 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id d25sm4258999edt.33.2021.09.13.11.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:12:02 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 11/18] staging: r8188eu: remove the helpers of usb_read_port_cancel()
Date:   Mon, 13 Sep 2021 20:09:55 +0200
Message-Id: <20210913181002.16651-12-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913181002.16651-1-fmdefrancesco@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
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

v3->v4:
        Split a patch into fourteen.
v2->v3:
        No changes.
v1->v2:
        No changes.

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

