Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29FDD42C843
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 20:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238329AbhJMSFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 14:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbhJMSFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 14:05:02 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3364C061570
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:02:58 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id a7so8451974yba.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 11:02:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AmvXcYMzdSDz7TFRGUZQZv1hDpV4qXcA0OVZWq94CrY=;
        b=hWwHez8pxhnQbl9RbSKH5ubLoy0ruwVkpbVpXohvouwCiH0akNhqJuTARv23f8T2F6
         dJVSJTMuvB2ib7TdpQ5hUea1dVcylLcbVa6ZC76d++PDuzKlU6DTQTbyOHybyDGF9ZDA
         QXhNETaAVga73vS97J2AvD/qCV1o/F8CYVeuQ5N/J7neLgeX0a6GVufj0yW+qElLWmtW
         hN4ZsSXeGSEs9br/Rgz23Mb105lF2xSntVezElxtMkDJ09p0oFh3ve9MVogRqGraqz/b
         ujRPeydUfpsUU1v0KVWRcs2SShmSGy8CVQ0E/ujm34XyBK4KaptliApwqa6qJHYU6n2f
         J2Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AmvXcYMzdSDz7TFRGUZQZv1hDpV4qXcA0OVZWq94CrY=;
        b=2RsJOGDbazMssrHS8gDT5ZeKADT/BrJ1UQvjJjky5J3EQivafZamdbXLCzgiRDpvVD
         RUJAE1FYSI7W/I3H8pcDOiOjHGxlSFPGmhEX2p2YGVoRPgDETbHJB+T6KwLdWyPn7Adv
         q7Ao3VSUA9KJiG3gziNTom1G0hqhZEXFJpvrrqSMoYL9i8UC8+KvWFrCmxkN79LgIhym
         XExFwUNWxB3Hdw7BnuqH2AC0oxGIEOzlLnT4sA0lek899pPS2q3SFD4Wi8EQjGgnhG2K
         uz3PIWG9UWA7DgzgialOt0KfGljZk8ELG37eX7PPnrNTY+Gkys+FW2qgGZ98cN5+ggzy
         HQCg==
X-Gm-Message-State: AOAM531AMehGBlGVs0kpucaUY0QxvWv4Hg4vH8YZNTFtOXxtletp8m8T
        O802r+w9YXhsAikkiZ8pspsFcsRKloiX+slG9TBoauWAicwo4g==
X-Google-Smtp-Source: ABdhPJyrbDM7N0hs+1pUKm7Mjmnx5U+Rzf9i4SVFmamFZYXIPBXGxFhj+hL1SHSMyBb/fpkhXeinKCHWoF5QR7Te8AU=
X-Received: by 2002:a25:bd08:: with SMTP id f8mr910512ybk.89.1634148177510;
 Wed, 13 Oct 2021 11:02:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211007031756.345269-1-eric.dumazet@gmail.com>
 <20211007072917.GN174703@worktop.programming.kicks-ass.net>
 <CANn89iKOa+tqerm80vHvHEurc2UxTq_heQuOUE0KnVuJht8AKA@mail.gmail.com>
 <YV7+/0+Q1n67wCF8@hirez.programming.kicks-ass.net> <CANn89iLEz5POFii_=wU=2J0A9CE3H5JPq3sQFUQ8E400YumUpw@mail.gmail.com>
 <CANn89iKg2Te8if2t_8oaAo6wL2BFNr2cP3D2w+jDePkFO5xREg@mail.gmail.com> <YWWDbIU+Cpppc7PV@hirez.programming.kicks-ass.net>
In-Reply-To: <YWWDbIU+Cpppc7PV@hirez.programming.kicks-ass.net>
From:   Eric Dumazet <edumazet@google.com>
Date:   Wed, 13 Oct 2021 11:02:46 -0700
Message-ID: <CANn89iL5mmbVojrUC4GHKC+0WSxzs_obqbt=rn2S_cmkddAriQ@mail.gmail.com>
Subject: Re: [PATCH] x86/apic: reduce cache line misses in __x2apic_send_IPI_mask()
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 5:46 AM Peter Zijlstra <peterz@infradead.org> wrote:

