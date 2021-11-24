Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5132745B5B9
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 08:42:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbhKXHpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 02:45:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbhKXHpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 02:45:30 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19E3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:42:21 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id s137so1387933pgs.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 23:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :organization:mime-version:content-transfer-encoding;
        bh=AbxPakazhsq/O8dK541/+uelph6l7oh7B7WgQNBgHmo=;
        b=TGfQ7X/wqLJNZvMD/TbKudSq72dL+W2Yxt4fxqFcoxTwvSyfUwE9tgEzXTOU/JjNeX
         P8Aidc3au57pOKPFW91qd2Nz63T7b7Mi47md5r4hnDOUl4F68ni+o5Z7UC3gDb1fVTo0
         vWBIr32S1l1D3yNLD772H6ugkANT91KvQBC8Ft4EF47bfyUkBGNRWVu/tzHZ70kKhexm
         0GRH5E5fKbNS8U3RUDr+2M0muSZcJTlump+FHwCWpQwIAZtJezhnUgQH+Fv/Gifq54BU
         KzWTF1cCG3Wfqwx+gcYdAsuoI1WubPM217kDS5arQmEQey3ciEnrR6xxUk/2oVb8lOJW
         WsgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:organization:mime-version:content-transfer-encoding;
        bh=AbxPakazhsq/O8dK541/+uelph6l7oh7B7WgQNBgHmo=;
        b=VglXqJk9was7i+vnv7mt7byQyj7OAWe5jizf9g5T/EpVQgKXwxccDFAmthdsdi4HJp
         bNyTt+e2t056ApeMdTKzIcv7hp5YrjsyZVOLDT2sub2F6Pon67ZNwkfdv3ZzQscAAzre
         mVXhv+KFhSG7QsXEI95ZWBfB3gOIyoj8EMdOgS8oBkf9ZFh/F3R6Fen8K3XTtwHMMq7/
         dPT0/q9ShzrMcs/TkPzwKxdb2rPJeVWxlCp2uuEWq2LdUUyFasBcgUCTJEY+RYKyl05k
         ZyocA63CYzFjO08A0eH9vCqZutSLXOJmX2xM7J/80DxKmKiM0+KCW6zJvdrDRV3hPvj2
         1JiA==
X-Gm-Message-State: AOAM533Fq6JopnYIoX5OjoMOk8BclVmmIhmFqU6VAEdmJYOnvu1KuZ43
        C4D/qfr7JccQH8OJuQP4TJ0=
X-Google-Smtp-Source: ABdhPJz6UODNWUxw5kNQy/FtdQQykWTZtAW7xx1Vjl0baao1U/s7AaN39myjLCGQnlk4V7P15vuO9g==
X-Received: by 2002:a63:8849:: with SMTP id l70mr2501795pgd.257.1637739741316;
        Tue, 23 Nov 2021 23:42:21 -0800 (PST)
Received: from localhost.localdomain ([43.128.78.144])
        by smtp.gmail.com with ESMTPSA id mr2sm3684971pjb.25.2021.11.23.23.42.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 23:42:21 -0800 (PST)
Date:   Wed, 24 Nov 2021 15:42:14 +0800
From:   Aili Yao <yaoaili126@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        bsegall@google.com, mgorman@suse.de, linux-kernel@vger.kernel.org,
        yaoaili@kingsoft.com
Subject: Re: [PATCH] sched/isolation: delete redundant
 housekeeping_overridden check
Message-ID: <20211124154214.43972a31@gmail.com>
In-Reply-To: <20211123204200.0976e065@rorschach.local.home>
References: <20211123154535.48be4399@gmail.com>
        <20211123123852.11a84a9e@gandalf.local.home>
        <20211124092103.64e93376@gmail.com>
        <20211123204200.0976e065@rorschach.local.home>
