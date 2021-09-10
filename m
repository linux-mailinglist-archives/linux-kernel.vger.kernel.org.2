Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FA0406A77
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Sep 2021 13:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhIJLGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Sep 2021 07:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbhIJLGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Sep 2021 07:06:48 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E972BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 04:05:37 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id w29so1291762wra.8
        for <linux-kernel@vger.kernel.org>; Fri, 10 Sep 2021 04:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+2y44jrbQZGFptWL4+9rlLk/L6X6IpiDOKRP2pw5kk=;
        b=fTbU5XztU0aX2FTKtgupluCvSj3mjTLq5tGmYLz2HF4sN1HKrI9ErcF/uCCu7iDaQL
         FkPeyL99+UQ359etrwesJcgOUt8tZ2JHH3cMiQ/5pqCGxrG827SVXw5k2S4/NDYyG0tQ
         l6/EkIYIZ/YGg33Y5tIhKAEtn5XS3kus6pPm4KOXu4jy+xn8fnwoAA4M4Zh+AI8zKnA8
         r+Nh+J67fRyw0YWa6LYJrtZ/tQy668OSWc1dx827Om2CAUytthVHX4MI6KGUKs1Y/TpU
         NZADVRy0tuo/4BHrWVxlULZkGqwgKefNkfeE78TK9vI3t0wIO0nkWKeRLSSga1uHZ4s/
         518g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=W+2y44jrbQZGFptWL4+9rlLk/L6X6IpiDOKRP2pw5kk=;
        b=EDaz0IeoHJnOt4In5UrnMcYe++TlA+aadzK+KBKYQbCZlpJI0+Cpw0WSWJIramvU94
         QG/YfdMaxz7gOMs1ZJOGiJr2MUAPhpF0Z+AV/hrCGzYoCW9OSro7mdXrF/RIP6r0V0V+
         bwUEhVQosbYYkU/cmWcQeinpU4RCe1C4u8D7GmQ4YvpH3bzRCydsWvoblMdK3DjO5zOe
         2VxkGXKtw7ZjFJ5a6wp0DxmyV0wwy4gCKKYtJbRBGrRFsbxA/ae1fmg4udSXvf9M/q6w
         mlPMVFuBkscDHu4AI8AjwxeqN1/hQM0I/cxdJQdQCbnuzkdZ8SIAuGasm/9VLPw3ssWH
         ivsA==
X-Gm-Message-State: AOAM531mtX746ZmAxonc/Lku1qHGwt4hQbkS0x8fY1orYihsIjKqfjC7
        BsiDX0vmtIId0QSN7KP6Fh8=
X-Google-Smtp-Source: ABdhPJyaGBz0R2W64Irxq4HNeUTmhYRytc71ZTb+/j5fiTsvU8CabUGa0U7AZfa2g71jchXvNHuMTw==
X-Received: by 2002:adf:fb07:: with SMTP id c7mr1458401wrr.399.1631271936605;
        Fri, 10 Sep 2021 04:05:36 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id h8sm3920783wmb.35.2021.09.10.04.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:05:36 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 1/3] staging: r8188eu: remove IOL_exec_cmds_sync() from struct hal_ops
Date:   Fri, 10 Sep 2021 13:05:24 +0200
Message-Id: <20210910110526.4093-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove IOL_exec_cmds_sync() from struct hal_ops and its wrapper
rtw_hal_iol_cmd(). Call rtl8188e_IOL_exec_cmds_sync() directly
instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_iol.c          |  2 +-
 drivers/staging/r8188eu/hal/hal_intf.c          | 10 ----------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c |  4 +---
 drivers/staging/r8188eu/include/hal_intf.h      | 10 +++-------
 4 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_iol.c b/drivers/staging/r8188eu/core/rtw_iol.c
