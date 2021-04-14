Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69DD535F35F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Apr 2021 14:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350824AbhDNMT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Apr 2021 08:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350804AbhDNMTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Apr 2021 08:19:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B111C061574
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:18:57 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id y204so9103463wmg.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Apr 2021 05:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AzC9o1o0ixYi6KaDWY1ROlCOIjizjCzFaIisDwi93jA=;
        b=aWncd9Qsf6VvUPxeQFIgoPFErkVfocB1tR/M1Q9jn3nHV8M17YJqJ/lEpOnMZt9jtc
         A8JH3dlN8EO33KUR4/Tivl2+/vS+BJ2sRjWGBdasF7BRw4gI5jfGD9XiltgY++VJz1a/
         6zNQB2Dg1f88fUKBkyNReOg7G0E6bhfTZUxiwgmKabo1alJ2K/QdJHw7GQrGuh3CQM4t
         /KcE/XL9uewv2N9VyhM9tIP2ahiACeZfhORxeBiaTH4odvgeU5W7PXsYgrDOyiPp9EJk
         NCQS68ZeWjI9b8uXxDMO9p2y6A0C5OJHGL4XKSiez7Q+tv/EWQ+WE5WEP4Qh5lm+MbGm
         GsJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AzC9o1o0ixYi6KaDWY1ROlCOIjizjCzFaIisDwi93jA=;
        b=tEPSeq0A2WuiDdfiVvH1lekWjxdvyVtrTAErmM3SD/WqjzdIpc1bZPZvFGgKobEE8k
         rsPGeZDQGrbTE0GtF4OY1PkzxBRgMdLHIBSaXEU1HztdGuG0QOEwKTjLm/NKOiHyRFDa
         qWwctlRF4Zxp9QMjPAahNZ38YI6ftt8qf2pJye6Fc8/C5g0+ZUqmcuYV/A1sOmRCrNaK
         n5pU8LSrIeF7nMklJ5fbI7qr6nMXKNVmWNGjHzGSH9Q1qU3mpyRHUT9V1MzEoCHAoQQa
         13jfldIxBYc1/cx8/lrxrYDjiAfK5aSq80bKo4O+GHVahiw3g5AB7ew7cWIybrytauao
         nz2A==
X-Gm-Message-State: AOAM5333cJkVJEhNWJtflVWJntC6YIdOLWfRGiNIoXzwJfuX9JzK7ws7
        YcFxKAYASPtUcBXarZJ8uAU/cG2Ckj6rXQ==
X-Google-Smtp-Source: ABdhPJwrXJ0kT6waXpeEWCsburvi7kEe4k+FmeRNpLxUR9B2xrLHAx/0zaWOKec9bAkcZf5e1C05Mg==
X-Received: by 2002:a7b:cb04:: with SMTP id u4mr2741291wmj.122.1618402735563;
        Wed, 14 Apr 2021 05:18:55 -0700 (PDT)
Received: from agape ([5.171.26.216])
        by smtp.gmail.com with ESMTPSA id l4sm5125486wmh.8.2021.04.14.05.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Apr 2021 05:18:55 -0700 (PDT)
From:   Fabio Aiuto <fabioaiuto83@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     julia.lawall@inria.fr, joe@perches.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] staging: rtl8723bs: remove DBG_871X_SEL_NL macro declaration
Date:   Wed, 14 Apr 2021 14:18:49 +0200
Message-Id: <8839231b53881c8bf1f8a4d70953ec8acaa2fe95.1618401896.git.fabioaiuto83@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1618401896.git.fabioaiuto83@gmail.com>
References: <cover.1618401896.git.fabioaiuto83@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove DBG_871X_SEL_NL obsolete macro declaration.

Signed-off-by: Fabio Aiuto <fabioaiuto83@gmail.com>
---
 drivers/staging/rtl8723bs/include/rtw_debug.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/drivers/staging/rtl8723bs/include/rtw_debug.h b/drivers/staging/rtl8723bs/include/rtw_debug.h
index f1b37d511f27..12873c3d801d 100644
--- a/drivers/staging/rtl8723bs/include/rtw_debug.h
+++ b/drivers/staging/rtl8723bs/include/rtw_debug.h
@@ -181,15 +181,6 @@
 			seq_printf(sel, fmt, ##arg);			\
 	} while (0)
 
-/* dump message to selected 'stream' with driver-defined prefix */
-#define DBG_871X_SEL_NL(sel, fmt, arg...)				\
-	do {								\
-		if (sel == RTW_DBGDUMP)					\
-			DBG_871X_LEVEL(_drv_always_, fmt, ##arg);	\
-		else							\
-			seq_printf(sel, fmt, ##arg);			\
-	} while (0)
-
 #endif /* defined(_dbgdump) */
 
 void sd_f0_reg_dump(void *sel, struct adapter *adapter);
-- 
2.20.1

