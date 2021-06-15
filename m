Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3221D3A72DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:16:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhFOASa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbhFOAS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:18:29 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19820C061767
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:16:15 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 5so11160295qvf.1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lMWqJmjrpvLtZqVobxXtt4msj7Q2FIK8Lw4t02MOvsw=;
        b=D1jZ08n7KbkSxfAQZOPdGI9Wn9MVQcZJH9aNAmDr0d382WHXxMLUhlND6boW+S8W8L
         naelbKZxS39ATb7voLZKu7whFJj0v7tgigEW2sMoekg0Ypz0/D5kESzjMyK+MjdSWx6v
         1r5D8UZSbb/2kEJmd3FkfSU2aNJbxu8jy5tncRQ2sDwfjLJJuELYAySmZ1f+qXa6b1tb
         4al+aSWYlF/0kwdydQIj3R03YM74Mq/DQKWjRmDXC+F6n6QpYt+h79lSpUzDoEq/9rzf
         f1FUSnZrdDP2DqqhQiAMNIRV78ZYX1gk81DbC/mwBhrTd3vTnbjRfHucRA6I4Z+evFyX
         tlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lMWqJmjrpvLtZqVobxXtt4msj7Q2FIK8Lw4t02MOvsw=;
        b=o5/Sha28yBy4dzjlTTmI1Eq2pKjrATtLodeqEH5IOilH+G5Aba9UukufmVN2nHsRy1
         CqdAJy/pomZ7cQduDK4F9fAKyDqOLz6fYgyDeZB/CHnIBhSvdrqLkDhQoJial30x6Dyj
         h0ZcTWjuRVj+sdU6MYLA9rEBpJ1ncIgPOp1QkI+xm2J/aqs0ilrHG6RwV9JbjoQB0FyE
         vvThoWE/Kuopg9c1UgnwJKrgssvLLg7HLSUo0ZlxUz3+BXybJHl6WeQ2dtjicZfSkb78
         CfZyCkqGsJ4YbdHfdVBFPOPO3P+yvVEjIQo8zIEivhx6c8/0SNVwIKH/0tNnjn77eviy
         ZT1g==
X-Gm-Message-State: AOAM530BInWuQ6/X8GM+Rh3DpsLzbau19iXXhRNOjZefjXglyDwCK6DW
        wK6hqSG1olpVyqfqNYRfwe56ZH1V+lIPXkgH
X-Google-Smtp-Source: ABdhPJz/oFIU0QYnDNjOiTe37DxuFT7U9gse1+aWTtgL+upxhjFOdSE1i2K3joCsNaZAdrn/kMDqKA==
X-Received: by 2002:a05:6214:1551:: with SMTP id t17mr1826207qvw.50.1623716174229;
        Mon, 14 Jun 2021 17:16:14 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:16:13 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 18/28] staging: rtl8188eu: remove all DBG_88E calls from hal/rtl8188e_cmd.c
Date:   Tue, 15 Jun 2021 01:14:57 +0100
Message-Id: <20210615001507.1171-19-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from hal/rtl8188e_cmd.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c | 42 +++-----------------
 1 file changed, 6 insertions(+), 36 deletions(-)

diff --git a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
index d6c83e4fb105..19c8976c2e01 100644
--- a/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
+++ b/drivers/staging/rtl8188eu/hal/rtl8188e_cmd.c
@@ -55,11 +55,8 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 	u32 h2c_cmd_ex = 0;
 	s32 ret = _FAIL;
 
-	if (!adapt->bFWReady) {
-		DBG_88E("%s(): return H2C cmd because fw is not ready\n",
-			__func__);
+	if (!adapt->bFWReady)
 		return ret;
-	}
 
 	if (!pCmdBuffer)
 		goto exit;
@@ -71,10 +68,8 @@ static s32 FillH2CCmd_88E(struct adapter *adapt, u8 ElementID, u32 CmdLen, u8 *p
 	/* pay attention to if  race condition happened in  H2C cmd setting. */
 	h2c_box_num = adapt->HalData->LastHMEBoxNum;
 
-	if (!_is_fw_read_cmd_down(adapt, h2c_box_num)) {
-		DBG_88E(" fw read cmd failed...\n");
+	if (!_is_fw_read_cmd_down(adapt, h2c_box_num))
 		goto exit;
-	}
 
 	*(u8 *)(&h2c_cmd) = ElementID;
 
@@ -134,9 +129,6 @@ void rtw_hal_add_ra_tid(struct adapter *pAdapter, u32 bitmap, u8 arg, u8 rssi_le
 
 	bitmap &= 0x0fffffff;
 
-	DBG_88E("%s=> mac_id:%d, raid:%d, ra_bitmap=0x%x, shortGIrate=0x%02x\n",
-		__func__, macid, raid, bitmap, shortGIrate);
-
 	ODM_RA_UpdateRateInfo_8188E(odmpriv, macid, raid, bitmap, shortGIrate);
 }
 
@@ -146,9 +138,6 @@ void rtl8188e_set_FwPwrMode_cmd(struct adapter *adapt, u8 Mode)
 	struct pwrctrl_priv *pwrpriv = &adapt->pwrctrlpriv;
 	u8 RLBM = 0; /*  0:Min, 1:Max, 2:User define */
 
-	DBG_88E("%s: Mode=%d SmartPS=%d UAPSD=%d\n", __func__,
-		Mode, pwrpriv->smart_ps, adapt->registrypriv.uapsd_enable);
-
 	switch (Mode) {
 	case PS_MODE_ACTIVE:
 		H2CSetPwrMode.Mode = 0;
@@ -194,7 +183,6 @@ void rtl8188e_set_FwMediaStatus_cmd(struct adapter *adapt, __le16 mstatus_rpt)
 	opmode = (u8)mst_rpt;
 	macid = (u8)(mst_rpt >> 8);
 
-	DBG_88E("### %s: MStatus=%x MACID=%d\n", __func__, opmode, macid);
 	FillH2CCmd_88E(adapt, H2C_COM_MEDIA_STATUS_RPT, sizeof(mst_rpt), (u8 *)&mst_rpt);
 }
 
@@ -275,10 +263,8 @@ static void ConstructBeacon(struct adapter *adapt, u8 *pframe, u32 *pLength)
 
 _ConstructBeacon:
 
-	if ((pktlen + TXDESC_SIZE) > 512) {
-		DBG_88E("beacon frame too large\n");
+	if ((pktlen + TXDESC_SIZE) > 512)
 		return;
-	}
 
 	*pLength = pktlen;
 }
