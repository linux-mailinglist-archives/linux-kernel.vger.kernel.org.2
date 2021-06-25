Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2135C3B43A0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 14:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhFYMzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 08:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhFYMzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 08:55:44 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5FE8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:53:22 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id ot9so13950700ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 05:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=deviqon.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5SyFrBP+lRNlzWjmWrDdw8iXHJyoigUCeXuFZFUyFMo=;
        b=Bw+H+F7n+XI8/IRD2hKAymRZvWwbF/EseKJjYc2N0nkS5LJVy0ib59zn6fzY7DXCoS
         gLKlh8nYQQW0zIVGbahVpgz+vcMya5t2G84QhCNi9aVNSmLgPribtW9v1yu6dWOJi/Aw
         MsIJ5mftV7zxnbDteW9JcO7E5xTm1FE1LT70nWuSWtzp2104RsLo8Ldo+mOpULGSw69j
         hyUZhOlP08WRtWgssHs7wheQS27KSIh7/XsfqvjTstO9rDW8pDDDcJ5LdJHpApIna7QI
         sucgCyYB07gCv18lWOJ69ufkLoGPa3Xh50NEwcBoSKSUEIjErKPXzqp8CNmjEvS/l/jk
         W+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5SyFrBP+lRNlzWjmWrDdw8iXHJyoigUCeXuFZFUyFMo=;
        b=dF0slIPZgSuREZ2iuOvaPnESuLmN2RwNeyZd6fwPNSxTPl4HBLnOd49Bfkls5x2cE/
         alp0uhWT+xb9LjHIeuqMn2DXq7HqVyL3vNY4OEgZtLJ/1MiNXIP8OcJ22Fdk7X8AA6qp
         MT5S78pnD0G4dJVdCwIwZ60t8MFbLjKEdFBrBSW0GzFFslQftCAxhRVFylfG1apzakdC
         WmBCY6atwHoaq3ZfUUjCNFMpI7LZvQfqEO0sbdort6D2cx733SzUPG4mveZOMAakj/Rb
         y3bCP5XiKouGWR3m+C+D+AHUpZPOYrurk/sb3nzCBx4YsX3oA+w+yxzaa66ZhrV3bapB
         PWmQ==
X-Gm-Message-State: AOAM531zvitGrxHK7XVjaHWNzqBfPYf1TYQMrxhe1hRpCgV5cohhfYqx
        BmSrNMeqEmqVOjfZbXBaO5fDj+kyU4sFfdyjm4w=
X-Google-Smtp-Source: ABdhPJxJ2WUhQwQK3tGbb4pM563tFVEpT4w4L4iD7cGb2FhMrigF2b1f1RhYtm2hO3fYU9ksjUj2QA==
X-Received: by 2002:a17:906:6847:: with SMTP id a7mr10584762ejs.268.1624625601111;
        Fri, 25 Jun 2021 05:53:21 -0700 (PDT)
Received: from neptune.. ([5.2.193.191])
        by smtp.gmail.com with ESMTPSA id j19sm3859399edw.43.2021.06.25.05.53.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 05:53:20 -0700 (PDT)
From:   Alexandru Ardelean <aardelean@deviqon.com>
To:     linux-kernel@vger.kernel.org
Cc:     lgirdwood@gmail.com, broonie@kernel.org,
        Alexandru Ardelean <aardelean@deviqon.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH] regulator: devres: disable regulator on release if refcount is 1
Date:   Fri, 25 Jun 2021 15:53:07 +0300
Message-Id: <20210625125307.330831-1-aardelean@deviqon.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Evidently, this came about after doing a few of these types of constructs:

   static void reg_disable(void *reg)
   {
         regulator_disable(reg)
   }

   ...

   ret = regulator_enable(reg);
   if (ret)
       return ret;

   ret = devm_add_action_or_reset(dev, reg_disable, reg);

   ...

Naturally, the first thought was to try to move this construct into
regulator core, but I remembered that a devm_regulator_enable() function
isn't all that loved.
The construct above looks like it could become a short-hand (in the form of
devm_regulator_enable()), somewhere in the regulator framework.

After going back through the previous discussions [referenced below, sorry
if I missed any], it looks like maybe an idea would be to call
regulator_disable() right before regulator_put() inside
devm_regulator_release(). But we need to call it only if the 'enable_count'
is 1.

This means that the last 'regulator_disable()' (on driver remove) becomes
optional.
If there are any unbalanced regulator_enable()/regulator_disable() calls,
the 'enable_count' won't be touched and 'regulator_put()' will print a
warning.
The condition could be made to check if 'enable_count >= 1', and the
behavior would be the same, but it's probably a good idea not to touch this
refcount if isn't 1.

The only disadvantage to this approach, is that it changes the order in the
drivers in which the register_disable() gets called, with respect to other
steps in the probe/remove order.
With this, the register_disable() will be called right before the consumer
reference is free'd.

But the other advantage is that regulator_disable() calls can be removed
in simple drivers, where the consumer reference has been requested
with devm_regulator_get().

References:
  https://lore.kernel.org/lkml/20170213023249.GA27688@dtor-ws/
  https://lkml.org/lkml/2014/2/4/940

Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Alexandru Ardelean <aardelean@deviqon.com>
---

Note: this patch applies indepently of this series:
  https://lore.kernel.org/lkml/20210625122324.327585-1-aardelean@deviqon.com/

 drivers/regulator/devres.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/regulator/devres.c b/drivers/regulator/devres.c
index 826c29499d69..1852afc02990 100644
--- a/drivers/regulator/devres.c
+++ b/drivers/regulator/devres.c
@@ -16,7 +16,12 @@
 
 static void devm_regulator_release(struct device *dev, void *res)
 {
-	regulator_put(*(struct regulator **)res);
+	struct regulator *regulator = *(struct regulator **)res;
+
+	if (regulator->enable_count == 1)
+		regulator_disable(regulator);
+
+	regulator_put(regulator);
 }
 
 static struct regulator *_devm_regulator_get(struct device *dev, const char *id,
-- 
2.31.1

