Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 357764171D7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Sep 2021 14:28:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343659AbhIXM3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Sep 2021 08:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343609AbhIXM3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Sep 2021 08:29:16 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C45C061756
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:42 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id ee50so35458852edb.13
        for <linux-kernel@vger.kernel.org>; Fri, 24 Sep 2021 05:27:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2tlqcJMcGsGx5TiqtBgZeF8XSKZxGfxWP/NlXeWrtk=;
        b=NvuMCW+aUEe+rO34+i0dkfagyFCnUsHDoZ42Id4BtabVICgidjyzqXuwnPzOsX6Grc
         ebT5ss6v8EoWbXim8WUwAYcpRRYUDpPhd4eiKUmbK/nIT6TAUildorl2qBpadSv50KpV
         szniFl0+wPLeGEyL/WP+aR7g2Qkc+z3d0ftmNZp7BoRKyF2Ue8962ayPGCcD+IT4D/Zx
         BDAVS8/Zp7Q9WS7r4lsCEpv4Fd7KXFNxkX1sNPg6EwNL6twXGwtG6636A6pDHfUOtX5X
         Jy7G896EteGdUHQTrN3p39GOdrvCNfX7i7GRqbsrOxg0ZepxyDye9Zzv9KrcA3Kg85+X
         0xqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2tlqcJMcGsGx5TiqtBgZeF8XSKZxGfxWP/NlXeWrtk=;
        b=KqIs+PRLOiBm2pWaERoID/zIj6AmQWdzJKNJr4i8O5RG87zQ7XSWqC6qx/XQlvMRFK
         YIP/Pva0vEXX1t09awTsM8cAxKTfLs6vpKu4BOLLK87EhdAWX3bL0ut80gmljyjFzKVU
         498cKHgKexAkdTT6/GoxTQzFKPg71qTN9x4TZhc/jWxx57Dfq7Qxmx876vfDpVu1O9ey
         R6Mq/Lh4h7to6LHvPg3TWjq1zJJGfaR5OmI/UsqAxb3M7Y9yOVU+QDjHfMBemrzOl+MB
         7yQCmHhJsdITdJGjg6O3DSKFN5CyhlpizBqhSiPOCE5zcZHbwcodx8HWofBiVCHLzGhZ
         uFng==
X-Gm-Message-State: AOAM531uqQyYtqxsOuMfKDUVkBIGbX0GssT7gu9VbCyZvUajVOX3eofY
        oeVOV5Q6IZ/Tx/3qLUfCgPk=
X-Google-Smtp-Source: ABdhPJwjq3UnZNEU8xjnA8EyNdjPxAhejmwCUeOoIddLhztuXXKKdvT1reOW/sZmyGvFXLGcAlBQYg==
X-Received: by 2002:aa7:d814:: with SMTP id v20mr4709387edq.169.1632486461404;
        Fri, 24 Sep 2021 05:27:41 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id v13sm4882522ejh.62.2021.09.24.05.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 05:27:40 -0700 (PDT)
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
Subject: [PATCH v10 11/16] staging: r8188eu: change the type of a variable in rtw_read16()
Date:   Fri, 24 Sep 2021 14:27:00 +0200
Message-Id: <20210924122705.3781-12-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210924122705.3781-1-fmdefrancesco@gmail.com>
References: <20210924122705.3781-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of "data" from __le32 to __le16. The size of the data
that usbctrl_vendorreq() will read is two bytes in little endian order,
so the most suitable type is __le16.

With the old code, since the two most significant bytes of data are not
initialized, KMSan can likely detect the reading of uninitialized data,
so this change can prevent the checker from complaining.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 3b50d2b5c0e3..04a878c1a87d 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -109,11 +109,11 @@ u16 rtw_read16(struct adapter *adapter, u32 addr)
 	struct io_priv *io_priv = &adapter->iopriv;
 	struct intf_hdl *intf = &io_priv->intf;
 	u16 value = addr & 0xffff;
-	__le32 data;
+	__le16 data;
 
 	usbctrl_vendorreq(intf, value, &data, 2, REALTEK_USB_VENQT_READ);
 
-	return (u16)(le32_to_cpu(data) & 0xffff);
+	return le16_to_cpu(data);
 }
 
 u32 rtw_read32(struct adapter *adapter, u32 addr)
-- 
2.33.0

