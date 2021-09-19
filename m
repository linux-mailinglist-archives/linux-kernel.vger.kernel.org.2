Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 835BD410DEB
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:56:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbhISX5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbhISXzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:50 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53428C0613D9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:19 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c21so53628706edj.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9iEcs50Nb+e28VH/GVFj+34tTNYlwqWufQuNdGxljS4=;
        b=M6Y7be1MXVcUUSoNuT646ZKS9+KaEP5EcEu5L/ruHAHiQN0rbfzUI5hWQEEAkgbDhR
         5gLmsS1502E8AGWxfcQ1wfap6FGQfnMF7TjIO8PXMY7NEK8Xu7f3mvQoAmQlgWu0mSWl
         ZWmO7Qbvd93E5eMaWjktG92LWaMqTXCF1CMWqksia3YoHquwBZ8zTH7efrMRmW247Miw
         b9c8coo/g3ZUUUhM5DPZbVTB+FopJa5gdENXAQZ+hTg64aFXvuToUuAURoZfUGLXA55j
         /r1L+cP3rvPti7Va/5L/DSqdR9nJZoZ0YYzX1HH3uINGD3XqDT1Eqww+dm38xLnXknbr
         ws9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9iEcs50Nb+e28VH/GVFj+34tTNYlwqWufQuNdGxljS4=;
        b=3rrMJIFE/tAIRkROfP5E2BI1dQLeTF6EQFRwvo0ylpGOyXhRa69o2Udz5XFNu2uyJ6
         SSTyu2dIzk4LbYr9/dlZgYgIhZEuxOiwnCDXrtRxfg3YrGrvgs4VEJymFoPjEDv7BQ50
         g98zhLkz78j6Fk7ekwuQhEVSpavv68jVsdf+2YCWDli3PpbV4IDFpd+miB2B+4eVvlzr
         L/Dr8DlbOgMjFmlejqWVbUnSIg9tOplps7yF/7UgoV1OW2eOw8A48qVhYfWdJw5dtZtS
         o0fn/F6s6ZvaCONnoc9q4H7FCBop8cPaTVimaSo6sSlS44kVCuuWX5x3lmABc0qtnQ1D
         ru5w==
X-Gm-Message-State: AOAM533Y1D6ebJ78gkEXpsdZWF6QQ1eXo9JApVeldlczXk4O8oZSukm8
        cVrcZarb0pvvLsHkQO0I0DQ=
X-Google-Smtp-Source: ABdhPJwnG3bh0CKlNCZDJo5K6+ggTQz/ubE7A6wb2xPExFdARnRK4xXNd5po06QhBlK8L5ciSNlUxQ==
X-Received: by 2002:a50:cf08:: with SMTP id c8mr2784866edk.86.1632095657927;
        Sun, 19 Sep 2021 16:54:17 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:17 -0700 (PDT)
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
Subject: [PATCH v8 12/19] staging: r8188eu: change the type of a variable in rtw_write16()
Date:   Mon, 20 Sep 2021 01:53:49 +0200
Message-Id: <20210919235356.4151-13-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of "data" from __le32 to __le16.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index ba654db869f7..b2a5b6ffbb46 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -147,7 +147,7 @@ int rtw_write16(struct adapter *adapter, u32 addr, u16 val)
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
 	u16 value = addr & 0xffff;
-	__le32 data = cpu_to_le32(val & 0x0000ffff);
+	__le16 data = cpu_to_le16(val);
 	int ret;
 
 	ret = usbctrl_vendorreq(intfhdl, value, &data, 2, REALTEK_USB_VENQT_WRITE);
-- 
2.33.0

