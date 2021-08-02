Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15633DDC1F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Aug 2021 17:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhHBPQT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Aug 2021 11:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234885AbhHBPQK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Aug 2021 11:16:10 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D175C06175F
        for <linux-kernel@vger.kernel.org>; Mon,  2 Aug 2021 08:16:01 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 61-20020a9d0d430000b02903eabfc221a9so17831936oti.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Aug 2021 08:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UUGsT9ZBKIoOMU3i/IfKC7jHLnds9a6HaJpB/flOpvY=;
        b=pIAKNmw5M9IgzkSaPReZMy0zN6VPTAaXDDeTV8B9h2f9jyi2bIYz66D4vK/ief2zcA
         MQ9c4f0aXli7NRLa4gDXfN0NWuiofJwMQc1V6x9c0QgjvAMTIS/b8IgSSoujZKhowrXv
         aGd8x8OmIdnlb6xGTSYebmQttqVGy/TmkxJcZHgdG3ShY1g+2jtTQEbZAX1/k3/MZPxL
         u9mfgeWr/5Iuv0Oh9zeCxIJPbXRO3ZVRwdNkQsElODWNWFJji1CsRgfPGooEPOy0Huis
         ef15jqTSESVzmVELueecFQeEcr8fNq7F9pgjqRcoykRJ0mRuBxU8F7heqEeAdcte5+/q
         nw2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=UUGsT9ZBKIoOMU3i/IfKC7jHLnds9a6HaJpB/flOpvY=;
        b=AB6E/j89agi/IyLxILFn1drggu56vSt7T6Zo5RrF9ZikB2/gicWYkkJx708f8pY+sv
         o7I1Yyff4CMyBTO/6S9AwiL2ir08codq14sBTXFltg16WEuIC0EDCWG/JQQBGrPKxDR3
         M5I3jtD21nwQ2XZgpxH6eUGxVZfySzwnj5Kypg4Wbh965lUcHHwsNcDnSkVAXMSbmWR8
         qNSrOTB/KOK+XxB7pGw1Y2O0ywG+/hiNue5W2UzhIXhzzmutXh3nEze28thV0y9yZ4v3
         LL3T8FlkKDd2tasnJ4sbDnv1G84ECeP0dIlVaDg3n5LAS+SOM4jga2gfGFDavSqdwoWD
         gofQ==
X-Gm-Message-State: AOAM532FOSymLtPRNUsLwEKjYSktgnzvlXI6sy8KYUMX8zf0Sbph7c5V
        00441CYyvAquWkdsD1rjo0A=
X-Google-Smtp-Source: ABdhPJwGcKgKHE+cI2p/kOMj+8O6mHUICeEUItfCqqGMp33rtEQUM3JvDNLB9R1plWDYX7OeDtpd2Q==
X-Received: by 2002:a9d:17e8:: with SMTP id j95mr11451523otj.263.1627917360388;
        Mon, 02 Aug 2021 08:16:00 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-100a.res6.spectrum.com. [2603:8090:2005:39b3::100a])
        by smtp.gmail.com with ESMTPSA id w16sm1807034oiv.15.2021.08.02.08.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 08:15:59 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/6] staging: r8188eu: Remove wrapper around vfree
Date:   Mon,  2 Aug 2021 10:15:42 -0500
Message-Id: <20210802151546.31797-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210802151546.31797-1-Larry.Finger@lwfinger.net>
References: <20210802151546.31797-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This call is so simple that there is no need, or use, for a wrapper.

Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
---
 drivers/staging/r8188eu/core/rtw_mlme.c         |  4 +---
 drivers/staging/r8188eu/core/rtw_mp.c           |  3 +--
 drivers/staging/r8188eu/core/rtw_recv.c         |  5 +----
 drivers/staging/r8188eu/core/rtw_sta_mgt.c      |  2 +-
 drivers/staging/r8188eu/core/rtw_xmit.c         | 10 +++-------
 drivers/staging/r8188eu/hal/odm_interface.c     |  2 +-
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  2 +-
 drivers/staging/r8188eu/include/osdep_service.h |  2 --
 drivers/staging/r8188eu/os_dep/ioctl_linux.c    |  4 ++--
 drivers/staging/r8188eu/os_dep/osdep_service.c  |  7 +------
 drivers/staging/r8188eu/os_dep/usb_intf.c       |  2 +-
 11 files changed, 13 insertions(+), 30 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index d8716a8b224a..5f8e58a0372a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -133,9 +133,7 @@ void _rtw_free_mlme_priv (struct mlme_priv *pmlmepriv)
 	if (pmlmepriv) {
 		rtw_mfree_mlme_priv_lock (pmlmepriv);
 
-		if (pmlmepriv->free_bss_buf) {
-			rtw_vmfree(pmlmepriv->free_bss_buf, MAX_BSS_CNT * sizeof(struct wlan_network));
-		}
+		vfree(pmlmepriv->free_bss_buf);
 	}
 
 }
