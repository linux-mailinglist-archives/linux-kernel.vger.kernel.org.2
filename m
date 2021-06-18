Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C87A3AD193
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 19:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234726AbhFRR5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 13:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:45214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233104AbhFRR5X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 13:57:23 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B3804613ED;
        Fri, 18 Jun 2021 17:55:12 +0000 (UTC)
Date:   Fri, 18 Jun 2021 13:55:11 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     Phil Auld <pauld@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Kate Carcia <kcarcia@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Clark Willaims <williams@redhat.com>,
        John Kacur <jkacur@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 10/12] trace: Add osnoise tracer
Message-ID: <20210618135511.7c06a635@oasis.local.home>
In-Reply-To: <c555b92d6cfef5b3d05c426696d98553c1a46c8d.1623746916.git.bristot@redhat.com>
References: <cover.1623746916.git.bristot@redhat.com>
        <c555b92d6cfef5b3d05c426696d98553c1a46c8d.1623746916.git.bristot@redhat.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jun 2021 11:28:49 +0200
Daniel Bristot de Oliveira <bristot@redhat.com> wrote:

> diff --git a/arch/x86/kernel/trace.c b/arch/x86/kernel/trace.c
> new file mode 100644
> index 000000000000..e67d63657628
> --- /dev/null
> +++ b/arch/x86/kernel/trace.c
> @@ -0,0 +1,238 @@
> +#include <asm/trace/irq_vectors.h>
> +
> +#ifdef CONFIG_OSNOISE_TRACER
> +extern void osnoise_trace_irq_entry(int id);
> +extern void osnoise_trace_irq_exit(int id, const char *desc);

Any reason to have the above outside the LOCAL_APIC def? It's not used.
In fact, this could just be turned into:

#if defined(CONFIG_OSNOISE_TRAECR) && defined(CONFIG_X86_LOCAL_APIC)

-- Steve


> +
> +#ifdef CONFIG_X86_LOCAL_APIC

[..]

> +#endif /* CONFIG_X86_LOCAL_APIC */
> +#endif /* CONFIG_OSNOISE_TRACER */
