Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A23DF34D35C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Mar 2021 17:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbhC2PKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Mar 2021 11:10:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:37130 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230347AbhC2PKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Mar 2021 11:10:05 -0400
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617030603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=czaWfQDmWfTZZyk40/r3fn5m8w82rCTMKw/DG6KyCoA=;
        b=3lmkfVXQ6Kn8x60NUjbCQEHJ6ITAaNLJLrTnRuRX79GChppNS9h4DSkLF9ihUdwo1uxBBf
        nRbSqQ7ZgOFX/uwi8bTzSHRM2J7jRcMz+LBfdbllOjxGHkLMkCsWez4kglhEbvuHhpEUUs
        IckgkHO26+svKMgFIWzihmC95ey6tfnNRWzz33LTUZn5t6psLWN5YNgYffoS5d/azDT+4F
        R8YtzpNyVod55yDrfeqRVze0rWL4ZPvemU3Qvb7xvlqL2wEbZQrLZmQwA+f2tlDQdvYNHz
        XcUrWIXlJ6UH4PiTv6M/UYTqpmgVxiA3F7vils6OtvtTO4ZQW7Dv93hVGX8P2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617030603;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=czaWfQDmWfTZZyk40/r3fn5m8w82rCTMKw/DG6KyCoA=;
        b=IAdBFzE0yMQolHI4rDtJPaIUbjeNL+Gd3Mx/YUdTHGxrOCZhymDMIWuCIWSOB9MI2RgLFn
        p9Fb5UQys2JfXMAg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
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
In-Reply-To: <YGGmNu5ilDnSKH3g@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de> <20210316233326.10778-3-john.ogness@linutronix.de> <YFnHKlCvIA2nI41c@alley> <87pmzmi2xm.fsf@jogness.linutronix.de> <YGGmNu5ilDnSKH3g@alley>
Date:   Mon, 29 Mar 2021 17:10:02 +0200
Message-ID: <87sg4e6lo5.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-29, Petr Mladek <pmladek@suse.com> wrote:
> I wonder if some console drivers rely on the fact that the write()
> callback is called with interrupts disabled.
>
> IMHO, it would be a bug when any write() callback expects that
> callers disabled the interrupts.

Agreed.

> Do you plan to remove the console-spinning stuff after offloading
> consoles to the kthreads?

Yes. Although a similar concept will be introduced to allow the threaded
printers and the atomic consoles to compete.

> Will you call console write() callback with irq enabled from the
> kthread?

No. That defeats the fundamental purpose of this entire rework
excercise. ;-)

> Anyway, we should at least add a comment why the interrupts are
> disabled.

I decided to move the local_irq_save/restore inside the console-spinning
functions and added a comment for v2.

John Ogness
