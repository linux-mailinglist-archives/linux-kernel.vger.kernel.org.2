Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6243DEFF7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Aug 2021 16:17:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbhHCORb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Aug 2021 10:17:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56902 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236495AbhHCORS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Aug 2021 10:17:18 -0400
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628000226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvjqH4AUxl/i+ONAf8ZUv/JOSwfBnJ5sSi+EEb4J4nw=;
        b=QwmPXsmbNFThdZqdTN9xO6lKINbiE0XQlpzRwR+//JQS6qh9eh2uYi/ZHDxwTeq+WUIbKy
        b174zkDaOyiMWOfejmp5waqQyeoJ3KDaju52LRaZM6KPoz8/z/OJ+JHQKMVzBduTbGNc00
        4n6OmifC0cI+MwczsXT7h0q5f1nz3jXlgFbBB1BK2E39NoIjMLmcz9kLcGdja0O2XiNFAA
        HylRmFLZ0scMEM28ohL9v5xcVe4BSzAtzGcpeYrMD9HcF2IiMitKUwsdUafkC1eaj0oC+p
        NZTjMlcBqCrYhf/PUUMnNYXg+BzJuIsxQgZK4Wt6DAJttHIfxZEhGWX1eK7oyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628000226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rvjqH4AUxl/i+ONAf8ZUv/JOSwfBnJ5sSi+EEb4J4nw=;
        b=PJITQpgyLrGrJlQYV/KPTowFZjH6/7yNspKoS4cNi17vR6qfWnWxMULJ/miN1zqMgdls16
        zd4+AIlhgzdcq9Bg==
To:     linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Karol Herbst <karolherbst@gmail.com>,
        Pekka Paalanen <ppaalanen@gmail.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, nouveau@lists.freedesktop.org
Subject: [PATCH 06/38] x86/mmiotrace: Replace deprecated CPU-hotplug functions.
Date:   Tue,  3 Aug 2021 16:15:49 +0200
Message-Id: <20210803141621.780504-7-bigeasy@linutronix.de>
In-Reply-To: <20210803141621.780504-1-bigeasy@linutronix.de>
References: <20210803141621.780504-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The functions get_online_cpus() and put_online_cpus() have been
deprecated during the CPU hotplug rework. They map directly to
cpus_read_lock() and cpus_read_unlock().

Replace deprecated CPU-hotplug functions with the official version.
The behavior remains unchanged.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Karol Herbst <karolherbst@gmail.com>
Cc: Pekka Paalanen <ppaalanen@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: nouveau@lists.freedesktop.org
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/x86/mm/mmio-mod.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/mmio-mod.c b/arch/x86/mm/mmio-mod.c
index cd768dafca9e9..933a2ebad471b 100644
--- a/arch/x86/mm/mmio-mod.c
+++ b/arch/x86/mm/mmio-mod.c
@@ -376,12 +376,12 @@ static void enter_uniprocessor(void)
 		goto out;
 	}
=20
-	get_online_cpus();
+	cpus_read_lock();
 	cpumask_copy(downed_cpus, cpu_online_mask);
 	cpumask_clear_cpu(cpumask_first(cpu_online_mask), downed_cpus);
 	if (num_online_cpus() > 1)
 		pr_notice("Disabling non-boot CPUs...\n");
-	put_online_cpus();
+	cpus_read_unlock();
=20
 	for_each_cpu(cpu, downed_cpus) {
 		err =3D remove_cpu(cpu);
--=20
2.32.0

