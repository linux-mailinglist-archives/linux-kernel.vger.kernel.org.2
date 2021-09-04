Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECDE400B61
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Sep 2021 14:41:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236493AbhIDMmE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Sep 2021 08:42:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236436AbhIDMl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Sep 2021 08:41:57 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBA86C061575
        for <linux-kernel@vger.kernel.org>; Sat,  4 Sep 2021 05:40:55 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id u26-20020a05600c441a00b002f66b2d8603so1376126wmn.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Sep 2021 05:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ds16IXU2vNbsdQO/dc3L1eeaxH+v8TjOAf/ArBE1Ksc=;
        b=NErbtEpsWLPvWPgtqRVHT4IVDgQ2qCI0k8HA0G+A0ZB6+BCnVSMby6IBM4UmZYIw1K
         CAy7lz44pT5+W6F+/LVSY9u0BT0vbLKLULdGVQD+Ivt7E/VlwdDfGRnKED6z6P17dKQT
         DC7llkPrZzZ1oVJSt1jigp96OfgcE5M+cvW5BPMMWLdJGQiUWltAs6UEUpEj0b5zb0/3
         2Yfi6i5wi3HIPvFEcduQQfCIuL1sPjnA0lcmnpzqBJFqOfTYkguyFMafMftkDEwz5g+X
         nLCgE1Fabjvvo0Gg147+RBmmL0QNv0A3SjTo7/KOfyPiNvCQL7nB/u/t49FfeQUOVGwd
         DhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ds16IXU2vNbsdQO/dc3L1eeaxH+v8TjOAf/ArBE1Ksc=;
        b=Ks2lo7P563Zd4qU3PfKBUB7eL23uJSvJ/zEWjUwTvjq4yzGFqn87pVnuQc3GOc5a0k
         KvWT2UKu0D+Lj1nfNCoPdqe9JefR66gCHgPQvRJqj+BwDV6Pg4ZYkdzs1ZUzhlEmRgqf
         6MyHfdZEpNw/ZWGq5vx7qcxvUqYSRNb2vMrcWl7xhykHQqApTkrhURozGfpwFI4GM58L
         mMCca8IiyY/r53CNbTCHu/XZ5s9HCu+hnRdIzxJelYU19kSbK9/rejhrs7BvlKw/k0hA
         H0c2oqL/RGWLVa0GKk+6wsa/5To70wZLGUkXugvIJsPcQfrZFE+PKbMQfS2IrKVBPxkv
         bSJQ==
X-Gm-Message-State: AOAM531qe7lGXViyR2Qx8AcBwcnVDNZYEQexqV2V9vXH7raMWE/XZKbV
        Mvk02F9zGQ/e2r9QnAiGw2I=
X-Google-Smtp-Source: ABdhPJzgIAS56OsHpK0ht5hesJFnBIORKknDuFnp2OuAXb3F9MI3URJthp+eyQfMtukV2hlfJDJLTQ==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr3007306wmz.93.1630759254463;
        Sat, 04 Sep 2021 05:40:54 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::8fe1])
        by smtp.gmail.com with ESMTPSA id j207sm2094071wmj.40.2021.09.04.05.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Sep 2021 05:40:54 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 4/6] staging: r8188eu: remove wrapper around ReadChipVersion8188E()
Date:   Sat,  4 Sep 2021 14:40:31 +0200
Message-Id: <20210904124033.14244-5-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210904124033.14244-1-straube.linux@gmail.com>
References: <20210904124033.14244-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function ReadChipVersion8188E() is only called by the wrapper
rtl8188e_read_chip_version(). Rename ReadChipVersion8188E()
to rtl8188e_read_chip_version() and change the return type to
void since the return value is never used.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/hal/rtl8188e_hal_init.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
index 24bc8ba8726e..64a0223f0ee0 100644
--- a/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
+++ b/drivers/staging/r8188eu/hal/rtl8188e_hal_init.c
@@ -1689,7 +1689,7 @@ static int rtl8188e_Efuse_PgPacketWrite(struct adapter *pAdapter, u8 offset, u8
 	return ret;
 }
 
-static struct HAL_VERSION ReadChipVersion8188E(struct adapter *padapter)
+void rtl8188e_read_chip_version(struct adapter *padapter)
 {
 	u32				value32;
 	struct HAL_VERSION		ChipVersion;
@@ -1726,13 +1726,6 @@ static struct HAL_VERSION ReadChipVersion8188E(struct adapter *padapter)
 	}
 
 	MSG_88E("RF_Type is %x!!\n", pHalData->rf_type);
-
-	return ChipVersion;
-}
-
-void rtl8188e_read_chip_version(struct adapter *padapter)
-{
-	ReadChipVersion8188E(padapter);
 }
 
 static void rtl8188e_GetHalODMVar(struct adapter *Adapter, enum hal_odm_variable eVariable, void *pValue1, bool bSet)
-- 
2.33.0

