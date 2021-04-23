Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3AA36955B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Apr 2021 17:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbhDWPAk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 11:00:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242886AbhDWO75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 10:59:57 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3AEC06134C
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:17 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e7so39730171wrs.11
        for <linux-kernel@vger.kernel.org>; Fri, 23 Apr 2021 07:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iUF9VHzbVOwedrHS/nllSjnFr9sMj9nVtpSdM/jLSwQ=;
        b=ZNFnBbt+uKWhgxr370dwwOTk385HJbpmeBbTrx7JfXT9L5unIKAI6eN9QGIW8/W/Vq
         /26i36WkQOcBBpz/rIsyMYbo297bQEKgjhV6DbeLqkuMqtP3JyKHiOggVZCqZW3uWNO7
         IxdDa30GrEjdd4I/rkFVXSMscfv53kzy1zDELu045mBomixVGV5jo4EGlFluX9jn16LY
         EYI+/Tw9D4EY1Hc7igSg5k365KiPekppuAxNinvQTFD1v6my+jmVA3cQj9/744r2RLH5
         LgrzB9dMdUsrlsmxFjtChDS3fpo7CnZ9u6u+VREz4jQzCo0xTtZ1syEkfInP/Iq59Vdg
         9EtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iUF9VHzbVOwedrHS/nllSjnFr9sMj9nVtpSdM/jLSwQ=;
        b=nYoZkmKYikxxe+dUGx/nGhJxusce9XBh0fS+jtTwQ6PkqL3Nknk9qDU4wv+5pmIcf9
         sAXbWxbSKu5Nvo/PaPI4T8tYV8G/o+AtfdY2WCNsOdiiyzKNkhUTbEJFUqBdS6/AAK/e
         Tro9wzccNexSxnJ2v253p8MxGnCnze+gASw+xeLs29ZK9rEqlpokBVZ0mwAxWaA9WETP
         ZWIvmggRiKghtN3inDr2FDH0tGHEWLff8QVkB1/moGziwDwJJEHKbo5pBMamrwYW8ZwV
         clCxE6K8x1jQnSMNYHPLpq5KLrKCG1OJGWF3et+olOM0lER12R4nk+Lapow+wii20j6u
         8vBw==
X-Gm-Message-State: AOAM530Jcwf6jS6J4Psb7EI2gMooaWMPLR6i2vS8FOpnuBO7RXjeLZJS
        sP/+hhVLLb0DvjStnRP5G2le8/XHBxI=
X-Google-Smtp-Source: ABdhPJylMZVwmZNoykj2Py/sgjTmmcL6pkpXihDsqwBzT85Kr6KV6QZA0SUsM0Pup0TQoFjewkzWPA==
X-Received: by 2002:a5d:400d:: with SMTP id n13mr5196237wrp.372.1619189956200;
        Fri, 23 Apr 2021 07:59:16 -0700 (PDT)
Received: from agape ([5.171.72.99])
        by smtp.gmail.com with ESMTPSA id i15sm9888868wru.12.2021.04.23.07.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 07:59:15 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 21/49] staging: rtl8723bs: remove debug macros related to core/rtw_sta_mgt.c tracing
Date:   Fri, 23 Apr 2021 16:58:12 +0200
Message-Id: <28234444bf984c87bd2f4c535687f5d277fc6c4b.1619189489.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619189489.git.fabioaiuto83@gmail.com>
References: <cover.1619189489.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove debug macro definitions related to core/rtw_sta_mgt.c
obsolete tracing.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_sta_mgt.c  | 2 --
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
index 85663182b388..c056a0ada060 100644
--- a/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
+++ b/drivers/staging/rtl8723bs/core/rtw_sta_mgt.c
@@ -4,8 +4,6 @@
  * Copyright(c) 2007 - 2011 Realtek Corporation. All rights reserved.
  *
  ******************************************************************************/
-#define _RTW_STA_MGT_C_
-
 #include <drv_types.h>
 #include <rtw_debug.h>
 
diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index d51e22ee1328..76756f6aac99 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_sta_mgt_c_		BIT(6)
 #define _module_rtl871x_cmd_c_			BIT(7)
 #define _module_cmd_osdep_c_		BIT(8)
 #define _module_rtl871x_io_c_				BIT(9)
@@ -37,9 +36,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTW_STA_MGT_C_
-	#define _MODULE_DEFINE_	_module_rtl871x_sta_mgt_c_
-#elif defined _RTW_CMD_C_
+#if defined _RTW_CMD_C_
 	#define _MODULE_DEFINE_	_module_rtl871x_cmd_c_
 #elif defined _CMD_OSDEP_C_
 	#define _MODULE_DEFINE_	_module_cmd_osdep_c_
-- 
2.20.1

