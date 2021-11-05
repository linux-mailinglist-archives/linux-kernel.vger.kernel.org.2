Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A64C446B65
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Nov 2021 00:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbhKFAAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Nov 2021 20:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233311AbhKFAAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Nov 2021 20:00:34 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CF0C061570
        for <linux-kernel@vger.kernel.org>; Fri,  5 Nov 2021 16:57:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c126so1763398pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 Nov 2021 16:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=7RtiW0pQ1DeZ6xW39uygZoCvZ6G5gkm0qqg2xuDv39s=;
        b=fhngLAxI7xCPGK4Uz8L9zi7m7RBoassfm1q8MFWqcWzhNJmPM4b7p7f/OXAXcYaJIr
         uWtk/wt9JDRpHaNgsFkJjiIoQc8GzNWGsxSSUsVtPbCfzxyha8CKWowM0seP+Ds6P3xv
         SaBw2lftmRGGcGo3MTHS/Jee2LgTgUDUtgW999uWxYjXMw55HJYmF3fPAhnnmroz6YnI
         HS5G8rqRSXayM5Bg6MVfGgImJSgdKbgFLpb/MpQ8zsXLURSVQsbhtdVCYk/hasnDwapC
         +rl8oZZyHJazG+vhW1hsaKwjg8qDsnaGDvUPvT5cQeVCcPBdMhwR7XRkoNDHH1VcPMel
         RtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=7RtiW0pQ1DeZ6xW39uygZoCvZ6G5gkm0qqg2xuDv39s=;
        b=4tSRbdyW8cLnVkZoq8FSFqC/ih4ZWJwFaaRnDRgmd5JsOqI5BfeoP0hCjfrBmFL4zL
         SNw2vhhE7ZKoA18OU8WQyPCOnSRk6VSSht8r3UgA+iU4bhHHW8HEb2aB0wFjQfxI8dxv
         AOSqgaNkJm8nSkLuwOFGlORDuPoRAHYccAvbD6DHoI40+tHkzQyGhGFrHkFPClUjON2l
         ZEYlKWD0QOIDkSPZPSbYpIaD3aTX98DN35ITyVQHmFrGzMViQ9QKVMsYFBhG8jkFDKWS
         e2ZxaH/DUr72LPKEkAILVQR1Qv0aZpWsDrVMWzAP5xo0l3LEOZIOzch/qJw3HMd99SHV
         KKkg==
X-Gm-Message-State: AOAM532emsNrk9TPtMtBZka6hHJCO4e8rx4P5wGWIMCwCicMAnMFBiNQ
        ITRGsZp32tMrCEXyw/E8b3R1878HvVY=
X-Google-Smtp-Source: ABdhPJwOpodW0Y4tGu+r5Vz9TjTJrucayEpC1UBH0cZu2R9S4kvmD5Mchwe9smA0hP49Kujo780o7Q==
X-Received: by 2002:a63:131c:: with SMTP id i28mr46866006pgl.396.1636156673261;
        Fri, 05 Nov 2021 16:57:53 -0700 (PDT)
Received: from localhost (60-241-46-56.tpgi.com.au. [60.241.46.56])
        by smtp.gmail.com with ESMTPSA id p14sm7076267pjl.32.2021.11.05.16.57.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Nov 2021 16:57:52 -0700 (PDT)
Date:   Sat, 06 Nov 2021 09:57:47 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: Removal of printk safe buffers delays NMI context printk
To:     John Ogness <john.ogness@linutronix.de>,
        Petr Mladek <pmladek@suse.com>
Cc:     Laurent Dufour <ldufour@linux.ibm.com>,
        linux-kernel@vger.kernel.org
References: <1636039236.y415994wfa.astroid@bobo.none>
        <87ee7vki7f.fsf@jogness.linutronix.de>
        <1636073838.qpmyp6q17i.astroid@bobo.none>
        <87r1bv2aga.fsf@jogness.linutronix.de>
        <1636111599.wwppq55w4t.astroid@bobo.none>
        <87h7cqg0xk.fsf@jogness.linutronix.de> <YYVakNdzjrYuBmhf@alley>
