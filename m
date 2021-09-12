Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52990407B57
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Sep 2021 04:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232787AbhILCx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Sep 2021 22:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbhILCxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Sep 2021 22:53:55 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE122C061574
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 19:52:41 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id c42-20020a05683034aa00b0051f4b99c40cso8249119otu.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Sep 2021 19:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QS7lEB6T19Q3S6MzQYIAJ7p+SjMy0EhADFjlcu+1l+8=;
        b=oa7vebChqwaywf0Rjune8cJmlqpG47gc52Yw6TSf+PAdtuqQIuj1Nr9cgGFoIKBs1g
         B7eU7zIeuVQWBCA13lQ1zJ19AC3C5wx3MbcId1Th3kavwbzkIxJXZbpvrNcYQtpfImSO
         5ZvSIF/VtZ2CgxK1ORLH1LQvA3R6cK/rft6eY5Dz4qcYGB45kLTX5ASo3Fxw1cJSP2Xw
         mOIurekBPhd85DqxWwQ+FwzxEADiEMIMYNlb3vDc+u4bdP/gkmMX6srMfHnBwrbCFgJ0
         ykURvowi+P3tjTfvZWrT3Y63boR1v8x3JCw2BiOuNSgR7mIPZhdbLCgOTB0mOeX5JVX+
         5SKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=QS7lEB6T19Q3S6MzQYIAJ7p+SjMy0EhADFjlcu+1l+8=;
        b=N4uPNPgGgv86/cioL/yN5XfMC0Ha9A12SFg1HfifPwQnsvOUWiYBJBw20jOvKz3SsX
         WscHkXl2BATA0G1sJzHwuiiTnVPM1YGx3+8jalWUc0B1qal6p7mTIix0K0kAlx1MrLsH
         yZJWFqexyIHuZgf41T4cqgEfS5qEpSaGsqMkZN3M1dpQb2sGLMFfA/kSX1eBv63C938K
         jdbyajq3Ldyk8q4e9GOd+mSR+1OSRgkPxv+HCE3jBkNRyBSb4xSokLPSMd3F0mRUVidF
         DGrbvd970dzmSW/T42sDSO7JcmdYxODS0ZkqfUkwSIQbZpg09lGD2yzpRa/v6PxPKX+W
         AHxA==
X-Gm-Message-State: AOAM533OhxIMCnGgCUYbXskgtgWTiVtW/3Lpj5MqcC2ANmUricM/zr7W
        WA4XH9LVtYlsiknmuEm6XM8=
X-Google-Smtp-Source: ABdhPJz1c91fw0E6Aub0KteAmWy7toQ2uOPAmJqr1y71fEMKp66YXMJHmq0fQCDBbV9d5Dw+7/go5g==
X-Received: by 2002:a9d:7f07:: with SMTP id j7mr4371938otq.84.1631415160468;
        Sat, 11 Sep 2021 19:52:40 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v11sm842646oto.22.2021.09.11.19.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 19:52:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        linux-xtensa@linux-xtensa.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH] xtensa: Increase size of gcc stack frame check
Date:   Sat, 11 Sep 2021 19:52:35 -0700
Message-Id: <20210912025235.3514761-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

xtensa frame size is larger than the frame size for almost all other
architectures. This results in more than 50 "the frame size of <n> is
larger than 1024 bytes" errors when trying to build xtensa:allmodconfig.

Increase frame size for xtensa to 1536 bytes to avoid compile errors
due to frame size limits.

Cc: Chris Zankel <chris@zankel.net>
Cc: Max Filippov <jcmvbkbc@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index ed4a31e34098..afad11e57d6b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -346,7 +346,7 @@ config FRAME_WARN
 	int "Warn for stack frames larger than"
 	range 0 8192
 	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
-	default 1536 if (!64BIT && PARISC)
+	default 1536 if (!64BIT && (PARISC || XTENSA))
 	default 1024 if (!64BIT && !PARISC)
 	default 2048 if 64BIT
 	help
-- 
2.33.0

