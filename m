Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB8973E1B75
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:37:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241464AbhHEShw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241395AbhHEShn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:37:43 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8592C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 11:37:28 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id r16-20020a0568304190b02904f26cead745so5760751otu.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 11:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0xIqY3Ha7oUmEWl7eMuzDyYERvbInSb/rsWCme0XJJ8=;
        b=EfV5nfPM2w0W8hCuemLFoujIQtI/qIg5E/w6JJLnBHK7K9rc7F5GcFbW1ORgjByFvi
         RdFW3fCv0tnO6K+30apDrs4vablheIMIQlNKlC+Dr3wSpT0Oum8oTgMzBqX+EHxucojx
         uZXBEKuJY64AwNypKorysZED3WSXr0F54TOSapF49kPBYo9y0VWKZGLrOMRuRsqZ+Dvw
         uwDCU8wpRRatuxvUOp6IpkCKdFOC+HQZMbVWWpN4MB+bF3Rt2WNpm8uH5EfPrVMkdHSx
         tzOzCo5FeSAYj1ue2nxcyrkXQnkfDo2hcSfIrmKcvSreIWHMXCtNJSlosd9EigSrstJx
         CGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=0xIqY3Ha7oUmEWl7eMuzDyYERvbInSb/rsWCme0XJJ8=;
        b=eYpZq9YqnzLxz8Ex78+sKdqci0TNjjPJmp0IFd/BOgHJ3erX6hrTxlJC8alDCD+ewo
         EuSgPqbBivKqV6Deipa8b0aODKekQgVtuY1UbqqFPBOdjlPo9NYQriChxJvaar8GhtCU
         J1rBPapQKjjIWqhS3cNl92fCVpZhTMQXrubBJOqs2E+kM0tvjZlbLoJ/JdLICqZAMq2D
         leF/c6HjBUss0TssLfFU5syezhuY4tVhXlwdNPwm0mve5ciArWEkmZquSfpI2Z4qKLWA
         b/Ou3ZsykKaNRDylECo2WusivcgVgF5jAGoc+jsp4xRpEwEvwbxFG6zdUqiEQA2A/h9D
         v/Sg==
X-Gm-Message-State: AOAM531CHGnr7lTYZNZ0NQUbSR1sBaRr4NQFsSRFyxU/Lg8798ni5ntK
        s4/Oxech/1bwsvLiJWawDfs=
X-Google-Smtp-Source: ABdhPJzq6YJDfJkIf9qV3e2iaS5lrYSueoCzzzTqdYiEaLlJHJBdxbHIzoglTbna5yf7elyZfsZQOg==
X-Received: by 2002:a05:6830:2802:: with SMTP id w2mr4757055otu.303.1628188648210;
        Thu, 05 Aug 2021 11:37:28 -0700 (PDT)
Received: from 2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com.com (2603-8090-2005-39b3-0000-0000-0000-1016.res6.spectrum.com. [2603:8090:2005:39b3::1016])
        by smtp.gmail.com with ESMTPSA id q32sm1156726oiw.37.2021.08.05.11.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 11:37:27 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
To:     gregkh@linuxfoundation.org
Cc:     phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: [PATCH 2/5] staging: r8188eu: Remove wrapper around vfree
Date:   Thu,  5 Aug 2021 13:37:14 -0500
Message-Id: <20210805183717.23007-3-Larry.Finger@lwfinger.net>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210805183717.23007-1-Larry.Finger@lwfinger.net>
References: <20210805183717.23007-1-Larry.Finger@lwfinger.net>
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
index 549ebcccca57..72570aede776 100644
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
index 36119602541a..9ff0a19cc680 100644
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
index 37cf22569c59..6f6caf727f3b 100644
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
index 4f62ef3dd246..2f1d1bfb6f73 100644
--- a/drivers/staging/r8188eu/core/rtw_sta_mgt.c
+++ b/drivers/staging/r8188eu/core/rtw_sta_mgt.c
@@ -211,7 +211,7 @@ u32	_rtw_free_sta_priv(struct	sta_priv *pstapriv)
 		rtw_mfree_sta_priv_lock(pstapriv);
 
 		if (pstapriv->pallocated_stainfo_buf)
-			rtw_vmfree(pstapriv->pallocated_stainfo_buf, sizeof(struct sta_info)*NUM_STA+4);
+			vfree(pstapriv->pallocated_stainfo_buf);
 		}
 
 	return _SUCCESS;
diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 3aab02a90697..05396cc2e82a 100644
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
index abbc8d22883b..9b0d02a759a4 100644
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
index b64f8851796b..1ff0980e6bfb 100644
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
index 9cf9f272cccb..d3603e34eeb4 100644
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
@@ -230,7 +225,7 @@ void rtw_free_netdev(struct net_device *netdev)
 	if (!pnpi->priv)
 		goto RETURN;
 
-	rtw_vmfree(pnpi->priv, pnpi->sizeof_priv);
+	vfree(pnpi->priv);
 	free_netdev(netdev);
 
 RETURN:
diff --git a/drivers/staging/r8188eu/os_dep/usb_intf.c b/drivers/staging/r8188eu/os_dep/usb_intf.c
index f3321a6653fc..b1184c36ddfc 100644
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

