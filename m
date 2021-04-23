Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0EAD369549
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbhDWO7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242831AbhDWO7b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:31 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F5FC061574
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:54 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so1389482wmi.5
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Bs6Xp2hN7bXYFa4GJsG/iTvQnibSGJwSZFCsbQblVKk=;
        b=ekgaCo9LiIzm0uxkV1wVXN3IlzioPLYt1aCel6oigEhny1bA/wk9+ZGI4L7HQ3GcB5
         CYXhF4pTu58xDOJFIrEeTMDEuE3elvYC4KT0vADyRxBdIqkBBxCXA6nQ9RebvCTBPxDz
         pZMSyvRjKcfzFYfR+n3/c3R/Kbf+FeUBh05H+RmOXgCZcAGLEgCMBwa5p0hx7KHVtIAC
         aPC6a2lMcivTa/uFE+AwbtynmUasNXLoEJ3p/uita3N9f2erazFh04LSumUCrjfVkxMg
         ljze8SCJDQfRJRyxmWzRhrHPwjkyfFeH/+iCZHczcXyH7YVDPbAkcmU4fcNxmn5R/b6k
         4foQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Bs6Xp2hN7bXYFa4GJsG/iTvQnibSGJwSZFCsbQblVKk=;
        b=aKTesPkXVehSXLxFtd1bh2i+8rgUXJxXJLa8wBz/TCGXtEec64uoCm7F7aXkeo0UhV
         9Lcfhwz5g6vkH/O0QaSqCgWRY5SBYD4IzfR5z7fpkmDZBC25vJvtd7Mso74/uK0JlWym
         M4b+j5och3nf0DanprJf9+ASynEqkmeiDMC92te9pKBry1yZWSThqnKpsuHC+/uLddSG
         2pcR6gZ2bWTUftF9e4jILF2zvG/VTp/KAPc33ARx5cOHD3CesagpKfbwcpDyeoM/ltEE
         TKzE1twXTsg1TZIbAhS7B7vxyaFbEgwEojStYyiAS0o+Hb/kTV3H0L1CJnZF30/N6cv+
         r+bg==
X-Gm-Message-State: AOAM532Bgb3cnnylWWUblNF9KxovXXJK00g5RAigD8SJu+1jQbH4KwE9
        X39X5lXbRASCSOYamoy7q7FaAWK/pjY=
X-Google-Smtp-Source: ABdhPJw1uN4o5u1of1ZkiAE2lS6jJZCg7WkV4fM420EZLHC4OmtOj5uxc3Ays77nl/Ix5slZgcZEUg==
X-Received: by 2002:a05:600c:247:: with SMTP id 7mr6050020wmj.111.1619189933390;
        Fri, 23 Apr 2021 07:58:53 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id c16sm9116083wrt.83.2021.04.23.07.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:58:53 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 07/49] staging: rtl8723bs: remove unused rf_reg_dump() function argument
Date:   Fri, 23 Apr 2021 16:57:58 +0200
Message-Id: <a05d90dbdd972b9189e15302059b1629f26d4468.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused function argument void *sel from rf_reg_dump.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c     | 2 +-
 drivers/staging/rtl8723bs/include/rtw_debug.h  | 2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index 154a35b1541f..e6e583446626 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -45,7 +45,7 @@ void bb_reg_dump(struct adapter *adapter)
 	}
 }
 
-void rf_reg_dump(void *sel, struct adapter *adapter)
+void rf_reg_dump(struct adapter *adapter)
 {
 	int i, j = 1, path;
 	u32 value;
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 6064de93c24c..fc187a4ed2c3 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -150,6 +150,6 @@
 
 void mac_reg_dump(struct adapter *adapter);
 void bb_reg_dump(struct adapter *adapter);
-void rf_reg_dump(void *sel, struct adapter *adapter);
+void rf_reg_dump(struct adapter *adapter);
 
 #endif	/* __RTW_DEBUG_H__ */
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index fa260714b588..5912915a7870 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2738,7 +2738,7 @@ static int rtw_dbg_port(struct net_device *dev,
 						else if (extra_arg == 1)
 							bb_reg_dump(padapter);
 						else if (extra_arg == 2)
-							rf_reg_dump(RTW_DBGDUMP, padapter);
+							rf_reg_dump(padapter);
 					}
 					break;
 
-- 
2.20.1

