Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F86233D774
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236944AbhCPPao (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236925AbhCPPaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:30:25 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A410BC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:30:23 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id y16so10711482wrw.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=8Dp/YU7BjP7tuvO83iJhuaJJVbiqvNcU3OcxU2f06ms=;
        b=rKVhkwohaMSU3XoibbktudpzsJydYpm1Y/8dn31BNjp94HXr0OCQHKArMfYerOSP2p
         UftA4wD52BcLy6KesQ69JQYu+JtDT0Nt0Nr97ruTS2WgfC8TyqzHkZb7qBwjdzJV5HmT
         5pby4HS0Pdb8T94WyFvycqHXrsnx7XDAppg1PE+RVaRQLRTe1q8x3LCC8CaSFzGm7WYY
         BIMnvyKYB1vwaEfetyV8Hjae1GheKL1gKg6BtbjWENa1FTMoUzrpPH5kErK5hAqj56WX
         xYgG6t10X9WxjzH5KBb7FdKyy+rbR9cllcwe1Z21C3LQR9TP7IhYu6Fe7YhtEeSSXUDZ
         xmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=8Dp/YU7BjP7tuvO83iJhuaJJVbiqvNcU3OcxU2f06ms=;
        b=U0EoA5UnuKVqDeMzARPzawg4M9eEMrs6V2xz3e0xRSJHRDpl56+nh1bXAfK/BgF1MH
         pwiLfabk3Sy5ketTOhPRCWrr0CZ6P4Z+jCq/gYp4I93I3ew5E4SPp51N3EBURPBmqEHd
         5E+MtNdcDWXIrcUatFeCpCNZs8Tlr7lbU4h7bbkh+PfpARKdwFlNEslRNE9fRV90WNDw
         J7nWF5zQYPdGio3BlBJ9LOOPF7gwq9y+oOc+9AKSB4AWb30s449xwJpWwXFAbis52P04
         JjA7nR51LxW/3SaRh7+2Iq9G1enVySgiC4ZjCatCnyt/K2QwdAqRomZFqZj+NzM3TGF8
         r7eA==
X-Gm-Message-State: AOAM531BFuwXm8XBFgVfjloEL/k29VWh3bLlEcox1h2yOEzzmOs0TKu1
        58a3af0/4RBhuc9csf6otPKGHef6Yqk=
X-Google-Smtp-Source: ABdhPJz0PbsHJQqTs7QXhf3BH0KiecR5QtTyhYrhaH+fB4H0yE4v800v9Dl5Bavbr2n9HU8AvN7ceA==
X-Received: by 2002:a5d:534e:: with SMTP id t14mr5494698wrv.202.1615908622424;
        Tue, 16 Mar 2021 08:30:22 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id v2sm333394wmj.1.2021.03.16.08.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:30:22 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:30:19 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/12] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_CMCC_TEST
Message-ID: <c5f84efa3c593a897f0498568a41d8638f7f0f8a.1615907632.git.fabioaiuto83@gmail.com>
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
CONFIG_CMCC_TEST

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 .../staging/rtl8723bs/hal/rtl8723b_hal_init.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index 6f08af686f9d..5904b7f9f134 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -2115,16 +2115,6 @@ static void UpdateHalRAMask8723B(struct adapter *padapter, u32 mac_id, u8 rssi_l
 	rate_bitmap = hal_btcoex_GetRaMask(padapter);
 	mask &= ~rate_bitmap;
 
-#ifdef CONFIG_CMCC_TEST
-	if (pmlmeext->cur_wireless_mode & WIRELESS_11G) {
-		if (mac_id == 0) {
-			DBG_871X("CMCC_BT update raid entry, mask = 0x%x\n", mask);
-			mask &= 0xffffff00; /* disable CCK & <24M OFDM rate for 11G mode for CMCC */
-			DBG_871X("CMCC_BT update raid entry, mask = 0x%x\n", mask);
-		}
-	}
-#endif
-
 	if (pHalData->fw_ractrl) {
 		rtl8723b_set_FwMacIdConfig_cmd(padapter, mac_id, psta->raid, psta->bw_mode, shortGIrate, mask);
 	}
@@ -3082,10 +3072,6 @@ static void rtl8723b_fill_default_txdesc(
 				ptxdesc->data_ldpc = 1;
 			if (pattrib->stbc)
 				ptxdesc->data_stbc = 1;
-
-#ifdef CONFIG_CMCC_TEST
-			ptxdesc->data_short = 1; /* use cck short premble */
-#endif
 		} else {
 			/*  EAP data packet and ARP packet. */
 			/*  Use the 1M data rate to send the EAP/ARP packet. */
@@ -3767,11 +3753,6 @@ void SetHwReg8723B(struct adapter *padapter, u8 variable, u8 *val)
 		BrateCfg &= rrsr_2g_allow_mask;
 		masked = BrateCfg;
 
-		#ifdef CONFIG_CMCC_TEST
-		BrateCfg |= (RRSR_11M|RRSR_5_5M|RRSR_1M); /* use 11M to send ACK */
-		BrateCfg |= (RRSR_24M|RRSR_18M|RRSR_12M); /* CMCC_OFDM_ACK 12/18/24M */
-		#endif
-
 		/* IOT consideration */
 		if (mlmext_info->assoc_AP_vendor == HT_IOT_PEER_CISCO) {
 			/* if peer is cisco and didn't use ofdm rate, we enable 6M ack */
-- 
2.20.1

