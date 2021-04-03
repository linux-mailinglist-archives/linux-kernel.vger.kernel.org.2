Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBBC9353332
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Apr 2021 11:25:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhDCJPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Apr 2021 05:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236133AbhDCJOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Apr 2021 05:14:39 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4174DC061794
        for <linux-kernel@vger.kernel.org>; Sat,  3 Apr 2021 02:14:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id b2-20020a7bc2420000b029010be1081172so3324762wmj.1
        for <linux-kernel@vger.kernel.org>; Sat, 03 Apr 2021 02:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vXCLvI8TEyAmbBcLdMXgq4ObYns8B8WMiEotpUKpaLI=;
        b=WFs50adgpz3dSGcyBQNLIS3Tp0TtFk8wjaDNzMaw4r5iqXOqnWuy2d28G17CYOhXyk
         yDbCyp+5G9jFtrJJN3nG6SAVzDDE9Z4vs+pw4XLXcV71RYOecCJQu0f9Q5flhlZ6b+MD
         ce7JmTw/iwCDyoQpDFUUi0y2xPYMxXbBKtK976vs6WTj09JNcNYRCKjZvkxeY7koXbmd
         8YyZRPoGWXAWEzrq9apFGvZCxcRFTuRj8bAogA72D1KqC7XvjF1bxarKTnX6EeWJ6rGn
         pHbq6Su38ohiHVZM0vuy//lqorK+NuGntH6yj4c9VXHzKIVuJcrI76wiV1taHn0RjI7N
         BgLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vXCLvI8TEyAmbBcLdMXgq4ObYns8B8WMiEotpUKpaLI=;
        b=JMyaBW7nKdZFQpKN6byk88Lui5G3rdjlmV/dxtEFbBoZwxq22pepsHWvytOK5I3PjM
         NzMKXhb2bE2KVkBs/Wayq7dJ09odg/KTrSE+k+8I5GnFknXRkqQBmoicA0Z6lGl4ontF
         XDUp0ZZLgpNdJd5eKpJ/NibgzoGPyMcybR/m1VkGlpGQKWQ3P93G+IvNw+1zqzAFqtqv
         oYnlxpOzAWv7g6ZDS6B8lWsiU3muzISkuU4/rEIEMD81YiiTDcjjq6AEf8ae7thXr/i0
         ZUvtdFGO+lWhIWMEm9/hK27woiwbNojdPgUqm+M4L/t5Y4QkY2DzoM5nhQQtcoYKteO7
         gExg==
X-Gm-Message-State: AOAM531URPNo2O/hLOSWt6EDrgJmno5UcdqPH+s6oRrOmVuvnU/k6cJf
        gD8YCndxh5vVIW9MDqqs8WM=
X-Google-Smtp-Source: ABdhPJzACVpB3QNYZgTGatcLcfz5A8Ffm8zJNdB2Kd/RtyCRxKDE4XOaObIEFLdEvlqZt2WrWLL3DA==
X-Received: by 2002:a05:600c:4b86:: with SMTP id e6mr2320153wmp.78.1617441275004;
        Sat, 03 Apr 2021 02:14:35 -0700 (PDT)
Received: from agape ([5.171.72.64])
        by smtp.gmail.com with ESMTPSA id f2sm15951756wmp.20.2021.04.03.02.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Apr 2021 02:14:34 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     dan.carpenter@oracle.com, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH v3 13/30] staging: rtl8723bs: remove unnecessary parentheses in if condition in core/rtw_cmd.c
Date:   Sat,  3 Apr 2021 11:13:35 +0200
Message-Id: <04aa9d68d6d28d295001dde7cc14f33ef83f8046.1617440834.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617440833.git.fabioaiuto83@gmail.com>
References: <cover.1617440833.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix post-commit hook checkpatch issue:

WARNING: Unnecessary parentheses
166: FILE: drivers/staging/rtl8723bs/core/rtw_cmd.c:2000:
+	if ((pcmd->res != H2C_SUCCESS))

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_cmd.c b/drivers/staging/rtl8723bs/core/rtw_cmd.c
index 840b9da9f2d9..77c583c60343 100644
--- a/drivers/staging/rtl8723bs/core/rtw_cmd.c
+++ b/drivers/staging/rtl8723bs/core/rtw_cmd.c
@@ -1997,7 +1997,7 @@ void rtw_createbss_cmd_callback(struct adapter *padapter, struct cmd_obj *pcmd)
 	if (pcmd->parmbuf == NULL)
 		goto exit;
 
-	if ((pcmd->res != H2C_SUCCESS))
+	if (pcmd->res != H2C_SUCCESS)
 		_set_timer(&pmlmepriv->assoc_timer, 1);
 
 	del_timer_sync(&pmlmepriv->assoc_timer);
-- 
2.20.1

