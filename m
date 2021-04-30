Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D36236FD1D
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231239AbhD3PAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231758AbhD3O7D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:59:03 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5F77C061361
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:05 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id l4so105670942ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hFYXNIY5FeV5UAVQrFjKPa0zVtJHZ4wfGLP7AO6BVmE=;
        b=rJHkC9/bjQCEqKI7PwuknFsJrJObpmGkUqpWuOCCG32R2fRGN5yZ3Bs7Ve0c9sdp71
         XV4WQ+nTYYUozVFjCmas/QsxRJX8azy729oDjUdl3SPj1yurO0RDV4dFLAm+TrypKjiJ
         l1CG5/gIIXKgUZznLuwWFWgFR51bRBefUOR+RiigZ1WLSmr+uUnnabhkgstZ43qI3Rzx
         DKiVyXJmxlKMtzBo710Wm9AGF3a0cGF8FmB6O/1NP+EObMkNpt2IH8HhzYEI5KLfNqqI
         iT1nfVXg0Mjpy1DX+P8X70maxJdzKb1wfD2sYxUMwB0QO1xYAoc9QKWXQpXllh214Ixr
         Ua5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hFYXNIY5FeV5UAVQrFjKPa0zVtJHZ4wfGLP7AO6BVmE=;
        b=Pp6CgHSSmfzcIReVNdFp3P84S+znG303MLgGsL2l2PcvPfRGGAcc8SrX7hGHGmPfg7
         ASmclkg5iby+hUbAuP8ohmbtiqUUZcsfetglLOlwJNdDUJv/YQls4LcGiSa9yhBEbqnI
         +Hnsx2yFxr6Rz4iKpd1QbH371CvfyLDYe3QV4oNe/33pZSf49i82O6OP4ZGbrjfMivQB
         SGOZulRlMkOf6L0j6afRAWcWGmMyi08VaV1YOUBGZcFCSEYNDee68C3SjUGL/SwuZcQa
         9z1NASZeOWpaOXRCXWNHJICvlv3acEvcZlOAdOwl6cNz3Xdv2M2oAzfmyihHmW+XpF5E
         z+Zw==
X-Gm-Message-State: AOAM53100zgX/kMcwzXFkDKJajysa1SujhVJ3ZHhAt2GsNJRQpCl+IQb
        I0qDteegY9SQ11mcHCdO0jmlX5HmjEo=
X-Google-Smtp-Source: ABdhPJzY4a9BJokQ8s4rh+L+pvUZSWvj8J929m+rCOpu2/S8mNpL5KkMCLqTxUJYnENdFM+yZZID/A==
X-Received: by 2002:a17:907:78c4:: with SMTP id kv4mr4725634ejc.445.1619794684279;
        Fri, 30 Apr 2021 07:58:04 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id k5sm1663568edk.46.2021.04.30.07.58.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:58:03 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 35/43] staging: rtl8723bs: remove commented out DbgPrint logs
Date:   Fri, 30 Apr 2021 16:56:57 +0200
Message-Id: <63eb0244a9e25d5633d78b67fd5a0c61cb48d83e.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove commented out DbgPrint logs.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_efuse.c    |  1 -
 drivers/staging/rtl8723bs/core/rtw_recv.c     | 20 -------------------
 .../staging/rtl8723bs/hal/HalBtc8723b2Ant.c   |  1 -
 drivers/staging/rtl8723bs/hal/odm_DIG.c       |  1 -
 drivers/staging/rtl8723bs/hal/odm_HWConfig.c  | 12 -----------
 drivers/staging/rtl8723bs/hal/odm_RTL8723B.c  |  1 -
 drivers/staging/rtl8723bs/hal/sdio_halinit.c  |  2 --
 7 files changed, 38 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_efuse.c b/drivers/staging/rtl8723bs/core/rtw_efuse.c
