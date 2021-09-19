Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC1B410DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:56:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233743AbhISX53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233760AbhISXzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC9CC0613D5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id q3so54041336edt.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=s0HCFshaBauxOuAacOXu+93zFdW/J/F5i0+U/nZsqBI=;
        b=YeKWCOcyHaDzO1Gi9HrLOux6kxCvGbqkkfbhpLoK8pf4fJ3vo8Q/rvVTMEZu3LZI8G
         TycfwN0+ucWC6MCYiSlP6LtfQy0a9a1ZNwQFPhVGqkDEEhYwjW0njRX8A3TP/6kNeoK4
         wVQsHaZyY0HsErdcgkbs+cyKU08IspYUyu0OMkfalfo2ObNde9m+MCPYMXocmgfdnnJw
         y0ucnPTsR94zOn5H6K1LTvVjLzrVXh6/PR3sgq8mzNuYYDWUtmRyjOKn0cfHW+GsNk0m
         xEq5YAGIdfvOgXl6XjKTOkQ5bDckg3RHhX43NbRJhmsR2NfaG6F0P+Oh1ujAfQ7Qu5/H
         pvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=s0HCFshaBauxOuAacOXu+93zFdW/J/F5i0+U/nZsqBI=;
        b=EvAfxP0DiWNtu+slj0VABC99hH35XpB2A9M/MuxEN9sCKwPSFoROfddm1uoa3kg0At
         f04XWzDbqU3VAXArS081o0XTxumTYzC23+rSlz5KpyLegrsgYQyNFzu0ePZLmlpeMgYw
         x2DTOYBH6xRY9UAKwD6VE+uva6MfMy6remqR3+Aeft98VkDh0J/2CxWAgpTYA5A2USnU
         uPR7qP5LhOdSn+iu960ip+GsoF3nIFjK+M0gbEWwEReOhn1SGRQ+7Y7kqQ0ncFdaYvXQ
         ZBgOcmpLKo1x9DG6gcMD9FSPV1lSlb80zvx9MZOHXI5p6QGrQnJIWPxtoLvlIasBulDk
         Xm2g==
X-Gm-Message-State: AOAM5330TUm44GF11hGRCovuWSW89bZVoXeWmR79LrSl3UJgYJbU1ncn
        6sN4HLXGlagVqHD5SxQC/wM=
X-Google-Smtp-Source: ABdhPJzjCyllRrZHBS6no89+Zi5stuQRbND3NY1tPEm4cc6e299YgKycPC2o+D6qG+X4UyYh5UYPRQ==
X-Received: by 2002:a50:e0c9:: with SMTP id j9mr12609589edl.336.1632095656615;
        Sun, 19 Sep 2021 16:54:16 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v8 11/19] staging: r8188eu: remove unnecessary casts from rtw_{read,write}*()
Date:   Mon, 20 Sep 2021 01:53:48 +0200
Message-Id: <20210919235356.4151-12-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
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
index efdf654e434a..ba654db869f7 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -98,7 +98,7 @@ u8 rtw_read8(struct adapter *adapter, u32 addr)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
-	u16 value = (u16)(addr & 0x0000ffff);
+	u16 value = addr & 0xffff;
 	u8 data;
 
 	usbctrl_vendorreq(intfhdl, value, &data, 1, REALTEK_USB_VENQT_READ);
@@ -110,7 +110,7 @@ u16 rtw_read16(struct adapter *adapter, u32 addr)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
-	u16 value = (u16)(addr & 0x0000ffff);
+	u16 value = addr & 0xffff;
 	__le32 data;
 
 	usbctrl_vendorreq(intfhdl, value, &data, 2, REALTEK_USB_VENQT_READ);
@@ -122,7 +122,7 @@ u32 rtw_read32(struct adapter *adapter, u32 addr)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
-	u16 value = (u16)(addr & 0x0000ffff);
+	u16 value = addr & 0xffff;
 	__le32 data;
 
 	usbctrl_vendorreq(intfhdl, value, &data, 4, REALTEK_USB_VENQT_READ);
@@ -134,7 +134,7 @@ int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
-	u16 value = (u16)(addr & 0x0000ffff);
+	u16 value = addr & 0xffff;
 	int ret;
 
 	ret = usbctrl_vendorreq(intfhdl, value, &val, 1, REALTEK_USB_VENQT_WRITE);
@@ -146,7 +146,7 @@ int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
-	u16 value = (u16)(addr & 0x0000ffff);
+	u16 value = addr & 0xffff;
 	__le32 data = cpu_to_le32(val & 0x0000ffff);
 	int ret;
 
@@ -159,7 +159,7 @@ int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
-	u16 value = (u16)(addr & 0x0000ffff);
+	u16 value = addr & 0xffff;
 	__le32 data = cpu_to_le32(val);
 	int ret;
 
@@ -172,7 +172,7 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 {
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
-	u16 value = (u16)(addr & 0x0000ffff);
+	u16 value = addr & 0xffff;
 	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
 	int ret;
 
-- 
2.33.0

