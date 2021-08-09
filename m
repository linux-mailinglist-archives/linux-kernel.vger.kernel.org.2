Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA1D63E4C7D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Aug 2021 20:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235839AbhHIS5C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Aug 2021 14:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbhHIS5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Aug 2021 14:57:00 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B63C0613D3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Aug 2021 11:56:39 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id mq2-20020a17090b3802b0290178911d298bso1444926pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Aug 2021 11:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rZnS5Yg8Ungl0NoSfe0iR6+HFsdNXlz+2LHGqQJxvwo=;
        b=bwoE5zejhZCxyq+WyMKCe4nXWa5tO89iRvDhnlFHiCRzHi8k4EyOEpcvSOKWw8ui9t
         IOHeyYKndJnQwJhk7IkL6+dil9dvBZ9jKtZyMkUuKUjgVpkbJOFjWytz+vBp5EeOp0FA
         vzHcolzrdP/9CjzGPAY0oGu72yGbpfm5Gn6h55tOlldPTsuV6BMlA/irMvUnQ+aqQoZW
         0p72/A/xm7ZYKBiyli/ctS30ECBO4FD/LfeDjwoC7UiBeiQa750HX3UeQkFPAN0FN5ZF
         9rys4gNBkRwSxpR/fOIawV5651K6f7jV/G+lZfpaVJxlSTDfyFbSV0i5Yq1DqG5PgxOe
         JL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rZnS5Yg8Ungl0NoSfe0iR6+HFsdNXlz+2LHGqQJxvwo=;
        b=a7U66hrYEjxps5i9Ef/mQLRwc8SO3jBgrX2fdk2f2QEPyQo/a4OJOYfC3GxEPF0FJl
         5ocbl1fJgPBSNxgYqMuX/PSlVHuIZ2FnMtTm5rdtPENJIU0Awl9Vwt9+LKB0CENEl1lu
         UkUCY6h08ZJ++HhBDDKyYzhd+Rl5XHdbFt9oWricqnG8UeCP/0O0dPkGWor2nqw0Iegi
         pJTJVN4bjvRoF6AacpCIlAVBShUVuHAMekDQfppa6ILJ7Z8B5pq83L/r9Z+ZgckeLDDK
         nCZn47Cgh0IqMnDDdUgjgxsNRIfhTlYkVMag3EW3YhKu1pnHUrNGQbnpJpR3q2KJdned
         huNA==
X-Gm-Message-State: AOAM530AyiozRhUTjBva5Cgm01G7InvDwQHcxwg8SvQTypQg2RdxqSh9
        Xnhgh8BtXnprLLiazCpX1n+HKvsRARl6TZPTj3I1yA==
X-Google-Smtp-Source: ABdhPJxjaqkLW6MmJ+c8T9DwC9JWTtlsFJVi3w9OFPIZvA0UgCpNZOngvNOAK/gUwWSpb8bAkZyYtzuh0uESzMCUs3g=
X-Received: by 2002:a63:f342:: with SMTP id t2mr465315pgj.45.1628535398993;
 Mon, 09 Aug 2021 11:56:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210808160823.3553954-1-surenb@google.com> <CALvZod7cgW_-4GUi6__SoaQaha=DvNRbu-n-CGMvc4hFHvv_cA@mail.gmail.com>
 <CAJuCfpG+4QAaxiqeXZ7xwrgTM-tuOhs+or2pPmKOsfKZFESh2A@mail.gmail.com>
In-Reply-To: <CAJuCfpG+4QAaxiqeXZ7xwrgTM-tuOhs+or2pPmKOsfKZFESh2A@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Mon, 9 Aug 2021 11:56:28 -0700
Message-ID: <CAJuCfpFMDZRB71Vv+QcicVomHs2tkzLECWP_gGM4815wxPqt_A@mail.gmail.com>
Subject: Re: [PATCH v8 1/2] mm: introduce process_mrelease system call
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 9, 2021 at 9:23 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Mon, Aug 9, 2021 at 8:23 AM Shakeel Butt <shakeelb@google.com> wrote:
> >
> > On Sun, Aug 8, 2021 at 9:08 AM Suren Baghdasaryan <surenb@google.com> wrote:
> > >
> > > In modern systems it's not unusual to have a system component monitoring
> > > memory conditions of the system and tasked with keeping system memory
> > > pressure under control. One way to accomplish that is to kill
> > > non-essential processes to free up memory for more important ones.
> > > Examples of this are Facebook's OOM killer daemon called oomd and
> > > Android's low memory killer daemon called lmkd.
> > > For such system component it's important to be able to free memory
> > > quickly and efficiently. Unfortunately the time process takes to free
> > > up its memory after receiving a SIGKILL might vary based on the state
> > > of the process (uninterruptible sleep), size and OPP level of the core
> > > the process is running. A mechanism to free resources of the target
> > > process in a more predictable way would improve system's ability to
> > > control its memory pressure.
> > > Introduce process_mrelease system call that releases memory of a dying
> > > process from the context of the caller. This way the memory is freed in
> > > a more controllable way with CPU affinity and priority of the caller.
> > > The workload of freeing the memory will also be charged to the caller.
> > > The operation is allowed only on a dying process.
> > >
> > > After previous discussions [1, 2, 3] the decision was made [4] to introduce
> > > a dedicated system call to cover this use case.
> > >
> > > The API is as follows,
> > >
> > >           int process_mrelease(int pidfd, unsigned int flags);
> > >
> > >         DESCRIPTION
> > >           The process_mrelease() system call is used to free the memory of
> > >           an exiting process.
> > >
> > >           The pidfd selects the process referred to by the PID file
> > >           descriptor.
> > >           (See pidfd_open(2) for further information)
> > >
> > >           The flags argument is reserved for future use; currently, this
> > >           argument must be specified as 0.
> > >
> > >         RETURN VALUE
> > >           On success, process_mrelease() returns 0. On error, -1 is
> > >           returned and errno is set to indicate the error.
> > >
> > >         ERRORS
> > >           EBADF  pidfd is not a valid PID file descriptor.
> > >
> > >           EAGAIN Failed to release part of the address space.
> > >
> > >           EINTR  The call was interrupted by a signal; see signal(7).
> > >
> > >           EINVAL flags is not 0.
> > >
> > >           EINVAL The memory of the task cannot be released because the
> > >                  process is not exiting, the address space is shared
> > >                  with another live process or there is a core dump in
> > >                  progress.
> > >
> > >           ENOSYS This system call is not supported, for example, without
> > >                  MMU support built into Linux.
> > >
> > >           ESRCH  The target process does not exist (i.e., it has terminated
> > >                  and been waited on).
> > >
> > > [1] https://lore.kernel.org/lkml/20190411014353.113252-3-surenb@google.com/
> > > [2] https://lore.kernel.org/linux-api/20201113173448.1863419-1-surenb@google.com/
> > > [3] https://lore.kernel.org/linux-api/20201124053943.1684874-3-surenb@google.com/
> > > [4] https://lore.kernel.org/linux-api/20201223075712.GA4719@lst.de/
> > >
> > > Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> >
> > Reviewed-by: Shakeel Butt <shakeelb@google.com>
>
> Thanks folks! I'll make the change Christian suggested and will push
> the next version carrying Acks along, including the one from David
> which I forgot to carry in this one.

v9 posted at: https://lore.kernel.org/linux-mm/20210809185259.405936-1-surenb@google.com
