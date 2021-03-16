Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA9533D779
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Mar 2021 16:31:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236998AbhCPPbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Mar 2021 11:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236777AbhCPPar (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Mar 2021 11:30:47 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CC51C06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:30:47 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id g8so10344769wmd.4
        for <linux-kernel@vger.kernel.org>; Tue, 16 Mar 2021 08:30:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vuIwBRbiam1ooCxdpqGgCQL+gzZRk+zauspKrWZZM/U=;
        b=kne1wwX6KHZRnoiTuOuyDuIoNiX0l8vApMYayO26ZrcQ84F5QRw94ZsHlEKrmIcNmv
         ujDUT0fY7Jjs1zPPVtmLKawQfIVMQs9EhvGWM1dHcnoI2xTTdDm8uYxukVFvH1iaIPdt
         ggTtcImawgTEnxYJ28sCG+Vvv4a/RQ6g7aLx9FKBsD9v+jsyfdtfBijesGg4K57oiDdq
         aWYNa+wcLYXgFprnzTInfuMlg9pXTaisrDfQmFMEzeSgKPIRpDjhEsoBV9YEusXrlRkL
         WQs5JzwBtUdYDiCCQLkzNEndXv0co52/Y6bSVliOqqXse1EI2GdKcmP7Mf6hi0ObyxJ4
         wXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vuIwBRbiam1ooCxdpqGgCQL+gzZRk+zauspKrWZZM/U=;
        b=c3MMehRUTLBCJZucmkbVkOK2nZFej+4g3+OeXR7y6kcNUG98KN+PzqjQ91fk2q+hFY
         wIbPwjiNHeGxZrl79KuNGriy45LALLnBvCnkHZ5BrqJpZlWqA17L/++ErMbpeOqXMGUA
         r4QvE0ORQvTS3T/S2sajJI9ayMeH1+W8YuGmyGv/R3oLJaPZtAsVM2Mc8g9AlkYUgw8D
         GXdEIKBya4betEb55hzk8kGm/1Z6dugO3WulEmTHWUuiF44MN13ygu6izWglFABjFso4
         VYtu1hFTKgijxQ+Gir0J8w2S+crYWhHIq4aEJoi6NFKSwdYqdb8xGWKm6SsPPfy14G8e
         0UFQ==
X-Gm-Message-State: AOAM531qHPM8UWXhyOuyjGwokfLfHQ35yagp2DVdUMm8ygHsNP6GZQLs
        QFgRo7wL+2Fuyk9+P/fZ0ICC3sAznRg=
X-Google-Smtp-Source: ABdhPJzHPSl0JEBDNALcOhjBqFMirDVVdBI/FzU8nHpMdRn1v+hT08VJcxW69frrDAePfgVfRTGtQA==
X-Received: by 2002:a05:600c:4146:: with SMTP id h6mr246820wmm.32.1615908646175;
        Tue, 16 Mar 2021 08:30:46 -0700 (PDT)
Received: from agape.jhs ([5.171.72.71])
        by smtp.gmail.com with ESMTPSA id z3sm22721689wrw.96.2021.03.16.08.30.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:30:45 -0700 (PDT)
Date:   Tue, 16 Mar 2021 16:30:43 +0100
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/12] staging: rtl8723bs: remove unused code blocks
 conditioned by never set CONFIG_DISABLE_MCS13TO15
Message-ID: <54e5805534f920d8c443874b759560a6127c8db8.1615907632.git.fabioaiuto83@gmail.com>
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
CONFIG_DISABLE_MCS13TO15

cleaning required in TODO file:

find and remove code blocks guarded by never set CONFIG_FOO defines

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c      | 16 +---------------
 drivers/staging/rtl8723bs/core/rtw_wlan_util.c |  7 -------
 2 files changed, 1 insertion(+), 22 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 725f699abda9..a9e5c27a42f7 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2679,14 +2679,7 @@ unsigned int rtw_restructure_ht_ie(struct adapter *padapter, u8 *in_ie, u8 *out_
 		if (stbc_rx_enable)
 			ht_capie.cap_info |= cpu_to_le16(IEEE80211_HT_CAP_RX_STBC_2R);/* RX STBC two spatial stream */
 
-		#ifdef CONFIG_DISABLE_MCS13TO15
-		if (((cbw40_enable == 1) && (operation_bw == CHANNEL_WIDTH_40)) && (pregistrypriv->wifi_spec != 1))
-				set_mcs_rate_by_mask(ht_capie.mcs.rx_mask, MCS_RATE_2R_13TO15_OFF);
-		else
-				set_mcs_rate_by_mask(ht_capie.mcs.rx_mask, MCS_RATE_2R);
-		#else /* CONFIG_DISABLE_MCS13TO15 */
-			set_mcs_rate_by_mask(ht_capie.mcs.rx_mask, MCS_RATE_2R);
-		#endif /* CONFIG_DISABLE_MCS13TO15 */
+		set_mcs_rate_by_mask(ht_capie.mcs.rx_mask, MCS_RATE_2R);
 		break;
 	}
 
@@ -2809,14 +2802,7 @@ void rtw_update_ht_cap(struct adapter *padapter, u8 *pie, uint ie_len, u8 channe
 			break;
 		case RF_2T2R:
 		default:
-#ifdef CONFIG_DISABLE_MCS13TO15
-			if (pmlmeext->cur_bwmode == CHANNEL_WIDTH_40 && pregistrypriv->wifi_spec != 1)
-				set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_2R_13TO15_OFF);
-			else
-				set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_2R);
-#else /* CONFIG_DISABLE_MCS13TO15 */
 			set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_2R);
-#endif /* CONFIG_DISABLE_MCS13TO15 */
 		}
 
 		/* switch to the 40M Hz mode according to the AP */
diff --git a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
index 3e211780cde4..2dd902b04509 100644
--- a/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
+++ b/drivers/staging/rtl8723bs/core/rtw_wlan_util.c
@@ -1071,14 +1071,7 @@ void HT_caps_handler(struct adapter *padapter, struct ndis_80211_var_ie *pIE)
 		break;
 	case RF_2T2R:
 	default:
-#ifdef CONFIG_DISABLE_MCS13TO15
-		if (pmlmeext->cur_bwmode == CHANNEL_WIDTH_40 && pregistrypriv->wifi_spec != 1)
-			set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_2R_13TO15_OFF);
-		else
-			set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_2R);
-#else /* CONFIG_DISABLE_MCS13TO15 */
 		set_mcs_rate_by_mask(pmlmeinfo->HT_caps.u.HT_cap_element.MCS_rate, MCS_RATE_2R);
-#endif /* CONFIG_DISABLE_MCS13TO15 */
 	}
 
 	if (check_fwstate(pmlmepriv, WIFI_AP_STATE)) {
-- 
2.20.1

