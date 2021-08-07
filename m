Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E16C3E347C
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Aug 2021 11:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbhHGJte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Aug 2021 05:49:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231928AbhHGJsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Aug 2021 05:48:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FC6C0613D3
        for <linux-kernel@vger.kernel.org>; Sat,  7 Aug 2021 02:48:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h14so14290420wrx.10
        for <linux-kernel@vger.kernel.org>; Sat, 07 Aug 2021 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=i4txUbUiM72tg9+taxP8c210NgRR0U+ErnpmNqbMHEI=;
        b=iEPWkQ/dnS265W7fBT/TEgqIIRyyMIliV/GBBFJWxkM6ogZnTVA7OptaFtIoBQutWL
         VkugHFefYY8AzTppMkuc8QQmdhiPIBJyF87UM0FfnpZBVNWR/jnPRimt133kcXw+Y5nu
         q1Ry6oJc0ZjBqk2fqreB6zjmztiRDR4PC4ARnr29nLoMzR1qDDw9XxhQcVhcFxb8lADX
         2cEQfo/pAfK0ZQEH4573FBkg+S6DT6YonAJlI1HE28UPPQSsj+CxWeXrX80JVJiWFTUd
         VRSkUZEMWt7kdRGmdxgaaXI3GopgZMc3LXHDOsudevwxoAjBEIFAPzRY8xcPKL0qce6i
         +FLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=i4txUbUiM72tg9+taxP8c210NgRR0U+ErnpmNqbMHEI=;
        b=EeAmRAXwvW+BXJqSXrMo0fq4mxaMgG2/rkUVDPgFl9qhld4eeF2F/bo2heatUndMzM
         PnmcRZ5MjkBiYfCgOHTd/f39pGhl6bSUdmyZpveujqSJYXIIgDOubqTSJXxBk1jD/vNT
         lkwctMdorr6X2IWitH/IFIZQQhef6lgtO55TygM3nw5DuEriN1/Ag0vS/LsEsg1yVUyz
         sEcfA3r25fFuXnqH8zAXiaLgTNvQw5eFfMNZ/Vlybhq/8wGY/SfSXX/q8PjFu2fS6uMz
         tW0zoCE8HoYCAPvUAO4aFphiSpmTF95uArG4sqG7YeaSdjU351seh4yhP1BUb3NR5p68
         qY8w==
X-Gm-Message-State: AOAM531IoF1ifPGkXZM/EmIx4Qk9ZE7ZjciaauKHkU9CM9r5WIqyOjMD
        uO55xqPNmOe0noJkHxl0QZhAPVrrBdo=
X-Google-Smtp-Source: ABdhPJyhei1pjYm7I3WMqJNUc7CB23dSmOuCDVOnXcKnm3Yp4eGbtn7LNHQb956N3JyRESoBBrgI2A==
X-Received: by 2002:adf:f112:: with SMTP id r18mr14538107wro.160.1628329716716;
        Sat, 07 Aug 2021 02:48:36 -0700 (PDT)
Received: from agape ([5.171.80.112])
        by smtp.gmail.com with ESMTPSA id c190sm11252174wma.21.2021.08.07.02.48.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Aug 2021 02:48:36 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     hdegoede@redhat.com, Larry.Finger@lwfinger.net,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 16/21] staging: rtl8723bs: remove unused rtw_rf_config module param
Date:   Sat,  7 Aug 2021 11:48:08 +0200
Message-Id: <a83eaa9b2350d3d16f5b1dddc40870e0f0a6df06.1628329348.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1628329348.git.fabioaiuto83@gmail.com>
References: <cover.1628329348.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused rtw_rf_config module param and struct field
used to store the param value.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/drv_types.h | 1 -
 drivers/staging/rtl8723bs/os_dep/os_intfs.c   | 4 ----
 2 files changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/drv_types.h b/drivers/staging/rtl8723bs/include/drv_types.h
index d49009c75d2e..580028d28c42 100644
--- a/drivers/staging/rtl8723bs/include/drv_types.h
+++ b/drivers/staging/rtl8723bs/include/drv_types.h
@@ -132,7 +132,6 @@ struct registry_priv {
 
 	u8 lowrate_two_xmit;
 
-	u8 rf_config;
 	u8 low_power;
 
 	u8 wifi_spec;/*  !turbo_mode */
diff --git a/drivers/staging/rtl8723bs/os_dep/os_intfs.c b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
index 128c64e0f0ab..7728eabdfe48 100644
--- a/drivers/staging/rtl8723bs/os_dep/os_intfs.c
+++ b/drivers/staging/rtl8723bs/os_dep/os_intfs.c
@@ -89,8 +89,6 @@ static int rtw_beamform_cap = 0x2;
 
 static int rtw_lowrate_two_xmit = 1;/* Use 2 path Tx to transmit MCS0~7 and legacy mode */
 
-/* int rf_config = RF_1T2R;  1T2R */
-static int rtw_rf_config = RF_MAX_TYPE;  /* auto */
 static int rtw_low_power;
 static int rtw_wifi_spec;
 static int rtw_channel_plan = RT_CHANNEL_DOMAIN_MAX;
@@ -144,7 +142,6 @@ module_param(rtw_ampdu_amsdu, int, 0644);
 
 module_param(rtw_lowrate_two_xmit, int, 0644);
 
-module_param(rtw_rf_config, int, 0644);
 module_param(rtw_power_mgnt, int, 0644);
 module_param(rtw_smart_ps, int, 0644);
 module_param(rtw_low_power, int, 0644);
@@ -249,7 +246,6 @@ static void loadparam(struct adapter *padapter, struct net_device *pnetdev)
 	registry_par->beamform_cap = (u8)rtw_beamform_cap;
 
 	registry_par->lowrate_two_xmit = (u8)rtw_lowrate_two_xmit;
-	registry_par->rf_config = (u8)rtw_rf_config;
 	registry_par->low_power = (u8)rtw_low_power;
 
 
-- 
2.20.1

