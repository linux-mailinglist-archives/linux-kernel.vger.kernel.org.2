Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25EF36FD26
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbhD3PAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 11:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbhD3O73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:59:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AFFC061349
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:18 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id d14so19169126edc.12
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOZa0FsLTNmXREG+LfKtNmgMKRo0KsphLPysLx3lCcw=;
        b=ubCAOAEEJdRw5h0zbivJpkjZsXqxXas6RrV0r86vmVy+Xy7GHqCSlApZZh0TZHylOF
         iwAntHEitG2LGoy9TmE4q3/1lVrTLUItFyHB5avw/uAzgpK2opAZmcD1r/yNu2KzPaBT
         482Va8Q6yH63L0+0RSXxLtbKu7MPdhYe6dIqqTAiEKvVxmjjoHm3P4oWoUJ2CZY8+LKT
         tcaRaRbP5dLaTuMcRU7CMZCyBMd04e6B5pQRBEOtvc3uEslZMSLqOFwRHPbp/+R4oayh
         4R2wnL3V/koLo5Gk4MOQtiIEnEjttsVuWWUmWf4lBYYNDqwVVpb9KRrlLxhJXKeDT8Uh
         Y+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOZa0FsLTNmXREG+LfKtNmgMKRo0KsphLPysLx3lCcw=;
        b=idnGpuqfP7YOcdba0lUurgh5XPD55zWtdgoEYMy2LU21oGbIPCuh0hSqL6ZBVH4f4Y
         IT7EA6npKaEa/cz8u6SbNCZW+UpUUN8DQ1tG0Q9fxyqoQsTG8F6YznGhaXkcLE2bhhxH
         MdN+BHp0IqgpZWLnE9vpJbBMizkZ9973erBuIsHo5F9zc0StnVTfLJ5x9oo3i4T9KxYV
         LkzC9dYNi0CU/ub539mTtC6OsKTbQtli6m64CpNnwt5xyLH6y4NULUqX+ftBKNA7hK0d
         BEnsO77hJOFRDfNh4biDmOnJCMWDPQcrbeeAvvs7xnoWIMbv3W8YHyHgnjHpIR4D2JXy
         epVg==
X-Gm-Message-State: AOAM530hkl2PtQyyvmbLewSCXkMssScTREQ9XwCzV7oaahhkpM3s98WR
        n13Q6hWIcRqJVDZzAERt0RYQItAwr2Q=
X-Google-Smtp-Source: ABdhPJxnBC9iko7os4+FU3MWsxpLXwKpFDJ1XEVXHO42xA6XRDNw8s1deLd0qoWZj6LC5yaZLnlo7w==
X-Received: by 2002:a05:6402:35d3:: with SMTP id z19mr6445012edc.143.1619794696803;
        Fri, 30 Apr 2021 07:58:16 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id r19sm2091358ejr.55.2021.04.30.07.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:58:16 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 43/43] staging: rtl8723bs: remove odm_debug.h header file
Date:   Fri, 30 Apr 2021 16:57:05 +0200
Message-Id: <58f3ed0c7706fdb33614d3e38ed802d56d77f0ec.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove obsolete odm_debug.h header file.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h   | 88 ---------------------
 drivers/staging/rtl8723bs/hal/odm_precomp.h |  1 -
 2 files changed, 89 deletions(-)
 delete mode 100644 drivers/staging/rtl8723bs/hal/odm_debug.h

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
deleted file mode 100644
index 94011343f7e7..000000000000
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ /dev/null
@@ -1,88 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-
-#ifndef __ODM_DBG_H__
-#define __ODM_DBG_H__
-
-
-/*  */
-/* Define the debug levels */
-/*  */
-/* 1.	DBG_TRACE and DBG_LOUD are used for normal cases. */
-/* So that, they can help SW engineer to developed or trace states changed */
-/* and also help HW enginner to trace every operation to and from HW, */
-/* e.g IO, Tx, Rx. */
-/*  */
-/* 2.	DBG_WARNNING and DBG_SERIOUS are used for unusual or error cases, */
-/* which help us to debug SW or HW. */
-/*  */
-/*  */
-/*  */
-/* Never used in a call to ODM_RT_TRACE()! */
-/*  */
-#define ODM_DBG_OFF					1
-
-/*  */
-/* Fatal bug. */
-/* For example, Tx/Rx/IO locked up, OS hangs, memory access violation, */
-/* resource allocation failed, unexpected HW behavior, HW BUG and so on. */
-/*  */
-#define ODM_DBG_SERIOUS				2
-
-/*  */
-/* Abnormal, rare, or unexpected cases. */
-/* For example, */
-/* IRP/Packet/OID canceled, */
-/* device suprisely unremoved and so on. */
-/*  */
-#define ODM_DBG_WARNING				3
-
-/*  */
-/* Normal case with useful information about current SW or HW state. */
-/* For example, Tx/Rx descriptor to fill, Tx/Rx descriptor completed status, */
-/* SW protocol state change, dynamic mechanism state change and so on. */
-/*  */
-#define ODM_DBG_LOUD				4
-
-/*  */
-/* Normal case with detail execution flow or information. */
-/*  */
-#define ODM_DBG_TRACE				5
-
-/*  */
-/*  Define the tracing components */
-/*  */
-/*  */
-/* BB Functions */
-#define ODM_COMP_DIG				BIT0
-#define ODM_COMP_RA_MASK			BIT1
-#define ODM_COMP_DYNAMIC_TXPWR		BIT2
-#define ODM_COMP_FA_CNT				BIT3
-#define ODM_COMP_RSSI_MONITOR		BIT4
-#define ODM_COMP_CCK_PD				BIT5
-#define ODM_COMP_ANT_DIV			BIT6
-#define ODM_COMP_PWR_SAVE			BIT7
-#define ODM_COMP_PWR_TRAIN			BIT8
-#define ODM_COMP_RATE_ADAPTIVE		BIT9
-#define ODM_COMP_PATH_DIV			BIT10
-#define ODM_COMP_PSD				BIT11
-#define ODM_COMP_DYNAMIC_PRICCA		BIT12
-#define ODM_COMP_RXHP				BIT13
-#define ODM_COMP_MP					BIT14
-#define ODM_COMP_CFO_TRACKING		BIT15
-/* MAC Functions */
-#define ODM_COMP_EDCA_TURBO			BIT16
-#define ODM_COMP_EARLY_MODE			BIT17
-/* RF Functions */
-#define ODM_COMP_TX_PWR_TRACK		BIT24
-#define ODM_COMP_RX_GAIN_TRACK		BIT25
-#define ODM_COMP_CALIBRATION		BIT26
-/* Common Functions */
-#define ODM_COMP_COMMON				BIT30
-#define ODM_COMP_INIT				BIT31
-
-#endif	/*  __ODM_DBG_H__ */
diff --git a/drivers/staging/rtl8723bs/hal/odm_precomp.h b/drivers/staging/rtl8723bs/hal/odm_precomp.h
index 440a549bffc7..5041c9535e9a 100644
--- a/drivers/staging/rtl8723bs/hal/odm_precomp.h
+++ b/drivers/staging/rtl8723bs/hal/odm_precomp.h
@@ -27,7 +27,6 @@
 
 #include "odm.h"
 #include "odm_HWConfig.h"
-#include "odm_debug.h"
 #include "odm_RegDefine11N.h"
 #include "odm_EdcaTurboCheck.h"
 #include "odm_DIG.h"
-- 
2.20.1

