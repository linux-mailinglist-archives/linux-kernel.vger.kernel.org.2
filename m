Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27FF0401F9B
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 20:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244720AbhIFS0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 14:26:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244395AbhIFS0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 14:26:16 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8D6C061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 11:25:10 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r7so10511272edd.6
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 11:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gDDbV5k8w+ZNilfMRl6tEIv8pUv9RSEpEzotQr9O7i4=;
        b=khdgJ6FeRC5Dxs0YER97Gm68F1hGJsbEtbtcF65+B8X3DIkmdNSN6xNt645KH91174
         /MT4OeBhV2V2aMuAmqrLuI6nv1SgXArv9CkJOxMoJfaMvC8baF3HmAWCycfJTz5cueXY
         gbx7ihOwyAW83HlK+kuvyrPFfgwiC3QUFv7xps7rqo+cjbHZ/kj/KAhzhAZuDHEt1YQE
         7B+dcaXLFmIO9rVEnkxGIB3XArPEtqxEADCjgUx2wym9YZy7Z5QQLU5ChiJo+//uH+Ps
         O8QgvDJXtksRSFbmMDL9fu9Q7qgeZ1gB9YEuhW1jTE9aYFxOE8fEdo5rKcGU4Lx6AqjQ
         18Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gDDbV5k8w+ZNilfMRl6tEIv8pUv9RSEpEzotQr9O7i4=;
        b=GcHn3fFdXA4eGk/thk0UDvpE1q9RD6hBxtpt91GTnPZeRpxypulBROl7m7hMcr8FTZ
         wVWqel7156RW79ATc4uhPd9L09PugYbZGvkC2xdO3U2eoiDnWi5Ly0wdC139jqbyR/FJ
         dmX3FUVwrva4jGZZKW8CEloDvYSYoDQRvARBocc0EJw1w5ZfHzHc8OFf54cwBO9YPdMi
         6+9UlS1Mfm5gWx0xGS9e4xBkRzKhtKDR6RDCRBl59p61FOcXdL916YRrpRDqyjVNC18o
         MxrGqze6cKZxqJEhvD3GA58LYxvaCYVebWL+15L18Jq5siD1EQezOoWNXNjyfMA27GTn
         1y1Q==
X-Gm-Message-State: AOAM530v6JNTrdeIA1IBepZfA/2NJ8q9V3Gn3rgQSnpC+FgooZcq+Mww
        nCjmUwasJd3Qk6dh0c2I31A=
X-Google-Smtp-Source: ABdhPJwdVy3ZKXaxmCqZNYnAsrh4aA3ZzNZmGKPOaF/KDoJlh+uR9NGUvuxqFu3b9+GRKn0A+REFSA==
X-Received: by 2002:aa7:da56:: with SMTP id w22mr14559059eds.89.1630952709546;
        Mon, 06 Sep 2021 11:25:09 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id s25sm4284492ejq.17.2021.09.06.11.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 11:25:09 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 11/40] staging: r8188eu: remove set_channel_handler from hal_ops
Date:   Mon,  6 Sep 2021 20:24:09 +0200
Message-Id: <20210906182438.5417-12-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210906182438.5417-1-straube.linux@gmail.com>
References: <20210906182438.5417-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove set_channel_handler from hal_ops and remove its wrapper
rtw_hal_set_chan(). Call PHY_SwChnl8188E() directly instead.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_wlan_util.c    | 4 ++--
 drivers/staging/r8188eu/hal/hal_intf.c          | 6 ------
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 2 --
 drivers/staging/r8188eu/include/hal_intf.h      | 4 ----
 4 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_wlan_util.c b/drivers/staging/r8188eu/core/rtw_wlan_util.c
index 37400e29eec4..cd4f1ae61dca 100644
--- a/drivers/staging/r8188eu/core/rtw_wlan_util.c
+++ b/drivers/staging/r8188eu/core/rtw_wlan_util.c
@@ -318,7 +318,7 @@ void SelectChannel(struct adapter *padapter, unsigned char channel)
 {
 	/* saved channel info */
 	rtw_set_oper_ch(padapter, channel);
-	rtw_hal_set_chan(padapter, channel);
+	PHY_SwChnl8188E(padapter, channel);
 }
 
 void SetBWMode(struct adapter *padapter, unsigned short bwmode,
@@ -359,7 +359,7 @@ void set_channel_bwmode(struct adapter *padapter, unsigned char channel, unsigne
 	rtw_set_oper_bw(padapter, bwmode);
 	rtw_set_oper_choffset(padapter, channel_offset);
 
-	rtw_hal_set_chan(padapter, center_ch); /*  set center channel */
+	PHY_SwChnl8188E(padapter, center_ch); /*  set center channel */
 	SetBWMode(padapter, bwmode, channel_offset);
 }
 
diff --git a/drivers/staging/r8188eu/hal/hal_intf.c b/drivers/staging/r8188eu/hal/hal_intf.c
index 93691e72e263..79a2a5a0abd9 100644
--- a/drivers/staging/r8188eu/hal/hal_intf.c
+++ b/drivers/staging/r8188eu/hal/hal_intf.c
@@ -215,12 +215,6 @@ void rtw_hal_write_rfreg(struct adapter *adapt, enum rf_radio_path rfpath,
 					      bitmask, data);
 }
 
-void rtw_hal_set_chan(struct adapter *adapt, u8 channel)
-{
-	if (adapt->HalFunc.set_channel_handler)
-		adapt->HalFunc.set_channel_handler(adapt, channel);
-}
-
 void rtw_hal_bcn_related_reg_setting(struct adapter *adapt)
 {
 	if (adapt->HalFunc.SetBeaconRelatedRegistersHandler)
diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 8a73294d8bec..4274b11e456c 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1784,8 +1784,6 @@ void rtl8188e_set_hal_ops(struct hal_ops *pHalFunc)
 {
 	pHalFunc->free_hal_data = &rtl8188e_free_hal_data;
 
-	pHalFunc->set_channel_handler = &PHY_SwChnl8188E;
-
 	pHalFunc->Add_RateATid = &rtl8188e_Add_RateATid;
 	pHalFunc->run_thread = &rtl8188e_start_thread;
 	pHalFunc->cancel_thread = &rtl8188e_stop_thread;
diff --git a/drivers/staging/r8188eu/include/hal_intf.h b/drivers/staging/r8188eu/include/hal_intf.h
index f3f294aa6a24..eab0b8576c92 100644
--- a/drivers/staging/r8188eu/include/hal_intf.h
+++ b/drivers/staging/r8188eu/include/hal_intf.h
@@ -143,8 +143,6 @@ struct hal_ops {
 	s32	(*init_recv_priv)(struct adapter *padapter);
 	void	(*free_recv_priv)(struct adapter *padapter);
 
-	void	(*set_channel_handler)(struct adapter *padapter, u8 channel);
-
 	void	(*SetHwRegHandler)(struct adapter *padapter, u8	variable,
 				   u8 *val);
 	void	(*GetHwRegHandler)(struct adapter *padapter, u8	variable,
@@ -281,8 +279,6 @@ void	rtw_hal_write_rfreg(struct adapter *padapter,
 			    enum rf_radio_path eRFPath, u32 RegAddr,
 			    u32 BitMask, u32 Data);
 
-void	rtw_hal_set_chan(struct adapter *padapter, u8 channel);
-
 u8	rtw_hal_antdiv_before_linked(struct adapter *padapter);
 void	rtw_hal_antdiv_rssi_compared(struct adapter *padapter,
 				     struct wlan_bssid_ex *dst,
-- 
2.33.0

