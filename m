Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A81F45BC51
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Nov 2021 13:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244783AbhKXM1l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Nov 2021 07:27:41 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:41394 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244589AbhKXMXx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Nov 2021 07:23:53 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id CF31021941;
        Wed, 24 Nov 2021 12:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1637756439; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=x051lL+rIcViyFMqRM8uVRQZz+CCvBR7eit+ORyQOVA=;
        b=qV8/E86W9MN7uvn5lwYq6hoKppSZf24lyYq0Wpea70I7YQZFNgLTuAhnkxsyOcmcLc04bX
        //grjHPmsfSdKJbmMDXmDTQE8QwyI+2hAP/b/N5yD+3BM9RWYnhc8c219LlD8Sh7BvEKby
        n0eknJVgel1u3X+dEUvo+CsEA4ygxN0=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 51409A3B84;
        Wed, 24 Nov 2021 12:20:39 +0000 (UTC)
Date:   Wed, 24 Nov 2021 13:20:35 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Matthew Wilcox <willy@infradead.org>, akpm@linux-foundation.org,
        rientjes@google.com, hannes@cmpxchg.org, guro@fb.com,
        riel@surriel.com, minchan@kernel.org, kirill@shutemov.name,
        aarcange@redhat.com, christian@brauner.io, hch@infradead.org,
        oleg@redhat.com, david@redhat.com, jannh@google.com,
        shakeelb@google.com, luto@kernel.org, christian.brauner@ubuntu.com,
        fweimer@redhat.com, jengelh@inai.de, timmurray@google.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com
Subject: Re: [PATCH 1/2] mm: protect free_pgtables with mmap_lock write lock
 in exit_mmap
Message-ID: <YZ4uE/ySv4y4gdJ4@dhcp22.suse.cz>
References: <20211116215715.645231-1-surenb@google.com>
 <YZzqX0PjxNmhJSvm@casper.infradead.org>
 <CAJuCfpE1zdAL8t2Cnhjar48Xda2GBNTX3BR5X9p_LM2OTiGsJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpE1zdAL8t2Cnhjar48Xda2GBNTX3BR5X9p_LM2OTiGsJw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 23-11-21 09:56:41, Suren Baghdasaryan wrote:
> On Tue, Nov 23, 2021 at 5:19 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Nov 16, 2021 at 01:57:14PM -0800, Suren Baghdasaryan wrote:
> > > @@ -3170,6 +3172,7 @@ void exit_mmap(struct mm_struct *mm)
> > >       unmap_vmas(&tlb, vma, 0, -1);
> > >       free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> > >       tlb_finish_mmu(&tlb);
> > > +     mmap_write_unlock(mm);
> > >
> > >       /*
> > >        * Walk the list again, actually closing and freeing it,
> >
> > Is there a reason to unlock here instead of after the remove_vma loop?
> > We'll need the mmap sem held during that loop when VMAs are stored in
> > the maple tree.
> 
> I didn't realize remove_vma() would need to be protected as well. I
> think I can move mmap_write_unlock down to cover the last walk too
> with no impact.
> Does anyone know if there was any specific reason to perform that last
> walk with no locks held (as the comment states)? I can track that
> comment back to Linux-2.6.12-rc2 merge with no earlier history, so not
> sure if it's critical not to hold any locks at this point. Seems to me
> it's ok to hold mmap_write_unlock but maybe I'm missing something?

I suspect the primary reason was that neither fput (and callbacks
invoked from it) nor vm_close would need to be very careful about
interacting with mm locks. fput is async these days so it shouldn't be
problematic. vm_ops->close doesn't have any real contract definition AFAIK
but taking mmap_sem from those would be really suprising. They should be
mostly destructing internal vma state and that shouldn't really require
address space protection.
-- 
Michal Hocko
SUSE Labs
