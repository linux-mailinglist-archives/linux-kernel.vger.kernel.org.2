Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93B5425FB1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Oct 2021 00:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234157AbhJGWPz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Oct 2021 18:15:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbhJGWPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Oct 2021 18:15:53 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E05C061570
        for <linux-kernel@vger.kernel.org>; Thu,  7 Oct 2021 15:13:59 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id q189so16780147ybq.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Oct 2021 15:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PPDFrbOLT5EipBsq26G4jXGTjsiPQOTWTBJkYyy/cMo=;
        b=TCoJfjVYIJij7znlhqHlltJa0XLZIUWonnjacS1BNG884ZIqSHmE+yGukdYuSOq6up
         l0XjWGPwxZLTMQNmR0VeqKi03+8kN7GzrHOhdPaBJH9P5GpF3aefxXx14zkUtjMYTgKa
         P7lhTxfK/FQhMafsLaHNZq8Ec4I13CCDfX7U5CVHOeakTB37/PwRj3KkfKLHzMGSLzEu
         e8BZ+0UoxmuulYWGjcD7Cxb4k05ILwBiTrONOoHhDoqXeChjwF6kuoxvHNtgGWOkAY/7
         F4vg5uG0ROYkD+VzxLKPqoECUIAZxF+oIByln5Rsi5oE1QienLSaCaeV+kEmwBm/Fvbb
         KGqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PPDFrbOLT5EipBsq26G4jXGTjsiPQOTWTBJkYyy/cMo=;
        b=pu2gN9+04r+ha0e6x9P+6f31xpgIPlQou9GAzggV3psuugKEMV8OZiDJ+X/DM8iSWC
         pPPR+msYY7i4TV+KRlqSRjzA+lLfSf8/dH72VVoxLzg4fqi9nEHtzeU695vRJiAMl2GR
         6++6N0tjWct+30TGiVuXEtuSqlcnXP3gxOXGIw7t+wV+Uj60LFhtHQFtAiJU9z92z+h1
         39WpbH09a3UjPy2jAmifhIfycqxjsqENFzvc48GVSZD8uT0b4mu39z+ZjBwnQZFPSTD3
         sDRz5ohYkTwNoQsFli8GEMYw4bNDcaoedSqhBeh4G8DqVs06dZ+YynBaPi2F+hScvQg9
         ji8g==
X-Gm-Message-State: AOAM5310v8iRzVfrLqfGJjZpOx3gH2k4JCJcw/4WmE0IeTMOYP2GVJy4
        pbE+pQ6K3xS5cpKn78nUxtDNiJMRcSdWtl9X0bG3Og==
X-Google-Smtp-Source: ABdhPJzgVvjQCo6LeifuTbNka5/+IT9a5AHATVyTYynZBlFUcjV3o2kcr7V0r0v8R+lSuFtzILr4mV5xQ5Fu5hu4G38=
X-Received: by 2002:a25:d258:: with SMTP id j85mr8296017ybg.398.1633644837866;
 Thu, 07 Oct 2021 15:13:57 -0700 (PDT)
MIME-Version: 1.0
References: <20211007031756.345269-1-eric.dumazet@gmail.com>
 <20211007072917.GN174703@worktop.programming.kicks-ass.net>
 <CANn89iKOa+tqerm80vHvHEurc2UxTq_heQuOUE0KnVuJht8AKA@mail.gmail.com>
 <YV7+/0+Q1n67wCF8@hirez.programming.kicks-ass.net> <CANn89iLEz5POFii_=wU=2J0A9CE3H5JPq3sQFUQ8E400YumUpw@mail.gmail.com>
In-Reply-To: <CANn89iLEz5POFii_=wU=2J0A9CE3H5JPq3sQFUQ8E400YumUpw@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 7 Oct 2021 15:13:46 -0700
Message-ID: <CANn89iKg2Te8if2t_8oaAo6wL2BFNr2cP3D2w+jDePkFO5xREg@mail.gmail.com>
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

On Thu, Oct 7, 2021 at 7:13 AM Eric Dumazet <edumazet@google.com> wrote:
>
> On Thu, Oct 7, 2021 at 7:07 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Oct 07, 2021 at 07:04:09AM -0700, Eric Dumazet wrote:
> > > Good idea, I will try this.
> > > Hopefully nr_cpu_ids is populated there ?
> >
> > Lets hope :-), I'm always terminally lost in early bringup. I figure it
> > should be painfully obvious if it goes wrong.
>
> The answer seems to be yes on hosts I tested.

I have one more question about __x2apic_send_IPI_mask()

Would it make sense to disable hard irqs in __x2apic_send_IPI_mask()
only for CONFIG_CPUMASK_OFFSTACK=y builds ?

It seems wasteful to use tiny per-cpu variables and block hard irqs.

Quick and very dirty patch :

diff --git a/arch/x86/kernel/apic/x2apic_cluster.c
b/arch/x86/kernel/apic/x2apic_cluster.c
index e696e22d0531976f7cba72ed17443592eac72c13..c5076d40d4ea7bc9ffb06728531d91777a32cef4
100644
--- a/arch/x86/kernel/apic/x2apic_cluster.c
+++ b/arch/x86/kernel/apic/x2apic_cluster.c
@@ -44,15 +44,18 @@ static void
 __x2apic_send_IPI_mask(const struct cpumask *mask, int vector, int apic_dest)
 {
        unsigned int cpu, clustercpu;
-       struct cpumask *tmpmsk;
+       cpumask_var_t tmpmsk;
+#ifdef CONFIG_CPUMASK_OFFSTACK
        unsigned long flags;
+#endif
        u32 dest;

        /* x2apic MSRs are special and need a special fence: */
        weak_wrmsr_fence();
+#ifdef CONFIG_CPUMASK_OFFSTACK
        local_irq_save(flags);
-
        tmpmsk = this_cpu_cpumask_var_ptr(ipi_mask);
+#endif
        cpumask_copy(tmpmsk, mask);
        /* If IPI should not be sent to self, clear current CPU */
        if (apic_dest != APIC_DEST_ALLINC)
@@ -74,7 +77,9 @@ __x2apic_send_IPI_mask(const struct cpumask *mask,
int vector, int apic_dest)
                cpumask_andnot(tmpmsk, tmpmsk, &cmsk->mask);
        }

+#ifdef CONFIG_CPUMASK_OFFSTACK
        local_irq_restore(flags);
+#endif
 }

 static void x2apic_send_IPI_mask(const struct cpumask *mask, int vector)
