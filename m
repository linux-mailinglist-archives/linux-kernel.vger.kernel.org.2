Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B13F43BC59
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Oct 2021 23:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239586AbhJZV1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Oct 2021 17:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239576AbhJZV1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Oct 2021 17:27:15 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01699C061570
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 14:24:51 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id n7so1124943ljp.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Oct 2021 14:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eH7S5IumUVeN7L8l1WgDLmgF00kuecfKrHYb8RcvYCs=;
        b=AjHm0pXtMOyYcyYD3wvK5+j6X3gTYWxd2SRvwXksgKKjz9avBBM7spcuif+K+BVMJY
         d7mI5LVg0RqlXjn3XsrNUkpcG9WkpQFA3Ptcvsg45ufd9zxnAqWUyqDqlpcwKxP5Sefv
         SjtrYVFeeO/7duhIxQhyuB8jLaYa0aP3Dlt4cUDecgxkq81mn0J+sezkaNIBA0x5OvpC
         0ITSj5rk5Cx/U52Fbx9JhzyKC+KPngCZzQ15+AvS+iR0n2Eb96MbUn+rLAPhNzD3oJ+7
         nsbuERUC51elKjxAh+TTG02wbx4PUcqCbvSpON8ShUxJ1GXhM8UYvgAjkBOkxUFojuHr
         7s4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eH7S5IumUVeN7L8l1WgDLmgF00kuecfKrHYb8RcvYCs=;
        b=cgbeT1N+j74kGSy4/O3Lg9Ocf5zdJRUzn5NmaLc7ttRU0jHkrWVIXyL/Ua/RDqFlVc
         NPQuOl2tKJu1UDwmHmE6XQp1EbH3U6bp8evTpXVBmn+xI46yaEFatpPYAItljvVZSLW6
         eSHkqw+IINoRF5caUR1mx+WCOv3v71N1YTgmTvyhfNMddhFb4J7iyiH66qqeaPwbT+1q
         KugXHizDLggHLQweb6cH3MKzLGCvPPTXbZfc5ViHCKb5qR5UC/7ps7vQD/NwUdPwBy8L
         ePHuFx+QzQwOi2njsgCNl1ZZ1590t15CkRJIGsmNf/+wPrsBdxxjWJ01IJpzQ4Q8X2wA
         b2MA==
X-Gm-Message-State: AOAM531EFivAZABiqmPQIP9tBg6lVpLHd+5SZeScLovh3JtblKA6JdfT
        MwQFYZU4DethNPDzEKqhD8WkUVX6ye2sWAts4QtWYQ==
X-Google-Smtp-Source: ABdhPJxgEpVsONeBJ/mXU1kEZqRAB95gArl1xcPgE1AXUX5wSDjbzr/NDKJ0OuOSRof/wfJ+uUwFFDvm4D0CbfOmcYI=
X-Received: by 2002:a2e:810c:: with SMTP id d12mr29001490ljg.177.1635283489290;
 Tue, 26 Oct 2021 14:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20211026173822.502506-1-pasha.tatashin@soleen.com>
 <YXhHq52jDrU61V4E@casper.infradead.org> <CA+CK2bBbGEJa4s7HtgQkG_tZmN66UaVcDRovgLz4q+a0VGSqZg@mail.gmail.com>
 <YXhhbSSRQrG5Av6P@casper.infradead.org>
In-Reply-To: <YXhhbSSRQrG5Av6P@casper.infradead.org>
From:   Pasha Tatashin <pasha.tatashin@soleen.com>
Date:   Tue, 26 Oct 2021 17:24:12 -0400
Message-ID: <CA+CK2bBhMHv=G0Hd=rmCHUjKDOw0sYhOX2q3DfBXSJWFdQj8BQ@mail.gmail.com>
Subject: Re: [RFC 0/8] Hardening page _refcount
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

On Tue, Oct 26, 2021 at 4:14 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Tue, Oct 26, 2021 at 02:30:25PM -0400, Pasha Tatashin wrote:
> > On Tue, Oct 26, 2021 at 2:24 PM Matthew Wilcox <willy@infradead.org> wrote:
> > > I think this is overkill.  Won't we get exactly the same protection
> > > by simply testing that page->_refcount == 0 in set_page_count()?
> > > Anything which triggers that BUG_ON would already be buggy because
> > > it can race with speculative gets.
> >
> > We can't because set_page_count(v) is used for
> > 1. changing _refcount form a current value to unconstrained v
> > 2.  initialize _refcount from undefined state to v.
> >
> > In this work we forbid the first case, and reduce the second case to
> > initialize only to 1.
>
> Anything that is calling set_page_refcount() on something which is
> not 0 is buggy today

For performance reasons the memblock allocator does not zero struct
page memory, we initialize every field in struct page individually,
that includes page->_refcount. Most of the time the boot memory is
zeroed by firmware, but it is not guaranteed, non-zero pages can come
from bootloader, or from freed firmware pages. Also, after kexec
memory state is not zeroed as well, and struct pages can contain
garbage until fields are initialized.

This is a valid reason to do set_page_recount() with non-zero
refcounts, but the function is too generic, as in this case we really
need to set it only to 1: so instead rename it to page_ref_init() and
set it only to 1.

Another example:
In __free_pages_core() and in init_cma_reserved_pageblock() we do
set_page_refcount() when _ref_count is 1 and we change it to 0.

In this case doing dec_return check makes more sense in order to
verify that the ref_count was indeed 1, and we won't have a double
free.

>  There are several ways to increment the page
> refcount speculatively if it is not 0.  eg lockless GUP and page cache
> reads.  So we could have:
>
> CPU 0: alloc_page() (refcount now 1)
> CPU 1: get_page_unless_zero() (refcount now 2)
> CPU 0: set_page_refcount(5) (refcount now 5)
> CPU 1: put_page() (refcount now 4)
>
> Now the refcount is wrong.  So it is *only* safe to call
> set_page_refcount() if the refcount is 0.  If you can find somewhere
> that's calling set_page_refcount() on a non-0 refcount, that's a bug
> that needs to be fixed.

Right, add_return/sub_return() with check after operation ensures that
there are no races where we could have some writes to refcount between
knowing it is 0 and calling set_page_refcount().

Thanks,
Pasha
