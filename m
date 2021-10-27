Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05AAB43D038
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Oct 2021 20:00:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238342AbhJ0SDT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Oct 2021 14:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243422AbhJ0SDS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Oct 2021 14:03:18 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E99EC061745
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:00:52 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id u84so4812347yba.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Oct 2021 11:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=clXqNUS4aH+lp7CvysKQZD0qyG4h3WcOXjDUltwQb6U=;
        b=spy08q38upaQmQzNFn22bVmpGqRkZpMLppZP19FX208LVS7bKM4p1WeH7C/kIK3w8B
         mQjpjthV9ux54iJ7m72QuqrZ2q7MKOh9YIrboIp9GiJltpaPe7MBwGGrf10K9a/9DmUE
         A3akdddQnK5CYb/RP1LTJfQe5TEW6vgiDIMts94pHTBPOcibp/cS97WEFH6/ohUaz6ss
         YICJ8xcA8zSlf01Do5w8utuY32NLGysFmBGVLnBVxxenTlWqaIG6YkyD0Aa72ZpGcJX9
         bRYc0omYodEAYDs8ROqb9T8mg+BmVfQBJUXQmV6cg/vxpBr6fmbtKjoIExWK+oJlhc8t
         sn0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=clXqNUS4aH+lp7CvysKQZD0qyG4h3WcOXjDUltwQb6U=;
        b=TirS/7406XEQ7G/1gLkMZd2nPYatbkCDabw7X9vH+fSzPl/6W0sJBQfN4/VND0Wqku
         hLvraeZLVYxznb+81o8va1hUz3Dy/omF3zs9L6rxul/GE1TJyjjkvy9TjSNoGbG6c/mt
         SAtgZ61QD4Ca1EEQV0SVCFtN41BJgvoo2F1iVZgc+Ku3qCFudbE0lDEx0PtT7qMN7EPO
         n7PQxrvwrnHyvnizzKzzR8rJDq8xRBzX8651/3/2jpnVdcTjTS6bBSSsxOyNycl+4CiG
         u/WSkQD5fAivrE7MDRbWzcXl3S7JxmFnq8iLWJaWxrsIXyKoQWsTdU3keJFZeRO30i0a
         qf6w==
X-Gm-Message-State: AOAM531FeQezKjhPqk4FhCq6HI4cgm3BIpQMkDRQxlKkclXEJu6TuPoh
        17OjaqFKgjhiV0ItoAlDe1j1FyBGJpeeMpLeU68qIw==
X-Google-Smtp-Source: ABdhPJw+b4ieaS+XkelygwszTNfA8iUxOPZ3IyD0AyktmJLzezrD+qqN5C7+sdyzIu3rekl+DE5Hn023AAKjGGWtu0w=
X-Received: by 2002:a25:2f48:: with SMTP id v69mr11873590ybv.487.1635357649502;
 Wed, 27 Oct 2021 11:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211022014658.263508-1-surenb@google.com> <YXJwUUPjfg9wV6MQ@dhcp22.suse.cz>
 <CAJuCfpEcSbK8WrufZjDj-7iUxiQtrmVTqHOxFUOvLhYGz6_ttQ@mail.gmail.com>
 <CAJuCfpFccBJHHqfOKixJvLr7Xta_ojkdHGfGomwTDNKffzziRQ@mail.gmail.com>
 <YXmNaoV4dBTOJ3+w@casper.infradead.org> <CAJuCfpFP-57JkWhDAN4T6VtPboSV4LGqipHMU4j+wJKU45yjYg@mail.gmail.com>
 <YXmRq5d86Umzrxs+@casper.infradead.org>
In-Reply-To: <YXmRq5d86Umzrxs+@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 27 Oct 2021 11:00:38 -0700
Message-ID: <CAJuCfpH6ZGc9qaG6cNsJhHTaKdf_EXQgX7iRRcqXF6GiL-Mj8Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm: prevent a race between process_mrelease and exit_mmap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     "Liam R. Howlett" <liam.howlett@oracle.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, Rik van Riel <riel@surriel.com>,
        Minchan Kim <minchan@kernel.org>,
        Christian Brauner <christian@brauner.io>,
        Christoph Hellwig <hch@infradead.org>,
        Oleg Nesterov <oleg@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jann Horn <jannh@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Florian Weimer <fweimer@redhat.com>,
        Jan Engelhardt <jengelh@inai.de>,
        Linux API <linux-api@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Andrea Arcangeli <aarcange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 27, 2021 at 10:52 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Wed, Oct 27, 2021 at 10:42:29AM -0700, Suren Baghdasaryan wrote:
> > On Wed, Oct 27, 2021 at 10:35 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Wed, Oct 27, 2021 at 09:08:21AM -0700, Suren Baghdasaryan wrote:
> > > > Unconditional mmap_write_lock around free_pgtables in exit_mmap seems
> > > > to me the most semantically correct way forward and the pushback is on
> > > > the basis of regressing performance of the exit path. I would like to
> > > > measure that regression to confirm this. I don't have access to a big
> > > > machine but will ask someone in another Google team to try the test
> > > > Michal wrote here
> > > > https://lore.kernel.org/all/20170725142626.GJ26723@dhcp22.suse.cz/ on
> > > > a server with and without a custom patch.
> > >
> > > Sorry to hijack this, but could you ask that team to also test this
> > > patch?  I think there's probably a good-sized win here, but I have no
> > > profiles to share at this point.  I've only done light testing, and
> > > it may have bugs.
> > >
> > > NB: I only did the exit() path here.  fork() conversion is left as an
> > > exercise for the reader^W^W Liam.
> >
> > To clarify, this patch does not change the mmap_write_lock portion of
> > exit_mmap. Do you want to test it in isolation or with the locking
> > changes in exit_mmap I mentioned?
>
> Correct, it does not.  I think it's interesting to test it in isolation,
> but if you want to test it in in combination, that could also be
> interesting (see if we regain some of the expected performance loss).
> I just don't have a NUMA box of my own to test on, so I'm hoping to
> exploit your test infrastructure ;-)
>
> By the way, my vmavec patch should also be helpful on small systems
> like phones ... ;-)

Sounds good. I'll try to queue up the patches so that it's easy to
test them both in isolation and together.
