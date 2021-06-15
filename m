Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 377EE3A72E2
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231764AbhFOASn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:18:43 -0400
Received: from mail-qv1-f48.google.com ([209.85.219.48]:38710 "EHLO
        mail-qv1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbhFOASm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:18:42 -0400
Received: by mail-qv1-f48.google.com with SMTP id r19so282162qvw.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:16:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wiasv2cr/puGUU+UQjp5j18V6n/sSvzOpW+EPeVUoIQ=;
        b=SqDRRjnCq8+CIHERR4DnKwRF7MMUhnRV4rsY6tRROjXlDaE9TMivtJuCewwI5D5o6C
         zzZGf2iuizBDu4Ew5jACdL3/7HteMYNUyhTKid+tFxH04XlRs1Z2D5i3CJok2LjpHRyy
         +OrbQXgLAT6v060v53D8QhDKAfzljbYEJjeIzhectRiYtjJ7ofmem3f/mINymlymkqzN
         qVsObl5Gknhvr9x2kenH4/XGXUUoCiDNFQMlTGZJ1o1a+ovtGJj2zAQ0HDzrbkg9yl2n
         Y29N+7czb3tr05g1ln9LBIWcll+OO8Eu5GNkvzInCjVAg+82hpPHWeXr3EwqFQed3v4j
         P4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wiasv2cr/puGUU+UQjp5j18V6n/sSvzOpW+EPeVUoIQ=;
        b=UzhzfWpIDrzj/mbIxDYJfESD+PsUBWi5smF4Czk4kZ6gdwbuFpyMT3+83f8QXktcYx
         u+U48pBdAMidO3qgdQJs/Vcmd5IVzbzoqDuSXgJFaslPLWZeQuTYz1XgoIeF7eClMXyt
         /rHNKoCtlEApFAeXJxsNa5LR7rA+rXR8iosf3ASe7jb1AzzLukXxHwpcYK0NzT8suG8e
         Kf5Czkv2CXQSQW5HZfm2zhwVNFhaGpPL5CpKT1FuxFNbkmS1G99n605ENWxDiL6Yhxwu
         nxd+aAnEJW6eWPR/8NzWwTWmqu+2DKOEXXioUTSN8EgfEsaEFOgZyOe06wlyDcGgvb7j
         7K6A==
X-Gm-Message-State: AOAM532c5XWO4cf9D/xQkiZYcnOI5LDi4RT6AGtn9sKGaM7aZPLAsQM3
        GKkCHso1w58DyLHwHQGC4U9udw==
X-Google-Smtp-Source: ABdhPJyZyc3OjD0Xic8H0EWaAhaeKlPoWBF9LjOfZAA25pwma5cxrnoYCp3EcEKjQZOZM4kgJwFn8g==
X-Received: by 2002:a0c:ca94:: with SMTP id a20mr1768204qvk.49.1623716128684;
        Mon, 14 Jun 2021 17:15:28 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:15:28 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 02/28] staging: rtl8188eu: remove all DBG_88E calls from core/rtw_xmit.c
Date:   Tue, 15 Jun 2021 01:14:41 +0100
Message-Id: <20210615001507.1171-3-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from core/rtw_xmit.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Also remove static rtw_sctx_chk_warning_status function, as it no longer
has any callers.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_xmit.c | 40 ++---------------------
 1 file changed, 3 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_xmit.c b/drivers/staging/rtl8188eu/core/rtw_xmit.c
index 718dd20ff36c..07c2171a42d0 100644
--- a/drivers/staging/rtl8188eu/core/rtw_xmit.c
+++ b/drivers/staging/rtl8188eu/core/rtw_xmit.c
@@ -364,8 +364,6 @@ u8 qos_acm(u8 acm_mask, u8 priority)
 			change_priority = 5;
 		break;
 	default:
-		DBG_88E("%s(): invalid pattrib->priority: %d!!!\n",
-			__func__, priority);
 		break;
 	}
 
