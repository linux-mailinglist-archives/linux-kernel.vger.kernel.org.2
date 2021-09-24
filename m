Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6855F4171D2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343649AbhIXM31 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245733AbhIXM3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:13 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1CAC061574
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:39 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id y89so24666277ede.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qi+zf2bdvOa9UR9wFZCL3fbUpqToUUKmha/pjGTdTMQ=;
        b=CnN9oEj+J4GtMs6JYBo5rmZzvjKY4yNBYe54W5lmAvc0Xy2wU34PuOpsoKVkby7AxW
         gki2tyHhV6eDm0oXJBPvaINVNx23xmt4zk3m5khvp1mN8+/3BYySQBdMvWqkUhtt956m
         kfAuxxVnS2W/Ofs0ObTWZDNev0JL7/C/MM3x7R7uWOMpsqwdCES5PelLz4VckjGJyCtn
         4GacBH4bX9ssrvOepLHo7aDDbjGK0xd0spY3R7o15kRKgQw0op4MEdvejgfa7rCZ9obS
         AMeZwI04TDCfXs5WTWRJYhxG5oYF760kB8qSXQoendnBTxhX7HnexugnKcNts1HBJqJ/
         sWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qi+zf2bdvOa9UR9wFZCL3fbUpqToUUKmha/pjGTdTMQ=;
        b=yC26OHffyEOaZyQr23hVYVOnkiwZTRB12dNJQ4lwTpbT5HsGz3Ydq98DrhI0z0BrJO
         FIZutJybw7p4mdCiCtEnQQ4vxlI7opPV9uQAGpfXDAjkPGiDnkeXaiVxvZqTG5YhLkDi
         fJliTbcekdRBNrBRTspOFP7+91yX5p2iYdI5RUD/b+ucu2xFea4HskeY8CepzCYqmHXt
         YWrtZgtEwS6nvqDNjEESwZq8imeSmXUwgwQpXNMzOnemzpHg0qbwJpY4OB+DY+Eyl6mG
         CW4OVunEpdTXuKbqHWUZNfKHj6fdWjckWf9bKJb2BUhV9VPfNG+KYxHtut+Ca7ZlROCE
         zh9A==
X-Gm-Message-State: AOAM533YIOBnTNztq+9725EeCnUGWQF2DkeFQmSFl3PzT82n9x//+ter
        ArGy7SImre3ryW3Xcri68wI=
X-Google-Smtp-Source: ABdhPJyN07c2oeIsr7KQYYz0nlPDopZ9R2gAH964rMRYs68ZkL6BcP35HRLqBw6Gc5kVBSXWqJ1MxA==
X-Received: by 2002:a17:906:c246:: with SMTP id bl6mr10741802ejb.80.1632486458506;
        Fri, 24 Sep 2021 05:27:38 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:38 -0700 (PDT)
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
Subject: [PATCH v10 09/16] staging: r8188eu: remove a buffer from rtw_writeN()
Date:   Fri, 24 Sep 2021 14:26:58 +0200
Message-Id: <20210924122705.3781-10-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary buffer "u8 buf[VENDOR_CMD_MAX_DATA_LEN]" and
pass directly "data" to usbctrl_vendorreq().

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 5dcab1ee4be0..8e4e578ed60b 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -171,14 +171,12 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intf = &io_priv->intf;
 	u16 value = addr & 0xffff;
-	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
 	int ret;
 
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
 		return _FAIL;
 
-	memcpy(buf, data, length);
-	ret = usbctrl_vendorreq(intf, value, buf, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
+	ret = usbctrl_vendorreq(intf, value, data, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
 
 	return RTW_STATUS_CODE(ret);
 }
-- 
2.33.0

