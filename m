Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B48336F690
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbhD3Hpz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbhD3HpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D008C061343
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a4so10477049ejk.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZ9GqwS1PPNPtRn+ut+6mZGIBFXs5PoH/wfecY65hmw=;
        b=Lj8cqDC1w71yvV68QUQjJqo1onXFIFaRvucg/ATAasvTsVH6P3WK0QRxqlBL+4rpZZ
         z0u2pphhwrQw+pggfE3FaZsWnKgjOZn7XVN8HJHULh5LJ7ozG7PXUmnulI5RpRZVbVts
         NE91jS/o4aJxpFxw3OHXTIYTPFfmdO2zjFLn9BK7nAv+2NatEs31deGSPH8TJ1jXL/gQ
         ++sXel/Ai8hYBjvC3M0Uq7kd4qD9XoKwjceEwSlY+c2gVT+HP49od0gF5kk8JP80BjC3
         ZxPAmrzw5uHq70M62uOEYDvHXrK8qiDE3gmDZAqCHWDALrg/wz+KiHCqmSnk2G4Fr2xE
         gJEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZ9GqwS1PPNPtRn+ut+6mZGIBFXs5PoH/wfecY65hmw=;
        b=G4MSi89FWYoozScG97VyJEjt7Z39j0vVgfyWJgXC9LcEpYGV0Czc0uF4UQHYWZbfGN
         qAbSZBZ7R5XAwNT6BPWQJStX0frkAgbQt/5GNb+rJo6LC2w4ttyjFinbOvNRNRldXuPA
         J5q1B9QLx5j6tAhHlLvbNMC2KfZA4y4SiHhg1ITuCdacTmJxl/3OnTE2sOi4w90h2g9j
         dHODpXTwAPTQDinnqqn4bgYJIcEzOfl+sULaRWh2QkEOOjiNNOWyf4Zt/t2XYLkq0i9o
         EJ0lh6jXMe47BVrBLQle+Q66D/H3Onv5QJ862QqpCuHChdPebsHz/2CjvLu1HQAfD4hB
         pUGw==
X-Gm-Message-State: AOAM531wPMkxROlvO9RNBMOeSGYm5MlJfDKMRxGk/COfKICYT4fBX2hd
        gfu7caiKhHW1uqtFhLp9FIzcP0JJiV8G+w==
X-Google-Smtp-Source: ABdhPJyuSWLYSgujn7CLdFgci10905rObx/o86kJ5miQhpMSAjXl1UHKus+MEH3csZxB4aBNCn+/jA==
X-Received: by 2002:a17:906:3111:: with SMTP id 17mr2701005ejx.403.1619768672641;
        Fri, 30 Apr 2021 00:44:32 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id j20sm1415518ejc.110.2021.04.30.00.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:32 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 17/43] staging: rtl8723bs: remove empty #ifndef block
Date:   Fri, 30 Apr 2021 09:43:35 +0200
Message-Id: <a114cc6f881315676862315228da6ad16b02a96a.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty ifndef block.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 78b9b4548dcb..3faf4da42bd7 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -91,9 +91,6 @@
 		DbgPrint("%s(): " fmt, __func__, ## args)
 	#define RT_DISP(dbgtype, dbgflag, printstr)
 
-#ifndef ASSERT
-#endif
-
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
 
 #endif	/*  __ODM_DBG_H__ */
-- 
2.20.1