> I'm really conflicted about this. On the one hand, yes absolutely. On
> the other hand, urgh, code ugly :-)

That was indeed some ugly hack.

I cooked this more generic patch instead, I am currently testing it.
(generic as : we no longer disable hard irqs, regardless of some CONFIG option )

diff --git a/arch/x86/kernel/apic/x2apic_cluster.c
b/arch/x86/kernel/apic/x2apic_cluster.c
index e696e22d0531976f7cba72ed17443592eac72c13..7ad81467ce33349dee1ceaf0cefc8375d60213f6
100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -22,7 +22,10 @@ struct cluster_mask {
  */
 static u32 *x86_cpu_to_logical_apicid __read_mostly;

-static DEFINE_PER_CPU(cpumask_var_t, ipi_mask);
+#define IPI_NEST_MAX 3
+static DEFINE_PER_CPU(cpumask_var_t, ipi_mask[IPI_NEST_MAX]);
+static DEFINE_PER_CPU(int, ipi_nest_level);
+
 static DEFINE_PER_CPU_READ_MOSTLY(struct cluster_mask *, cluster_masks);
 static struct cluster_mask *cluster_hotplug_mask;

@@ -45,14 +48,18 @@ __x2apic_send_IPI_mask(const struct cpumask *mask,
int vector, int apic_dest)
 {
        unsigned int cpu, clustercpu;
        struct cpumask *tmpmsk;
-       unsigned long flags;
+       int nest_level;
        u32 dest;

        /* x2apic MSRs are special and need a special fence: */
        weak_wrmsr_fence();
-       local_irq_save(flags);

-       tmpmsk = this_cpu_cpumask_var_ptr(ipi_mask);
+       preempt_disable();
+       nest_level = this_cpu_inc_return(ipi_nest_level) - 1;
+       if (WARN_ON_ONCE(nest_level >= IPI_NEST_MAX))
+               goto end;
+
+       tmpmsk = this_cpu_cpumask_var_ptr(ipi_mask[nest_level]);
        cpumask_copy(tmpmsk, mask);
        /* If IPI should not be sent to self, clear current CPU */
        if (apic_dest != APIC_DEST_ALLINC)
@@ -74,7 +81,9 @@ __x2apic_send_IPI_mask(const struct cpumask *mask,
int vector, int apic_dest)
                cpumask_andnot(tmpmsk, tmpmsk, &cmsk->mask);
        }

-       local_irq_restore(flags);
+end:
+       this_cpu_dec(ipi_nest_level);
+       preempt_enable();
 }

 static void x2apic_send_IPI_mask(const struct cpumask *mask, int vector)
@@ -153,20 +162,26 @@ static int alloc_clustermask(unsigned int cpu, int node)

 static int x2apic_prepare_cpu(unsigned int cpu)
 {
+       int i;
+
        if (alloc_clustermask(cpu, cpu_to_node(cpu)) < 0)
                return -ENOMEM;
-       if (!zalloc_cpumask_var(&per_cpu(ipi_mask, cpu), GFP_KERNEL))
-               return -ENOMEM;
+       for (i = 0 ; i < IPI_NEST_MAX; i++) {
+               if (!zalloc_cpumask_var(&per_cpu(ipi_mask[i], cpu), GFP_KERNEL))
+                       return -ENOMEM;
+       }
        return 0;
 }

 static int x2apic_dead_cpu(unsigned int dead_cpu)
 {
        struct cluster_mask *cmsk = per_cpu(cluster_masks, dead_cpu);
+       int i;

        if (cmsk)
                cpumask_clear_cpu(dead_cpu, &cmsk->mask);
-       free_cpumask_var(per_cpu(ipi_mask, dead_cpu));
+       for (i = 0; i < IPI_NEST_MAX; i++)
+               free_cpumask_var(per_cpu(ipi_mask[i], dead_cpu));
        return 0;
 }
