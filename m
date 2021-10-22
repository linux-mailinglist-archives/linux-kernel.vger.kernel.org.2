Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BF5437620
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 13:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232756AbhJVLmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Oct 2021 07:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232682AbhJVLmB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Oct 2021 07:42:01 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991A8C061764
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 04:39:43 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id e19so1921845edy.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Oct 2021 04:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g7Q9pJ+WrRHjtbL9qN8GaIdJ4pUYdhRfwzGTptegbRI=;
        b=jqonEAlJuFH6wlAQgRO6Uff5SUxr68DmT3Wn8ClHbF5nm91AB5NfFFxY1dvglNflcd
         cuNAUC/AJJeBRXKI6OCF/v1bT2nyhMc3rmdQza5KKhzJGJ6HZR52dotcCntXrGY6JuEj
         hKhuLv6tinJV4JfpQvVuByWzqBCwr4d3L3zYxkRzA8thsAMr/XzOAnSF+Zy51yhf2777
         l3qgmYs7pHydwfPkkPYH3imoWr0gmVUzhVbYc9nCz4nNWe9lvRyTDz6yT4hHDAYHGazr
         Vaz1mQ8ZHYUEAY9Zn01d7kEUQYwbv2JU1GbUNsumxX21PCbKOlq24TXyWS/HCncAqAF0
         4gxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g7Q9pJ+WrRHjtbL9qN8GaIdJ4pUYdhRfwzGTptegbRI=;
        b=1IRIEpMQXiNdvM7aY3ujGhcBgNm9MYE/4W3aGfDcDEMsYB4j7KpkLCln/dTG46Z9Af
         bjRWuRtV7S3oAz/AEEGtQzXIMKEdsmzoEk/rBqpnHiI8O3a6U3y0t9bcSvN5GzquvBJl
         NOIcvspOWPEqKI5VXIwbjxWX2nQA5/3YEsLRsPelIearW39d/Smutprh0WX4XrqiEJrz
         Q7QTefIpLUqHdOvsvpQ22Uw3CMZsint4p/rbavBMqw0z0OuA53iI1PlClGfJLaQbKs1a
         pLP0U+sKCPYaelvmd1yYCmW7u0MmwGqibw1UWRxSG7RkBcpVeZeg3JR/NrFpnauRMLyN
         qb6A==
X-Gm-Message-State: AOAM530pymVrkSR83qBNJ9vozDG91nurZ26eD/hoP+JTFwF8X9n02N1h
        e+p0pXUJLI56fO1CUvxpWDQ=
X-Google-Smtp-Source: ABdhPJz7i5IO2AaA7gvNTE41DlUCK9pe/shJ7tS5vNbMQuHUUQCUXUo0H9FTEaYATyhSe4duyr+xvw==
X-Received: by 2002:a17:906:84e:: with SMTP id f14mr14879434ejd.105.1634902782115;
        Fri, 22 Oct 2021 04:39:42 -0700 (PDT)
Received: from localhost.localdomain (host-80-181-148-119.retail.telecomitalia.it. [80.181.148.119])
        by smtp.gmail.com with ESMTPSA id j15sm4360050edl.34.2021.10.22.04.39.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 04:39:41 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [PATCH] staging: r8188eu: Remove four unused semaphores
Date:   Fri, 22 Oct 2021 13:39:36 +0200
Message-Id: <20211022113936.7909-1-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove four initialized but unused semaphores.

Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_recv.c     | 2 --
 drivers/staging/r8188eu/core/rtw_xmit.c     | 3 ---
 drivers/staging/r8188eu/include/drv_types.h | 1 -
 drivers/staging/r8188eu/include/rtw_recv.h  | 1 -
 drivers/staging/r8188eu/include/rtw_xmit.h  | 2 --
 drivers/staging/r8188eu/os_dep/usb_intf.c   | 1 -
 6 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 51a13262a226..23f251827310 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -81,8 +81,6 @@ int _rtw_init_recv_priv(struct recv_priv *precvpriv, struct adapter *padapter)
 	}
 	precvpriv->rx_pending_cnt = 1;
 
