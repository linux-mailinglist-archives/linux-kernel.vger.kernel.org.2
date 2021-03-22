Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 586E7343F6D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Mar 2021 12:17:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhCVLQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Mar 2021 07:16:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhCVLQT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Mar 2021 07:16:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB41C061574
        for <linux-kernel@vger.kernel.org>; Mon, 22 Mar 2021 04:16:19 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616411776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d6MCD7pdLm1m9o0nSZfcGVynnHaaFFKisNBi8FUOUDI=;
        b=HGQ4Dq/QId1GFRVx1HMe3bnD4P4EIomI4JZ4cANiCSDYQJY6xdBYfGImEqIIUdflHSb2eG
        AG5nGJdk4lX5XVjaaiqS//GrJsVJP9Ijq8bdaIbrE7SKJoEIGdLpM/EDcpQBAB2lQgk6MU
        X8oZeFM6ONCXtShUT3/k50CnKRxnUQZBn4N/a/5fbdnrL+44mEG7qAdlWW2Tg8FmxwI7Oq
        VShNPK4jV2pQROn0KgdIlW5lbfX0nvRrf220GY7eMXUDCtKPCuFUg0M0FJO/mwUwNdxzQ1
        QbMS2AQMn4FOISkPvPjbMNIlD+XNpFoBkR2xwJ+6iO0Nm/Vq0xMd3c4LvxLrUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616411776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=d6MCD7pdLm1m9o0nSZfcGVynnHaaFFKisNBi8FUOUDI=;
        b=GVJkDM5NKKZT5EVSKd6owK/h9IbxTC3ADU1q8YrkwIBQ319MtYvZb+Ca0JzfmiT2F1P3nA
        kRaLvwiQ6+lXkyDA==
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>, Yue Hu <huyue2@yulong.com>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Rafael Aquini <aquini@redhat.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH next v1 2/3] printk: remove safe buffers
In-Reply-To: <YFbY8kF7ilYoxvYp@google.com>
References: <20210316233326.10778-1-john.ogness@linutronix.de> <20210316233326.10778-3-john.ogness@linutronix.de> <YFbY8kF7ilYoxvYp@google.com>
Date:   Mon, 22 Mar 2021 12:16:15 +0100
Message-ID: <87k0pzmoao.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-21, Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
>> @@ -369,7 +70,10 @@ __printf(1, 0) int vprintk_func(const char *fmt, va_list args)
>>  	 * Use the main logbuf even in NMI. But avoid calling console
>>  	 * drivers that might have their own locks.
>>  	 */
>> -	if ((this_cpu_read(printk_context) & PRINTK_NMI_DIRECT_CONTEXT_MASK)) {
>> +	if (this_cpu_read(printk_context) &
>> +	    (PRINTK_NMI_DIRECT_CONTEXT_MASK |
>> +	     PRINTK_NMI_CONTEXT_MASK |
>> +	     PRINTK_SAFE_CONTEXT_MASK)) {
>
> Do we need printk_nmi_direct_enter/exit() and
> PRINTK_NMI_DIRECT_CONTEXT_MASK?  Seems like all printk_safe() paths
> are now DIRECT - we store messages to the prb, but don't call console
> drivers.

I was planning on waiting until the kthreads are introduced, in which
case printk_safe.c is completely removed. But I suppose I could switch
the 1 printk_nmi_direct_enter() user to printk_nmi_enter() so that
PRINTK_NMI_DIRECT_CONTEXT_MASK can be removed now. I would do this in a
4th patch of the series.

John Ogness
