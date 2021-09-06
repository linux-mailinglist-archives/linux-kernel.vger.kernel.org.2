Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4104401F9A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:31:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244770AbhIFS0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244420AbhIFS0P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:15 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361E5C061757
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z19so10496157edi.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uYnkOq4yxqkoB1rb/ew5x0vj+H8yKqRwDVySAJFiDa4=;
        b=EzU9kd5XNbd0wT2oUmX5yDNHIPCGQ00/XkrhMQHPTROLtDz0FIIgbxYk3KYF7MFjq5
         rQi8Dsx8BCG8LdyEWg/KMuIvZ7NattnD+C5lv5zU7Yit2bN645C5VpyTI31HAQ4ibqd0
         yTSUdTp9FjxtKZTg8OnV2cHfq6ukBvX0YrBAtCyWDWvOZRp2h6U9qvZi2K6YR3RfLfr2
         N1LWeyx1Wrb9RQLFvHrFhIZMfkP3VVV+kt4CznvCrLp0IJjqm93GQu+hSay/mPENmbdJ
         uhke9jtranboPd7KCJQSZCR2VSNEhdtMCFd0gt7McenuNRhakjn+7imDW2g4HL4NZc1F
         xk8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uYnkOq4yxqkoB1rb/ew5x0vj+H8yKqRwDVySAJFiDa4=;
        b=VO0XJPhJaTOZAhSl9TZu7u/Jqvtr9mreM7Rhs+rH/cpIUmHjJ+63y1RCBN1Wr9m16Q
         7fSZdVtG99qE/02TqITGNG9A75BwC2BxJIzv6KXB30jfv/lSwSpeWVOK6rKv3Jyh30Nx
         cN5eZWL9O6SYrqjySITDC44DFBjbDtqHZ5N9P5QFhGwlumk5hMoeO51BcENp+xL9H0UC
         4CQeI+kE9VGo2wvtHW9xbbU5CWwk4M1tgHNbvniH4hN6EkOuEdbVMHraOKESVzP4qAZU
         Tx7VKZH8Mh2/+dDa5Lugavig1QXXt0ck2jlN6OeWmjTrE17GyVewbAVeGv09LRRrZy7+
         6DYQ==
X-Gm-Message-State: AOAM531fE5Xbbgk4AxGdD1u3MIyMfIZlYYEvnyLm9ks39Ncu9+u4U5Wc
        fg+8kvCqK6vpgovi4ulCgcc=
X-Google-Smtp-Source: ABdhPJwltkpVvybmdUJSVR0384sSYGDkP2ujpdZBb9yGyJ9ep68eO+bzHV01fUUahSdz7EsOaLYgig==
X-Received: by 2002:a50:9e0f:: with SMTP id z15mr14695966ede.40.1630952708859;
        Mon, 06 Sep 2021 11:25:08 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:08 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 10/40] staging: r8188eu: remove set_bwmode_handler from hal_ops
Date:   Mon,  6 Sep 2021 20:24:08 +0200
Message-Id: <20210906182438.5417-11-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set_bwmode_handler from hal_ops and remove its wrapper
rtw_hal_set_bwmode(). Call PHY_SetBWMode8188E() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c    | 2 +-
 drivers/staging/r8188eu/hal/hal_intf.c          | 8 --------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 1 -
 drivers/staging/r8188eu/include/hal_intf.h      | 5 -----
 4 files changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index ccb5fbbc3ffb..37400e29eec4 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -328,7 +328,7 @@ void SetBWMode(struct adapter *padapter, unsigned short bwmode,
 	rtw_set_oper_bw(padapter, bwmode);
 	rtw_set_oper_choffset(padapter, channel_offset);
 
-	rtw_hal_set_bwmode(padapter, (enum ht_channel_width)bwmode, channel_offset);
+	PHY_SetBWMode8188E(padapter, (enum ht_channel_width)bwmode, channel_offset);
 }
 
 void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigned char channel_offset, unsigned short bwmode)
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 9374e5ecb13b..93691e72e263 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -215,14 +215,6 @@ void rtw_hal_write_rfreg(struct adapter *adapt, enum rf_radio_path rfpath,
 					      bitmask, data);
 }
 
-void rtw_hal_set_bwmode(struct adapter *adapt,
-			enum ht_channel_width bandwidth, u8 offset)
-{
-	if (adapt->HalFunc.set_bwmode_handler)
-		adapt->HalFunc.set_bwmode_handler(adapt, bandwidth,
-						     offset);
-}
-
 void rtw_hal_set_chan(struct adapter *adapt, u8 channel)
 {
 	if (adapt->HalFunc.set_channel_handler)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 844a18117f09..8a73294d8bec 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1784,7 +1784,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	pHalFunc->free_hal_data = &rtl8188e_free_hal_data;
 
-	pHalFunc->set_bwmode_handler = &PHY_SetBWMode8188E;
 	pHalFunc->set_channel_handler = &PHY_SwChnl8188E;
 
 	pHalFunc->Add_RateATid = &rtl8188e_Add_RateATid;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index caf759a9eb48..f3f294aa6a24 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -143,9 +143,6 @@ struct hal_ops {
 	s32	(*init_recv_priv)(struct adapter *padapter);
 	void	(*free_recv_priv)(struct adapter *padapter);
 
-	void	(*set_bwmode_handler)(struct adapter *padapter,
-				      enum ht_channel_width Bandwidth,
-				      u8 Offset);
 	void	(*set_channel_handler)(struct adapter *padapter, u8 channel);
 
 	void	(*SetHwRegHandler)(struct adapter *padapter, u8	variable,
@@ -284,8 +281,6 @@ void	rtw_hal_write_rfreg(struct adapter *padapter,
 			    enum rf_radio_path eRFPath, u32 RegAddr,
 			    u32 BitMask, u32 Data);
 
-void	rtw_hal_set_bwmode(struct adapter *padapter,
-			   enum ht_channel_width Bandwidth, u8 Offset);
 void	rtw_hal_set_chan(struct adapter *padapter, u8 channel);
 
 u8	rtw_hal_antdiv_before_linked(struct adapter *padapter);
-- 
2.33.0

