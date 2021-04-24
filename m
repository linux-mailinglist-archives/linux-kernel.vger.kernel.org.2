Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE9336A045
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:03:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbhDXJDc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:03:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236954AbhDXJD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:03:26 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99307C06138B
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:48 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id c4so11774981wrt.8
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qFn1Hbee8soeZsKXnx5NCbBSbEoNpVbwk+kQZRDVH5E=;
        b=FDfhxaOyIox29frvuP0Lz0tW4PQQW1fwil53obFXyk5PHCt1mqDhvBL8DUUOY9WGrS
         unrH11mv9Fj3fHhXy+cCN+2Sr4yv0YqllB12GTFVlSGTrSyM/MHso8m2z7f2nUhGvOgp
         fRQVVhpC7E3w/rh3ploWqZvBOuh/PeQE2gvvjyom9ynL0ymGVSaUFpcxPfMpHn6mcGan
         P40nxi7yw7G/7In3A9qnX93KwAIOYzRftJazzbNa7+s8GYuSP47asOEEKlgnREztj0OU
         zrIupiUlm/ZzZlzRI4RxUuDAkzVcflAsrhxajvGDtmm5u4XbNcttiQccT+cG3byftEix
         eZjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qFn1Hbee8soeZsKXnx5NCbBSbEoNpVbwk+kQZRDVH5E=;
        b=Ffa8ltIp+K7SZBqY32mw7rzZuoR0yhW+Zs7nxDh/+etPfVn1D0DEiC3MASwqQWgOu7
         6VdKZbAGgs6JL/TRzUdlC5CS1KQKBhkytjOSGOQvISjSNymd4Dxnu74jW71Cn1oC3D2E
         5ZamJkiMDd5ogqxOWqRmpWQhQzmlq7yLASnKVbRhhEjfa+fo+jczY3PnYoZsnDWB9hxa
         3P/kI2Hi/mj7F8Vlo5eRso3OJN9EonpydvtEaZy3lWCpyI0Q89Dg2vgmksZ8V8omXwRM
         h1Dxnb3BHl8OgxRmbezmU24BAwFGdS4tH7ZiqGoENLR01Xwb+poUrBMrwHFK4Z+Xa5jv
         SEUA==
X-Gm-Message-State: AOAM5306ljWJMIslFwSbqgPNjfODfTWRcTtIrppNIXZ3Dgatvg+vggg/
        bYv/21aqJxhKhopM8AaGK3tMS9DCVL3xFw==
X-Google-Smtp-Source: ABdhPJwUd64AHBh9VWJSuwuaHaG4ha+ch4hJzYS9KtkIGgI7LFr7WJRGEpYv03DR+HwfiVgggBcjyA==
X-Received: by 2002:a5d:60d0:: with SMTP id x16mr10068365wrt.0.1619254967257;
        Sat, 24 Apr 2021 02:02:47 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id w7sm12386254wru.87.2021.04.24.02.02.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:02:47 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/50] staging: rtl8723bs: remove unused bb_reg_dump() function argument
Date:   Sat, 24 Apr 2021 11:01:50 +0200
Message-Id: <62bfb844bc77818ca0595b369e64eca3b8872470.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused function argument void *sel from bb_reg_dump.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c     | 2 +-
 drivers/staging/rtl8723bs/include/rtw_debug.h  | 2 +-
 drivers/staging/rtl8723bs/os_dep/ioctl_linux.c | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index ad3cdbe45e55..9dfa71580b2e 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -36,7 +36,7 @@ void mac_reg_dump(struct adapter *adapter)
 		dump_4_regs(adapter, i);
 }
 
-void bb_reg_dump(void *sel, struct adapter *adapter)
+void bb_reg_dump(struct adapter *adapter)
 {
 	int i;
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index eabc21d2b689..6064de93c24c 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -149,7 +149,7 @@
 #endif /* defined(_dbgdump) */
 
 void mac_reg_dump(struct adapter *adapter);
-void bb_reg_dump(void *sel, struct adapter *adapter);
+void bb_reg_dump(struct adapter *adapter);
 void rf_reg_dump(void *sel, struct adapter *adapter);
 
 #endif	/* __RTW_DEBUG_H__ */
diff --git a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
index 7951c362d664..fa260714b588 100644
--- a/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
+++ b/drivers/staging/rtl8723bs/os_dep/ioctl_linux.c
@@ -2736,7 +2736,7 @@ static int rtw_dbg_port(struct net_device *dev,
 						if (extra_arg == 0)
 							mac_reg_dump(padapter);
 						else if (extra_arg == 1)
-							bb_reg_dump(RTW_DBGDUMP, padapter);
+							bb_reg_dump(padapter);
 						else if (extra_arg == 2)
 							rf_reg_dump(RTW_DBGDUMP, padapter);
 					}
-- 
2.20.1

