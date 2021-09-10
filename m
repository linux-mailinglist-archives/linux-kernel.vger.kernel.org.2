Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7009F4070ED
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 20:31:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbhIJScp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 14:32:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbhIJScn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 14:32:43 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6703DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 11:31:32 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id t20so1936022pju.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 11:31:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+yaW+MnHcAMiT6v5gmW51Vj6i+pKWcS5CVSB30Jf6AI=;
        b=nakKVtF10W5ZLh3ZQuvaFCrOERBll0sHW6txMBWA06B7ZQLjT9cTYD7VBaN2nk6/Bp
         m56C1nCb4DHZC1jYAFTn/HQnkyua7GvceZ1L2i/fExbirhQNXxH+dgZbWQ6hrY0xr8C5
         XhNjVwHjBgqXt3QOrl6lcmlIETgNyOmbHTMb+iY+0qyo+gdiYUEE+Z+5iyDv43CV+8xo
         Mt5mfOTTNcp0HbOhp9YJKAh7L+RzmnJ0uJ8tJp5zsfcNgIls/GM2ioNTQt7/g6STi5nB
         duMHcjLmA0PEDow1bmDnGWgasXBrPqzpSkoR5GOsKGkACg9MMfXrRr3liWJspzHnU8Xf
         mq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+yaW+MnHcAMiT6v5gmW51Vj6i+pKWcS5CVSB30Jf6AI=;
        b=rmjX/3MKiDxBiEhNIWSqvBa52srmvx1QSqQMmf1VXQKuBhxJox+3KTx3/ZRt8HUbgi
         njvmfO3ehg7+DMN2q7SuzBY5tQC/Gcd3NsMoP9z/fmxVKykpS+DL6pkSUqFCTZk+hNfN
         LuFqOtasurJssBF+8Nnpt+AM3HF+yKeXH1jooYEUeUonpdhv+Vd6uS3w+RgVp6Zay+9W
         roRxr38uskYPHC9DZZbm+Dpg9MVG3Xym0YM0nQ9ZY/yVehPX+7Djxj5ypJ7fuC4gecWa
         oh9gVnR4rgS8tJGiEfgF+JcNucwLiWA3LKr5tYIEsUFbCiEoCme+rRByUojt7erXmDum
         nzRw==
X-Gm-Message-State: AOAM532yr3TNyn5vZSbYvt0pZf8bCWhPmsSvFnfMaYvL8Z7WlvxJFphb
        1aidShIHdwPCTGd1bik/3sk=
X-Google-Smtp-Source: ABdhPJzngmOnd6/YIM7th9A+yrTjtDG3Q1DFpNjaxxRMcYhRh/QqqTq+6WCkCDz8IdHMYAc7G4cp8A==
X-Received: by 2002:a17:902:b20e:b029:12b:fd6f:44c3 with SMTP id t14-20020a170902b20eb029012bfd6f44c3mr8977203plr.36.1631298691801;
        Fri, 10 Sep 2021 11:31:31 -0700 (PDT)
Received: from user ([117.98.200.228])
        by smtp.gmail.com with ESMTPSA id y126sm5839794pfy.88.2021.09.10.11.31.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 11:31:31 -0700 (PDT)
Date:   Sat, 11 Sep 2021 00:01:25 +0530
From:   Saurav Girepunje <saurav.girepunje@gmail.com>
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        fmdefrancesco@gmail.com, paskripkin@gmail.com,
        saurav.girepunje@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     saurav.girepunje@hotmail.com
Subject: [PATCH] staging: r8188eu: core: remove unused variable padapter
Message-ID: <YTukfSY0CxowGXlQ@user>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove unused variable padapter from mp_init_xmit_attrib().

Signed-off-by: Saurav Girepunje <saurav.girepunje@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_mp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index dabdd0406f30..8ac23d2112fb 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -75,7 +75,7 @@ static void _init_mp_priv_(struct mp_priv *pmp_priv)
 	memcpy(pnetwork->Ssid.Ssid, "mp_871x", pnetwork->Ssid.SsidLength);
 }

-static void mp_init_xmit_attrib(struct mp_tx *pmptx, struct adapter *padapter)
+static void mp_init_xmit_attrib(struct mp_tx *pmptx)
 {
 	struct pkt_attrib *pattrib;
 	struct tx_desc *desc;
@@ -107,7 +107,7 @@ s32 init_mp_priv(struct adapter *padapter)
 	pmppriv->papdater = padapter;

 	pmppriv->tx.stop = 1;
-	mp_init_xmit_attrib(&pmppriv->tx, padapter);
+	mp_init_xmit_attrib(&pmppriv->tx);

 	switch (padapter->registrypriv.rf_config) {
 	case RF_1T1R:
--
2.32.0

