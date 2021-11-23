Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B90045AAA4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Nov 2021 18:56:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239365AbhKWSAC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Nov 2021 13:00:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbhKWSAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Nov 2021 13:00:01 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 589A6C061574
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:56:53 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id q74so61647745ybq.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Nov 2021 09:56:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zhBSENOcjRgENIr5y/hkg5ZA7piRHECklFcLpKkWeOU=;
        b=i8L0F+POA6/OG1wJdDKJ+V3RWIG3ljK/HPcc+zFAxc959TgzAdbmMTKWYL3nGZnIVz
         6r43QYC2WIUP7ppTPEQ8F8s81273/JkfviMNp+wq/BsoyQK7JWq9ku5vShCXLM92dqLD
         D5oCArI1rhyWsUsWOAld+v7uzKloJVKVIfqpt78g79AjF3hqZHrdcMfsZ4YXk6ujELqQ
         cEnDpXhcNLFWjqb0mr/TK/OH+nwMiCci+hahnemfiHwcbPL4ZB/gHB3kVeIXc4kmaz1+
         vrLMje1Ogb8oHxQbXLIcIhvzpxo+cKdWwOVfRLIDKb595QjR2L/UryHBx5FnyogIjFOD
         SuiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zhBSENOcjRgENIr5y/hkg5ZA7piRHECklFcLpKkWeOU=;
        b=RbxY9ILT+BfvjgXtrfcdnsT+1wGj3RPXTbTpCbap0hr5wczy5VRBtBRhAhsfjI08my
         fl05tuaM3jvF5mf2EN237LIIv5Y8bh2bsi1Xozdvdqr+EwndpbO7D5nN6Cjso+YBuOv6
         gBDNwxwGta03Ycvqyy10VaRlK4yZznJ3igR+a3gGSB+d+W+NG4Dc1dTsP9PJmhb2crBA
         zveC1eWJWV4YWSuHzLb33W630GDlTX4iFIB4fitmDisQjdCLfm4o4UhpzOc8BeoWfbil
         ZEwBHydD54QjksAC6SbzlTPeVevg5BUxnUR3y9Bi5HoLcPhstY6oy0WEW8/1n6AXzyi5
         /OMg==
X-Gm-Message-State: AOAM5331ttBGfHI+cGyHaNpKlVrkGmI3CRebTnRcPRR6LHM53igJXqdp
        Pi2qg/nRl5JdC9Oo4lwuNiLyhUN/JkhybNko/XscYA==
X-Google-Smtp-Source: ABdhPJwuIzMs0ujfhuW0hjM6tf1x63+EELDkBNf6nzkT6+D9tRn7uvgz7huY+84qHCFlkeJuoZsdvPv+FLqKzDlvo7M=
X-Received: by 2002:a25:8411:: with SMTP id u17mr8441656ybk.376.1637690212376;
 Tue, 23 Nov 2021 09:56:52 -0800 (PST)
MIME-Version: 1.0
References: <20211116215715.645231-1-surenb@google.com> <YZzqX0PjxNmhJSvm@casper.infradead.org>
In-Reply-To: <YZzqX0PjxNmhJSvm@casper.infradead.org>
From:   Suren Baghdasaryan <surenb@google.com>
Date:   Tue, 23 Nov 2021 09:56:41 -0800
Message-ID: <CAJuCfpE1zdAL8t2Cnhjar48Xda2GBNTX3BR5X9p_LM2OTiGsJw@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm: protect free_pgtables with mmap_lock write lock
 in exit_mmap
To:     Matthew Wilcox <willy@infradead.org>
Cc:     akpm@linux-foundation.org, mhocko@kernel.org, mhocko@suse.com,
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

On Tue, Nov 23, 2021 at 5:19 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Nov 16, 2021 at 01:57:14PM -0800, Suren Baghdasaryan wrote:
> > @@ -3170,6 +3172,7 @@ void exit_mmap(struct mm_struct *mm)
> >       unmap_vmas(&tlb, vma, 0, -1);
> >       free_pgtables(&tlb, vma, FIRST_USER_ADDRESS, USER_PGTABLES_CEILING);
> >       tlb_finish_mmu(&tlb);
> > +     mmap_write_unlock(mm);
> >
> >       /*
> >        * Walk the list again, actually closing and freeing it,
>
> Is there a reason to unlock here instead of after the remove_vma loop?
> We'll need the mmap sem held during that loop when VMAs are stored in
> the maple tree.

I didn't realize remove_vma() would need to be protected as well. I
think I can move mmap_write_unlock down to cover the last walk too
with no impact.
Does anyone know if there was any specific reason to perform that last
walk with no locks held (as the comment states)? I can track that
comment back to Linux-2.6.12-rc2 merge with no earlier history, so not
sure if it's critical not to hold any locks at this point. Seems to me
it's ok to hold mmap_write_unlock but maybe I'm missing something?