diff --git a/drivers/staging/r8188eu/core/rtw_mp.c b/drivers/staging/r8188eu/core/rtw_mp.c
index a12c6e0ad002..c579f2e2fd62 100644
--- a/drivers/staging/r8188eu/core/rtw_mp.c
+++ b/drivers/staging/r8188eu/core/rtw_mp.c
@@ -922,8 +922,7 @@ void _rtw_mp_xmit_priv(struct xmit_priv *pxmitpriv)
 		pxmitbuf++;
 	}
 
-	if (pxmitpriv->pallocated_xmit_extbuf)
-		rtw_vmfree(pxmitpriv->pallocated_xmit_extbuf, num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
+	vfree(pxmitpriv->pallocated_xmit_extbuf);
 
 	if (padapter->registrypriv.mp_mode == 0) {
 		max_xmit_extbuf_size = 6000;
diff --git a/drivers/staging/r8188eu/core/rtw_recv.c b/drivers/staging/r8188eu/core/rtw_recv.c
index 610cc699caf9..08e095cd08b8 100644
--- a/drivers/staging/r8188eu/core/rtw_recv.c
+++ b/drivers/staging/r8188eu/core/rtw_recv.c
@@ -115,12 +115,9 @@ void _rtw_free_recv_priv (struct recv_priv *precvpriv)
 
 	rtw_os_recv_resource_free(precvpriv);
 
-	if (precvpriv->pallocated_frame_buf) {
-		rtw_vmfree(precvpriv->pallocated_frame_buf, NR_RECVFRAME * sizeof(struct recv_frame) + RXFRAME_ALIGN_SZ);
-	}
+	vfree(precvpriv->pallocated_frame_buf);
 
 	rtw_hal_free_recv_priv(padapter);
-
 }
 
 struct recv_frame *_rtw_alloc_recvframe (struct __queue *pfree_recv_queue)
diff --git a/drivers/staging/r8188eu/core/rtw_sta_mgt.c b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
index feaf39fddf7c..3b1a6a689d95 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -233,7 +233,7 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 		rtw_mfree_sta_priv_lock(pstapriv);
 
 		if (pstapriv->pallocated_stainfo_buf)
-			rtw_vmfree(pstapriv->pallocated_stainfo_buf, sizeof(struct sta_info)*NUM_STA+4);
+			vfree(pstapriv->pallocated_stainfo_buf);
 		}
 
 	return _SUCCESS;
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 408d2b9955b9..87aa45c0305a 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -252,11 +252,9 @@ void _rtw_free_xmit_priv (struct xmit_priv *pxmitpriv)
 		pxmitbuf++;
 	}
 
-	if (pxmitpriv->pallocated_frame_buf)
-		rtw_vmfree(pxmitpriv->pallocated_frame_buf, NR_XMITFRAME * sizeof(struct xmit_frame) + 4);
+	vfree(pxmitpriv->pallocated_frame_buf);
 
-	if (pxmitpriv->pallocated_xmitbuf)
-		rtw_vmfree(pxmitpriv->pallocated_xmitbuf, NR_XMITBUFF * sizeof(struct xmit_buf) + 4);
+	vfree(pxmitpriv->pallocated_xmitbuf);
 
 	/*  free xmit extension buff */
 	_rtw_spinlock_free(&pxmitpriv->free_xmit_extbuf_queue.lock);
@@ -267,9 +265,7 @@ void _rtw_free_xmit_priv (struct xmit_priv *pxmitpriv)
 		pxmitbuf++;
 	}
 
-	if (pxmitpriv->pallocated_xmit_extbuf) {
-		rtw_vmfree(pxmitpriv->pallocated_xmit_extbuf, num_xmit_extbuf * sizeof(struct xmit_buf) + 4);
-	}
+	vfree(pxmitpriv->pallocated_xmit_extbuf);
 
 	rtw_free_hwxmits(padapter);
 
