Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B38D4139EE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 20:19:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbhIUSUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 14:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232600AbhIUSU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 14:20:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BC0CC061756
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:18:58 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id v22so72740215edd.11
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 11:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hf9oTNZKOUajfI54KCH2+7bKh2Aob9UZCoTzOKf0/U=;
        b=RzG8WEV2SaAw9vef3rPjSCq21ZtGpdiuJUE0vGTkPXA/E3MGk2TmHlt4CrGVp1RZr7
         yq0rWNJmO6ZYMQxu0is9+wEjC1F4+hfccczJKxb+RvDny6EZ1D7cgmT13IojLI6QBLfd
         Nnht2UQnWUNU1zdz0cXO+836GQGzDjsLpfTUv6QNGQ4ZxliHo3FxOehSij/XdlCEIbnK
         HiUZJh1a6B4hCq+7d8mWufYyq+qddQ6bfdveRErMDVbmK8r4kTgkEpQ1/Va/xebCGUJo
         JeBTnkNxwdfZx2v4siG66pWEbfeXoYO1Gp+uwPbcCtcuIZDxmL+f9EEiAw/fhmuR8YrY
         gxwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hf9oTNZKOUajfI54KCH2+7bKh2Aob9UZCoTzOKf0/U=;
        b=F/rWgDLRFFPVtFdCB9AQi64/JBWTinc3FvswHUlj1hdPSHXal7oMzzg1nIQmliEta8
         RNUdn7aa2Lcg9cslh5dsLbyQQ6Cx7WSS+IsJREvBguqfzPL8/ovSJJapn1woRd3m6rID
         3PJ4Yjo31SqOgfgpcEaT6u7rk06Zmye5gU3Hwx239/n4LgEHXpB0vnEAm5xmOs0UoAa1
         ySuIPpJx3iabBFfiBPkqKqWMSu70QlbJe1ciJwMAGeFxW+4K5lRCA15ZavJpFIULolWW
         pVScArZaW6KpU6TE+mchgRBHfkvlnC1j1ilGZw/BQ2yPwzEMzErXsijqwhy8E15ICTM3
         h+og==
X-Gm-Message-State: AOAM530+2LWgmd1GsybIYR4lHGL/QuxDSNcHFB2lSxNY7FS/0QA5N2zN
        xzBV5XzwNwDiGSeeoQpiG4DyoTwD64Y=
X-Google-Smtp-Source: ABdhPJx7KNukFEXXEpPhp3OSqexrTXLxW+hbHVjTmK73kNECyQOY64XMlZGASWVXuLuzgW6uacw8KA==
X-Received: by 2002:a17:907:75ca:: with SMTP id jl10mr36668939ejc.302.1632248336588;
        Tue, 21 Sep 2021 11:18:56 -0700 (PDT)
Received: from localhost.localdomain.it (host-212-171-30-160.retail.telecomitalia.it. [212.171.30.160])
        by smtp.gmail.com with ESMTPSA id cn8sm1833162edb.77.2021.09.21.11.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 11:18:56 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        David Laight <david.Laight@aculab.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Martin Kaiser <martin@kaiser.cx>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH v9 02/16] staging: r8188eu: reorder declarations in usbctrl_vendorreq()
Date:   Tue, 21 Sep 2021 20:18:20 +0200
Message-Id: <20210921181834.29677-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921181834.29677-1-fmdefrancesco@gmail.com>
References: <20210921181834.29677-1-fmdefrancesco@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reorder variables declarations according to the "Reverse Xmas Tree"
style.

Co-developed-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/hal/usb_ops_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
index 3e7bc510197e..84ec7c1346b1 100644
--- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
+++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
@@ -13,10 +13,10 @@ static int usbctrl_vendorreq(struct intf_hdl *intf, u16 value, void *data, u16 l
 	struct adapter *adapt = intf->padapter;
 	struct dvobj_priv *dvobjpriv = adapter_to_dvobj(adapt);
 	struct usb_device *udev = dvobjpriv->pusbdev;
+	int vendorreq_times = 0;
 	unsigned int pipe;
 	int status = 0;
 	u8 *io_buf;
-	int vendorreq_times = 0;
 
 	if ((adapt->bSurpriseRemoved) || (adapt->pwrctrlpriv.pnp_bstop_trx)) {
 		status = -EPERM;
-- 
2.33.0

