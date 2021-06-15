Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCD93A72DA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 02:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231152AbhFOASJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Jun 2021 20:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230376AbhFOASE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jun 2021 20:18:04 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ADF8C0613A4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:49 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 5so2292527qkc.8
        for <linux-kernel@vger.kernel.org>; Mon, 14 Jun 2021 17:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=t6ykaOl2SV5hC/WjmHjpxXukVtJto/xf+MPn+lpAaJ4=;
        b=Vguo5TTsqBmeZHwCReiF8UMlGvaDf1kVs8TIEpxQ868oArLK1FUbH76dbw+1Iw+9ds
         lt13zYwiUg3qSqaA1cyNDr5MuKrS0RGo4dmC50ZHHYwseXuXVo3ZoPVCzgTV86fzNqJQ
         yePA97ou12+n+ycZh6tkJgYFKJ57hxErAkLzY63RoWDgp1rjhSaKDsa6xz3Xs1uMazwx
         jykZBNleCfAnHYtBGcDVoV53bg5U4aIAhcecUN7L+sp5O/A2+xCJJM3Zt8mghwazic0l
         nIhwwAYErJ4XlX0YALwu4EJYLFk4yPOl5Tu3uEc6s9NvjAj6uXbyUovp8MhZzTb8ml2G
         cidg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=t6ykaOl2SV5hC/WjmHjpxXukVtJto/xf+MPn+lpAaJ4=;
        b=bNmlib8hn9TmgizubhLKHeabXLlckEF8kUNBiXfo5oS0ZFq89ys0fMHB7kmNLvwuY3
         1r5kjY16UMiPJVY2qwfKd7Q4A/HMh1V5DQ1qNAjTSYeam91GBTptL31/fZ6p67anKn2P
         gxy90SSbIwF2Lnath/ukC89GSlNQFmIcfr7je+waURSQkrA06MZ9pEQ3ao4LD2KtdHHn
         Dzehuyca9atTCXrsh5S09VGZ7eS7aIJ33LNl0Kq4K6PyNJ2XQ5G2GpSTGzoYEZTZK723
         C0Lzl2KD+vbcE5nUE8V7tiJBLEZwo3oUDWGu195tN3GJfU3NGbrEUzBSa/QNFOevv2pq
         XImw==
X-Gm-Message-State: AOAM5310IPrvhSqzkgprxpoWB1EwjSx+WI957KhAEBd3+DPXgKBbClDw
        ewoCqWMwLP/EjTUeF8m82BqdcA==
X-Google-Smtp-Source: ABdhPJyeIJAJs7B70tsSe63rrzcMZOnnB816pYkffsPASqf1VDXxqbCGe/CiCJoLX4kmd3IDp60y6g==
X-Received: by 2002:a37:4392:: with SMTP id q140mr19287782qka.49.1623716148815;
        Mon, 14 Jun 2021 17:15:48 -0700 (PDT)
Received: from localhost.localdomain (5.d.e.a.c.b.a.1.5.0.9.4.d.7.7.d.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0:d77d:4905:1abc:aed5])
        by smtp.gmail.com with ESMTPSA id m199sm11244248qke.71.2021.06.14.17.15.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 17:15:48 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, dan.carpenter@oracle.com,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH 09/28] staging: rtl8188eu: remove all DBG_88E calls from core/rtw_ioctl_set.c
Date:   Tue, 15 Jun 2021 01:14:48 +0100
Message-Id: <20210615001507.1171-10-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210615001507.1171-1-phil@philpotter.co.uk>
References: <20210615001507.1171-1-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove all DBG_88E calls from core/rtw_ioctl_set.c as this macro is
unnecessary, and many of these calls are dubious in terms of necessity.
Removing all calls will ultimately allow the removal of the macro
itself.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index 76dcaffea0fc..c8b8346adbee 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -143,7 +143,6 @@ u8 rtw_set_802_11_bssid(struct adapter *padapter, u8 *bssid)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	DBG_88E("Set BSSID under fw_state = 0x%08x\n", get_fwstate(pmlmepriv));
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
 		goto handle_tkip_countermeasure;
 	else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
@@ -227,7 +226,6 @@ u8 rtw_set_802_11_ssid(struct adapter *padapter, struct ndis_802_11_ssid *ssid)
 
 	spin_lock_bh(&pmlmepriv->lock);
 
-	DBG_88E("Set SSID under fw_state = 0x%08x\n", get_fwstate(pmlmepriv));
 	if (check_fwstate(pmlmepriv, _FW_UNDER_SURVEY))
 		goto handle_tkip_countermeasure;
 	else if (check_fwstate(pmlmepriv, _FW_UNDER_LINKING))
@@ -328,7 +326,6 @@ u8 rtw_set_802_11_infrastructure_mode(struct adapter *padapter,
 		spin_lock_bh(&pmlmepriv->lock);
 
 		RT_TRACE(_module_rtl871x_ioctl_set_c_, _drv_info_, (" change mode!"));
-		/* DBG_88E("change mode, old_mode =%d, new_mode =%d, fw_state = 0x%x\n", *pold_state, networktype, get_fwstate(pmlmepriv)); */
 
 		if (*pold_state == Ndis802_11APMode) {
 			/* change to other mode from Ndis802_11APMode */
@@ -432,7 +429,6 @@ u8 rtw_set_802_11_bssid_list_scan(struct adapter *padapter, struct ndis_802_11_s
 
 	} else {
 		if (rtw_is_scan_deny(padapter)) {
-			DBG_88E(FUNC_ADPT_FMT": scan deny\n", FUNC_ADPT_ARG(padapter));
 			indicate_wx_scan_complete_event(padapter);
 			return _SUCCESS;
 		}
@@ -595,7 +591,6 @@ int rtw_set_country(struct adapter *adapter, const char *country_code)
 	int i;
 	int channel_plan = RT_CHANNEL_DOMAIN_WORLD_WIDE_5G;
 
-	DBG_88E("%s country_code:%s\n", __func__, country_code);
 	for (i = 0; i < ARRAY_SIZE(channel_table); i++) {
 		if (strcmp(channel_table[i].name, country_code) == 0) {
 			channel_plan = channel_table[i].channel_plan;
@@ -603,8 +598,5 @@ int rtw_set_country(struct adapter *adapter, const char *country_code)
 		}
 	}
 
-	if (i == ARRAY_SIZE(channel_table))
-		DBG_88E("%s unknown country_code:%s\n", __func__, country_code);
-
 	return rtw_set_chplan_cmd(adapter, channel_plan, 1);
 }
-- 
2.30.2

