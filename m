Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A82B042B30A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 05:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237010AbhJMDDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 23:03:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46085 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229980AbhJMDDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 23:03:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634094104;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qAK7ZtyLejfkOrKCroLEuyBtwqTtOLSVz4puxzj6usQ=;
        b=T+cpt8QWNnL4ZfodoggsyipXB6iPu2yGt5rcReBb+DVCN76uqUduOMZNvPBEHfoxgJWMfd
        g4xtKKVO2AgaK5gnTiypK/1D8POMSKYiL0xyexvj5q57COp21swbNAERI8rTMpRNCJdPeY
        HeuCLnfgHqNFljKlSgO8QrPI2+tZ2Ks=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-UB0ebTrgMRifbd23g8mhDA-1; Tue, 12 Oct 2021 23:01:43 -0400
X-MC-Unique: UB0ebTrgMRifbd23g8mhDA-1
Received: by mail-pg1-f198.google.com with SMTP id d5-20020a63ed05000000b002688d3aff8aso662928pgi.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 20:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qAK7ZtyLejfkOrKCroLEuyBtwqTtOLSVz4puxzj6usQ=;
        b=Vqqi3calW2TSaB2CEyCefmuGZZblumgoL+B5xW+vapPrfcAznjP32JkFbDfjeT6dAb
         QX+QqbH1JRSJPMnqP/ZmDxyKlsMs2ax/c8kmiG+/1EIxNSIe+4lO47RAxr8hWgLmp0kR
         oWWycon2QDD/d+n6mfSjxWiD8mBg3CtIBX+srxcoBw6a8cv/4BwZeA0MiGYu9yu6FSrw
         8j9WgEVuB7vz0QcT2LjmedEEOag5MYmy7eQAwgVUNUIUABpQmnX5RMgZEuaksuilZkBw
         Qw2Pvr/Y6y5IRuVzFjqxcgfESdmNDU8IIc1nzJP8FTtOJ1MlpbMf/dsY5erm791eGCzP
         9Qxg==
X-Gm-Message-State: AOAM532PvuBvJLnHsFlUst3MuJx9clFz5G0POXLj+0rFfpJz4nhJlfvT
        +nVo6UkubdQgZwy6zxvscL9GXyTadFD9CsU7cUOH4YWkWrlV2xEf/NS0VDiMwHLhXlt3JLHohz7
        ndlSMwoqeVKCHmblqd8Qtcip2
X-Received: by 2002:a17:902:b18a:b0:13e:e5f3:1b25 with SMTP id s10-20020a170902b18a00b0013ee5f31b25mr33374302plr.78.1634094101808;
        Tue, 12 Oct 2021 20:01:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJypNI1X8unmkUC5RrbJrw/a546NZtB/kQO1FWilxGsO15l6uPTi+8w4knAmVYrQr7I3dSjsNQ==
X-Received: by 2002:a17:902:b18a:b0:13e:e5f3:1b25 with SMTP id s10-20020a170902b18a00b0013ee5f31b25mr33374264plr.78.1634094101392;
        Tue, 12 Oct 2021 20:01:41 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id p189sm12224275pfp.167.2021.10.12.20.01.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 20:01:40 -0700 (PDT)
Date:   Wed, 13 Oct 2021 11:01:33 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
        <naoya.horiguchi@nec.com>, Hugh Dickins <hughd@google.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [v3 PATCH 2/5] mm: filemap: check if THP has hwpoisoned subpage
 for PMD page fault
Message-ID: <YWZMDTwCCZWX5/sQ@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
 <YV4Dz3y4NXhtqd6V@t490s>
 <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
 <CAHbLzkqm_Os8TLXgbkL-oxQVsQqRbtmjdMdx0KxNke8mUF1mWA@mail.gmail.com>
 <YWTc/n4r6CJdvPpt@t490s>
 <YWTobPkBc3TDtMGd@t490s>
 <CAHbLzkrOsNygu5x8vbMHedv+P3dEqOxOC6=O6ACSm1qKzmoCng@mail.gmail.com>
 <YWYHukJIo8Ol2sHN@t490s>
 <CAHbLzkp3UXKs_NP9XD_ws=CSSFzUPk7jRxj0K=gvOqoi+GotmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkp3UXKs_NP9XD_ws=CSSFzUPk7jRxj0K=gvOqoi+GotmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 07:48:39PM -0700, Yang Shi wrote:
