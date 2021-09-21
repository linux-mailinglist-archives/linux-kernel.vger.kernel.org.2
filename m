Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 402044139EF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232816AbhIUSUq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232769AbhIUSU3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:20:29 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6998AC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:18:59 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id dj4so21714729edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2NFdRrR4y988/qJTdBg9DXHSyMtgA8l3RX+tVJ10Rt8=;
        b=Tlr+smt3loiY+77C5LwxIwTFle38gMIDXzxzT773/FF6bSvf7uZtsRYf/yRVkDIx2G
         eOpMpzA7KWB59XKHgVOrHfPAiiYl+rGI0+8YKCkZY536PxNEwj+ufANIbYKsKSmFFOwM
         GQcpmhkyDLhsYFiQxWlJf3Ucr1SZ9eo3U6GwsgnyXU1hL9MqyNi0HsO9EfotC3nez0Zs
         EdhSKRwTedgrhhbLLW3Uc594N9qcA8W+EraDqv3PGEf6x7l2XN/Mf5haxx8TWWFmLqXW
         JN4iDJUVsbBHMgPEVEiNJgRU6Zxd0GFJur5EkSxhc5a5aW34Q+3IB+xyTzOWsseLHfXj
         ZRiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2NFdRrR4y988/qJTdBg9DXHSyMtgA8l3RX+tVJ10Rt8=;
        b=Osd9jxW2Fuv+fWVWu0/h5DpfUUfsK2eRB3Obey01yvOooI2sZEsoboE2frqyfK2ZC6
         lSQ9WKA5Ikfp8OQapN2gEtj+uYHdxBhLaBw8+jxBwy+cYtGVUcEYXIinTLxP85Cg9aYi
         ZVTNFh2dcY9zEd3lsGwNVBbkH2MyfgMi/xRXxaCFK6RF7YPXQrkrd0taN9omiqoKndMA
         lHgCzWJANgRzKtzsdSRf+A18q/XNwNj61/sbjuOM6uwIT49MFjVRL9Z6jgfcvMPLNP4u
         wfdj4OgkmbWLByDRjom7pgL4tSPg0fdgVkFSNK6pwVY87Lf5A8TapzDD/dw+/aCt+juo
         D7Wg==
X-Gm-Message-State: AOAM5338mKa++Yaw0RH7CVooGu8EG4jSXvUWQ02IekgX/6fnrpB2L5ub
        29/fYiZQy2j30F9zSJQWCHY=
X-Google-Smtp-Source: ABdhPJwvE1mJDNFx5pz5SPq9aIVWFYbmpGueIbzFS015G92bcqJisNwY67Tjgr0EBvUZLLnnPrhXTQ==
X-Received: by 2002:a17:906:6c94:: with SMTP id s20mr37523899ejr.152.1632248337807;
        Tue, 21 Sep 2021 11:18:57 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id cn8sm1833162edb.77.2021.09.21.11.18.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:18:57 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v9 03/16] staging: r8188eu: remove unnecessary test in usbctrl_vendorreq()
Date:   Tue, 21 Sep 2021 20:18:21 +0200
Message-Id: <20210921181834.29677-4-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921181834.29677-1-fmdefrancesco@gmail.com>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unnecessary test for "!io_buf" in usbctrl_vendorreq(). This test
is not necessary because io_buf has been assigned with the address of
a region of dinamically allocated memory (dvobj->usb_alloc_vendor_req_buf)
by rtw_init_intf_priv() in os_dep/usb_intf.c.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 84ec7c1346b1..61a016e3608f 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -34,12 +34,6 @@ static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 l
 	/*  Acquire IO memory for vendorreq */
 	io_buf = dvobjpriv->usb_vendor_req_buf;
 
-	if (!io_buf) {
-		DBG_88E("[%s] io_buf == NULL\n", __func__);
-		status = -ENOMEM;
-		goto release_mutex;
-	}
-
 	if (requesttype == REALTEK_USB_VENQT_READ)
 		pipe = usb_rcvctrlpipe(udev, 0);/* read_in */
 	else
@@ -91,7 +85,7 @@ static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 l
 		if ((value >= FW_8188E_START_ADDRESS && value <= FW_8188E_END_ADDRESS) || status == len)
 			break;
 	}
-release_mutex:
+
 	mutex_unlock(&dvobjpriv->usb_vendor_req_mutex);
 exit:
 	return status;
-- 
2.33.0

