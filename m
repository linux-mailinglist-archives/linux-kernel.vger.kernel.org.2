Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD5339CD3
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Mar 2021 09:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233311AbhCMINJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Mar 2021 03:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbhCMIMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Mar 2021 03:12:44 -0500
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A68D5C061574
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 00:12:44 -0800 (PST)
Received: by mail-pj1-x1043.google.com with SMTP id s21so6275321pjq.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Mar 2021 00:12:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzZTCnj15hjOYCaDum7CvoHlT5xGIZI6IXf2XlaJEN0=;
        b=e3uIugvgtounyR3VnJ4cN4Yf8+N1RJPZJW3WDFWAVU+UDRYCjOEYrjm8jhIysCNATx
         jEfiywfm6JNZJ1E/643BJ5a+RY8aR9zI+Q6WTbXPvMRbfkTAD+5zULXfpgG6jW1uFPOm
         Nd1FKXais17wTaLLm7d4/7+Th+aANX7KgrY6yAYtoHUM6V9xtjY2K3dPIWJ8+w7D/e8K
         uyamm8lLseaesmvEBi2siBp1gkAXsfA3oSgb87JQL9Eij2UCQ2HBzODzAQwAmRZ6hVQs
         5xi+fRt04FFsBpUZmPU67wLwLyEbSxDwJRoweRgnZzh9N4Xs3IUhivABncp2rrptU0H6
         g/1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QzZTCnj15hjOYCaDum7CvoHlT5xGIZI6IXf2XlaJEN0=;
        b=UdSp6RCN0BrcWfSEikxWhc5V1kdE1NAI3u/ihISiXz17yXzMIA0KGl5Vlv3KnKE2ZA
         jG9s9c4pHngMntwSu22Yjtq+J7Ff6KYksJQno5iSY7iVXlBzZxCBRWFeXAQGpsin8KGv
         JMW0B8Rdii5r7VmjDYrhxCxCZsl6nUOf4wyeT07UEd5dMCJ/EyAUAT5gxDzeOB5zOY4u
         OYvQYQm23jPnXJjpVUiq1ZQ1wd1JIVFkCNBpgdNQj076Zc5SttvO9nYGfjlDGjHdXKxF
         ryrolLDINFA5Da6uG49wtM5HLXuUSSC7KDKZQeAoxVp643/ygDzjtwZniWzsVn36p/Nf
         RtGQ==
X-Gm-Message-State: AOAM5332G3DPxgYlpz5iqKa3bxXy0Iyk0vZhQbJiixeqDvGyhDFTg1T+
        NWXEd53GpYYlUaprV9x2ylrSvFu5mDA=
X-Google-Smtp-Source: ABdhPJyHUQ4G+W8zpjJ7NteFhvl0yzEvyM9EMJHdx58cC0Kd4h9LA3Ao8dHLW8XwhuopV9uGnLWUKQ==
X-Received: by 2002:a17:90a:a403:: with SMTP id y3mr2451221pjp.227.1615623163215;
        Sat, 13 Mar 2021 00:12:43 -0800 (PST)
Received: from localhost.localdomain ([178.236.46.205])
        by smtp.gmail.com with ESMTPSA id l3sm7468665pfc.81.2021.03.13.00.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 00:12:42 -0800 (PST)
From:   menglong8.dong@gmail.com
X-Google-Original-From: zhang.yunkai@zte.com.cn
To:     linux@armlinux.org.uk
Cc:     rppt@kernel.org, akpm@linux-foundation.org,
        zhang.yunkai@zte.com.cn, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM:sa1100: remove duplicate include in hackkit.c
Date:   Sat, 13 Mar 2021 00:12:35 -0800
Message-Id: <20210313081235.363124-1-zhang.yunkai@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yunkai <zhang.yunkai@zte.com.cn>

'linux/tty.h' included in 'hackkit.c' is duplicated.
It is also included in the 13th line.

Signed-off-by: Zhang Yunkai <zhang.yunkai@zte.com.cn>
---
 arch/arm/mach-sa1100/hackkit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-sa1100/hackkit.c b/arch/arm/mach-sa1100/hackkit.c
index 3085f1c2e586..3fe34ee7c0ab 100644
--- a/arch/arm/mach-sa1100/hackkit.c
+++ b/arch/arm/mach-sa1100/hackkit.c
@@ -18,7 +18,6 @@
 #include <linux/serial_core.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mtd/partitions.h>
-#include <linux/tty.h>
 #include <linux/gpio.h>
 #include <linux/leds.h>
 #include <linux/platform_device.h>
-- 
2.25.1

