Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72733410DF1
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 01:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234196AbhISX6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Sep 2021 19:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233693AbhISXzv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Sep 2021 19:55:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC85C0613DE
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:20 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id n10so53227446eda.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Sep 2021 16:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4qsIiH/RtEI2IhNpJD4OpYNAp+b7Sl9kBKeEhQ/lxNQ=;
        b=Gq9HmhJp0JB3sJnp6R8LL4gAWKIzQ3xCtQTt36PLFExGrps+RlR1lk+4ZO/5B2x7a0
         suepHdaexHh9VdIXXfi2ZCMk4Mta9qhwphaMURp91WvIgbh7QU+yBmK3J83uF+cm4CQH
         pc93yH/dDksfkNv9W5gAEwHTYDHn6lAvY5oQOar8LjUvnW8d178eRa46lJeaufQwzJ5D
         UxXdCRleLZ2R9txaI+h5L0xypoYiv5JGOM4TkZRCqNBiqfRdFbk6vrCRrYT9EGeizP/a
         9QKfxdaigKVwxVWbLJ3eGic8aFH8CtsdkCth/PISFrql3On5bq7rTATPL9gXQ2QaqyIl
         VQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4qsIiH/RtEI2IhNpJD4OpYNAp+b7Sl9kBKeEhQ/lxNQ=;
        b=4VAODE1VDqrrE/oizduz9d0SL9wWzrLA1U5JIh7osjM3xQITsqGnq1+teywsq2T8kF
         SZ8jFxh/NXBcI3mY7UGR7HXgV2FScha12oq1i2L0nrgKU1hiiq7O0xC43EGz9ljJg9oT
         mmzymNqNkXaMAlvRGGF2m6yI+AGUrOzhHRY+lh3jssLEpGz1MOTGQlcQCpdAwg7tlHPe
         P40xFETcu2T/ar759M/svcNu04gYK8CFCVjRS7PgSD5nXdB3IADEr1R1YA1SqKLQtXtu
         4xByrIX37YVi3k3IBh01WCPCO8AtS2s3R9K6WfPXiSR7vYFH9iKEuFehUMsDn45OpRH+
         /zbw==
X-Gm-Message-State: AOAM531IaMunGcjT7PN6Cfmk4DHQAUiDw70n/NvZxMutZCQci6ozBBOe
        kwzu4aw67feB+/A06JK8IIdbKG4DrRA=
X-Google-Smtp-Source: ABdhPJztk56cfL4Mcg+JiuQf0oLYinFckc79mTfAuYlTa0ubF4OyT8hDQ/UnAnFfMoFkBwkMd3Ixrg==
X-Received: by 2002:a50:cd87:: with SMTP id p7mr26531356edi.294.1632095659186;
        Sun, 19 Sep 2021 16:54:19 -0700 (PDT)
Received: from localhost.localdomain (host-79-47-104-104.retail.telecomitalia.it. [79.47.104.104])
        by smtp.gmail.com with ESMTPSA id e11sm5353636ejm.41.2021.09.19.16.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Sep 2021 16:54:18 -0700 (PDT)
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
Subject: [PATCH v8 13/19] staging: r8188eu: remove an unneeded buffer from rtw_writeN()
Date:   Mon, 20 Sep 2021 01:53:50 +0200
Message-Id: <20210919235356.4151-14-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210919235356.4151-1-fmdefrancesco@gmail.com>
References: <20210919235356.4151-1-fmdefrancesco@gmail.com>
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
index b2a5b6ffbb46..aa57bd7b8f10 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -173,14 +173,12 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intfhdl = &io_priv->intf;
 	u16 value = addr & 0xffff;
-	u8 buf[VENDOR_CMD_MAX_DATA_LEN] = {0};
 	int ret;
 
 	if (length > VENDOR_CMD_MAX_DATA_LEN)
 		return _FAIL;
 
-	memcpy(buf, data, length);
-	ret = usbctrl_vendorreq(intfhdl, value, buf, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
+	ret = usbctrl_vendorreq(intfhdl, value, data, (length & 0xffff), REALTEK_USB_VENQT_WRITE);
 
 	return RTW_STATUS_CODE(ret);
 }
-- 
2.33.0

