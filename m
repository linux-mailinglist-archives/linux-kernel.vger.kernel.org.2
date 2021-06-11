Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9783A38AA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Jun 2021 02:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbhFKA1e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Jun 2021 20:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231421AbhFKA1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Jun 2021 20:27:32 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A5DAC0613A2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:25:16 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r9so4115348wrz.10
        for <linux-kernel@vger.kernel.org>; Thu, 10 Jun 2021 17:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uj6zxxcZkeKHjtwD505V5xcj+v/aiATR1kOB3b2LnBg=;
        b=VIu2LfcUjC8C1LxXZi86Eu5CKW9N7IckFWoLszBNNbSMgCtLsJOdWKwhi0JauOh9gu
         nj/xNqrWu5tzmCzYlkEEW6I5kWngBEl1Juei9zRNDgm4GyzCAVCJNuiBKWZLZNUfKMcD
         1f+xJl4P+5ZPrRbbF0CTO2xtRrPutj/zAhNZ5YaIL8G53UQOtXCX70zgGm7GKtVa0RiX
         WTk8EWXPYm272a3yrgIEgt4PxB45pfceN4DOqnqLI7ujj3CmFPWmUCsWfqD77dNaWRtP
         ZaDtSm55Wbz2Auv3FFerpYRJ9NlFbUm9w3D3gHV5HnknZC0si0rP3rw6tmJpnSpICE3E
         S1Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uj6zxxcZkeKHjtwD505V5xcj+v/aiATR1kOB3b2LnBg=;
        b=fd4zWGcDtjbaBTn4/7+S5w/4dRYgHQmsEPHPBnh4dJBYY+RUY+UfQ/NuwxCVye8RDB
         QBA1TRia90cw9nwbf547dhRU5zSZWULqgk51ZUkEE/NhZo7SSIQ0BXFQel+XcUB0zIKW
         qhUq00g231FGY5jCk76fl5wSxhif1Idqm0hWm/8NajMdeAIRZyVl/AW3KHb334B/+M0A
         Fweja+a5O7oLFp3EE1PjvB5VKu0phZLkFgjTe+Hf2B8t+2d7rUucjPFS5kC4b3yaFHXt
         iurU/sOXOPqmbKeg0mDeZB/OQIx0HDm0a13A50dPiF07HLV2PZ2HjMk+Zv2ETR018AHZ
         OguQ==
X-Gm-Message-State: AOAM530EtHtj1ZfNj+1MUdlqTSSDfVNUOtTmR4QcFLzEvTz2S1A1/raE
        HH9c2iGi/brQ1vlfGLK35rkVbg==
X-Google-Smtp-Source: ABdhPJwNbmivXMjTHNVauHu69n+AjQ1nnDItlkNu55v/tCRdpdypOwIWgQo/Vs/E3pfnmwVKbZoxXA==
X-Received: by 2002:adf:ed8d:: with SMTP id c13mr985563wro.164.1623371114479;
        Thu, 10 Jun 2021 17:25:14 -0700 (PDT)
Received: from localhost.localdomain (2.0.5.1.1.6.3.8.5.c.c.3.f.b.d.3.0.0.0.0.6.1.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:df16:0:3dbf:3cc5:8361:1502])
        by smtp.gmail.com with ESMTPSA id c2sm11386189wmf.24.2021.06.10.17.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jun 2021 17:25:14 -0700 (PDT)
From:   Phillip Potter <phil@philpotter.co.uk>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, straube.linux@gmail.com,
        kaixuxia@tencent.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, liushixin2@huawei.com,
        unixbhaskar@gmail.com, gustavoars@kernel.org, martin@kaiser.cx,
        bkkarthik@pesu.pes.edu, dan.carpenter@oracle.com
Subject: [PATCH 6/6] staging: rtl8188eu: remove include/odm_debug.h
Date:   Fri, 11 Jun 2021 01:25:04 +0100
Message-Id: <20210611002504.166405-7-phil@philpotter.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210611002504.166405-6-phil@philpotter.co.uk>
References: <20210611002504.166405-1-phil@philpotter.co.uk>
 <20210611002504.166405-2-phil@philpotter.co.uk>
 <20210611002504.166405-3-phil@philpotter.co.uk>
 <20210611002504.166405-4-phil@philpotter.co.uk>
 <20210611002504.166405-5-phil@philpotter.co.uk>
 <20210611002504.166405-6-phil@philpotter.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove include/odm_debug.h header, and its inclusion within
include/odm_precomp.h, as there are now no users of it.

Signed-off-by: Phillip Potter <phil@philpotter.co.uk>
---
 drivers/staging/rtl8188eu/include/odm_debug.h | 83 -------------------
 .../staging/rtl8188eu/include/odm_precomp.h   |  1 -
 2 files changed, 84 deletions(-)
 delete mode 100644 drivers/staging/rtl8188eu/include/odm_debug.h

