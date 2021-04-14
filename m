Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452E135FA70
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352307AbhDNSMZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234434AbhDNSMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4899FC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:44 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id mh2so11252315ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QMJML+82xR+GJjag/s3bkG8ynndxU0FxEKtd3aOCd3E=;
        b=lSsY4A2MH4pdoclSpVKQ/156/UAqetGRQPFcErQvViKegAm4VdoYEo9blYFb9G/ikx
         6sem5KOcOQZnGp1Fw0PgyykozRrOyHmdewmNtmpsX+qKN6Fe/LPl9Kd5j7vynLSq+16X
         8in1H7lsrU2u9xWTpw2VLH3ZGya7N4Pj8zKqblLSAQtMxDsd59PIXbtGHSLkSDVywJgC
         h+bmwE9gGPXMefsokerloL3fAas5KOPwA2+fmHhsSnyZ+eVVrDeRkUX268AQH5ArAgos
         xG02fuOMiKGL+/67w+XSumdbNzBONEBVP+m5EvWrUaGIv8ybTJz4Ov5ue81GD6FbXO6Z
         R5fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QMJML+82xR+GJjag/s3bkG8ynndxU0FxEKtd3aOCd3E=;
        b=PeBjmSnpWPbXt92J3ZlRahjIxQVUFP8iVr4fVGielNUap41f9yfJcqozuBaSn8FiZg
         FWXnv7BwkixRsmafrjfGIHu2rXolOB3n3BJysZG1DedqmeIgJ6KwMbciAHP77Pch/YXg
         kQBl36xMq35FaVHjzCwr9M7oG0Es11MoHG7Yi43/w2aUmxRGXCQg7k9s6xwnwfzMGBqe
         l3bpvjQaWSaSc5EZ26aOWjvYJnRFUG8/eEQLk8cmI0uVfYTgrvqpNZDyEyPylgWn4av7
         fyjZ+gkWz4/X5S9IR8WcCZWfd6wunprRizmCB1lyMuEsqdzekwp4boywOdkR8wklJFCi
         jiVA==
X-Gm-Message-State: AOAM533IRePdiYktCAF4rIFCtN4gHVXif94LdEtGRW2sWSlBH1EScejW
        zjny+Zz5+MH9klR17AjCAXfmIg==
X-Google-Smtp-Source: ABdhPJxQmvqiTvSCiERWkFe+9qBQ7DhMjV1gxqEeVN8RVWaxj6blE0Nw11hSz3z3hThqq85LxoEmsQ==
X-Received: by 2002:a17:906:86cd:: with SMTP id j13mr119879ejy.423.1618423903070;
        Wed, 14 Apr 2021 11:11:43 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:11:42 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 08/57] staging: rtw_ioctl_set: Move 'channel_table' to the only place it's used
Date:   Wed, 14 Apr 2021 19:10:40 +0100
Message-Id: <20210414181129.1628598-9-lee.jones@linaro.org>
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

 In file included from drivers/staging/rtl8188eu/include/drv_types.h:41,
 from drivers/staging/rtl8188eu/core/rtw_ap.c:12:
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h:177:3: warning: ‘channel_table’ defined but not used [-Wunused-const-variable=]
 In file included from drivers/staging/rtl8188eu/include/drv_types.h:41,
 from drivers/staging/rtl8188eu/core/rtw_cmd.c:10:
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h:177:3: warning: ‘channel_table’ defined but not used [-Wunused-const-variable=]
 In file included from drivers/staging/rtl8188eu/include/drv_types.h:41,
 from drivers/staging/rtl8188eu/include/rtw_debug.h:11,
 from drivers/staging/rtl8188eu/core/rtw_debug.c:9:
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h:177:3: warning: ‘channel_table’ defined but not used [-Wunused-const-variable=]
 In file included from drivers/staging/rtl8188eu/include/drv_types.h:41,
 from drivers/staging/rtl8188eu/core/rtw_efuse.c:10:
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h:177:3: warning: ‘channel_table’ defined but not used [-Wunused-const-variable=]
 In file included from drivers/staging/rtl8188eu/include/drv_types.h:41,

Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8188eu/core/rtw_ioctl_set.c   | 8 ++++++++
 drivers/staging/rtl8188eu/include/rtw_mlme_ext.h | 8 --------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
index 1ef32ff900a98..c569001f6b839 100644
--- a/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
+++ b/drivers/staging/rtl8188eu/core/rtw_ioctl_set.c
@@ -13,6 +13,14 @@
 
 extern void indicate_wx_scan_complete_event(struct adapter *padapter);
 
+static const struct {
+	int channel_plan;
+	char *name;
+} channel_table[] = { { RT_CHANNEL_DOMAIN_FCC, "US" },
+	{ RT_CHANNEL_DOMAIN_ETSI, "EU" },
+	{ RT_CHANNEL_DOMAIN_MKK, "JP" },
+	{ RT_CHANNEL_DOMAIN_CHINA, "CN"} };
+
 u8 rtw_do_join(struct adapter *padapter)
 {
 	struct list_head *plist, *phead;
diff --git a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
index 77eb5e3ef172b..03d55eb7dc16b 100644
--- a/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
+++ b/drivers/staging/rtl8188eu/include/rtw_mlme_ext.h
@@ -171,14 +171,6 @@ struct rt_channel_plan_map {
 	unsigned char	Index2G;
 };
 
-static const struct {
-	int channel_plan;
-	char *name;
-} channel_table[] = { { RT_CHANNEL_DOMAIN_FCC, "US" },
-	{ RT_CHANNEL_DOMAIN_ETSI, "EU" },
-	{ RT_CHANNEL_DOMAIN_MKK, "JP" },
-	{ RT_CHANNEL_DOMAIN_CHINA, "CN"} };
-
 enum Associated_AP {
 	atherosAP	= 0,
 	broadcomAP	= 1,
-- 
2.27.0

