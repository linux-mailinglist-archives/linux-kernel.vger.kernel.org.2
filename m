Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD11836A064
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbhDXJGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237175AbhDXJEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:16 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E09C061756
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:37 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e5so22024265wrg.7
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h2ZqN65XK5OLpZsVVr1uV7MpQbBGCFzPUcE3WgPQfd8=;
        b=RwX0OvUgKVkU1HvRZftDzWf02QvjA/1BX+mujfW2ncSPvGJpdL68TBlgENyqtsgW7N
         v4U+TfrOqz+wVGuWL527wRe3FIC7TNLOIksN70eyUIN+Ym6CrA9WrUcBiihD3pyyhLvF
         PJ5wugev0PAqPvzyxxm/lPktzxbv2eDF30cPEmZ1vVMjtxtpw2oYHxxN5HD3SZu9vT5a
         H16dAAxCZTQgGl73kUugD8/nUfrRcigxhYLatiT2S6IoZcbMxwHlSqVtLJDu16pSPt8v
         3cNdiIT/05zN4JeXIjsutY4drpl7WWEB0Cvnq/Qy7CSbacR+RijomQhDae0b30jjCV+N
         9uZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h2ZqN65XK5OLpZsVVr1uV7MpQbBGCFzPUcE3WgPQfd8=;
        b=ZvFXxbYFgRs662NUsX6w2wSHp4ljabeFm+ZIP6MDq0qRpaUW28DE8N5wODTz4TznOl
         FL4gj9MwlMK5riPrUTHoSi0/2TsOYMq9InuSIybT3h5cDKvUubXvBD4bCv9+7+1QPptK
         vKUrXwd7c/KK4w/9CynSgVisry188JB5bixA0gVzdr+vgMMc62RFmzCtTrrvkDvWvAj7
         BVKZYH4PQvvWJM/neyhsU/pJK4ZQBLYmcJOrAz/S1e+kE5Zxt7Ziw9dnJhKm9IXYwrtW
         xPZqB+rOH+HcrtGNHufyM3TBpY+zzB7xqYbBwh5A2uPtq7KzjgolLvLRYDI4++YkIOL5
         ZtCQ==
X-Gm-Message-State: AOAM530O68SILMxs5GorBuUpxcrDxQty50lnMgR8YD3wm4599iIa+991
        5unsLLMfa2Tfv+YQ17tOjxzOR2iAtLdkQw==
X-Google-Smtp-Source: ABdhPJzjNksjeJmrMzaR5htTMru0pZgkE48svY7NVrTFUp2i/pacQFRwK6JGJGYzS1GqwS/sNZeHhQ==
X-Received: by 2002:adf:fb07:: with SMTP id c7mr9808980wrr.88.1619255015908;
        Sat, 24 Apr 2021 02:03:35 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id n16sm1590093wrp.50.2021.04.24.02.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:35 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 36/50] staging: rtl8723bs: remove unused macros tied to core/rtw_pwrctrl.c debug
Date:   Sat, 24 Apr 2021 11:02:19 +0200
Message-Id: <0f746668ec65d6c188ba422778d6edc2b6eb7d91.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused macro definitions tied to
core/rtw_pwrctrl.c debug.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_pwrctrl.c  | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
index 251b9abdf591..a392d5b4caf2 100644
--- a/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
+++ b/drivers/staging/rtl8723bs/core/rtw_pwrctrl.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_PWRCTRL_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <hal_data.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 8e324313ebf9..a7f6827c282f 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -23,9 +23,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTW_PWRCTRL_C_
-	#define	_MODULE_DEFINE_	1
-#elif defined _HCI_INTF_C_
+#if defined _HCI_INTF_C_
 	#define	_MODULE_DEFINE_	_module_hci_intfs_c_
 #elif defined _HCI_OPS_C_
 	#define	_MODULE_DEFINE_	_module_hci_ops_c_
-- 
2.20.1

