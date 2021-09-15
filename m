Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8690540C588
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Sep 2021 14:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237375AbhIOMqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Sep 2021 08:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237872AbhIOMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Sep 2021 08:46:03 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0B3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:44:44 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id i6so4181831edu.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Sep 2021 05:44:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=20wywgQEOo0egoQmBSEpanb7Vzi97onrpQZGv5F4kZg=;
        b=OKE9OcXa9GCgYZbsRBoHNdSURhOECrxAjId9RtbtreLfCJl5AFlhlYSFIpt6vOXEmU
         uWx7frNkquimr1ShZ1e/9uH594hJBM2pvQabSK52thMJvdCrXz43KNjOTSS6EJBqvCi9
         3xho2Wl7LrUkgEMB2XfrIjAPa8shwWLM2xOGVNamZywPrZqezLuYbDQvTY+VnWfeNxwL
         lnLrxc2WtJVva/n5QosPjwLtp4js5g2YIzq18K3zaqf0BAkVinVxxLidrEEwo9JAouOi
         c4ap7LMMR7tqKpZMCI4pqjT9DOxlTGHzpOt4fTv+iqQdU9hNDWm9sOYs3vBNSG/RJBoJ
         KvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=20wywgQEOo0egoQmBSEpanb7Vzi97onrpQZGv5F4kZg=;
        b=R7ygSX4EwsLI2BL+iIw8TxFNX0DNGE+J+o1o6itP8eZRlG8+F+kGgvYgjm+df1Zqrp
         zG585rg+3bRRbEmelRLAF0ighRBuE+jcs9WJeD2NqZDInoaqrJQshQqAt2pOsVQrAacu
         aW2CMELyJEJspOI2N/c56NQ1Z13AGcMZ1lV/hLbTNhHR4XICpNb0z1PnZ7QyeQ/9kslL
         0YlzKDFlHRmpHPcTWJ3PxeXkVrjLcecOesske3FoVuHvxjwrDyzy1zID05Dh9gi8mi9E
         KX/NVcEjckKfAuKkLTDQcb1Br4znOkU7C8IKWsQ1hzLab7wl5oxaBUsM8buM0/PIx54D
         9mIg==
X-Gm-Message-State: AOAM532LMw7/bHCY1zieGTBUWz3HkYWwDWGVhlVnuGGPJDuRyfHv1Yr4
        T+VSPBMRNrNqVg/w9Zi8m3Q=
X-Google-Smtp-Source: ABdhPJzxAfXz9A3jfa4XfCfKVZ8J6ie6+TTaDDonBrT3uvYBvnkyFiNWm3CD0U0VFxlln586JRpoCQ==
X-Received: by 2002:a05:6402:229c:: with SMTP id cw28mr22114784edb.356.1631709883282;
        Wed, 15 Sep 2021 05:44:43 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id s3sm6394002ejm.49.2021.09.15.05.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 05:44:42 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Philip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Fabio M . De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v5 14/19] staging: remove struct _io_ops
Date:   Wed, 15 Sep 2021 14:41:44 +0200
Message-Id: <20210915124149.27543-15-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210915124149.27543-1-fmdefrancesco@gmail.com>
References: <20210915124149.27543-1-fmdefrancesco@gmail.com>
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

