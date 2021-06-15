Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7C93A8B26
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Jun 2021 23:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbhFOVfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Jun 2021 17:35:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36164 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFOVf3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jun 2021 17:35:29 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623792803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdxnA8Skq8VjRrrCsfx8g/tR/LgI4RM8IniA+FYR8z0=;
        b=Ir3emsOWCdf0ZxOb90hwf94lq9e7eF/XTcV05u6spmRLGSwXc3QGGtjOmfG7rjqcs0L9qc
        AyT9OzzXe5SJE4DB6Wy0ZYyu/bQGHgyiBDHrCuq/HReAmCjszOZ9/cVrrOqY3CcgB3T2Vt
        Ra4PdIMZIYOGGI98irsQ+PflFN8jM3SPrqdiMC7LfnGkWyR86tu3fG08ZgmyX2x9JSg3NO
        BY5PXyI3PaE/YoNNXoJu3Yg06xQvEA+7KEZsvJw304eVT8CJEaiUTwdpZK8Uwy2Xf/UZJJ
        zU6+CTy2bxZms42EzgOEcswIqZgnrHh3XOQQK+/phf2vp0EHOhoAZhxJoZU74Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623792803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AdxnA8Skq8VjRrrCsfx8g/tR/LgI4RM8IniA+FYR8z0=;
        b=zIvhq3oegviT8Sc8mMGNwW2VHg2/ekAvBi4TuJaReWhhxqVjE9EwL4xVTaCjFiklRz6Wal
        eShPFV5MZWPXngCA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Alexander Potapenko <glider@google.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH next v3 1/2] dump_stack: move cpu lock to printk.c
In-Reply-To: <20210615174947.32057-2-john.ogness@linutronix.de>
References: <20210615174947.32057-1-john.ogness@linutronix.de> <20210615174947.32057-2-john.ogness@linutronix.de>
Date:   Tue, 15 Jun 2021 23:39:23 +0206
Message-ID: <8735tiq0d8.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-06-15, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index 114e9963f903..5369d8f33299 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -3532,3 +3532,70 @@ void kmsg_dump_rewind(struct kmsg_dump_iter *iter)
>  EXPORT_SYMBOL_GPL(kmsg_dump_rewind);
>  
>  #endif
> +
> +#ifdef CONFIG_SMP
> +static atomic_t printk_cpulock_owner = ATOMIC_INIT(-1);
> +static bool printk_cpulock_nested;

I just realized that @printk_cpulock_nested will need to be an atomic_t
counter to allow multiple nested levels since nesting can also occur
because of recursion and not only because of an interrupting NMI
context. So a v4 will be needed for that simple change. But please still
comment on the rest.

Thanks.

John Ogness
