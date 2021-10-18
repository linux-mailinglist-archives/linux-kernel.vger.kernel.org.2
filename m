Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75DD430E66
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 05:42:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231579AbhJRDom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Oct 2021 23:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbhJRDoE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Oct 2021 23:44:04 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E9FC06161C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 20:41:53 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id z69so11485197iof.9
        for <linux-kernel@vger.kernel.org>; Sun, 17 Oct 2021 20:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=igK1nZ8hc/5gJ85bo2+Q9TJzU65v5Shm38MGnbxn7Ew=;
        b=KKR1riqS+v5Uz6N8UA1J8fkYUd+5A9yaKtHwDoZRChZNwvVBOoUcXSywZxk7Mmratp
         m2OHhcbZ5ddOiLErwwz4haDBfDhSMg4bwRxnIqSMGE4/6LrKpfm65GrgkCizAl0XHV60
         1L5IOqtoF1RCMdhNlzO81G5sQ6Sj6w7rE/rJzRqPhcK4bf8fCuFakOvF7DH3m5V5GIEe
         x/LPdmtXKyfl9UTY2XFobrANDAKYHLV/Uk2oOItue25GK0s8EZQ5gooxb14byeMrcyU9
         DoVSry/VoECoY/WDsfu8VJIgmQb6bW0Mdm4zF/KMz2CMC/2ROgm0gcNkhDdRzTGaY+HU
         P9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=igK1nZ8hc/5gJ85bo2+Q9TJzU65v5Shm38MGnbxn7Ew=;
        b=UnjUftoTtRMVOJYU87TW2+sAK/Wi2rwt68OC9RY6jewpsq/LLPxrL0pmje7jXFtr9n
         pxZm5cyTDbAbJGdugDPO+4bqdLOspR55O7N5bhsM+UgPpR81K6izY5fp6esDnoZ3odSS
         AnIKV5TMPPfQtUcQ0OcD9o/OEchtbAr5q8xtgibMwO/7as3VkefqONyLZ+VWekscwN4T
         oTuJ2vQobUJhx0oPfAENHd0JJULQrxXSHdRGJCVBOpX0Xb7/Ect+Ra7jH5YbXcySSHbQ
         x3dLBv+55zIx4accw33Y9AbFTF/B+PpN0yHdvUoDBAgjGcoR/LQrHIbDjSaNbJ7uFB4B
         qkQA==
X-Gm-Message-State: AOAM530b9h3WF9GJmyl07j+a7dSoDVltgqG96eez07rnRWKhcdvREcvd
        V1Slo0ies9xvv5TMO4gJWOv2EJfRotCoV1DWNigG0q8VXSPfReW1k9A=
X-Google-Smtp-Source: ABdhPJy+U03GtKCF3PZVkmS25SgT+7WnzUIcsomRjPeCAd82IsHPdd0G78jX1Zj00XnNNguQHVEeeHBoeO1SuB5FF5k=
X-Received: by 2002:a02:a786:: with SMTP id e6mr16086736jaj.117.1634528512901;
 Sun, 17 Oct 2021 20:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20211015005923.2659140-1-alistair.francis@opensource.wdc.com> <CAK8P3a3GVcjPp+ANKQvgMaDLqN4xAhNv+3jSO5gUMRszsARtFA@mail.gmail.com>
In-Reply-To: <CAK8P3a3GVcjPp+ANKQvgMaDLqN4xAhNv+3jSO5gUMRszsARtFA@mail.gmail.com>
From:   Alistair Francis <alistair23@gmail.com>
Date:   Mon, 18 Oct 2021 13:41:26 +1000
Message-ID: <CAKmqyKNZm+w=WhUXPRLs-UWCwgBpZzt=4DMne-FbfBe=UjSrKw@mail.gmail.com>
Subject: Re: [PATCH] uapi: futex: Add a futex syscall
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Alistair Francis <alistair.francis@opensource.wdc.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 6:24 PM Arnd Bergmann <arnd@arndb.de> wrote:
>
> On Fri, Oct 15, 2021 at 2:59 AM Alistair Francis
> <alistair.francis@opensource.wdc.com> wrote:
> >
> > From: Alistair Francis <alistair.francis@wdc.com>
> >
> > This commit adds two futex syscall wrappers that are exposed to
> > userspace.
> >
> > Neither the kernel or glibc currently expose a futex wrapper, so
> > userspace is left performing raw syscalls. This has mostly been becuase
> > the overloading of one of the arguments makes it impossible to provide a
> > single type safe function.
> >
> > Until recently the single syscall has worked fine. With the introduction
> > of a 64-bit time_t futex call on 32-bit architectures, this has become
> > more complex. The logic of handling the two possible futex syscalls is
> > complex and often implemented incorrectly.
> >
> > This patch adds two futux syscall functions that correctly handle the
> > time_t complexity for userspace.
> >
> > This idea is based on previous discussions: https://lkml.org/lkml/2021/9/21/143
> >
> > Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
>
> Thanks a lot for taking this on!