index 5c1b19679cad..9c85e590fc9d 100644
--- a/drivers/staging/r8188eu/core/rtw_iol.c
+++ b/drivers/staging/r8188eu/core/rtw_iol.c
@@ -74,7 +74,7 @@ bool rtw_IOL_applied(struct adapter  *adapter)
 
 int rtw_IOL_exec_cmds_sync(struct adapter  *adapter, struct xmit_frame *xmit_frame, u32 max_wating_ms, u32 bndy_cnt)
 {
-	return rtw_hal_iol_cmd(adapter, xmit_frame, max_wating_ms, bndy_cnt);
+	return rtl8188e_IOL_exec_cmds_sync(adapter, xmit_frame, max_wating_ms, bndy_cnt);
 }
 
 int rtw_IOL_append_LLT_cmd(struct xmit_frame *xmit_frame, u8 page_boundary)
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 92c55b9ab244..849651bbab5e 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -177,13 +177,3 @@ void rtw_hal_write_rfreg(struct adapter *adapt, enum rf_radio_path rfpath,
 		adapt->HalFunc.write_rfreg(adapt, rfpath, regaddr,
 					      bitmask, data);
 }
-
-int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
-		    u32 max_wating_ms, u32 bndy_cnt)
-{
-	if (adapter->HalFunc.IOL_exec_cmds_sync)
-		return adapter->HalFunc.IOL_exec_cmds_sync(adapter, xmit_frame,
-							   max_wating_ms,
-							   bndy_cnt);
-	return _FAIL;
-}
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 8278493e3489..5ea96a5ac630 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -306,7 +306,7 @@ static s32 iol_ioconfig(struct adapter *padapter, u8 iocfg_bndy)
 	return rst;
 }
 
-static int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter, struct xmit_frame *xmit_frame, u32 max_wating_ms, u32 bndy_cnt)
+int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter, struct xmit_frame *xmit_frame, u32 max_wating_ms, u32 bndy_cnt)
 {
 	struct pkt_attrib *pattrib = &xmit_frame->attrib;
 	u8 i;
@@ -1754,8 +1754,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 	pHalFunc->write_bbreg = &rtl8188e_PHY_SetBBReg;
 	pHalFunc->read_rfreg = &rtl8188e_PHY_QueryRFReg;
 	pHalFunc->write_rfreg = &rtl8188e_PHY_SetRFReg;
-
-	pHalFunc->IOL_exec_cmds_sync = &rtl8188e_IOL_exec_cmds_sync;
 }
 
 u8 GetEEPROMSize8188E(struct adapter *padapter)
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index 727ef8511f64..c1e120593574 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -162,10 +162,6 @@ struct hal_ops {
 	void	(*write_rfreg)(struct adapter *padapter,
 			       enum rf_radio_path eRFPath, u32 RegAddr,
 			       u32 BitMask, u32 Data);
-
-	int (*IOL_exec_cmds_sync)(struct adapter *padapter,
-				  struct xmit_frame *frame, u32 max_wait,
-				  u32 bndy_cnt);
 };
 
 #define RF_CHANGE_BY_INIT	0
@@ -204,6 +200,9 @@ void hal_notch_filter_8188e(struct adapter *adapter, bool enable);
 void SetBeaconRelatedRegisters8188EUsb(struct adapter *adapt);
 void UpdateHalRAMask8188EUsb(struct adapter *adapt, u32 mac_id, u8 rssi_level);
 
+int rtl8188e_IOL_exec_cmds_sync(struct adapter *adapter,
+				struct xmit_frame *xmit_frame, u32 max_wating_ms, u32 bndy_cnt);
+
 uint rtw_hal_init(struct adapter *padapter);
 uint rtw_hal_deinit(struct adapter *padapter);
 void rtw_hal_stop(struct adapter *padapter);
@@ -240,9 +239,6 @@ void	rtw_hal_write_rfreg(struct adapter *padapter,
 			    enum rf_radio_path eRFPath, u32 RegAddr,
 			    u32 BitMask, u32 Data);
 
-int rtw_hal_iol_cmd(struct adapter  *adapter, struct xmit_frame *xmit_frame,
-		    u32 max_wating_ms, u32 bndy_cnt);
-
 void indicate_wx_scan_complete_event(struct adapter *padapter);
 u8 rtw_do_join(struct adapter *padapter);
 
-- 
2.33.0

