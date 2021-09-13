Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3D8409BEE
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:12:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346972AbhIMSN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:13:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346880AbhIMSNy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:13:54 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478DEC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:12:38 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id n10so15675574eda.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ECq1ge6/bnVovuHw7hJS+s7iJ6k9k30Dw3V5gtmVFLc=;
        b=Vuv3MGcfwkWgWYz8QH6QPx7qM5Fn0m2HDUIkJC0DfJHbsubGU/GbF5Fainnpws0N4f
         8fD1WMAKaJ7c5NFcc18ZWog8QwbksfyHSqcWfEDT+w98hyWvZLXMKtYSj9vM7aFbEB9x
         IahbQC010Yhowo5onWFouTMZnNuO2mf4EukBKz7ce4Me2RQhd+C/r5XJQLyN/CHdcXLJ
         r8osOeIEfDLPx2/lhgyOBbWx7TtIMfUZsYiT4C+LcJTgaRVfrKx89ZILfKFU7+/rjoqf
         ScmhsBhp9FX6nGjOVAlLhglMWCeJ0uuu2is+jqDKq3vvmAF25VPc1ffhWwllrfG/q/7v
         Co7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ECq1ge6/bnVovuHw7hJS+s7iJ6k9k30Dw3V5gtmVFLc=;
        b=H2IU7t5JASDjzyG/eHZmwuKX74FfGaMtPAUwckYOgoil+PRshaKfYdK7fgMrVJidRx
         8rw4eAggS2rca3G1kAk/fjOii1toX1dUrmsmoLZnHAWsSlyTV2toAMW7RpXnosPEOcA0
         sVEUxT24U7YLCV93e72QoSVlq+TjVILeTFJNUfaKubIcOurOPgT++vzAuqMyD7v8fmw+
         c9AUiYjtFygoku9Wj+Ett9mGKT6dE5+N4VQGeyuA/Y8LXxsdX/8elr+1udwMGvZyVwTR
         pJdzyfLdqBMW2vCXdPabRhIdLfyYHICpSR54tgskovL0mT+sbGfQUds/SGE+LSA2Vttn
         /PsQ==
X-Gm-Message-State: AOAM530jDJsuQbl4C3AY0SpdPx+3xoUdYONzsLWb1JJObyL7ROjJR/V3
        oVaA8DYyAwt5lAye1MSohhU=
X-Google-Smtp-Source: ABdhPJzBh8T+FuTXAkJNuTnYfE3ylseMzg5NQHEvJevRpZD5ntPz+qtb2YB72UMDoaVxoF8BFXl36g==
X-Received: by 2002:a05:6402:4cf:: with SMTP id n15mr14242384edw.269.1631556756880;
        Mon, 13 Sep 2021 11:12:36 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id d25sm4258999edt.33.2021.09.13.11.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:12:36 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     Pavel Skripkin <paskripkin@gmail.com>,
        "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v4 14/18] staging: remove struct _io_ops
Date:   Mon, 13 Sep 2021 20:09:58 +0200
Message-Id: <20210913181002.16651-15-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913181002.16651-1-fmdefrancesco@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
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

v3->v4:
        Split a patch into fourteen.
v2->v3:
        No changes.
v1->v2:
        No changes.

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

