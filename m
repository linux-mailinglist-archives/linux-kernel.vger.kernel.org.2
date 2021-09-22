Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26F5A4150DB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Sep 2021 21:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237311AbhIVUBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Sep 2021 16:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237307AbhIVUA4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Sep 2021 16:00:56 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811B7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:59:25 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id u18so15987577lfd.12
        for <linux-kernel@vger.kernel.org>; Wed, 22 Sep 2021 12:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JNOAIcFCLSssIhBnFoRYm/3pctiMwQNvmPnLO/Yue9U=;
        b=ia9nVgZYffiQAHS8yaJRtMBgjTGgySxNlv4rddVjesC5t0076zChAx5R2RVHJU985x
         05SpGjGEjMN2wnfj+82qiG77Q/nfrw1ZytVkJvjE+7ZJEXi8OyiC8tGDNickZ8r8OXP/
         6t24gTrU4JCR8sPxAmxp4FatcQYgfKihntGmlP8/RGVwSt7/wdG+jqMXmkLyQL3iJawV
         Y7JuC6IsSzBZrFMipSWTc8Ptea/jLujgLma7No8h1uwLJniRHDXfP7vq4ptUFZMtxX8S
         lOVxZMq75sEM70+32OlNHP9NL3JM0Ee6VVw9r8gl8s/zg84n6ZlBc1fALoG8Poa2nYIM
         rg+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JNOAIcFCLSssIhBnFoRYm/3pctiMwQNvmPnLO/Yue9U=;
        b=H+kY+3jWGkb4EYLi8xrQ4hU27NcBLDLn0S6BBZC8Nw3AIFQRMDBzMOawxlqqd0vTlr
         MR+3jcQt4X+IvAkXBaodFfHMmW15uMU8DurPztLPRD2WIAJ3Hd58KztFko35+nQHhiaF
         jfPO4kwCiktTJBKjH/72ggH0Za1ynEHWGRWYQ75btMPX1sRE1OJIjYfH/myQNRYUJtbK
         h4jfHFIHGfoOAsx0XEP4SxSqRFp8P0yjQ3Ue/O9x637SslcyAmUHyplFekZ+sDc9xSBy
         LiTg/rXrRzM5zD/lfZAjSe33A+zHhsyU9rRrZ4syeQSrguLMJPWdhvuKzc8xpP6WgUUm
         rIzA==
X-Gm-Message-State: AOAM531Hzrg3CPNAv4v8o5CBwfZWcVkuLF+50r0AGwQaMCH396x+W+r1
        x8YXAJ4bYPmn5SbrBrjtOP6gow==
X-Google-Smtp-Source: ABdhPJxwG0YSV9Azfc3KfYTBekJaP2gHdriAb1R9Dn3Y6iyj8Ys2TldSi1Y767bzXYTcYc/RpnFKIg==
X-Received: by 2002:ac2:455b:: with SMTP id j27mr735933lfm.238.1632340763843;
        Wed, 22 Sep 2021 12:59:23 -0700 (PDT)
Received: from localhost.localdomain (c-fdcc225c.014-348-6c756e10.bbcust.telenor.se. [92.34.204.253])
        by smtp.gmail.com with ESMTPSA id j18sm251514lfg.65.2021.09.22.12.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Sep 2021 12:59:23 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        Joel Stanley <joel@jms.id.au>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 2/3 v2] clocksource/drivers/fttmr010: Clear also overflow bit on AST2600
Date:   Wed, 22 Sep 2021 21:56:55 +0200
Message-Id: <20210922195656.1822268-2-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210922195656.1822268-1-linus.walleij@linaro.org>
References: <20210922195656.1822268-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The code was originally just writing 0x1 into TIMER_INTR_STATE
on the AST2600. But that is just the bit for TIMER_1_INT_MATCH1
so if we're using periodic IRQs we also need to clear
TIMER_1_INT_OVERFLOW.

Cc: Cédric Le Goater <clg@kaod.org>
Cc: Joel Stanley <joel@jms.id.au>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Resending with the other patches.
---
 drivers/clocksource/timer-fttmr010.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-fttmr010.c b/drivers/clocksource/timer-fttmr010.c
index f47099dda96b..5af8ea388cc4 100644
--- a/drivers/clocksource/timer-fttmr010.c
+++ b/drivers/clocksource/timer-fttmr010.c
@@ -285,7 +285,8 @@ static irqreturn_t ast2600_timer_interrupt(int irq, void *dev_id)
 
 	val = readl(fttmr010->base + TIMER_INTR_STATE);
 	if (val & (TIMER_1_INT_MATCH1 | TIMER_1_INT_OVERFLOW)) {
-		writel(TIMER_1_INT_MATCH1, fttmr010->base + TIMER_INTR_STATE);
+		writel(TIMER_1_INT_MATCH1 | TIMER_1_INT_OVERFLOW,
+		       fttmr010->base + TIMER_INTR_STATE);
 		evt->event_handler(evt);
 	} else {
 		/* Just clear any spurious IRQs from the block */
-- 
2.31.1

