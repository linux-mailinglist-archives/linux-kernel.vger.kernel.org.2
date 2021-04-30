Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29C936FD03
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Apr 2021 17:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbhD3O63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Apr 2021 10:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbhD3O6Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Apr 2021 10:58:16 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15234C061343
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:25 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id zg3so24103589ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 30 Apr 2021 07:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EkTXw+UrM2wYCxNZsOy4gcxyM1XqC056VTNVEgdSP/k=;
        b=X5QnQ04dxENC/9z7tTKzI0IbZbHdHArKrQ0Ks6NiStIML8kju0MVmGe44k7Tb6fzQY
         fb1qpf5NWvIUJse8ZfEamIqIG6vHB3qQVb8xOaKc6YNygRb/EQdobgTB+VltHxgTy0sC
         SbrBiTC1U4PCW1SVEF/DxLNP0M1UuV782/mQIDDM75W6M9nloonjhaOavtMDn7ddS0qr
         Dx4gCy2zbGgMRQ4HsgfBoJy0LoyZTL/k541+sfAmR40rxtW57rFiJsh2SxaCx1kumoDR
         gfoYNlO2bhukt/sSk+yUtHDTWIyNgcWG5dJDdmxQ9GecotIYoof4EB6l3wdD+EW/4W6F
         zf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EkTXw+UrM2wYCxNZsOy4gcxyM1XqC056VTNVEgdSP/k=;
        b=thuArd11DldQMe58pwG2rRtpoGkWkqXD3JbMBDg5mORlsZlGf4Yrjpa6GoKVCDh9aN
         MoxDEelZP4/9Swgb65qPrGPEe6mZtqaQUMed+sd2RvOZISvr5M+QzN00lq94siCEXfGN
         PlsASe3IFptfdAV7Imt51WbdcmEhNSz3Eqz+eXzscg1kKOSPghd/NF1FgIBDhct5Wbgf
         HxfoeLjBOqHQEKuPCc4uUqXTGE2t0rzd0TfxowT21iw9hIIOjz8SB3eCIzAUV9aY2z37
         vMTMPNuXJKDnUbRcQ4w6hz62mX7NOgzrjvP63Qhedn8IC3Mffkt0KFaQAVElYNxcSJw9
         Eo6Q==
X-Gm-Message-State: AOAM533JXvxhfW9tU3lIYMZ3Gn83Ai/c7zabINPK+G93vIJWv2STNOjf
        TeRWAdaoBGovUiCWe1us2rJUPc7WNbY=
X-Google-Smtp-Source: ABdhPJyVEwtVXoXqxZYwzK6RL7nlFaENTyDhGG7jrbisQylq+WGn3fvprsRJOGQmL/SYCHuU83LQ0Q==
X-Received: by 2002:a17:907:2cc2:: with SMTP id hg2mr4614544ejc.62.1619794643347;
        Fri, 30 Apr 2021 07:57:23 -0700 (PDT)
Received: from agape ([109.52.244.36])
        by smtp.gmail.com with ESMTPSA id eb9sm2065310ejc.96.2021.04.30.07.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 07:57:22 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/43] staging: rtl8723bs: remove unused ODM_RT_ASSERT macro
Date:   Fri, 30 Apr 2021 16:56:32 +0200
Message-Id: <4d9fd27f60d1ef4bf8384d411885d05c6d40768e.1619794331.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619794331.git.fabioaiuto83@gmail.com>
References: <cover.1619794331.git.fabioaiuto83@gmail.com>
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

