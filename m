Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC5635FA95
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352900AbhDNSOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352403AbhDNSMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:41 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BB8C061343
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z1so24829480edb.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iNak7t2/n+TkEA5ScWfi9u14bmgi0YzUvL4SB6ShOqk=;
        b=JUEf2JXZhXFWK1RXS/hCZrNNUccxxZ//fO44dbDJFVxY9o0ErZX7Uo7LY8OHXSdklv
         iecZ+9D2JYe1T+n/QDw0kdiZh21+yKFmI8n7LXzwfyZnNOkHJGWVYFJJoKjrKNDwNX+Q
         yXRx/EkCqOGnXGB9CRGjJv5tIu8H0knQTCtHuRjFvtzf8xZZSOkFyH9YU7AswlP0mPWb
         ZSvxJGF7WDRPlkoNe2TaMut4hvyj53wPVLitT6mHcT5pTY8/CAGwqRJrG4lgphZ2awO0
         p/gHMPwsBSKiU2NCG1IbcsKe/WOAYd5QZ+3ud/R29N9ReisAr/90fTzZDuPwXKnQwnpN
         cwZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iNak7t2/n+TkEA5ScWfi9u14bmgi0YzUvL4SB6ShOqk=;
        b=rsVb4ibQVKRr+e/26/XwXGX2yDuLIpV/5j474wefzO3EYjSETHUiPXzSEfc9prFrQg
         VrX5U/4K92uHWoTrhb9fUuLPXKTO8U46VEQapCBPQtqzr2Z1z6UWr/w8ndGipoTv3GHx
         9H8lhYtWOIAi1Qkw4NkAfgTg25bj6yoE5EPZoOpBcON9QMIJeydiXgYNX89UZ2vREK+J
         BsKqTAxJ1RuLJiXOOVqcmsMa4NrtSf/zl6ccqOqTObuLMk2KML/lcNVEPfknd5X/OlYg
         LowGspm4q7FXr6NHVSCwC2Qq+/OshcEF6Teww1za4uzQTIrS7r2IpeqGNTuEQ0uFAzMz
         6l4A==
X-Gm-Message-State: AOAM532KRL05QgK2+kqQCl8d42yi/ncwtyrYYJ//TZSQhgXfIjgTw3v3
        ucQsLCFH/EUKzptWBhFC6E3jl3LNNDQaVQ==
X-Google-Smtp-Source: ABdhPJwE6JC+3zsVayk+aJpMjJ+Xs7MV0cgpI7XuQithc6M4jw3zMkHsBuGwunnYXL4WqJq3IdlrjA==
X-Received: by 2002:a05:6402:350f:: with SMTP id b15mr221007edd.6.1618423933136;
        Wed, 14 Apr 2021 11:12:13 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:12 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 37/57] staging: rtl8188eu: os_dep: ioctl_linux: Move 2 large data buffers into the heap
Date:   Wed, 14 Apr 2021 19:11:09 +0100
Message-Id: <20210414181129.1628598-38-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c: In function ‘translate_scan’:
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c:310:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c: In function ‘rtw_wx_set_mlme’:
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:1128:6: warning: variable ‘reason’ set but not used [-Wunused-but-set-variable]
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c: In function ‘rtw_dbg_port’:
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2548:33: warning: variable ‘preorder_ctrl’ set but not used [-Wunused-but-set-variable]
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:2573:33: warning: variable ‘preorder_ctrl’ set but not used [-Wunused-but-set-variable]
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c:36:27: warning: ‘iw_operation_mode’ defined but not used [-Wunused-const-variable=]

Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8188eu/os_dep/ioctl_linux.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
index c95ae4d6a3b6b..cc14f00947781 100644
--- a/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8188eu/os_dep/ioctl_linux.c
@@ -224,7 +224,7 @@ static char *translate_scan(struct adapter *padapter,
 	/* parsing WPA/WPA2 IE */
 	{
 		u8 *buf;
-		u8 wpa_ie[255], rsn_ie[255];
+		u8 *wpa_ie, *rsn_ie;
 		u16 wpa_len = 0, rsn_len = 0;
 		u8 *p;
 
@@ -232,6 +232,14 @@ static char *translate_scan(struct adapter *padapter,
 		if (!buf)
 			return start;
 
+		wpa_ie = kzalloc(255, GFP_ATOMIC);
+		if (!wpa_ie)
+			return start;
+
+		rsn_ie = kzalloc(255, GFP_ATOMIC);
+		if (!rsn_ie)
+			return start;
+
 		rtw_get_sec_ie(pnetwork->network.ies, pnetwork->network.ie_length, rsn_ie, &rsn_len, wpa_ie, &wpa_len);
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: ssid =%s\n", pnetwork->network.ssid.ssid));
 		RT_TRACE(_module_rtl871x_mlme_c_, _drv_info_, ("rtw_wx_get_scan: wpa_len =%d rsn_len =%d\n", wpa_len, rsn_len));
@@ -268,6 +276,8 @@ static char *translate_scan(struct adapter *padapter,
 			start = iwe_stream_add_point(info, start, stop, &iwe, rsn_ie);
 		}
 		kfree(buf);
+		kfree(wpa_ie);
+		kfree(rsn_ie);
 	}
 
 	{/* parsing WPS IE */
-- 
2.27.0

