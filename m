Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6F5F345EC4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 13:59:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhCWM7F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 08:59:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231502AbhCWM63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 08:58:29 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81983C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id r12so26937122ejr.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 05:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Mb74xJj4X7Fk0W46aIpOMrmEyQd8S7cZr54o50UVkWo=;
        b=EgPlfl3kVTpXpdHgw82Om8tWnkPoO0pPCshmHxSh/61ZqhiRTsf8Sm7NwXFH1cK3Eq
         /7Kfih1nJjyuaA4nXumtUB2OPo6XJlsgo6NcrQ2+QdaOjtN2uwcPSlVDRBOw9PYnMapq
         NZQdkSdFpEO42btf6/Miw2mF5nsuNK0qquo/FgbMOiSmWSbeGkElun7fV7PbVuA2va1P
         n0p6/1Pd0/PnFblodytQFniseNGPq4xqQdBX5ETGHO+egmu13zN58jzpLjHLH8azo2dF
         u5CghaSMa+ftl5/ov321wpEQVb5TB4W3rdvM9ZPQotl2votyaVb/8f5XyRIpxQI0gsih
         fpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Mb74xJj4X7Fk0W46aIpOMrmEyQd8S7cZr54o50UVkWo=;
        b=UKkgKN4SXTDfK4LD5LucP/3zCojhHKhdZSOOpWrd4suyRFgMIzPjEjDDLQArfSPRtj
         sfLkyZK8D3LWevZ+aOrO/HCB5/c4X6OlhXEMHtk3qm2CF7wVPDi9B552QiahOrwrRzV8
         Dw1sOnZEibq0nQK/dYxF+yT5LkhyfgHeHHbuU2T5cLSRYf8HJhEjIFR4AhpMXEekaQhw
         f1r2ZClRHzXo7dwPFv3yQ3k2jWfLAMJZ+F9zWJ7iF6e6WmL6/w7orZePdJvkMmHA+Tts
         MJ+Gxki0aGGJ2mCkjv/QYF/ed//XRYxrtgAE9THMz3gf+Nfa4+msxlwYiMjwBRv+QCUg
         sxNg==
X-Gm-Message-State: AOAM530bnCOPQ3aFTusb0hpfHtigGr/90ufpQh6YxrnRgzr5T2Funw6+
        xvol1yQIfYu0E7iug2VKx3g=
X-Google-Smtp-Source: ABdhPJzMWu/kpH8U1YbDFjLTVKSjkii4IqojKYpx81UFyj41WFUzuSXtrHDZ2LQoGtxaZ1hlNn+9Yw==
X-Received: by 2002:a17:906:a896:: with SMTP id ha22mr4700972ejb.503.1616504307276;
        Tue, 23 Mar 2021 05:58:27 -0700 (PDT)
Received: from agape ([151.57.211.10])
        by smtp.gmail.com with ESMTPSA id t12sm13278578edy.56.2021.03.23.05.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 05:58:26 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, apw@canonical.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 7/9] staging: rtl8723bs: remove undefined function prototype in of os_dep/sdio_intf.c
Date:   Tue, 23 Mar 2021 13:56:34 +0100
Message-Id: <06d61465fd33b6cf6d9428ac983e55f50afd448b.1616503354.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1616503354.git.fabioaiuto83@gmail.com>
References: <cover.1616503354.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch issue:

WARNING: externs should be avoided in .c files
486: FILE: drivers/staging/rtl8723bs/os_dep/sdio_intf.c:486:
+extern int pm_netdev_close(struct net_device *pnetdev, u8 bnormal);

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 8f8549eee23e..185919b6963f 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -483,7 +483,6 @@ static void rtw_dev_remove(struct sdio_func *func)
 }
 
 extern int pm_netdev_open(struct net_device *pnetdev, u8 bnormal);
-extern int pm_netdev_close(struct net_device *pnetdev, u8 bnormal);
 
 static int rtw_sdio_suspend(struct device *dev)
 {
-- 
2.20.1

