Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 167F93545AB
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Apr 2021 18:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbhDEQuf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Apr 2021 12:50:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbhDEQuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Apr 2021 12:50:32 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7CAC061756
        for <linux-kernel@vger.kernel.org>; Mon,  5 Apr 2021 09:50:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so7878562wml.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Apr 2021 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=227hYF+Eha+xMlaisT8IZB9wb/D6fhH9xFrCO6Vdj2M=;
        b=BpK4YjDmOt57tH+cycLHF/FwKcpSm+AshzZmYbw7WfNKPFCfFSUXPu6tjla9Adq9sG
         J5fiHVVBD8wWtQ1Ko0bZBnVlap2mGD7/3idN6F9WBm78+7MHbQ7VrZrOL2we67+rd7A8
         xx44Xaf8Wft+biD6i4f4751nSXb8iRnOYiGqk1iLKkxq7kzMEWxF9UBhNSO+O3LBua0B
         M9LB0kJWzn50QSr1EkXfsfWsrSfrENBEh/xOFt8eXA8rjvwBSQpY1uAJFKO4VstvBBYB
         8FjlgDquTAM2WyUd8hifG2TgZmB8b1oNVPZ+pEum84NufJWYOXM7GeQ9MeNyo0n8lu2I
         Ej8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=227hYF+Eha+xMlaisT8IZB9wb/D6fhH9xFrCO6Vdj2M=;
        b=dP1gxfSyJ2Ct81ybzVXDuoXSrjnExl1C7ROGYK51wQwb5UtD1jF/cguthLy3MZwU+m
         yi07tAO1yuuq9zSEE3Le76GE5pv+AJq5YZ2t6+3W/Ah+Rl8O1t+9wVQGGGqixBmfS+Mr
         mcxcDeFxSh+NyENTonM0h9UmFtx+qiKdTpsMt/nPvJBM4YUpPIGJV1xsUaQtBgBfHqyF
         IxMhA+p1E3z36CgFGv+KyielZmJAz6QW+fRBxG69WS2F129gDMLJdTdXMYsyKBGDN7dS
         wh81lcwIHftHnWd0u5rDjHES/M11QFACkntwbMxjqM5J6DoFeFdIAOx8i1fIwTiTrkDQ
         zw8Q==
X-Gm-Message-State: AOAM5305LfLvcdS11t8nhPx4pMO6zmGKQY2cJRfzkj2YaCHKCqz2sYCl
        aWJ84c9tqJ5VUOX0tF+O6OvDYt78Gz4=
X-Google-Smtp-Source: ABdhPJwbd6zSUNCT9b/aONG7cQUhlBAG0zvxnr3dfHDqnVFwzKY8Zd17Sv5qjRGw4+PKU3m/JbT+Rg==
X-Received: by 2002:a1c:b0c4:: with SMTP id z187mr32905wme.81.1617641424908;
        Mon, 05 Apr 2021 09:50:24 -0700 (PDT)
Received: from agape ([5.171.72.58])
        by smtp.gmail.com with ESMTPSA id k3sm8782711wrc.67.2021.04.05.09.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Apr 2021 09:50:24 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 06/10] staging: rtl8723bs: remove unnecessary bracks after RT_TRACE deletion
Date:   Mon,  5 Apr 2021 18:49:53 +0200
Message-Id: <19fda6f0a2b381399623f5a5def39b07be0d995f.1617640221.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617640221.git.fabioaiuto83@gmail.com>
References: <cover.1617640221.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all unnecessary bracks in if blocks, after RT_TRACE macro
deletion

Suggested-by: Joe Perches <joe@perches.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c |  3 +--
 drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c    |  9 +++------
 drivers/staging/rtl8723bs/hal/sdio_halinit.c      | 15 +++++----------
 drivers/staging/rtl8723bs/hal/sdio_ops.c          |  3 +--
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c    | 10 ++++------
 drivers/staging/rtl8723bs/os_dep/os_intfs.c       |  6 ++----
 drivers/staging/rtl8723bs/os_dep/osdep_service.c  |  3 +--
 drivers/staging/rtl8723bs/os_dep/recv_linux.c     |  3 +--
 drivers/staging/rtl8723bs/os_dep/sdio_intf.c      | 13 +++++--------
 9 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 9fdaefe6e183..4c94202ac209 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -3937,9 +3937,8 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 		{
 			u32 usNavUpper = *((u32 *)val);
 
-			if (usNavUpper > HAL_NAV_UPPER_UNIT_8723B * 0xFF) {
+			if (usNavUpper > HAL_NAV_UPPER_UNIT_8723B * 0xFF)
 				break;
-			}
 
 			usNavUpper = DIV_ROUND_UP(usNavUpper,
 						  HAL_NAV_UPPER_UNIT_8723B);
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
index c18587cc78a5..54f36ca2f810 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723bs_xmit.c
@@ -101,9 +101,8 @@ static s32 rtl8723_dequeue_writeport(struct adapter *padapter)
 	if (
 		(padapter->bSurpriseRemoved) ||
 		(padapter->bDriverStopped)
-	) {
+	)
 		goto free_xmitbuf;
-	}
 
 	if (rtw_sdio_wait_enough_TxOQT_space(padapter, pxmitbuf->agg_num) == false)
 		goto free_xmitbuf;
