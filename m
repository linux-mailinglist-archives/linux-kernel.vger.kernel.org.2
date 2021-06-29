Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9BDF3B6CAB
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Jun 2021 04:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231743AbhF2Czh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Jun 2021 22:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbhF2Czg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Jun 2021 22:55:36 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7B59C061574
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 19:53:08 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id h15so36525858lfv.12
        for <linux-kernel@vger.kernel.org>; Mon, 28 Jun 2021 19:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DajkdBeCCFmMhMvtFbnjwTvzKMnsz2v7ADpzRrerOtM=;
        b=ndstumrC5KGEt7B0fAJrPB1fe6lOayRoOqQGOTkwZWPghPGs1HW2kouAeJ582FGjF9
         4Ls10gfp33aJe54qjVsU0lyLb0E5jqWN8Yr/ua/ZEZeIij2COjKsEch/Etm8ajCwod/L
         ikL1oqzl9C1fvwr6H6kc1JvISov1h0jYmp5q52lmKw5kb35jLwO8T3voydJSDWXDTinQ
         FH95yw8pm4pOxChdf1XXEi3atw0zmKd4LMTKcy3YrIcKTnC5QLEDwp/X7xlDUCxdFpeP
         GQTWAyRZEK+50vFoyJRjtSB5Lo4scf+/ZS+R7JFf21tZLVsEgxPDmnUDx+89Y2sZ3oC6
         USSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DajkdBeCCFmMhMvtFbnjwTvzKMnsz2v7ADpzRrerOtM=;
        b=AzqYLL8Rh1M8xgkFwX92FoeZupja0NFjRCGl2OizhJ+lE6cDL4v1vQmAveydKPTI9D
         FZaw/ZzCZHFvO3IEVWrsIeDpaNsL1hSpRk0zNdkcrFmMYszPHBjwiWsD3EuuhyNfxlLj
         5isuBcJ0Ttuil1IyuCm31/X/DXmJblS/x5uV8UX8rusM/6eMr8iBR0a7boD4N45Kqgp0
         j3UZ8g9v01C6q8CRjc4iHaoSP+QXrCEFCY0JO8NaaynztW1LK+xCTnJjSpfgSj7NCnG8
         rrGv2y8RLQTP8fmE+HojmaLukId1XXQMjbQkWPwGPq6lZ70ItyH5JIBe6DspMuywRYKS
         ImLw==
X-Gm-Message-State: AOAM53048sD54nkMWPgXsXJk0JJ7y6GDKwHUXGdR4/T+8RMsgZoAsnag
        RbLAaJ57NiGgEJtzTHJBhm7nn5oL6zsWmFKHovw=
X-Google-Smtp-Source: ABdhPJxooq6oGPf00tQulv2fBnXXtV0ipZ2QmX6Ga65Qk7Cic71KJyVxaG5OT30fdSmQngIKJE8x47yZwUGHbAD6q3Y=
X-Received: by 2002:a05:6512:1683:: with SMTP id bu3mr22348002lfb.520.1624935187230;
 Mon, 28 Jun 2021 19:53:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210628151708.138524-1-sxwjean@me.com> <8fc00823-9d42-2178-784a-af33cc34b168@redhat.com>
In-Reply-To: <8fc00823-9d42-2178-784a-af33cc34b168@redhat.com>
From:   Xiongwei Song <sxwjean@gmail.com>
Date:   Tue, 29 Jun 2021 10:52:41 +0800
Message-ID: <CAEVVKH-rJCutaHJ3WzssSBPmd_TDk5kECWXWtKpSZqXe0UM-iQ@mail.gmail.com>
Subject: Re: [PATCH v2] locking/lockdep: Fix meaningless usages output of lock classes
To:     Waiman Long <llong@redhat.com>
Cc:     Xiongwei Song <sxwjean@me.com>, peterz@infradead.org,
        mingo@redhat.com, will@kernel.org,
        Boqun Feng <boqun.feng@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 29, 2021 at 5:17 AM Waiman Long <llong@redhat.com> wrote:
