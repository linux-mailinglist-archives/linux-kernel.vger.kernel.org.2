Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7483E416397
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242291AbhIWQtl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:49:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35878 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235221AbhIWQtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:49:22 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632415670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vi5RWc6YZLQPlGlsSLEKEH6yFrTkfKkQNlRzcTZMmK0=;
        b=Bgn0atERrUNvHTzYENlPr0cnhm00ZYx8HlPtgCw+qRp7ZtkS9h/N3Wk6or2ysnJn7a0Afm
        26Vb5MxjgHXJW1Oideg0QLRPOXYUxMV4VGDWreJ+i74Fxnj9QPSSWNPkitBWLQTHb1ijzt
        fuphfk5InnwhsOM6k2LM6Qs+eWyovaQGvsPqI+FyajTWUM+jdCmrfM3aTql6kP6kA4kzxZ
        2ymIkKo2gxNo/MeKz1nle6gRdKoYayQoU06zJz0smYvDc5KUQTE0Cu9hTjpakjR1ib/8nZ
        dzO3FiJW8kQVTK4xk2i/DRZrhUOeIcklA3b3M3tHQTcnhNfWocLxNKznqFtq7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632415670;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vi5RWc6YZLQPlGlsSLEKEH6yFrTkfKkQNlRzcTZMmK0=;
        b=hPyPg9J7+L7N2j//adKoTJAzG0+sQ5Bqsu6ZcemI7sPyPWeBYgMBs3TxKRIokj+YR8RM51
        p9zFdR4ydqCD8lDw==
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 4/5] kcov: Avoid enable+disable interrupts if !in_task().
Date:   Thu, 23 Sep 2021 18:47:40 +0200
Message-Id: <20210923164741.1859522-5-bigeasy@linutronix.de>
In-Reply-To: <20210923164741.1859522-1-bigeasy@linutronix.de>
References: <20210923164741.1859522-1-bigeasy@linutronix.de>
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
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Marco Elver <elver@google.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20210830172627.267989-5-bigeasy@linutronix.=
de
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

