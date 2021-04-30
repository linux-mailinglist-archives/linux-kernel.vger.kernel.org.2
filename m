Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4944836F692
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbhD3HqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231347AbhD3HpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:25 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7DAC06138C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:37 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n2so103822940ejy.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kxnsY7XxgR5LPkLt/HzBZqQVJx7TOeoHfiVCxdpmUW4=;
        b=hrhRKshMp3WRdkuds8YQxZl/TMiaTbst/OmV1OxYXnVSkyvzca55VxbCNGofsw2t2c
         i+kleGNk2ItBWf1nDFR2hbGFoEa/zmdzycA09aRIbphHnx9V+Ube1MrHV9MysHCAp06V
         dM4OVc18THAEd2snplWac8pJkiuR+2sFY+0pJXto8ymvXllFyT8zw2qswcytLB8OhwLj
         fWsneuUUQiICPzNjtGPdYLDh1fI8Ak39khZYRtxC8LRxrGckNaq8NYuZ+5JDFUWE1oap
         2lk8Z8zkptaJqZQua8/58jpYK53XqYb1Z+BV2G1l3NrnE+MWHN5x082UWKSJX1aUYDIp
         srTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kxnsY7XxgR5LPkLt/HzBZqQVJx7TOeoHfiVCxdpmUW4=;
        b=uVPDhBzDcvrf5TiJAy86Q6cHJ0PvW6PA6L+lrvw9iSbuTtM/ClvY1/aIsXQ2SJ5vds
         +YOYRXBN5Ax3thkCC//ufS4JXD0ozo7Gz8HRvZgrtYq9S7BFuI03Oj64UmHFS8qg79xB
         f0gAfVCulRvjnwe0W6nACuboLy/IjTLC7fIyfdlBmetxrCWbcMPAw2z3yKbFPS+T9CKR
         m+mxA2towaPSatDPb7WRx3dXppMTtdx4xDYy7AEBl4Ray20SCCKJLUkBUAcruiDZ6Eyt
         pgJ06jOhjKR6nufc6TwpWHctzT3sRhqFOTSKzd6Lw0It4Gts7T+oU/B5TtszQTESqgAh
         fEBQ==
X-Gm-Message-State: AOAM532JUbeF5M2nXJd/7ToXrN5EOtZU/0AphZJeDcUJkdwh5BCL7yiw
        N3xvtYajBHgPCUanYD/wYPybdR8gDrx10A==
X-Google-Smtp-Source: ABdhPJxCYNqD0VnHq8f+IoNhzvOHjurXyPfPsJ1AQpIwrpb+xo2Eafyp1y7sIvmkXWELiJVIw/mDcA==
X-Received: by 2002:a17:906:dc90:: with SMTP id cs16mr2814549ejc.210.1619768675994;
        Fri, 30 Apr 2021 00:44:35 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id r21sm1475223ejy.27.2021.04.30.00.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:35 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 19/43] staging: rtl8723bs: remove unused RT_PRINTK macro
Date:   Fri, 30 Apr 2021 09:43:37 +0200
Message-Id: <794c49f2978c0a94fc2ca91c60588f9999bd0e70.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused RT_PRINTK macro definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 3faf4da42bd7..5c4412bf6fbd 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -87,8 +87,6 @@
 
 /*------------------------Export Marco Definition---------------------------*/
 	#define DbgPrint printk
-	#define RT_PRINTK(fmt, args...)\
-		DbgPrint("%s(): " fmt, __func__, ## args)
 	#define RT_DISP(dbgtype, dbgflag, printstr)
 
 void ODM_InitDebugSetting(struct dm_odm_t *pDM_Odm);
-- 
2.20.1

