Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1173C400D15
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 23:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236702AbhIDV36 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 17:29:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236050AbhIDV3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 17:29:54 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CFFC0613C1
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 14:28:52 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id mf2so5244370ejb.9
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 14:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=21yXVwHi3W8nI+JyDWw96C1fxGLy7XxTy+IduUl5Byk=;
        b=NHGwJtNsIqvFbXtjYgWZ0kp43Rr2UZyckpuTBM9FiQQJ1ts/8zk+pj1I3WLNrty4gg
         49dJJ3tVeLJq7s8pgXrEoioZdqQtiPNTBCLJ6bYfzJx8eN7sjV0Jb2po3cZe18Xn/OAD
         a+Atg+6KxXrshXipIoXlXbp5Ih26IJIIGgmFN8P/Aa6IC/S6MJwMdWCtCLOzSlF7u4Zd
         oBiDPq5vIGmXJCFUT7rk+3vsanCMKHJdDjwoYHPcZnvL+u/kz2cksJVXZnmP2hVHAr9X
         tKOxka400TF3CzAyJ+P+2l1AAtfIgDlJl1sUn/XOm+RwPPWfdmLuUOvyctlezc4+Kueg
         BPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=21yXVwHi3W8nI+JyDWw96C1fxGLy7XxTy+IduUl5Byk=;
        b=dHlYDSH5/ekbHeUtC/SzVnQEBkRwHwQC0FfuZltNg/FU1Dbz/AQMyd8rBA5n7yd8Uj
         1Ky5t14lvY7jwvHNi/PwdkYDnzVvGr0TonjJrm9AmkP9trb/otLI0BVDgURABWnYOQKe
         eGU2xBgXIM2Gs+bx4+N3fcgPySGjcdhwBYORdNlVFu9eWdAWvE72rTCk7IA4eku9eb5C
         Z/d7CAjrCh0Bo4stto+o+5TerGmltL+nC4DhRjT3jYXMI1lPrpa4ahFFt+iGZORBR8mc
         KZ9ETozPHbngQlK1y2WRmJKPZssoG1g5nsPJdm/trahSHeSDzPjJi3wxZe6hzWSC+VEx
         KdsQ==
X-Gm-Message-State: AOAM532B77LgZ9EIgsHMrdxjVYe/IaZjaJEmi1BLtEB3BLRcvU+0Yf92
        TVrHZg10nFY1pevybQas+vI=
X-Google-Smtp-Source: ABdhPJwEe7SRBgbk8h4F5LS6x6MyDiE85SXre52T5esSjJwJtMwxGZPpWxvIJtKSL2P6MGDDDqbqIA==
X-Received: by 2002:a17:906:914e:: with SMTP id y14mr5908609ejw.223.1630790931442;
        Sat, 04 Sep 2021 14:28:51 -0700 (PDT)
Received: from localhost.localdomain (host-79-23-101-208.retail.telecomitalia.it. [79.23.101.208])
        by smtp.gmail.com with ESMTPSA id n13sm1866699edq.91.2021.09.04.14.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 14:28:51 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v2 2/3] staging: r8188eu: Shorten calls chain of rtw_read8/16/32()
Date:   Sat,  4 Sep 2021 23:27:18 +0200
Message-Id: <20210904212719.11426-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904212719.11426-1-fmdefrancesco@gmail.com>
References: <20210904212719.11426-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shorten the calls chain of rtw_read8/16/32() down to the actual reads.
For this purpose unify the three usb_read8/16/32 into the new
usb_read(); make the latter parameterizable with 'size'; embed most of
the code of usbctrl_vendorreq() into usb_read() and use in it the new
usb_control_msg_recv() API of USB Core.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---

v1->v2: No changes.

 drivers/staging/r8188eu/hal/usb_ops_linux.c | 92 +++++++++++++++++----
 1 file changed, 78 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index a87b0d2e87d0..f9c4fd5a2c53 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -97,38 +97,102 @@ static int usbctrl_vendorreq(struct intf_hdl *pintfhdl, u16 value, void *pdata,
 	return status;
 }
 
+static int usb_read(struct intf_hdl *intfhdl, u32 addr, void *data, u8 size)
+{
+	u16 value = (u16)(addr & 0x0000ffff);
+	struct adapter *adapt = intfhdl->padapter;
+	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
+	struct usb_device *udev = dvobjpriv->pusbdev;
+	int status;
+	u8 *io_buf;
+	int vendorreq_times = 0;
+
+	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx) {
+		status = -EPERM;
+		goto exit;
+	}
+
+	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
+
+	/*  Acquire IO memory for vendorreq */
+	io_buf = dvobjpriv->usb_vendor_req_buf;
+
+	if (!io_buf) {
+		DBG_88E("[%s] io_buf == NULL\n", __func__);
+		status = -ENOMEM;
+		goto release_mutex;
+	}
+
+	while (++vendorreq_times <= MAX_USBCTRL_VENDORREQ_TIMES) {
+		status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
+					      REALTEK_USB_VENQT_READ, value,
+					      REALTEK_USB_VENQT_CMD_IDX, io_buf,
+					      size, RTW_USB_CONTROL_MSG_TIMEOUT,
+					      GFP_KERNEL);
+		if (!status) {   /*  Success this control transfer. */
+			rtw_reset_continual_urb_error(dvobjpriv);
+			memcpy(data, io_buf, size);
+		} else { /*  error cases */
+			DBG_88E("reg 0x%x, usb %s %u fail, status:%d vendorreq_times:%d\n",
+				value, "read", size, status, vendorreq_times);
+
+			if (status == (-ESHUTDOWN) || status == -ENODEV) {
+				adapt->bSurpriseRemoved = true;
+			} else {
+				struct hal_data_8188e *haldata = GET_HAL_DATA(adapt);
+
+				haldata->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
+			}
+
+			if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
+				adapt->bSurpriseRemoved = true;
+				break;
+			}
+		}
+
+		/*  firmware download is checksummed, don't retry */
+		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || !status)
+			break;
+	}
+
+release_mutex:
+	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
+exit:
+	return status;
+}
+
 u8 rtw_read8(struct adapter *adapter, u32 addr)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
+	u16 value = (u16)(addr & 0x0000ffff);
 	u8 data;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, 1, REALTEK_USB_VENQT_READ);
+	usb_read(intfhdl, value, &data, 1);
 
 	return data;
 }
 
 u16 rtw_read16(struct adapter *adapter, u32 addr)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
-	__le32 data;
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
+	u16 value = (u16)(addr & 0x0000ffff);
+	__le16 data;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, 2, REALTEK_USB_VENQT_READ);
+	usb_read(intfhdl, value, &data, 2);
 
-	return (u16)(le32_to_cpu(data) & 0xffff);
+	return le16_to_cpu(data);
 }
 
 u32 rtw_read32(struct adapter *adapter, u32 addr)
 {
-	struct io_priv *pio_priv = &adapter->iopriv;
-	struct intf_hdl *pintfhdl = &pio_priv->intf;
-	u16 wvalue = (u16)(addr & 0x0000ffff);
+	struct io_priv *io_priv = &adapter->iopriv;
+	struct intf_hdl *intfhdl = &io_priv->intf;
+	u16 value = (u16)(addr & 0x0000ffff);
 	__le32 data;
 
-	usbctrl_vendorreq(pintfhdl, wvalue, &data, 4, REALTEK_USB_VENQT_READ);
+	usb_read(intfhdl, value, &data, 4);
 
 	return le32_to_cpu(data);
 }
-- 
2.33.0

