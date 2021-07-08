Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6F2B3BF5B7
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 08:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhGHGm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 02:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhGHGm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 02:42:28 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F78C061574
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 23:39:46 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id k184so7227384ybf.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 23:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=27in3H3NG/Vl86S0tsNdE2x7qDRib9u0Z+T9F2j/CEQ=;
        b=Q8SVvr1jTKOq3j1BCslRCPLWmaQMXyTeDdBuyUrjxBV79g3niuwJsDTUD9ZUUaHJ0s
         CmDeMucSyAQQbZ+j+xfAsykJJ8181J+14rDNbhmGr15mWq/jW0X4JmmPGq0ampUTCFLj
         Ih+mINskcgfLLx4uGScvhz3uXISFAHbElucLnlFNBHUtgsdR0E6XhwibmnKO4OTFmRkV
         efPB+obV4e8RgQ32aCvcY3hJ7ndU45iGFw+PGvbVEaIq3vSFen6pNbrsoOgfi0UqzvfW
         sqyAwULvJamzlS1Cj6xjhtRamBFLl80h2AQTm2OBtFA+kI3OxMaiY20J/kelIl8MGSJu
         zkGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=27in3H3NG/Vl86S0tsNdE2x7qDRib9u0Z+T9F2j/CEQ=;
        b=HeChCU0j3BoiRAeqPjDYLyLJPR9WLxh75Wl+hsxLYiiN7yeRjDs2XdghnhxUXhlDcZ
         PCPJdFnyGOrIpNDn4I25wd8tjK3DpJYfU+io2UDxWnk84dz+fSGAtxwh45LKO41awh5O
         J0SMTX5/MywTYvnIgvg4sj6U9Vooihwqt+X/cCZUciufvNCkhLy2ZkgZe+ZFzHsZwzFp
         qRAlMI6AIHFADhyqY42fTTwXuEjS/7meIXLIGISDkQgW8ii/yEKFz40V29fe6ZHkXrRb
         RILp1ng202RsQME2KgS47Vw3k64C5P+ExkL7eBTie94rKT7L6UQ0rFKe1enkipQTh4TW
         Pt6g==
X-Gm-Message-State: AOAM5304c4UNsNa8vRwcfyxqg4R8hc4KVc+s4mh/ZESwFFb20gTUc5sZ
        rGqAHm+7kfQhXS5Eni0myznQEGub3JjfZL/Tt4TnIQ==
X-Google-Smtp-Source: ABdhPJydDNpP10FuMf7vtQWnSXkxu7Hqff+2qGL2BpHgm1W1RGB/mrktTIT/F59XFDxVt4zCP/5eFl+K0CtXXxtblYY=
X-Received: by 2002:a25:4102:: with SMTP id o2mr35358941yba.23.1625726385748;
 Wed, 07 Jul 2021 23:39:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <87sg0qa22l.fsf@oldenburg.str.redhat.com>
 <CAJuCfpEWpvw+gW+NvBPOdGqUOEyucFoT8gdC2uk18dMBQFbhqw@mail.gmail.com>
 <87wnq1z7kl.fsf@oldenburg.str.redhat.com> <CAJuCfpFt55Dw1uW3S6_AincNfPaAtwdi6iXYVvFr7x3fvt4uzw@mail.gmail.com>
 <87zguxxrfl.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87zguxxrfl.fsf@oldenburg.str.redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 7 Jul 2021 23:39:34 -0700
Message-ID: <CAJuCfpEUXz-oHi5Ho8nGAKtFV6ArQDx9yQwrdTzYgHr5+6=YaQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: introduce process_reap system call
To:     Florian Weimer <fweimer@redhat.com>
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
        Shakeel Butt <shakeelb@google.com>,
        Tim Murray <timmurray@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 11:15 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Suren Baghdasaryan:
>
> > On Wed, Jul 7, 2021 at 10:41 PM Florian Weimer <fweimer@redhat.com> wro=
te:
> >>
> >> * Suren Baghdasaryan:
> >>
> >> > On Wed, Jul 7, 2021 at 2:47 AM Florian Weimer <fweimer@redhat.com> w=
rote:
> >> >>
> >> >> * Suren Baghdasaryan:
> >> >>
> >> >> > The API is as follows,
> >> >> >
> >> >> >           int process_reap(int pidfd, unsigned int flags);
> >> >> >
> >> >> >         DESCRIPTION
> >> >> >           The process_reap() system call is used to free the memo=
ry of a
> >> >> >           dying process.
> >> >> >
> >> >> >           The pidfd selects the process referred to by the PID fi=
le
> >> >> >           descriptor.
> >> >> >           (See pidofd_open(2) for further information)
> >> >> >
> >> >> >           The flags argument is reserved for future use; currentl=
y, this
> >> >> >           argument must be specified as 0.
> >> >> >
> >> >> >         RETURN VALUE
> >> >> >           On success, process_reap() returns 0. On error, -1 is r=
eturned
> >> >> >           and errno is set to indicate the error.
> >> >>
> >> >> I think the manual page should mention what it means for a process =
to be
> >> >> =E2=80=9Cdying=E2=80=9D, and how to move a process to this state.
> >> >
> >> > Thanks for the suggestion, Florian! Would replacing "dying process"
> >> > with "process which was sent a SIGKILL signal" be sufficient?
> >>
> >> That explains very clearly the requirement, but it raises the question
> >> why this isn't an si_code flag for rt_sigqueueinfo, reusing the existi=
ng
> >> system call.
> >
> > I think you are suggesting to use sigqueue() to deliver the signal and
> > perform the reaping when a special value accompanies it. This would be
> > somewhat similar to my early suggestion to use a flag in
> > pidfd_send_signal() (see:
> > https://lore.kernel.org/patchwork/patch/1060407) to implement memory
> > reaping which has another advantage of operation on PIDFDs instead of
> > PIDs which can be recycled.
> > kill()/pidfd_send_signal()/sigqueue() are supposed to deliver the
> > signal and return without blocking. Changing that behavior was
> > considered unacceptable in these discussions.
>
> Does this mean that you need two threads, one that sends SIGKILL, and
> one that calls process_reap?  Given that sending SIGKILL is blocking
> with the existing interfaces?

Sending SIGKILL is blocking in terms of delivering the signal, but it
does not block waiting for SIGKILL to be processed by the signal
recipient and memory to be released. When I was talking about
"blocking", I meant that current kill() and friends do not block to
wait for SIGKILL to be processed.
process_reap() will block until the memory is released. Whether the
userspace caller is using it right after sending a SIGKILL to reclaim
the memory synchronously or spawns a separate thread to reclaim memory
asynchronously is up to the user. Both patterns are supported.

> Please also note that asynchronous deallocation of resources leads to
> bugs and can cause unrelated workloads to fail.  For example, in some
> configurations, clone can fail with EAGAIN even in cases where the total
> number of tasks is clearly bounded because the kernel signals task exit
> to applications before all resources are deallocated.  I'm worried that
> the new interface makes things quite a bit worse in this regard.

The process_reap() releases memory synchronously, no kthreads are
being used. If asynchronous release is required, the userspace would
need to spawn a userspace thread and issue this syscall from it. I
hope this clears your concerns, which I think are about asynchronous
deallocations within the kernel.
Thanks!

>
> Thanks,
> Florian
>
