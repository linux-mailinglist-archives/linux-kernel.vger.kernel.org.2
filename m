Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 062DF3BA14B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbhGBNjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 09:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbhGBNju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 09:39:50 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52794C061762
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 06:37:18 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id n25so13263445edw.9
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 06:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GP5Hvx1AiXmpH714u2kfDOsz3oFFI+owQf7RK9VTiG4=;
        b=QlOVwfAZvZV5AExaD5Bq7aU7Xj5W34yUVf4q7B3oaOf9DRzgRstIzwi+zYMtMoZwPb
         IiQQoHXLs3oeAp22Mq7vA+ZyhERVZbcWrg6qAxR5XVkKosSTpcoW7B/RHHTDvC5sdNqr
         Rtj8bVXPH9rGEbLbg9yfD4twr8o13vwa4+Azs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=GP5Hvx1AiXmpH714u2kfDOsz3oFFI+owQf7RK9VTiG4=;
        b=lQAFivi7V4hrBR7UXzNAmTZ24zbWgD8V2cO9y1zweiAqQ4PW04nFFVOAvIL30UheA1
         sSPq97NnWAdtOioy7c4m0WBcTFzMxMX9KFHSmvTBc0Bknj9ncv/HGBuuevdDWfY5QjWs
         YAbaXcDGZgKEt8OQI6ePTT4sjJ3NvCWeXiLESqyCWyq9rZ9qtE1qxjaIKQMkfkFmYyhQ
         g3u9TWkG7/6/QbhuiBc+AJMDpt99QmgaHp2z1pmlUpEKcrQQTB7VZ5gjRGJpkEfFJewc
         rX0CuvTOmb7yiB4UPmVyXIbNvqh3aeEzF/zycoKM2dZj2RGJsc66wFDmRg3UdPTebA7c
         6M+A==
X-Gm-Message-State: AOAM532PZj+t2EnV2liZXmgndICiH3WbhIP0wWQN+1G74FzuGkuKzJ9l
        Q535j1cSgUXNCkBZ+fqZ23epUg==
X-Google-Smtp-Source: ABdhPJxPaB8jBtbt3nSubsRoY7Xx7SIWWOxnI8+yDtNbZU7q9UePzlvCoAFCLrJ2W6DGsIOeaX+aiA==
X-Received: by 2002:a05:6402:707:: with SMTP id w7mr6902211edx.264.1625233036688;
        Fri, 02 Jul 2021 06:37:16 -0700 (PDT)
Received: from prevas-ravi.prevas.se ([80.208.64.110])
        by smtp.gmail.com with ESMTPSA id bq1sm1053046ejb.66.2021.07.02.06.37.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 06:37:16 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Song Hui <hui.song_1@nxp.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        stable@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Revert "gpio: mpc8xxx: change the gpio interrupt flags."
Date:   Fri,  2 Jul 2021 15:37:12 +0200
Message-Id: <20210702133712.128611-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 3d5bfbd9716318b1ca5c38488aa69f64d38a9aa5.

When booting with threadirqs, it causes a splat

  WARNING: CPU: 0 PID: 29 at kernel/irq/handle.c:159 __handle_irq_event_percpu+0x1ec/0x27c
  irq 66 handler irq_default_primary_handler+0x0/0x1c enabled interrupts

That splat later went away with commit 81e2073c175b ("genirq: Disable
interrupts for force threaded handlers"), which got backported to
-stable. However, when running an -rt kernel, the splat still
exists. Moreover, quoting Thomas Gleixner [1]

  But 3d5bfbd97163 ("gpio: mpc8xxx: change the gpio interrupt flags.")
  has nothing to do with that:

      "Delete the interrupt IRQF_NO_THREAD flags in order to gpio interrupts
       can be threaded to allow high-priority processes to preempt."

  This changelog is blatantly wrong. In mainline forced irq threads
  have always been invoked with softirqs disabled, which obviously
  makes them non-preemptible.

So the patch didn't even do what its commit log said.

[1] https://lore.kernel.org/lkml/871r8zey88.ffs@nanos.tec.linutronix.de/

Cc: stable@vger.kernel.org # v5.9+
Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
Thomas, please correct me if I misinterpreted your explanation.

 drivers/gpio/gpio-mpc8xxx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-mpc8xxx.c b/drivers/gpio/gpio-mpc8xxx.c
index 4b9157a69fca..50b321a1ab1b 100644
--- a/drivers/gpio/gpio-mpc8xxx.c
+++ b/drivers/gpio/gpio-mpc8xxx.c
@@ -405,7 +405,7 @@ static int mpc8xxx_probe(struct platform_device *pdev)
 
 	ret = devm_request_irq(&pdev->dev, mpc8xxx_gc->irqn,
 			       mpc8xxx_gpio_irq_cascade,
-			       IRQF_SHARED, "gpio-cascade",
+			       IRQF_NO_THREAD | IRQF_SHARED, "gpio-cascade",
 			       mpc8xxx_gc);
 	if (ret) {
 		dev_err(&pdev->dev,
-- 
2.31.1

