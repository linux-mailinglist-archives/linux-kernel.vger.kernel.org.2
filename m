Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7C34171D1
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:28:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343691AbhIXM3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:29:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245751AbhIXM3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:12 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B19C061756
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:38 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id eg28so35660528edb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XcIedgRKd4A/e9/Vk0iYyZm/XbgKRfJOO6XAQxSeG7Y=;
        b=YuZvnUUSmVCb3vxkpGs6qUEG9jhB3yRhpRsoB3F+EKLGJDD+rQoqlEa0Zt6p+7tNZT
         JxziWlPx2D5CuPy/4S9zcXxaYK0KP6ncnPX04B154l/2uQ6seiF8qHkESdtKD8KSeNP7
         Xxnfu8XK2i6nixRt3Jt5/rvHbgayQBO47bHElcju9ttnzn7Jvihv5CCjy/HtCY90pUgg
         tcrrLvF97OCZu3824HRZYeGsRGAevQJw23a+yRw53JnAq8jvukFy7eN3mRUTZrdskPDW
         iVKc6tOK/39qkujf2DDy5r/rvSpMuRetphZSno33pU8dGpTXEBC8R9z5NsAtoy4FRTX9
         vbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XcIedgRKd4A/e9/Vk0iYyZm/XbgKRfJOO6XAQxSeG7Y=;
        b=vGAp2Hjpymg8ETn2vlTUsKu9ErsA8mmyZJNcAFe+h6IgGGBD32H5faQ+rhpmBbmACE
         diiPZUoscQFukuVBdGQrbqYTksRBLUflyA0w1Atn2kmL9xZJIeb71ZuL8km9xmuCAvb1
         q9Rn6oTw+Lc13qTyhQplQM4NRYPJNdlO4exQuUQZ1nQnPA+c1ClxT1XF++gUGffFps8P
         WLwd8QrQgc2H+9P/U7oClYsFg+tlYH5iYuF/FWwYMNIVJAlE2MWbkMydzqiL61xJiAxm
         HLLXUsEY9PPegS7nMj/7FV2LVfnKOUxFFNbSQ+8ILqSqGPL6Il1DoVYdkAK6dJ3JZ5mJ
         1dyw==
X-Gm-Message-State: AOAM532ux3+KWPY3L/JoKvxIyDoxdUvZ7/VCXq5ciwnFFOWjglyBSy/L
        pLR4+S95l9TiHDr3K6zgsoA=
X-Google-Smtp-Source: ABdhPJxuO9TM+vll1WneXs8MBnfPZ4DyGqCotBs43lRFt5JYEPZuQlVi5kx6gwbfNgLDCcySz5hRBQ==
X-Received: by 2002:a17:906:fc0b:: with SMTP id ov11mr10878057ejb.22.1632486457160;
        Fri, 24 Sep 2021 05:27:37 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:36 -0700 (PDT)
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
Subject: [PATCH v10 08/16] staging: r8188eu: change the type of a variable in rtw_write16()
Date:   Fri, 24 Sep 2021 14:26:57 +0200
Message-Id: <20210924122705.3781-9-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of "data" from __le32 to __le16 in rtw_write16(). The
argument "val", which is u16, after being conditionally swapped to little
endian, is assigned to "data"; therefore, __le16 is the most suitable type
for "data". Remove the bitwise AND of "val" with 0xffff because it is
redundant. Use cpu_to_le16() because "data" is __le16.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 95cd7a6bc28b..5dcab1ee4be0 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -145,7 +145,7 @@ int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intf = &io_priv->intf;
 	u16 value = addr & 0xffff;
-	__le32 data = cpu_to_le32(val & 0x0000ffff);
+	__le16 data = cpu_to_le16(val);
 	int ret;
 
 	ret = usbctrl_vendorreq(intf, value, &data, 2, REALTEK_USB_VENQT_WRITE);
-- 
2.33.0

