Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC44440CE9A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 23:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232990AbhIOVNc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 17:13:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232349AbhIOVNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 17:13:00 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F5FCC0613E8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h17so8539041edj.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 14:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20wywgQEOo0egoQmBSEpanb7Vzi97onrpQZGv5F4kZg=;
        b=cZBxDO7xKYXTHeOTM24VPRcITX8W36hO/h4TCwVKO4sdHiH99zoRdmyxYZoXZoKKg0
         wgOuNmj+W+wFVhDIJCZ6R7PzHmcit5/zsvlPrjxMuYx5y0DXIPZfRD1oHUNRzkrTlx0D
         QTNzY6ENcBeXtRpgAlBmTAICY1QGoJwR3EIEcTxBFClU2Mx5SdMMPXRwnnSryd/t24Ka
         XXhGcZzzsp5g88f76GtrO21yl+vOutHVMcz8YqC7i5OjSDBhfFoB8GD6UkcZXXGA2bYk
         ///sgb9KoiV/w5UfzUEdOcIQDjm6/evevqaYcUjc6LL/jNuFaH0goxX+hVksGt4KAqen
         GlYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20wywgQEOo0egoQmBSEpanb7Vzi97onrpQZGv5F4kZg=;
        b=QMfJYm7VbdOH0u+cnWt+UxwAvbGwzVo1zRSsok+Hfj5nkae6yWCjW1jZd+2sQ0iblL
         Nny+b0mN0ZHWQ7Y5s8rTagoEhr6UoTunKRvD+qgtMlEbHwoZWPMoGTpIBzxAtu+elqA+
         ysrM1/gpCthLHvWpk072bVdkM3HnDNcI8BpRLnBgbwJQUBkP9CVGQblZmH3ZscQU2arH
         POC0JOzf0SOmKT7tPGbSnp0hpUVOZfshSu6Qi5IZBtmELtUKOH1y22Hxvqmo1AD3Y+th
         N3NU0AfToEVp0enb/FSYy96DrQiBPMzjW+1dEuvKVm9AWMOkVEbsQC5ChviWX9RtDGxd
         JBsA==
X-Gm-Message-State: AOAM5313dXWhJhkbGDrkAcXvnlBJpGRtDNrAQjCXN0Ux8rR52ugM3due
        WMuIzx7DMC5qXw3CCB7KJtc=
X-Google-Smtp-Source: ABdhPJy0I2v9gtVf9CWF6UyexPC9jXNGXGTdHLOWPaleaMRcL5UM+Tw2pC+GAFV++66NF71ZUngwpw==
X-Received: by 2002:aa7:cdd1:: with SMTP id h17mr2351062edw.346.1631740295770;
        Wed, 15 Sep 2021 14:11:35 -0700 (PDT)
Received: from localhost.localdomain (host-95-235-105-169.retail.telecomitalia.it. [95.235.105.169])
        by smtp.gmail.com with ESMTPSA id t3sm511618edt.61.2021.09.15.14.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 14:11:35 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v6 14/19] staging: remove struct _io_ops
Date:   Wed, 15 Sep 2021 23:10:58 +0200
Message-Id: <20210915211103.18001-15-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915211103.18001-1-fmdefrancesco@gmail.com>
References: <20210915211103.18001-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pavel Skripkin <paskripkin@gmail.com>

Finally struct _io_ops is unused, so remove it.

Co-developed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c |  6 -----
 drivers/staging/r8188eu/include/rtw_io.h    | 25 ---------------------
 drivers/staging/r8188eu/include/usb_ops.h   |  2 --
 3 files changed, 33 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 2516cfc464a9..117213c9f984 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -558,12 +558,6 @@ void rtl8188eu_xmit_tasklet(unsigned long priv)
 	}
 }
 
-void rtl8188eu_set_intf_ops(struct _io_ops	*pops)
-{
-
-	memset((u8 *)pops, 0, sizeof(struct _io_ops));
-}
-
 void rtl8188eu_set_hw_type(struct adapter *adapt)
 {
 	adapt->chip_type = RTL8188E;
diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 2b9b64f1ac80..c6a078210eeb 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -84,30 +84,6 @@ struct intf_priv;
 struct intf_hdl;
 struct io_queue;
 
-struct _io_ops {
-	u8 (*_read8)(struct intf_hdl *pintfhdl, u32 addr);
-	u16 (*_read16)(struct intf_hdl *pintfhdl, u32 addr);
-	u32 (*_read32)(struct intf_hdl *pintfhdl, u32 addr);
-	int (*_write8)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
-	int (*_write16)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
-	int (*_write32)(struct intf_hdl *pintfhdl, u32 addr, u32 val);
-	int (*_writeN)(struct intf_hdl *pintfhdl, u32 addr, u32 length,
-		       u8 *pdata);
-	int (*_write8_async)(struct intf_hdl *pintfhdl, u32 addr, u8 val);
-	int (*_write16_async)(struct intf_hdl *pintfhdl, u32 addr, u16 val);
-	int (*_write32_async)(struct intf_hdl *pintfhdl, u32 addr, u32 val);
-	void (*_read_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
-			  u8 *pmem);
-	void (*_write_mem)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
-			   u8 *pmem);
-	u32 (*_read_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
-			  u8 *pmem);
-	u32 (*_write_port)(struct intf_hdl *pintfhdl, u32 addr, u32 cnt,
-			   u8 *pmem);
-	void (*_read_port_cancel)(struct intf_hdl *pintfhdl);
-	void (*_write_port_cancel)(struct intf_hdl *pintfhdl);
-};
-
 struct io_req {
 	struct list_head list;
 	u32	addr;
@@ -125,7 +101,6 @@ struct io_req {
 struct	intf_hdl {
 	struct adapter *padapter;
 	struct dvobj_priv *pintf_dev;
-	struct _io_ops	io_ops;
 };
 
 struct reg_protocol_rd {
diff --git a/drivers/staging/r8188eu/include/usb_ops.h b/drivers/staging/r8188eu/include/usb_ops.h
index c53cc54b6b87..1939b781b097 100644
--- a/drivers/staging/r8188eu/include/usb_ops.h
+++ b/drivers/staging/r8188eu/include/usb_ops.h
@@ -21,8 +21,6 @@
 
 void rtl8188eu_set_hw_type(struct adapter *padapter);
 #define hal_set_hw_type rtl8188eu_set_hw_type
-void rtl8188eu_set_intf_ops(struct _io_ops *pops);
-#define usb_set_intf_ops rtl8188eu_set_intf_ops
 
 /*
  * Increase and check if the continual_urb_error of this @param dvobjprivei
-- 
2.33.0

