Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C65636F6AA
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 09:48:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbhD3Hrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 03:47:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbhD3HqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 03:46:06 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2E7C06134D
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:19 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id i3so55808330edt.1
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 00:45:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOZa0FsLTNmXREG+LfKtNmgMKRo0KsphLPysLx3lCcw=;
        b=KqHuyebzBPX8Q1EmBcM+/0HAfjIwC5HLFaGtMUKD6rmcFh70RawmBPW+Jn/kZAH4IZ
         tnPQzztUe8zhWVzdf3eClydsajMxC/s9nfsk4ofxzrCTZV4rXkr+5S3RLS06YxQVOaee
         5fJDJib9ywPgG669J4NihGEaMJLk/lCebvo4tTgFQ1ISUKM8FNKfgTjfF4yd6N1iCTQT
         QcOlkXVQCqXj/I9V9iRUH/SkLjc+GVEpMi/9CrMNforIq1ZrDTQTnnjVsuLz4oo2LT4p
         +poQU8W/qrNJSJrW5xkztQMInKqb2oVaS+avDwVCWB8lf58lvqFNdF5BkYrV2YIo9YlW
         GYrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOZa0FsLTNmXREG+LfKtNmgMKRo0KsphLPysLx3lCcw=;
        b=XuQVPpbI5r2t5cW79/WT2AmbpvwCwinFlM0zGxaUqsY2rBvy5hjLs1iCR/MZC9g6DP
         H6jnxnTmRK9M1AnmroFj0rBcUM72968ZGUhISl1lg8ZlOtZ5Qyf6iYbntZ34jqn/MC+8
         LNk2S3BbxN/xebw9GRd9N0kKgEblPBOeny3jGfWf6cxIh5Mdc1aM/O1vAKRvpGBwubwD
         GPy9/It8JSm1d91gD53kvTB39hsTlum+1BVw+FNQWWEhX97vUZx1TGqyX62SVNO5dMb7
         xpdBpZT1sETDi+mTScX/trCt9MVzMrEDwhu2QOUnmRYa0JbfNLBQj5JhMwvtaNOHDRRe
         TVgQ==
X-Gm-Message-State: AOAM533ZfkDTvdeZydsIpazFfObxIKHCkTNgydxz3zJTcNN+ESWXckI0
        jve4dzaWMSsMs+acnMWoU/ceOIPC9H5c4g==
X-Google-Smtp-Source: ABdhPJzPkM33ALnbJYAPg8n6krD2GGDvhIM+FofXnsHfaW/rH3pjXtmlC5c18yKXhx1urj+076Zltw==
X-Received: by 2002:a05:6402:10d8:: with SMTP id p24mr4089217edu.337.1619768717634;
        Fri, 30 Apr 2021 00:45:17 -0700 (PDT)
Received: from agape ([5.171.81.86])
        by smtp.gmail.com with ESMTPSA id t15sm643651edr.55.2021.04.30.00.45.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 00:45:17 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 43/43] staging: rtl8723bs: remove odm_debug.h header file
Date:   Fri, 30 Apr 2021 09:44:01 +0200
Message-Id: <5a3088091c7ab8789bdfba2ef3cb86236d330130.1619768150.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619768150.git.fabioaiuto83@gmail.com>
References: <cover.1619768150.git.fabioaiuto83@gmail.com>
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

