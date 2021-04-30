Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20D836F685
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhD3HpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231131AbhD3HpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:45:04 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329B6C06138D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:16 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id g10so13560658edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:44:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FleOPJ3gtiTATKAeonx+PuxFi1VSxS1weEi5bkXodsY=;
        b=V/YZ/XGtqW/bOPTBNDpeh1HXpc6qYK8P1gPxPtwvqW2yK6Pw67OO/KJfi3ByTZ7Xac
         Y7RrE77hpN9sXZZpxAB8X+k70NWFJgFQc0WQZRToHbn7Nf6aCn7PsvH6Ty3fAH+KBzJf
         eNoaXhf4MyLuDIaQ8p36MPapwBisgLgV8cuyNB/vuu9KyttT9HgVXyuS/yWyJxYZ8lfL
         g9zrK519s71i7xej4Gv86hcyse7wAPwmulmOa6HHBjWNuZvCNWTAu5dWSe19/HOetn/K
         T8fa0ZP/35/0+wCmlyJiMHEHpbNZPo/szDNEW2cfhsn9oozOgCw8a7P7hRxt83Pz8zA1
         ayRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FleOPJ3gtiTATKAeonx+PuxFi1VSxS1weEi5bkXodsY=;
        b=jfyCx+s1SQ/uSGM8ZxgwNfVqJ3ZhT4Dvlu6N3k4fO5I9BrDYfojCORcBLQxSbZl551
         LvmWY3jimqcA3WPSEEroxy8kus9uEYYSTrC4Drg6G4d7u8obHdWbShG2nNkBa0n75oMr
         TheFEAUSAJivZ5VyJsETH9mf1vnSgMaTfe5LjjlxR8cIwbHv7i3cI9hJvXiI90v3hS1O
         52udwOBgCbhM18/AhneyPpezAmbxqYXWgROZTNxOS7HdkIPjsp7cJb2CP1wEO/A+q0qv
         HG46uy21vVTxIG+DtLijvyB8GaK2k5hO53gXSbWuonhWZ0omUsfM34ecYq8l61UZJTqq
         4gTQ==
X-Gm-Message-State: AOAM533og53ASHmgLYZsMUFF1k68bmuWI62z4pQOT+rSmK6xmHce8hBf
        PhIN8q+31FvA1VXg6fXo9+3WZexsplxUQQ==
X-Google-Smtp-Source: ABdhPJzEERBtrwZa0o1YQKTkoVGXIdB+5vZaz24vJFIBLiZhoEhj1lpTA61rM8Iy6aYlJxAcQNb4Vw==
X-Received: by 2002:aa7:c7d5:: with SMTP id o21mr4217214eds.166.1619768654795;
        Fri, 30 Apr 2021 00:44:14 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id e4sm1426179ejh.98.2021.04.30.00.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:44:14 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 06/43] staging: rtl8723bs: remove empty header file
Date:   Fri, 30 Apr 2021 09:43:24 +0200
Message-Id: <ed2e1d94727c7d2403b5b6c9f265ced934b3c611.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove empty header file.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm.h         |  1 -
 drivers/staging/rtl8723bs/hal/odm_PathDiv.h | 11 -----------
 drivers/staging/rtl8723bs/hal/odm_precomp.h |  1 -
 3 files changed, 13 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_PathDiv.h

diff --git a/drivers/staging/rtl8723bs/hal/odm.h b/drivers/staging/rtl8723bs/hal/odm.h
index ff21343fbe0b..ba723ed7aa96 100644
--- a/drivers/staging/rtl8723bs/hal/odm.h
+++ b/drivers/staging/rtl8723bs/hal/odm.h
@@ -11,7 +11,6 @@
 
 #include "odm_EdcaTurboCheck.h"
 #include "odm_DIG.h"
-#include "odm_PathDiv.h"
 #include "odm_DynamicBBPowerSaving.h"
 #include "odm_DynamicTxPower.h"
 #include "odm_CfoTracking.h"
diff --git a/drivers/staging/rtl8723bs/hal/odm_PathDiv.h b/drivers/staging/rtl8723bs/hal/odm_PathDiv.h
deleted file mode 100644
index de69d5ea6ffd..000000000000
--- a/drivers/staging/rtl8723bs/hal/odm_PathDiv.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-
-#ifndef	__ODMPATHDIV_H__
-#define    __ODMPATHDIV_H__
-
- #endif		 /* ifndef  __ODMPATHDIV_H__ */
diff --git a/drivers/staging/rtl8723bs/hal/odm_precomp.h b/drivers/staging/rtl8723bs/hal/odm_precomp.h
index d48d681472d5..440a549bffc7 100644
--- a/drivers/staging/rtl8723bs/hal/odm_precomp.h
+++ b/drivers/staging/rtl8723bs/hal/odm_precomp.h
@@ -31,7 +31,6 @@
 #include "odm_RegDefine11N.h"
 #include "odm_EdcaTurboCheck.h"
 #include "odm_DIG.h"
-#include "odm_PathDiv.h"
 #include "odm_DynamicBBPowerSaving.h"
 #include "odm_DynamicTxPower.h"
 #include "odm_CfoTracking.h"
-- 
2.20.1

