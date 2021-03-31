Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2C2134FD28
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 11:41:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234881AbhCaJlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 05:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234811AbhCaJk1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 05:40:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26399C061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:27 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id w3so29111404ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 02:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1JSwcAsIwTkETAiCAOu8+EdDrTOoO0FeFHKJwcZxxps=;
        b=GRDcimpRJSHDf0G311fTt0Vtbr7YMv/frMM5R2bBi2gyj5rVYiFqfDQ9CQxqAxrKm4
         aMF4NSmlT11MF8GdLrjykOTqiW8yuNeLGus5IlLn0lRqcnqCYgI1unSKDPNY/f8Dta40
         e63dnuO38CrDa6c3c2f5drnY90lY7ANpuCu1tfs0SCe/MQMro4Pflq0VZtWLWCR2XQ4w
         hb9us5ybt0MroaLpzblUzxOBr3FtG2uz0QDA/h6XwX/7zXPtFxEscBZd67VwdtiRKwYK
         I+g0qHJwVmAev5Tl5+3sNsxMJLTm5XATgF6CdcC02Gm9Y6GlCQg9RIcNRGM3TNXfxeCU
         +tdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1JSwcAsIwTkETAiCAOu8+EdDrTOoO0FeFHKJwcZxxps=;
        b=cFpiSQRmozbsug089GXbVWGABv45hRg7ye7CLvXkO1MRYVAPSN0rb6iSrgVA3syp3i
         JpEv1TDDBisDx0IU4G8sUDAmBrYyBIjOtDgTtH2vnwMEa+kz2o7WMSKk2vCdLCNH3fEh
         sysP5WdA0zglXr7j7gsDjdz/ojmGMLb8vhu5rPv03yP8//UEmVZ1h5M/p7HnxZH+siyd
         4W0V9YLJ5N71cTFOyRUCYHaoPGeKWfPA4ScmL9xuSmumnbIheF8EEDCIbrpUb66M3Arx
         N3lLC8/Ia8wL9iDPkg/av8OIfo9wnnk0uzuXXn5ytW+m5GaYAo6n9pbhgpHtctRKNvWC
         betw==
X-Gm-Message-State: AOAM532agvDp/x9uDz4p+O9YPSb2QEmj5ZHLkl+d1N8VuJvbyBw405IK
        E+RFEUIrxKatpT2lw6qOfAc=
X-Google-Smtp-Source: ABdhPJwTnIefI0WbrKvXHMTmDCfoZxtwXnqz1JZgoseZg36c8gtspX3PL/cxbWcKCnWilX/CPdO8OA==
X-Received: by 2002:a17:907:9709:: with SMTP id jg9mr2499469ejc.276.1617183625947;
        Wed, 31 Mar 2021 02:40:25 -0700 (PDT)
Received: from agape ([5.171.73.44])
        by smtp.gmail.com with ESMTPSA id r17sm1156405edx.1.2021.03.31.02.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 02:40:25 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 08/40] staging: rtl8723bs: replace RT_TRACE with public printk wrappers in core/rtw_mlme_ext.c
Date:   Wed, 31 Mar 2021 11:39:36 +0200
Message-Id: <39dc6c0c012c4fa37a75667505babb48682a26de.1617183374.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617183374.git.fabioaiuto83@gmail.com>
References: <cover.1617183374.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

replace private macro RT_TRACE for tracing with in-kernel
pr_* printk wrappers

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 39 ++++++++++---------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 8aadcf72a7ba..9ed216c58fa0 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -526,12 +526,12 @@ void mgt_dispatcher(struct adapter *padapter, union recv_frame *precv_frame)
 	struct dvobj_priv *psdpriv = padapter->dvobj;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("+mgt_dispatcher: type(0x%x) subtype(0x%x)\n",
-		  GetFrameType(pframe), GetFrameSubType(pframe)));
+	pr_info("%s+%s: type(0x%x) subtype(0x%x)\n", DRIVER_PREFIX, __func__,
+		GetFrameType(pframe), GetFrameSubType(pframe));
 
 	if (GetFrameType(pframe) != WIFI_MGT_TYPE) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("mgt_dispatcher: type(0x%x) error!\n", GetFrameType(pframe)));
