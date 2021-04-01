Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBDE35120D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Apr 2021 11:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234293AbhDAJXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Apr 2021 05:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233783AbhDAJWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Apr 2021 05:22:11 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC0CC061793
        for <linux-kernel@vger.kernel.org>; Thu,  1 Apr 2021 02:22:11 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id e7so1136409edu.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Apr 2021 02:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hM+Yde17Zdskg7zytVje3fm23lmUvElHVdMsmjIgn/U=;
        b=PyxaMyX+0l6pefqOOZhM2RfksB7zsbY+16qwKPV3O4BSMwf57q/eruJNE9Nh13KOkE
         9HHAiFNPrZx2UgHpG4x+t151H9FsyrXcViAbysVXpGxbaMCNlJqTcB3V1FdrQy2DYiF7
         mYYHIQgzLfrxhU8kfkmJw+idBcdNTfh8H9QYHiB1BANGJP6XkFSoEyl7S/sjpx8ohYso
         12UnCJTVOp8dHEUUZKe5hpRXfnsIi15M5W+uzMnTVTPtZtRcfZPHUEcMbw1Q9sleQba5
         J0FNoTBw1Uad+3KT4GrSURR2vGS24a2+KS+R2HrngrQOpjX6UeyxMtugAKoFApfVldlw
         dvBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hM+Yde17Zdskg7zytVje3fm23lmUvElHVdMsmjIgn/U=;
        b=fccCDR3R6uhsyd8+F/VUeEq8pXbEs2Xl9ejQByVArM6VRus2JlXLX32MLaJ9iMqlum
         dBW7z9bFP1U7Hj5VapsJeoUM07yp+mobJtH5QVCQHFvC3zOUc/mfKIbJ+wAb9JtnbfAQ
         0T0zJ5kzMtqh3w1YjIUsMLkl5/RVNZOe/dr6wO2Mj1ys6Ji+I3P4kBAzZHlj56QrAbXp
         7LUmRNSJbrHONjpSjuSwNxMP0DdF1lD/cOtyLh7wiidtuK/OsEl4Wr8v4bmfkQ0ubna9
         HNepdxs1g7cjB572SYtZzR1EKAXn4lMats5sqQgRlnHf3G0ClUSoi7lgpwOSqkrZ1lTy
         LLEA==
X-Gm-Message-State: AOAM530tn8p+Cd1a8QlA+puHWxrhcvmcQSkgcAarSZ6La8bIkW+YKla3
        VJYg5j9RoZQCM5KGajJlA2rwbjgRuPqRJA==
X-Google-Smtp-Source: ABdhPJwCZocLXSE5ugKLapKC5x+a7wEvYaP7HQ/21h8xxTk7dbz8DpyGUDA/317TuEogqcRINEVKbQ==
X-Received: by 2002:a05:6402:3592:: with SMTP id y18mr8594052edc.360.1617268929876;
        Thu, 01 Apr 2021 02:22:09 -0700 (PDT)
Received: from agape ([5.171.80.247])
        by smtp.gmail.com with ESMTPSA id p3sm2538709ejd.7.2021.04.01.02.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Apr 2021 02:22:09 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, dan.carpenter@oracle.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 28/49] staging: rtl8723bs: remove empty if blocks in hal/rtl8723bs_hal_init.c
Date:   Thu,  1 Apr 2021 11:20:58 +0200
Message-Id: <aff7710e7a36e99348eab7aacac525ab796c17fc.1617268327.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1617268327.git.fabioaiuto83@gmail.com>
References: <cover.1617268327.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty if blocks after RT_TRACE deletion

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
index fbc6ef0cfe0c..df15b9c206f3 100644
--- a/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
+++ b/drivers/staging/rtl8723bs/hal/rtl8723b_hal_init.c
@@ -64,9 +64,6 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 	blockCount_p1 = buffSize / blockSize_p1;
 	remainSize_p1 = buffSize % blockSize_p1;
 
-	if (blockCount_p1) {
-	}
-
 	for (i = 0; i < blockCount_p1; i++) {
 		ret = rtw_write32(padapter, (FW_8723B_START_ADDRESS + i * blockSize_p1), *((u32 *)(bufferPtr + i * blockSize_p1)));
 		if (ret == _FAIL) {
@@ -82,9 +79,6 @@ static int _BlockWrite(struct adapter *padapter, void *buffer, u32 buffSize)
 		blockCount_p2 = remainSize_p1/blockSize_p2;
 		remainSize_p2 = remainSize_p1%blockSize_p2;
 
-		if (blockCount_p2) {
-		}
-
 	}
 
 	/* 3 Phase #3 */
-- 
2.20.1

