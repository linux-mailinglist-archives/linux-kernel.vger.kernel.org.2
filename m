Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE20F336B34
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Mar 2021 05:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231180AbhCKEl2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 23:41:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhCKElB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 23:41:01 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24047C061574
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 20:41:01 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id h18so17821653ils.2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 20:41:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QfY9o5qVU+uaM0GkTw3MH4V3esABZsaKGtxvHD5Dq8=;
        b=IhYpCm80Np4hg6Xo6Wyld4fgWI9hbM7PL0geE+DexqPqb9aiwIfGrVV4rWhVRORrso
         c7rIasHuArlq3WDixS3xmHnlFQ1AxCF+0lYfILz5qjqtaEee9BL+5WzSfguFqm13psuI
         mvrX2yYzT17e31WZY5Jak1OroUDN+BfH8XuTqoYQUgVYAWvrn9+eqpFuJtOjx2WMQgXt
         7C9SvKNQS/dYaONPjv/+uYdeXWrFX9Zi6OpyEKioc1Uac+gQpN2VxxHdD6cjFNA41HT0
         Ohf9H93qOYxlA4v1/G8cv1/6xH8rnmxkKeQ2zJnjzHP3xDsbyLXb0uXR5mlKl0qglevA
         06rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QfY9o5qVU+uaM0GkTw3MH4V3esABZsaKGtxvHD5Dq8=;
        b=Ow6XAE6lzQ9NASHqlp4FqyPuKJBG7ghoeI39Di0wUStYtFGXMkTzoqtNfxvsyQ0PK5
         6+1L9mEa1dLB8rVu9HTk+7i5/5EbNVuRzhZiYWDxZM0OncnbW5TxC4wo6DzpvvqLyvwz
         Mfb7i6USrBf4J428YCVRCZiUEFd9U1UCfkI0uqpLbrrn+QgrNtnU6tWcxdHMFJ+wBOlr
         sE/s3AHeT9CZ7noGGVqda8T0qBOXtpFVnp1paWNgYFVcBbMx0YGA16HXrbMczmGtavk2
         1kIUYyQ4y//JRy1fqbuhDyzaNuzc3HD82GZxUacxRCOqHt0iNDs88M+CbnZl9VC9LMrv
         3TKQ==
X-Gm-Message-State: AOAM532gl6kVS+x+4W7pzOVRQIt6X4xL/SECgBuB+YIlsoemUJDFrwFM
        xymvP17JEmZi8ka+rbo02AoLpSDlZiH4klT4TQg=
X-Google-Smtp-Source: ABdhPJyD+UCsIwWx8KroENXJ+JxvYXxKwKTelemz45ek9agrb0bW6PtJcYPemDDbkEqq6B447GXR/beU1PecnDF7Gqw=
X-Received: by 2002:a05:6e02:1bec:: with SMTP id y12mr5273816ilv.214.1615437660537;
 Wed, 10 Mar 2021 20:41:00 -0800 (PST)
MIME-Version: 1.0
References: <1615296712-175334-1-git-send-email-zhaoqianligood@gmail.com>
 <20210309182657.GA1408@redhat.com> <CAPx_LQEQto2fget=kCnfjSCdAp9XCwc2AWgzwxpbxdyCgNs5Mg@mail.gmail.com>
 <m1lfavufep.fsf@fess.ebiederm.org>
In-Reply-To: <m1lfavufep.fsf@fess.ebiederm.org>
From:   qianli zhao <zhaoqianligood@gmail.com>
Date:   Thu, 11 Mar 2021 12:40:49 +0800
Message-ID: <CAPx_LQF90joRVLCjR9M44uZ0829Ktw3GAFStdOWEBANGLfDvdQ@mail.gmail.com>
Subject: Re: [PATCH] exit: trigger panic when init process is set to SIGNAL_GROUP_EXIT
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, christian@brauner.io,
        axboe@kernel.dk, Thomas Gleixner <tglx@linutronix.de>,
        Peter Collingbourne <pcc@google.com>,
        linux-kernel@vger.kernel.org, Qianli Zhao <zhaoqianli@xiaomi.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Eric
Thank you for your suggestion

> At the start of your changelog and your patch subject you describe what
> you are doing but not why.  For the next revision of the patch please
> lead with the why it makes what you are trying to do much easier to
> understand.

got it.

>
> It does not work to use SIGNAL_UNKILLABLE for this.  Normally init
> has SIGNAL_UNKILLABLE set.  The only case that clears SIGNAL_UNKILLABLE
> is force_sig_info_to_task.  If the init process exits with exit(2)
> SIGNAL_UNKILLABLE will already be set.  Which means testing
> SIGNAL_UNKILLABLE as your patch does will prevent the panic.
>

Ok,using SIGNAL_UNKILLABLE is incorrect.

> Further simply calling panic is sufficient to guarantee that the other
> threads don't exit, and that whichever thread calls panic first
> will be the reporting thread.  The rest of the threads will be caught
> in panic_smp_self_stop(), if they happen to be running on other cpus.
>
> So I would make the whole thing just be:
>
>         /* If global init has exited,
>          * panic immediately to get a useable coredump.
>          */
>         if (unlikely(is_global_init(tsk) &&
>             (thread_group_empty(tsk) ||
>             (tsk->signal->flags & SIGNAL_GROUP_EXIT)))) {
>                 panic("Attempted to kill init!  exitcode=0x%08x\n",
>                         tsk->signal->group_exit_code ?: (int)code);
>         }
>
> The thread_group_empty test is needed to handle single threaded
> inits.
>
> Do you think you can respin your patch as something like that?
>

Ok.it's a very good change,other CPUs calls to panic() will be caught
and execute panic_smp_self_stop(),
there is no need to deal with this situation separately when other CPUs exit().
