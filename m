Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1033FBAEE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238131AbhH3R1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229709AbhH3R1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:27:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46510C06175F
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:26:39 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630344397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i0MzP5fg/W/TLTV2fekKiWllQmlcT6Ku3/vzSWshZuU=;
        b=fH3wzDSqPAHQc6bytbbGbN0WVkUW5F9jf4fTN4J/MqrFVSeUTwuTUPyk5HzlqHnL4ngAih
        t0eFxyDsJhEVE14T00Vzu3jtfEwKQRvQjHrP1/Rudm7O7O1CPiOjy74whQpirSoIsY0N+R
        NL/Q2dfTuUpj5Tqf7iNfXuPzm4CxREH+tzr/grn/N5rlmuXHPGNGe3MeHmu0y/cH2ORyrx
        vB1GvXpIPwmTMYyCA/9Z/MKl9G1PEzah+lprkHD85mDMinfIy1IoWodqWRb2BLN54nnIcC
        6TtOzGiIccYyFAqgr1qakcKXw4Y+58hlXJkJUxMYGlaVOGISMkQ9r8MeAZTu/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630344397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i0MzP5fg/W/TLTV2fekKiWllQmlcT6Ku3/vzSWshZuU=;
        b=9j0gqXh0YqP9QPYh993FYGw/JQ9vgvn2bhOfaqUUHY2bDaljMsrL8zS1bcnwmzhITJjzzr
        t645O80ZrxwVgwBg==
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 4/5] kcov: Avoid enable+disable interrupts if !in_task().
Date:   Mon, 30 Aug 2021 19:26:26 +0200
Message-Id: <20210830172627.267989-5-bigeasy@linutronix.de>
In-Reply-To: <20210830172627.267989-1-bigeasy@linutronix.de>
References: <20210830172627.267989-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kcov_remote_start() may need to allocate memory in the in_task() case
(otherwise per-CPU memory has been pre-allocated) and therefore requires
enabled interrupts.
The interrupts are enabled before checking if the allocation is required
so if no allocation is required then the interrupts are needlessly
enabled and disabled again.

Enable interrupts only if memory allocation is performed.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/kcov.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 4f910231d99a2..620dc4ffeb685 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -869,19 +869,19 @@ void kcov_remote_start(u64 handle)
 		size =3D CONFIG_KCOV_IRQ_AREA_SIZE;
 		area =3D this_cpu_ptr(&kcov_percpu_data)->irq_area;
 	}
-	spin_unlock_irqrestore(&kcov_remote_lock, flags);
+	spin_unlock(&kcov_remote_lock);
=20
 	/* Can only happen when in_task(). */
 	if (!area) {
+		local_irqrestore(flags);
 		area =3D vmalloc(size * sizeof(unsigned long));
 		if (!area) {
 			kcov_put(kcov);
 			return;
 		}
+		local_irq_save(flags);
 	}
=20
-	local_irq_save(flags);
-
 	/* Reset coverage size. */
 	*(u64 *)area =3D 0;
=20
--=20
2.33.0

