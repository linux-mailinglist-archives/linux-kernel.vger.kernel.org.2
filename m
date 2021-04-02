Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42B01352941
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 12:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235031AbhDBKCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 06:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbhDBKCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 06:02:04 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2795C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 03:02:02 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id bx7so4932485edb.12
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 03:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nIY2sYvWAOKx6fw8woLxf3bCvMwVlUruJocGwJTs26M=;
        b=jy2Mw6N2OtMTqqWNCYiUmujDxQcvQSauxMA4+dFGkDWSuuefLbdMzSEY2sr0q6m4/f
         MxxfK5pjdEVxeqbjhYPiIOJANkNgp1B1IKBTwiR0AqIZCgMIpAc0ryRlHRx2Mf1bk1GZ
         VZj94klGu8AP4NSXTu/jwo2nPqZKqV05U+FHByfxX0F57i7rICl7bDU/YcJYH5r1DpkB
         xnlBJGM61oAeNlqHTkMIAKRc6o12kEPA2ZLD/qhD+mAQ5mpogMegYWKlVt0LulPCfpXD
         mtWVCkbhOJFl0RdQSVZe7Zr9i8p5aERbwPA972gUzbaO5BgM1jJuDBz/4i38tSxwT5/8
         /E2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nIY2sYvWAOKx6fw8woLxf3bCvMwVlUruJocGwJTs26M=;
        b=KBPSVW/ZF7bHuOlmYGVa1NENXwnDOUqBzGU4EpNwxBwJDoDVIbzLg1jevqFrJ7ubDn
         29HNaMySTxXlURjN7dwnQx9Fy7Tphjt6ZysgiuYbTmKKYoL5nDJkya2Uf7KZxzMDzt8h
         KhiIHotLaifnvA1/62ttz2wWBBudfhUkVTpzO8ti8y7CrDzavhhEugFooLpHFyIbKYeM
         bTdLshttZ/mWz9pw9COejRwZOMe0oiZunrLthRomMbTLLIg8i64+jGHW/sbimUhas9NZ
         cNrxRnL+NICeal9JDpiQKBiXSZfPpms7I9KsE20SAIT8VnGf95G6xSrJFHx9LjgZF51n
         FA4w==
X-Gm-Message-State: AOAM530dvBcQdCQqP+sV5UmHh8tPguh00bpIBAfglVa1mB/19iUrWuX0
        v5gfibCT9FfVIKvZ59ePfRg=
X-Google-Smtp-Source: ABdhPJyKQS6XyVhu70o5FLQQ6r2ltJgZs1wwIMhvIaxJ8wlh02iysGdEMLq0wajnJ6/VQmWjwP1r2Q==
X-Received: by 2002:aa7:c312:: with SMTP id l18mr760224edq.190.1617357721631;
        Fri, 02 Apr 2021 03:02:01 -0700 (PDT)
Received: from agape ([5.171.72.128])
        by smtp.gmail.com with ESMTPSA id x4sm4863867edd.58.2021.04.02.03.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 03:02:01 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 09/16] staging: rtl8723bs: remove RT_TRACE logs in core/rtw_mlme_ext.c
Date:   Fri,  2 Apr 2021 12:01:29 +0200
Message-Id: <a6ed8753e63a95698657b7dcf0bbd81241c3a1a1.1617356821.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617356821.git.fabioaiuto83@gmail.com>
References: <cover.1617356821.git.fabioaiuto83@gmail.com>
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

