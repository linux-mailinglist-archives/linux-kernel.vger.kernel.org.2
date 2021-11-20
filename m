Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36562457EA6
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Nov 2021 14:02:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237232AbhKTNFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Nov 2021 08:05:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237622AbhKTNEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Nov 2021 08:04:42 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB4FC061574
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:39 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id t30so23119395wra.10
        for <linux-kernel@vger.kernel.org>; Sat, 20 Nov 2021 05:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OT2MymgMjRX0JoyOs0QE2/dhsG6GMnEwHNSf3NK7P7g=;
        b=oWDP3jXGMomYJzDL/u1VD5ZD0GL19J7trxWOjMWZaJvYo7k1An4lw4IQ9vmx2gEl9M
         +4/hPb2CaSH67v0CbkFCqRDM4rtNZXMYeITHypmScqjGoRa2/zLshWwsbX3bzhH+8ygW
         4oFWkjvyXYGXElBW9cFrJJ5wqyBKmN0UjKktmMXbiS7I8O4CWNhUqAEPKHjwlkjyX0sQ
         qNQEJMLztm16sn4yC80F14ejMjSGQA2FptyJ0L0O+8YFBPe/ekC6TsLz1pzRYE53mEnS
         1CKK21Mz5LFf5XMkxX3ZGfftcnbG2veEz7L3z3nM46Hm8GVoJTKvKFBc+s5s+7OrgBzY
         Pxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OT2MymgMjRX0JoyOs0QE2/dhsG6GMnEwHNSf3NK7P7g=;
        b=BXrCfgv03QB4YugQvgdSiB2SPekUHGVes2twJrb+kEG7LaGsZqoh06x9WGv8NNruDG
         2PuyAdgNOsB5e5BSvsNDlzJpTCm+ASGaNmZLgDFk6H7I5BxBfRu+WMJpN/Ncs/gpRlJk
         Byq5i+aTD0cPqYW2tQViQoNwnQxq0WVpFOM+PIKEwnJueD7LcKxTSF26Xz0S09otnOy6
         ybHCM2NsyuMa9y3Z/RnLykQA840/2sk3OvcrPybT93FIPxA/nPzq5BgeGS4OXcsZjesy
         99tkT4lMGmXKVWQqtq2o7V4I934Fe+s8q3LT/2bi7m612QKA8XhkygHVwmDyhLuWQ3Ht
         dajw==
X-Gm-Message-State: AOAM532jzYfyYx3SH/MOxQ1uOba39ewUkeogA6Pbbp2GDQIKW6CwYZM0
        8NWaGL0u5uTKqyFjAEbF67v9cJhFiezxgw==
X-Google-Smtp-Source: ABdhPJzmrABzT7tZ9+2sgaxB6JAxUlVaT0VWEZAZfonNrNTCSdBNlP0jqxeMcgLZaDeC60+g++DB1Q==
X-Received: by 2002:a5d:6c67:: with SMTP id r7mr18109646wrz.286.1637413297865;
        Sat, 20 Nov 2021 05:01:37 -0800 (PST)
Received: from ady1.alejandro-colomar.es ([170.253.36.171])
        by smtp.googlemail.com with ESMTPSA id m17sm2636736wrz.22.2021.11.20.05.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Nov 2021 05:01:37 -0800 (PST)
From:   Alejandro Colomar <alx.manpages@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alejandro Colomar <alx.manpages@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v2 20/20] linux/power_of_2.h: Implement [__]BUILD_BUG_ON_NOT_POWER_OF_2() in terms of __IS_POWER_OF_2[_OR_0]()
Date:   Sat, 20 Nov 2021 14:01:04 +0100
Message-Id: <20211120130104.185699-22-alx.manpages@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211120130104.185699-1-alx.manpages@gmail.com>
References: <20211119113644.1600-1-alx.manpages@gmail.com>
 <20211120130104.185699-1-alx.manpages@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alejandro Colomar <alx.manpages@gmail.com>
---
 include/linux/power_of_2.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/power_of_2.h b/include/linux/power_of_2.h
index 132592f0b718..80d11714b0ad 100644
--- a/include/linux/power_of_2.h
+++ b/include/linux/power_of_2.h
@@ -10,10 +10,8 @@
 #define __IS_POWER_OF_2(n)       (__IS_POWER_OF_2_OR_0(n) && ((n) != 0))
 
 /* Force a compilation error if a constant expression is not a power of 2 */
-#define __BUILD_BUG_ON_NOT_POWER_OF_2(n)	\
-	BUILD_BUG_ON(((n) & ((n) - 1)) != 0)
-#define BUILD_BUG_ON_NOT_POWER_OF_2(n)			\
-	BUILD_BUG_ON((n) == 0 || (((n) & ((n) - 1)) != 0))
+#define __BUILD_BUG_ON_NOT_POWER_OF_2(n)  BUILD_BUG_ON(!__IS_POWER_OF_2_OR_0(n))
+#define BUILD_BUG_ON_NOT_POWER_OF_2(n)    BUILD_BUG_ON(!__IS_POWER_OF_2(n))
 
 
 #endif	/* _LINUX_POWER_OF_2_H */
-- 
2.33.1

