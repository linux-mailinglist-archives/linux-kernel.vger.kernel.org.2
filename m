Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76E98410DEC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:56:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233874AbhISX6C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:58:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233625AbhISXzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A711C0613E2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v22so49631903edd.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=erW3613vb3h40I0FgUxVUMwFB8GH00L3QkH0tCAOwl0=;
        b=pyTlF0pfhV3XopquFDBbCbBQSSCeykoAW4AhpebLHotQbXOKBf+EzRaZgGJNFEZuoS
         nMm4IfGY60yzwHVM4ENx813GwG8Ln9ZpDWc9Wkp+BrR172g5XXBFb/zdONRY25thy3qe
         B3w94bSkoXydJLSLGDcn8So5rLLqJJrG4RhGRbpA4QGDyNN8WfDmaSIvkPHZ+vZ+54Sd
         dvQEvVLfgfS5RlmMJP6YflHKwFQB2skKovZhz4VIgbReYbK6ZKkdX2Fuob1cjlkAnq7q
         r3sobxtywJhd9ZHd5R2yoWq0acz5aUz7QoBoGL5r5dPPj50234MIBJd7SAOVJQImtl3Z
         ZRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=erW3613vb3h40I0FgUxVUMwFB8GH00L3QkH0tCAOwl0=;
        b=WRJj17PkYrgY/cBJvM8zn9f5U0RiH1MHO96fD7aKAxeE+pMaVzZn5NceLXKNsWQ929
         0SMldXs5oMpOXw599F8T1GbQbME+I9np1oN1jdoJv4AP8UqKdZ0N88YQhpavcWLjqvtT
         /2bK0vDe5zdKZjIQpR+tUGjtUg1tad7rPIubPexnCWWO1b4it9/mRmgbXAsW7SktGd6E
         auSPsYZmKaJm5ryAqGtSC+cc3Vvsadn3qC5O1PIEGjQt1DZKOX38uKpHK/tCUTpv+kv/
         xhdIHYi0MKDZklKVAEXQswfS2xbdwv4Uf0qpATWmTe2LZ+lSKQh532C4oRk+qdUYs7oC
         dbRQ==
X-Gm-Message-State: AOAM532q4lJ4kJBZ8ZlzN+fvbIo4h3yXzYcK4BMUdE3Mad+tUTGCHyKg
        GaGfcIHPY1X/cKBl2xVmDpU=
X-Google-Smtp-Source: ABdhPJxAP1kk6D7elhi7ouTfo7mvJpY1+/LxsYmU6si6EFCVhNRTjkZhSTe5gfIQsc2jYK+5wPW8dw==
X-Received: by 2002:a50:ff0a:: with SMTP id a10mr26411862edu.273.1632095661721;
        Sun, 19 Sep 2021 16:54:21 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:21 -0700 (PDT)
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
Subject: [PATCH v8 15/19] staging: r8188eu: change the type of a variable in rtw_read16()
Date:   Mon, 20 Sep 2021 01:53:52 +0200
Message-Id: <20210919235356.4151-16-fmdefrancesco@gmail.com>
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
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 625b29af9410..c378b5740353 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -111,11 +111,11 @@ u16 rtw_read16(struct adapter *adapter, u32 addr)
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
 	u16 value = addr & 0xffff;
-	__le32 data;
+	__le16 data;
 
 	usbctrl_vendorreq(intfhdl, value, &data, 2, REALTEK_USB_VENQT_READ);
 
-	return (u16)(le32_to_cpu(data) & 0xffff);
+	return le16_to_cpu(data);
 }
 
 u32 rtw_read32(struct adapter *adapter, u32 addr)
-- 
2.33.0

