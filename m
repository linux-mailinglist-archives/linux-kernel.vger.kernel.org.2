Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9749B38F586
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 00:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbhEXWUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 18:20:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:60086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232911AbhEXWUC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 18:20:02 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CBFCA613D6;
        Mon, 24 May 2021 22:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621894713;
        bh=+VJpt92mcBbsUrWh9kr31YWl1BdzjiW1yi5tLRR3Csk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F3ZPPPGSwifpDOmcG0/xBpaUVwDXOu1TfO/1VuqIB+Ufo09mTyOV0i1Bn2AJhUlsG
         t7pRl/emPl2mcKl7Mt0WYe+T4sIn58vsddsZ8TU9cJ7av4JGwQVSZnq8fOM/g9OfD0
         1vJXmdqUHLQxaxuvDimP5InyPWVvCiV0dZ9I9jh2L6zlP9JUdwEEJ3I+18nj5rr76E
         0HdiDLxUxOr1xWURHLvmdVnM/gSP/3VCqkNxux5P+q/4WI1UMIXpp0lYh1NmLclRj6
         HEMTD6mTrU54KCDzOKCeFVXcqd24cXgaT62Mg/YJzejjrDy44TvaH55c34BEKEZhnj
         0nbkJG8IxxayQ==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Mika=20Penttil=C3=A4?= <mika.penttila@nextfour.com>,
        kernel-team@android.com
Subject: [PATCH v2 1/5] tick/broadcast: Drop unneeded CONFIG_GENERIC_CLOCKEVENTS_BROADCAST guard
Date:   Mon, 24 May 2021 23:18:14 +0100
Message-Id: <20210524221818.15850-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210524221818.15850-1-will@kernel.org>
References: <20210524221818.15850-1-will@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tick-broadcast.o is only built if CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y
so remove the redundant #ifdef guards around the definition of
tick_receive_broadcast().

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: John Stultz <john.stultz@linaro.org>
Cc: Stephen Boyd <sboyd@kernel.org>
Signed-off-by: Will Deacon <will@kernel.org>
---
 kernel/time/tick-broadcast.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/tick-broadcast.c b/kernel/time/tick-broadcast.c
index a44055228796..fb794ff4855e 100644
--- a/kernel/time/tick-broadcast.c
+++ b/kernel/time/tick-broadcast.c
@@ -253,7 +253,6 @@ int tick_device_uses_broadcast(struct clock_event_device *dev, int cpu)
 	return ret;
 }
 
-#ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 int tick_receive_broadcast(void)
 {
 	struct tick_device *td = this_cpu_ptr(&tick_cpu_device);
@@ -268,7 +267,6 @@ int tick_receive_broadcast(void)
 	evt->event_handler(evt);
 	return 0;
 }
-#endif
 
 /*
  * Broadcast the event to the cpus, which are set in the mask (mangled).
-- 
2.31.1.818.g46aad6cb9e-goog