-	sema_init(&precvpriv->allrxreturnevt, 0);
-
 	res = rtl8188eu_init_recv_priv(padapter);
 
 	timer_setup(&precvpriv->signal_stat_timer, rtw_signal_stat_timer_hdl, 0);
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 0c033a077bf9..dbb5baa145c5 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -49,7 +49,6 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 	/*  We don't need to memset padapter->XXX to zero, because adapter is allocated by vzalloc(). */
 
 	spin_lock_init(&pxmitpriv->lock);
-	sema_init(&pxmitpriv->terminate_xmitthread_sema, 0);
 
 	/*
 	Please insert all the queue initializaiton using rtw_init_queue below
@@ -187,8 +186,6 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
 
 	pxmitpriv->txirp_cnt = 1;
 
-	sema_init(&pxmitpriv->tx_retevt, 0);
-
 	/* per AC pending irp */
 	pxmitpriv->beq_cnt = 0;
 	pxmitpriv->bkq_cnt = 0;
diff --git a/drivers/staging/r8188eu/include/drv_types.h b/drivers/staging/r8188eu/include/drv_types.h
index 3e4928320f17..60140ae42dca 100644
--- a/drivers/staging/r8188eu/include/drv_types.h
+++ b/drivers/staging/r8188eu/include/drv_types.h
@@ -152,7 +152,6 @@ struct dvobj_priv {
 	u8	RtNumOutPipes;
 	int	ep_num[5]; /* endpoint number */
 	int	RegUsbSS;
-	struct semaphore usb_suspend_sema;
 	struct mutex  usb_vendor_req_mutex;
 
 	struct usb_interface *pusbintf;
diff --git a/drivers/staging/r8188eu/include/rtw_recv.h b/drivers/staging/r8188eu/include/rtw_recv.h
index 1e28ec731547..2557d0e9b3bd 100644
--- a/drivers/staging/r8188eu/include/rtw_recv.h
+++ b/drivers/staging/r8188eu/include/rtw_recv.h
@@ -176,7 +176,6 @@ struct recv_priv {
 	uint  rx_largepacket_crcerr;
 	uint  rx_smallpacket_crcerr;
 	uint  rx_middlepacket_crcerr;
-	struct semaphore allrxreturnevt;
 	uint	ff_hwaddr;
 	u8	rx_pending_cnt;
 
diff --git a/drivers/staging/r8188eu/include/rtw_xmit.h b/drivers/staging/r8188eu/include/rtw_xmit.h
index b2df1480d66b..156ec9cebad6 100644
--- a/drivers/staging/r8188eu/include/rtw_xmit.h
+++ b/drivers/staging/r8188eu/include/rtw_xmit.h
@@ -256,7 +256,6 @@ struct agg_pkt_info {
 
 struct	xmit_priv {
 	spinlock_t lock;
-	struct semaphore terminate_xmitthread_sema;
 	struct __queue be_pending;
 	struct __queue bk_pending;
 	struct __queue vi_pending;
@@ -281,7 +280,6 @@ struct	xmit_priv {
 	u8	wmm_para_seq[4];/* sequence for wmm ac parameter strength
 				 * from large to small. it's value is 0->vo,
 				 * 1->vi, 2->be, 3->bk. */
-	struct semaphore tx_retevt;/* all tx return event; */
 	u8		txirp_cnt;/*  */
 	struct tasklet_struct xmit_tasklet;
 	/* per AC pending irp */
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 40f2481afc6f..7ed9f5f54472 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -129,7 +129,6 @@ static struct dvobj_priv *usb_dvobj_init(struct usb_interface *usb_intf)
 	}
 
 	/* 3 misc */
-	sema_init(&pdvobjpriv->usb_suspend_sema, 0);
 	rtw_reset_continual_urb_error(pdvobjpriv);
 
 	usb_get_dev(pusbd);
-- 
2.33.1

