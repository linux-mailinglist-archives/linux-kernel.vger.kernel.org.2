Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9761E352E5F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 19:33:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236225AbhDBRbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 13:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbhDBRat (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 13:30:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C131C061793
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 10:30:46 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so2676900wmj.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 10:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nIY2sYvWAOKx6fw8woLxf3bCvMwVlUruJocGwJTs26M=;
        b=VdZLKo0jMU8fVwtl7lYt5ds8MJfsOwROOZZUwZ4LMsT9ll2Mhi6xbSLaCyQ8KRoT68
         RWkVWeuEl1YPy+npbiy3TZtE8UsHwKqzI8afx9vSFCBuy23VR06FXCYRVkbW0zfx2Wdz
         HPaYFkIbeBmGqh024r7205TMF9j8L2lQ9VuUE+CXmtpw8vUeunxHRmSFt4dV4/X+L6Xp
         5sIjqxrnUzzMdZXkvUH7VO0XLuQFagG25sPzBa2l0w4whIJ9YIsbBls78eIupebuCHoC
         6gOHwzznrrhM5pBPl+sQpeojuKK/RN3j6c+pGlcHe1eAk7aus/ZQoCWvNvciUitlHO8F
         6skg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nIY2sYvWAOKx6fw8woLxf3bCvMwVlUruJocGwJTs26M=;
        b=A5OJ2iOXaLsiztIns3Pp36LHY+5Moy87qf90QcH8s9MK6v9AsljiX+bRTZUzJIqkeH
         E9xVEcMfEe6w6Z7baB6oWdz4cwIaroH/h7oFE+GfR19GlBWPMeblqej+8hjmIW7RvCoK
         R6jvdIkh3AQ5fQupPQeLp9EgNbGZyCKvBgtOkqvUqa4NU8YFSkJSWqWbEYgYpWrDWwZV
         m7Es8E3T3pBGnDlvFD6FD2myTWz4P6rNEP39srJ+1uFryNFPFhAGiv/d8jZqFgGNcSC0
         SPwDnuhqjO7805qdr9zDw8dsykVTrPciWfLY8DEw6qg3S959/hScZXDOWlhxaNDncVhI
         oAFQ==
X-Gm-Message-State: AOAM530yCxay+nIS2XSTQ79s+WedhxyDD0oj+9EF+E9XAKL4SMtup9sK
        r7MZIvsOVTk98xiKNqo3EOs=
X-Google-Smtp-Source: ABdhPJzOsWVwTfyPtwWM9WWKHkPlJYg5pLUQX9Q9+YB5Us3Zg4FtIvwGccyJcgWMPSmhsQfV6MIwxA==
X-Received: by 2002:a05:600c:2282:: with SMTP id 2mr13564944wmf.93.1617384644693;
        Fri, 02 Apr 2021 10:30:44 -0700 (PDT)
Received: from agape ([5.171.81.4])
        by smtp.gmail.com with ESMTPSA id 21sm13120436wme.6.2021.04.02.10.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 10:30:44 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v2 17/30] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_mlme_ext.c
Date:   Fri,  2 Apr 2021 19:29:59 +0200
Message-Id: <e22f32de55ec48baaedcbab27dc874f3e7688654.1617384172.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617384172.git.fabioaiuto83@gmail.com>
References: <cover.1617384172.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 39 +++----------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index 8aadcf72a7ba..9855a77a5188 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -526,14 +526,8 @@ void mgt_dispatcher(struct adapter *padapter, union recv_frame *precv_frame)
 	struct dvobj_priv *psdpriv = padapter->dvobj;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
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
@@ -545,10 +539,9 @@ void mgt_dispatcher(struct adapter *padapter, union recv_frame *precv_frame)
 
 	index = GetFrameSubType(pframe) >> 4;
 
-	if (index >= ARRAY_SIZE(mlme_sta_tbl)) {
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("Currently we do not support reserved sub-fr-type =%d\n", index));
+	if (index >= ARRAY_SIZE(mlme_sta_tbl))
 		return;
-	}
+
 	ptable += index;
 
 	if (psta) {
@@ -2675,8 +2668,6 @@ static int _issue_probereq(struct adapter *padapter,
 	int	bssrate_len = 0;
 	u8 bc_addr[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("+issue_probereq\n"));
-
 	pmgntframe = alloc_mgtxmitframe(pxmitpriv);
 	if (!pmgntframe)
 		goto exit;
@@ -2743,8 +2734,6 @@ static int _issue_probereq(struct adapter *padapter,
 
 	pattrib->last_txcmdsz = pattrib->pktlen;
 
-	RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_, ("issuing probe_req, tx_len =%d\n", pattrib->last_txcmdsz));
-
 	if (wait_ack) {
 		ret = dump_mgntframe_and_wait_ack(padapter, pmgntframe);
 	} else {
@@ -4441,8 +4430,6 @@ void start_create_ibss(struct adapter *padapter)
 
 		/* issue beacon */
 		if (send_beacon(padapter) == _FAIL) {
-			RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("issuing beacon frame fail....\n"));
-
 			report_join_res(padapter, -1);
 			pmlmeinfo->state = WIFI_FW_NULL_STATE;
 		} else {
@@ -4622,8 +4609,6 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 		memset(country, 0, 4);
 		memcpy(country, p, 3);
 		p += 3;
-		RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-				("%s: 802.11d country =%s\n", __func__, country));
 
 		i = 0;
 		while ((ie - p) >= 3) {
@@ -4813,9 +4798,6 @@ static void process_80211d(struct adapter *padapter, struct wlan_bssid_ex *bssid
 					break;
 
 				chplan_new[i].ScanType = SCAN_ACTIVE;
-				RT_TRACE(_module_rtl871x_mlme_c_, _drv_notice_,
-						 ("%s: change channel %d scan type from passive to active\n",
-						  __func__, channel));
 			}
 			break;
 		}
@@ -6332,10 +6314,6 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 	#ifdef CHECK_EVENT_SEQ
 	/*  checking event sequence... */
 	if (evt_seq != (atomic_read(&pevt_priv->event_seq) & 0x7f)) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_info_,
-			 ("Event Seq Error! %d vs %d\n", (evt_seq & 0x7f),
-			  (atomic_read(&pevt_priv->event_seq) & 0x7f)));
-
 		pevt_priv->event_seq = (evt_seq+1)&0x7f;
 
 		goto _abort_event_;
@@ -6343,21 +6321,14 @@ u8 mlme_evt_hdl(struct adapter *padapter, unsigned char *pbuf)
 	#endif
 
 	/*  checking if event code is valid */
-	if (evt_code >= MAX_C2HEVT) {
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nEvent Code(%d) mismatch!\n", evt_code));
+	if (evt_code >= MAX_C2HEVT)
 		goto _abort_event_;
-	}
 
 	/*  checking if event size match the event parm size */
 	if ((wlanevents[evt_code].parmsize != 0) &&
-			(wlanevents[evt_code].parmsize != evt_sz)) {
-
-		RT_TRACE(_module_rtl871x_cmd_c_, _drv_err_, ("\nEvent(%d) Parm Size mismatch (%d vs %d)!\n",
-			evt_code, wlanevents[evt_code].parmsize, evt_sz));
+			(wlanevents[evt_code].parmsize != evt_sz))
 		goto _abort_event_;
 
-	}
-
 	atomic_inc(&pevt_priv->event_seq);
 
 	peventbuf += 2;
-- 
2.20.1

