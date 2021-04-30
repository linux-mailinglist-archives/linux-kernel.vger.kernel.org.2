Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5557D36FCBE
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbhD3OqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233489AbhD3Op3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:29 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8BDC06134D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:41 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id i24so23350338edy.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DZ9GqwS1PPNPtRn+ut+6mZGIBFXs5PoH/wfecY65hmw=;
        b=Iz2Oj01s64NJ60zI0ggXwISxptC7FWWdcm/+QMU1n/vA4bmq5tPG6MvUZkbpnf1rgm
         e9ee2jOWbwtxvk/3i59ox0yWSOMbfMTvszSyB4+Akic1gFiaJZWGdr1TYgk05OC1qDrZ
         DImXL5IRIIqWkoRz/DAWErVOU2MUmUhwgT9A3VUOCbfggvi3/6GFTf1jBCsW8TPdaK4t
         cZkNfgKxF6kpfcrfY/EpWarP4Dx4fIut+yhV+8gPWQWBD/NYM/WGw3y+Fbg+bZhnQCCZ
         t7ipcDsjhEYCu3gehuq2jMN6mRB7JwfM9zBAl2v9xp6AWQZfu5WUJnKzK1P4/Bw5bJh4
         gTPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DZ9GqwS1PPNPtRn+ut+6mZGIBFXs5PoH/wfecY65hmw=;
        b=TZnDG0b76Xp3XZHocuLGBsGmGtGMs2x1fdfYJsDSb8G2qPMqWkmdnd9LUjr+CR5UNG
         xJipu0emRdBXy9Rsjee5CQlzZkCQPma/9PVKudMQvQ1djPyVKWepRqdAYN0G66teqGUT
         Cvtsjdb79twi+5lpEvtSrTudbrjIu2BPsylekf5Tm/c0xtPENGZ5dNQ2tUOMUDEiA8DC
         u40GOeNvKHT3P8kss6UZQLDSdFt5NZhHwFX48Nuwgw4hphakF7fzWu6MMUJB3SzrY6PT
         vsEP/8j6pbXMhAWUn/6/5WWMWgDOW6w2KdP5lRtQi+tSrYp1CcY+QuuZ4efLOGkMfpan
         7L/A==
X-Gm-Message-State: AOAM530h5ll/FSBYTAokvd/rgHHxqJnTz1FcZuwvOL/nCnisABZD3qKm
        CjljmUttUzefXodmX5wNs1hgb82e8KY=
X-Google-Smtp-Source: ABdhPJx+1mkyvBoNk54GXq+Nypg65Ym0B/INFGBsg543s0TSONV62OVWk4U/6sUgyCJPKyaadHcNkg==
X-Received: by 2002:aa7:c9cf:: with SMTP id i15mr6563047edt.4.1619793879980;
        Fri, 30 Apr 2021 07:44:39 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id z17sm2086460ejc.69.2021.04.30.07.44.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:39 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 17/43] staging: rtl8723bs: remove empty #ifndef block
Date:   Fri, 30 Apr 2021 16:43:47 +0200
Message-Id: <6acb4774f795431fa2acf4ba8719ba91b5c37f67.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
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

