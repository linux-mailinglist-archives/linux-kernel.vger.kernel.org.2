Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76888345890
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 08:24:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbhCWHXn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 03:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhCWHXe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 03:23:34 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E14AC061756
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:23:34 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id v70so13390454qkb.8
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 00:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=U+uQtXtTrSMjophb7N2eSO56RonvwygmBaLAk9/84Ks=;
        b=pCpHL8O1GgN4SAUgHmLLUOLSG8t06m+lyFPh5S973ZPYluAoUHAyJboWjvl0HEgjqb
         msNTGmfQjF7wW83zU70SrxIBbB7s8U9kOBn/1piiCVuYSEhjuZjm9da3fYVg3Kq20XdJ
         DpnBw9F0BiYje1Uq6ZVTq8o3DKy7aItTQ7IP+Xyp++K8juH8kYrvjpi0z7vXcUN9oIyN
         fQUuzLso4/O3oRl2cItDATpnG6WpY24Wmzl1936axKxXTJbHZ1Famc38k3/lfpohpk/H
         M889PaJBgb3NPn9pIbB0SDTh8cAZNVXqOwfvQ6x722YcuhBepOOsq3SOkXiXGQZpUXC3
         aoAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=U+uQtXtTrSMjophb7N2eSO56RonvwygmBaLAk9/84Ks=;
        b=NOSIh4NFjsMcClHUD2GNEk5gsQ3nZ9kC0/vDx03XG4RT4MqZiLgKxvFjj96hvHt8dS
         rZ6xfCDDkI33mhTD+3J/kVRi+TFDO1Ok/gTBmGTwcNC/6r/V2ysrEpWx5C/L3vR5S2Pl
         Ys+cCQLlgUtgyr5lPTvL9uYaWWsoD9MVO4BOqMk5foVMgchlW41W6t4tjJwSAYIkYX6g
         8qmaqaTAeVbTMeBACAWmidf5t0I86cknkCFywpLqPV5Ao7TwEyOlLQ2WEs7u4fCIRXBE
         GC+grIsibdQTtIyW8F9tywPyhY3D/aUyCRHS02daKW2Kv278M8Sgemdkl/v7ZVGW2jNy
         MqZw==
X-Gm-Message-State: AOAM530Cofpcw0vmEo95duk16zEHkzrN53ORLGAbw+f/YxZ4u+vn0K11
        vU5svzxOG3eLilQ+azVovR30JIKpVFx2HqlphB4pMQ==
X-Google-Smtp-Source: ABdhPJxt4KjxsRuDPpNyJVF+DCCctaPWsQErBljNOJEKOIYqXMk5uD6IUOlbzkmXzxdNgHSuu3AeKYIA3O03PdP7cuQ=
X-Received: by 2002:a37:a7cb:: with SMTP id q194mr4169818qke.350.1616484212917;
 Tue, 23 Mar 2021 00:23:32 -0700 (PDT)
MIME-Version: 1.0
References: <CACT4Y+bdXrFoL1Z_h5s+5YzPZiazkyr2koNvfw9xNYEM69TSvg@mail.gmail.com>
 <20210321184403.8833-1-info@alexander-lochmann.de>
