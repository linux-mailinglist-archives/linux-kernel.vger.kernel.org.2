Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1236435FA93
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 20:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350546AbhDNSOi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 14:14:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352452AbhDNSMl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 14:12:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0EAC061756
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:19 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id e14so32779908ejz.11
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 11:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ou9pFz1yt2cBGVMByHH+2tSi6/Zokuu+I/QCR5zN9V0=;
        b=dUeZaVa9qaRoanrYQIlaeGHzZzfQ0rnSDg9Zmwab1KKCNjEHQ77S/NnU0EN9GLt5PA
         EaiNXYFwg+Yj8sIWSQ7vHztzOY5BxVmwXzcqEap/TsE9rbkxHybnkhSkiRKsy9nMLM5L
         zGc1ZtweyvsW/XJs1XEY8eMenPZv25tvbztcSrtjuzABiXwWt+96zFmUk4YDmXWQFA1N
         JMHiz59tBqUj77fEntNehNuPY31uv01gr60NikVTNQA3/2VHJOHfoaTr2TJ+xiB5Y3kL
         29XolHyIbKiGcPnS/mo90FNfQ0OmFqgCZeFCdvaz5ySKQLBd0du42QUI8wfVobs9NI6Q
         5Q6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ou9pFz1yt2cBGVMByHH+2tSi6/Zokuu+I/QCR5zN9V0=;
        b=fcE0ogaDLctoz4NIgXdOh09AmBQwkd/JhnXWeR8iixui3CP9ghZORnF5vIo1gWrb9E
         wyBxE/YNDjoeD1ZhTA2lCaoCpsoU57j/9Pbpo8G5ooo8fzRBPRxDq81IgBx9Q29gihlm
         4WPMvWyPiMDHbfMsVcXsnWFN1+rlEAGOv4MQtSNRaPSPFziWEPodiUlUgCRRi/2ph8H6
         Tnl4Jlgs6ihYJ172r7yyQxxm18jDt7FSRna+opI/FAkqf71d7yf4mYS5OxgPEVw5UP+P
         FOvyuPTEIYdcEzLCaOCIj4ogK8OtH+4M1Oq7V1UEtnFF6SpPEuWwWHJyxY0SBpX7EZBe
         n9Dw==
X-Gm-Message-State: AOAM53150MDeGlgPf3o8sBwR12+SGcfKB3FKGX41QkObK+2hyAGlzTBx
        /MmjAW5A12QuXMKfjTyugiQcxQ==
X-Google-Smtp-Source: ABdhPJxiKs/E9rYKIqmEb8TLijPjyGAl4oRI9fx4KCXVQZ9/5Prl/L3H0P4Lc1mgOHRjnQUZxvaoiA==
X-Received: by 2002:a17:906:1e8e:: with SMTP id e14mr126983ejj.399.1618423938178;
        Wed, 14 Apr 2021 11:12:18 -0700 (PDT)
Received: from dell.default ([91.110.221.215])
        by smtp.gmail.com with ESMTPSA id v1sm279493eds.17.2021.04.14.11.12.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 11:12:17 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH 42/57] staging: rtl8188eu: os_dep: rtw_android: Demote kernel-doc abuse
Date:   Wed, 14 Apr 2021 19:11:14 +0100
Message-Id: <20210414181129.1628598-43-lee.jones@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210414181129.1628598-1-lee.jones@linaro.org>
References: <20210414181129.1628598-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/staging/rtl8188eu/os_dep/rtw_android.c:56: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst

Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/staging/rtl8188eu/os_dep/rtw_android.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8188eu/os_dep/rtw_android.c b/drivers/staging/rtl8188eu/os_dep/rtw_android.c
index f5763a9d70c58..91c51b5583d27 100644
--- a/drivers/staging/rtl8188eu/os_dep/rtw_android.c
+++ b/drivers/staging/rtl8188eu/os_dep/rtw_android.c
@@ -52,7 +52,7 @@ struct android_wifi_priv_cmd {
 	int total_len;
 };
 
-/**
+/*
  * Local (static) functions and variables
  */
 
-- 
2.27.0

