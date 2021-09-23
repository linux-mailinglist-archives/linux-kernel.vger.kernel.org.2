Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B145416395
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Sep 2021 18:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242251AbhIWQth (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Sep 2021 12:49:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbhIWQtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Sep 2021 12:49:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C977C061757
        for <linux-kernel@vger.kernel.org>; Thu, 23 Sep 2021 09:47:51 -0700 (PDT)
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632415669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MhgQj1OhNDXz0bPvvBfoxg/NZ1WrouJm6NgCj0VKRs=;
        b=iBOYuNNyrlgroA3GzzQj6XShZfY4/p0zoJ0Bk47m/Or3UcnwSJslqN7NIySgj8LxqmHyHw
        mouk/wZPaAwlLbNvLyLlYMx9z8XJZkveBtXGw+8BNZLLv2jzAPSrAlWJRWd9lcsEiRnXmo
        BmnGoVGwo4uy0LZhgkfP0z5q/GILayfZaoxC0tZw7KXRsZqxNH7v4F/c/qt4Xk0SvAtDPW
        FsKz7+ph6lABBbJHI/LTJLrNhZsYYJAH8xtKdfUkN8211qbBUZ6rUTYjybdKXjv8X02xqf
        Hlaa9ZO6kSrmawiuc0K68zpY6eTrGtT4c4S7XKxniz0RILxItr/3uw74dIJy5w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632415669;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2MhgQj1OhNDXz0bPvvBfoxg/NZ1WrouJm6NgCj0VKRs=;
        b=lb5BHGJkT2gvWf2pb7De5S9gaRoS2yxMnbXLmoI3FN9Cna1jcm1huWLnj6NXGiOV/okcrK
        XxziWmqtdZ3OAiBQ==
To:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Marco Elver <elver@google.com>,
        Clark Williams <williams@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 3/5] kcov: Allocate per-CPU memory on the relevant node.
Date:   Thu, 23 Sep 2021 18:47:39 +0200
Message-Id: <20210923164741.1859522-4-bigeasy@linutronix.de>
In-Reply-To: <20210923164741.1859522-1-bigeasy@linutronix.de>
References: <20210923164741.1859522-1-bigeasy@linutronix.de>
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
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Acked-by: Marco Elver <elver@google.com>
Tested-by: Marco Elver <elver@google.com>
Link: https://lore.kernel.org/r/20210830172627.267989-4-bigeasy@linutronix.=
de
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

