Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE794139F8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:19:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbhIUSVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232799AbhIUSUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:20:36 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE0CC06175F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:06 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id dj4so21716055edb.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jb29YhUiEo2/Z5mRHGHyQpktxwm+oorBHIgt3QfLXoY=;
        b=URMx2XgebU4GsiHTakJKa2hvAQhCAn6jYgNz9/6olzBhuDaQLGwFBjjCWlt6XXn/YS
         1QLVlZhCS4eG2+PHnGugfkexR2d25zEc6UJaS7f47lqaRSu+qVWy7/kfR9k4EN/pLg7O
         lb6Q1AXboqqRQJ/MNND77yuRVN4MxQ7lLCnTMYtOkvshA82nkOPSe5gNW6hO7bfj15Ig
         lmgeISiNVhQ0jFTNc+cxGaSuWCTuZXX0DlaB0Cp+nVKIuUMN+970t2QPwNSWTkLFwlWf
         8P+CpUEEUTRTZlt8g5BlpiIOtbavd2Ea0lcRo1ZTGKDASITPeLadMglQniTXImg5UmPk
         c9ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jb29YhUiEo2/Z5mRHGHyQpktxwm+oorBHIgt3QfLXoY=;
        b=Lyb0b4AJ4TsvjIdQt11RVXj30CzriR4qLAPS2vVSsUytnh452Pw4xONfhI9NpRYfT+
         Dc5Jv6lAwtaYriTGfFP7zGJeyHTTX5mNEgiZrJDh1d7VFh1rAWsnh/9G4oNI5Xxf1OfN
         HuXB1pC3DejqTRujA9iSnJqfWEHOZiyAKaFe3/zeUImRu9ibG40vTe02n6xy/jepuWMg
         gzWEUgEXjkvWYB1cYFiBiXh/Y53vuyq0jNDAaIdN48KSTWprKDFJzY/aHME10G/7zYV5
         xc5mX6+6avK89Vfg7CAp7J1y6004UBbg1BPiUK508Up+3fjH8lBOD3Lp1wH8ZYuCTZRr
         WtHg==
X-Gm-Message-State: AOAM53198Cetz5wF9ektfv/m9V2mKhgLLxrhw93Yv3oQZHC2X89rg6H+
        b46x/HDZvKfWebXIa+azp2E=
X-Google-Smtp-Source: ABdhPJwxRy4gRY8l3UrJlgkg2ECP8TQHVjOSB4CYxmcGL4Qzss4ALQTke0trmReRZStF8qjWQlrS/A==
X-Received: by 2002:a50:e085:: with SMTP id f5mr22210630edl.9.1632248345094;
        Tue, 21 Sep 2021 11:19:05 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id cn8sm1833162edb.77.2021.09.21.11.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:19:04 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v9 09/16] staging: r8188eu: remove an buffer from rtw_writeN()
Date:   Tue, 21 Sep 2021 20:18:27 +0200
Message-Id: <20210921181834.29677-10-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921181834.29677-1-fmdefrancesco@gmail.com>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary buffer "u8 buf[VENDOR_CMD_MAX_DATA_LEN]" and
pass "data" directly to usbctrl_vendorreq().

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