Organization: ksyun
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> The static branch is a jump and a nop, and the two conditions are not
> the same. So nothing above is redundant.
>=20
> The static_branch_unlikely(&housekeeping_overridden) is a switch that
> is either a nop which being an unlikely, is the fast path, and the
> content of the if block is the out-of-band condition. That is, the
> static branch keeps the expensive if conditional from ever being tested
> (because it is "overridden").
>=20
> Now when it's not overridden, that static branch turns into a jump to
> the flags test. Which then performs the expensive conditional compare
> against flags to see if it should do the cpumask_test_cpu().
>=20
> I state "expensive" because compared to a jmp or nop, any branch based
> on a test causes cache speculation to be executed. Which means branch
> prediction, etc.  The jmp and nop are just like any other atomic
> instruction that goes through the pipeline and is considered 100%
> predictable, hence it doesn't need the extra logic in the CPU to figure
> it out.
>=20
> The only thing your patch does is remove the optimization of the static
> branch logic.
>=20
Great thanks for your detailed explanation, and in some way, I get your poi=
nts
and partially understand the static branch's necessary, Thanks!

I follow you explanations and dig more into the code, and i have another RF=
C option,
And I want it shared and reviewed:

=46rom 40c13fad29b22242df6ff5ac97bddafd59e04f3e Mon Sep 17 00:00:00 2001
From: Aili Yao <yaoaili@kingsoft.com>
Date: Wed, 24 Nov 2021 02:15:28 -0500
Subject: [PATCH] sched/isolation: little optimization for housekeeping_cpu

the housekeeping_test_cpu resides in isolation.c and is not a inline
function; For general housekeeping_cpu interface, we seems want to unify
the inline definition, so housekeeping_cpu call housekeeping_test_cpu
when CONFIG_CPU_ISOLATION, while this public inline function still will
call non-static housekeeping_test_cpu; this seems not nessary;

For different CPU_ISOLATION configuration, we may use different inline
property, this will gain a little optimization;

Signed-off-by: Aili Yao <yaoaili@kingsoft.com>
---
 include/linux/sched/isolation.h | 9 ++-------
 kernel/sched/isolation.c        | 4 ++--
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolatio=
n.h
index cc9f393e2a70..3ccc19e52186 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -23,9 +23,8 @@ extern int housekeeping_any_cpu(enum hk_flags flags);
 extern const struct cpumask *housekeeping_cpumask(enum hk_flags flags);
 extern bool housekeeping_enabled(enum hk_flags flags);
 extern void housekeeping_affine(struct task_struct *t, enum hk_flags flags=
);
-extern bool housekeeping_test_cpu(int cpu, enum hk_flags flags);
+extern bool housekeeping_cpu(int cpu, enum hk_flags flags);
 extern void __init housekeeping_init(void);
-
 #else
=20
 static inline int housekeeping_any_cpu(enum hk_flags flags)
@@ -46,15 +45,11 @@ static inline bool housekeeping_enabled(enum hk_flags f=
lags)
 static inline void housekeeping_affine(struct task_struct *t,
 				       enum hk_flags flags) { }
 static inline void housekeeping_init(void) { }
-#endif /* CONFIG_CPU_ISOLATION */
=20
 static inline bool housekeeping_cpu(int cpu, enum hk_flags flags)
 {
-#ifdef CONFIG_CPU_ISOLATION
-	if (static_branch_unlikely(&housekeeping_overridden))
-		return housekeeping_test_cpu(cpu, flags);
-#endif
 	return true;
 }
+#endif /* CONFIG_CPU_ISOLATION */
=20
 #endif /* _LINUX_SCHED_ISOLATION_H */
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 7f06eaf12818..b5e81df4b04a 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -54,14 +54,14 @@ void housekeeping_affine(struct task_struct *t, enum hk=
_flags flags)
 }
 EXPORT_SYMBOL_GPL(housekeeping_affine);
=20
-bool housekeeping_test_cpu(int cpu, enum hk_flags flags)
+bool housekeeping_cpu(int cpu, enum hk_flags flags)
 {
 	if (static_branch_unlikely(&housekeeping_overridden))
 		if (housekeeping_flags & flags)
 			return cpumask_test_cpu(cpu, housekeeping_mask);
 	return true;
 }
-EXPORT_SYMBOL_GPL(housekeeping_test_cpu);
+EXPORT_SYMBOL_GPL(housekeeping_cpu);
=20
 void __init housekeeping_init(void)
 {
--=20
2.27.0



