Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F33F369565
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243054AbhDWPBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243167AbhDWPAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 11:00:14 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A40CC061350
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:31 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id x7so48673827wrw.10
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0TBgmlQX5j7/Q4T3HKXp2yybKM0tyr8DeALWegqbME4=;
        b=dqhvI9nnqy1hbsqBBtjaq0ArNtfqvWIlv0sVmgOdiW8ES5u/rl5wnnHQaQsnB1BcZb
         W3ZL1CVagrjYbCl2ScdQ2l4ova2TDRpRm8ttOKJMCO/MgXlguZo5cJV9BvH30k9bmran
         +Gr4rnDQejlot512la8hQD95ZrCy6Hcde52pDTTGpAB0qASOn/YFGasIDt4DqjMaNkAs
         p8wyXg2flq+S0lCUkXN5eJ7fuPwcVmpSRHsyqhJE0HkzozPYrlPHHNKWj7AU692nQvxG
         KCa5/ij7fC07A0YbntQUPujY8iZtfXnYhAXV58HmBzgiHh1IL7PrrWPmBihNjKbCwtdq
         995g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TBgmlQX5j7/Q4T3HKXp2yybKM0tyr8DeALWegqbME4=;
        b=Vll5m0lCaE2MKaDHPX0v97aqdca2osFp/C9sX7F4lyKTAuFQIuAX8AHDV4QVDiGq8K
         n1mXrRVaS1L/ilhNj9MjrFF2SLnptJVwZDTv7ZVnayycFP5WzA5g8rsYX2DFewpGc4vs
         72muhgItJU0GEV7TMIrZQTAJv8PNHf2ksJF4+Ey1gCQ0V4HvoRNy/Vl6w9CJHS5Lahvg
         XByU545+k+o3WC5tSPpAJwA8cGxZQ4XR/lSbA8fDW4rlCpVqcCjfPD7Wp/wPpYyu9zbX
         ESZmeT5wTKrNNW1UgzDktW+6Pjx0wztmVVuOKgPYX0x1hjLuNZuGzdRLGsdkzl/pV7XI
         rVuw==
X-Gm-Message-State: AOAM530Qym4MIHHyGWKuPLRmiVFK5RbpOJr2DYrt1XDcDiTRKSEsOG04
        9a4yBky3p4mzJDyYvTIp5CN69wOmGUw=
X-Google-Smtp-Source: ABdhPJxUKftQQYSxvsy0BAFq9GCJIbwrptTqjydvAJJ7z9LJ88GX0BwFoihKdRQHSb/SLdD4lS5YSw==
X-Received: by 2002:a5d:66cd:: with SMTP id k13mr5290056wrw.387.1619189969626;
        Fri, 23 Apr 2021 07:59:29 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id e10sm9464383wrw.20.2021.04.23.07.59.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:29 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 29/49] staging: rtl8723bs: remove debug macros related to hal/hal_intf.c tracing
Date:   Fri, 23 Apr 2021 16:58:20 +0200
Message-Id: <aa3d08bd65faf97676f7af6d46c47155a66fe347.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to hal/hal_intf.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/hal_intf.c      | 3 ---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/hal_intf.c b/drivers/staging/rtl8723bs/hal/hal_intf.c
index 8dc4dd8c6d4c..4868a69cdb8f 100644
--- a/drivers/staging/rtl8723bs/hal/hal_intf.c
+++ b/drivers/staging/rtl8723bs/hal/hal_intf.c
@@ -4,9 +4,6 @@
  * Copyright(c) 2007 - 2012 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-
-#define _HAL_INTF_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 #include <hal_data.h>
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 8a4ee840434e..4da881e3a0c0 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_hal_init_c_		BIT(14)
 #define _module_hci_hal_init_c_		BIT(15)
 #define _module_rtl871x_ioctl_c_		BIT(16)
 #define _module_rtl871x_ioctl_set_c_		BIT(17)
@@ -29,9 +28,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _HAL_INTF_C_
-	#define	_MODULE_DEFINE_	_module_hal_init_c_
-#elif (defined _HCI_HAL_INIT_C_) || (defined _SDIO_HALINIT_C_)
+#if (defined _HCI_HAL_INIT_C_) || (defined _SDIO_HALINIT_C_)
 	#define	_MODULE_DEFINE_	_module_hci_hal_init_c_
 #elif defined _RTL871X_IOCTL_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_c_
-- 
2.20.1

