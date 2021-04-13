Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 452B735E205
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Apr 2021 16:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244932AbhDMO5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Apr 2021 10:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244150AbhDMO5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Apr 2021 10:57:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FB0C061574
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:56:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id g9so748741wrx.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Apr 2021 07:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XByxU8I0VSid+b/yMvMswXSnRy3WRcAQkZMoMz7IPUE=;
        b=sBsHmGLLkKiPF8RR/fdnmar/PgKLrUUkbINtjtoW25zBRg9tWDwee4Gk6ESJsKfhMU
         avdW3RoT2x/3mk9RfW7Zy/KSPnJC933HrBRBxZqVcKIc+t9urbu7SSUIo2ga/S50LF3v
         GtF/VaIKGpp/n7HiGeMUCE0wlqlz9eCyS3fZjJqhfGIOYhE4m8s3Ponfzj/noGULliEo
         hS2w8zrFVJAigCQMAzhCUd/5qJAOGA3W7+uCKF/uFbHtpszUduHkfohrfYdkIzIzR5ew
         nkuRhUsV9wsM7KqQqNBGl7smintqjXsOz0FhwXyUmCyoPS1mrLrQQ63qSw1RFfW4rfcn
         AYLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XByxU8I0VSid+b/yMvMswXSnRy3WRcAQkZMoMz7IPUE=;
        b=dXVkJ3J6wXj8TaL55pCoU19kT8bWAs7sDuoqMQmRQi/ejIS8NZdjdSPeWLNJXSHoMS
         LnCTSACiZKYGt+kUMj7oR3D8Ah/oQwDwrIQtO5BDT6BD6TDcmjrZLd+8ytBGxUlWr7fN
         cjiEjOe0UV/Fmcp7umOyky+fX6+OO8+yXbEZOh5cGLCghFvtC5MdDuVYZMMxc6TZobsE
         vle6snOE4mApRCsTKP6/LMsAjpVriHMO1xehrfix7bzHjOV3CIG0IY5LglbSpWuploZM
         J4eydHNPd5q85mgB+/OELkzOrrdV30hlki77/yOX00Ua5MZR3HpkpJJHgGBhhj27iVDw
         0cGA==
X-Gm-Message-State: AOAM530I5QuKMa8XgX5sxS00H2C+g3BjFJvm8euRaQSupyxOHTBLm06s
        vUktVHMomIhdZzYO1J8TiPXJ0o8KjnXflw==
X-Google-Smtp-Source: ABdhPJwtAm6v65tnf2gqzGZC8vcNMx0cHNT4IvzAIDHPG9e/baacf2AeZ5Hz0CyCUuhUJuerIHnyBg==
X-Received: by 2002:adf:a294:: with SMTP id s20mr21462232wra.54.1618325801589;
        Tue, 13 Apr 2021 07:56:41 -0700 (PDT)
Received: from agape ([5.171.81.171])
        by smtp.gmail.com with ESMTPSA id d133sm2749168wmf.9.2021.04.13.07.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:56:41 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 3/7] staging: rtl8723bs: remove two unused functions
Date:   Tue, 13 Apr 2021 16:56:31 +0200
Message-Id: <2e8dd88c053735daed95701140b2f03b4cfe2a2e.1618325614.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618325614.git.fabioaiuto83@gmail.com>
References: <cover.1618325614.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove dump_drv_version() and dump_log_level() function
definitions and prototypes. Those functions are unused,
and add unnecessary wrap level to log calls.

They wrap DBG_871X_SEL_NL which will be replaced by
netdev_dbg() with coccinelle script application.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_debug.c    | 10 ----------
 drivers/staging/rtl8723bs/include/rtw_debug.h |  3 ---
 2 files changed, 13 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_debug.c b/drivers/staging/rtl8723bs/core/rtw_debug.c
index d3ee7b7f6fde..324c7e5248f8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_debug.c
+++ b/drivers/staging/rtl8723bs/core/rtw_debug.c
@@ -14,16 +14,6 @@ u32 GlobalDebugLevel = _drv_err_;
 
 #include <rtw_version.h>
 
-void dump_drv_version(void *sel)
-{
-	DBG_871X_SEL_NL(sel, "%s %s\n", "rtl8723bs", DRIVERVERSION);
-}
-
-void dump_log_level(void *sel)
-{
-	DBG_871X_SEL_NL(sel, "log_level:%d\n", GlobalDebugLevel);
-}
-
 void sd_f0_reg_dump(void *sel, struct adapter *adapter)
 {
 	int i;
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 7747e90bd1cc..f1b37d511f27 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -192,9 +192,6 @@
 
 #endif /* defined(_dbgdump) */
 
-void dump_drv_version(void *sel);
-void dump_log_level(void *sel);
-
 void sd_f0_reg_dump(void *sel, struct adapter *adapter);
 
 void mac_reg_dump(void *sel, struct adapter *adapter);
-- 
2.20.1