> On Tue, Oct 12, 2021 at 3:10 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Tue, Oct 12, 2021 at 11:02:09AM -0700, Yang Shi wrote:
> > > On Mon, Oct 11, 2021 at 6:44 PM Peter Xu <peterx@redhat.com> wrote:
> > > >
> > > > On Mon, Oct 11, 2021 at 08:55:26PM -0400, Peter Xu wrote:
> > > > > Another thing is I noticed soft_offline_in_use_page() will still ignore file
> > > > > backed split.  I'm not sure whether it means we'd better also handle that case
> > > > > as well, so shmem thp can be split there too?
> > > >
> > > > Please ignore this paragraph - I somehow read "!PageHuge(page)" as
> > > > "PageAnon(page)"...  So I think patch 5 handles soft offline too.
> > >
> > > Yes, exactly. And even though the split is failed (or file THP didn't
> > > get split before patch 5/5), soft offline would just return -EBUSY
> > > instead of calling __soft_offline_page->page_handle_poison(). So
> > > page_handle_poison() should not see THP at all.
> >
> > I see, so I'm trying to summarize myself on what I see now with the new logic..
> >
> > I think the offline code handles hwpoison differently as it sets PageHWPoison
> > at the end of the process, IOW if anything failed during the offline process
> > the hwpoison bit is not set.
> >
> > That's different from how the memory failure path is handling this, as in that
> > case the hwpoison bit on the subpage is set firstly, e.g. before split thp.  I
> > believe that's also why memory failure requires the extra sub-page-hwpoison bit
> > while offline code shouldn't need to: because for soft offline split happens
> > before setting hwpoison so we just won't ever see a "poisoned file thp", while
> > for memory failure it could happen, and the sub-page-hwpoison will be a temp
> > bit anyway only exist for a very short period right after we set hwpoison on
> > the small page but before we split the thp.
> >
> > Am I right above?
> 
> Yeah, you are right. I noticed this too, only successfully migrated
> page is marked as hwpoison. But TBH I'm not sure why it does this way.

My wild guess is that unlike memory failures, soft offline is best-effort. Say,
the data on the page is still consistent, so even if offline failed for some
reason we shouldn't stop the program from execution.  That's not true for
memory failures via MCEs, afaict, as the execution could read/write wrong data
and that'll be a serious mistake, so we set hwpoison 1st there first before
doing anything else, making sure "this page is broken" message delivered and
user app won't run with risk.

But yeah it'll be great if Naoya could help confirm that.

> Naoya may know. Anyway, THP doesn't get migrated if it can't be split,
> so PageHasHWPoisoned doesn't apply, right?

Right, that matches my current understanding of the code, so the extra bit is
perhaps not useful for soft offline case.

But this also reminded me that shouldn't we be with the page lock already
during the process of "setting hwpoison-subpage bit, split thp, clear
hwpoison-subpage bit"?  If it's only the small window that needs protection,
while when looking up the shmem pagecache we always need to take the page lock
too, then it seems already safe even without the extra bit?  Hmm?

> 
> >
> > I feel like __soft_offline_page() still has some code that assumes "thp can be
> > there", e.g. iiuc after your change to allow file thp split, "hpage" will
> > always be the same as "page" then in that function, and isolate_page() does not
> > need to pass in a pagelist pointer too as it'll always be handling a small page
> > anyway.  But maybe they're fine to be there for now as they'll just work as
> > before, I think, so just raise it up.
> 
> That compound_head() call seems to be for hugetlb since isolating
> hugetlb needs to pass in the head page IIUC. For the pagelist, I think
> it is just because migrate_pages() requires a list as the second
> parameter.

Fair enough.

Thanks,

-- 
Peter Xu

