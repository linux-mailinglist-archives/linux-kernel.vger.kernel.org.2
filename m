Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9030733D778
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236867AbhCPPbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236843AbhCPPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:30:38 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E4AC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:30:37 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so1703958wml.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=dS3wtgYoSrTn+JxDUWBgQjpo1/B60ctev1wnKqso3Hc=;
        b=iuRnhZNzffLP5xnvM1MJy0HH0rYAYdeTj/yoTJC0aE5hk6HXGeEFcVhI2c2g/ZghLU
         Mxh21Ki8NMMO3yyqjI3BLBfp/hJNQ+31lst2+v1EaQ5yo+yPtn5ctqnPLnj+XOBdrW+y
         g6ZjsTVEbxdLhqiy7zWB4fD3UsgJsVRuQFosfKmiGMMwSZiHjX8SOT4tqfmqT6PdxbLG
         mMmgxYyQ3rrgegy2VCzyk44Tky+Xf2k/eq7VeQypGW1vA8Y6RbMNQ0kgi/rtCLMAebin
         I8uSKYxD0CIiMEhVizpzLiTqivUaBbR0qBu4gjgtV/2dwLlLVBuvNovRyc6k3cukwoVF
         xaNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=dS3wtgYoSrTn+JxDUWBgQjpo1/B60ctev1wnKqso3Hc=;
        b=cCl5UkxYGJo8dZh3coK/dYuOdIW5WEpdgLUl0m8Kr49HXuLMz9HCgwRKjwq3cRIatd
         pATOq14QkF58RHLoT2BN7IsUcdx3qZL+YvkBGJBhyk5ovyK/MkEhwzBqeWJ9QfXS2ZGA
         wHe+sZL+860A3r3HUOrqCQvdw0XHFmcASQ1cN75c9dgkisDi4lwLkFo0q4C6qEPLoKtJ
         c4sVjHKtry6Rrw8Baltm/ZFwtSKnjh502LVXzmPwdhVx2znpgzwIXfMMWHocQxbT83Yh
         Xu9ISmGIgi48lOOZzS47xOi8IjVzeuVbkP5u6wqXImgQtGG0bYR+9rZjP9nawztRwU+L
         rgxQ==
X-Gm-Message-State: AOAM5337UZQJtI4uCIz2gXCP+i7BQSyTYSpV0Hl2Q7HPgUfLw03Q+MHd
        WJsAAbeR2nG1uK88n9P8cs8=
X-Google-Smtp-Source: ABdhPJyKIBbf5DZj9ex/pewWUH2vyInifZTgiWV+bzhiLVr62vmJhIZoXoPbBUrAUdQY76+/u7PwsA==
X-Received: by 2002:a7b:cc84:: with SMTP id p4mr241269wma.10.1615908635897;
        Tue, 16 Mar 2021 08:30:35 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id a131sm3395163wmc.48.2021.03.16.08.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:30:35 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:30:33 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 02/12] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_INTERRUPT_BASED_TXBCN*
Message-ID: <9157000821fd6febf25566b8c712fad1995c7c78.1615907632.git.fabioaiuto83@gmail.com>
References: <cover.1615907632.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1615907632.git.fabioaiuto83@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove conditional code blocks checked by unused
CONFIG_INTERRUPT_BASED_TXBCN family defines

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_ap.c       | 30 ++-----------------
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 21 -------------
 2 files changed, 3 insertions(+), 48 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_ap.c b/drivers/staging/rtl8723bs/core/rtw_ap.c
index 63b339484289..74f0f4d5a0b3 100644
--- a/drivers/staging/rtl8723bs/core/rtw_ap.c
+++ b/drivers/staging/rtl8723bs/core/rtw_ap.c
@@ -920,12 +920,10 @@ void start_bss_network(struct adapter *padapter, u8 *pbuf)
 	if (pmlmeext->bstart_bss) {
 		update_beacon(padapter, WLAN_EID_TIM, NULL, true);
 
-#ifndef CONFIG_INTERRUPT_BASED_TXBCN /* other case will  tx beacon when bcn interrupt coming in. */
-		/* issue beacon frame */
-		if (send_beacon(padapter) == _FAIL)
-			DBG_871X("issue_beacon, fail!\n");
+	/* issue beacon frame */
+	if (send_beacon(padapter) == _FAIL)
+		DBG_871X("issue_beacon, fail!\n");
 
-#endif /* CONFIG_INTERRUPT_BASED_TXBCN */
 	}
 
 	/* update bc/mc sta_info */