In-Reply-To: <20210321184403.8833-1-info@alexander-lochmann.de>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 23 Mar 2021 08:23:21 +0100
Message-ID: <CACT4Y+Z=d0WmcGV+Tt-g4G=XVDruxbpvOPJSAN6JZ1rXbOQ=2Q@mail.gmail.com>
Subject: Re: [PATCH] Introduced new tracing mode KCOV_MODE_UNIQUE.
To:     Alexander Lochmann <info@alexander-lochmann.de>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev <kasan-dev@googlegroups.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 21, 2021 at 7:44 PM Alexander Lochmann
<info@alexander-lochmann.de> wrote:
>
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
>  Documentation/dev-tools/kcov.rst | 80 +++++++++++++++++++++++++++
>  include/linux/kcov.h             | 12 ++--
>  include/uapi/linux/kcov.h        | 10 ++++
>  kernel/kcov.c                    | 94 ++++++++++++++++++++++++--------
>  4 files changed, 169 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/dev-tools/kcov.rst b/Documentation/dev-tools/kcov.rst
> index d2c4c27e1702..e105ffe6b6e3 100644
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
> index 4e3037dc1204..d72dd73388d1 100644
> --- a/include/linux/kcov.h
> +++ b/include/linux/kcov.h
> @@ -12,17 +12,21 @@ enum kcov_mode {
>         /* Coverage collection is not enabled yet. */
>         KCOV_MODE_DISABLED = 0,
>         /* KCOV was initialized, but tracing mode hasn't been chosen yet. */
> -       KCOV_MODE_INIT = 1,
> +       KCOV_MODE_INIT_TRACE = 1,
> +       /* KCOV was initialized, but recording of unique PCs hasn't been chosen yet. */
> +       KCOV_MODE_INIT_UNQIUE = 2,
>         /*
>          * Tracing coverage collection mode.
>          * Covered PCs are collected in a per-task buffer.
>          */
> -       KCOV_MODE_TRACE_PC = 2,
> +       KCOV_MODE_TRACE_PC = 4,
>         /* Collecting comparison operands mode. */
> -       KCOV_MODE_TRACE_CMP = 3,
> +       KCOV_MODE_TRACE_CMP = 8,
> +       /* Collecting unique covered PCs. Execution order is not saved. */
> +       KCOV_MODE_UNIQUE_PC = 16,
>  };
>
> -#define KCOV_IN_CTXSW  (1 << 30)
> +#define KCOV_IN_CTXSW  (1 << 31)
>
>  void kcov_task_init(struct task_struct *t);
>  void kcov_task_exit(struct task_struct *t);
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
> index 80bfe71bbe13..1f727043146a 100644
> --- a/kernel/kcov.c
> +++ b/kernel/kcov.c
> @@ -24,6 +24,7 @@
>  #include <linux/refcount.h>
>  #include <linux/log2.h>
>  #include <asm/setup.h>
> +#include <asm/sections.h>

Is this for __always_inline?
__always_inline is defined in include/linux/compiler_types.h.