diff --git a/drivers/staging/r8188eu/hal/odm_interface.c b/drivers/staging/r8188eu/hal/odm_interface.c
index 507baf9fd913..38f6ae410e53 100644
--- a/drivers/staging/r8188eu/hal/odm_interface.c
+++ b/drivers/staging/r8188eu/hal/odm_interface.c
@@ -85,7 +85,7 @@ void ODM_AllocateMemory(struct odm_dm_struct *pDM_Odm, void **pPtr, u32 length)
 /*  length could be ignored, used to detect memory leakage. */
 void ODM_FreeMemory(struct odm_dm_struct *pDM_Odm, void *pPtr, u32 length)
 {
-	rtw_vmfree(pPtr, length);
+	vfree(pPtr);
 }
 
 s32 ODM_CompareMemory(struct odm_dm_struct *pDM_Odm, void *pBuf1, void *pBuf2, u32 length)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 62d8a7ca3a9a..a8e2081f3540 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -363,7 +363,7 @@ void rtw_IOL_cmd_tx_pkt_buf_dump(struct adapter *Adapter, int data_len)
 			} while (!rstatus && (loop++ < 10));
 		}
 		rtw_IOL_cmd_buf_dump(Adapter, data_len, pbuf);
-		rtw_vmfree(pbuf, data_len+10);
+		vfree(pbuf);
 	}
 	DBG_88E("###### %s ######\n", __func__);
 }
diff --git a/drivers/staging/r8188eu/include/osdep_service.h b/drivers/staging/r8188eu/include/osdep_service.h
index 30f645d89fe8..48d49919b2d5 100644
--- a/drivers/staging/r8188eu/include/osdep_service.h
+++ b/drivers/staging/r8188eu/include/osdep_service.h
@@ -214,10 +214,8 @@ extern unsigned char RSN_TKIP_CIPHER[4];
 #define rtw_update_mem_stat(flag, sz) do {} while (0)
 u8 *_rtw_vmalloc(u32 sz);
 u8 *_rtw_zvmalloc(u32 sz);
-void _rtw_vmfree(u8 *pbuf, u32 sz);
 #define rtw_vmalloc(sz)			_rtw_vmalloc((sz))
 #define rtw_zvmalloc(sz)			_rtw_zvmalloc((sz))
-#define rtw_vmfree(pbuf, sz)		_rtw_vmfree((pbuf), (sz))
 
 void *rtw_malloc2d(int h, int w, int size);
 
diff --git a/drivers/staging/r8188eu/os_dep/ioctl_linux.c b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
index 5f4355cb03e7..11301e0f287a 100644
--- a/drivers/staging/r8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/r8188eu/os_dep/ioctl_linux.c
@@ -5575,7 +5575,7 @@ static int rtw_wx_set_priv(struct net_device *dev,
 		return -ENOMEM;
 
 	if (copy_from_user(ext, dwrq->pointer, len)) {
-		rtw_vmfree(ext, len);
+		vfree(ext);
 		return -EFAULT;
 	}
 
@@ -5614,7 +5614,7 @@ static int rtw_wx_set_priv(struct net_device *dev,
 
 FREE_EXT:
 
-	rtw_vmfree(ext, len);
+	vfree(ext);
 
 	return ret;
 }
diff --git a/drivers/staging/r8188eu/os_dep/osdep_service.c b/drivers/staging/r8188eu/os_dep/osdep_service.c
index d537f6352fc5..dab61fac976c 100644
--- a/drivers/staging/r8188eu/os_dep/osdep_service.c
+++ b/drivers/staging/r8188eu/os_dep/osdep_service.c
@@ -53,11 +53,6 @@ inline u8 *_rtw_zvmalloc(u32 sz)
 	return pbuf;
 }
 
-inline void _rtw_vmfree(u8 *pbuf, u32 sz)
-{
-	vfree(pbuf);
-}
-
 void *rtw_malloc2d(int h, int w, int size)
 {
 	int j;
@@ -296,7 +291,7 @@ void rtw_free_netdev(struct net_device *netdev)
 	if (!pnpi->priv)
 		goto RETURN;
 
-	rtw_vmfree(pnpi->priv, pnpi->sizeof_priv);
+	vfree(pnpi->priv);
 	free_netdev(netdev);
 
 RETURN:
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index 270de35f1d35..2c372c9ad7e7 100644
--- a/drivers/staging/r8188eu/os_dep/usb_intf.c
+++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
@@ -702,7 +702,7 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
 		if (pnetdev)
 			rtw_free_netdev(pnetdev);
 		else if (padapter)
-			rtw_vmfree((u8 *)padapter, sizeof(*padapter));
+			vfree(padapter);
 		padapter = NULL;
 	}
 exit:
-- 
2.32.0

