Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C683DEF5A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 15:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236407AbhHCNw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 09:52:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbhHCNwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 09:52:51 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2611DC0613D5
        for <linux-kernel@vger.kernel.org>; Tue,  3 Aug 2021 06:52:39 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id x15so28184397oic.9
        for <linux-kernel@vger.kernel.org>; Tue, 03 Aug 2021 06:52:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wxUGfVk4B2qU9ZCj5neY6QAee9EY7qdDX1/2z4s5sYw=;
        b=aowZ2GGTrq23OypJvwmEQ+lTsJYgIcZYQKyQ+f68emWwYPAtIZhlX17OjaZU9hb8bb
         tqV9Jf6L+GbxvYVhXmmEEgRjByP93jF7wOHpBQ5rezYdb6ZEvKexkSabLdVwYy+CUlDp
         U10ee161enxyO303+fnbFxOTvwdDx72L1jwAf3TwPJ2kE2U/cmrK9Wc684ka6zSrGv8C
         s1eszHc/fztRsAmBHpOFAsyQgOJQUlVn4auktItq6S1RZYjCaXr4QsRB/xtVAmy/GI0m
         2JHofHFHGzy55sV02Sd6L8V+2sOUv5isj4Eti+WuMUg7MiTVnNkPGQR5flBh0ep4Ta5q
         MPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=wxUGfVk4B2qU9ZCj5neY6QAee9EY7qdDX1/2z4s5sYw=;
        b=iKHIjXBV+g16ML6PpxQcMVkiPaYL2zVGAQKMRU183XlVn1E5FId0xpvMWf/5rIhYHa
         DFUBuSZkR7l90qPCqi1dvrSvkSzCDrkukjjVD5+NnYhX7DhDjYiLL5owP0WouonMx/HK
         sArBN6txQgAoWbSQwIR9PXM+LqcmQAPnc/2wtY2g6FR3BVk4USB7/xnuC8yjvcG0+dKG
         f53Ihd0scA9+f2wiSDgwueHL+4kDo8sHi+Cu65NYOvSBx9kAA5YsmdoyoPLdTXDf2iv/
         MQHFG07FIKlLiftMEr4DOgWiBCFYbkiZ3cR4y/uMqpt1lVQbry93LgUmtOAgdWx0KsBo
         uPRg==
X-Gm-Message-State: AOAM532HD3SL0qiEduIL4qGOpApff7Bhshs1NtJDZvkbaF/X+DlmQwsI
        nlzckN/n05N+cJdn4G1xX1g=
X-Google-Smtp-Source: ABdhPJyRgbKtIUjUEnX6f6MUoXt1q3Acjpa/F9Dub/rbje1lBI1YozyLwgZfZpBUyMHiG8GuB5ATuQ==
X-Received: by 2002:aca:c6c4:: with SMTP id w187mr1793235oif.121.1627998758544;
        Tue, 03 Aug 2021 06:52:38 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1010.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1010.res6.spectrum.com. [2603:8090:2005:39b3::1010])
        by smtp.gmail.com with ESMTPSA id y26sm2504106otq.23.2021.08.03.06.52.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 06:52:38 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 02/10] staging: r8188eu: Remove wrapper around vfree
Date:   Tue,  3 Aug 2021 08:52:15 -0500
Message-Id: <20210803135223.12543-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210803135223.12543-1-Larry.Finger@lwfinger.net>
References: <20210803135223.12543-1-Larry.Finger@lwfinger.net>
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
index 3a83cf9731a0..c3763d9e448a 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -129,9 +129,7 @@ void _rtw_free_mlme_priv (struct mlme_priv *pmlmepriv)
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
index 4575f5da5f70..446f43ac08d3 100644
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
index 8d89b98545cf..ec877615bdf7 100644
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