@@ -145,9 +144,8 @@ s32 rtl8723bs_xmit_buf_handler(struct adapter *padapter)
 	}
 
 	ret = (padapter->bDriverStopped) || (padapter->bSurpriseRemoved);
-	if (ret) {
+	if (ret)
 		return _FAIL;
-	}
 
 	queue_pending = check_pending_xmitbuf(pxmitpriv);
 
@@ -406,9 +404,8 @@ static s32 rtl8723bs_xmit_handler(struct adapter *padapter)
 	if (
 		(padapter->bDriverStopped) ||
 		(padapter->bSurpriseRemoved)
-	) {
+	)
 		return _FAIL;
-	}
 
 	spin_lock_bh(&pxmitpriv->lock);
 	ret = rtw_txframes_pending(padapter);
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index faedeeffcead..cec72abc983c 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -56,9 +56,8 @@ u8 _InitPowerOn_8723BS(struct adapter *padapter)
 
 	/*  only cmd52 can be used before power on(card enable) */
 	ret = CardEnable(padapter);
-	if (!ret) {
+	if (!ret)
 		return _FAIL;
-	}
 
 	/*  Radio-Off Pin Trigger */
 	value8 = rtw_read8(padapter, REG_GPIO_INTM + 1);
@@ -674,9 +673,8 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 /* 	rtw_hal_disable_interrupt(padapter); */
 
 	ret = _InitPowerOn_8723BS(padapter);
-	if (_FAIL == ret) {
+	if (_FAIL == ret)
 		return _FAIL;
-	}
 
 	rtw_write8(padapter, REG_EARLY_MODE_CONTROL, 0);
 
@@ -710,18 +708,16 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 
 #if (HAL_MAC_ENABLE == 1)
 	ret = PHY_MACConfig8723B(padapter);
-	if (ret != _SUCCESS) {
+	if (ret != _SUCCESS)
 		return ret;
-	}
 #endif
 	/*  */
 	/* d. Initialize BB related configurations. */
 	/*  */
 #if (HAL_BB_ENABLE == 1)
 	ret = PHY_BBConfig8723B(padapter);
-	if (ret != _SUCCESS) {
+	if (ret != _SUCCESS)
 		return ret;
-	}
 #endif
 
 	/*  If RF is on, we need to init RF. Otherwise, skip the procedure. */
@@ -730,9 +726,8 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 	{
 #if (HAL_RF_ENABLE == 1)
 		ret = PHY_RFConfig8723B(padapter);
-		if (ret != _SUCCESS) {
+		if (ret != _SUCCESS)
 			return ret;
-		}
 #endif
 	}
 
diff --git a/drivers/staging/rtl8723bs/hal/sdio_ops.c b/drivers/staging/rtl8723bs/hal/sdio_ops.c
index acbb811ced5a..b1f02bb9f0a9 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_ops.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_ops.c
@@ -873,9 +873,8 @@ static struct recv_buf *sd_recv_rxfifo(struct adapter *adapter, u32 size)
 	/* 3 3. read data from rxfifo */
 	readbuf = recvbuf->pskb->data;
 	ret = sdio_read_port(&adapter->iopriv.intf, WLAN_RX0FF_DEVICE_ID, readsize, readbuf);