In-Reply-To: <YYVakNdzjrYuBmhf@alley>
MIME-Version: 1.0
Message-Id: <1636156115.ubjgngowl8.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Petr Mladek's message of November 6, 2021 2:23 am:
> On Fri 2021-11-05 15:03:27, John Ogness wrote:
>> On 2021-11-05, Nicholas Piggin <npiggin@gmail.com> wrote:
>> >> What was removed from 93d102f094b was irq_work triggering on all
>> >> CPUs.
>> >
>> > No, it was the caller executing the flush for all remote CPUs itself.
>> > irq work was not involved (and irq work can't be raised in a remote
>> > CPU from NMI context).
>>=20
>> Maybe I am missing something. In 93d102f094b~1 I see:
>>=20
>> watchdog_smp_panic
>>   printk_safe_flush
>>     __printk_safe_flush
>>       printk_safe_flush_buffer
>>         printk_safe_flush_line
>>           printk_deferred
>>             vprintk_deferred
>>               vprintk_emit (but no direct printing)
>>               defer_console_output
>>                 irq_work_queue
>>=20
>> AFAICT, using defer_console_output() instead of your new printk_flush()
>> should cause the exact behavior as before.
>=20
> I agree. printk_safe_flush() used printk_deferred(). It only queued
> the irq_work and never called consoles directly.
>=20
>> > but we do need that printk flush capability back there and for
>> > nmi_backtrace.
>>=20
>> Agreed. I had not considered this necessary side-effect when I removed
>> the NMI safe buffers.
>=20
> Honestly, I do not understand why it stopped working or how
> it worked before.
>=20
> printk() calls vprintk(). Current vprintk() does:
>=20
> asmlinkage int vprintk(const char *fmt, va_list args)
> {
> [...]
> 	/*
> 	 * Use the main logbuf even in NMI. But avoid calling console
> 	 * drivers that might have their own locks.
> 	 */
> 	if (this_cpu_read(printk_context) || in_nmi()) {
> 		int len;
>=20
> 		len =3D vprintk_store(0, LOGLEVEL_DEFAULT, NULL, fmt, args);
> 		defer_console_output();
> 		return len;
> 	}
>=20
> 	/* No obstacles. */
> 	return vprintk_default(fmt, args);
> }
>=20
> By other words, current vprintk():
>=20
>    + queues irq_work() in NMI context
>    + tries to flush consoles immeditely otherwise
>=20
>=20
>> I am just wondering if we should fix the regression by going back to
>> using irq_work (such as defer_console_output()) or if we want to
>> introduce something new that introduces direct printing.
>=20
> Yup, defer_console_output() should do the same as printk_safe_flush()
> before. We do not longer need to copy the messages because they are
> already in the main lockless log buffer.
>=20
> Well, I am curious about the original code. The commit 93d102f094be9beab2=
8e5
> ("printk: remove safe buffers") did the following:
>=20
> diff --git a/arch/powerpc/kernel/watchdog.c b/arch/powerpc/kernel/watchdo=
g.c
> index c9a8f4781a10..dc17d8903d4f 100644
> --- a/arch/powerpc/kernel/watchdog.c
> +++ b/arch/powerpc/kernel/watchdog.c
> @@ -183,11 +183,6 @@ static void watchdog_smp_panic(int cpu, u64 tb)
> =20
>         wd_smp_unlock(&flags);
> =20
> -       printk_safe_flush();
> -       /*
> -        * printk_safe_flush() seems to require another print
> -        * before anything actually goes out to console.
> -        */
>         if (sysctl_hardlockup_all_cpu_backtrace)
>                 trigger_allbutself_cpu_backtrace();
>=20
> And I am curious because:
>=20
>    + Why was printk_safe_flush() called before triggering backtraces
>      on other CPUs?

I commented about that earlier in the thread. The flush is for a=20
previous non-maskable IPI. trigger_allbutself_cpu_backtrace is not NMI=20
on powerpc it's just regular irq context so if they did respond to it=20
they would also be able to run the irq work.

>    + The comment says that another print is needed before the messages
>      goes to the console. It makes sense because printk_safe_flush()
>      only set irq_work. But the patch did not remove any printk().
>      So, nobody called any printk() even before.

I think that was my misunderstanding as to the problem. The NMI IPI is
actually asynchronous so it was not guaranteed that targets had
completed their backtraces at this point. powerpc watchdog needs a
separate fix (after which it seems to work fine with printk_safe_flush)

Thanks,
Nick
