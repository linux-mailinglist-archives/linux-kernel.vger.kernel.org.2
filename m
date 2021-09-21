Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E4694139F3
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:19:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233065AbhIUSVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbhIUSUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:20:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE88C061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:07 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id v24so77732882eda.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xdFvvX5/HN7bvh9JTzeUFUGFd/lBuWQSjRE1lGqFFEU=;
        b=bgXxtD01Uth7YZjYyLEt3mG+K2B0n4KNi8SDebspVpxfNybeTQAqIzIQn4ktHQyp7m
         g4etEW/xepDscjdEZ0ezPNttfFKnvmXr+WG6DnUC906TDnl4h0z+22navJ7cpu1/yJoL
         2ZilIEZWFLx16KOCmAiLR1lpq6Hi4BkB+DwuL7GY+ggXVAolxFdsHdMaYS6h9ucPpD/p
         yrAwhF9wggAQblqhFDlQKTP40kNwGE6pDr7DgZNi5H14ZwzoUVK7T0nIN1GA44GqzVGM
         YC4u4u29TY3no1xQbnX/63F5R51qLBOxkeCIRCb0OwCPokIYG6mWjVXVtgfaL/6ytwo/
         +jzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xdFvvX5/HN7bvh9JTzeUFUGFd/lBuWQSjRE1lGqFFEU=;
        b=b6dxWTMY5ANiiu4F77BbQ501KiSuAbwrTluVorLzFNU5kS4ElfcJ+wVfBJKj81q4lm
         vCMF3DR0Sm9R/gOBZt6vUPYm9SMQ9KxizS2KZsJh4Yh7G8K62A2Rk+bNZgz+cSxjONm0
         u/upath6l/t4WuTxjHn7mzKdfPU6otvLN2pTz+YoyY3IciWABIUX1At8Nh2J3Ra+X+F2
         9Cw98i2uzEzfb7m31v1mR3MZi1j+sm6QFVA7nPIu3afBg+4YDZiCnk18RNUh1un+kUBy
         sGnfp+f+c2+zuzVamJIGoO0LIz0wGMBXR3MeJZAjOZBTqCVaAhxUQTIPf5U07ufyFYDe
         yvJA==
X-Gm-Message-State: AOAM531ta9ozwSJ/4FSFju7HE9fHJIZKPfZ0eklfPuvHwnt8wn2k7WIO
        7cYVNhGQ0cbGFITvBWJXTow=
X-Google-Smtp-Source: ABdhPJwbufqOE53iQv7IYZ6RKdg5kWOWoID34lHShZxXOQNx199RoU0Af89/dYiRu3E6vDhl+OBjug==
X-Received: by 2002:a17:906:a0c9:: with SMTP id bh9mr36754521ejb.51.1632248346345;
        Tue, 21 Sep 2021 11:19:06 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id cn8sm1833162edb.77.2021.09.21.11.19.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:19:05 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v9 10/16] staging: r8188eu: remove a bitwise AND from rtw_writeN()
Date:   Tue, 21 Sep 2021 20:18:28 +0200
Message-Id: <20210921181834.29677-11-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921181834.29677-1-fmdefrancesco@gmail.com>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove an unnecessary bitwise AND because "length" can never be greater
than 0xffff since VENDOR_CMD_MAX_DATA_LEN is defined as '254'.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 8e4e578ed60b..3b50d2b5c0e3 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -176,7 +176,7 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
 		return _FAIL;
 
-	ret = usbctrl_vendorreq(intf, value, data, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
+	ret = usbctrl_vendorreq(intf, value, data, length, REALTEK_USB_VENQT_WRITE);
 
 	return RTW_STATUS_CODE(ret);
 }
-- 
2.33.0