-	if (ret == _FAIL) {
+	if (ret == _FAIL)
 		return NULL;
-	}
 
 	/* 3 4. init recvbuf */
 	recvbuf->len = size;
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 5b3976216d71..03360af0645d 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -439,9 +439,8 @@ static int wpa_set_encryption(struct net_device *dev, struct ieee_param *param,
 			wep_key_len = wep_key_len <= 5 ? 5 : 13;
 			wep_total_len = wep_key_len + FIELD_OFFSET(struct ndis_802_11_wep, KeyMaterial);
 			pwep = kzalloc(wep_total_len, GFP_KERNEL);
-			if (pwep == NULL) {
+			if (pwep == NULL)
 				goto exit;
-			}
 
 			pwep->KeyLength = wep_key_len;
 			pwep->Length = wep_total_len;
@@ -1488,9 +1487,8 @@ static int rtw_wx_set_essid(struct net_device *dev,
 		pmlmepriv->pscanned = get_next(phead);
 
 		while (1) {
-			if (phead == pmlmepriv->pscanned) {
+			if (phead == pmlmepriv->pscanned)
 				break;
-			}
 
 			pnetwork = container_of(pmlmepriv->pscanned, struct wlan_network, list);
 
@@ -1635,9 +1633,9 @@ static int rtw_wx_set_rate(struct net_device *dev,
 		}
 	}
 
-	if (rtw_setdatarate_cmd(padapter, datarates) != _SUCCESS) {
+	if (rtw_setdatarate_cmd(padapter, datarates) != _SUCCESS)
 		ret = -1;
-	}
+
 	return ret;
 }
 
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 26b77e42c020..fd6309b0bf87 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -869,9 +869,8 @@ static int _netdev_open(struct net_device *pnetdev)
 		padapter->bCardDisableWOHSM = false;
 
 		status = rtw_hal_init(padapter);
-		if (status == _FAIL) {
+		if (status == _FAIL)
 			goto netdev_open_error;
-		}
 
 		DBG_871X("MAC Address = %pM\n", MAC_ARG(pnetdev->dev_addr));
 
@@ -948,9 +947,8 @@ static int  ips_netdrv_open(struct adapter *padapter)
 	/* padapter->bup = true; */
 
 	status = rtw_hal_init(padapter);
-	if (status == _FAIL) {
+	if (status == _FAIL)
 		goto netdev_open_error;
-	}
 
 	if (padapter->intf_start)
 		padapter->intf_start(padapter);
diff --git a/drivers/staging/rtl8723bs/os_dep/osdep_service.c b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
index 7b2aad346d20..5e4200d6b00f 100644
--- a/drivers/staging/rtl8723bs/os_dep/osdep_service.c
+++ b/drivers/staging/rtl8723bs/os_dep/osdep_service.c
@@ -160,9 +160,8 @@ int rtw_change_ifname(struct adapter *padapter, const char *ifname)
 	else
 		ret = register_netdevice(pnetdev);
 
-	if (ret != 0) {
+	if (ret != 0)
 		goto error;
-	}
 
 	return 0;
 
diff --git a/drivers/staging/rtl8723bs/os_dep/recv_linux.c b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
index a2a28803c8d9..63a7e7fe2bb5 100644
--- a/drivers/staging/rtl8723bs/os_dep/recv_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/recv_linux.c
@@ -201,9 +201,8 @@ int rtw_recv_indicatepkt(struct adapter *padapter, union recv_frame *precv_frame
 	pfree_recv_queue = &(precvpriv->free_recv_queue);
 
 	skb = precv_frame->u.hdr.pkt;
-	if (skb == NULL) {
+	if (skb == NULL)
 		goto _recv_indicatepkt_drop;
-	}
 
 	skb->data = precv_frame->u.hdr.rx_data;
 
diff --git a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
index 5da4d271b5ee..f8e1d15f54ef 100644
--- a/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
+++ b/drivers/staging/rtl8723bs/os_dep/sdio_intf.c
@@ -197,9 +197,9 @@ static struct dvobj_priv *sdio_dvobj_init(struct sdio_func *func)
 	psdio = &dvobj->intf_data;
 	psdio->func = func;
 
-	if (sdio_init(dvobj) != _SUCCESS) {
+	if (sdio_init(dvobj) != _SUCCESS)
 		goto free_dvobj;
-	}
+
 	rtw_reset_continual_io_error(dvobj);
 	status = _SUCCESS;
 
@@ -301,9 +301,8 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 	padapter->intf_alloc_irq = &sdio_alloc_irq;
 	padapter->intf_free_irq = &sdio_free_irq;
 
-	if (rtw_init_io_priv(padapter, sdio_set_intf_ops) == _FAIL) {
+	if (rtw_init_io_priv(padapter, sdio_set_intf_ops) == _FAIL)
 		goto free_hal_data;
-	}
 
 	rtw_hal_read_chip_version(padapter);
 
@@ -315,9 +314,8 @@ static struct adapter *rtw_sdio_if1_init(struct dvobj_priv *dvobj, const struct
 	rtw_hal_read_chip_info(padapter);
 
 	/* 3 7. init driver common data */
-	if (rtw_init_drv_sw(padapter) == _FAIL) {
+	if (rtw_init_drv_sw(padapter) == _FAIL)
 		goto free_hal_data;
-	}
 
 	rtw_wdev_alloc(padapter, dvobj_to_dev(dvobj));
 
@@ -397,9 +395,8 @@ static int rtw_drv_init(
 	struct dvobj_priv *dvobj;
 
 	dvobj = sdio_dvobj_init(func);
-	if (dvobj == NULL) {
+	if (dvobj == NULL)
 		goto exit;
-	}
 
 	if1 = rtw_sdio_if1_init(dvobj, id);
 	if (if1 == NULL) {
-- 
2.20.1

