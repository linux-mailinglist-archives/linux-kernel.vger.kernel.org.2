Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9D23AD219
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Jun 2021 20:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236414AbhFRS3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Jun 2021 14:29:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:51190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236427AbhFRS3Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jun 2021 14:29:16 -0400
Received: from oasis.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 55065613C2;
        Fri, 18 Jun 2021 18:27:04 +0000 (UTC)
Date:   Fri, 18 Jun 2021 14:27:02 -0400
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
Message-ID: <20210618142702.7c75f0c9@oasis.local.home>
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

> diff --git a/kernel/trace/trace_osnoise.h b/kernel/trace/trace_osnoise.h
> new file mode 100644
> index 000000000000..34c7b80f9e12
> --- /dev/null
> +++ b/kernel/trace/trace_osnoise.h
> @@ -0,0 +1,9 @@
> +int __weak osnoise_arch_register(void)
> +{
> +	return 0;
> +}
> +
> +void __weak osnoise_arch_unregister(void)
> +{
> +	return;
> +}

No reason to put the above in a header file. In fact, as it is code, it
should not be in a header file. Keep it in the trace_osnoise.c.

-- Steve
