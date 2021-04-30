Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 705F536FCD4
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhD3OrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhD3Oq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:46:28 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B59AC06138E
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:15 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id h10so82911216edt.13
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=COla8THV9MLqgxdkc3FzpFMxvj3Sxk16di+Wdxq2A3k=;
        b=cwQJ7+myEX/mDcGBX2NZhAEoLa5qA5oqAJCVH43z8fwwFsxe9rYLtcRpZ4l4e0hJOW
         5mrl2H0i4hkec2aIvLyOgUTc7hlYxVCqn4vTrk84DMOzWe5BVJk2w3ivvOQ13bPN50Wi
         mivw49nPkFBjKnSQveqUiclF9aP4OG230NrtYzGfmBEAnnymmKoo3a3tXUu6zoldgYIt
         bk3lsdfKfUYAYS6/ZZV9DFWyAs2OsNyMgEKsSiN8F4p/8SrItaliCwwf7GV7xEHb6EKT
         9eFOWjRF34TVCZjUi6CYWLJEXHdVi9hSaGQwMS46hLAkulWPKTO81/JvL4ElyUIIwApa
         15jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=COla8THV9MLqgxdkc3FzpFMxvj3Sxk16di+Wdxq2A3k=;
        b=O920W7aDK26HhBQGToV88Wr6XTAlgJ6PSlDryfmTCIjGRpZLfMWrKV4Tf+59AFTDsN
         yEGfobsm6MtKgHLJXWqWKRTEEmRFcJi/b6kMrCD/mZs0acNqftGTTgYsDFLNMkceqWHF
         JJffq5tjeI6GzqVCy6IrLSs7/pRVLQrz2nw3YJk4awaaunIiFQmDXGwPb1/FoQ3nwra9
         e6RVvwXgCTztPMHu57aHY6xLTxBaYUG7XPpmxiwO+a5qsRVlSBqVSooqdMCeXhWtVxS6
         u/VVfsmw5pYpjtyPkEZzt49WP/gFYCeTfRtTBjeKiDj9kX4vvBuplNe/hdPu3aperl2W
         jXyA==
X-Gm-Message-State: AOAM530+uTiNvrbsrWZSAAFuJ7g2EIDoULbiqWxy0LCDVwjDKWu+4RNx
        pc6T/c+X5YgsM9ZsAexIaRwy82EDOvw=
X-Google-Smtp-Source: ABdhPJyXGn7IvEb/JU5p4RopGS8NYgZb4aQ6RIwKpfs8wW3PwLvougaYvsBz1iENh1IqzIuRfVfASA==
X-Received: by 2002:a05:6402:b48:: with SMTP id bx8mr6279302edb.157.1619793914136;
        Fri, 30 Apr 2021 07:45:14 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id me3sm2063843ejb.49.2021.04.30.07.45.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:45:13 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 40/43] staging: rtl8723bs: remove empty hal/odm_debug.c file
Date:   Fri, 30 Apr 2021 16:44:10 +0200
Message-Id: <f175773c3bc4300673663bf68a6b0611d5af0901.1619793406.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
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

