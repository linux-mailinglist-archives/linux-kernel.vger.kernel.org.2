Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650953A2FE0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Jun 2021 17:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhFJPzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 11:55:36 -0400
Received: from mail-qv1-f52.google.com ([209.85.219.52]:35398 "EHLO
        mail-qv1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbhFJPzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 11:55:35 -0400
Received: by mail-qv1-f52.google.com with SMTP id if15so4112727qvb.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 08:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=q71sfuDpSTxt6fvWZzA8RCfU/BngLdxXFJt4It6rlCA=;
        b=i5HkU28Ey4Su/dHHODoPLy4Sgc+xzjtfBXCh3i3RI2bYzRydfGenqCvZ0MlKDM55t9
         ZUe23/wol7VecXZLTRSmYkppH11icZKzBTRjNssGTlez5pz3BdADTCVogciwPW/OOPJz
         GwL8XSN5MDwep6/aN8o0/hiZ19y26sD+cX6q/OccrI5ebnc/PjZbxPfGBv6VDATra/NO
         /30PrXDTFhs+56xDME4nZk8lWClz8MVZTvjjwXaWeCTYM5lH1Kr7fCjAneFtbLMFO3TZ
         H1Y0BCQNuZGnOS8idqC8VoRb8tO7lAh13J/ZNO3gv/rUQ9qpO8PLaVr2rHoFXY20f2MJ
         NKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=q71sfuDpSTxt6fvWZzA8RCfU/BngLdxXFJt4It6rlCA=;
        b=XpebMMiOQXS0ZM5dRJb1dztJq1IzqDXuAYDxNI/QkPHapNMN9nX6nThXb9yqn+3O5U
         2/dIZmIAJHRKP1dRa93plz1W+86razWfyrzOD51pkj43UUJAFIZc9X+RYT02+z+7GRJC
         ZKPpOfu+h3lbuQutFwI93d8cyHqg4jVXPhumPbNPUIXDXRk1dmqQSd01toSkDU7z0qr6
         kRt4ov/6L+sxQIKHcQVoXTfBZzUDI2+sS/DOGu+Nfg+5WGYo1K/5LcfRzErw8eqa7Isx
         IreGO2HzQ3WuxsVl4BjCd0vOLG154k+liSAqXUNcmNvAf0zIBUAlSp6pWkHIeXUoel6F
         m4fg==
X-Gm-Message-State: AOAM531Ty3uukWPS4rd7bhL9dZezrAYYtNG9sInSpQ5zpPYZMQcj15iw
        dtZOu56F6GaLsJrqJ21IJxw=
X-Google-Smtp-Source: ABdhPJyuzPPJ4F7bcLYDiWuzjYBZPTpualxUehhHy8yyykk3/11N9INnjtP/6/zscPSQ24+ZsM7Bug==
X-Received: by 2002:a05:6214:80a:: with SMTP id df10mr317569qvb.8.1623340343855;
        Thu, 10 Jun 2021 08:52:23 -0700 (PDT)
Received: from ubuntu ([191.96.170.82])
        by smtp.gmail.com with ESMTPSA id c26sm2457647qtj.41.2021.06.10.08.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 08:52:23 -0700 (PDT)
From:   Philippe Dixon <philippesdixon@gmail.com>
To:     hdegoede@redhat.com, Larry.Finger@lwfinger.net
Cc:     Philippe Dixon <philippesdixon@gmail.com>,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] staging: rtl8723bs: core: add blank line after variable declaration
Date:   Thu, 10 Jun 2021 08:51:15 -0700
Message-Id: <c5eedc7a5298b05beb576b7b9e108794ca7bb58c.1623339773.git.philippesdixon@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1623339773.git.philippesdixon@gmail.com>
References: <cover.1623339773.git.philippesdixon@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following checkpatch.pl warning:

WARNING: Missing a blank line after declarations

Signed-off-by: Philippe Dixon <philippesdixon@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index f82f8289bf3b..3199386f5850 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -223,6 +223,7 @@ void _rtw_free_evt_priv(struct	evt_priv *pevtpriv)
 
 	while (!rtw_cbuf_empty(pevtpriv->c2h_queue)) {
 		void *c2h = rtw_cbuf_pop(pevtpriv->c2h_queue);
+
 		if (c2h && c2h != (void *)pevtpriv)
 			kfree(c2h);
 	}
@@ -563,6 +564,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	/* prepare ssid list */
 	if (ssid) {
 		int i;
+
 		for (i = 0; i < ssid_num && i < RTW_SSID_SCAN_AMOUNT; i++) {
 			if (ssid[i].SsidLength) {
 				memcpy(&psurveyPara->ssid[i], &ssid[i], sizeof(struct ndis_802_11_ssid));
@@ -574,6 +576,7 @@ u8 rtw_sitesurvey_cmd(struct adapter  *padapter, struct ndis_802_11_ssid *ssid,
 	/* prepare channel list */
 	if (ch) {
 		int i;
+
 		for (i = 0; i < ch_num && i < RTW_CHANNEL_SCAN_AMOUNT; i++) {
 			if (ch[i].hw_value && !(ch[i].flags & RTW_IEEE80211_CHAN_DISABLED)) {
 				memcpy(&psurveyPara->ch[i], &ch[i], sizeof(struct rtw_ieee80211_channel));
-- 
2.25.1

