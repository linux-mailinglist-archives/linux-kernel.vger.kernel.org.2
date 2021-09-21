Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C16E4139F4
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233103AbhIUSVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232792AbhIUSUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:20:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E63C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:03 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id c22so77147448edn.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0o7R1/of5Vu6517IGPX3lhQkbtC4VCfvh7d9Pkg94p8=;
        b=B0p8fKM4QnAYovgBz+b33IApVh9p25D6VhQa2xDP+OnLcFnWvln7ChfDIMfZ9IsVta
         V3sJ1QSQNplATypmr0vSZIIzTv3ObqdKLij5TyEpWYeB617AteLA6CpWlhQdtCYw+6/w
         +L8fqsy1inffHjSaMaUc8/++9H/ACBoYMHa6Y3Afor0cpwjuZ9WTlqJDd9OVXRUUtwqz
         vHwl7ZpGdZcsrpS1RD3X/NGHxQbHunH0vhGgTlGPhKihOvzQ6d8NVXH7OENC58q5i9OE
         h99r76HfANmpx8wwDOiM/DIFM6gf/UKnsP7AnoYkvovWwtwqsYwhMiPV3PUFlkbX4OsB
         CxEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0o7R1/of5Vu6517IGPX3lhQkbtC4VCfvh7d9Pkg94p8=;
        b=69zbcoFbFs3vcsDxnvro2+nvb7PerKivhSp+dxfYGDe52N8xHRgcD6fCz0BOASc83y
         AG5QGdDqXSz8pf4cqzW0F8JhWZxa8jH99iVUd/YZVe04sWTDhlyn0oVPXaWqrwKNg7nT
         OynEC2qv89+4dzSuS5USmgW7pYvuCBmSw5BnA0mz1acwRvGANc6x/5QbybOmT+09IT3e
         LTPB1I3+mW/656kfLWgVGEgYp63Vn2AgyRyzkvgR6gjl7elhphQhHXw2hb0tnx3TY2le
         nofPKFVeNQWahLM++9mpYQdKOHNoYSquEx02aEX/AzN0fjg40eiL9Ks4xEoqYXSegE1r
         Xcvw==
X-Gm-Message-State: AOAM531d5Jed+QmTz8znz7rDY+r/rnGAGdxNBmUmqPWdkLAo4K9aDI97
        xJIAJuc6tEqeXypISQzCybgC2pgAm94=
X-Google-Smtp-Source: ABdhPJyvl4Zx85WIrZf2veEw6zQff4KrLEgWQRmwVrFuhhO9dl/E0nIu8yDmWW14rsuUOAP+LTNfjA==
X-Received: by 2002:a17:906:5010:: with SMTP id s16mr13676572ejj.245.1632248342597;
        Tue, 21 Sep 2021 11:19:02 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id cn8sm1833162edb.77.2021.09.21.11.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:19:02 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v9 07/16] staging: r8188eu: remove casts from rtw_{read,write}*()
Date:   Tue, 21 Sep 2021 20:18:25 +0200
Message-Id: <20210921181834.29677-8-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921181834.29677-1-fmdefrancesco@gmail.com>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary casts from rtw_read{8,16,32}() and from
rtw_write{8,16,32,N}().

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 9ff57e114b04..95cd7a6bc28b 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -96,7 +96,7 @@ u8 rtw_read8(struct adapter *adapter, u32 addr)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intf = &io_priv->intf;
-	u16 value = (u16)(addr & 0x0000ffff);
+	u16 value = addr & 0xffff;
 	u8 data;
 
 	usbctrl_vendorreq(intf, value, &data, 1, REALTEK_USB_VENQT_READ);
@@ -108,7 +108,7 @@ u16 rtw_read16(struct adapter *adapter, u32 addr)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intf = &io_priv->intf;
-	u16 value = (u16)(addr & 0x0000ffff);
+	u16 value = addr & 0xffff;
 	__le32 data;
 
 	usbctrl_vendorreq(intf, value, &data, 2, REALTEK_USB_VENQT_READ);
@@ -120,7 +120,7 @@ u32 rtw_read32(struct adapter *adapter, u32 addr)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intf = &io_priv->intf;
-	u16 value = (u16)(addr & 0x0000ffff);
+	u16 value = addr & 0xffff;
 	__le32 data;
 
 	usbctrl_vendorreq(intf, value, &data, 4, REALTEK_USB_VENQT_READ);
@@ -132,7 +132,7 @@ int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intf = &io_priv->intf;
-	u16 value = (u16)(addr & 0x0000ffff);
+	u16 value = addr & 0xffff;
 	int ret;
 
 	ret = usbctrl_vendorreq(intf, value, &val, 1, REALTEK_USB_VENQT_WRITE);
@@ -144,7 +144,7 @@ int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intf = &io_priv->intf;
-	u16 value = (u16)(addr & 0x0000ffff);
+	u16 value = addr & 0xffff;
 	__le32 data = cpu_to_le32(val & 0x0000ffff);
 	int ret;
 
@@ -157,7 +157,7 @@ int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intf = &io_priv->intf;
-	u16 value = (u16)(addr & 0x0000ffff);
+	u16 value = addr & 0xffff;
 	__le32 data = cpu_to_le32(val);
 	int ret;
 
@@ -170,7 +170,7 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intf = &io_priv->intf;
-	u16 value = (u16)(addr & 0x0000ffff);
+	u16 value = addr & 0xffff;
 	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
 	int ret;
 
-- 
2.33.0

