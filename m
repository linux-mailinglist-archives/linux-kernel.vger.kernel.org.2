Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBAE73DAA5B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 19:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhG2ReU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 13:34:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231271AbhG2ReS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 13:34:18 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8437FC0613C1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:34:15 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id y9so8190042iox.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 10:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9Ewlgw+kgawQ6AHZLlkWuiBcJPxDcUOvpHKSWaDCcQ=;
        b=YTbgE128gsBTPnNOjQpj/EMQHtqnVoC34nMf+kBkBjQNWFLbbfr6EQFyrczUXcAnXq
         /jRtU2y7k/ZzzgWy6L5OfS3NpHRCVxtATAziFw8X6W4lF9EKn8ORcKYKO1Ez9Ay+a0km
         aVI5+SuNIGJafEqNkNH3p4nqlvHCVPrU97h49T3sp8QWlmnBxM/K55gtON/yII2WEexl
         zxtwbq9bJmqT0v8eayrUN398AKSvqNkyNi659AbP4VL0h5rVefFlhhPP2T0H5QXoVDz1
         9kcfEgRwGGTjrb7AybsodS7wIxAK0nl/GxuoABuQkCilPnCTcXNaDxHWUJbkABuYVm2K
         cfIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9Ewlgw+kgawQ6AHZLlkWuiBcJPxDcUOvpHKSWaDCcQ=;
        b=ixPh/qqyI9RnkU3O1gfo4EZIZU0sw9gImgO5+NA1Qh4WEKV5jVKw8dOMuSg3UKaVYt
         6krY8m9o8Ke5CpB0MOwkaRtRQLp+NKcmt4PpUx0ISz9LlszbYOA5TLfcRh3JRiUnooso
         3C0LRTKT83Ba81xc/6a9tAwFkADQ8YrsJyr7rprSZ8/US//B8fF8Sy+QHjXJekSeNZZ3
         aKYvd0FJRVOb+aTNykQEmBM7TZtY3+zU3XeLG+8NpJJi1q+Aq5LsDlARAjNOTDjMGrL/
         B/IgkRkoAu3ZvCJcdgL32Z6dRDs0PkMv8IC5dLEjlaDG7oFM/7ZBHCwv2ZSeN/5+JZDK
         fzyQ==
X-Gm-Message-State: AOAM531HjSZjvvL6/PQwbl6087OTswbnTw6fo7ZW2QxTUuh9hqETLDRN
        KfY1XRShGU6wwlU31gr8TWVktRb4zSzlnjMSEAh+jA==
X-Google-Smtp-Source: ABdhPJz6ZYlm1UALlZLeni161G5bwtT+dSVL+gU7HdRPIcCo8gfRPcUoD4TxKOZVTrIovoLdnwd4m3f3w7vOkWaNTL0=
X-Received: by 2002:a5e:8f0d:: with SMTP id c13mr4890425iok.57.1627580054841;
 Thu, 29 Jul 2021 10:34:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210729092853.38242-1-ligang.bdlg@bytedance.com>
In-Reply-To: <20210729092853.38242-1-ligang.bdlg@bytedance.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 29 Jul 2021 10:33:38 -0700
Message-ID: <CAJHvVcjBH+Vry8v5T0FWyFWWDY6_AqSxZcVQxXRm=LR8v=ML-Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] mm: mmap_lock: add ip to mmap_lock tracepoints
To:     Gang Li <ligang.bdlg@bytedance.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not a strong objection, but I think this can be achieved already using either:

- The "stacktrace" feature which histogram triggers support
(https://www.kernel.org/doc/html/latest/trace/histogram.html)
- bpftrace's kstack/ustack feature
(https://github.com/iovisor/bpftrace/blob/master/docs/tutorial_one_liners.md#lesson-9-profile-on-cpu-kernel-stacks)

I haven't tried it out myself, but I suspect you could construct a
synthetic event
(https://www.kernel.org/doc/html/latest/trace/histogram.html#synthetic-events)
which adds in the stack trace, then it ought to function a lot like it
would with this patch.

Then again, it's not like this change is huge by any means. So, if you
find this more convenient than those alternatives, you can take:

Reviewed-by: Axel Rasmussen <axelrasmussen@google.com>

It's possible Steven or Tom have a more strong opinion on this though. ;)

On Thu, Jul 29, 2021 at 2:29 AM Gang Li <ligang.bdlg@bytedance.com> wrote:
>
> The mmap_lock is acquired on most (all?) mmap / munmap / page fault
> operations, so a multi-threaded process which does a lot of these
> can experience significant contention. Sometimes we want to know
> where the lock is hold. And it's hard to locate without collecting ip.
>
> Here's an example: TP_printk("ip=%pS",ip)
> Log looks like this: "ip=do_user_addr_fault+0x274/0x640"
>
> We can find out who cause the contention amd make some improvements
> for it.
>
> Signed-off-by: Gang Li <ligang.bdlg@bytedance.com>
> ---
>  include/trace/events/mmap_lock.h | 27 +++++++++++++++++----------
>  mm/mmap_lock.c                   |  6 +++---
>  2 files changed, 20 insertions(+), 13 deletions(-)
>
> diff --git a/include/trace/events/mmap_lock.h b/include/trace/events/mmap_lock.h
> index b9dd66f9c226..8913a9f85894 100644
> --- a/include/trace/events/mmap_lock.h
> +++ b/include/trace/events/mmap_lock.h
> @@ -15,35 +15,39 @@ extern void trace_mmap_lock_unreg(void);
>
>  DECLARE_EVENT_CLASS(mmap_lock,
>
> -       TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write),
> +       TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
> +               unsigned long ip),
>
> -       TP_ARGS(mm, memcg_path, write),
> +       TP_ARGS(mm, memcg_path, write, ip),
>
>         TP_STRUCT__entry(
>                 __field(struct mm_struct *, mm)
>                 __string(memcg_path, memcg_path)
>                 __field(bool, write)
> +               __field(void *, ip)
>         ),
>
>         TP_fast_assign(
>                 __entry->mm = mm;
>                 __assign_str(memcg_path, memcg_path);
>                 __entry->write = write;
> +               __entry->ip = (void *)ip;
>         ),
>
>         TP_printk(
> -               "mm=%p memcg_path=%s write=%s",
> +               "mm=%p memcg_path=%s write=%s ip=%pS",
>                 __entry->mm,
>                 __get_str(memcg_path),
> -               __entry->write ? "true" : "false"
> -   )
> +               __entry->write ? "true" : "false",
> +               __entry->ip
> +       )
>  );
>
>  #define DEFINE_MMAP_LOCK_EVENT(name)                                    \
>         DEFINE_EVENT_FN(mmap_lock, name,                                \
>                 TP_PROTO(struct mm_struct *mm, const char *memcg_path,  \
> -                       bool write),                                    \
> -               TP_ARGS(mm, memcg_path, write),                         \
> +                       bool write, unsigned long ip),                  \
> +               TP_ARGS(mm, memcg_path, write, ip),                     \
>                 trace_mmap_lock_reg, trace_mmap_lock_unreg)
>
>  DEFINE_MMAP_LOCK_EVENT(mmap_lock_start_locking);
> @@ -52,14 +56,15 @@ DEFINE_MMAP_LOCK_EVENT(mmap_lock_released);
>  TRACE_EVENT_FN(mmap_lock_acquire_returned,
>
>         TP_PROTO(struct mm_struct *mm, const char *memcg_path, bool write,
> -               bool success),
> +               unsigned long ip, bool success),
>
> -       TP_ARGS(mm, memcg_path, write, success),
> +       TP_ARGS(mm, memcg_path, write, ip, success),
>
>         TP_STRUCT__entry(
>                 __field(struct mm_struct *, mm)
>                 __string(memcg_path, memcg_path)
>                 __field(bool, write)
> +               __field(void *, ip)
>                 __field(bool, success)
>         ),
>
> @@ -67,14 +72,16 @@ TRACE_EVENT_FN(mmap_lock_acquire_returned,
>                 __entry->mm = mm;
>                 __assign_str(memcg_path, memcg_path);
>                 __entry->write = write;
> +               __entry->ip = (void *)ip;
>                 __entry->success = success;
>         ),
>
>         TP_printk(
> -               "mm=%p memcg_path=%s write=%s success=%s",
> +               "mm=%p memcg_path=%s write=%s ip=%pS success=%s",
>                 __entry->mm,
>                 __get_str(memcg_path),
>                 __entry->write ? "true" : "false",
> +               __entry->ip,
>                 __entry->success ? "true" : "false"
>         ),
>
> diff --git a/mm/mmap_lock.c b/mm/mmap_lock.c
> index 1854850b4b89..f1100eae6f2f 100644
> --- a/mm/mmap_lock.c
> +++ b/mm/mmap_lock.c
> @@ -227,20 +227,20 @@ static const char *get_mm_memcg_path(struct mm_struct *mm)
>
>  void __mmap_lock_do_trace_start_locking(struct mm_struct *mm, bool write)
>  {
> -       TRACE_MMAP_LOCK_EVENT(start_locking, mm, write);
> +       TRACE_MMAP_LOCK_EVENT(start_locking, mm, write, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_start_locking);
>
>  void __mmap_lock_do_trace_acquire_returned(struct mm_struct *mm, bool write,
>                                            bool success)
>  {
> -       TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, write, success);
> +       TRACE_MMAP_LOCK_EVENT(acquire_returned, mm, write, _RET_IP_, success);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_acquire_returned);
>
>  void __mmap_lock_do_trace_released(struct mm_struct *mm, bool write)
>  {
> -       TRACE_MMAP_LOCK_EVENT(released, mm, write);
> +       TRACE_MMAP_LOCK_EVENT(released, mm, write, _RET_IP_);
>  }
>  EXPORT_SYMBOL(__mmap_lock_do_trace_released);
>  #endif /* CONFIG_TRACING */
> --
> 2.20.1
>
