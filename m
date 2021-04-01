Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1788B35121E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234486AbhDAJXw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234011AbhDAJWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:33 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EACB3C06178A
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:32 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h10so1129127edt.13
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7hdax9p/vB4Qg+0O3qoMDiFgv/iIraqhxfLO0Zus+xg=;
        b=f0YWzc7rXuj6/KUdQvi+2O7rP9cCnmtYfZtTPHRcutrTH/ikhZ9aAJt229i2ciqQhv
         vnp7LuixuvT842+G3sr0rB89GS6o3QzMeAbhbdQr8RXm4R/jWLWqdGG951Z54QeqH/LX
         12J4KIgvmU99tFWnX347QgSS3twbsqqSOaa9DocvLXhSgR6pCZIgKhhJIys3ELTN5FpO
         WXGboBjTlgQ+WAGklXGxmU0/90wTO/RZqnPl/gi62MLIhdjFV5KV3meNh9EWJyQ+R6Uo
         uBBAfU/U4O4HObG/+ZIXpbWmq3Nl593UWlZ68gjj+DJuz/jIaW2EkICjXYDyYQuQysQ8
         yZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7hdax9p/vB4Qg+0O3qoMDiFgv/iIraqhxfLO0Zus+xg=;
        b=XVU3GBzx/pD8vFdEpZmZPNnnzMVF05tWDs++RYZE2T2StYU4P/ZcEdhOpgnxjaPi80
         9dAwSVWxm3/dMmOr58IFTniOcVDb3HIhAHpFmRIo0k6Y4+ivTxUJYfY9N/bSxXbGvnmR
         aQGKf8RL5WSKj4fYBW1w2CizMU2A/+obEPxz22X6oHidEBbU/U5cx0JszdnmUzE2WA9r
         hH41nRG6yXxkH1k8YXrzaamtK6AVwRbVlNP1DQGfnqQ2kVYSd3rL4yHH9Sln3Rn5xpTR
         XXfoRECpo/x4fnHRKTDshymOQp4oSSgnY04em7cr8LTmlftS2RyFtWWLHhw2rPbnlOnF
         145A==
X-Gm-Message-State: AOAM531pw8IGQG/BSGzehLghX442HytTJc8rjqcjhTb8BvC8rjr7Ejz7
        CMxCyg0tJ3Eony1VvAcfnA0=
X-Google-Smtp-Source: ABdhPJxCuZJEaDHmRrFoVqRE+qs3loDCRkh3JKZ+RYAK2aoDsCi8RquicZEOS7b3TqhxCMdhPNu3Kw==
X-Received: by 2002:a05:6402:4244:: with SMTP id g4mr8750615edb.204.1617268951784;
        Thu, 01 Apr 2021 02:22:31 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id 90sm3728691edr.69.2021.04.01.02.22.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:31 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 42/49] staging: rtl8723bs: remove RT_TRACE logs in os_dep/mlme_linux.c
Date:   Thu,  1 Apr 2021 11:21:12 +0200
Message-Id: <dd874e10f5cc8e12ab0fc33462f6e29a7c66d9e9.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove all macro RT_TRACE logs

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/os_dep/mlme_linux.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
index ba4d3789a41e..b46c086233bb 100644
--- a/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/mlme_linux.c
@@ -145,12 +145,8 @@ void rtw_report_sec_ie(struct adapter *adapter, u8 authmode, u8 *sec_ie)
 	u8 *buff, *p, i;
 	union iwreq_data wrqu;
 
-	RT_TRACE(_module_mlme_osdep_c_, _drv_info_, ("+rtw_report_sec_ie, authmode =%d\n", authmode));
-
 	buff = NULL;
 	if (authmode == WLAN_EID_VENDOR_SPECIFIC) {
-		RT_TRACE(_module_mlme_osdep_c_, _drv_info_, ("rtw_report_sec_ie, authmode =%d\n", authmode));
-
 		buff = rtw_zmalloc(IW_CUSTOM_MAX);
 		if (NULL == buff) {
 			DBG_871X(FUNC_ADPT_FMT ": alloc memory FAIL!!\n",
-- 
2.20.1

