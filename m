Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445DC4139F2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233189AbhIUSU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbhIUSUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:20:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB54BC061575
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ee50so4146625edb.13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iS0yrz2R2AQfS41qiitv5hcqB1aEN904+JCIHfInJMc=;
        b=Ld5HhnuBjmawUaJClQ+o42Qk/gDny9CrzPMmV+WwDrkMPKiqYEsmd2aRlGjiz/92bv
         dNamLEo/BCD/ebGsVdVSt8LXF/cE+avSvd/98XlWlnHR3eZwxCsXJLcTM3sOWLffChAN
         dBkuj3Znxnp4u6Xl6xRYmaTT9aPKvhr/pyg/uy23Me6s34PDGVi02sd+uiyPDL/ljd5+
         L+PuIKm4KCglHYVsoSn6LEHQ6ZMBOHrO0vsYv1zoeaJYgDnJa0XO09NLTU5j2E73R5lZ
         4Cg2ChyIxr56KIx+UEe72aVhAZXeB3jTqWwF6ezPx1TlPzV/qPpQ2EduSw65/cx+2uV3
         LbMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iS0yrz2R2AQfS41qiitv5hcqB1aEN904+JCIHfInJMc=;
        b=ZqR1qqIzQA/So7TQoUJhhmA20H1rzo1w/1fv0wDfUO4nRPNk+UrTMOvI3owOuvhlNw
         5tVxY8mFOCd0uK/AUBEgylMfMzkMyNmljDCy5KsqMwx5AJgVsHNGAP/3Vjze1JQSsuPS
         +MPRTYT7jiDQIsXYyaly8fhAR+NTyZxMLPqgpZiQnkPKTk7ALUFukV0+VxjOeTgxTo0D
         jbxZVZZkuGMPKwzXNgta+nTLcUvPtZIYWlWzP2OaX6q0mg/XZbysrbFWn/uRfYb8u7gp
         pZul5r0WhbOWDaB1G7WRMhbqsWO4g79EFGtlaG4sgSkm7jpHJQh7yBlv8xw3FrKrRQHv
         o03g==
X-Gm-Message-State: AOAM532yp5aHLrk7vZb7u+0dQDB5okOnZsIQaCms0s4xUkIXL/atQD5e
        iTBlEebm5j8yN3FTkZ20pyA=
X-Google-Smtp-Source: ABdhPJy1F89X/n4iaEaAK0LMg+JbXXcaONPI01qXi/g0GuqhSxlmyr5evEguF1BGL7KU9r1yiqbwBA==
X-Received: by 2002:aa7:d582:: with SMTP id r2mr37199868edq.324.1632248341397;
        Tue, 21 Sep 2021 11:19:01 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id cn8sm1833162edb.77.2021.09.21.11.19.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:19:01 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v9 06/16] staging: r8188eu: rename symbols in rtw_read*() and rtw_write*()
Date:   Tue, 21 Sep 2021 20:18:24 +0200
Message-Id: <20210921181834.29677-7-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921181834.29677-1-fmdefrancesco@gmail.com>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename names of variables in rtw_read{8.16.32}() and in
rtw_write{8,16,32,N}() because of unnecessary 'p' (that probably stand
for "pointer to") and 'w' (that probably stands for "word"):

	pio_priv => io_priv;
	pintfhdl => intf;
	wvalue => value.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 60 ++++++++++-----------
 1 file changed, 30 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 5c9613cc2415..9ff57e114b04 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -94,91 +94,91 @@ static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 l
 
 u8 rtw_read8(struct adapter *adapter, u32 addr)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intf = &io_priv->intf;
+	u16 value = (u16)(addr & 0x0000ffff);
 	u8 data;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, 1, REALTEK_USB_VENQT_READ);
+	usbctrl_vendorreq(intf, value, &data, 1, REALTEK_USB_VENQT_READ);
 
 	return data;
 }
 
 u16 rtw_read16(struct adapter *adapter, u32 addr)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intf = &io_priv->intf;
+	u16 value = (u16)(addr & 0x0000ffff);
 	__le32 data;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, REALTEK_USB_VENQT_READ);
+	usbctrl_vendorreq(intf, value, &data, 2, REALTEK_USB_VENQT_READ);
 
 	return (u16)(le32_to_cpu(data) & 0xffff);
 }
 
 u32 rtw_read32(struct adapter *adapter, u32 addr)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intf = &io_priv->intf;
+	u16 value = (u16)(addr & 0x0000ffff);
 	__le32 data;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, REALTEK_USB_VENQT_READ);
+	usbctrl_vendorreq(intf, value, &data, 4, REALTEK_USB_VENQT_READ);
 
 	return le32_to_cpu(data);
 }
 
 int rtw_write8(struct adapter *adapter, u32 addr, u8 val)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intf = &io_priv->intf;
+	u16 value = (u16)(addr & 0x0000ffff);
 	int ret;
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &val, 1, REALTEK_USB_VENQT_WRITE);
+	ret = usbctrl_vendorreq(intf, value, &val, 1, REALTEK_USB_VENQT_WRITE);
 
 	return RTW_STATUS_CODE(ret);
 }
 
 int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intf = &io_priv->intf;
+	u16 value = (u16)(addr & 0x0000ffff);
 	__le32 data = cpu_to_le32(val & 0x0000ffff);
 	int ret;
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, REALTEK_USB_VENQT_WRITE);
+	ret = usbctrl_vendorreq(intf, value, &data, 2, REALTEK_USB_VENQT_WRITE);
 
 	return RTW_STATUS_CODE(ret);
 }
 
 int rtw_write32(struct adapter *adapter, u32 addr, u32 val)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intf = &io_priv->intf;
+	u16 value = (u16)(addr & 0x0000ffff);
 	__le32 data = cpu_to_le32(val);
 	int ret;
 
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, REALTEK_USB_VENQT_WRITE);
+	ret = usbctrl_vendorreq(intf, value, &data, 4, REALTEK_USB_VENQT_WRITE);
 
 	return RTW_STATUS_CODE(ret);
 }
 
-int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *pdata)
+int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intf = &io_priv->intf;
+	u16 value = (u16)(addr & 0x0000ffff);
 	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
 	int ret;
 
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
 		return _FAIL;
 
-	memcpy(buf, pdata, length);
-	ret = usbctrl_vendorreq(pintfhdl, wvalue, buf, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
+	memcpy(buf, data, length);
+	ret = usbctrl_vendorreq(intf, value, buf, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
 
 	return RTW_STATUS_CODE(ret);
 }
-- 
2.33.0

