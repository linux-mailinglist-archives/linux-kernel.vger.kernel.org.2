Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39E4319F91
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 14:12:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbhBLNMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 08:12:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231991AbhBLMzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 07:55:41 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07AA9C061788
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 04:55:00 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id m144so8510437qke.10
        for <linux-kernel@vger.kernel.org>; Fri, 12 Feb 2021 04:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A09MlorbuFhAqvAFLbguPfavL7t6ToDr/07aTs43MbM=;
        b=Eb5OnfMhAPrwXqVGpUWEPKMQ4nvls7ivfjFBf8679sFQJfuLh0V0TpXKVeVFaJlPoH
         cNspRM2qvEjiVIpKyoS994PkpxuM+qpqGYmWfJmCV8+cuQdrlTe56eaFU6rQ8wvRspJ3
         BHJBiuFqMgszxp9Bdv6FSnpQ8uY0LDODF5bQXuP6B8G8ogQE4QBNhqOI7Z2FjDc43cdf
         RYNi9we5eWvdV2/W5McFiResnHfuS0/LqssGBYZkgSGt585Nsk6RmktZHCgeHoQJhep8
         5j7YyQtBNlQ0Ah3PfcmKTRQ3kSohtDSt0WcmukTzFHdYzzqFKr04V1QBSh+9sO/5uXXo
         EuwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A09MlorbuFhAqvAFLbguPfavL7t6ToDr/07aTs43MbM=;
        b=Itggkx8eQS4dnYZ4TPxamYr6nDSd3itk8W6oUGaSDekXuXcb87LwY0nrUW5oUT/2Ci
         cyhjX22RNjk7btxFM7652vs/4V8pEK1TfmkbEYZERJ1ntusTOw4FPYghW15sp7EjERmU
         1dr5GJOLOAVBAn9V9uzC1fC7cdf1fE+NI0voc0+ZO6KmppPVkwJtaM2cx8vlAKdsPVLS
         zur7JeDnTQzKUdgwyLuqZJ4Odn7CaU5oQsmRPKUYm4a3wUIyluQ659DcqNzJNJuJAXol
         rnK9elL/zkWQK8Y+M3jcyw5oEfAP780+DdX1bYwLyzy4K/JjmF/QmhETEK41rEyJpJOg
         5YiA==
X-Gm-Message-State: AOAM533uwQEE+hHyO4ann30/O3W2d7UdluvVuIGY52cKmzbyRCZm5bLc
        3tD0hzWKcqyIbyiy8t0yX9rLe1SdU7eskJ28aI9Skw==
X-Google-Smtp-Source: ABdhPJzVQ42yn6IHy2reIyacbb/OQh0x+/coysVCLgtnd/DHKOIiNVAXcs+kxnnKGr96r3SvBfYviScwFvzDBFiQZXw=
X-Received: by 2002:a37:a757:: with SMTP id q84mr2310526qke.501.1613134498748;
 Fri, 12 Feb 2021 04:54:58 -0800 (PST)
