Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84C5B34A66A
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Mar 2021 12:24:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbhCZLX4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Mar 2021 07:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229753AbhCZLXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Mar 2021 07:23:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AE57C0613AA
        for <linux-kernel@vger.kernel.org>; Fri, 26 Mar 2021 04:23:39 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616757817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mRLSZQ6r/i5uAgZO4Pnx1DA/UH2ftlRhR3DU3PS/hkc=;
        b=oYYGpNpqJlsDyXOReEiLdoor1l1XpQQENWvFkjnxw8XNHMLuxQ41/cgauNc/FDsVHt/0KP
        KiuxoMzkdHhL63vbBQqcfwhk5F0onPXzfbVfVHHTEVoyKfg4zLo2aG4Gcc42NPxADjO2ej
        YzBYgHKyxwUPG+AmBIaLzwc6XMJDAxW82e8+XgRoPiAAItDfPd9sGgTggANrAl54aZOoWG
        H92jcqED4zpkXXhw3jfMQ8MlWmSd9O+93evS27eU7C7dpCTG3Lb9gTfcFqV/YbQrSmHLDw
        reB5F0HU7u4D+Bzb9AJbAVs8Epp7o7MJec+dsQZi8820FLawB729uJLBnu+dtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616757817;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mRLSZQ6r/i5uAgZO4Pnx1DA/UH2ftlRhR3DU3PS/hkc=;
        b=gHfir+/VOT2qASsPyulH02Xy/8aMVavBJ2TFPMgyTu+AZrLt1mBVo9Wd58G/WcxtFrfjxD
        /eCkbauFtFynlWCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH next v1 3/3] printk: convert @syslog_lock to spin_lock
In-Reply-To: <YFnYiQX99oVv3JpU@alley>
References: <20210316233326.10778-1-john.ogness@linutronix.de> <20210316233326.10778-4-john.ogness@linutronix.de> <YFnYiQX99oVv3JpU@alley>
Date:   Fri, 26 Mar 2021 12:23:37 +0100
Message-ID: <87mtuqi2fa.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-23, Petr Mladek <pmladek@suse.com> wrote:

> On Wed 2021-03-17 00:33:26, John Ogness wrote:
>> @syslog_log was a raw_spin_lock to simplify the transition of
>
> s/syslog_log/syslog_lock/
>
> Same problem is also below.

Right.

>> removing @logbuf_lock and the safe buffers. With that transition
>> complete, @syslog_log can become a spin_lock.
>
> I know that we already talked about this. But I want to be sure
> that this patch makes sense.
>
> It will actually not change the behavior because we always
> take the lock with interrupts disabled.
>
> We disable the interrupts because register_console() is called
> in IRQ context on parisc in handle_interruption() when it is
> going to panic (code == 1 => will call parisc_terminate()).

Yes. [0]

> Disabling IRQ will not help in parisc_terminate(). This code
> path is non-maskable and never returns. The deadlock might be
> prevented only by trylock.
>
> trylock on syslog_lock is only small problem. Much bigger is
> is a deadlock on console_lock. Fixing this is beyond this
> patchset.
>
> Summary:
>
>     + disabling IRQ does not help for parisc
>
>     + register_console() is not irq safe in general because
>       of the sleeping console_lock.
>
>
> I would personally prefer to remove both "raw" and "irq"
> in this patch and just document the problem with parisc
> in the commit message.
>
> IMHO, it does not make sense to keep _irq when it neither
> helps nor makes sense.

I agree. I will change it for v2 and note in the commit message that the
parisc call chain:

handle_interruption(code=1) /* High-priority machine check (HPMC) */
  pdc_console_restart()
    pdc_console_init_force()
      register_console()

is unsafe and is the only register_console() user in atomic context.

John Ogness

[0] https://lore.kernel.org/lkml/8735xs10hi.fsf@jogness.linutronix.de
