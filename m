Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F23436FCF3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbhD3O6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbhD3O6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:04 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA36C06138D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:15 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u21so105730110ejo.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3tIIreTX1B9CMYOHSzNQF8ZG+/YV3WWYfSInXojnLbE=;
        b=RdJbPgZDSCfM2XhsOV2nzj424rJzDJW5lq4ZfnXn3f/9oRks5QwjhtAb7STj+60M4x
         gUvc6rYkS0emf8qc5Q46ls36trL25hSksB0vmpDmZo/Jpeo8Wrni1lu7bN/Vu2dRcJsw
         yrkbCXFwtqouR9EB4wMVGzlHY26Ae0Fq4HOqgwICkvJnwnIV44W8126jGBNwx0RTD/F+
         7SGacmddfXsL+uP8rCJTQYFu+ptlLCxtEm7K+t0nt2pHw2lcP7RnkbnfAdgjPWH0XSh0
         cMAMuxNMh/4QQGccVEX/IbKezG7gPg/ep3YcmKbRle5TzhnLYm8oiUE07B/f+4LitnUz
         fNGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3tIIreTX1B9CMYOHSzNQF8ZG+/YV3WWYfSInXojnLbE=;
        b=IejDRGAfl7gIrepse0vuv1GAvSKp+Y+iYAGQEotpv/Vnbl3O96wJywguuYcCyRuuuX
         LEW124KY91ajC9V+Ja4PwXtD3LZuuBAt8IzAZFthQQOKdxma28E/c+E+Axn8Sp0ypIuB
         tmHVH/n1ueGT2zCRqBsV8g6Ix5NhjNraO7koawaUNUxki9JTNMafxgQk9BDWvSbPmD4Z
         R2LlL3owGKOrs1EvG2Dmd1dbPMsUzrG98dAN5CbaomPWByIZwMUQTV8UXZ7alLzQ4dtl
         gmb7vU3qx3ZA6AQa7/c24j+EtCT9CqNmzuMnLPp08CL5U3gk3QfUC8OEd90iaHSjEDvZ
         tFhA==
X-Gm-Message-State: AOAM5330v8dBb0JxoUn54P9WDKMA5vfFoCcUGgDUV/sqG1edBaBLYUQ1
        qPmDNFeKchZfMKdgaIgImog=
X-Google-Smtp-Source: ABdhPJzywSMbF7Ja+SNGHhApyNWR2SMA6v53KvwW0xHy9HG+XH9ZxDxdBn+9tM4F5GTTtiwSl705cg==
X-Received: by 2002:a17:906:5495:: with SMTP id r21mr4871192ejo.471.1619794633933;
        Fri, 30 Apr 2021 07:57:13 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id ks10sm2092672ejb.41.2021.04.30.07.57.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:13 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 04/43] staging: rtl8723bs: remove empty hal/odm_PathDiv.c source file
Date:   Fri, 30 Apr 2021 16:56:26 +0200
Message-Id: <90ebcf46a58375ae25d51638ae91fa40521c6c06.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty hal/odm_PathDiv.c source file.
remove related target in Makefile.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/Makefile          | 1 -
 drivers/staging/rtl8723bs/hal/odm_PathDiv.c | 9 ---------
 2 files changed, 10 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_PathDiv.c

diff --git a/drivers/staging/rtl8723bs/Makefile b/drivers/staging/rtl8723bs/Makefile
index dfe410283ca0..c40983496608 100644
--- a/drivers/staging/rtl8723bs/Makefile
+++ b/drivers/staging/rtl8723bs/Makefile
@@ -35,7 +35,6 @@ r8723bs-y = \
 		hal/odm_EdcaTurboCheck.o \
 		hal/odm_HWConfig.o \
 		hal/odm_NoiseMonitor.o \
-		hal/odm_PathDiv.o \
 		hal/odm_RegConfig8723B.o \
 		hal/odm_RTL8723B.o \
 		hal/rtl8723b_cmd.o \
diff --git a/drivers/staging/rtl8723bs/hal/odm_PathDiv.c b/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
deleted file mode 100644
index 1a2e367bb306..000000000000
--- a/drivers/staging/rtl8723bs/hal/odm_PathDiv.c
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