@@ -1685,26 +1683,6 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	}
 
 	kfree(pbackup_remainder_ie);
-
-	/*  deal with the case without set_tx_beacon_cmd() in update_beacon() */
-#if defined(CONFIG_INTERRUPT_BASED_TXBCN)
-	if ((pmlmeinfo->state & 0x03) == WIFI_FW_AP_STATE) {
-		u8 sr = 0;
-
-		rtw_get_wps_attr_content(
-			pwps_ie_src,
-			wps_ielen,
-			WPS_ATTR_SELECTED_REGISTRAR,
-			(u8 *)(&sr),
-			NULL
-		);
-
-		if (sr) {
-			set_fwstate(pmlmepriv, WIFI_UNDER_WPS);
-			DBG_871X("%s, set WIFI_UNDER_WPS\n", __func__);
-		}
-	}
-#endif
 }
 
 static void update_bcn_p2p_ie(struct adapter *padapter)
@@ -1802,12 +1780,10 @@ void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
 
 	spin_unlock_bh(&pmlmepriv->bcn_update_lock);
 
-#ifndef CONFIG_INTERRUPT_BASED_TXBCN
 	if (tx) {
 		/* send_beacon(padapter);//send_beacon must execute on TSR level */
 		set_tx_beacon_cmd(padapter);
 	}
-#endif /* CONFIG_INTERRUPT_BASED_TXBCN */
 }
 
 /*
diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 5904b7f9f134..2b81be6f1b32 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -3272,17 +3272,6 @@ static void hw_var_set_opmode(struct adapter *padapter, u8 variable, u8 *val)
 		if ((mode == _HW_STATE_STATION_) || (mode == _HW_STATE_NOLINK_)) {
 			{
 				StopTxBeacon(padapter);
-#ifdef CONFIG_INTERRUPT_BASED_TXBCN
-#ifdef CONFIG_INTERRUPT_BASED_TXBCN_EARLY_INT
-				rtw_write8(padapter, REG_DRVERLYINT, 0x05); /*  restore early int time to 5ms */
-				UpdateInterruptMask8812AU(padapter, true, 0, IMR_BCNDMAINT0_8723B);
-#endif /*  CONFIG_INTERRUPT_BASED_TXBCN_EARLY_INT */
-
-#ifdef CONFIG_INTERRUPT_BASED_TXBCN_BCN_OK_ERR
-				UpdateInterruptMask8812AU(padapter, true, 0, (IMR_TXBCN0ERR_8723B|IMR_TXBCN0OK_8723B));
-#endif /*  CONFIG_INTERRUPT_BASED_TXBCN_BCN_OK_ERR */
-
-#endif /*  CONFIG_INTERRUPT_BASED_TXBCN */
 			}
 
 			/*  disable atim wnd */
@@ -3292,16 +3281,6 @@ static void hw_var_set_opmode(struct adapter *padapter, u8 variable, u8 *val)
 			ResumeTxBeacon(padapter);
 			rtw_write8(padapter, REG_BCN_CTRL, DIS_TSF_UDT|EN_BCN_FUNCTION|DIS_BCNQ_SUB);
 		} else if (mode == _HW_STATE_AP_) {
-#ifdef CONFIG_INTERRUPT_BASED_TXBCN
-#ifdef CONFIG_INTERRUPT_BASED_TXBCN_EARLY_INT
-			UpdateInterruptMask8723BU(padapter, true, IMR_BCNDMAINT0_8723B, 0);
-#endif /*  CONFIG_INTERRUPT_BASED_TXBCN_EARLY_INT */
-
-#ifdef CONFIG_INTERRUPT_BASED_TXBCN_BCN_OK_ERR
-			UpdateInterruptMask8723BU(padapter, true, (IMR_TXBCN0ERR_8723B|IMR_TXBCN0OK_8723B), 0);
-#endif /*  CONFIG_INTERRUPT_BASED_TXBCN_BCN_OK_ERR */
-
-#endif /*  CONFIG_INTERRUPT_BASED_TXBCN */
 
 			ResumeTxBeacon(padapter);
 
-- 
2.20.1