@@ -440,12 +426,9 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 	struct rsvdpage_loc RsvdPageLoc;
 	struct wlan_bssid_ex *pnetwork;
 
-	DBG_88E("%s\n", __func__);
 	ReservedPagePacket = kzalloc(1000, GFP_KERNEL);
-	if (!ReservedPagePacket) {
-		DBG_88E("%s: alloc ReservedPagePacket fail!\n", __func__);
+	if (!ReservedPagePacket)
 		return;
-	}
 
 	pxmitpriv = &adapt->xmitpriv;
 	pmlmeext = &adapt->mlmeextpriv;
@@ -523,7 +506,6 @@ static void SetFwRsvdPagePkt(struct adapter *adapt, bool bDLFinished)
 
 	rtw_hal_mgnt_xmit(adapt, pmgntframe);
 
-	DBG_88E("%s: Set RSVD page location to Fw\n", __func__);
 	FillH2CCmd_88E(adapt, H2C_COM_RSVD_PAGE, sizeof(RsvdPageLoc), (u8 *)&RsvdPageLoc);
 
 exit:
@@ -540,8 +522,6 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 	u8 DLBcnCount = 0;
 	u32 poll = 0;
 
-	DBG_88E("%s mstatus(%x)\n", __func__, mstatus);
-
 	if (mstatus == 1) {
 		/*  We should set AID, correct TSF, HW seq enable before set JoinBssReport to Fw in 88/92C. */
 		/*  Suggested by filen. Added by tynli. */
@@ -558,10 +538,8 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		usb_write8(adapt, REG_BCN_CTRL, usb_read8(adapt, REG_BCN_CTRL) & (~BIT(3)));
 		usb_write8(adapt, REG_BCN_CTRL, usb_read8(adapt, REG_BCN_CTRL) | BIT(4));
 
-		if (haldata->RegFwHwTxQCtrl & BIT(6)) {
-			DBG_88E("HalDownloadRSVDPage(): There is an Adapter is sending beacon.\n");
+		if (haldata->RegFwHwTxQCtrl & BIT(6))
 			bSendBeacon = true;
-		}
 
 		/*  Set FWHW_TXQ_CTRL 0x422[6]=0 to tell Hw the packet is not a real beacon frame. */
 		usb_write8(adapt, REG_FWHW_TXQ_CTRL + 2, (haldata->RegFwHwTxQCtrl & (~BIT(6))));
@@ -584,12 +562,6 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 			} while (!bcn_valid && (poll % 10) != 0 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
 		} while (!bcn_valid && DLBcnCount <= 100 && !adapt->bSurpriseRemoved && !adapt->bDriverStopped);
 
-		if (adapt->bSurpriseRemoved || adapt->bDriverStopped)
-			;
-		else if (!bcn_valid)
-			DBG_88E("%s: 1 Download RSVD page failed! DLBcnCount:%u, poll:%u\n", __func__, DLBcnCount, poll);
-		else
-			DBG_88E("%s: 1 Download RSVD success! DLBcnCount:%u, poll:%u\n", __func__, DLBcnCount, poll);
 		/*  */
 		/*  We just can send the reserved page twice during the time that Tx thread is stopped (e.g. pnpsetpower) */
 		/*  because we need to free the Tx BCN Desc which is used by the first reserved page packet. */
@@ -612,10 +584,8 @@ void rtl8188e_set_FwJoinBssReport_cmd(struct adapter *adapt, u8 mstatus)
 		}
 
 		/*  Update RSVD page location H2C to Fw. */
-		if (bcn_valid) {
+		if (bcn_valid)
 			rtw_hal_set_hwreg(adapt, HW_VAR_BCN_VALID, NULL);
-			DBG_88E("Set RSVD page location to Fw.\n");
-		}
 
 		/*  Do not enable HW DMA BCN or it will cause Pcie interface hang by timing issue. 2011.11.24. by tynli. */
 		/*  Clear CR[8] or beacon packet will not be send to TxBuf anymore. */
-- 
2.30.2

