Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E188336FCB6
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 16:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233585AbhD3Opg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbhD3OpV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:45:21 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB87C061346
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id w3so105674547ejc.4
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkTXw+UrM2wYCxNZsOy4gcxyM1XqC056VTNVEgdSP/k=;
        b=lvkXXjVYtfZ+PtvyuU/0QoT4J4q556JpH9BCSFSKiljg7KR2559/elzxcOXGVwaSMx
         GlD9E/h1KkKVnGMRlJtTESqzJXlaRkymoLlxJ3LBk3FS54Y9sq8ZHWGGqc3cu7Zn6Vyx
         RZYoP0zdEVdpwg3OGHuCPwzLb5XHsH5U0kf/5LVX7T7IvJtZOXWhIiSufHXbi3XfGRcY
         1b/q6NDCsBUTAG1NsyTQm4FmlufFUPTNK0dsBfAqK5KTwc4m/gVtS5Z4f9ZZYMbFCAdX
         jEFKX8X+LohI3Q31wf0eO6zRRgsI0uJOSPSWIhqM07bYtmJoUdWGgbeyGAjKvd0SyPOj
         CkaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkTXw+UrM2wYCxNZsOy4gcxyM1XqC056VTNVEgdSP/k=;
        b=OqeAypFwjJNUDp+J5aIlbTlMM/S5v4z2PwSXc6HnuoqoeN0iI5n9KMPMHrBtx6KYvp
         oHqWRZHAMIb64ixh3fOyPv4err/gikN8z08npzdPuCNF9+el8aOE2MIiYfcdhVR1BF08
         k/OvG6F98HwQgNXxDkpzR+LsJXF9/e6XhINjoRgPIgH80ad8DMU6LH8SonGqC68ikrMH
         qKxl5Z2nZps/hcPo/SSMCMR9gCTxK4pwFvc0tpizt8FWh8Jyu9NMfaMuxpl8YLI6ZrdC
         4FYFm31A2HnGdSWecTSWvIVXm7IXF1dQ6KODM/Pas+NusfnNhTYClWHJYd4KQT4D6T0N
         Zifg==
X-Gm-Message-State: AOAM533bNYTYcia4unTOQGGj8SmpZTAr31gC1su8K779OLd8JtHPScDt
        8o6Od2Qxv4Wd8A8S7K2Z/+AuU9VZUGA=
X-Google-Smtp-Source: ABdhPJwqJKv5kPajBjtoMKuMpJse68jKy5z9XWTVF2oCRm1mYmN4rN4jGTweHZoMBnRMHC7dAUj6xw==
X-Received: by 2002:a17:906:3ec1:: with SMTP id d1mr4818766ejj.523.1619793869911;
        Fri, 30 Apr 2021 07:44:29 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id o13sm2084409ejx.86.2021.04.30.07.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:44:29 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 10/43] staging: rtl8723bs: remove unused ODM_RT_ASSERT macro
Date:   Fri, 30 Apr 2021 16:43:40 +0200
Message-Id: <5e31ee70c4be243ccf92d92ad123d4f348acd5cc.1619793405.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619793405.git.fabioaiuto83@gmail.com>
References: <cover.1619793405.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused ODM_RT_ASSERT macro declarations.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/hal/odm_debug.h | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/staging/rtl8723bs/hal/odm_debug.h b/drivers/staging/rtl8723bs/hal/odm_debug.h
index 09e8bfec7664..b4fc247242fe 100644
--- a/drivers/staging/rtl8723bs/hal/odm_debug.h
+++ b/drivers/staging/rtl8723bs/hal/odm_debug.h
@@ -96,20 +96,6 @@
 #endif
 
 #if DBG
-#define ODM_RT_ASSERT(pDM_Odm, expr, fmt)\
-	do {\
-		if (!expr) {\
-			DbgPrint("Assertion failed! %s at ......\n", #expr);\
-			DbgPrint(\
-				"      ......%s,%s, line =%d\n",\
-				__FILE__,\
-				__func__,\
-				__LINE__\
-			);\
-			RT_PRINTK fmt;\
-			ASSERT(false);\
-		} \
-	} while (0)
 #define ODM_dbg_trace(str) { DbgPrint("%s:%s\n", __func__, str); }
 
 #define ODM_PRINT_ADDR(pDM_Odm, comp, level, title_str, ptr)\
@@ -129,7 +115,6 @@
 		} \
 	} while (0)
 #else
-#define ODM_RT_ASSERT(pDM_Odm, expr, fmt)		no_printk fmt
 #define ODM_dbg_enter()					do {} while (0)
 #define ODM_dbg_exit()					do {} while (0)
 #define ODM_dbg_trace(str)				no_printk("%s", str)
-- 
2.20.1

