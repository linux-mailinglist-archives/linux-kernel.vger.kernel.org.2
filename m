Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9F943BC79
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:35:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239657AbhJZVhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239651AbhJZVhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:37:20 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D27C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 14:34:56 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id o11so1117024ljg.10
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 14:34:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g6bRc3hEdmoyhbDnFfzjpCbgpj5AnIIMpxpQWkoEAPc=;
        b=Q4c50WAkXBkEgY6gvfcvo5e8MhJnvWwBTJNOzFIu/Getb0WstjIXLdG5eqbfR8JHCO
         E6Y0rOmp5bYSVo1Q9PcxShZiHfhSraEdNL+WfcryfjngLxGyqGCsA5mFOURH3O99GL/i
         KVy9PC23hRaZpo6bFOq801aVnJMORPKPAlnrqhhYhS6shRWe6cLbC0zIajMFQL8Rjy+Y
         9c1nn6cpFy+B2gmYUl2It8YpTn+2JQ5ZHX22aV2hXltq1IDGBQO1f7LThO574E+8qUnV
         crYxEAr25H0V5ROMUrRin0hi1zM0AlaD7yMwLRHVEEVtJLGIPpPI2022dKE11PYdtY6s
         4Pvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g6bRc3hEdmoyhbDnFfzjpCbgpj5AnIIMpxpQWkoEAPc=;
        b=TY/lZpUyFSsuUqq3bZru8oUITWudPg02CUzRohW2hkUr8E3F9G/Cx383JaH3mdOs2m
         UEqr06DlQ8tXYgKYUbtgfzJdHNqI+Fb4rs0Dy1M91aeq/n6SxmQxJYeROGtD0kpaA5GF
         PVfBjHGjq9v6XnFt9Lv7h0QCkJqugYH37pHziXPiGxZ4fmKZCKhMKkYKil7cMZRwjYga
         HnfZltVVohWhHrH9YoOgy572Y+zXntj4SDTu9+hrgD/eNet+Ts/8zTu8bhgfFNy788+L
         GxwI+NZ4dUKkVhXFw0zNT13tpt1oPqDil3/80nUUEqH+UBZ8Ab8lRMu1cDpp1ooOYFi0
         P3NA==
X-Gm-Message-State: AOAM532SwOcaiQOCOgQeE83BvZ1bV8FBAhiXKqgR7zT6AKKUqaLVfF71
        MgZyw/t1nx3fYfvOYFL3PS8tp+8+QNA5JRNKgLoGaA==
X-Google-Smtp-Source: ABdhPJyq6ZHqYiDS8wM3KDSM1FRUj5xGQE4Nq6PhjHX04LBcqXGgXrhGvXWB7NaICqxAg2MRMZNWWZ7nPiqdXVQhY5o=
X-Received: by 2002:a2e:a0d7:: with SMTP id f23mr29374831ljm.422.1635284094799;
 Tue, 26 Oct 2021 14:34:54 -0700 (PDT)
MIME-Version: 1.0
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <20211026173822.502506-2-pasha.tatashin@soleen.com> <YXhbq/6OIpIAr7Tx@casper.infradead.org>
In-Reply-To: <YXhbq/6OIpIAr7Tx@casper.infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 26 Oct 2021 17:34:18 -0400
Message-ID: <CA+CK2bCZO5J-NRqavWFKXt+yB1u17dFA9VrW48HLBepiQLJtcA@mail.gmail.com>
Subject: Re: [RFC 1/8] mm: add overflow and underflow checks for page->_refcount
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
        linux-m68k@lists.linux-m68k.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        william.kucharski@oracle.com,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        schmitzmic@gmail.com, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <guro@fb.com>, songmuchun@bytedance.com,
        weixugc@google.com, Greg Thelen <gthelen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 26, 2021 at 3:50 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Oct 26, 2021 at 05:38:15PM +0000, Pasha Tatashin wrote:
> >  static inline void page_ref_add(struct page *page, int nr)
> >  {
> > -     atomic_add(nr, &page->_refcount);
> > +     int ret;
> > +
> > +     VM_BUG_ON(nr <= 0);
> > +     ret = atomic_add_return(nr, &page->_refcount);
> > +     VM_BUG_ON_PAGE(ret <= 0, page);
>
> This isn't right.  _refcount is allowed to overflow into the negatives.
> See page_ref_zero_or_close_to_overflow() and the conversations that led
> to it being added.

#define page_ref_zero_or_close_to_overflow(page) \
1204   ((unsigned int) page_ref_count(page) + 127u <= 127u)


Uh, right, I saw the macro but did not realize there was an (unsigned int) cast.

OK, I think we can move this macro inside:
include/linux/page_ref.h

modify it to something like this:
#define page_ref_zero_or_close_to_overflow(page) \
   ((unsigned int) page_ref_count(page) + v + 127u <= v + 127u)

The sub/dec can also be fixed to ensure that we do not underflow but
still working with the fact that we use all 32bits of _refcount.

Pasha
