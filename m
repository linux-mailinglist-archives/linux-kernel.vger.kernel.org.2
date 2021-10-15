Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB43642EC34
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 10:25:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237026AbhJOI1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 04:27:45 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:50913 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbhJOI0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 04:26:23 -0400
Received: from mail-wm1-f45.google.com ([209.85.128.45]) by
 mrelayeu.kundenserver.de (mreue107 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1MwgOK-1mvpAb2fog-00yCVf for <linux-kernel@vger.kernel.org>; Fri, 15 Oct
 2021 10:24:15 +0200
Received: by mail-wm1-f45.google.com with SMTP id 63-20020a1c0042000000b0030d60716239so2181662wma.4
        for <linux-kernel@vger.kernel.org>; Fri, 15 Oct 2021 01:24:15 -0700 (PDT)
X-Gm-Message-State: AOAM530ntYPj/RCDAPfwfRLINe+2aEfOyyIJWZdTr5m9MeLOsdaHzPDV
        jxJvC7sT1Xa4na9PaWyi8+89ks1CGy+Vw5uuJeY=
X-Google-Smtp-Source: ABdhPJw+iae7sMAEvm//VXy8JWsBbDtRt1xIuMEhy0ueNQukNYue+1ZSxfxd4B6QZbKoUCvnbO2ftNX7hM2i80N9ulA=
X-Received: by 2002:a05:600c:208:: with SMTP id 8mr23986013wmi.173.1634286255249;
 Fri, 15 Oct 2021 01:24:15 -0700 (PDT)
MIME-Version: 1.0
References: <20211015005923.2659140-1-alistair.francis@opensource.wdc.com>
In-Reply-To: <20211015005923.2659140-1-alistair.francis@opensource.wdc.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 15 Oct 2021 10:23:59 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3GVcjPp+ANKQvgMaDLqN4xAhNv+3jSO5gUMRszsARtFA@mail.gmail.com>
Message-ID: <CAK8P3a3GVcjPp+ANKQvgMaDLqN4xAhNv+3jSO5gUMRszsARtFA@mail.gmail.com>
Subject: Re: [PATCH] uapi: futex: Add a futex syscall
To:     Alistair Francis <alistair.francis@opensource.wdc.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alistair Francis <alistair23@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:C2NN3JTjUizKfUA95+g9Yy7QRfgmqIh52QQ8/DXlwAqTsIqLzL7
 llw/K+HoJOkuarltAA6VCLWEenPrHRUQbMahvT9HyIdCqs/JWByGbcm2JFsuY6cMn6PqC1+
 4rvpdmEv7jLImY2V2ZZ2qmwoW0i0BS7IpLVVZ9mHfKTCFYW7PzReMrP/SWB35nZXS2EkFP2
 zQLejL+aXSwMux8Sw9NYw==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:4iKev+7VRjM=:V74JSf/lqpLBKXC9f0SHD1
 EWc7chNK0vXCpb4g+C+K8ytLCpNgXO5UbhTjmT08P77M3yGwFDimAywMvGTP2NXzsdReQaUmS
 aC6JtYFGMzABvyFOHUxdZQxXXYDZ2RdQ934VnGvlwtLsyfEcHD7hkKJ1WTFcGR6Vl/JOHMgQx
 C7DhCG2DY38zA8+MMZJvOQjfAQY5AN1l03XPGvmKaNpjl7BOa1aCv0nxAd5X0HyNi+xvpJKgR
 Ag9DfzMscyD5zXeFsLdrxSqdsjZ8iHkzrYLf4myFAYEQo/SMX9IvSq2VgHCAE3Ixk/pzclrIb
 Ac4i8OtvAlPhEsaE9Z8FP6PYSkn3AHYcOnaZ7MJeDANZc83ggpv/RNEFVsTi81vPwr0zoZc4u
 MWghU0U9NG6coFas5yqDHWi4dNyM+Ksvdmh5UV1q04elozswC4F6dy/+gWIoJXTdGJHndWe21
 mA86ohZh+mgp/mbY9CrQ6oAHuJx7/9IZ1/dalIIzJFPJ5kFtySj+O5/5z+wBQmPE6GkhByO4k
 1ONlPrM3uVWbeMwwPe7Pgbux7gGWlxYYqga8n0kS1bU+UFEDeS9WictHX0+DbtGLLwtS1Pq21
 NYVBeUuEQogL9R4OmQAcBGplkt4M63I3l/4bQPB4NtHqFbClp6La96rfJWhV9PmI/rKpd4sn6
 KEvV4fr2EKmo5XdofmqO0uiuta/d0kXWJRq9N+jy9P3HF8NQU6lkVaNNP3rRCfc9VLm5TlsaM
 7kxKWIoEs0Zju3I5/0yJ71xN47QLehGO6lunK2gwSlRHAGCznXDbLaoQj281LNWeHEEn1iGX5
 Jg1agv2/TnAY5Y5zYJQmzgXE0v9Sg7GGyL5LiC+RZNKemH8pBoxGy2aOBiyZRD9DICQTUxcig
 tQIM9RdBNYw5kw5upXEA==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 2:59 AM Alistair Francis
<alistair.francis@opensource.wdc.com> wrote:
>
> From: Alistair Francis <alistair.francis@wdc.com>
>
> This commit adds two futex syscall wrappers that are exposed to
> userspace.
>
> Neither the kernel or glibc currently expose a futex wrapper, so
> userspace is left performing raw syscalls. This has mostly been becuase
> the overloading of one of the arguments makes it impossible to provide a
> single type safe function.
>
> Until recently the single syscall has worked fine. With the introduction
> of a 64-bit time_t futex call on 32-bit architectures, this has become
> more complex. The logic of handling the two possible futex syscalls is
> complex and often implemented incorrectly.
>
> This patch adds two futux syscall functions that correctly handle the
> time_t complexity for userspace.
>
> This idea is based on previous discussions: https://lkml.org/lkml/2021/9/21/143
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks a lot for taking this on!

The implementation looks good to me, I've just noted some details below.

The big question here is the exact one that has kept the wrappers out of
glibc and musl for now: What should the function prototype(s) be?

I see you went with having two distinct function names for the two
sets of argument types, which I think was what the glibc developers
were leaning towards.

I think it would be nicer to use a transparent union like

typedef union __attribute__((__transparent_inion__)) {
        struct timespec *timeout;
        u_int32_t nr_requeue;
} __futex_arg4;

which would let us provide a single function for both variants.
The main downside is that this relies on a GCC extension, but I
don't expect that to be a problem since any code using this is
already nonportable.

The other question here is what namespace to use. You went for the
non-prefixed futex_syscall, which is clearly nicer to use in an application,
but it might clash with libc providing the same function name in the
future. We could consider using __kernel_futex() as the function name,
putting it into a private namespace for the kernel headers that could
then get wrapped again by an application or libc using it.

> +#include <errno.h>
> +#include <linux/types.h>
> +#include <linux/time_types.h>

I wonder if this should also #include <asm/unistd.h> and
<sys/syscall.h>, or if you
can leave that to the caller to include either <asm/unistd.h.> or <unistd.h>.

> +/**
> + * futex_syscall_timeout() - __NR_futex/__NR_futex_time64 syscall wrapper
> + * @uaddr:  address of first futex
> + * @op:   futex op code
> + * @val:  typically expected value of uaddr, but varies by op
> + * @timeout:  an absolute struct timespec
> + * @uaddr2: address of second futex for some ops
> + * @val3: varies by op
> + */
> +static inline int
> +futex_syscall_timeout(volatile u_int32_t *uaddr, int op, u_int32_t val,
> +                     struct timespec *timeout, volatile u_int32_t *uaddr2, int val3)
> +{
> +#if defined(__NR_futex_time64)
> +       if (sizeof(*timeout) != sizeof(struct __kernel_old_timespec)) {
> +               int ret =  syscall(__NR_futex_time64, uaddr, op, val, timeout, uaddr2, val3);
> +
> +               if (ret == 0 || errno != ENOSYS)
> +                       return ret;
> +       }
> +#endif
> +
> +#if defined(__NR_futex)
> +       if (sizeof(*timeout) == sizeof(struct __kernel_old_timespec))
> +               return syscall(__NR_futex, uaddr, op, val, timeout, uaddr2, val3);
> +
> +       if (timeout && timeout->tv_sec == (long)timeout->tv_sec) {

Not sure if we actually need to reject timeouts that overflow, should probably
check what glibc does for this case. Intuitively, I'd go with setting
tv_sec=LONG_MAX.

> +               struct __kernel_old_timespec ts32;
> +
> +               ts32.tv_sec = (__kernel_long_t) timeout->tv_sec;
> +               ts32.tv_nsec = (__kernel_long_t) timeout->tv_nsec;
> +
> +               return syscall(__NR_futex, uaddr, op, val, ts32, uaddr2, val3);

You need to pass 'ts32' by reference here.

          Arnd
