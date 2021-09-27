Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0F941A144
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 23:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237211AbhI0VVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 17:21:10 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59346 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236743AbhI0VVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 17:21:09 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632777570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ua6ba4F9xI9z9efr4kiigXojMnXFe5ZRsiSrCyvi2p8=;
        b=2fW8ST/KIrJDNwmhLa6xRzS4Z630SfbIuGqW+pNrTduhiBozAbyOGKNBOROINzCkcW4Jzv
        go267E1VouvssE98oeQrPbFZ6Zs4C7leTiukxScN151ScIJswkkOWhi0QEBBgUmekksYVq
        TyvWzNZM34OioxXVQOfA4Ef377hnf1EeHRffQUrdfatjqggZzRauQP0jZj07nRp51kHoB6
        3CQzMoMGKyrwqVr6VIdeGr3JPxJL4wcEw9uEdePli9g6gC5vsmGCXZxy9xzyX56EYJz1mT
        GvB4G9Oa0eiYkV0vSjz8qpUQic8BFd5USQu/EyTki9KpDbBwLt7xoBmn2iadHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632777570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ua6ba4F9xI9z9efr4kiigXojMnXFe5ZRsiSrCyvi2p8=;
        b=776F6zsXw3pg4wUbW2MOX62s8EzQxbJQd7LS2QjdaC5tTiz4wTQ4ysioSRYmjbudrFjIra
        rLzmy6v9lBXB3gCA==
To:     linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 2/5] irq_work: Ensure that irq_work runs in in-IRQ context.
Date:   Mon, 27 Sep 2021 23:19:16 +0200
Message-Id: <20210927211919.310855-3-bigeasy@linutronix.de>
In-Reply-To: <20210927211919.310855-1-bigeasy@linutronix.de>
References: <20210927211919.310855-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The irq-work callback should be invoked in hardirq context and some
callbacks rely on this behaviour. At the time irq_work_run_list()
interrupts should be disabled but the important part is that the
callback is invoked from a in-IRQ context.
The "disabled interrupts" check can be satisfied by disabling interrupts
from a kworker which is not the intended context.

Ensure that the callback is invoked from hardirq context and not just
with disabled interrupts.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/irq_work.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index db8c248ebc8c8..caf2edffa20d5 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -167,7 +167,7 @@ static void irq_work_run_list(struct llist_head *list)
 	struct irq_work *work, *tmp;
 	struct llist_node *llnode;
=20
-	BUG_ON(!irqs_disabled());
+	BUG_ON(!in_hardirq());
=20
 	if (llist_empty(list))
 		return;
--=20
2.33.0

