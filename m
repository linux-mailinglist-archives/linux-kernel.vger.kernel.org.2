Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92A2E3FF163
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 18:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346294AbhIBQab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 12:30:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbhIBQaa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 12:30:30 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10CFC061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 09:29:31 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id k17so1551030pls.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 Sep 2021 09:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:cc;
        bh=QLAsHUWiHUoR30E0hI8bhnsUA1KEyzqg8wNQea4W3og=;
        b=GKh+qaiaGfL//iSZ+ukPmTJLsUPZU6MwFnsBs383+uUMwt2M3hnFC3aFvbaf+D+DmW
         T/V0YCNQ9E7ZGZtaXlpR5iaMKx75Ij7vppp2XMDKSxm2gcE/Eymg+dsnUAU+ES2OEda3
         DjLouSXxOq0GRzjcfP6ak4IM0vuE27Bo0YNwxdjhHrIPjlxEXjiWvKPpwWidsv6p5uZs
         Yngtk94ZsTHSwb68653zk0f9e+Q0Ldxvmr6yEm0jpA4KnT/w6SnclQyHicn0fTdpAybK
         zY0y3V03bBJkUNyrBG5IBCGtIXsEo0P2Klnk88UvY90E39CKI9vwMmpAbjq4m66Zz2HX
         Zvww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:cc;
        bh=QLAsHUWiHUoR30E0hI8bhnsUA1KEyzqg8wNQea4W3og=;
        b=RA8JiOJABqcu0Yl62LY51IBAfk/sTs4Mn+r/IN4awvBdl5V00Y+18GQ06SPCGgEOJt
         Xm3KEDyGc1bbVLn6KtfX2VVWr9GYyZpdjbj1HF2wDQthS3ob1hYbNrHgIpFdX7wdQV+Z
         8QPDoMC7uyCqa0JLN2p0Dc1ysY1zw1Mzdf4AZIRniepqCro5H8duq2lJFTnVRTDER+JF
         8rfSfqiWnCbIf6saI6ercfkp8bbi93T7t9fmndclQxxQylH/1BRZbAW/IwcLOBw/CO0O
         dkIDcPdt2a04MmN3ZLOZVCfogQXgMkwO/ih6KLhFrnlw+KrRmC4b0sNldJVXRL5/aUmx
         EueQ==
X-Gm-Message-State: AOAM533MmoJ4D+8X8JxYdd1pG/ivQ9gpqCEnJivR5UjVec9i7nefHoUn
        duOUWWMnM3gBD10lL9GAUlfQSqMuzQeEd8PFQoM7RA==
X-Received: by 2002:a17:90a:6b83:: with SMTP id w3mt3834386pjj.114.1630600170838;
 Thu, 02 Sep 2021 09:29:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210831170233.1409537-1-kaleshsingh@google.com>
In-Reply-To: <20210831170233.1409537-1-kaleshsingh@google.com>
From:   Kalesh Singh <kaleshsingh@google.com>
Date:   Thu, 2 Sep 2021 09:29:19 -0700
Message-ID: <CAC_TJvdW6wMn5yMYpG37NiYmr7tLBNb57N_-6FxTSgndmnjqZg@mail.gmail.com>
Subject: Re: [RESEND v2] tracing/gpu: Add imported size to gpu_mem_imported tracepoint
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Hridya Valsaraju <hridya@google.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        John Reitan <john.reitan@arm.com>,
        =?UTF-8?Q?=C3=98rjan_Eide?= <orjan.eide@arm.com>,
        Mark Underwood <mark.underwood@arm.com>,
        Gary Sweet <gary.sweet@broadcom.com>,
        Stephen Mansfield <stephen.mansfield@imgtec.com>,
        "Cc: Android Kernel" <kernel-team@android.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 31, 2021 at 10:02 AM Kalesh Singh <kaleshsingh@google.com> wrote:
>
> The existing gpu_mem_total tracepoint provides GPU drivers a uniform way
> to report the per-process and system-wide GPU memory usage. This
> tracepoint reports a single total of the GPU private allocations and the
> imported memory. [1]
>
> To allow distinguishing GPU private vs imported memory, add an
> imported_size field to the gpu_mem_total tracepoint. GPU drivers can use
> this new field to report the per-process and global GPU-imported memory
> in a uniform way.
>
> User space tools can detect and handle the old vs new gpu_mem_total
> format via the gpu_mem/gpu_mem_total/format file.
>
> [1] https://lore.kernel.org/r/20200302234840.57188-1-zzyiwei@google.com/
>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Friendly ping on this one, since Steve was out of office :)

If there are no other concerns, I would like to have it considered for merge.

Thanks,
Kalesh

> ---
>  include/trace/events/gpu_mem.h | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
>
> diff --git a/include/trace/events/gpu_mem.h b/include/trace/events/gpu_mem.h
> index 26d871f96e94..ae6fab6bab7b 100644
> --- a/include/trace/events/gpu_mem.h
> +++ b/include/trace/events/gpu_mem.h
> @@ -15,7 +15,7 @@
>
>  /*
>   * The gpu_memory_total event indicates that there's an update to either the
> - * global or process total gpu memory counters.
> + * global or process total and imported gpu memory counters.
>   *
>   * This event should be emitted whenever the kernel device driver allocates,
>   * frees, imports, unimports memory in the GPU addressable space.
> @@ -24,31 +24,36 @@
>   *
>   * @pid: Put 0 for global total, while positive pid for process total.
>   *
> - * @size: Size of the allocation in bytes.
> + * @size: Total size of allocated and imported memory in bytes.
> + *
> + * @imported_size: Total size of imported memory in bytes.
>   *
>   */
>  TRACE_EVENT(gpu_mem_total,
>
> -       TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size),
> +       TP_PROTO(uint32_t gpu_id, uint32_t pid, uint64_t size, uint64_t imported_size),
>
> -       TP_ARGS(gpu_id, pid, size),
> +       TP_ARGS(gpu_id, pid, size, imported_size),
>
>         TP_STRUCT__entry(
>                 __field(uint32_t, gpu_id)
>                 __field(uint32_t, pid)
>                 __field(uint64_t, size)
> +               __field(uint64_t, imported_size)
>         ),
>
>         TP_fast_assign(
>                 __entry->gpu_id = gpu_id;
>                 __entry->pid = pid;
>                 __entry->size = size;
> +               __entry->imported_size = imported_size;
>         ),
>
> -       TP_printk("gpu_id=%u pid=%u size=%llu",
> +       TP_printk("gpu_id=%u pid=%u size=%llu imported_size=%llu",
>                 __entry->gpu_id,
>                 __entry->pid,
> -               __entry->size)
> +               __entry->size,
> +               __entry->imported_size)
>  );
>
>  #endif /* _TRACE_GPU_MEM_H */
>
> base-commit: 9c849ce86e0fa93a218614eac562ace44053d7ce
> --
> 2.33.0.259.gc128427fd7-goog
>
