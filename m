Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B059A3CC3E9
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jul 2021 16:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234629AbhGQPAg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jul 2021 11:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234425AbhGQPAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jul 2021 11:00:01 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3811C06175F
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:57:04 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id l17-20020a05600c1d11b029021f84fcaf75so9949362wms.1
        for <linux-kernel@vger.kernel.org>; Sat, 17 Jul 2021 07:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xRK7NSI5UgeQ2tu+VHcDHeBzFj/hyQCQmKRmPBf8Kfs=;
        b=MbTWMunJVoMjkyYhtnHcM2TDQ7sRPyr2tD57XNBjilL/kSS0cRRGcPaf1b6npq9Mia
         Ur4BIDDVyYdcb+jAK2RTYv965IvcTETxwhtLVYX7v5NtCSsnvya4ywQnHY5TVBepiSY+
         usd2CreaVL31Kc2ohHYTCGgB3N9MMPkCA35+BDzEvkqPP9/uRbJxX4iqKPfd/VQaqq5x
         rCKsF65kFPzljTfmpiaDPDZoWME6sojIoTd89chJLkwuJc0Is33bv4Ar2RJcMkQQ740V
         e1aS8knN0E/1jEJ/AATk1TVTctG1fGEREnCPEE1M6e7LCqP/+D9prD4OHtOt9+d61DiO
         /JTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xRK7NSI5UgeQ2tu+VHcDHeBzFj/hyQCQmKRmPBf8Kfs=;
        b=oTdLBHEMg1M9xUt5qfKwzLXbXzT8sakv1Ks6TADCif6Y0iKGHQsemiMS/0Chihmw2O
         TGlaZ+U4Lzr8mu8mVPIAO2iK1DXGDFrui1UBQ/h9iL7plh+Kk+R5NSJDz22h5TniQTPW
         kcuKxn1zogJtOk022+wh9WbnizfJB+h3UGrNPPdNy+QcA8AbqgEou79TDGlJW2DT2jUj
         VDIRzleU2wW7FcZf1DS6XYpY+fwPppfZUifJV+c5FbdcXSi6pPm4LCyMj/5qrFYpddbm
         UeGeUOCZ6jJqsCUQeNw7fGRki7BZm660xhU/8EXYZGoKJnWvDtcGlEnrukGcGtXZ0JVp
         TA3Q==
X-Gm-Message-State: AOAM533D2iXld89vgVDuqFIiri72S6nD/K2pP6XuN9PbJ1aoI8Htxbbl
        v7EaMm3kwkEPth1z40wlgU3elxiwEWs=
X-Google-Smtp-Source: ABdhPJwe1L03lXK9t/ykUyykJavtp8asfCN8VmhKNOOuUjaBbquq0MfTVSQcRlHe4yzKntINYT+stQ==
X-Received: by 2002:a7b:c181:: with SMTP id y1mr22998036wmi.106.1626533823324;
        Sat, 17 Jul 2021 07:57:03 -0700 (PDT)
Received: from agape ([5.171.72.101])
        by smtp.gmail.com with ESMTPSA id w8sm2598776wrk.10.2021.07.17.07.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jul 2021 07:57:03 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, hdegoede@redhat.com,
        Larry.Finger@lwfinger.net, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/10] staging: rtl8723bs: fix post-commit camel case issues
Date:   Sat, 17 Jul 2021 16:56:48 +0200
Message-Id: <6fd6d3266b5119330e15006ae610cb49b767bc59.1626533647.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1626533647.git.fabioaiuto83@gmail.com>
References: <cover.1626533647.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following post-commit camel case issues:

CHECK: Avoid CamelCase: <Adapter>
33: FILE: drivers/staging/rtl8723bs/hal/hal_com.c:152:
+		if (is_supported_24g(Adapter->
	registrypriv.wireless_mode) == false)

CHECK: Avoid CamelCase: <NetType>
46: FILE: drivers/staging/rtl8723bs/include/ieee80211.h:159:
+#define is_supported_24g(NetType)
	((NetType) & SUPPORTED_24G_NETTYPE_MSK ? true : false)

CHECK: Avoid CamelCase: <IsEnableHWCCK>
49: FILE: drivers/staging/rtl8723bs/include/ieee80211.h:161:
+#define IsEnableHWCCK(NetType)
	is_supported_24g(NetType)

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_com.c       | 4 ++--
 drivers/staging/rtl8723bs/include/ieee80211.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_com.c b/drivers/staging/rtl8723bs/hal/hal_com.c
index d18537fde4ed..4a112989899a 100644
--- a/drivers/staging/rtl8723bs/hal/hal_com.c
+++ b/drivers/staging/rtl8723bs/hal/hal_com.c
@@ -144,12 +144,12 @@ u8 hal_com_config_channel_plan(
 	return chnlPlan;
 }
 
-bool HAL_IsLegalChannel(struct adapter *Adapter, u32 Channel)
+bool HAL_IsLegalChannel(struct adapter *adapter, u32 Channel)
 {
 	bool bLegalChannel = true;
 
 	if ((Channel <= 14) && (Channel >= 1)) {
-		if (is_supported_24g(Adapter->registrypriv.wireless_mode) == false)
+		if (is_supported_24g(adapter->registrypriv.wireless_mode) == false)
 			bLegalChannel = false;
 	} else {
 		bLegalChannel = false;
diff --git a/drivers/staging/rtl8723bs/include/ieee80211.h b/drivers/staging/rtl8723bs/include/ieee80211.h
index 2fa6ced333a0..f29b7a92d9ac 100644
--- a/drivers/staging/rtl8723bs/include/ieee80211.h
+++ b/drivers/staging/rtl8723bs/include/ieee80211.h
@@ -156,9 +156,9 @@ enum network_type {
 
 #define is_legacy_only(net_type)  ((net_type) == ((net_type) & (WIRELESS_11BG)))
 
-#define is_supported_24g(NetType) ((NetType) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
+#define is_supported_24g(net_type) ((net_type) & SUPPORTED_24G_NETTYPE_MSK ? true : false)
 
-#define IsEnableHWCCK(NetType) is_supported_24g(NetType)
+#define IsEnableHWCCK(net_type) is_supported_24g(net_type)
 #define IsEnableHWOFDM(NetType) (((NetType) & (WIRELESS_11G|WIRELESS_11_24N)) ? true : false)
 
 #define IsSupportedRxCCK(NetType) IsEnableHWCCK(NetType)
-- 
2.20.1

