Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB0C409BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Sep 2021 20:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346891AbhIMSOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Sep 2021 14:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240644AbhIMSOf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Sep 2021 14:14:35 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7DF9C061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:13:18 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id qq21so17082669ejb.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Sep 2021 11:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/OzfD5DtP7nTmC6Cj3TQwQWXv921Gqp47fsa9UuRvDg=;
        b=FPtjcKGEYMckLsOt4YDPafDyUNlqxGzVQt28MH7q9w+e0rShq7QPSSqclUARYdgDvf
         qhuk7cOK50Y3oSyQPh8q+T015GXKBOdAjdqlWsWCKv0GTtVhc6lUDJ3L0S4HaAOWrqZt
         o2KZjXwNNCGGCMaA8hER937nB+0VzuAILnVIxSEc8OZ75HXoHOxJn71Zivs93nhUCk3+
         WTtqw8nvEVi9HtthnuDwCSlN48qbEVHep9P5rzFvMMDJb/+xO/Aw8J+Y8hWM3mee0w19
         t20aQt2B6W5KVhKNaG1m6CyPKpas2+LIMlj9T3WG1QhXsIJWlqitf0tZ/j+a+Y6WrOll
         pnEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/OzfD5DtP7nTmC6Cj3TQwQWXv921Gqp47fsa9UuRvDg=;
        b=bdK3pjyl2AzhrgOpVt6TFIu89+anvRrq+SI7OUGFtAWP5PYVbBbd/B7Ih6Y4x98Isa
         KnvlCMH7+BOwaqPBAcNPQeU6IaUyEVARsdrxpbisTClpE7JkltSLeU1enpmBcSQaS80X
         Lm6EdTmHU0k+H49K6iaKcA8MlNZRdms85gtiHU9M3Cb51Xje4o+FvLydUcNJhWdODIP3
         H+aieC6r9mq8gieks6s3vIUhy/IARvYWXfvZLM4sQySH3rAQ45z1C1SWja15ofFUlQ3t
         AElxDgVMdpKNVtjgnlxjaVw/tVjTaM47jFoxToW9L5Odc+7KLg+PQBVOzfUUFtjYbqW0
         wEhA==
X-Gm-Message-State: AOAM532btMkh4AxVOiI5opzKlqdhs9IA/PnBe8RvAftgkSQMQrMFDoEE
        K/pp+4KUBCI/RbrarhJFluBeHNuParE=
X-Google-Smtp-Source: ABdhPJyM4d/Jyf/kqM/reTvqOIcKnAKqk26XziqBpwxmpb+uV+hZ7z4GdM9V2Ebo/ukTvyyIFryhhw==
X-Received: by 2002:a17:906:9aca:: with SMTP id ah10mr6720113ejc.471.1631556797351;
        Mon, 13 Sep 2021 11:13:17 -0700 (PDT)
Received: from localhost.localdomain.it (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id d25sm4258999edt.33.2021.09.13.11.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 11:13:16 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: [PATCH v4 17/18] staging: r8188eu: Shorten calls chain of rtw_read8/16/32()
Date:   Mon, 13 Sep 2021 20:10:01 +0200
Message-Id: <20210913181002.16651-18-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210913181002.16651-1-fmdefrancesco@gmail.com>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

v3->v4: 
	Make some changes according to a first review of Greg
	Kroah-Hartman; remove unnecessary while loop and a couple of
	'if' test; handle the errors returned by usb_control_msg_recv()
v2->v3: 
	No changes.
v1->v2: 
	No changes.

 drivers/staging/r8188eu/hal/usb_ops_linux.c | 56 +++++++++++++++++++--
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 04402bab805e..75475b0083db 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -89,6 +89,56 @@ static int usbctrl_vendorreq(struct intf_hdl *intfhdl, u16 value, void *data, u1
 	return status;
 }
 
+static int usb_read(struct intf_hdl *intfhdl, u16 addr, void *data, u8 size)
+{
+	int status;
+	u8 *io_buf; /* pointer to I/O buffer */
+	struct adapter *adapt = intfhdl->padapter;
+	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
+	struct usb_device *udev = dvobjpriv->pusbdev;
+
+	if (adapt->bSurpriseRemoved || adapt->pwrctrlpriv.pnp_bstop_trx) {
+		status = -EPERM;
+		goto exit;
+	}
+
+	mutex_lock(&dvobjpriv->usb_vendor_req_mutex);
+
+	io_buf = dvobjpriv->usb_vendor_req_buf;
+
+	status = usb_control_msg_recv(udev, 0, REALTEK_USB_VENQT_CMD_REQ,
+				      REALTEK_USB_VENQT_READ, addr,
+				      REALTEK_USB_VENQT_CMD_IDX, io_buf,
+				      size, RTW_USB_CONTROL_MSG_TIMEOUT,
+				      GFP_KERNEL);
+	if (!status) {
+		/*  Success this control transfer. */
+		rtw_reset_continual_urb_error(dvobjpriv);
+		memcpy(data, io_buf, size);
+		goto mutex_unlock;
+	}
+	/*  error cases */
+	if (status == (-ESHUTDOWN || -ENODEV || -ENOENT)) {
+		/*
+		 * device or controller has been disabled due to
+		 * some problem that could not be worked around,
+		 * device or bus doesn’t exist, endpoint does not
+		 * exist or is not enabled.
+		 */
+		adapt->bSurpriseRemoved = true;
+			goto mutex_unlock;
+	}
+	GET_HAL_DATA(adapt)->srestpriv.wifi_error_status = USB_VEN_REQ_CMD_FAIL;
+	if (rtw_inc_and_chk_continual_urb_error(dvobjpriv)) {
+		adapt->bSurpriseRemoved = true;
+		goto mutex_unlock;
+	}
+mutex_unlock:
+	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
+exit:
+	return status;
+}
+
 u8 rtw_read8(struct adapter *adapter, u32 addr)
 {
 	u8 data;
@@ -96,7 +146,7 @@ u8 rtw_read8(struct adapter *adapter, u32 addr)
 	struct intf_hdl *intfhdl = &io_priv->intf;
 	u16 address = (u16)(addr & 0xffff);
 
-	usbctrl_vendorreq(intfhdl, address, &data, 1, REALTEK_USB_VENQT_READ);
+	usb_read(intfhdl, address, &data, 1);
 
 	return data;
 }
@@ -108,7 +158,7 @@ u16 rtw_read16(struct adapter *adapter, u32 addr)
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
 
-	usbctrl_vendorreq(intfhdl, address, &data, 2, REALTEK_USB_VENQT_READ);
+	usb_read(intfhdl, address, &data, 2);
 
 	return le16_to_cpu(data);
 }
@@ -120,7 +170,7 @@ u32 rtw_read32(struct adapter *adapter, u32 addr)
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
 
-	usbctrl_vendorreq(intfhdl, address, &data, 4, REALTEK_USB_VENQT_READ);
+	usb_read(intfhdl, address, &data, 4);
 
 	return le32_to_cpu(data);
 }
-- 
2.33.0

