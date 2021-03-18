Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3FA3408D7
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 16:27:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbhCRP10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 11:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231835AbhCRP1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 11:27:08 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCE8C06174A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:08 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id m20-20020a7bcb940000b029010cab7e5a9fso5657887wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 08:27:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XHTDPddOoVLkUdJc2DU5agYlYSsR4ub1kogsH0wzRWA=;
        b=nGEOKR3XKt81VREQbES5zSHFnUF5ZuJEknl3hd3pGMjBGpVS3XdO8DyBVz/a3dar49
         lUoqJu087XxPOJNqJ8dvnSpB3Eit/KT7zGCH/zloovrqYLb+lPAcyW+0yg1zRwckLdnq
         50OoTndSHiA53QYDX27KoFvYhaGlG/YP4NS+89AsGOImK9I+TGsLyQlDlJC+brGI/mLI
         twSILbR+aHRXvp4Wj/Of3lgbSpVx444zo2bGcP6VcIW4gWNnI4xFgqULuRiUBN5+QTfJ
         BzMhhIOaL1mj+VQnEc7aUN/IZQOO8XeZzrEY+hkGKb1H5j51gxIzvyllpV4SAsE1TqG2
         LS9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XHTDPddOoVLkUdJc2DU5agYlYSsR4ub1kogsH0wzRWA=;
        b=rcbGiDDm+ZuxBfeRU3BLMHrJAP70khx/j92qLR3u1C6U9sbrEjogOteOSOv1r1j5Th
         oXw8gLSpupUl0kRgoKvJgt1qfrbnc5+VLIfyJa+Dy61IkZQWhUJ17crdbZPiInXmc78Y
         OVh4RFgCq9dYLQFMj4WnmFz3egFqL/LD1k/r+8DT2+2+yXFllRkZdHvZjEOj7NHgtNui
         s3CUYJLyHkisbUOfgcRKtVzv4EX3VDv6iMb9WuiK7TS+wKWRF/r2cAMDD+8YsifZFyFN
         SReaSgU5BSi1p3IfAPBYa8P3OQA+I7ct+onkBBwDPM4xMwC/mbx8Wg9jzl19PfjO50F/
         w6fw==
X-Gm-Message-State: AOAM5317J65P7bPWNvRTCJ1Rp4Kgpuz3Rz1m6i9N/HHFkXl2Bvn1eWrJ
        Re2DOCsvN3Rkx4jPatLz0Ph1UTEqxYqZbA==
X-Google-Smtp-Source: ABdhPJx6nCxW5YL/wm7YGE9DpNb95A1n+CSOex7Q8mqj8znldYeJ7KUCWxavST3g3kay4wTLc93CHA==
X-Received: by 2002:a1c:a7d3:: with SMTP id q202mr4128873wme.93.1616081227052;
        Thu, 18 Mar 2021 08:27:07 -0700 (PDT)
Received: from agape ([151.46.162.59])
        by smtp.gmail.com with ESMTPSA id j30sm3855479wrj.62.2021.03.18.08.27.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Mar 2021 08:27:06 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Fabio Aiuto <fabioaiuto83@gmail.com>
Subject: [PATCH 09/15] staging: rtl8723bs: remove unnecessary logging in hal/odm_debug.h
Date:   Thu, 18 Mar 2021 16:26:04 +0100
Message-Id: <20210318152610.16758-10-fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210318152610.16758-1-fabioaiuto83@gmail.com>
References: <YFMb+7jjmj7Oty8B@kroah.com>
 <20210318152610.16758-1-fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following checkpatch.pl issues:

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
134: FILE: drivers/staging/rtl8723bs/hal/odm_debug.h:134:
+#define ODM_dbg_enter() { DbgPrint("==> %s\n", __func__); }
--
WARNING: Unnecessary ftrace-like logging - prefer using ftrace
135: FILE: drivers/staging/rtl8723bs/hal/odm_debug.h:135:
+#define ODM_dbg_exit() { DbgPrint("<== %s\n", __func__); }

and removed containing unused macros

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 22f0e37456e2..f2b2e169a6ac 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -131,8 +131,6 @@
 			ASSERT(false);\
 		} \
 	} while (0)
-#define ODM_dbg_enter() { DbgPrint("==> %s\n", __func__); }
-#define ODM_dbg_exit() { DbgPrint("<== %s\n", __func__); }
 #define ODM_dbg_trace(str) { DbgPrint("%s:%s\n", __func__, str); }
 
 #define ODM_PRINT_ADDR(pDM_Odm, comp, level, title_str, ptr)\
-- 
2.20.1

