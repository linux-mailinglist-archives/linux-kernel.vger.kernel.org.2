Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB693F4A3F
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Aug 2021 14:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbhHWMDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Aug 2021 08:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236764AbhHWMDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Aug 2021 08:03:11 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2EBBC0613D9
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:02:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id n5so13570319wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 23 Aug 2021 05:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iiH0QAta1EQrMPpCuR5gGeqObp4Krd4m3HvoNHVwjIQ=;
        b=rYb22mNB1yn3yPu469+092IchwHhkfzwonNdGbioZmZDMz5++FBW4M7xWgl/uivf8H
         V75qnVLE8pP6YiLzKdLhhUw1WmwtNfOGgw559Ty3Z3qYLKdQw2z4zxv/vHl7x/QXcJvo
         Es/YCVqVQy0R+Hnn+z+0VPBN8Se9p1CT2rcWB1qndhFVRdLiJ47Sj23TgmOLG9AkFyxa
         V/znLXnn7EmnRoeBgbc8EyedI+kYFPVvmRjFNtW0EMo6h+BDCRnXV2b6KwrqGNnmYW6K
         zuulQXMPlAunG63o7p+dh1K5tmEOp+Qwz3SLcF3vjr8AxGRFXN07mBn77Gt5hTvIE9aW
         Gf4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iiH0QAta1EQrMPpCuR5gGeqObp4Krd4m3HvoNHVwjIQ=;
        b=moa4EbdyweHquPavbfVyXxMOdb3bTMMHpb3cSi+xiCJr0pvQjZcifUamDGfDvWVhuA
         Gq1avl7MhvYWx1tt+3KYvIEDdVCtuHRwwVZB1TVRvIJE6hEbgEoiVedhrn1D7gqBo0uo
         MeouzUbXvB5EA3Tn8Z7Lc6e+0bLWS8sMN/b2aNV1VwhczGNEUCGOnQ6RXW+GGPBcIn/9
         L7sj0P9fxapmQ2kLnshRQikxF+qmXhz1HpNivnr3NhIbBA0u8zV4q+uIZeoGDISWYQWN
         ps8I+4qiZYyCEilEhGZ1XyEisz/9v2n6H2tFsupb6ZrldvLVComGzt4eCfMqu+2dI54P
         WwZg==
X-Gm-Message-State: AOAM530FzzyEtTPxOnopv8E2Jgh117fx5lrYmJWxRZme/YSGfyXUK6hz
        HIqkbCJXaCM5XnNGT0zwj3I=
X-Google-Smtp-Source: ABdhPJyFVaMr1SQcTY6bNzpxZmuh7s7fkPH/cb0/O6BBqAojC4VvPN2sWwcV7uPH9sr+D5G3wv7b6A==
X-Received: by 2002:a5d:65c2:: with SMTP id e2mr13051492wrw.191.1629720147468;
        Mon, 23 Aug 2021 05:02:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::3c39])
        by smtp.gmail.com with ESMTPSA id g5sm901332wrq.80.2021.08.23.05.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:02:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 6/8] staging: r8188eu: use is_multicast_ether_addr in core/rtw_xmit.c
Date:   Mon, 23 Aug 2021 14:01:04 +0200
Message-Id: <20210823120106.9633-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210823120106.9633-1-straube.linux@gmail.com>
References: <20210823120106.9633-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_multicast_ether_addr instead of custom macro IS_MCAST, all
buffers are properly aligned.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index f242f3ffca70..b901d4398f03 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -411,7 +411,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	struct sta_info *psta = NULL;
 	struct ethhdr etherhdr;
 
-	int bmcast;
+	bool bmcast;
 	struct sta_priv		*pstapriv = &padapter->stapriv;
 	struct security_priv	*psecuritypriv = &padapter->securitypriv;
 	struct mlme_priv	*pmlmepriv = &padapter->mlmepriv;
@@ -472,7 +472,7 @@ static s32 update_attrib(struct adapter *padapter, struct sk_buff *pkt, struct p
 	if ((pattrib->ether_type == 0x0806) || (pattrib->ether_type == 0x888e) || (pattrib->dhcp_pkt == 1))
 		rtw_lps_ctrl_wk_cmd(padapter, LPS_CTRL_SPECIAL_PACKET, 1);
 
-	bmcast = IS_MCAST(pattrib->ra);
+	bmcast = is_multicast_ether_addr(pattrib->ra);
 
 	/*  get sta_info */
 	if (bmcast) {
@@ -597,7 +597,6 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 	struct	xmit_priv *pxmitpriv = &padapter->xmitpriv;
 	u8 priority[4] = {0x0, 0x0, 0x0, 0x0};
 	u8 hw_hdr_offset = 0;
-	int bmcst = IS_MCAST(pattrib->ra);
 
 	if (pattrib->psta)
 		stainfo = pattrib->psta;
@@ -615,7 +614,7 @@ static s32 xmitframe_addmic(struct adapter *padapter, struct xmit_frame *pxmitfr
 
 			pframe = pxmitframe->buf_addr + hw_hdr_offset;
 
-			if (bmcst) {
+			if (is_multicast_ether_addr(pattrib->ra)) {
 				if (!memcmp(psecuritypriv->dot118021XGrptxmickey[psecuritypriv->dot118021XGrpKeyid].skey, null_key, 16))
 					return _FAIL;
 				/* start to calculate the mic code */
@@ -715,12 +714,10 @@ s32 rtw_make_wlanhdr(struct adapter *padapter, u8 *hdr, struct pkt_attrib *pattr
 
 	struct sta_info *psta;
 
-	int bmcst = IS_MCAST(pattrib->ra);
-
 	if (pattrib->psta) {
 		psta = pattrib->psta;
 	} else {
-		if (bmcst) {
+		if (is_multicast_ether_addr(pattrib->ra)) {
 			psta = rtw_get_bcmc_stainfo(padapter);
 		} else {
 			psta = rtw_get_stainfo(&padapter->stapriv, pattrib->ra);
@@ -907,7 +904,7 @@ s32 rtw_xmitframe_coalesce(struct adapter *padapter, struct sk_buff *pkt, struct
 	struct xmit_priv	*pxmitpriv = &padapter->xmitpriv;
 	struct pkt_attrib	*pattrib = &pxmitframe->attrib;
 	u8 *pbuf_start;
-	s32 bmcst = IS_MCAST(pattrib->ra);
+	bool bmcst = is_multicast_ether_addr(pattrib->ra);
 	s32 res = _SUCCESS;
 
 	if (!pkt)
@@ -1801,7 +1798,7 @@ int xmitframe_enqueue_for_sleeping_sta(struct adapter *padapter, struct xmit_fra
 	struct sta_priv *pstapriv = &padapter->stapriv;
 	struct pkt_attrib *pattrib = &pxmitframe->attrib;
 	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
-	int bmcst = IS_MCAST(pattrib->ra);
+	bool bmcst = is_multicast_ether_addr(pattrib->ra);
 
 	if (!check_fwstate(pmlmepriv, WIFI_AP_STATE))
 	    return ret;
-- 
2.32.0