No worries!

>
> The implementation looks good to me, I've just noted some details below.
>
> The big question here is the exact one that has kept the wrappers out of
> glibc and musl for now: What should the function prototype(s) be?
>
> I see you went with having two distinct function names for the two
> sets of argument types, which I think was what the glibc developers
> were leaning towards.
>
> I think it would be nicer to use a transparent union like
>
> typedef union __attribute__((__transparent_inion__)) {
>         struct timespec *timeout;
>         u_int32_t nr_requeue;
> } __futex_arg4;
>
> which would let us provide a single function for both variants.
> The main downside is that this relies on a GCC extension, but I
> don't expect that to be a problem since any code using this is
> already nonportable.

I don't love this. Relying on a GCC extension doesn't seem like a great idea.

As well as that we need to split the types out to check the timeout
value, and I'm not sure of how we could do that. We could have a
switch case on the futex op, but that seems likely to get out of sync.

>
> The other question here is what namespace to use. You went for the
> non-prefixed futex_syscall, which is clearly nicer to use in an application,
> but it might clash with libc providing the same function name in the
> future. We could consider using __kernel_futex() as the function name,
> putting it into a private namespace for the kernel headers that could
> then get wrapped again by an application or libc using it.

Sounds like a good idea, I'll update this.

>
> > +#include <errno.h>
> > +#include <linux/types.h>
> > +#include <linux/time_types.h>
>
> I wonder if this should also #include <asm/unistd.h> and
> <sys/syscall.h>, or if you
> can leave that to the caller to include either <asm/unistd.h.> or <unistd.h>.

I think the kernel test bot answered this question :)

I have added both.

>
> > +/**
> > + * futex_syscall_timeout() - __NR_futex/__NR_futex_time64 syscall wrapper
> > + * @uaddr:  address of first futex
> > + * @op:   futex op code
> > + * @val:  typically expected value of uaddr, but varies by op
> > + * @timeout:  an absolute struct timespec
> > + * @uaddr2: address of second futex for some ops
> > + * @val3: varies by op
> > + */
> > +static inline int
> > +futex_syscall_timeout(volatile u_int32_t *uaddr, int op, u_int32_t val,
> > +                     struct timespec *timeout, volatile u_int32_t *uaddr2, int val3)
> > +{
> > +#if defined(__NR_futex_time64)
> > +       if (sizeof(*timeout) != sizeof(struct __kernel_old_timespec)) {
> > +               int ret =  syscall(__NR_futex_time64, uaddr, op, val, timeout, uaddr2, val3);
> > +
> > +               if (ret == 0 || errno != ENOSYS)
> > +                       return ret;
> > +       }
> > +#endif
> > +
> > +#if defined(__NR_futex)
> > +       if (sizeof(*timeout) == sizeof(struct __kernel_old_timespec))
> > +               return syscall(__NR_futex, uaddr, op, val, timeout, uaddr2, val3);
> > +
> > +       if (timeout && timeout->tv_sec == (long)timeout->tv_sec) {
>
> Not sure if we actually need to reject timeouts that overflow, should probably
> check what glibc does for this case. Intuitively, I'd go with setting
> tv_sec=LONG_MAX.

gblic generally rejects these with EOVERFLOW, see:

https://github.com/bminor/glibc/blob/595c22ecd8e87a27fd19270ed30fdbae9ad25426/sysdeps/unix/sysv/linux/clock_settime.c#L46
https://github.com/bminor/glibc/blob/595c22ecd8e87a27fd19270ed30fdbae9ad25426/sysdeps/unix/sysv/linux/clock_adjtime.c#L40

>
> > +               struct __kernel_old_timespec ts32;
> > +
> > +               ts32.tv_sec = (__kernel_long_t) timeout->tv_sec;
> > +               ts32.tv_nsec = (__kernel_long_t) timeout->tv_nsec;
> > +
> > +               return syscall(__NR_futex, uaddr, op, val, ts32, uaddr2, val3);
>
> You need to pass 'ts32' by reference here.

Thanks! Fixed.

Alistair

>
>           Arnd
