Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC0753FBAEC
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Aug 2021 19:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238071AbhH3R1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Aug 2021 13:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238039AbhH3R1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Aug 2021 13:27:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3EF1C061575
        for <linux-kernel@vger.kernel.org>; Mon, 30 Aug 2021 10:26:38 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630344397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdeGlaxloU7A7puzQDSmxwaKz/GLtfH48l9XOoOH/4I=;
        b=QOxAok9pTRgDw/fxTZ5ZsWZox5JvwlWDGdAx/+BWvzi4l7ddFMYuLTk63i539xakZQp3mU
        cMBMG63vwVxu/qIkj7MQN9pjRmLKU8ZRqE5bloE3ExBoAhBzfvYhNFVvdXgrG6hG211rFk
        YWdrSMOSssfvkCDNGqSKSzbc+FuO9XY5fb70ujrroALAPm1k455TyIdqtTrIk2/EXiF25y
        6bHKuO0W2bYvpbWWiW184LhxL9Rlt2jy2q4twur4vganWTv/vmWwCWCUJJwrDTkLFLh3EP
        YGDDf6Z5v94/WBUlHmFDjpdIyLFXadEhyMFXbiCjiTvVtE3JSS/BTmfx0iAXog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630344397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zdeGlaxloU7A7puzQDSmxwaKz/GLtfH48l9XOoOH/4I=;
        b=y69AgIFSKTaaa6dAWRJppunTbCfNaOW3MA4pl4bZuBXPyRl6KP0ctRhFm/+d8kvn3nyI6A
        DOVWW1w+LJDmNECw==
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 3/5] kcov: Allocate per-CPU memory on the relevant node.
Date:   Mon, 30 Aug 2021 19:26:25 +0200
Message-Id: <20210830172627.267989-4-bigeasy@linutronix.de>
In-Reply-To: <20210830172627.267989-1-bigeasy@linutronix.de>
References: <20210830172627.267989-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During boot kcov allocates per-CPU memory which is used later if remote/
softirq processing is enabled.

Allocate the per-CPU memory on the CPU local node to avoid cross node
memory access.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 kernel/kcov.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index 80bfe71bbe13e..4f910231d99a2 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -1034,8 +1034,8 @@ static int __init kcov_init(void)
 	int cpu;
=20
 	for_each_possible_cpu(cpu) {
-		void *area =3D vmalloc(CONFIG_KCOV_IRQ_AREA_SIZE *
-				sizeof(unsigned long));
+		void *area =3D vmalloc_node(CONFIG_KCOV_IRQ_AREA_SIZE *
+				sizeof(unsigned long), cpu_to_node(cpu));
 		if (!area)
 			return -ENOMEM;
 		per_cpu_ptr(&kcov_percpu_data, cpu)->irq_area =3D area;
--=20
2.33.0

