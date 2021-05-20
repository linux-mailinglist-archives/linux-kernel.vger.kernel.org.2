Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E51F638B649
	for <lists+linux-kernel@lfdr.de>; Thu, 20 May 2021 20:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236082AbhETSsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 May 2021 14:48:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:39388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235813AbhETSsq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 May 2021 14:48:46 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0FC3C611AB;
        Thu, 20 May 2021 18:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621536444;
        bh=+VJpt92mcBbsUrWh9kr31YWl1BdzjiW1yi5tLRR3Csk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=q8UVoynLOLpMdIppIYneX64kan/QxB9SBJsGaUmcr5PnjSABQGsROy8nPsL3fK6gh
         bngoy/uD8IUbEtSpdr+zOuqDeAu6e07XKTOdYFVrGupcmjxsV6z6hMPFG3feqe4P7B
         woBW90ftxJJSm7cvgc1tm6iQHbdpM5LkqI3RQZ4T1YZUwQZ2qEKI2uD4buySSvLhpg
         tv5dLt07y6gVg4aZYg6zNk1Yvn6dy1iAzjujmrh3iUXaXq1KgLvyqJESGGaOa5T3bU
         g4IbgAfxSEVW30Z3uZLiKbypu+U9PER2HlwZu91l0QYLWzyQ3ZH6sCHLnnfb25jK9q
         BvuT6x2Ma7s2g==
From:   Will Deacon <will@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Colitti <lorenzo@google.com>,
        John Stultz <john.stultz@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>, kernel-team@android.com
Subject: [PATCH 1/5] tick/broadcast: Drop unneeded CONFIG_GENERIC_CLOCKEVENTS_BROADCAST guard
Date:   Thu, 20 May 2021 19:47:01 +0100
Message-Id: <20210520184705.10845-2-will@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210520184705.10845-1-will@kernel.org>
References: <20210520184705.10845-1-will@kernel.org>
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