+		pr_err("%s %s: type(0x%x) error!\n", DRIVER_PREFIX, __func__,
+		       GetFrameType(pframe));
 		return;
 	}
 
@@ -546,7 +546,8 @@ void mgt_dispatcher(struct adapter *padapter, union recv_frame *precv_frame)
 	index = GetFrameSubType(pframe) >> 4;
 
 	if (index >= ARRAY_SIZE(mlme_sta_tbl)) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Currently we do not support reserved sub-fr-type =%d\n", index));
+		pr_err("%s Currently we do not support reserved sub-fr-type =%d\n",
+		       DRIVER_PREFIX, index);
 		return;
 	}
 	ptable += index;
@@ -2675,7 +2676,7 @@ static int _issue_probereq(struct adapter *padapter,
 	int	bssrate_len = 0;
 	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+issue_probereq\n"));
+	pr_notice("%s+%s\n", DRIVER_PREFIX, __func__);
 
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
@@ -2743,7 +2744,8 @@ static int _issue_probereq(struct adapter *padapter,
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("issuing probe_req, tx_len =%d\n", pattrib->last_txcmdsz));
+	pr_notice("%s issuing probe_req, tx_len =%d\n",
+		  DRIVER_PREFIX, pattrib->last_txcmdsz);
 
 	if (wait_ack) {
 		ret = dump_mgntframe_and_wait_ack(padapter, pmgntframe);
@@ -4441,7 +4443,7 @@ void start_create_ibss(struct adapter *padapter)
 
 		/* issue beacon */
 		if (send_beacon(padapter) == _FAIL) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("issuing beacon frame fail....\n"));
+			pr_err("%s issuing beacon frame fail....\n", DRIVER_PREFIX);
 
 			report_join_res(padapter, -1);
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
@@ -4622,8 +4624,8 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 		memset(country, 0, 4);
 		memcpy(country, p, 3);
 		p += 3;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-				("%s: 802.11d country =%s\n", __func__, country));
+		pr_notice("%s %s: 802.11d country =%s\n", DRIVER_PREFIX,
+			  __func__, country);
 
 		i = 0;
 		while ((ie - p) >= 3) {
@@ -4813,9 +4815,8 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 					break;
 
 				chplan_new[i].ScanType = SCAN_ACTIVE;
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-						 ("%s: change channel %d scan type from passive to active\n",
-						  __func__, channel));
+				pr_notice("%s %s: change channel %d scan type from passive to active\n",
+					  DRIVER_PREFIX, __func__, channel);
 			}
 			break;
 		}
@@ -6332,9 +6333,9 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 	#ifdef CHECK_EVENT_SEQ
 	/*  checking event sequence... */
 	if (evt_seq != (atomic_read(&pevt_priv->event_seq) & 0x7f)) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_,
-			 ("Event Seq Error! %d vs %d\n", (evt_seq & 0x7f),
-			  (atomic_read(&pevt_priv->event_seq) & 0x7f)));
+		pr_info("%s Event Seq Error! %d vs %d\n",
+			DRIVER_PREFIX, (evt_seq & 0x7f),
+			(atomic_read(&pevt_priv->event_seq) & 0x7f));
 
 		pevt_priv->event_seq = (evt_seq+1)&0x7f;
 
@@ -6344,7 +6345,7 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 
 	/*  checking if event code is valid */
 	if (evt_code >= MAX_C2HEVT) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nEvent Code(%d) mismatch!\n", evt_code));
+		pr_err("%s Event Code(%d) mismatch!\n", DRIVER_PREFIX, evt_code);
 		goto _abort_event_;
 	}
 
@@ -6352,8 +6353,8 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 	if ((wlanevents[evt_code].parmsize != 0) &&
 			(wlanevents[evt_code].parmsize != evt_sz)) {
 
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nEvent(%d) Parm Size mismatch (%d vs %d)!\n",
-			evt_code, wlanevents[evt_code].parmsize, evt_sz));
+		pr_err("%s Event(%d) Parm Size mismatch (%d vs %d)!\n",
+		       DRIVER_PREFIX, evt_code, wlanevents[evt_code].parmsize, evt_sz);
 		goto _abort_event_;
 
 	}
-- 
2.20.1

