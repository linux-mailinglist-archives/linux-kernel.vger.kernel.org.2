Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 652BE351225
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234561AbhDAJYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234061AbhDAJWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:39 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8C33C0617AA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:37 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id e7so1137757edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j8yBh+QrAemiC0bPY4Ow5WV3STLbPxKdPO1253KlO8E=;
        b=OhpN8VvpGm0bFGtgRnt1NDcbV70nSeMs7fv69TeRd03m/KluDthTV6/M/Gf6VzA658
         oA8cfGd0wPyW7U80eJBdD89tQG8h5PGR3AxCyNHDqhT+8JVSHLiqW11FriP4fZaLLkpi
         K8uHfQlzvHWTTITijhWb0InGA20tPJmaow4G1bPyleK1pF/GvetVXcy8nxKTV8UTNQr6
         3mZ/lSlGw/0gEkT4/jOdG+pk0YPCvAIi7Ps4upYwD1jtqSOowl7LRjwOmaLOJReQrcLZ
         aLYJJzaOevrm+mAP3KIk6B/t0VxmRjZ/Nx3jxX5LbwRA4qn8YKz7zpYPyXtCX6z/RV9c
         61eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j8yBh+QrAemiC0bPY4Ow5WV3STLbPxKdPO1253KlO8E=;
        b=g64adx2BGuzrwqN6ZTCDgS+q19t32ENg6m3L7yNmR4Y1SlTUp/bNJEMpEFn5ZQcikh
         WgznkQaXe8COSeoeK9FZ4xIzaBlYQ+8I38mL+t69IJE4aitfO7gXNPgmEA3QVg3Kg974
         ec/rbs6rdGUCf1TVwn8fR20JlLt1E3OZ/cmFm6hKhfClrxhBm26qxRSCyzrZb56UP+a3
         ps7pPr+vcgPH7M1rfOGIwgrJ57xV6vXXTO76JbZKI6B3G1j+JExjXzXsLjNyUdqrGX3w
         SuEtZ5R+Yh0q1Yimqyo8VpRHH+AZL1aoQoYZhQMDt2um0Za69jUAhuenSkPe4jYHcuZu
         hpYg==
X-Gm-Message-State: AOAM531SbX489bO+peEHg4Dfw3blIVP7N7Zv+kj/LHmPudEThNxKOxDd
        daUZPnQZ9iuzF4mibwnzlOk=
X-Google-Smtp-Source: ABdhPJzs1aZHMP3M9CxAAP2l/WDqbK0qVH9aqo7hvWt/RD4Af/18tdUhCOw7N0bgNg3iOmN9vXvjbw==
X-Received: by 2002:a05:6402:438f:: with SMTP id o15mr8833029edc.123.1617268956527;
        Thu, 01 Apr 2021 02:22:36 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id g20sm3083129edb.7.2021.04.01.02.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:36 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 45/49] staging: rtl8723bs: remove RT_TRACE logs in os_dep/sdio_intf.c
Date:   Thu,  1 Apr 2021 11:21:15 +0200
Message-Id: <1efd90da9a2d3b1456f2fe47b28543e0ef5b1fb7.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index b6be1423ef75..fecb43b870d7 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -159,9 +159,6 @@ static void sdio_deinit(struct dvobj_priv *dvobj)
 	struct sdio_func *func;
 	int err;
 
-
-	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("+sdio_deinit\n"));
-
 	func = dvobj->intf_data.func;
 
 	if (func) {
@@ -201,7 +198,6 @@ static struct dvobj_priv *sdio_dvobj_init(struct sdio_func *func)
 	psdio->func = func;
 
 	if (sdio_init(dvobj) != _SUCCESS) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("%s: initialize SDIO Failed!\n", __func__));
 		goto free_dvobj;
 	}
 	rtw_reset_continual_io_error(dvobj);
@@ -306,8 +302,6 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 	padapter->intf_free_irq = &sdio_free_irq;
 
 	if (rtw_init_io_priv(padapter, sdio_set_intf_ops) == _FAIL) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
-			("rtw_drv_init: Can't init io_priv\n"));
 		goto free_hal_data;
 	}
 
@@ -322,8 +316,6 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 
 	/* 3 7. init driver common data */
 	if (rtw_init_drv_sw(padapter) == _FAIL) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_,
-			 ("rtw_drv_init: Initialize driver software resource Failed!\n"));
 		goto free_hal_data;
 	}
 
@@ -406,7 +398,6 @@ static int rtw_drv_init(
 
 	dvobj = sdio_dvobj_init(func);
 	if (dvobj == NULL) {
-		RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("initialize device object priv Failed!\n"));
 		goto exit;
 	}
 
@@ -424,8 +415,6 @@ static int rtw_drv_init(
 	if (sdio_alloc_irq(dvobj) != _SUCCESS)
 		goto free_if2;
 
-	RT_TRACE(_module_hci_intfs_c_, _drv_err_, ("-871x_drv - drv_init, success!\n"));
-
 	rtw_ndev_notifier_register();
 	status = _SUCCESS;
 
@@ -447,8 +436,6 @@ static void rtw_dev_remove(struct sdio_func *func)
 	struct dvobj_priv *dvobj = sdio_get_drvdata(func);
 	struct adapter *padapter = dvobj->if1;
 
-	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("+rtw_dev_remove\n"));
-
 	dvobj->processing_dev_remove = true;
 
 	rtw_unregister_netdevs(dvobj);
@@ -479,7 +466,6 @@ static void rtw_dev_remove(struct sdio_func *func)
 
 	sdio_dvobj_deinit(func);
 
-	RT_TRACE(_module_hci_intfs_c_, _drv_notice_, ("-rtw_dev_remove\n"));
 }
 
 static int rtw_sdio_suspend(struct device *dev)
-- 
2.20.1

