Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D02C6393F50
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236622AbhE1JIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236565AbhE1JIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:08:14 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A07F9C06138B
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id h3so1692592wmq.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AwUDDxXVk1/gfDczqY3uBtnDj2zTQC8MabK5rngnn1I=;
        b=IdLYAQEvPjiSqARIkd2bfyj/4gzG9Rv0Ht9kAoSHv1+cd7EzRWoFI/hs7JyjW4d8ri
         mTSGCjR62DB1lu96PAB3z6tPwVyqpiKnJy6nKPhT7NSeu5mptDh7EFQAHiwVO6i2FmxW
         APi7eB67/KdW+WNuQtBUa8Vuo4TVH9mJdvEayvA7H4sX0CexbMBLJIgpTLE3ah7OTxgH
         NHHi9CF1dSaZeZcYM6kljQ067t9fIVaeBF3ggkk5umiHyHmgDER+yjiTHd/G0N5X6C0B
         oEHJOczHcw87oig8cfOyies7kjIjsNZzs71GkqhLoj2deOmY7wpPI2o67zMJJSWvzlSq
         shug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AwUDDxXVk1/gfDczqY3uBtnDj2zTQC8MabK5rngnn1I=;
        b=SIthrMekxtaiEOqeoCV/WXn3iZYYphTvGAMj3gDQuD2H8XIffsdBrKDLj6STRMapD/
         uP2Uf7xCcT4C0FjKeu/KkdUeW17rueTofv9CiRSbUo4tP96Vy5ZiEHwC63g30hdgqGDi
         z/a7lfph09IGJLnCXDoEUjmgVV5q6sIHfMHnFyB3ns/Z0Zpw+ZtU3B1+wG4yxzs/CLJx
         PV8MQeJqD5C+2iJDfjzkMKsKJIgc/5LglkI3MCv+HmX2UMxkTAt/cnws4zGwntZSIImF
         uqpGJ4DIeWc7GqoehdTFamnYyHX2E8B6Tz7OsVEH9KgSm+/UTmVBie9YQwR9TtaJ8Z3C
         i0Lg==
X-Gm-Message-State: AOAM532JCy3L9sRyuHoa9s7sHbKl0e1HhMjJbJvDbdWdpW0hLKmlpvAA
        mYcxCN06KbZVYDNOyi4dm+E3u5aI/jR9gA==
X-Google-Smtp-Source: ABdhPJzaN77KM+uDgBntPKsWLVNqAsNSeAX3EBKg0/ACU0I0FbdQwXOvkqzXTfsa/aAZENsArah5kA==
X-Received: by 2002:a7b:c1d3:: with SMTP id a19mr7387681wmj.104.1622192793244;
        Fri, 28 May 2021 02:06:33 -0700 (PDT)
Received: from dell.default ([91.110.221.223])
        by smtp.gmail.com with ESMTPSA id m132sm6105911wmf.11.2021.05.28.02.06.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 02:06:32 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bryan Wu <bryan.wu@canonical.com>, linux-leds@vger.kernel.org
Subject: [PATCH 01/15] leds: trigger: ledtrig-cpu: Fix incorrectly documented param 'ledevt'
Date:   Fri, 28 May 2021 10:06:15 +0100
Message-Id: <20210528090629.1800173-2-lee.jones@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210528090629.1800173-1-lee.jones@linaro.org>
References: <20210528090629.1800173-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 drivers/leds/trigger/ledtrig-cpu.c:52: warning: Function parameter or member 'ledevt' not described in 'ledtrig_cpu'
 drivers/leds/trigger/ledtrig-cpu.c:52: warning: Excess function parameter 'evt' description in 'ledtrig_cpu'

Cc: Pavel Machek <pavel@ucw.cz>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Bryan Wu <bryan.wu@canonical.com>
Cc: linux-leds@vger.kernel.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/leds/trigger/ledtrig-cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/leds/trigger/ledtrig-cpu.c b/drivers/leds/trigger/ledtrig-cpu.c
index fca62d5035909..8af4f9bb9cde8 100644
--- a/drivers/leds/trigger/ledtrig-cpu.c
+++ b/drivers/leds/trigger/ledtrig-cpu.c
@@ -43,7 +43,7 @@ static atomic_t num_active_cpus = ATOMIC_INIT(0);
 
 /**
  * ledtrig_cpu - emit a CPU event as a trigger
- * @evt: CPU event to be emitted
+ * @ledevt: CPU event to be emitted
  *
  * Emit a CPU event on a CPU core, which will trigger a
  * bound LED to turn on or turn off.
-- 
2.31.1

