Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870A9369548
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 16:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242928AbhDWO7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 10:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231627AbhDWO7a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:30 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6A2C061756
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y204so24800273wmg.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:58:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BWEtir5T3ad04OpLTA6MNZesSjBqqA6KPqaPnr8Gv18=;
        b=V39PKCQ7+IXtqFEdxbpKNPyzkG+54s/RIdHKCj0vjxjw+hZ47t3HqKCeAD2YxkOxvO
         eJtDVbt9x6dEUWKlob3hs4KSythpgwB+D5W+YHzjr9q4vTAJu2IKuZc5bJGbJpfZ2ahY
         XJQJUaXhjQaB5gK8oSNxxmFYx9yfIH8sG8ZXLnrEwMUvmYJnkl/P0FhjTr6LMfYAIj7a
         qnWQB0/T6rp+ZNHVzukNeQKtJDU6CH4fkh0nFGBktS21xUfqeJZMhrZRaevbGuM3f13d
         2KNiqMvSNg9nIwfj1FGryikpvPxV2WIQYkPbyv/KR4lScHLBUidAeqy2fXjOZoiUi4PV
         YaDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BWEtir5T3ad04OpLTA6MNZesSjBqqA6KPqaPnr8Gv18=;
        b=SyG6vRt1virBEKtJ+3Xqnx2McAsAKl9z69FL/zxpXWOpB7g/oBDHwvou2M9yYkIvZk
         U2u+eAslS0UZB0fi2Yg1f3ZCcrjr/RRG6KpgnAiYHSgAcGjhVXCABaHsvqIV/q9rtG0Q
         rCF+BtaFXw2LUETB0t2NkbvkLrk4uhAVlgKM2Wd09Bz8n5UPWzl1AO7drEvmxCI1qAo/
         uUKmvKOwumhSpmPO0BQyS4d1uJyK5ukNRGgfFMWKimjM2/DearMYUB5NkIN/VKKxnk4+
         CsIBHerHt1EqZAwvg0pBgftb79ZDtvWkguEYb5WgKYT/3gUQ0U9MjJF45JqEyv1yIl9e
         KCEw==
X-Gm-Message-State: AOAM531xEERqDl1N5nZCPEnEoW9xtSPlJo2bmUgvkJZ7gKFcIKjrSWkY
        jY9c/uRCmTHaFKgED44gxIIgPtsJZxo=
X-Google-Smtp-Source: ABdhPJz5oH9UDFWyq82r/P6HUHpmpZWwaagZSjOvg2eLnc6W9xm8VkHcz7wqNCnVanU8hftSsIeSsQ==
X-Received: by 2002:a7b:c357:: with SMTP id l23mr4704840wmj.152.1619189931800;
        Fri, 23 Apr 2021 07:58:51 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id 18sm11167776wmo.47.2021.04.23.07.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:58:51 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/49] staging: rtl8723bs: remove unused bb_reg_dump() function argument
Date:   Fri, 23 Apr 2021 16:57:57 +0200
Message-Id: <6872fe3d18bcf1d2e481b3da0d5dc0df9f3c45a9.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
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
index fb12614a2bad..154a35b1541f 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -30,7 +30,7 @@ void mac_reg_dump(struct adapter *adapter)
 	}
 }
 
-void bb_reg_dump(void *sel, struct adapter *adapter)
+void bb_reg_dump(struct adapter *adapter)
 {
 	int i, j = 1;
 
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

