Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51B903BF564
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 08:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229815AbhGHGIw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 02:08:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbhGHGIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 02:08:50 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95627C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jul 2021 23:06:09 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id i18so7117483yba.13
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jul 2021 23:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=t05u7OBgFdxDeppEwVUIqAGqylHaA/nLaL/wU/DSQ40=;
        b=aD0SS2OXs7Z+sHYgjvvvL4RQiDk0cFyYBZY4bVMbor6xhhynz0xNn+057DwiNYFYiV
         Xtl0HZfnqauDx+MkakBDZhj/+sc5VFZJZ9yyXGFMPExYM9JQGV5zyt1jBfWzElQAsbPL
         S8BY3LVvvgEGA7sug4s3RXyzwzQ0kTf3pe68e2P0GDJ12gN3tPdbqgqYzqKvpypY0vwv
         s2SRLVYkrMOqKouhuURTDvCboAY4Aa/kyosDNKXT2aQytrXea6PcQR/nxuTQUiudl11o
         fPjliOo8rxIlWPgBSmz8w6eZZ/Gb2hjl2EA5CIAXrgxdqn18G09O23Ax+YS72ItAvnJX
         z0Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=t05u7OBgFdxDeppEwVUIqAGqylHaA/nLaL/wU/DSQ40=;
        b=BdGWbZtpgyaddX+XgyOv798LPIHzzvyqxZnJoLXbwbi5mGeiAGqfbzvc7bDoy4wPFp
         Vb2UHISR9XbQcTGTyRSCOCQSRIiZwaN8H5Tcgi9/+YRFf0u4BJt3pOlZ2ebh4SpE2h7/
         8G+k9zxWroMgCdRxApE9gdpb6QYgOuWvU7x5WNKpKLDKGwfvACSmKEtIHHpj8rsNJTWY
         IzIRyPAVGxdbLzYbgf8pqXjf/nRw8RAGOBjCxl0q+UWLjQQ0CJ9IQBbHkoU62M9qjepU
         K92wp2+CO2YpSFVHgZjnfm1YVy+Kjd4UnJHGVSqaaiuko6vao2JbJozmPGk058yokkhR
         duLw==
X-Gm-Message-State: AOAM533/oZwckBxZCmn3jLjtAWp95bkRarhCecHBqHc0t4HZywhH9tyq
        Jokz1IxhbFZmrY+2Jko9eavS5QX3Bz3T8Enl7Dd4zQ==
X-Google-Smtp-Source: ABdhPJwuywcXCuuMFThvcecm/PDvMW0qWsJkICaNeWvKCBkZMZyzVkO4uVOwqu4pHud13EH10/evFaZ/KJv//5t1iLU=
X-Received: by 2002:a25:4102:: with SMTP id o2mr35219483yba.23.1625724368500;
 Wed, 07 Jul 2021 23:06:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210623192822.3072029-1-surenb@google.com> <87sg0qa22l.fsf@oldenburg.str.redhat.com>
 <CAJuCfpEWpvw+gW+NvBPOdGqUOEyucFoT8gdC2uk18dMBQFbhqw@mail.gmail.com> <87wnq1z7kl.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87wnq1z7kl.fsf@oldenburg.str.redhat.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 7 Jul 2021 23:05:57 -0700
Message-ID: <CAJuCfpFt55Dw1uW3S6_AincNfPaAtwdi6iXYVvFr7x3fvt4uzw@mail.gmail.com>
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

On Wed, Jul 7, 2021 at 10:41 PM Florian Weimer <fweimer@redhat.com> wrote:
>
> * Suren Baghdasaryan:
>
> > On Wed, Jul 7, 2021 at 2:47 AM Florian Weimer <fweimer@redhat.com> wrot=
e:
> >>
> >> * Suren Baghdasaryan:
> >>
> >> > The API is as follows,
> >> >
> >> >           int process_reap(int pidfd, unsigned int flags);
> >> >
> >> >         DESCRIPTION
> >> >           The process_reap() system call is used to free the memory =
of a
> >> >           dying process.
> >> >
> >> >           The pidfd selects the process referred to by the PID file
> >> >           descriptor.
> >> >           (See pidofd_open(2) for further information)
> >> >
> >> >           The flags argument is reserved for future use; currently, =
this
> >> >           argument must be specified as 0.
> >> >
> >> >         RETURN VALUE
> >> >           On success, process_reap() returns 0. On error, -1 is retu=
rned
> >> >           and errno is set to indicate the error.
> >>
> >> I think the manual page should mention what it means for a process to =
be
> >> =E2=80=9Cdying=E2=80=9D, and how to move a process to this state.
> >
> > Thanks for the suggestion, Florian! Would replacing "dying process"
> > with "process which was sent a SIGKILL signal" be sufficient?
>
> That explains very clearly the requirement, but it raises the question
> why this isn't an si_code flag for rt_sigqueueinfo, reusing the existing
> system call.

I think you are suggesting to use sigqueue() to deliver the signal and
perform the reaping when a special value accompanies it. This would be
somewhat similar to my early suggestion to use a flag in
pidfd_send_signal() (see:
https://lore.kernel.org/patchwork/patch/1060407) to implement memory
reaping which has another advantage of operation on PIDFDs instead of
PIDs which can be recycled.
kill()/pidfd_send_signal()/sigqueue() are supposed to deliver the
signal and return without blocking. Changing that behavior was
considered unacceptable in these discussions. On the other hand using
some kthread to do the reaping asynchronously has its disadvantages:
userspace can't control the priority and cpu affinity of the thread
doing the reaping and this work is not charged towards the caller. In
the end a separate blocking syscall was deemed appropriate for this
operation. More details can be found in the links I posted in the
description of the patch.

>
> Thanks,
> Florian
>
