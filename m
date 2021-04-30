Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D65D136FCF6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbhD3O6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbhD3O6H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:07 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AD82C06138C
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:18 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id l4so105667156ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FleOPJ3gtiTATKAeonx+PuxFi1VSxS1weEi5bkXodsY=;
        b=sNERTVIWUOxiu/H67r7IdYKO2yzVdXb+QfoevZdgwBwpNWmEFv+PmYdSGeaYfaG5CG
         rBPPJnkj5bBkQ58Yc3pmg5qdwxDQioDsV3wOqJg/MzHTV20fL2iO5E7UyVeO14onV8DC
         KCRIzz7Cwqm3zS5Umq68JelbfJ+JSGvbIz/NhEPGmHpYgLunhc9qQbzXLdNOqM6AMEQL
         jhe5LM9O/4EyiCwdQEpEKNeWCCMGhEqMm3GHE1/qz6FeD1Y/5+7GoX1COQb+Zd7VUmEk
         QXYYMziPhHwPI30EgaiTvFqwmwrNau/Hs3huKEB6B9vXKkKZeakmm2J10ZW9TfvIhrbB
         lZjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FleOPJ3gtiTATKAeonx+PuxFi1VSxS1weEi5bkXodsY=;
        b=BoHSIUbwnWR2THBV+TdrDJuhk4vSLJwbIHEXILn3zICM3Ih4Ti0PNFeu+VqOx5BYcs
         hrA5g8bmnxAWJeV0OcFyENNssu6fne7MVN0bXLT8YJlmB6C6QRb9Zl5EDDRcWHiiJdRU
         eJWXzDohh5BpN8pX4riagff4UeaTcVLKafxYbIIyx0KnOIepIXz75sXKj7OfJH6ECRNJ
         d1TEXz3lrYVhTBVIfpBHO/vl9ly5nN+3CTwmC7WgiXjvmR7dpElZfVpqzBtJMghBKpyU
         KJcuYtUEFs3UWXfMoMa1dqReSHG4QZlYe9g7CnNBzkK8BUT//+4xOHxPNF+IWdkJ73vy
         To5Q==
X-Gm-Message-State: AOAM5318fLNva3SjYo7cziinznbIUaSJbVq3HoFxhrHgNkgYgY7Jvdot
        425L0DnBZMc3djRWJmayJTZVY/7iiWA=
X-Google-Smtp-Source: ABdhPJx/T0So/ozQ3dUvMaWs+/kR1qIb+BjxlMenrToFic6gbbGwW/9Zwqfex62wrqNdcqaJoQqNPQ==
X-Received: by 2002:a17:906:7842:: with SMTP id p2mr5003301ejm.87.1619794636894;
        Fri, 30 Apr 2021 07:57:16 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id f30sm2109977ejl.62.2021.04.30.07.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:16 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 06/43] staging: rtl8723bs: remove empty header file
Date:   Fri, 30 Apr 2021 16:56:28 +0200
Message-Id: <5f38543b96f491cf9a11bb8cda17e5be754a3636.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
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

