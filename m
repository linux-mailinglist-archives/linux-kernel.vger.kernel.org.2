Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2794413B21
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 22:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233933AbhIUUOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 16:14:55 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50794 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhIUUOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 16:14:54 -0400
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632255204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0cT54wjFzwYV56IKeBKsvLuQnhMoza2aiMZO/77L1U=;
        b=c/I+9j7XlYYit/f+dzeRfOadmv+YowkHrnttT0o8abNF3RC+vJUCPcXeM9w/m7rXrZAEUv
        gdKamNjPTSeuOKen/7J8rTCSSndjv3pb54XuJVad5i2GUWSzIPcvAAGfTKaVNuAfx5szjG
        8kQprbFn4ncDyB5tDRiLu64QMFW8XxE7zZuQxFhLHQJbmzrKffKtDrM5ePVgKEDKnTtXwU
        R6J7Yhx3FKydlih4Q3DzbHYo457i2IqDPsqtPxzhAXbOTpKdesX8OXKrVNYgJyo1kpdz/Q
        05lzxCCgpRwufJmu7/eUPl45G5DteNTgQbWZ32Z1RIqUuwZ0sSfWyU0Rxk6tSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632255204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0cT54wjFzwYV56IKeBKsvLuQnhMoza2aiMZO/77L1U=;
        b=52STx6QOv542bH3YxfmYQ7eQWh7POFCKqj0k2/aKvn/HFyv3DEwFENzCXju0Fh99+tuehz
        FGbSVBVOOziSRfCQ==
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Peter Ziljstra <peterz@infradead.org>,
        Song Liu <songliubraving@fb.com>,
        Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [patch V3 15/20] x86/fpu/signal: Change return type of
 copy_fpregs_to_sigframe() helpers to boolean
In-Reply-To: <CADYN=9K1BdyupzcDAbyk2JTio1A98J9tsBS_LeOH4=GVG=7FqQ@mail.gmail.com>
References: <20210908130922.118265849@linutronix.de>
 <20210908132525.794334915@linutronix.de>
 <CADYN=9K1BdyupzcDAbyk2JTio1A98J9tsBS_LeOH4=GVG=7FqQ@mail.gmail.com>
Date:   Tue, 21 Sep 2021 22:13:23 +0200
Message-ID: <871r5h7km4.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 21 2021 at 12:58, Anders Roxell wrote:
> On Wed, 8 Sept 2021 at 15:30, Thomas Gleixner <tglx@linutronix.de> wrote:
>>
>> Now that copy_fpregs_to_sigframe() returns boolean the individual return
>> codes in the related helper functions do not make sense anymore. Change
>> them to return boolean success/fail.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> When I build and boot (qemu_x86_64) a defconfig kernel on from todays
> next tag next-20210921 I see the following segmentation fault
>
> 2021-09-21T10:11:45 <6>[    1.622922] mount (89) used greatest stack
> depth: 14384 bytes left
> 2021-09-21T10:11:45 <6>[    1.664760] EXT4-fs (sda): re-mounted. Opts:
> (null). Quota mode: none.
> 2021-09-21T10:11:45 <6>[    1.691041] mkdir (92) used greatest stack
> depth: 14312 bytes left
> 2021-09-21T10:11:45 <6>[    1.713201] mount (93) used greatest stack
> depth: 13720 bytes left
> 2021-09-21T10:11:46 Starting syslogd: /etc/init.d/rcS: line 12:   101
> Segmentation fault      $i start
>
>
> I did a bisection and found this as the faulty patch [1]. When I
> revert this patch I can't see the issue.
>
> We noticed that function 'save_xstate_epilog()' changes the polarity
> of its return code for one of the return statements, and for its only
> caller. but not for the other return statement.
>
> I tried this patch and I couldn't see the segmentation fault.
>
> diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
> index 445c57c9c539..61eeebc04427 100644
> --- a/arch/x86/kernel/fpu/signal.c
> +++ b/arch/x86/kernel/fpu/signal.c
> @@ -104,7 +104,7 @@ static inline int save_xstate_epilog(void __user
> *buf, int ia32_frame)
>         err = __copy_to_user(&x->i387.sw_reserved, sw_bytes, sizeof(*sw_bytes));
>
>         if (!use_xsave())
> -               return err;
> +               return !err;

Oops. Good catch. Care to send a proper patch for this?

Thanks,

        tglx
