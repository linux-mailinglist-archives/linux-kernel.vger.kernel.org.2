Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 213D545AC33
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 20:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233228AbhKWT2u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 14:28:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230512AbhKWT2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 14:28:49 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198E7C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:25:41 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id p17so29988pgj.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 11:25:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DhFy0MqmTsyOiUPED+iU70G5vRclcE/NLBZngkza8OU=;
        b=XiK+wxK2j9VAKtZgSR8IevTLVfHHFXlQwrmaD4uED76OzsPIrsUWwP4+xK0R+a1vkj
         3IqWR8HPEX4OF/IzH4tC2Dgl6jCP1F+h2/33uFVNrdKo7xM9qKohO91BBkvS2lCaidgo
         x1txBgU9gat3diH2qMEOtCIfKmsOS42FzhQ5Q+8QSQqeY0MLhzMUVWLLG5Mb5PxxDyxb
         DloAOnSDaJyyHcuge37w/v3qWRTbxRguLbIeeLyOD0hSAVuNOSkpAd7nmlBDewpJrfRV
         plCuNsPSIEv7VuHz1Am/2Di7OYAuzJfQwKZzN9yplEvlcQnkYL67iD4jjV6XnPzHTuuf
         2eHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DhFy0MqmTsyOiUPED+iU70G5vRclcE/NLBZngkza8OU=;
        b=M8Q37oipL6t4aJ0sU5XyJ+qEszlZWDGc/QDP2Tk+vlqtVNcuXrm3vA1XjYBOcbR4d4
         xeDrU1f6Y8rbWBfx+/L+o4s+KV+5me0PELmwzyJsJZxhJBrBizOVajG7nMdBSI78TwdU
         O85JRxpPH6OeMVvxNYtGkFFfRlinUSGuxmew7gsNOWCbOp/tYSwgnn0CTtRlJqIur7D6
         89MrEFjOgSPfHWXKxL/0XovGYaYOjLmaUaaEvQz8AEk/eqzcPEANwMM1w09WVQrX6Hil
         h7m7lAs+vNE5gioV/HR6+sEo5RjfuKZbyXNuy6CH/tbuqEm794Pr984GBUmCFKiryYYB
         26mw==
X-Gm-Message-State: AOAM533IabFB81jER6t9NoqnGgudPcQbppQcLbKbh6WN4926qW4GjVM7
        6YBMZdCzIpj4DA59qnBV17ugYg==
X-Google-Smtp-Source: ABdhPJx3nbEeRJOChbYOoUCLH18mgDLo7EdjbvdDRQXQeprqK7IHXnPzUyCLlP/TMnVeEcRHkta61g==
X-Received: by 2002:aa7:8886:0:b0:49f:fae6:c5f5 with SMTP id z6-20020aa78886000000b0049ffae6c5f5mr7481634pfe.8.1637695540677;
        Tue, 23 Nov 2021 11:25:40 -0800 (PST)
Received: from localhost.localdomain ([2601:1c2:1001:7090:9eb6:364b:a21b:8ef6])
        by smtp.gmail.com with ESMTPSA id t40sm14317886pfg.107.2021.11.23.11.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 11:25:39 -0800 (PST)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     Drew Fustini <dfustini@baylibre.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] clocksource/drivers/pistachio: Fix -Wunused-but-set-variable warning
Date:   Tue, 23 Nov 2021 11:25:24 -0800
Message-Id: <20211123192524.1038304-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable 'overflow' set but not used, but this is the intended behavior.
The hardware only updates the counter register after the overflow
register read. However, the value of overflow is not actually needed.

Link: https://lore.kernel.org/lkml/202111200402.afQsussU-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 drivers/clocksource/timer-pistachio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-pistachio.c b/drivers/clocksource/timer-pistachio.c
index 6f37181a8c63..69c069e6f0a2 100644
--- a/drivers/clocksource/timer-pistachio.c
+++ b/drivers/clocksource/timer-pistachio.c
@@ -71,7 +71,8 @@ static u64 notrace
 pistachio_clocksource_read_cycles(struct clocksource *cs)
 {
 	struct pistachio_clocksource *pcs = to_pistachio_clocksource(cs);
-	u32 counter, overflow;
+	__maybe_unused u32 overflow;
+	u32 counter;
 	unsigned long flags;
 
 	/*
-- 
2.27.0

