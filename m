Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B501145C896
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 16:25:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235120AbhKXP3E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 10:29:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhKXP3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 10:29:03 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F0EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:25:54 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id f186so8365471ybg.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Nov 2021 07:25:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HmxFfSOiSfzWWbUMcFSvrEqVuHmnJJvWCAjgr14F02c=;
        b=ssPhpk67G6nEvM7D4xW8C7cwz/8zadU0FAkgMsMLTZ1QKGlYOZxvPd5BCp6VLUayF+
         hMvfbFgTxXVct98zlIsSCPbNNT8qlihuw7u5qtV2wlQ03s1cSTbjNc0eeYyL6NCeDxAe
         3m6rxk4oN6tgjqgGQakjWYaY0jMDk7FZn02y5DwWUoFQGzXSwUf6YtQd3KVu3Lr+fb2x
         +rhefgexUK9HSsOS+yr+Hfhw9UC5FDJVCtiNYHJPBEsVbAd3a9qWV9T3aFFYUQs1HRHv
         G4Uuf2eg4H7HcMGShVoV0JggV93Ii7txPN+JTzN4tDJo5hFC3h9thcQ5Acb/Ry9HAjeA
         6NAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HmxFfSOiSfzWWbUMcFSvrEqVuHmnJJvWCAjgr14F02c=;
        b=pnUI/Oe5NBdzrq8EC7qD9G+Y59WQFetdyWywAeKu8PHKuXQKErUO5Ayd1IB+2JAfEn
         2F63VWIHzKXoBkWqPuoIYJ+nC0xqjr+ZUrqrEaNqkMrHv1c7hgbtM1uv6zx8omZfsP0j
         a7+U4q+iFXBe3kCFbhleW8pB3OLfxeFM/fw+jCcj7MQO8g/Ul7YiGdpsJ0KjSK3N5maJ
         RI5noRAh4LMjBRwbM4XbAdXehJtZM9DH6azxOwzpHOE6RELJUhmSbVp9VlO0L4jfxmJ5
         WdUbYlT/VXEQ1C6kG0LArxiuQv0dFyun4MOTTFOuQ01UZYkzruzCCJoy2wrufgPxIOuH
         q9RQ==
X-Gm-Message-State: AOAM533ltCRr1joaWh9qQiUE6ueXW9FEq7AcxTiGCF2cdmQFrgz91QSj
        j/8C2XwSPKVTLzcCVbbbtyA0OcDCIlEejwA6piR/cg==
X-Google-Smtp-Source: ABdhPJyflYv1FyB+vVcXr/eG1/FUusHEXGFu/rw4qq6OeGStWb7PGHzJ6cTWXseh+m5ClqnqSNqMZamlGQ4YVx6kdRM=
X-Received: by 2002:a25:d4d5:: with SMTP id m204mr19201030ybf.418.1637767553224;
 Wed, 24 Nov 2021 07:25:53 -0800 (PST)
MIME-Version: 1.0
References: <20211116215715.645231-1-surenb@google.com> <YZzqX0PjxNmhJSvm@casper.infradead.org>
 <CAJuCfpE1zdAL8t2Cnhjar48Xda2GBNTX3BR5X9p_LM2OTiGsJw@mail.gmail.com> <YZ4uE/ySv4y4gdJ4@dhcp22.suse.cz>
In-Reply-To: <YZ4uE/ySv4y4gdJ4@dhcp22.suse.cz>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Wed, 24 Nov 2021 07:25:42 -0800
Message-ID: <CAJuCfpHOTiKNgsGQJR=_6bx=p_WuhwCEQhFe8K60JCA7muYRYQ@mail.gmail.com>
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

On Wed, Nov 24, 2021 at 4:20 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Tue 23-11-21 09:56:41, Suren Baghdasaryan wrote:
> > On Tue, Nov 23, 2021 at 5:19 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Nov 16, 2021 at 01:57:14PM -0800, Suren Baghdasaryan wrote:
> > > > @@ -3170,6 +3172,7 @@ void exit_mmap(struct mm_struct *mm)
> > > >       unmap_vmas(&tlb, vma, 0, -1);
> > > >       free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> > > >       tlb_finish_mmu(&tlb);
> > > > +     mmap_write_unlock(mm);
> > > >
> > > >       /*
> > > >        * Walk the list again, actually closing and freeing it,
> > >
> > > Is there a reason to unlock here instead of after the remove_vma loop?
> > > We'll need the mmap sem held during that loop when VMAs are stored in
> > > the maple tree.
> >
> > I didn't realize remove_vma() would need to be protected as well. I
> > think I can move mmap_write_unlock down to cover the last walk too
> > with no impact.
> > Does anyone know if there was any specific reason to perform that last
> > walk with no locks held (as the comment states)? I can track that
> > comment back to Linux-2.6.12-rc2 merge with no earlier history, so not
> > sure if it's critical not to hold any locks at this point. Seems to me
> > it's ok to hold mmap_write_unlock but maybe I'm missing something?
>
> I suspect the primary reason was that neither fput (and callbacks
> invoked from it) nor vm_close would need to be very careful about
> interacting with mm locks. fput is async these days so it shouldn't be
> problematic. vm_ops->close doesn't have any real contract definition AFAIK
> but taking mmap_sem from those would be really suprising. They should be
> mostly destructing internal vma state and that shouldn't really require
> address space protection.

Thanks for clarification, Michal. I'll post an updated patch with
remove_vma() loop executed under mmap_write_lock protection.

> --
> Michal Hocko
> SUSE Labs
