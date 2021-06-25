Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FF7C3B39F7
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 02:08:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233050AbhFYAK7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 20:10:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhFYAKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 20:10:34 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 987B1C061768
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:13 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id g14so6259707qtv.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 17:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47a1Z2Yt1fcMPLUNw60Hi1OyhOqku3CpdlDvOqjJHoM=;
        b=VR6bS7UxDZnLkpH8x+28cRM/7W2w1J3iWiEhiGz8Dhip7KtEIrfgjMxA6vuUF4LQ12
         ksFxjt8Ge9XOmCYdBMbLvFLWmzc0BbvtZC44RAjPYiqd0RSFDClUhoxMOseEsSIsHw8/
         w9VhTMKRq6vXHVnJh5/Z0kpKv8F7bdePLRHsTlPqBOSmQZ3HTgnAEuGKFJNPiT7MBrPW
         BRWZ1Vsbx+P2wnzW3vCCFCjo8/NVfDeAy4rDGYvXw1UH1deEoIVO/J8aB40ZHQNTA7NP
         2kQ2FOgckndij8oFwqQLqpCON7uYpGHUgoRekwYMtS1sV2sGJoowMU/lVQcO/5qLbs5A
         CscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47a1Z2Yt1fcMPLUNw60Hi1OyhOqku3CpdlDvOqjJHoM=;
        b=BkA2fSa8/N8ueFyJelOK55j1etkO9EZ0cDVNL+KZPXUGGXHT0GlR9jRVSHKdRyl3ho
         BnP9jWFuabgar8mTICIwbVoawlshHT2r6zpTBhbzqZLjkWGQ1bUw1mTYD0cab+iOjq9r
         /f2LgGUFYkbRns3a10O0XSywu6C56PXBiw+hBDVQrl7VnCQjRigxc/mbnnJ/6eziYY3k
         +nJbFfEDWgJfhpSW78/cBzs9npxlz6ptu22DhJeqHuPDto6/+YYiZLbGAt7a30N5kVR6
         lXMEeMJMpkqCw3xtbDVDaRaBUOcA/JjYEupkVMfYActF65vaIkRsBJUuMUyeZYVtFmlJ
         BHxA==
X-Gm-Message-State: AOAM53262Wo5isNtxQr4Da7DB2E8XuEZ/Z/GVpjvWSssFbD9/rV1nDF7
        76lrMVYoPzgWiZJJl0hSqiOgYg==
X-Google-Smtp-Source: ABdhPJwfZNGyh0CO/Hm5WfY2smD423vbK1A/w7BmVKJx77gFCpr344ju1241TJ94bmkE5zjLqH2p3A==
X-Received: by 2002:ac8:668c:: with SMTP id d12mr7267524qtp.188.1624579692801;
        Thu, 24 Jun 2021 17:08:12 -0700 (PDT)
Received: from kerneldevvm.. (5.6.a.8.a.a.b.f.c.9.4.c.a.9.a.a.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:aa9a:c49c:fbaa:8a65])
        by smtp.gmail.com with ESMTPSA id m187sm3629014qkd.131.2021.06.24.17.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 17:08:12 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 08/23] staging: rtl8188eu: remove all RT_TRACE calls from core/rtw_mlme_ext.c
Date:   Fri, 25 Jun 2021 01:07:41 +0100
Message-Id: <20210625000756.6313-9-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210625000756.6313-1-phil@philpotter.co.uk>
References: <20210625000756.6313-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all RT_TRACE calls from core/rtw_mlme_ext.c as this macro is
unnecessary, and these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_mlme_ext.c | 41 +++----------------
 1 file changed, 5 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
index e237df794db7..25653ebfaafd 100644
--- a/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8188eu/core/rtw_mlme_ext.c
@@ -594,8 +594,6 @@ static int issue_probereq(struct adapter *padapter,
 	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
 	int bssrate_len = 0;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+%s\n", __func__));
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		goto exit;
@@ -656,9 +654,6 @@ static int issue_probereq(struct adapter *padapter,
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-		 ("issuing probe_req, tx_len=%d\n", pattrib->last_txcmdsz));
-
 	if (wait_ack) {
 		ret = dump_mgntframe_and_wait_ack(padapter, pmgntframe);
 	} else {
@@ -2095,8 +2090,6 @@ static void start_create_ibss(struct adapter *padapter)
 
 		/* issue beacon */
 		if (send_beacon(padapter) == _FAIL) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("issuing beacon frame fail....\n"));
-
 			report_join_res(padapter, -1);
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		} else {
@@ -2269,9 +2262,6 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 		memset(country, 0, 4);
 		memcpy(country, p, 3);
 		p += 3;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-			 ("%s: 802.11d country =%s\n", __func__, country));
-
 		i = 0;
 		while ((ie - p) >= 3) {
 			fcn = *(p++);
@@ -2365,12 +2355,8 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
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
@@ -3859,17 +3845,8 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 	u8 *pframe = precv_frame->pkt->data;
 	struct sta_info *psta = rtw_get_stainfo(&padapter->stapriv, GetAddr2Ptr(pframe));
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_,
-		 ("+%s: type(0x%x) subtype(0x%x)\n", __func__,
-		  (unsigned int)GetFrameType(pframe),
-		  (unsigned int)GetFrameSubType(pframe)));
-
-	if (GetFrameType(pframe) != WIFI_MGT_TYPE) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,
-			 ("%s: type(0x%x) error!\n", __func__,
-			  (unsigned int)GetFrameType(pframe)));
+	if (GetFrameType(pframe) != WIFI_MGT_TYPE)
 		return;
-	}
 
 	/* receive the frames that ra(a1) is my address or ra(a1) is bc address. */
 	if (memcmp(GetAddr1Ptr(pframe), myid(&padapter->eeprompriv), ETH_ALEN) &&
@@ -3880,10 +3857,8 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
 
 	index = GetFrameSubType(pframe) >> 4;
 
-	if (index > 13) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Currently we do not support reserved sub-fr-type=%d\n", index));
+	if (index > 13)
 		return;
-	}
 	ptable += index;
 
 	if (psta) {
@@ -5095,19 +5070,13 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 	evt_code = (u8)((*peventbuf >> 16) & 0xff);
 
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
 
 	peventbuf += 2;
 
-- 
2.31.1