@@ -481,7 +479,6 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 
 	if (psta) {
 		pattrib->mac_id = psta->mac_id;
-		/* DBG_88E("%s ==> mac_id(%d)\n", __func__, pattrib->mac_id); */
 		pattrib->psta = psta;
 	} else {
 		/*  if we cannot get psta => drop the pkt */
@@ -926,10 +923,8 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	if (!psta)
 		return _FAIL;
 
-	if (!pxmitframe->buf_addr) {
-		DBG_88E("==> %s buf_addr == NULL\n", __func__);
+	if (!pxmitframe->buf_addr)
 		return _FAIL;
-	}
 
 	pbuf_start = pxmitframe->buf_addr;
 
@@ -939,7 +934,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 	if (rtw_make_wlanhdr(padapter, mem_start, pattrib) == _FAIL) {
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: rtw_make_wlanhdr fail; drop pkt\n", __func__));
-		DBG_88E("%s: rtw_make_wlanhdr fail; drop pkt\n", __func__);
 		res = _FAIL;
 		goto exit;
 	}
@@ -1040,7 +1034,6 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 
 	if (xmitframe_addmic(padapter, pxmitframe) == _FAIL) {
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n"));
-		DBG_88E("xmitframe_addmic(padapter, pxmitframe) == _FAIL\n");
 		res = _FAIL;
 		goto exit;
 	}
@@ -1153,10 +1146,8 @@ struct xmit_buf *rtw_alloc_xmitbuf_ext(struct xmit_priv *pxmitpriv)
 		list_del_init(&pxmitbuf->list);
 		pxmitpriv->free_xmit_extbuf_cnt--;
 		pxmitbuf->priv_data = NULL;
-		if (pxmitbuf->sctx) {
-			DBG_88E("%s pxmitbuf->sctx is not NULL\n", __func__);
+		if (pxmitbuf->sctx)
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
-		}
 	}
 	spin_unlock_irqrestore(&pfree_queue->lock, irql);
 
@@ -1197,7 +1188,6 @@ struct xmit_buf *rtw_alloc_xmitbuf(struct xmit_priv *pxmitpriv)
 		pxmitpriv->free_xmitbuf_cnt--;
 		pxmitbuf->priv_data = NULL;
 		if (pxmitbuf->sctx) {
-			DBG_88E("%s pxmitbuf->sctx is not NULL\n", __func__);
 			rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_ALLOC);
 		}
 	}
@@ -1214,10 +1204,8 @@ s32 rtw_free_xmitbuf(struct xmit_priv *pxmitpriv, struct xmit_buf *pxmitbuf)
 	if (!pxmitbuf)
 		return _FAIL;
 
-	if (pxmitbuf->sctx) {
-		DBG_88E("%s pxmitbuf->sctx is not NULL\n", __func__);
+	if (pxmitbuf->sctx)
 		rtw_sctx_done_err(&pxmitbuf->sctx, RTW_SCTX_DONE_BUF_FREE);
-	}
 
 	if (pxmitbuf->ext_tag) {
 		rtw_free_xmitbuf_ext(pxmitpriv, pxmitbuf);
@@ -1482,7 +1470,6 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)
 
 	if (!psta) {
 		res = _FAIL;
-		DBG_88E("%s: psta == NULL\n", __func__);
 		RT_TRACE(_module_rtl871x_xmit_c_, _drv_err_, ("%s: psta == NULL\n", __func__));
 		goto exit;
 	}
@@ -1591,7 +1578,6 @@ s32 rtw_xmit(struct adapter *padapter, struct sk_buff **ppkt)
 	pxmitframe = rtw_alloc_xmitframe(pxmitpriv);
 	if (!pxmitframe) {
 		RT_TRACE(_module_xmit_osdep_c_, _drv_err_, ("%s: no more pxmitframe\n", __func__));
-		DBG_88E("DBG_TX_DROP_FRAME %s no more pxmitframe\n", __func__);
 		return -1;
 	}
 
@@ -1992,7 +1978,6 @@ int rtw_sctx_wait(struct submit_ctx *sctx)
 	if (!wait_for_completion_timeout(&sctx->done, expire)) {
 		/* timeout, do something?? */
 		status = RTW_SCTX_DONE_TIMEOUT;
-		DBG_88E("%s timeout\n", __func__);
 	} else {
 		status = sctx->status;
 	}
@@ -2003,26 +1988,9 @@ int rtw_sctx_wait(struct submit_ctx *sctx)
 	return ret;
 }
 
-static bool rtw_sctx_chk_warning_status(int status)
-{
-	switch (status) {
-	case RTW_SCTX_DONE_UNKNOWN:
-	case RTW_SCTX_DONE_BUF_ALLOC:
-	case RTW_SCTX_DONE_BUF_FREE:
-
-	case RTW_SCTX_DONE_DRV_STOP:
-	case RTW_SCTX_DONE_DEV_REMOVE:
-		return true;
-	default:
-		return false;
-	}
-}
-
 void rtw_sctx_done_err(struct submit_ctx **sctx, int status)
 {
 	if (*sctx) {
-		if (rtw_sctx_chk_warning_status(status))
-			DBG_88E("%s status:%d\n", __func__, status);
 		(*sctx)->status = status;
 		complete(&((*sctx)->done));
 		*sctx = NULL;
@@ -2046,6 +2014,4 @@ void rtw_ack_tx_done(struct xmit_priv *pxmitpriv, int status)
 
 	if (pxmitpriv->ack_tx)
 		rtw_sctx_done_err(&pack_tx_ops, status);
-	else
-		DBG_88E("%s ack_tx not set\n", __func__);
 }
-- 
2.30.2

