Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6055145D17A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Nov 2021 01:01:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344581AbhKYAEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 19:04:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244155AbhKYAE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 19:04:28 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310C8C061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 16:01:18 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id q64so6337315qkd.5
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 16:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PM6s1UNS3WRel4T/MXBtZxxguRSaKWynAztDa9BXClo=;
        b=Ex4k32MWenEVlvhf9HW4R2UVbIIkdFVFS/9aoLMdUVk0bpn1xxOLzfGJn7J4hPMZjH
         SYdzmdR5QpKzjcRrogjU0Muz0LpWM3USQ7l7PfNmfZFEkHIP7TubUQ5ia20o9gg17wEb
         Zg703fso6x4fzeZERSj1l2+ojMe1ZVjMdV4Ch+O+OI0WgE4vjt6RENXoCpDBEQRWqpnQ
         2sg73Cpfwg+IHA7MJXO3r3IRt8qF713Z91/C+AobMBxgBCF8zAxpySCkX8acpavKrpPa
         bgc1Lq9AAV7u77O5geB/nKOPvGxCY11+0wBwGOJxKtmDgsbqvR6N+BY2HFD0uueK6/t4
         2A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PM6s1UNS3WRel4T/MXBtZxxguRSaKWynAztDa9BXClo=;
        b=AD/u7Mlm6Jd/s8Wz5meGIxqo9yF8DbpDTDfXedlEEEh/E5hgqZEpGgziregHTCpcLP
         YHCfPDIhoc3cMlMfG4XwAId0vVmYTJW41NxhSM0ZRfGJ+/je5w/3qHjHw+Tmi4nXS1qe
         UAbFQdwO8TzUwagJReAIi4k5TxlDK4Q1LrKUTp+sAH+sxWlYz55g3gT1EUettTqtAY2G
         LOPolwz0d5cXpqTxcElfz6qBzzBRULC+8jvxfFztg5DcZV52LPSdSVddyZfj12mdMyH6
         PHB1Qsaavel46BBZcRZfuAYvidJK6kCQEBR/tIjRX/y7ZQJvAQndUTHfZbxehtpPTqxZ
         YEHA==
X-Gm-Message-State: AOAM532WIsw1eE0jZvXqUvjPLQIz2lGLC5O1x8oCw/5gWBlklSQBiVEg
        3ZS8Bxl4fUyNQDcUT36bVWWK6Yi2+nw2/Fl1feOSdg==
X-Google-Smtp-Source: ABdhPJyNdBioCcc3I/kDV5QhqI6DiPU3l1KaToTwJJNLWCTJO4vu2uQTj78D6eQovkdqobPkOuwSWzu3/ddWt5+4i4A=
X-Received: by 2002:a05:6902:1350:: with SMTP id g16mr1349039ybu.202.1637798477126;
 Wed, 24 Nov 2021 16:01:17 -0800 (PST)
MIME-Version: 1.0
References: <20211116215715.645231-1-surenb@google.com> <YZzqX0PjxNmhJSvm@casper.infradead.org>
 <CAJuCfpE1zdAL8t2Cnhjar48Xda2GBNTX3BR5X9p_LM2OTiGsJw@mail.gmail.com>
 <YZ4uE/ySv4y4gdJ4@dhcp22.suse.cz> <CAJuCfpHOTiKNgsGQJR=_6bx=p_WuhwCEQhFe8K60JCA7muYRYQ@mail.gmail.com>
In-Reply-To: <CAJuCfpHOTiKNgsGQJR=_6bx=p_WuhwCEQhFe8K60JCA7muYRYQ@mail.gmail.com>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 24 Nov 2021 16:01:06 -0800
Message-ID: <CAJuCfpFCoP02tXYxjQG9u3pLqbzMiKebXN25QpMMjP2CZ-r7Pw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: protect free_pgtables with mmap_lock write lock
 in exit_mmap
To:     Michal Hocko <mhocko@suse.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        rientjes@google.com, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2021 at 7:25 AM Suren Baghdasaryan <surenb@google.com> wrote:
>
> On Wed, Nov 24, 2021 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Tue 23-11-21 09:56:41, Suren Baghdasaryan wrote:
> > > On Tue, Nov 23, 2021 at 5:19 AM Matthew Wilcox <willy@infradead.org> wrote:
> > > >
> > > > On Tue, Nov 16, 2021 at 01:57:14PM -0800, Suren Baghdasaryan wrote:
> > > > > @@ -3170,6 +3172,7 @@ void exit_mmap(struct mm_struct *mm)
> > > > >       unmap_vmas(&tlb, vma, 0, -1);
> > > > >       free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> > > > >       tlb_finish_mmu(&tlb);
> > > > > +     mmap_write_unlock(mm);
> > > > >
> > > > >       /*
> > > > >        * Walk the list again, actually closing and freeing it,
> > > >
> > > > Is there a reason to unlock here instead of after the remove_vma loop?
> > > > We'll need the mmap sem held during that loop when VMAs are stored in
> > > > the maple tree.
> > >
> > > I didn't realize remove_vma() would need to be protected as well. I
> > > think I can move mmap_write_unlock down to cover the last walk too
> > > with no impact.
> > > Does anyone know if there was any specific reason to perform that last
> > > walk with no locks held (as the comment states)? I can track that
> > > comment back to Linux-2.6.12-rc2 merge with no earlier history, so not
> > > sure if it's critical not to hold any locks at this point. Seems to me
> > > it's ok to hold mmap_write_unlock but maybe I'm missing something?
> >
> > I suspect the primary reason was that neither fput (and callbacks
> > invoked from it) nor vm_close would need to be very careful about
> > interacting with mm locks. fput is async these days so it shouldn't be
> > problematic. vm_ops->close doesn't have any real contract definition AFAIK
> > but taking mmap_sem from those would be really suprising. They should be
> > mostly destructing internal vma state and that shouldn't really require
> > address space protection.
>
> Thanks for clarification, Michal. I'll post an updated patch with
> remove_vma() loop executed under mmap_write_lock protection.

v2 is posted at
https://lore.kernel.org/all/20211124235906.14437-1-surenb@google.com/

>
> > --
> > Michal Hocko
> > SUSE Labs