>
> On 6/28/21 11:17 AM, Xiongwei Song wrote:
> > From: Xiongwei Song <sxwjean@gmail.com>
> >
> > When enabling CONFIG_LOCK_STAT, then CONFIG_LOCKDEP is forcedly enabled.
> > We can get output from /proc/lockdep, which currently includes usages of
> > lock classes. But the usages are meaningless, see the output below:
> >
> > / # cat /proc/lockdep
> > all lock classes:
> > ffffffff9af63350 ....: cgroup_mutex
> >
> > ffffffff9af54eb8 ....: (console_sem).lock
> >
> > ffffffff9af54e60 ....: console_lock
> >
> > ffffffff9ae74c38 ....: console_owner_lock
> >
> > ffffffff9ae74c80 ....: console_owner
> >
> > ffffffff9ae66e60 ....: cpu_hotplug_lock
> >
> > Only one usage context for each lock, this is because each usage is only
> > changed in mark_lock() that is in CONFIG_PROVE_LOCKING defined section,
> > however in the test situation, it's not.
> >
> > The fix is to move the usages reading and seq_print from
> > CONFIG_PROVE_LOCKING undefined setcion to its defined section. Also,
> > locks_after list of lock_class is empty when CONFIG_PROVE_LOCKING
> > undefined, so do the same thing as what have done for usages of lock
> > classes.
> With this patch, CONFIG_LOCKDEP without CONFIG_PROVE_LOCKING will make
> /proc/lockdep displays just the list of lock classes with their
> associated lock keys. I think it is worth explicitly saying that in the
> commit log.

Make sense. Will update.

> > Signed-off-by: Xiongwei Song <sxwjean@gmail.com>
> > ---
> >   kernel/locking/lockdep_proc.c | 24 +++++++++++++-----------
> >   1 file changed, 13 insertions(+), 11 deletions(-)
> >
> > diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
> > index 806978314496..a1ec2652d492 100644
> > --- a/kernel/locking/lockdep_proc.c
> > +++ b/kernel/locking/lockdep_proc.c
> > @@ -70,23 +70,25 @@ static int l_show(struct seq_file *m, void *v)
> >   #ifdef CONFIG_DEBUG_LOCKDEP
> >       seq_printf(m, " OPS:%8ld", debug_class_ops_read(class));
> >   #endif
> > -#ifdef CONFIG_PROVE_LOCKING
> > -     seq_printf(m, " FD:%5ld", lockdep_count_forward_deps(class));
> > -     seq_printf(m, " BD:%5ld", lockdep_count_backward_deps(class));
> > -#endif
> > +     if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
> > +             seq_printf(m, " FD:%5ld", lockdep_count_forward_deps(class));
> > +             seq_printf(m, " BD:%5ld", lockdep_count_backward_deps(class));
> >
> > -     get_usage_chars(class, usage);
> > -     seq_printf(m, " %s", usage);
> > +             get_usage_chars(class, usage);
> > +             seq_printf(m, " %s", usage);
> > +     }
> >
> >       seq_printf(m, ": ");
> >       print_name(m, class);
> >       seq_puts(m, "\n");
> >
> > -     list_for_each_entry(entry, &class->locks_after, entry) {
> > -             if (entry->distance == 1) {
> > -                     seq_printf(m, " -> [%p] ", entry->class->key);
> > -                     print_name(m, entry->class);
> > -                     seq_puts(m, "\n");
> > +     if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
> > +             list_for_each_entry(entry, &class->locks_after, entry) {
> > +                     if (entry->distance == 1) {
> > +                             seq_printf(m, " -> [%p] ", entry->class->key);
> > +                             print_name(m, entry->class);
> > +                             seq_puts(m, "\n");
> > +                     }
> >               }
> >       }
> >       seq_puts(m, "\n");
>
> Maybe you can remove the blank lines in this case by moving the last
> seq_puts() inside the if loop. The blank lines are not really needed
> without the associated locks_after information.

Yeah, I agree. Thank you.

Regards,
Xiongwei

> Cheers,
> Longman
>
