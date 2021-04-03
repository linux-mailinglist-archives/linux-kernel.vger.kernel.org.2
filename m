Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2802B353333
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236740AbhDCJPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236628AbhDCJOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB7F1C061797
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id t5-20020a1c77050000b029010e62cea9deso3329439wmi.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aKJMQyibGkbhT7wVDkcAwfnXuo5IWQYiwpzUD+I1No0=;
        b=DrQ35tyuZN5EFPvt1LW+I3CFSklFL26xj20GoWgz4tE7VX0TBF7PGny5Q8MfweyBA+
         q3h5WfEAQ7G1G8n/oZFor2TrhmVd2EAiZJSa446cj9x9bRf7PjbtSWtKhMIO16smAAaZ
         VK3Fi5qC75a00FHx4gg+gva/pX7Qmoooc3vvcylxZIXoBJo8WKk+E0F8BodkBR8BoCVu
         QISrc5jXcZaUIxZDNb1j6xlfamqz3abtl9QV5/YeljBuqkdXanmDTqnWT/5Uma83ypjg
         6cOMXsV9r9tUCEaptSL7AldsQK3rt5jXONPl3rByiTe+P7RW11gV3d8RkJEQWVtIs6vd
         LjQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aKJMQyibGkbhT7wVDkcAwfnXuo5IWQYiwpzUD+I1No0=;
        b=hE7+QyM8mQYRPi3nrtWXsQmJ0P6HU8YrLqldYV8udD0b7EcUdhv6Ym+gxrv4B993Wz
         8E9Qrpm+qu8PbzM3kdiXZt4PmxF2U/smgBgwzlwsqEOUkPWIGgCgzKjM/GOToalqX+lA
         LbDbz8JpJiPB+gpa27DmRwmFF34Herq8QUhue8uqZRe6JnPMyQOKXKKGdE4m0HQ3sJB2
         l8k6ADs2xsTQjDr/5Y5GREwYHerc9i4Usj6mUMGeD5nCRdDvZREes1sUuSbL9raYyyi7
         O54V/CVwPKSduBrhnPgX/pz3Jcq57dj1NzMzPcIEw8NXGM9dzvRrDtYuVwueFVnnB5wL
         0uWQ==
X-Gm-Message-State: AOAM533W+kNhePpAok19E861gNg5K/bgWcKEp5q7GE1viGz3IDL2nKET
        icKP4V/ujuKeA+FqoVlNnec=
X-Google-Smtp-Source: ABdhPJxsUtyzswOdFc/ln4wZpiwKoaPw8VSY/CfLIyay9KtIXtfNFa0r4zHYibgM0S5RhMVMfNREHA==
X-Received: by 2002:a1c:21c3:: with SMTP id h186mr16104071wmh.32.1617441276528;
        Sat, 03 Apr 2021 02:14:36 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id j26sm18294690wrh.57.2021.04.03.02.14.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:36 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 14/30] staging: rtl8723bs: remove commented RT_TRACE calls in core/rtw_mlme.c
Date:   Sat,  3 Apr 2021 11:13:36 +0200
Message-Id: <09862e8783366045a08fd97523595710a08df918.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove commented RT_TRACE calls in core/rtw_mlme.c

Remove all of the RT_TRACE logs in the core/rtw_mlme.c file as they
currently do nothing as they require the code to be modified by
hand in order to be turned on. This obviously has not happened
since the code was merged. Moreover it relies on an unneeded
private log level tracing which overrides the in-kernel public one,
so just remove them as they are unused.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 29d4b7493784..4289bf40aa73 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -356,7 +356,6 @@ static struct	wlan_network *rtw_dequeue_network(struct __queue *queue)
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork);
 void rtw_free_network_nolock(struct adapter *padapter, struct wlan_network *pnetwork)
 {
-	/* RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("rtw_free_network ==> ssid = %s\n\n" , pnetwork->network.Ssid.Ssid)); */
 	_rtw_free_network_nolock(&(padapter->mlmepriv), pnetwork);
 	rtw_cfg80211_unlink_bss(padapter, pnetwork);
 }
@@ -393,8 +392,6 @@ int rtw_is_same_ibss(struct adapter *adapter, struct wlan_network *pnetwork)
 
 inline int is_same_ess(struct wlan_bssid_ex *a, struct wlan_bssid_ex *b)
 {
-	/* RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_, ("(%s,%d)(%s,%d)\n", */
-	/* 		a->Ssid.Ssid, a->Ssid.SsidLength, b->Ssid.Ssid, b->Ssid.SsidLength)); */
 	return (a->Ssid.SsidLength == b->Ssid.SsidLength)
 		&&  !memcmp(a->Ssid.Ssid, b->Ssid.Ssid, a->Ssid.SsidLength);
 }
@@ -551,8 +548,6 @@ static void update_current_network(struct adapter *adapter, struct wlan_bssid_ex
 		&(pmlmepriv->cur_network.network));
 
 	if ((check_fwstate(pmlmepriv, _FW_LINKED) == true) && (is_same_network(&(pmlmepriv->cur_network.network), pnetwork, 0))) {
-		/* RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,"Same Network\n"); */
-
 		/* if (pmlmepriv->cur_network.network.IELength<= pnetwork->IELength) */
 		{
 			update_network(&(pmlmepriv->cur_network.network), pnetwork, adapter, true);
@@ -778,7 +773,6 @@ void rtw_survey_event_callback(struct adapter	*adapter, u8 *pbuf)
 
 	/*  update IBSS_network 's timestamp */
 	if ((check_fwstate(pmlmepriv, WIFI_ADHOC_MASTER_STATE)) == true) {
-		/* RT_TRACE(_module_rtl871x_mlme_c_, _drv_err_,"rtw_survey_event_callback : WIFI_ADHOC_MASTER_STATE\n\n"); */
 		if (!memcmp(&(pmlmepriv->cur_network.network.MacAddress), pnetwork->MacAddress, ETH_ALEN)) {
 			struct wlan_network *ibss_wlan = NULL;
 
-- 
2.20.1

