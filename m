Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DC2B4150F4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 22:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237371AbhIVUHC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237351AbhIVUG7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:06:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFD3DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:28 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id i23so10500034wrb.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 13:05:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c1o6cETie+EygdT2bARuzpRmX27g1uoX7+0epnYgy4w=;
        b=iI/0dEkNyjczXewoipqIKCHJ3HieBch4c0WRxg+smt7ezZoFpmsVMEnpyVJl5c1mdl
         Yj1VsYzk6nAQxUAi5G2xsI2cCoLmWAUq4E6tAs9XuUqwijMkFE8nJyXflTtgE2Xfnaek
         wNnZiwUhqarif6YF3NQuUgoaZ5L6BfDNc1RodW602Q1mO5Na2ozrlNSycmDyHs6yo8H/
         ILDnMmF63bM4smIbVHIM1sZtVDfVwchMk8ukGaBiFVZUhdPBpC0mDPtg7ufYofou3LZf
         JHmxdRJiVdiOS+R0wQjI7A/rcAQAFpxCQVMHjgAwFy24ShpOM4HN5cjmOKNS6Z4BxzGZ
         mOWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c1o6cETie+EygdT2bARuzpRmX27g1uoX7+0epnYgy4w=;
        b=5nA1KfGU+6qf6yGQh5qTCg8Zkbb+wqFeor33+8fqeTRo8AaYRMPlES8b9fmYuKiPH0
         Ytv7b5yKy98GX4REG0m4Zu9QKHWeq3bOwceJKqZHUutUhYdCvCG+dgJmpmealPZY03Am
         CEV7Y8YHxr6g3vkWkcXLMZsvOlmG2g1lSK9AornzGXvuafi1n9OH2L2lb/z5I0wbVFSe
         ArTmv3KTNtFGq6vOjf6lBE7EmJzufpho+nIMMJ5W9PG+iFLrUb0XlvlPjiBw5GqTyhP1
         0N+53AU9EGrfiakYaGFbdZL1ZeQaouJasyqgVdjW6fZYGTRhklA7z5Db2PN82G45DiM2
         Pghg==
X-Gm-Message-State: AOAM532u8KOfXSQQ11TpHtnLmhRKmx7eTqasMbgMoCANQsoZHykMyUNw
        g4mTLvupM7IR3drA0joHjmthmnN89A1fCw==
X-Google-Smtp-Source: ABdhPJzQkYoCk0jmNkY8qqkGC+xhDfyP9A7JEmls/pHN5NhB7gMmK9jBUz25qYqFD4R9vNOksHtiIA==
X-Received: by 2002:a5d:4810:: with SMTP id l16mr887007wrq.3.1632341127397;
        Wed, 22 Sep 2021 13:05:27 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id e2sm3219761wra.40.2021.09.22.13.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 13:05:27 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 02/47] staging: r8188eu: remove efuse_GetCurrentSize()
Date:   Wed, 22 Sep 2021 22:03:35 +0200
Message-Id: <20210922200420.9693-3-straube.linux@gmail.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210922200420.9693-1-straube.linux@gmail.com>
References: <20210922200420.9693-1-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function efuse_GetCurrentSize() is not used, remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_efuse.c    | 9 ---------
 drivers/staging/r8188eu/include/rtw_efuse.h | 1 -
 2 files changed, 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_efuse.c b/drivers/staging/r8188eu/core/rtw_efuse.c
index 958954473d9b..cb4ad21f00c1 100644
--- a/drivers/staging/r8188eu/core/rtw_efuse.c
+++ b/drivers/staging/r8188eu/core/rtw_efuse.c
@@ -286,15 +286,6 @@ u16 efuse_GetMaxSize(struct adapter *padapter)
 	return max_size;
 }
 
-u8 efuse_GetCurrentSize(struct adapter *padapter, u16 *size)
-{
-	rtl8188e_EfusePowerSwitch(padapter, false, true);
-	*size = rtl8188e_EfuseGetCurrentSize(padapter, EFUSE_WIFI, false);
-	rtl8188e_EfusePowerSwitch(padapter, false, false);
-
-	return _SUCCESS;
-}
-
 u8 rtw_efuse_map_read(struct adapter *padapter, u16 addr, u16 cnts, u8 *data)
 {
 	u16 mapLen = 0;
diff --git a/drivers/staging/r8188eu/include/rtw_efuse.h b/drivers/staging/r8188eu/include/rtw_efuse.h
index 81407efbdc44..a6e36be6ee76 100644
--- a/drivers/staging/r8188eu/include/rtw_efuse.h
+++ b/drivers/staging/r8188eu/include/rtw_efuse.h
@@ -101,7 +101,6 @@ extern u8 fakeBTEfuseInitMap[];
 extern u8 fakeBTEfuseModifiedMap[];
 /*------------------------Export global variable----------------------------*/
 
-u8 efuse_GetCurrentSize(struct adapter *adapter, u16 *size);
 u16 efuse_GetMaxSize(struct adapter *adapter);
 u8 rtw_efuse_access(struct adapter *adapter, u8 read, u16 start_addr,
 		    u16 cnts, u8 *data);
-- 
2.33.0

