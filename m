Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F255C34B7D4
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Mar 2021 15:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhC0O5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Mar 2021 10:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbhC0O4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Mar 2021 10:56:43 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619B2C0613B1;
        Sat, 27 Mar 2021 07:56:43 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kt15so12726487ejb.12;
        Sat, 27 Mar 2021 07:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9XfERiSuS0jgzL6XtH0j5Zkdj6GdS3lhay8hKtzIIvw=;
        b=daUZHZ3fBiNaSqN278lcZbLZBg1S9em0tplEV5jgXsyIjQJkzT3ZupisolsGGnxArG
         1LFe1EERqfwv3rj4aDrYpMXH8UDqNjm51BypNqPSfIBJoZdEEUj2HbFk3egzw4tVOIDu
         267CK1jCFWkQITeeYgRoiifaxXnfB7C/fT67K5gvFRaVqV8KZgvdgYaVs2gvgCn7Xrq7
         j4NtDNKCc0HO1IxkkqeGeXWMINfUr4GNBxhAoe3CVRxEnM1UsYAFHZ8dgy57+YM+ovO7
         wTF5ZZubjjMxyy+j+/DHuvpCUBFe4AlcrPrmnWz/SuhHst24aP5c28NA/dfPW6KAA4kh
         pfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9XfERiSuS0jgzL6XtH0j5Zkdj6GdS3lhay8hKtzIIvw=;
        b=eJhYku6rXQ6rADPwRPYPMrcfc7eXqLvNqC5H4rUlrM3SZzB1ILgtvT8TBPg7RTmUXn
         cJ0JFCcZMlUyuii2BGnhEQ9yj+GooJKKBa/T7wIJEuFrGsJg/dse36tfpElQFk3LOPWh
         t3w5TU3m8Hs6wluHT02dFAc5w9nrbiTnuPDRPuzLQ2QN1kpIjQd2yzA/9kOA0wkurzvG
         CaglDv6mj0SewmGcI4aHCMGptzudwpAYIOdb53AzvCdEd5ZB6yV4DJrrbd7y8qkz0Rrt
         +MCX/8n4m69j9iibW7hMTvJLZ6agnnwpYBBuv7z2FttLfuN6a2M63tYGo351rb0OdZw+
         45yQ==
X-Gm-Message-State: AOAM5339rK6+blBRcyHvutHUujxnwshTxFIpJ6fOiTloAr8KsfGBxxw+
        aPv7pp8FcKD34nZlRq02UTRzC2SsdgGW+LjA12c=
X-Google-Smtp-Source: ABdhPJy6lCRHeePNElX5dJ33hHek99HOaPXLCD5oruAOWdcfDLfojjJqMUdl6uKemoofUUsuQc0MN+uoF6UU3Gc0Bts=
X-Received: by 2002:a17:906:1fd6:: with SMTP id e22mr21088169ejt.481.1616857002134;
 Sat, 27 Mar 2021 07:56:42 -0700 (PDT)
MIME-Version: 1.0
References: <20210326205135.6098-1-info@alexander-lochmann.de>
In-Reply-To: <20210326205135.6098-1-info@alexander-lochmann.de>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Sat, 27 Mar 2021 15:56:31 +0100
Message-ID: <CA+fCnZcTi=QLGC_LCdhs+fMrxkqX66kXEuM5ewOmjVjifKzUrw@mail.gmail.com>
Subject: Re: [PATCHv3] Introduced new tracing mode KCOV_MODE_UNIQUE.
To:     Alexander Lochmann <info@alexander-lochmann.de>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Andrew Klychkov <andrew.a.klychkov@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Aleksandr Nogikh <nogikh@google.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Maciej Grochowski <maciej.grochowski@pm.me>,
        kasan-dev@googlegroups.com, linux-doc@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 9:52 PM Alexander Lochmann
<info@alexander-lochmann.de> wrote:
>

Hi Alexander,

> It simply stores the executed PCs.
> The execution order is discarded.
> Each bit in the shared buffer represents every fourth
> byte of the text segment.
> Since a call instruction on every supported
> architecture is at least four bytes, it is safe
> to just store every fourth byte of the text segment.

What about jumps?

[...]

> -#define KCOV_IN_CTXSW  (1 << 30)
> +#define KCOV_IN_CTXSW  (1 << 31)

This change needs to be mentioned and explained in the changelog.

> -static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_struct *t)
> +static __always_inline notrace bool check_kcov_mode(enum kcov_mode needed_mode,
> +                                                   struct task_struct *t,
> +                                                   unsigned int *mode)
>  {
> -       unsigned int mode;
> -
>         /*
>          * We are interested in code coverage as a function of a syscall inputs,
>          * so we ignore code executed in interrupts, unless we are in a remote
> @@ -162,7 +163,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
>          */
>         if (!in_task() && !(in_serving_softirq() && t->kcov_softirq))
>                 return false;
> -       mode = READ_ONCE(t->kcov_mode);
> +       *mode = READ_ONCE(t->kcov_mode);
>         /*
>          * There is some code that runs in interrupts but for which
>          * in_interrupt() returns false (e.g. preempt_schedule_irq()).
> @@ -171,7 +172,7 @@ static notrace bool check_kcov_mode(enum kcov_mode needed_mode, struct task_stru
>          * kcov_start().
>          */
>         barrier();
> -       return mode == needed_mode;
> +       return ((int)(*mode & (KCOV_IN_CTXSW | needed_mode))) > 0;

This change needs to be mentioned and explained in the changelog.

[...]

>  static notrace unsigned long canonicalize_ip(unsigned long ip)
> @@ -191,18 +192,27 @@ void notrace __sanitizer_cov_trace_pc(void)
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

This is confusing: for KCOV_MODE_TRACE_PC, pos is used to index area,
and for else, idx is used to index area. You should swap idx and pos.

[...]

> @@ -213,9 +223,10 @@ static void notrace write_comp_data(u64 type, u64 arg1, u64 arg2, u64 ip)
>         struct task_struct *t;
>         u64 *area;
>         u64 count, start_index, end_pos, max_pos;
> +       unsigned int mode;
>
>         t = current;
> -       if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t))
> +       if (!check_kcov_mode(KCOV_MODE_TRACE_CMP, t, &mode))
>                 return;

mode isn't used here, right? No need for it then.

> @@ -562,12 +576,14 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
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
> +               fallthrough;
>         case KCOV_INIT_TRACE:
>                 /*
>                  * Enable kcov in trace mode and setup buffer size.
> @@ -581,11 +597,42 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
>                  * that must not overflow.
>                  */
>                 size = arg;
> -               if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> -                       return -EINVAL;
> -               kcov->size = size;
> -               kcov->mode = KCOV_MODE_INIT;
> -               return 0;
> +               if (cmd == KCOV_INIT_UNIQUE) {

Let's put this code under KCOV_INIT_UNIQUE in the switch. This
internal if only saves duplicating two lines of code, which isn't
worth it.

> +                       if (size != 0)
> +                               return -EINVAL;
> +                       text_size = (canonicalize_ip((unsigned long)&_etext)
> +                                    - canonicalize_ip((unsigned long)&_stext));
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
> +                       kcov->mode = KCOV_MODE_INIT_UNIQUE;
> +               } else {
> +                       if (size < 2 || size > INT_MAX / sizeof(unsigned long))
> +                               return -EINVAL;
> +                       kcov->size = size;
> +                       kcov->mode = KCOV_MODE_INIT_TRACE;
> +               }
> +               return ret;

Thanks!
