Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAF6836A060
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 11:05:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhDXJFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Apr 2021 05:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237403AbhDXJEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Apr 2021 05:04:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98714C061345
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:30 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r7so38682555wrm.1
        for <linux-kernel@vger.kernel.org>; Sat, 24 Apr 2021 02:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=H3UavRC9eYgkj+4cOfjLIrmnA6AzYdpwCwf/ShfW9hQ=;
        b=XEgDLRgZRZayaU+w9go4KUuXejwHt4ngSj/gdCgquH7wNF3Nrm7VxC2NFKHRf5jImv
         0O+OEhinorkuF8NKK3oVsT2/Wl7oqAqOCjhdQsdjo3te8DA1PHK49af2oPEEsMJwFRnC
         VUS9PSyCdAkkPFx/m1vgUxEFOXd/AUmLLacEpVuqUK8uHUylmf9Dah5PG9YI5qNoqGvS
         P5kfqdv5HaKkFD9X53h6NVH1qqs2XPst/5KQRo2T83x3oY9Ia0uYvVDQJNdQmpn33k7S
         kqhN8Cb5Wp6pCZUWWqf5D9H9+Yh3dNdSLXIqQ998EXFvH7c5SxZ/vcRRkYhr2lPjIo3K
         EPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H3UavRC9eYgkj+4cOfjLIrmnA6AzYdpwCwf/ShfW9hQ=;
        b=onVoYX8dzWARm3W+LHW+U5MYDqizmFdduJ1tpo2u1y2hZDz3tRe4DqF4D/EoGfSRJb
         fSlD0lTIcEteKTTFySVnEuq7INdoVSg9fLP7s0aF4dQzQ9AmVKq4DFZZ4IHlDtao8TvB
         hVs5O3vlxIcM8K4FV0JVA+itskTPueR9IN08TRSq4LHzdDbDOXDHSSfRdayPDMwlqpq7
         1c07e8ttW1UWy+caFpqkKpDKZAJOaL7ssXrXqjzlzJwWTp9X4fFzMqW1VQXiFvFyYrSD
         1KDvOcm/8v+Z9eFsnlzI20X2R/wIllFNT72/57dXwbvW/MgOSIVDQSsrZw3RqN4thm9/
         qiRQ==
X-Gm-Message-State: AOAM532GKAV75ONoae3B6Jgt9loPJB1TaLRDF1D1IF9q838A1jf7ZMzB
        FVLKeVSabJLqOOgRrtGZK9570FWXxzq1RQ==
X-Google-Smtp-Source: ABdhPJxmZoFsCzvzeD5LiWto+xbsg88T15gUf7i7yrq7cLhB2AiuFo1ZQCcCltqbO6pQ1Pee2m1AdA==
X-Received: by 2002:a5d:564a:: with SMTP id j10mr9977556wrw.108.1619255009220;
        Sat, 24 Apr 2021 02:03:29 -0700 (PDT)
Received: from agape ([5.171.80.252])
        by smtp.gmail.com with ESMTPSA id b12sm13430800wrn.18.2021.04.24.02.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Apr 2021 02:03:28 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     joe@perches.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 32/50] staging: rtl8723bs: remove unused debug macros tied to _RTL871X_IOCTL_C_ definition
Date:   Sat, 24 Apr 2021 11:02:15 +0200
Message-Id: <216def2b5e244490debe86aafdc23cabc32f3c1e.1619254603.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1619254603.git.fabioaiuto83@gmail.com>
References: <cover.1619254603.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove unused private debug macros tied to
_RTL871X_IOCTL_C_ definition.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index 4146acb1cbb2..501155c8c9cf 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -7,7 +7,6 @@
 #ifndef __RTW_DEBUG_H__
 #define __RTW_DEBUG_H__
 
-#define _module_rtl871x_ioctl_c_		BIT(16)
 #define _module_rtl871x_ioctl_set_c_		BIT(17)
 #define _module_rtl871x_ioctl_query_c_	BIT(18)
 #define _module_rtl871x_pwrctrl_c_			BIT(19)
@@ -27,9 +26,7 @@
 
 #undef _MODULE_DEFINE_
 
-#if defined _RTL871X_IOCTL_C_
-	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_c_
-#elif defined _RTL871X_IOCTL_SET_C_
+#if defined _RTL871X_IOCTL_SET_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_set_c_
 #elif defined _RTL871X_IOCTL_QUERY_C_
 	#define	_MODULE_DEFINE_	_module_rtl871x_ioctl_query_c_
-- 
2.20.1