>
>  #define kcov_debug(fmt, ...) pr_debug("%s: " fmt, __func__, ##__VA_ARGS__)
>
> @@ -151,10 +152,8 @@ static void kcov_remote_area_put(struct kcov_remote_area *area,
>         list_add(&area->list, &kcov_remote_areas);
>  }
>
> -static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
> +static __always_inline notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t, unsigned int *mode)
>  {
> -       unsigned int mode;
> -
>         /*
>          * We are interested in code coverage as a function of a syscall inputs,
>          * so we ignore code executed in interrupts, unless we are in a remote
> @@ -162,7 +161,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
>          */
>         if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
>                 return false;
> -       mode = READ_ONCE(t->kcov_mode);
> +       *mode = READ_ONCE(t->kcov_mode);
>         /*
>          * There is some code that runs in interrupts but for which
>          * in_interrupt() returns false (e.g. preempt_schedule_irq()).
> @@ -171,7 +170,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
>          * kcov_start().
>          */
>         barrier();
> -       return mode == needed_mode;
> +       return ((int)(*mode & (KCOV_IN_CTXSW | needed_mode))) > 0;

This logic and the rest of the patch looks good to me.

Thanks

>  }
>
>  static notrace unsigned long canonicalize_ip(unsigned long ip)
> @@ -191,18 +190,27 @@ void notrace __sanitizer_cov_trace_pc(void)
>         struct task_struct *t;
>         unsigned long *area;
>         unsigned long ip = canonicalize_ip(_RET_IP_);
> -       unsigned long pos;
> +       unsigned long pos, idx;
> +       unsigned int mode;
>
>         t = current;
> -       if (!check_kcov_mode(KCOV_MODE_TRACE_PC, t))
> +       if (!check_kcov_mode(KCOV_MODE_TRACE_PC | KCOV_MODE_UNIQUE_PC, t, &mode))
>                 return;
>
>         area = t->kcov_area;
> -       /* The first 64-bit word is the number of subsequent PCs. */
> -       pos = READ_ONCE(area[0]) + 1;
> -       if (likely(pos < t->kcov_size)) {
> -               area[pos] = ip;
> -               WRITE_ONCE(area[0], pos);
> +       if (likely(mode == KCOV_MODE_TRACE_PC)) {
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
> @@ -213,9 +221,10 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>         struct task_struct *t;
>         u64 *area;
>         u64 count, start_index, end_pos, max_pos;
> +       unsigned int mode;
>
>         t = current;
> -       if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t))
> +       if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t, &mode))
>                 return;
>
>         ip = canonicalize_ip(ip);
> @@ -362,7 +371,7 @@ void kcov_task_init(struct task_struct *t)
>  static void kcov_reset(struct kcov *kcov)
>  {
>         kcov->t = NULL;
> -       kcov->mode = KCOV_MODE_INIT;
> +       kcov->mode = KCOV_MODE_INIT_TRACE;
>         kcov->remote = false;
>         kcov->remote_size = 0;
>         kcov->sequence++;
> @@ -468,12 +477,13 @@ static int kcov_mmap(struct file *filep, struct vm_area_struct *vma)
>
>         spin_lock_irqsave(&kcov->lock, flags);
>         size = kcov->size * sizeof(unsigned long);
> -       if (kcov->mode != KCOV_MODE_INIT || vma->vm_pgoff != 0 ||
> +       if (kcov->mode & ~(KCOV_INIT_TRACE | KCOV_INIT_UNIQUE) || vma->vm_pgoff != 0 ||
>             vma->vm_end - vma->vm_start != size) {
>                 res = -EINVAL;
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
>         else if (arg == KCOV_TRACE_CMP)
>  #ifdef CONFIG_KCOV_ENABLE_COMPARISONS
>                 return KCOV_MODE_TRACE_CMP;
> @@ -562,12 +574,14 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
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
> +               /* fallthrough here */

Looking at "git log --grep fallthrough", it seems that the modern way
to say this is to use the fallthrough keyword.

Please run checkpatch, it shows a bunch of other warnings as well:

git diff HEAD^ | scripts/checkpatch.pl -


>         case KCOV_INIT_TRACE:
>                 /*
>                  * Enable kcov in trace mode and setup buffer size.
> @@ -581,11 +595,41 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                  * that must not overflow.
>                  */
>                 size = arg;
> -               if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> -                       return -EINVAL;
> -               kcov->size = size;
> -               kcov->mode = KCOV_MODE_INIT;
> -               return 0;
> +               if (cmd == KCOV_INIT_UNIQUE) {
> +                       if (size != 0)
> +                               return -EINVAL;
> +                       text_size = (canonicalize_ip((unsigned long)&_etext) - canonicalize_ip((unsigned long)&_stext));
> +                       /**
> +                        * A call instr is at least four bytes on every supported architecture.
> +                        * Hence, just every fourth instruction can potentially be a call.
> +                        */
> +                       text_size = roundup(text_size, 4);
> +                       text_size /= 4;
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
> +                       /* Get the cover size (= amount of bytes stored) */
> +                       ret = text_size;
> +                       kcov->size = text_size / sizeof(unsigned long);
> +                       kcov_debug("text size = 0x%lx, roundup = 0x%x, kcov->size = 0x%x\n",
> +                                       ((unsigned long)&_etext) - ((unsigned long)&_stext),
> +                                       text_size,
> +                                       kcov->size);
> +                       kcov->mode = KCOV_INIT_UNIQUE;
> +               } else {
> +                       if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> +                               return -EINVAL;
> +                       kcov->size = size;
> +                       kcov->mode = KCOV_INIT_TRACE;
> +               }
> +               return ret;
>         case KCOV_ENABLE:
>                 /*
>                  * Enable coverage for the current task.
> @@ -594,7 +638,7 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                  * at task exit or voluntary by KCOV_DISABLE. After that it can
>                  * be enabled for another task.
>                  */
> -               if (kcov->mode != KCOV_MODE_INIT || !kcov->area)
> +               if (!kcov->area)
>                         return -EINVAL;
>                 t = current;
>                 if (kcov->t != NULL || t->kcov != NULL)
> @@ -602,6 +646,10 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                 mode = kcov_get_mode(arg);
>                 if (mode < 0)
>                         return mode;
> +               if (kcov->mode == KCOV_INIT_TRACE && mode == KCOV_MODE_UNIQUE_PC)
> +                       return -EINVAL;
> +               if (kcov->mode == KCOV_INIT_UNIQUE && (mode & (KCOV_MODE_TRACE_PC | KCOV_MODE_TRACE_CMP)))
> +                       return -EINVAL;
>                 kcov_fault_in_area(kcov);
>                 kcov->mode = mode;
>                 kcov_start(t, kcov, kcov->size, kcov->area, kcov->mode,
> @@ -622,7 +670,7 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                 kcov_put(kcov);
>                 return 0;
>         case KCOV_REMOTE_ENABLE:
> -               if (kcov->mode != KCOV_MODE_INIT || !kcov->area)
> +               if (kcov->mode != KCOV_MODE_INIT_TRACE || !kcov->area)
>                         return -EINVAL;
>                 t = current;
>                 if (kcov->t != NULL || t->kcov != NULL)
> --
> 2.30.2
>