diff --git a/drivers/staging/rtl8188eu/include/odm_debug.h b/drivers/staging/rtl8188eu/include/odm_debug.h
deleted file mode 100644
index 3c576a029c94..000000000000
--- a/drivers/staging/rtl8188eu/include/odm_debug.h
+++ /dev/null
@@ -1,83 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/******************************************************************************
- *
- * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
- *
- ******************************************************************************/
-
-#ifndef	__ODM_DBG_H__
-#define __ODM_DBG_H__
-
-/*  */
-/*	Define the debug levels */
-/*  */
-/*	1. DBG_TRACE and DBG_LOUD are used for normal cases. */
-/*	They can help SW engineer to develop or trace states changed */
-/*	and also help HW enginner to trace every operation to and from HW, */
-/*	e.g IO, Tx, Rx. */
-/*  */
-/*	2. DBG_WARNNING and DBG_SERIOUS are used for unusual or error cases, */
-/*	which help us to debug SW or HW. */
-
-/*	Never used in a call to ODM_RT_TRACE()! */
-#define ODM_DBG_OFF				1
-
-/*	Fatal bug. */
-/*	For example, Tx/Rx/IO locked up, OS hangs, memory access violation, */
-/*	resource allocation failed, unexpected HW behavior, HW BUG and so on. */
-#define ODM_DBG_SERIOUS				2
-
-/*	Abnormal, rare, or unexpected cases. */
-/*	For example, IRP/Packet/OID canceled, device suprisely unremoved and so on. */
-#define ODM_DBG_WARNING				3
-
-/*	Normal case with useful information about current SW or HW state. */
-/*	For example, Tx/Rx descriptor to fill, Tx/Rx descr. completed status, */
-/*	SW protocol state change, dynamic mechanism state change and so on. */
-/*  */
-#define ODM_DBG_LOUD					4
-
-/*	Normal case with detail execution flow or information. */
-#define ODM_DBG_TRACE					5
-
-/*  Define the tracing components */
-/* BB Functions */
-#define ODM_COMP_DIG					BIT(0)
-#define ODM_COMP_RA_MASK				BIT(1)
-#define ODM_COMP_DYNAMIC_TXPWR				BIT(2)
-#define ODM_COMP_FA_CNT					BIT(3)
-#define ODM_COMP_RSSI_MONITOR				BIT(4)
-#define ODM_COMP_CCK_PD					BIT(5)
-#define ODM_COMP_ANT_DIV				BIT(6)
-#define ODM_COMP_PWR_SAVE				BIT(7)
-#define ODM_COMP_PWR_TRA				BIT(8)
-#define ODM_COMP_RATE_ADAPTIVE				BIT(9)
-#define ODM_COMP_PATH_DIV				BIT(10)
-#define ODM_COMP_PSD					BIT(11)
-#define ODM_COMP_DYNAMIC_PRICCA				BIT(12)
-#define ODM_COMP_RXHP					BIT(13)
-/* MAC Functions */
-#define ODM_COMP_EDCA_TURBO				BIT(16)
-#define ODM_COMP_EARLY_MODE				BIT(17)
-/* RF Functions */
-#define ODM_COMP_TX_PWR_TRACK				BIT(24)
-#define ODM_COMP_RX_GAIN_TRACK				BIT(25)
-#define ODM_COMP_CALIBRATION				BIT(26)
-/* Common Functions */
-#define ODM_COMP_COMMON					BIT(30)
-#define ODM_COMP_INIT					BIT(31)
-
-/*------------------------Export Marco Definition---------------------------*/
-#define RT_PRINTK(fmt, args...)				\
-	pr_info("%s(): " fmt, __func__, ## args);
-
-#define ODM_RT_TRACE(pDM_Odm, comp, level, fmt)				\
-	if (((comp) & pDM_Odm->DebugComponents) &&			\
-	    (level <= pDM_Odm->DebugLevel)) {				\
-		pr_info("[ODM-8188E] ");				\
-		RT_PRINTK fmt;						\
-	}
-
-void ODM_InitDebugSetting(struct odm_dm_struct *pDM_Odm);
-
-#endif	/*  __ODM_DBG_H__ */
diff --git a/drivers/staging/rtl8188eu/include/odm_precomp.h b/drivers/staging/rtl8188eu/include/odm_precomp.h
index ef1afc83f9ac..eb2b8b613aad 100644
--- a/drivers/staging/rtl8188eu/include/odm_precomp.h
+++ b/drivers/staging/rtl8188eu/include/odm_precomp.h
@@ -23,7 +23,6 @@
 
 #include "odm.h"
 #include "odm_hwconfig.h"
-#include "odm_debug.h"
 #include "phydm_regdefine11n.h"
 
 #include "hal8188e_rate_adaptive.h" /* for RA,Power training */
-- 
2.30.2

