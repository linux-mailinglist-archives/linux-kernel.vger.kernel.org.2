Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA7C436F62
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Oct 2021 03:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbhJVBbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Oct 2021 21:31:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbhJVBbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Oct 2021 21:31:09 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13068C061766
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 18:28:53 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id m14so2215866pfc.9
        for <linux-kernel@vger.kernel.org>; Thu, 21 Oct 2021 18:28:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5hjq4xNDSX6zyKFegZIOLE1l43Iu1DbC8TAFvZCaTw=;
        b=H5WpnHXKIGc3d4jDMuT3XFNwz1AL2jxjUyD5Sx12hVeRwVThV7+s9LtD6DUWCjCgcM
         eXXNFN8KPbA0iVdecz95dC/6PN5NOi0g1NDGoE3VR9b2uuZXmXDcg+TMF/SprQv9+WRL
         zTb6YwPWSfybnDDO0uSmDGeLcu936QDWBPsOp7tR7Yfn0VgBpR0IVTu9/D7Aw5T8H9Op
         2kc0v+2Yogam+qP1jedtyOUBJFPKyWoPcjgS1/QW736bksLZzFsShEUDzhctLp8uWuxy
         158pvJeUXwXpfsB5gcrcUigBtC60qldSrCeebK0/I7eYtTgCrqnQafKskpohldZ432Sp
         LfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u5hjq4xNDSX6zyKFegZIOLE1l43Iu1DbC8TAFvZCaTw=;
        b=8SYx5pOO3hcV2xO6dSdPKcLclHT/ZfQ+7xWiRulII+yx7NCEJATC/mKCOrtc0Lz7q4
         Dx3j+9Bi4QpeVvVOsq9AglxXaW8fqQGdQy4z0VZc+4T2N0hfYhiX7fGUARhTsHMPfsGF
         F0kJC2pVFVjnAWITXT0T20ac4oZz3A3DKYPG3h1xlFa7eFyFMgHFpY4o3752WlZhquvI
         lzzWEdZOkl53nqpqXmRvqlhl11d0Cx35q/EumF+Pwr7TN49XF4qbKSdIsCBaxJfd7SiF
         7AU0SnphEA/CMV1S7ll4Mzaj358tXyz58r6AS7oQEETdLmwsCDxCDsDa/zZsKj0YRoRp
         A+VQ==
X-Gm-Message-State: AOAM532jWo0JurH9s6HXoMP2KTQ/oaYrAlnWyi1kUQ2Ve4emqyNJoGVE
        LXNksoeGH9+DGXTcceV+6K5OCofIkdpFbw==
X-Google-Smtp-Source: ABdhPJxd0ojl8Xm+42PNgmm95Ga7em0sQUY5QIsJoPp5XiSKQcbG+aFSPzQEyumx3JRPNw11+IbiDA==
X-Received: by 2002:a62:6411:0:b0:44c:bf9f:f584 with SMTP id y17-20020a626411000000b0044cbf9ff584mr9579903pfb.29.1634866132603;
        Thu, 21 Oct 2021 18:28:52 -0700 (PDT)
Received: from debian11-dev-61.localdomain (192.243.120.180.16clouds.com. [192.243.120.180])
        by smtp.gmail.com with ESMTPSA id ip10sm7181208pjb.40.2021.10.21.18.28.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Oct 2021 18:28:52 -0700 (PDT)
From:   davidcomponentone@gmail.com
X-Google-Original-From: yang.guang5@zte.com.cn
To:     keescook@chromium.org
Cc:     arnd@arndb.de, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH lkdtm] lkdtm: Fix reference preceded by free
Date:   Fri, 22 Oct 2021 09:28:32 +0800
Message-Id: <20211022012832.10644-1-yang.guang5@zte.com.cn>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The coccinelle check report:
./drivers/misc/lkdtm/heap.c:115:7-11:
ERROR: reference preceded by free on line 112
Moving the "kfree(base)" after using place to fix it.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
---
 drivers/misc/lkdtm/heap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/misc/lkdtm/heap.c b/drivers/misc/lkdtm/heap.c
index 8a92f5a800fa..4c6341e7bdca 100644
--- a/drivers/misc/lkdtm/heap.c
+++ b/drivers/misc/lkdtm/heap.c
@@ -109,8 +109,6 @@ void lkdtm_READ_AFTER_FREE(void)
 	base[offset] = *val;
 	pr_info("Value in memory before free: %x\n", base[offset]);
 
-	kfree(base);
-
 	pr_info("Attempting bad read from freed memory\n");
 	saw = base[offset];
 	if (saw != *val) {
@@ -121,6 +119,7 @@ void lkdtm_READ_AFTER_FREE(void)
 		pr_expected_config_param(CONFIG_INIT_ON_FREE_DEFAULT_ON, "init_on_free");
 	}
 
+	kfree(base);
 	kfree(val);
 }
 
-- 
2.30.2

