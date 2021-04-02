Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B0C352AF7
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 15:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhDBNUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 09:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbhDBNUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 09:20:48 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA66C0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 06:20:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id gb6so2722053pjb.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 06:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLdprKH3JUUdGr7ySBcn8te3XSD2cxM3yHUQP/41LNg=;
        b=iZO/Sz60fvZSP1X7hi/QAyidsD5/q31XvJNSztMxRT4IkSmTABBg21Q7rCgpR82sLY
         D2KRo1ISsYtlgdMj6+pga89sHKhLquWCY+VDlFHCHfFIck/B6EdkWy+vqssNahtZitXC
         O0oEESeycwdeE1c896XM6qNEwtZNDJJjXg1uVUwxT0NCsdwWYRsqDQljm7W4TnzDOzru
         OJhhUi5buezdd1DMivtnltTFTXva+7M8LiGicSaRpvpGtcPJQtrmdi/fNPb3ZOmNn2tA
         6KK7NDflS97wDwdR2nhvbYf4oFMcKZVoIdv63jacAYfo5/p8h32lHSenHNYcNNN+XPe0
         etQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kLdprKH3JUUdGr7ySBcn8te3XSD2cxM3yHUQP/41LNg=;
        b=KCyuQUjz+ObSotyu/m/DiZWBGttdk4zq5VlbmUpQvF4xJ43rqA+nDKtIKjsJjEhD1E
         0sncXg4+BO+Q9V8GemuhYNuyRRfcGzPGucarvyGIsT4mQg6tripTzmkOJRgRo63dnQu/
         HzE9N0p39A3ArNZMiw0jCWt/WqNLgYIqbIrBpg14GdyICJ8zdn8uZkr9A64YWhd1pRg6
         0jdxy7OA6nmIJu2wy/N9bVqhclTU4QGekJCkz7Enw6NmG4eIY06w7HJs+M7An8Pit+at
         ampLBbPJ9mE27koxXj1+xJZYcBWJBiHltVqsQYnSDvTp9jRaX7NsnOIYwFZ+WDVT58L/
         xmng==
X-Gm-Message-State: AOAM533VB7+fhp8oPglalm4Abyc3aVihZBSYHo2wEl5ocWyqV1B0G17K
        a82AwSePpGN2tyW36T7oDLo=
X-Google-Smtp-Source: ABdhPJyI6rASNXdFPM0KJCYnULg+XaX/RfaGhS4U8Dc2a3Rd9ryAHuQH5uTbCWdqS3Hft4uCRrrkrQ==
X-Received: by 2002:a17:90a:df91:: with SMTP id p17mr13919057pjv.23.1617369646365;
        Fri, 02 Apr 2021 06:20:46 -0700 (PDT)
Received: from bobo.ozlabs.ibm.com ([1.128.190.224])
        by smtp.gmail.com with ESMTPSA id h18sm4668935pgj.51.2021.04.02.06.20.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 06:20:45 -0700 (PDT)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] genirq: reduce irqdebug bouncing cachelines
Date:   Fri,  2 Apr 2021 23:20:37 +1000
Message-Id: <20210402132037.574661-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

note_interrupt increments desc->irq_count for each interrupt even for
percpu interrupt handlers, even when they are handled successfully. This
causes cacheline bouncing and limits scalability.

Instead of incrementing irq_count every time, only start incrementing it
after seeing an unhandled irq, which should avoid the cache line
bouncing in the common path.

This actually should give better consistency in handling misbehaving
irqs too, because instead of the first unhandled irq arriving at an
arbitrary point in the irq_count cycle, its arrival will begin the
irq_count cycle.

Cédric reports the result of his IPI throughput test:

               Millions of IPIs/s
 -----------   --------------------------------------
               upstream   upstream   patched
 chips  cpus   default    noirqdebug default (irqdebug)
 -----------   -----------------------------------------
 1      0-15     4.061      4.153      4.084
        0-31     7.937      8.186      8.158
        0-47    11.018     11.392     11.233
        0-63    11.460     13.907     14.022
 2      0-79     8.376     18.105     18.084
        0-95     7.338     22.101     22.266
        0-111    6.716     25.306     25.473
        0-127    6.223     27.814     28.029

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 kernel/irq/spurious.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/irq/spurious.c b/kernel/irq/spurious.c
index f865e5f4d382..c481d8458325 100644
--- a/kernel/irq/spurious.c
+++ b/kernel/irq/spurious.c
@@ -403,6 +403,10 @@ void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret)
 			desc->irqs_unhandled -= ok;
 	}
 
+	if (likely(!desc->irqs_unhandled))
+		return;
+
+	/* Now getting into unhandled irq detection */
 	desc->irq_count++;
 	if (likely(desc->irq_count < 100000))
 		return;
-- 
2.23.0