MIME-Version: 1.0
References: <20210211080716.80982-1-info@alexander-lochmann.de>
In-Reply-To: <20210211080716.80982-1-info@alexander-lochmann.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 12 Feb 2021 13:54:47 +0100
Message-ID: <CACT4Y+YwRE=YNQYmQ=7RWde33830YOYr5pEAoYbrofY2JG43MA@mail.gmail.com>
Subject: Re: [PATCH] KCOV: Introduced tracing unique covered PCs
To:     info@alexander-lochmann.de
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzkaller <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 11, 2021 at 9:07 AM Alexander Lochmann
<info@alexander-lochmann.de> wrote:
>
> Introduced new tracing mode KCOV_MODE_UNIQUE.
> It simply stores the executed PCs.
> The execution order is discarded.
> Each bit in the shared buffer represents every fourth
> byte of the text segment.
> Since a call instruction on every supported
> architecture is at least four bytes, it is safe
> to just store every fourth byte of the text segment.
> In contrast to KCOV_MODE_TRACE_PC, the shared buffer
> cannot overflow. Thus, all executed PCs are recorded.
>
> Signed-off-by: Alexander Lochmann <info@alexander-lochmann.de>
> ---
>  Documentation/dev-tools/kcov.rst | 80 ++++++++++++++++++++++++++++++++
>  include/linux/kcov.h             |  4 +-
>  include/uapi/linux/kcov.h        | 10 ++++
>  kernel/kcov.c                    | 67 ++++++++++++++++++++------
>  4 files changed, 147 insertions(+), 14 deletions(-)
>
> diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
> index 8548b0b04e43..4712a730a06a 100644
> --- a/Documentation/dev-tools/kcov.rst
> +++ b/Documentation/dev-tools/kcov.rst
> @@ -127,6 +127,86 @@ That is, a parent process opens /sys/kernel/debug/kcov, enables trace mode,
>  mmaps coverage buffer and then forks child processes in a loop. Child processes
>  only need to enable coverage (disable happens automatically on thread end).
>
> +If someone is interested in a set of executed PCs, and does not care about
> +execution order, he or she can advise KCOV to do so:
> +
> +.. code-block:: c
> +
> +    #include <stdio.h>
> +    #include <stddef.h>
> +    #include <stdint.h>
> +    #include <stdlib.h>
> +    #include <sys/types.h>
> +    #include <sys/stat.h>
> +    #include <sys/ioctl.h>
> +    #include <sys/mman.h>
> +    #include <unistd.h>
> +    #include <fcntl.h>
> +
> +    #define KCOV_INIT_TRACE                    _IOR('c', 1, unsigned long)
> +    #define KCOV_INIT_UNIQUE                _IOR('c', 2, unsigned long)
> +    #define KCOV_ENABLE                        _IO('c', 100)
> +    #define KCOV_DISABLE                       _IO('c', 101)
> +
> +    #define BITS_PER_LONG 64
> +    #define KCOV_TRACE_PC  0
> +    #define KCOV_TRACE_CMP 1
> +    #define KCOV_UNIQUE_PC 2
> +    /*
> +     * Determine start of text segment via 'nm vmlinux | grep _stext | cut -d " " -f1',
> +     * and fill in.
> +     */
> +    #define STEXT_START 0xffffffff81000000
> +
> +
> +
> +    int main(int argc, char **argv)
> +    {
> +       int fd;
> +       unsigned long *cover, n, i;
> +
> +       /* A single fd descriptor allows coverage collection on a single
> +        * thread.
> +        */
> +       fd = open("/sys/kernel/debug/kcov", O_RDWR);
> +       if (fd == -1)
> +               perror("open"), exit(1);
> +       /* Setup trace mode and trace size. */
> +       if ((n = ioctl(fd, KCOV_INIT_UNIQUE, 0)) < 0)
> +               perror("ioctl"), exit(1);
> +       /* Mmap buffer shared between kernel- and user-space. */
> +       cover = (unsigned long*)mmap(NULL, n,
> +                                    PROT_READ | PROT_WRITE, MAP_SHARED, fd, 0);
> +       if ((void*)cover == MAP_FAILED)
> +               perror("mmap"), exit(1);
> +       /* Enable coverage collection on the current thread. */
> +       if (ioctl(fd, KCOV_ENABLE, KCOV_UNIQUE_PC))
> +               perror("ioctl"), exit(1);
> +       /* That's the target syscal call. */
> +       read(-1, NULL, 0);
> +       /* Disable coverage collection for the current thread. After this call
> +        * coverage can be enabled for a different thread.
> +        */
> +       if (ioctl(fd, KCOV_DISABLE, 0))
> +               perror("ioctl"), exit(1);
> +        /* Convert byte size into element size */
> +        n /= sizeof(unsigned long);
> +        /* Print executed PCs in sorted order */
> +        for (i = 0; i < n; i++) {
> +            for (int j = 0; j < BITS_PER_LONG; j++) {
> +                if (cover[i] & (1L << j)) {
> +                    printf("0x%jx\n", (uintmax_t)(STEXT_START + (i * BITS_PER_LONG + j) * 4));
> +                }
> +            }
> +        }
> +       /* Free resources. */
> +       if (munmap(cover, n * sizeof(unsigned long)))
> +               perror("munmap"), exit(1);
> +       if (close(fd))
> +               perror("close"), exit(1);
> +       return 0;
> +    }
> +
>  Comparison operands collection
>  ------------------------------
>
> diff --git a/include/linux/kcov.h b/include/linux/kcov.h
> index a10e84707d82..aa0c8bcf8299 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -19,7 +19,9 @@ enum kcov_mode {
>          */
>         KCOV_MODE_TRACE_PC = 2,
>         /* Collecting comparison operands mode. */
> -       KCOV_MODE_TRACE_CMP = 3,
> +       KCOV_MODE_TRACE_CMP = 4,
> +       /* Collecting unique covered PCs. Execution order is not saved. */
> +       KCOV_MODE_UNIQUE_PC = 8,
>  };
>
>  #define KCOV_IN_CTXSW  (1 << 30)
> diff --git a/include/uapi/linux/kcov.h b/include/uapi/linux/kcov.h
> index 1d0350e44ae3..5b99b6d1a1ac 100644
> --- a/include/uapi/linux/kcov.h
> +++ b/include/uapi/linux/kcov.h
> @@ -19,6 +19,7 @@ struct kcov_remote_arg {
>  #define KCOV_REMOTE_MAX_HANDLES                0x100
>
>  #define KCOV_INIT_TRACE                        _IOR('c', 1, unsigned long)
> +#define KCOV_INIT_UNIQUE               _IOR('c', 2, unsigned long)
>  #define KCOV_ENABLE                    _IO('c', 100)
>  #define KCOV_DISABLE                   _IO('c', 101)
>  #define KCOV_REMOTE_ENABLE             _IOW('c', 102, struct kcov_remote_arg)
> @@ -35,6 +36,15 @@ enum {
>         KCOV_TRACE_PC = 0,
>         /* Collecting comparison operands mode. */
>         KCOV_TRACE_CMP = 1,
> +       /*
> +        * Unique coverage collection mode.
> +        * Unique covered PCs are collected in a per-task buffer.
> +        * De-duplicates the collected PCs. Execution order is *not* saved.
> +        * Each bit in the buffer represents every fourth byte of the text segment.
> +        * Since a call instruction is at least four bytes on every supported
> +        * architecture, storing just every fourth byte is sufficient.
> +        */
> +       KCOV_UNIQUE_PC = 2,
>  };
>
>  /*
> diff --git a/kernel/kcov.c b/kernel/kcov.c
> index 6b8368be89c8..8f00ba6e672a 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -24,6 +24,7 @@
>  #include <linux/refcount.h>
>  #include <linux/log2.h>
>  #include <asm/setup.h>
> +#include <asm/sections.h>
>
>  #define kcov_debug(fmt, ...) pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
>
> @@ -171,7 +172,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
>          * kcov_start().
>          */
>         barrier();
> -       return mode == needed_mode;
> +       return (mode & needed_mode) && !(mode & KCOV_IN_CTXSW);

I see this produces an additional check and branch:

void foo1(unsigned mode) {
  if ((mode & 10) && !(mode & (1<<30)))
    foo();
}

   0: 40 f6 c7 0a          test   $0xa,%dil
   4: 74 0f                je     15 <foo1+0x15>
   6: 81 e7 00 00 00 40    and    $0x40000000,%edi
   c: 75 07                jne    15 <foo1+0x15>
   e: 31 c0                xor    %eax,%eax
  10: e9 00 00 00 00        jmpq   15 <foo1+0x15>

I think we could make KCOV_IN_CTXSW sign bit and then express the check as:

void foo2(unsigned mode) {
  if (((int)(mode & 0x8000000a)) > 0)
    foo();
}

0000000000000020 <foo2>:
  20: 81 e7 0a 00 00 80    and    $0x8000000a,%edi
  26: 7f 08                jg     30 <foo2+0x10>
  28: c3                    retq




>  }
>
>  static notrace unsigned long canonicalize_ip(unsigned long ip)
> @@ -191,18 +192,26 @@ void notrace __sanitizer_cov_trace_pc(void)
>         struct task_struct *t;
>         unsigned long *area;
>         unsigned long ip = canonicalize_ip(_RET_IP_);
> -       unsigned long pos;
> +       unsigned long pos, idx;
>
>         t = current;
> -       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
> +       if (!check_kcov_mode(KCOV_MODE_TRACE_PC | KCOV_MODE_UNIQUE_PC, t))
>                 return;
>
>         area = t->kcov_area;
> -       /* The first 64-bit word is the number of subsequent PCs. */
> -       pos = READ_ONCE(area[0]) + 1;
> -       if (likely(pos < t->kcov_size)) {
> -               area[pos] = ip;
> -               WRITE_ONCE(area[0], pos);
> +       if (likely(t->kcov_mode == KCOV_MODE_TRACE_PC)) {

Does this introduce an additional real of t->kcov_mode?
If yes, please reuse the value read in check_kcov_mode.


> +               /* The first 64-bit word is the number of subsequent PCs. */
> +               pos = READ_ONCE(area[0]) + 1;
> +               if (likely(pos < t->kcov_size)) {
> +                       area[pos] = ip;
> +                       WRITE_ONCE(area[0], pos);
> +               }
> +       } else {
> +               idx = (ip - canonicalize_ip((unsigned long)&_stext)) / 4;
> +               pos = idx % BITS_PER_LONG;
> +               idx /= BITS_PER_LONG;
> +               if (likely(idx < t->kcov_size))
> +                       WRITE_ONCE(area[idx], READ_ONCE(area[idx]) | 1L << pos);
>         }
>  }
>  EXPORT_SYMBOL(__sanitizer_cov_trace_pc);
> @@ -474,6 +483,7 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
>                 goto exit;
>         }
>         if (!kcov->area) {
> +               kcov_debug("mmap(): Allocating 0x%lx bytes\n", size);
>                 kcov->area = area;
>                 vma->vm_flags |= VM_DONTEXPAND;
>                 spin_unlock_irqrestore(&kcov->lock, flags);
> @@ -515,6 +525,8 @@ static int kcov_get_mode(unsigned long arg)
>  {
>         if (arg == KCOV_TRACE_PC)
>                 return KCOV_MODE_TRACE_PC;
> +       else if (arg == KCOV_UNIQUE_PC)
> +               return KCOV_MODE_UNIQUE_PC;

As far as I understand, users can first do KCOV_INIT_UNIQUE and then
enable KCOV_TRACE_PC, or vice versa.
It looks somewhat strange. Is it intentional? It's not possible to
specify buffer size for KCOV_INIT_UNIQUE, so most likely the buffer
will be either too large or too small for a trace.




>         else if (arg == KCOV_TRACE_CMP)
>  #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
>                 return KCOV_MODE_TRACE_CMP;
> @@ -562,12 +574,13 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>  {
>         struct task_struct *t;
>         unsigned long size, unused;
> -       int mode, i;
> +       int mode, i, text_size, ret = 0;
>         struct kcov_remote_arg *remote_arg;
>         struct kcov_remote *remote;
>         unsigned long flags;
>
>         switch (cmd) {
> +       case KCOV_INIT_UNIQUE:

I think nowadays you need some annotation like fallthrough here.

>         case KCOV_INIT_TRACE:
>                 /*
>                  * Enable kcov in trace mode and setup buffer size.
> @@ -581,11 +594,39 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                  * that must not overflow.
>                  */
>                 size = arg;
> -               if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> -                       return -EINVAL;
> -               kcov->size = size;
> +               if (cmd == KCOV_INIT_UNIQUE) {
> +                       if (size != 0)
> +                               return -EINVAL;
> +                       text_size = (canonicalize_ip((unsigned long)&_etext) - canonicalize_ip((unsigned long)&_stext));
> +                       /**
> +                        * A call instr is at least four bytes on every supported architecture.
> +                        * Hence, just every fourth instruction can potentially be a call.
> +                        */
> +                       text_size /= 4;

Strictly saying, we need to round up text_size to 4 before dividing by
4. Otherwise we potentially don't cover up to the last 3 bytes.


> +                       /*
> +                        * Round up size of text segment to multiple of BITS_PER_LONG.
> +                        * Otherwise, we cannot track
> +                        * the last (text_size % BITS_PER_LONG) addresses.
> +                        */
> +                       text_size = roundup(text_size, BITS_PER_LONG);
> +                       /* Get the amount of bytes needed */
> +                       text_size = text_size / 8;
> +                       /* mmap() requires size to be a multiple of PAGE_SIZE */
> +                       text_size = roundup(text_size, PAGE_SIZE);
> +                       /* Get the cover size (= amount of longs stored) */

s/longs/bytes/

> +                       ret = text_size;
> +                       kcov->size = text_size / sizeof(unsigned long);
> +                       kcov_debug("text size = 0x%lx, roundup = 0x%x, kcov->size = 0x%x\n",
> +                                       ((unsigned long)&_etext) - ((unsigned long)&_stext),
> +                                       text_size,
> +                                       kcov->size);
> +               } else {
> +                       if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> +                               return -EINVAL;
> +                       kcov->size = size;
> +               }
>                 kcov->mode = KCOV_MODE_INIT;
> -               return 0;
> +               return ret;
>         case KCOV_ENABLE:
>                 /*
>                  * Enable coverage for the current task.
> --
> 2.30.0
>
