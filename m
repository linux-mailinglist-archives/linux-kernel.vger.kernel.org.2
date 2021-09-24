Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 923B74171CE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343653AbhIXM3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343588AbhIXM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:12 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47B23C0613C1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:37 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id s17so16783964edd.8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0o7R1/of5Vu6517IGPX3lhQkbtC4VCfvh7d9Pkg94p8=;
        b=UpTfTOx0pfLaZVB370SBT2TLnJBFC6nHj4KdrGc7j/W00NeGVrbktmrALvpYN02Xl2
         QWZL9Zf8+gV79mkDZM4S7CaHy3PmBfiQiwbFPQP24IcOU/JUktM66Zyfv6lkdcpNo1Yv
         Qi0eaSEDJNiZg97tBW4BxuFFmrYZi3sLQJIYvyT2fulzITT8kpLIvp9T192oh774FhpA
         Ub4Nts0AYeLV53yjobOd1Kw+qsHjrD1FO1ShsYNlH/D1sxKNQWEOC7kAhRS8bkGUvmgu
         1JGrrilBy9i+wd3mCfAxXej6Cn4Ae/quU0ubXQBeP8NQ5dXCELD1CWIXrvG0/CLpEYOf
         bq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0o7R1/of5Vu6517IGPX3lhQkbtC4VCfvh7d9Pkg94p8=;
        b=HDeGTdsqdKVK8eMpDOTJRSKVx/+jJqakZuEIop3L7wIm/8ZQtNm3KE15LN0y/Fntf7
         3VdIS/sl7pesFk4iqNOeWzx8S9Mu7cD1fYLj5TFLd3lSi4dxH7dRO93NQ44PrKdF6Fm5
         ReVJHDICwVIPp3Cp2atw5yF/xrBuKkJZ7dLOz4SYz4YQX49hWUPEy0f7qGLRBQ4vOKDa
         6UGoFZH6hSxICMMiLID3G7K0pSQJ/5HwG5QTYvhjRM8EOMKxnepcNif19rR1t/a8fCFI
         PZC2E/u0uJhLS90XviaYvINtfaJFD450gszB+5TFpKpjDgKyIPlzh9ExqKUQZGzyzT8I
         VpkQ==
X-Gm-Message-State: AOAM533Ctkxu66/WdWvHvvxHqB9DB/Ubx9vAcyXztEn6j5IUb29c5AF4
        UufLlZbQ8BsEniZkAwTYo4Y=
X-Google-Smtp-Source: ABdhPJzGEHDVUnpER+AjxCRY53gWAfByvHPAyrdf7ufclrroeOlbQAa5ZNV/ILj56FTvD07BhUx5WQ==
X-Received: by 2002:a17:906:fa12:: with SMTP id lo18mr11107253ejb.296.1632486455749;
        Fri, 24 Sep 2021 05:27:35 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:35 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v10 07/16] staging: r8188eu: remove casts from rtw_{read,write}*()
Date:   Fri, 24 Sep 2021 14:26:56 +0200
Message-Id: <20210924122705.3781-8-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
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

