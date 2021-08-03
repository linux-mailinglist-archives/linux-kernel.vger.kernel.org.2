Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35DC3DEC0A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 13:36:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235768AbhHCLgb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 07:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235706AbhHCLg1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 07:36:27 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21008C061764;
        Tue,  3 Aug 2021 04:36:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id h13so11493990wrp.1;
        Tue, 03 Aug 2021 04:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sTKYBnBKKsh1beNAYDR2xmYVPiIYdU0sotGuAnpEEyI=;
        b=c1DRXF4SH9nGuIlcc07AgsTIPweMjNjGI03eK91dNJovsSwh8jQC4hwurUWVFZX+zo
         eiZbcynA5kgxO/Zdqp3lCVBzi2a/4o4IWsHR8jTla3xsctpRxOzIQ40MbsjbvYbuPdtd
         yW6KC5cAlj6nQeof+Gy26NpZd7FQvN5FQF1eWCGb7vdgl5a//AIy8Y7eCEsW+vkybQlG
         NZssOv34eduvrNP51VOyuwasukTnkl/mhXEiWR26wKwE8RiiLHDTWto2H06vz0IZW7iy
         /jteWituQMVjRmq/mCCgiRf7utWVTBFMOnvxsGpxhoLqradL9+Bq26fKOkZth+5VIGo2
         Nl0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sTKYBnBKKsh1beNAYDR2xmYVPiIYdU0sotGuAnpEEyI=;
        b=hjLAjegYxFl0owvlFeHNtRg3Kt2ALEj+CxP5ho+QrGjCDaaYymcioSkYrlbMJvH5eQ
         b3z/X9APxE4SXNx+hkPQoJHu3RsH0QZ7KX1Q2e3z6NsVyJenmf2M52FdtshrPX5W1FNV
         m7AnIM+QSDF739qEVdozguVErB6HYrschn+S3wOuEdBKAQzP71YrFMC5UR3TAsLoEI1n
         nXCu+mZq8z44CkLBoxtNDeAq/f4CnYbZlnXcCU6iyti0LrbYJlJoRzPRUk5qL34rWYqT
         8U48yJZIcifDVJEGO0MsW87J7+pwGfdBbX2jV8Sj4u+cfR5/DpBnn3TSQsuqmg5C6wIx
         l9dw==
X-Gm-Message-State: AOAM533SKRmX4CN4tYghjqrhQtbb95UYXJTAZk724+68g3GlCuXIVaIc
        7lXGg6lxOlkGVx04t3R8NMg=
X-Google-Smtp-Source: ABdhPJxTzq4/0XGZJ0WFxWUhPJ0fqA4GhoGMSdqkYTT4aCMU87bvwqyrcnlnnN8RUg5QYaTyPV+lCw==
X-Received: by 2002:a05:6000:120f:: with SMTP id e15mr22049966wrx.399.1627990570652;
        Tue, 03 Aug 2021 04:36:10 -0700 (PDT)
Received: from felia.fritz.box ([2001:16b8:2de7:c500:a5d6:9db:2c2c:b89d])
        by smtp.gmail.com with ESMTPSA id m14sm13961364wrs.56.2021.08.03.04.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Aug 2021 04:36:07 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     "H . Peter Anvin" <hpa@zytor.com>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lubomir Rintel <lkundrak@v3.sk>, Pavel Machek <pavel@ucw.cz>,
        Lee Jones <lee.jones@linaro.org>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        platform-driver-x86@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH 2/9] x86, olpc: correct condition to intended CONFIG_OLPC_XO15_SCI
Date:   Tue,  3 Aug 2021 13:35:24 +0200
Message-Id: <20210803113531.30720-3-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
References: <20210803113531.30720-1-lukas.bulwahn@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The refactoring in commit ec9964b48033 ("Platform: OLPC: Move
EC-specific functionality out from x86") introduces an
ifdef CONFIG_OLPC_XO1_5_SCI, however the config is actually called
"CONFIG_OLPC_XO15_SCI".

Fortunately, ./scripts/checkkconfigsymbols.py warns:

OLPC_XO1_5_SCI
Referencing files: arch/x86/platform/olpc/olpc.c

Correct this ifdef condition to the intended config symbol.

Fixes: ec9964b48033 ("Platform: OLPC: Move EC-specific functionality out from x86")
Suggested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
 arch/x86/platform/olpc/olpc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/platform/olpc/olpc.c b/arch/x86/platform/olpc/olpc.c
index ee2beda590d0..1d4a00e767ec 100644
--- a/arch/x86/platform/olpc/olpc.c
+++ b/arch/x86/platform/olpc/olpc.c
@@ -274,7 +274,7 @@ static struct olpc_ec_driver ec_xo1_driver = {
 
 static struct olpc_ec_driver ec_xo1_5_driver = {
 	.ec_cmd = olpc_xo1_ec_cmd,
-#ifdef CONFIG_OLPC_XO1_5_SCI
+#ifdef CONFIG_OLPC_XO15_SCI
 	/*
 	 * XO-1.5 EC wakeups are available when olpc-xo15-sci driver is
 	 * compiled in
-- 
2.17.1