index 1f22eb4a29fa..81457467461c 100644
--- a/drivers/staging/rtl8723bs/core/rtw_efuse.c
+++ b/drivers/staging/rtl8723bs/core/rtw_efuse.c
@@ -38,7 +38,6 @@ Efuse_Read1ByteFromFakeContent(
 {
 	if (Offset >= EFUSE_MAX_HW_SIZE)
 		return false;
-	/* DbgPrint("Read fake content, offset = %d\n", Offset); */
 	if (fakeEfuseBank == 0)
 		*Value = fakeEfuseContent[Offset];
 	else
diff --git a/drivers/staging/rtl8723bs/core/rtw_recv.c b/drivers/staging/rtl8723bs/core/rtw_recv.c
index c0689a4b7cb1..d4c1725718d9 100644
--- a/drivers/staging/rtl8723bs/core/rtw_recv.c
+++ b/drivers/staging/rtl8723bs/core/rtw_recv.c
@@ -1644,16 +1644,10 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_n
 	/*  Rx Reorder initialize condition. */
 	if (preorder_ctrl->indicate_seq == 0xFFFF) {
 		preorder_ctrl->indicate_seq = seq_num;
-
-		/* DbgPrint("check_indicate_seq, 1st->indicate_seq =%d\n", precvpriv->indicate_seq); */
 	}
 
-	/* DbgPrint("enter->check_indicate_seq(): IndicateSeq: %d, NewSeq: %d\n", precvpriv->indicate_seq, seq_num); */
-
 	/*  Drop out the packet which SeqNum is smaller than WinStart */
 	if (SN_LESS(seq_num, preorder_ctrl->indicate_seq)) {
-		/* DbgPrint("CheckRxTsIndicateSeq(): Packet Drop! IndicateSeq: %d, NewSeq: %d\n", precvpriv->indicate_seq, seq_num); */
-
 		return false;
 	}
 
@@ -1666,8 +1660,6 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_n
 		preorder_ctrl->indicate_seq = (preorder_ctrl->indicate_seq + 1) & 0xFFF;
 
 	} else if (SN_LESS(wend, seq_num)) {
-		/* DbgPrint("CheckRxTsIndicateSeq(): Window Shift! IndicateSeq: %d, NewSeq: %d\n", precvpriv->indicate_seq, seq_num); */
-
 		/*  boundary situation, when seq_num cross 0xFFF */
 		if (seq_num >= (wsize - 1))
 			preorder_ctrl->indicate_seq = seq_num + 1 - wsize;
@@ -1676,8 +1668,6 @@ static int check_indicate_seq(struct recv_reorder_ctrl *preorder_ctrl, u16 seq_n
 		pdbgpriv->dbg_rx_ampdu_window_shift_cnt++;
 	}
 
-	/* DbgPrint("exit->check_indicate_seq(): IndicateSeq: %d, NewSeq: %d\n", precvpriv->indicate_seq, seq_num); */
-
 	return true;
 }
 
@@ -1689,8 +1679,6 @@ static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, un
 	union recv_frame *pnextrframe;
 	struct rx_pkt_attrib *pnextattrib;
 
-	/* DbgPrint("+enqueue_reorder_recvframe()\n"); */
-
 	/* spin_lock_irqsave(&ppending_recvframe_queue->lock, irql); */
 	/* spin_lock(&ppending_recvframe_queue->lock); */
 
@@ -1711,8 +1699,6 @@ static int enqueue_reorder_recvframe(struct recv_reorder_ctrl *preorder_ctrl, un
 		else
 			break;
 
-		/* DbgPrint("enqueue_reorder_recvframe():while\n"); */
-
 	}
 
 
@@ -1751,8 +1737,6 @@ static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reor
 	struct dvobj_priv *psdpriv = padapter->dvobj;
 	struct debug_priv *pdbgpriv = &psdpriv->drv_dbg;
 
-	/* DbgPrint("+recv_indicatepkts_in_order\n"); */
-
 	/* spin_lock_irqsave(&ppending_recvframe_queue->lock, irql); */
 	/* spin_lock(&ppending_recvframe_queue->lock); */
 
@@ -1796,7 +1780,6 @@ static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reor
 			/*  Indicate packets */
 
 			/* indicate this recv_frame */
-			/* DbgPrint("recv_indicatepkts_in_order, indicate_seq =%d, seq_num =%d\n", precvpriv->indicate_seq, pattrib->seq_num); */
 			if (!pattrib->amsdu) {
 				if ((padapter->bDriverStopped == false) &&
 				    (padapter->bSurpriseRemoved == false))
@@ -1819,8 +1802,6 @@ static int recv_indicatepkts_in_order(struct adapter *padapter, struct recv_reor
 			break;
 		}
 
-		/* DbgPrint("recv_indicatepkts_in_order():while\n"); */
-
 	}
 
 	/* spin_unlock(&ppending_recvframe_queue->lock); */
@@ -1890,7 +1871,6 @@ static int recv_indicatepkt_reorder(struct adapter *padapter, union recv_frame *
 
 	/* s3. Insert all packet into Reorder Queue to maintain its ordering. */
 	if (!enqueue_reorder_recvframe(preorder_ctrl, prframe)) {
-		/* DbgPrint("recv_indicatepkt_reorder, enqueue_reorder_recvframe fail!\n"); */
 		/* spin_unlock_irqrestore(&ppending_recvframe_queue->lock, irql); */
 		/* return _FAIL; */
 		goto _err_exit;
diff --git a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
index 15304feb2442..6822990bca7f 100644
--- a/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
+++ b/drivers/staging/rtl8723bs/hal/HalBtc8723b2Ant.c
@@ -1756,7 +1756,6 @@ static void halbtc8723b2ant_ActionA2dp(struct btc_coexist *pBtCoexist)
 
 	/*  define the office environment */
 	if (apNum >= 10 && BTC_RSSI_HIGH(wifiRssiState1)) {
-		/* DbgPrint(" AP#>10(%d)\n", apNum); */
 		pBtCoexist->fBtcSetRfReg(pBtCoexist, BTC_RF_A, 0x1, 0xfffff, 0x0);
 		halbtc8723b2ant_LimitedRx(pBtCoexist, NORMAL_EXEC, false, false, 0x8);
 		halbtc8723b2ant_FwDacSwingLvl(pBtCoexist, NORMAL_EXEC, 6);
diff --git a/drivers/staging/rtl8723bs/hal/odm_DIG.c b/drivers/staging/rtl8723bs/hal/odm_DIG.c
index 4bb558426427..702bb065636a 100644
--- a/drivers/staging/rtl8723bs/hal/odm_DIG.c
+++ b/drivers/staging/rtl8723bs/hal/odm_DIG.c
@@ -152,7 +152,6 @@ void odm_SearchPwdBLowerBound(void *pDM_VOID, u8 IGI_target)
 			else
 				pDM_Odm->txEdcca0 = pDM_Odm->txEdcca0 + 1;
 		}
-		/* DbgPrint("txEdcca1 = %d, txEdcca0 = %d\n", pDM_Odm->txEdcca1, pDM_Odm->txEdcca0); */
 
 		if (pDM_Odm->txEdcca1 > 5) {
 			IGI = IGI-1;
diff --git a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
index db703a3b1b25..179199993fa7 100644
--- a/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
+++ b/drivers/staging/rtl8723bs/hal/odm_HWConfig.c
@@ -59,7 +59,6 @@ static u8 odm_EVMdbToPercentage(s8 Value)
 	ret_val = Value;
 	ret_val /= 2;
 
-	/* DbgPrint("Value =%d\n", Value); */
 	/* ODM_RT_DISP(FRX, RX_PHY_SQ, ("EVMdbToPercentage92C Value =%d / %x\n", ret_val, ret_val)); */
 
 	if (ret_val >= 0)
@@ -141,7 +140,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 
 			}
 
-			/* DbgPrint("cck SQ = %d\n", SQ); */
 			pPhyInfo->signal_quality = SQ;
 			pPhyInfo->rx_mimo_signal_quality[ODM_RF_PATH_A] = SQ;
 			pPhyInfo->rx_mimo_signal_quality[ODM_RF_PATH_B] = -1;
@@ -231,9 +229,6 @@ static void odm_RxPhyStatus92CSeries_Parsing(
 			pPhyInfo->signal_strength = (u8)(odm_SignalScaleMapping(pDM_Odm, total_rssi /= rf_rx_num));
 		}
 	}
-
-	/* DbgPrint("isCCKrate = %d, pPhyInfo->rx_pwd_ba11 = %d, pPhyStaRpt->cck_agc_rpt_ofdm_cfosho_a = 0x%x\n", */
-		/* isCCKrate, pPhyInfo->rx_pwd_ba11, pPhyStaRpt->cck_agc_rpt_ofdm_cfosho_a); */
 }
 
 static void odm_Process_RSSIForDM(
@@ -285,8 +280,6 @@ static void odm_Process_RSSIForDM(
 				pDM_Odm->RSSI_A = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_A];
 				pDM_Odm->RSSI_B = 0;
 			} else {
-				/* DbgPrint("pRfd->Status.rx_mimo_signal_strength[0] = %d, pRfd->Status.rx_mimo_signal_strength[1] = %d\n", */
-					/* pRfd->Status.rx_mimo_signal_strength[0], pRfd->Status.rx_mimo_signal_strength[1]); */
 				pDM_Odm->RSSI_A =  pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_A];
 				pDM_Odm->RSSI_B = pPhyInfo->rx_mimo_signal_strength[ODM_RF_PATH_B];
 
@@ -376,11 +369,6 @@ static void odm_Process_RSSIForDM(
 			pEntry->rssi_stat.UndecoratedSmoothedCCK = UndecoratedSmoothedCCK;
 			pEntry->rssi_stat.UndecoratedSmoothedOFDM = UndecoratedSmoothedOFDM;
 			pEntry->rssi_stat.UndecoratedSmoothedPWDB = UndecoratedSmoothedPWDB;
-
-			/* DbgPrint("OFDM_pkt =%d, Weighting =%d\n", OFDM_pkt, Weighting); */
-			/* DbgPrint("UndecoratedSmoothedOFDM =%d, UndecoratedSmoothedPWDB =%d, UndecoratedSmoothedCCK =%d\n", */
-			/* UndecoratedSmoothedOFDM, UndecoratedSmoothedPWDB, UndecoratedSmoothedCCK); */
-
 		}
 
 	}
diff --git a/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c b/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c
index ecf0045fcad9..54518ea1be6b 100644
--- a/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c
+++ b/drivers/staging/rtl8723bs/hal/odm_RTL8723B.c
@@ -29,7 +29,6 @@ s8 odm_CCKRSSI_8723B(u8 LNA_idx, u8 VGA_idx)
 		break;
 	default:
 		/* rx_pwr_all = -53+(2*(31-VGA_idx)); */
-		/* DbgPrint("wrong LNA index\n"); */
 		break;
 
 	}
diff --git a/drivers/staging/rtl8723bs/hal/sdio_halinit.c b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
index fd060cf7bc57..a63f2f6bf7c1 100644
--- a/drivers/staging/rtl8723bs/hal/sdio_halinit.c
+++ b/drivers/staging/rtl8723bs/hal/sdio_halinit.c
@@ -791,8 +791,6 @@ static u32 rtl8723bs_hal_init(struct adapter *padapter)
 
 	rtl8723b_InitHalDm(padapter);
 
-	/* DbgPrint("pHalData->DefaultTxPwrDbm = %d\n", pHalData->DefaultTxPwrDbm); */
-
 	/*  */
 	/*  Update current Tx FIFO page status. */
 	/*  */
-- 
2.20.1

