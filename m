Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13784369546
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:59:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242903AbhDWO7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242814AbhDWO72 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:28 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9761CC06174A
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:51 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id m9so35966921wrx.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vNBjMQOLUQhncE75aINBlrH8zAP/gk/+qkzR/90Pdxs=;
        b=uLmYnd8Y9EC4ltHjNtv5xgl+L5y2HseUsZrqa/6zSy0SJWNYWLT20nQi6enSPS+VAg
         dDJo1z4Z6Bgt7g0v0IzFZouYvD7QsBWmQ4oIn8L/Z9pkXjRz6lieRNOmcglss0a4+lJC
         G3UqD7JhcvA/m9S2HPxERlMI1RHL0a2dBnMH6nKcy6VkULNEwMITXZ9zdyUXmU7WNRgx
         ctuTt28QDkpjIyhGhOyIjukBev2HcdjQ/3mJ1ABWzmNzceAqcCaePwrNNsiJ+dmhLv0p
         ZePKqYwFlh2Iy58hr9DUgyFnWlP2j0+W+G10oSSPqVxdIS1Tv8dRcRyALrELXM5opUSZ
         W14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vNBjMQOLUQhncE75aINBlrH8zAP/gk/+qkzR/90Pdxs=;
        b=oRA68gS+JdohCkQLUIwCAUwkSJE79lJkvT34QftRYYd7HZL85hxkBLabbBk9So3DO2
         UFBNGd6DZAA7PVOxO/YwFavGl2OKPK6hyTWX9Tqj50z7AYbZtUj6E0yfSUEqv3IieMZn
         GlLzslWFKG8UW8BNLtS+aTXRdjKuXa9bMe1hWAIc2T3iRJbp/JT9Krj1xrUzstEOgX37
         B1fgH1nCAl4ZKRFzz62I33lxUXh11eTjx0vBFhu7JWOGa1pRQ9AVl8Ovqp8WiNoWAu1L
         GRpFEnhQ2ZNMGpRwY8qOkBXIarcFCXvPx42T8EDSEb8JKZLocQ/6BCO8bJitEWCpqnei
         d91g==
X-Gm-Message-State: AOAM533V9BAGj4/7aqxPzEwpxExO8uZPNrTb3YPIhEwQ+2wun4Sc/ArE
        DJqbdkMoJaofyk/evEHZ3LrPnYCFQbU=
X-Google-Smtp-Source: ABdhPJyLD+za+u0I/c0ixqStEHmcYT3Doy66ZcQNbU34n7Qj5aAt6BKs4umehciuT1y55cWjXJEDyA==
X-Received: by 2002:adf:d1cc:: with SMTP id b12mr5396260wrd.131.1619189930141;
        Fri, 23 Apr 2021 07:58:50 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id f7sm9713039wrp.48.2021.04.23.07.58.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:58:49 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 05/49] staging: rtl8723bs: remove unused mac_reg_dump() function argument
Date:   Fri, 23 Apr 2021 16:57:56 +0200
Message-Id: <f8327daed6efcf5afbb8e09c58a5a9591aba0b33.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused function argument void *sel from mac_reg_dump.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c     | 2 +-
 drivers/staging/rtl8723bs/include/rtw_debug.h  | 2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index a43fa38cae62..fb12614a2bad 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -14,7 +14,7 @@ u32 GlobalDebugLevel = _drv_err_;
 
 #include <rtw_version.h>
 
-void mac_reg_dump(void *sel, struct adapter *adapter)
+void mac_reg_dump(struct adapter *adapter)
 {
 	int i, j = 1;
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index fdd5933a3d5a..eabc21d2b689 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -148,7 +148,7 @@
 
 #endif /* defined(_dbgdump) */
 
-void mac_reg_dump(void *sel, struct adapter *adapter);
+void mac_reg_dump(struct adapter *adapter);
 void bb_reg_dump(void *sel, struct adapter *adapter);
 void rf_reg_dump(void *sel, struct adapter *adapter);
 
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index e98e5388d5c7..7951c362d664 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2734,7 +2734,7 @@ static int rtw_dbg_port(struct net_device *dev,
 				case 0xdd:/* registers dump , 0 for mac reg, 1 for bb reg, 2 for rf reg */
 					{
 						if (extra_arg == 0)
-							mac_reg_dump(RTW_DBGDUMP, padapter);
+							mac_reg_dump(padapter);
 						else if (extra_arg == 1)
 							bb_reg_dump(RTW_DBGDUMP, padapter);
 						else if (extra_arg == 2)
-- 
2.20.1

