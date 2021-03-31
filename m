Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C174634FAFB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Mar 2021 10:00:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbhCaH7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Mar 2021 03:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234098AbhCaH7n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Mar 2021 03:59:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE8FAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 31 Mar 2021 00:59:42 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617177580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwENOV5fEtmm72Pvhge8smr8aYXEWHQVNQRqr1NurZ8=;
        b=HgYwf+F5t8/gQgaF2YZ17DNXo2yFb0pVTZn0ZbtZzqd8Y8Sahi6vDVeZ0yDH70XJiw0lYy
        IK406t8beuNJxH/nzZQzcWA/+RKwjqyUs73YOdDIcQaxefWARdaqrvvi8vrYEBXmgHaHr+
        /FYl89dM6MubMB7wiK1nxPRKCKwPD2bGb5i9UPJU7tgIY2LiqAVuAwuunDsFRrSDNh0I4v
        WlfdgErhyH1WDEQToFUy5Z/KFpxMkU1s6CQxFPHluQW67Vj+WuamrzwdOP99FhY4iMolJ5
        ehk4vzv9DwvPis/DM3Em1aEAz+5bwH2MpcfVmgMKTdLWSbSGGgbu/DijF3vdww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617177580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EwENOV5fEtmm72Pvhge8smr8aYXEWHQVNQRqr1NurZ8=;
        b=OFsxY0ULFZzlVDBhGsXuic6UtSXoqjsWNTcAn2ba/w5Yp2FKfdTtXYRsqVzLZI5u8tMC41
        ZAd55frkyv+omGAQ==
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
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Jordan Niethe <jniethe5@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        Yue Hu <huyue2@yulong.com>, Rafael Aquini <aquini@redhat.com>,
        "Guilherme G. Piccoli" <gpiccoli@canonical.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        linuxppc-dev@lists.ozlabs.org, kexec@lists.infradead.org
Subject: Re: [PATCH printk v2 2/5] printk: remove safe buffers
In-Reply-To: <20210330153512.1182-3-john.ogness@linutronix.de>
References: <20210330153512.1182-1-john.ogness@linutronix.de> <20210330153512.1182-3-john.ogness@linutronix.de>
Date:   Wed, 31 Mar 2021 09:59:39 +0200
Message-ID: <875z17vjmc.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-30, John Ogness <john.ogness@linutronix.de> wrote:
> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> index e971c0a9ec9e..f090d6a1b39e 100644
> --- a/kernel/printk/printk.c
> +++ b/kernel/printk/printk.c
> @@ -1772,16 +1759,21 @@ static struct task_struct *console_owner;
>  static bool console_waiter;
>=20=20
>  /**
> - * console_lock_spinning_enable - mark beginning of code where another
> + * console_lock_spinning_enable_irqsave - mark beginning of code where a=
nother
>   *	thread might safely busy wait
>   *
>   * This basically converts console_lock into a spinlock. This marks
>   * the section where the console_lock owner can not sleep, because
>   * there may be a waiter spinning (like a spinlock). Also it must be
>   * ready to hand over the lock at the end of the section.
> + *
> + * This disables interrupts because the hand over to a waiter must not be
> + * interrupted until the hand over is completed (@console_waiter is clea=
red).
>   */
> -static void console_lock_spinning_enable(void)
> +static void console_lock_spinning_enable_irqsave(unsigned long *flags)

I missed the prototype change for the !CONFIG_PRINTK case, resulting in:

linux/kernel/printk/printk.c:2707:3: error: implicit declaration of functio=
n =E2=80=98console_lock_spinning_enable_irqsave=E2=80=99; did you mean =E2=
=80=98console_lock_spinning_enable=E2=80=99? [-Werror=3Dimplicit-function-d=
eclaration]
   console_lock_spinning_enable_irqsave(&flags);
   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   console_lock_spinning_enable

Will be fixed for v3.

(I have now officially added !CONFIG_PRINTK to my CI tests.)

John Ogness
