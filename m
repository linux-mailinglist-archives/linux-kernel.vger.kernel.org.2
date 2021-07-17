Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FBE3CC3EA
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:58:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234705AbhGQPAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234423AbhGQPAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:00:01 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75AC0C061762
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:57:03 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l6so7569424wmq.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0zn5WjZjwzNr5arL/+ZIp0qYLVTWTo+XAzdShzhK7/Q=;
        b=WkVkvZ4nRhAanPCqnNgszlWRHIocaHadvhZYDlpG6VH1tj+EgfvSn00zMo4XXmMcFT
         4y4V69xYYEw9JiQgbrvjMHQ3mbcCYU92jFwtFqO/RcNsddpJfZp3poi+fWT5GfMkGoFB
         +x6TvmV2JTGsIJjPZwHqvvZeqJ57yKK3uAcKds/l9+GpoxaKUhyMzdKa42dEk61UjRoT
         Kr9rfZ0YnzskuzXXp+JuYDYQyLZLSR819WbalkjHxSt9gwNQyNdOv+jjn2p5x1qtKHlm
         K+4MBDEJuTSZvhXpD/wL78extpkP7OWizdQ2KijDowfEjQwEfcQ/yabsMquxME1cluOB
         W1nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0zn5WjZjwzNr5arL/+ZIp0qYLVTWTo+XAzdShzhK7/Q=;
        b=Xv142O/Neup7d2YW3PPJoZo9nmM/iVr6hJeJzgOe398VgPJHN4uF8DqRdRllhJAbB4
         Bpa5gPDHG/CWTMPlks8rBOglswwVOWyQYR/3hqosmws+Bw/OlOJJ5jmAL2i/uk+7HPBe
         9re0IE5mqCLvzW/48J9PIe83z3W0JXlJSqz29bSgL8ICiFxLN4X3ffz3yZG1jnhkraLE
         PcOddkBJmHOmAZug9xSPnQYdnpkDJ6teJTcs3H+//p+2km15d/sLo30EikeICV/LSUBI
         x2XfKsi7pL7Qn8uSAsbeL2xBMmSmClsW98omKV6ECOo9EJwz5KLMqVSXRYQD+4OqQEZI
         I6qQ==
X-Gm-Message-State: AOAM531V1n29KvDbIuvAnZkxV1lGML247NGki8hG41jMMIRgu2GDDQO0
        /LQAOnM27TC3em97SQgk/HlkdA5NycY=
X-Google-Smtp-Source: ABdhPJxNh9iHPMjZxkRbnOE6yyUIXLgs9SVuUf9OqqT7/0/2SF/ywY7t95l2zArpHVaN8B7lDICIPA==
X-Received: by 2002:a7b:c7cb:: with SMTP id z11mr22814393wmk.102.1626533821964;
        Sat, 17 Jul 2021 07:57:01 -0700 (PDT)
Received: from agape ([5.171.72.101])
        by smtp.gmail.com with ESMTPSA id m15sm11430161wmc.20.2021.07.17.07.57.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 07:57:01 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 06/10] staging: rtl8723bs: fix camel case name in macro IsSupported24G
Date:   Sat, 17 Jul 2021 16:56:47 +0200
Message-Id: <fd5e1873f72e7d5f72b6f4bf801ede882e9df4e2.1626533647.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626533647.git.fabioaiuto83@gmail.com>
References: <cover.1626533647.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix camel case name in macro IsSupported24G

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme_ext.c | 2 +-
 drivers/staging/rtl8723bs/hal/hal_com.c       | 2 +-
 drivers/staging/rtl8723bs/include/ieee80211.h | 4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
index c128d462c6c7..af7d133bce94 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme_ext.c
@@ -343,7 +343,7 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c
 	if (ChannelPlan >= RT_CHANNEL_DOMAIN_MAX && ChannelPlan != RT_CHANNEL_DOMAIN_REALTEK_DEFINE)
 		return chanset_size;
 
-	if (IsSupported24G(padapter->registrypriv.wireless_mode)) {
+	if (is_supported_24g(padapter->registrypriv.wireless_mode)) {
 		b2_4GBand = true;
 		if (RT_CHANNEL_DOMAIN_REALTEK_DEFINE == ChannelPlan)
 			Index2G = RTW_CHANNEL_PLAN_MAP_REALTEK_DEFINE.Index2G;
diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index eebd48438733..d18537fde4ed 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -149,7 +149,7 @@ bool HAL_IsLegalChannel(struct adapter *Adapter, u32 Channel)
 	bool bLegalChannel = true;
 
 	if ((Channel <= 14) && (Channel >= 1)) {
-		if (IsSupported24G(Adapter->registrypriv.wireless_mode) == false)
+		if (is_supported_24g(Adapter->registrypriv.wireless_mode) == false)
 			bLegalChannel = false;
 	} else {
 		bLegalChannel = false;
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 343d077d9c76..2fa6ced333a0 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -156,9 +156,9 @@ enum network_type {
 
 #define is_legacy_only(net_type)  ((net_type) == ((net_type) & (WIRELESS_11BG)))
 
-#define IsSupported24G(NetType) ((NetType) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
+#define is_supported_24g(NetType) ((NetType) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
 
-#define IsEnableHWCCK(NetType) IsSupported24G(NetType)
+#define IsEnableHWCCK(NetType) is_supported_24g(NetType)
 #define IsEnableHWOFDM(NetType) (((NetType) & (WIRELESS_11G|WIRELESS_11_24N)) ? true : false)
 
 #define IsSupportedRxCCK(NetType) IsEnableHWCCK(NetType)
-- 
2.20.1

