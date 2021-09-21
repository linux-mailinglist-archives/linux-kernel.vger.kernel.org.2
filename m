Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD034139F5
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbhIUSVG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:21:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232759AbhIUSUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:20:36 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA5AC061757
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:05 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id c22so77147704edn.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9EzZ4R4JkBXG+dzDoouCtaaBpzUz1iGVzFC46hdb8Pw=;
        b=DKs9EB8EcnzPOI9SCYyZ3N56/kpQ5CKaPMO/UjwryispNrsQijJQRDNw1LEhhbkvEH
         ktCkYYIXtCrSvGAcJlDonxvrPKxhMY4meUqUFDotQYsdcYKCepBHYik5GoPWyg9u7ciD
         MZ6q0SVrU8X83uYpM0S7SyLcf8JdUBK12HFtToTC/r1kINFK63oQMGKXCRyaWkmbySq6
         feFA0M41dQ6b+3fLpr2l/RRb65tMYgU1mWmv6G2Ey0p5usxHX3vdix2su0KFt4T5FbBA
         gTwzwkU+OSDuS3rJgcFBpT7OHUto/X3jQpS6lg+jcb5sSuhjlGofbfPV49kr6iUMqF0K
         gC5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9EzZ4R4JkBXG+dzDoouCtaaBpzUz1iGVzFC46hdb8Pw=;
        b=DX8gy3iGSmX2I1POdzmW323csPLzZUKwHqPbVwdJpWO6vFG91oKaK9BSZWiuqx3h46
         i0UgRRR78LWkN8vdVPXI36J5vhhUj65S7+oDiLSw9IWzOxXpuSbIqtB+80wZ2cGSg6Kk
         c++Q9cB+hro9EZqxPU3NdxjN9w6g5YR2LAecWIC1nzuD0LdFHtyNQVq0hiN0U38NS311
         +j5GGWu1M+M/pBzxYe6So3dq3Zu96TJ2V16zfG7Nvpkg3GHnclrs7GDRTVB8oaK22KyE
         DR89JY0qvsYlkfX4uxwCA+mRT5qMCPH5XgN0odtUsFs5pCoqkDOTYDv8qfn4ao3HBOJ1
         Qt4g==
X-Gm-Message-State: AOAM533+oSxIoKSZwsgeoZ6HfXvCgDIlUVxxhG4Iy3tVMi3gO9tF8/QR
        ELx8FBy0Vnxiwo2wJkIObkg=
X-Google-Smtp-Source: ABdhPJxuMBl2rorHtad+9+1kg9eb4EmeSX/GM8DnHsJWHfLfdnkq/uhLPcpL5Z+VVKypY/sBub4drg==
X-Received: by 2002:a17:906:ca4b:: with SMTP id jx11mr29294733ejb.52.1632248343916;
        Tue, 21 Sep 2021 11:19:03 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id cn8sm1833162edb.77.2021.09.21.11.19.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:19:03 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v9 08/16] staging: r8188eu: change the type of a variable in rtw_write16()
Date:   Tue, 21 Sep 2021 20:18:26 +0200
Message-Id: <20210921181834.29677-9-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921181834.29677-1-fmdefrancesco@gmail.com>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the type of "data" from __le32 to __le16 in rtw_write16(). The
argument "val", which is u16, after being conditionally swapped to little
endian, is assigned to "data"; therefore, __le16 is the most suitable type
for "data". Remove the bitwise AND of "val" with 0xffff because it is
redundant. Use cpu_to_le16() because "val" is u16.

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

