Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DC34139F6
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:19:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233192AbhIUSVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232803AbhIUSUh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:20:37 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC423C061760
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id u27so5524011edi.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C2tlqcJMcGsGx5TiqtBgZeF8XSKZxGfxWP/NlXeWrtk=;
        b=chgjDIOUssRK4i1AXk3hM3NLHNC5IuRFx5H6cib2lOn+FPoqdEYaYs7fEt/8TzNMn1
         yY/nIBvQz/7giqwZRxcVknI7VfjsvSk8uPdSCOP5p+sagDtmtLtCNfpN+QD9B5aDo/K8
         0FiBsIxj/91w9lNaKM9STPcBj+ScYbpwV8Vs799vchVRf5H4ExFpgHsJclewG402cogd
         yoS2GlEI4feB2zmty1sfEbMrffwPiZlSPIIVXVM6hB7oxVRU0BMDm3LW2CmLayxtgRYs
         Nutrr8UBm5wckdBdVppi+O6r1SxIBev81AX4o4efc5MPvluHYCICyR3fI5nVEPkLJHTV
         /aLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C2tlqcJMcGsGx5TiqtBgZeF8XSKZxGfxWP/NlXeWrtk=;
        b=tfkgMlAd5l9jYjQT9J3MDmo73oG0GZRgc/AWbHZeJoYrA65l3ya5EgwaNXoUNFRppU
         UGdHo2E6qpBRSR+qzmkpuOOxBK/hSCEx9cYqSnkz1Y4HxNlz5G5rVC8P6CtFkvZEDsU7
         FTGcTVdMVUDWS0HZSflQkvjFNC2mrOR84y29POFa//3IKhPE4rsG4VIgx1Ifl2P9HmwH
         aVKwANVFZ0rpy+jK6NJ+AKTx9NAOkiS45lPc+yLCtEDnXdMWz+SrxQU7ryx0Su68iQWj
         V1+ufMBnsj1j/eLhYFeGhecY1nHsIjBogJukCiq3Rk0dfwgxD72cH8lJ0+Q+t+mdNZ/q
         NCFQ==
X-Gm-Message-State: AOAM53351JKFRjoeQ+yjEV6AhDQ3BM4qoIxOMydvikBvgY/n9FcAVpIs
        p4Dont3jgfzq0X/EHqe48H4=
X-Google-Smtp-Source: ABdhPJyNQe5Czw66XgXZzjody/XbkoOrMMSkFESkbliRDYsfGeYaAX8e6Dvq9Es3oo3G2kgO/IWN9Q==
X-Received: by 2002:a50:d0d1:: with SMTP id g17mr37784124edf.96.1632248347522;
        Tue, 21 Sep 2021 11:19:07 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id cn8sm1833162edb.77.2021.09.21.11.19.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:19:07 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v9 11/16] staging: r8188eu: change the type of a variable in rtw_read16()
Date:   Tue, 21 Sep 2021 20:18:29 +0200
Message-Id: <20210921181834.29677-12-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921181834.29677-1-fmdefrancesco@gmail.com>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
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

