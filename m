Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075BE3DCD29
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Aug 2021 21:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbhHATFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Aug 2021 15:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbhHATE4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Aug 2021 15:04:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68BFFC0613D3
        for <linux-kernel@vger.kernel.org>; Sun,  1 Aug 2021 12:04:47 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id h14so18752203wrx.10
        for <linux-kernel@vger.kernel.org>; Sun, 01 Aug 2021 12:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H3Na+/2FQkl/OyTipvkNGQkh8rKRecOgsLStsVviL9E=;
        b=NXgMu+tq94gliPI8kZFLZGBvynrRb0COg6QrRGAHtEopgx4ouipjl5fC+8ZeP13E2j
         +8I3P8w2+OWK2PlBrlHwAy9RsoDIHeTh+v1ip/pmsuWxBHf43K2gD5M9CPySnC3h3zqy
         +cNODL890J5wG8kGFZcc82S6sd65twErKnxcjUlRFthuhsLq34lAcUOVzKXLzFGKvRFw
         2V7VZA8ykAp+m+OQMlmq+49Cw5nUbyHoGNfFKLwJp18veauGGzLIonNOQVBGQqAZaSVR
         59zq18+Ca9LTy0IsREqLtHn58euFCKEwuorbShnN4qZA4ItfryCgCqDYVMX8IQSeLfWZ
         HgEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3Na+/2FQkl/OyTipvkNGQkh8rKRecOgsLStsVviL9E=;
        b=D/6k7QV3HAoEhF5w3epqUgmAw84GF20DswBw2j308it5N4hRhw+lsunSMC5XBSoRh7
         kUN+AP5CtlHOabSlqRwLY7JU3gZjbldUaqXFEJc03Vbfb6csoQQ4KylrUITGxwob1Udv
         bh48oWnBT/74LiL8CA5ff/xJpYin+aG5ojZI+tA9YIkT7smE6tZBZDXvYeBRyXo+pWZc
         OG/fnS1cHoBOGkkHbEjN3Kx1SAgq4u3yNz0XHf2pNI9iocuO9ayKN/HQj2ag0m5PlVNp
         EaqEny9W74W66c978KrhAWNMIHmJVtj7GX9qhxZb2lUSxA2CNyvYN87tGyzITmX8kVQG
         /6qA==
X-Gm-Message-State: AOAM531kFWc+03FC4pB+HPQjTzfg/er/AyQdWtZ1CMjgAJ/cecEF2+bE
        huAOEEnd790aOaDeVhE6/CJ/4w==
X-Google-Smtp-Source: ABdhPJz9vUcOALvaCkyG3keuYCN4nhneTI3QB0tywU5BoEmvuTRHNlIf4LasOuVFPMsKRpMz60wmJA==
X-Received: by 2002:a5d:500a:: with SMTP id e10mr109077wrt.408.1627844686013;
        Sun, 01 Aug 2021 12:04:46 -0700 (PDT)
Received: from localhost.localdomain (3.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16::3])
        by smtp.gmail.com with ESMTPSA id c10sm8196026wmb.40.2021.08.01.12.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Aug 2021 12:04:45 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, martin@kaiser.cx
Subject: [PATCH 08/15] staging: r8188eu: remove RT_TRACE calls from core/rtw_mlme_ext.c
Date:   Sun,  1 Aug 2021 20:04:30 +0100
Message-Id: <20210801190437.82017-9-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210801190437.82017-1-phil@philpotter.co.uk>
References: <20210801190437.82017-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove RT_TRACE macro calls from core/rtw_mlme_ext.c, so that ultimately the
macro definition itself can eventually be removed.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/r8188eu/core/rtw_mlme_ext.c | 40 +++------------------
 1 file changed, 5 insertions(+), 35 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
index 1160b7caffdd..0562fd4cf3e5 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
@@ -418,14 +418,8 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 	u8 *pframe = precv_frame->rx_data;
 	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(pframe));
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("+mgt_dispatcher: type(0x%x) subtype(0x%x)\n",
-		  GetFrameType(pframe), GetFrameSubType(pframe)));
-
-	if (GetFrameType(pframe) != WIFI_MGT_TYPE) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("mgt_dispatcher: type(0x%x) error!\n", GetFrameType(pframe)));
+	if (GetFrameType(pframe) != WIFI_MGT_TYPE)
 		return;
-	}
 
 	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
 	if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN) &&
@@ -436,10 +430,8 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	index = GetFrameSubType(pframe) >> 4;
 
-	if (index > 13) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Currently we do not support reserved sub-fr-type=%d\n", index));
+	if (index > 13)
 		return;
-	}
 	ptable += index;
 
 	if (psta != NULL) {
@@ -3758,8 +3750,6 @@ static int _issue_probereq_p2p(struct adapter *padapter, u8 *da, int wait_ack)
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("issuing probe_req, tx_len=%d\n", pattrib->last_txcmdsz));
-
 	if (wait_ack) {
 		ret = dump_mgntframe_and_wait_ack(padapter, pmgntframe);
 	} else {
@@ -4833,8 +4823,6 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 	int	bssrate_len = 0;
 	u8	bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+issue_probereq\n"));
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (pmgntframe == NULL)
 		goto exit;
@@ -4895,9 +4883,6 @@ static int _issue_probereq(struct adapter *padapter, struct ndis_802_11_ssid *ps
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-		 ("issuing probe_req, tx_len=%d\n", pattrib->last_txcmdsz));
-
 	if (wait_ack) {
 		ret = dump_mgntframe_and_wait_ack(padapter, pmgntframe);
 	} else {
@@ -6669,8 +6654,6 @@ void start_create_ibss(struct adapter *padapter)
 
 		/* issue beacon */
 		if (send_beacon(padapter) == _FAIL) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("issuing beacon frame fail....\n"));
-
 			report_join_res(padapter, -1);
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		} else {
@@ -6847,9 +6830,6 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 		memset(country, 0, 4);
 		memcpy(country, p, 3);
 		p += 3;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-			 ("%s: 802.11d country =%s\n", __func__, country));
-
 		i = 0;
 		while ((ie - p) >= 3) {
 			fcn = *(p++);
@@ -6954,12 +6934,8 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 	i = 0;
 	while ((i < MAX_CHANNEL_NUM) && (chplan_new[i].ChannelNum != 0)) {
 		if (chplan_new[i].ChannelNum == channel) {
-			if (chplan_new[i].ScanType == SCAN_PASSIVE) {
+			if (chplan_new[i].ScanType == SCAN_PASSIVE)
 				chplan_new[i].ScanType = SCAN_ACTIVE;
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-					 ("%s: change channel %d scan type from passive to active\n",
-					 __func__, channel));
-			}
 			break;
 		}
 		i++;
@@ -8235,19 +8211,13 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 	evt_code = (u8)((*peventbuf>>16)&0xff);
 
 	/*  checking if event code is valid */
-	if (evt_code >= MAX_C2HEVT) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nEvent Code(%d) mismatch!\n", evt_code));
+	if (evt_code >= MAX_C2HEVT)
 		goto _abort_event_;
-	}
 
 	/*  checking if event size match the event parm size */
 	if ((wlanevents[evt_code].parmsize != 0) &&
-	    (wlanevents[evt_code].parmsize != evt_sz)) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_,
-			 ("\nEvent(%d) Parm Size mismatch (%d vs %d)!\n",
-			 evt_code, wlanevents[evt_code].parmsize, evt_sz));
+	    (wlanevents[evt_code].parmsize != evt_sz))
 		goto _abort_event_;
-	}
 
 	ATOMIC_INC(&pevt_priv->event_seq);
 
-- 
2.31.1

