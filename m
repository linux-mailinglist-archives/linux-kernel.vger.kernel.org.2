Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF13B36FD23
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbhD3PAb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:00:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbhD3O70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:59:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7A8C061344
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:13 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c22so19339928edn.7
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=COla8THV9MLqgxdkc3FzpFMxvj3Sxk16di+Wdxq2A3k=;
        b=vfyMn8NrfMAGI7+JQqgX5mLUxEs2WdoFuKJw5iEFBeq949/rxWaVKAZZOhuhu/DmUz
         hkhE+2ywdIM0muE+AtsRgybLPGfAJUltWCkL8CDg54tbQDmiQUizxH7ZRakWFirouME7
         YcRDom/hZS9kund6s/lrK9Ec2MblQ/XIrLBxilM2xOiwAKPfmkd/YOIkoM6ar3J6e173
         CLAekfNBv3kZ0GPRekauWt956HGsT3B5ctOr8iM7KWvCCrDBwZWGqu8ibo/y22xuhT1z
         WZMQQZJ6XW4QlL3IGJHvv6iareAfcfU0KH9iwBPKqDGRt8MgHv/A6TCU6Xb5yPUKX4VR
         kbBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COla8THV9MLqgxdkc3FzpFMxvj3Sxk16di+Wdxq2A3k=;
        b=itLZXncxlO6+eyyQCdl6nULuuQc/r3b08x5l+DQA+wRCpPHwhPjOkZo5zQXi/AQgC5
         hO9/y79XMqjRatL4rvggJUravdVMl7HqvhYPQNjgXNYed8WSwEKj49puRKroqrIxx9ZK
         KvO1UH6eLzEYVLQtQ4Rc1A0nfKO34t5/MSLO+gBGvEb4KdGBKF0cukg3hmGKUlGRvcO0
         r67dn2nFQS9vCUsFnH9DGUfbyKXdQxh2GrfzK1MsmGxTEyNEGN79ee5UaVhFAisNS6uK
         x5o9fgH7ABBQEMzPy75UVs1ah3zGVAjNR3CshIilK2eNldAjFQvjRYX9cyZNtdXrCF1R
         8Npw==
X-Gm-Message-State: AOAM533TRRM2CIPceoXDtUFLFIJPHfBmtg7MdEBAiQXxoTaEt/ZBRmBV
        cbx9zngss9gO1omun3foxGG45ksqXFA=
X-Google-Smtp-Source: ABdhPJykYYMOTuoCwSZeNKy9UqcoH0ZqAeevkuiWANoHm5o1e4hesuTDnCctIFzWkIW2PyLhydsuew==
X-Received: by 2002:a05:6402:1ed:: with SMTP id i13mr4135328edy.27.1619794691978;
        Fri, 30 Apr 2021 07:58:11 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id f19sm1497788edu.12.2021.04.30.07.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:58:11 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 40/43] staging: rtl8723bs: remove empty hal/odm_debug.c file
Date:   Fri, 30 Apr 2021 16:57:02 +0200
Message-Id: <0bd6ce2da09a5e2a671dc4a53f1c2e7ba1a64066.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove file left empty after function deletion.
remove related target in Makefile.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/Makefile        | 1 -
 drivers/staging/rtl8723bs/hal/odm_debug.c | 9 ---------
 2 files changed, 10 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_debug.c

diff --git a/drivers/staging/rtl8723bs/Makefile b/drivers/staging/rtl8723bs/Makefile
index c40983496608..fe45200ff53c 100644
--- a/drivers/staging/rtl8723bs/Makefile
+++ b/drivers/staging/rtl8723bs/Makefile
@@ -28,7 +28,6 @@ r8723bs-y = \
 		hal/HalPwrSeqCmd.o \
 		hal/odm.o \
 		hal/odm_CfoTracking.o \
-		hal/odm_debug.o \
 		hal/odm_DIG.o \
 		hal/odm_DynamicBBPowerSaving.o \
 		hal/odm_DynamicTxPower.o \
diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.c b/drivers/staging/rtl8723bs/hal/odm_debug.c
deleted file mode 100644
index 1a2e367bb306..000000000000
--- a/drivers/staging/rtl8723bs/hal/odm_debug.c
+++ /dev/null
@@ -1,9 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-
-#include "odm_precomp.h"
-
-- 
2.20.1

