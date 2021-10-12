Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF07E42AF89
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 00:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235771AbhJLWMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Oct 2021 18:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:33866 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229588AbhJLWMR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Oct 2021 18:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1634076614;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ua5oJG0CdYheQ7ierae4aE9Z756sdeVCm8xh3uzk1vo=;
        b=GPUpMRrOQo6VVie6L2crtdV6WIyYG/iefwRiFauhRJLjWsEOSzkxhOgbK03A1WXmSkrDb4
        TcXCc+5Mr8fjNkQtIppvRh48NEN556bNS+btbJY8KrZs+AhHm4d6pmBSxfrJiNlEaSKrdS
        vyLz5ywjs4gtv5/S4Wi5hmtqHFYDUJA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-529-h2QyQMHkNFG5er6eNF498A-1; Tue, 12 Oct 2021 18:10:13 -0400
X-MC-Unique: h2QyQMHkNFG5er6eNF498A-1
Received: by mail-pl1-f199.google.com with SMTP id k1-20020a170902c40100b0013f47bac4d8so135635plk.14
        for <linux-kernel@vger.kernel.org>; Tue, 12 Oct 2021 15:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Ua5oJG0CdYheQ7ierae4aE9Z756sdeVCm8xh3uzk1vo=;
        b=caX0o8FD9b0ZqRfX26KFS23cCWdOAt+vIa4GOXaMWg7ikGNR+ekHOFZSvp3q1amkO8
         8cbac0JRVIjQstDBQSFDl2ddwBqpFBhNIZoOV5ZznjfezlQM3HRc6VfZT+/frPe6zNbl
         QyNUBm+L4p7P0KIKppL15N7mPbDiSUXolEYTPZq1OZ5PirsgXOIRXgbcRyBSLtFx2hm1
         ebfWsvKvY8+qOs1SxMfaHdE0SIRZO4EMDx+FdxtfJUg4am7uFObIabOi7n4zev8Zy3Jm
         RXlCfQtvkgF8tYfwfeaKyQCpeTzEckikgcHH4vJvNZpwLSPOI/jduwzdCEmcbLF04huG
         oFlw==
X-Gm-Message-State: AOAM531bmWstO6OXVg0CZNvGL5YuGJKsx7G/p62qe87ufUfHqTGIM7f6
        5OLdDjjsEcuXN5iNTADZJ5sWBykmkwtVrY7s0TpNE64R33p2PnoOrdTeH2A9tGygPYfGtkBl24t
        Eg6fGR8cgmXsgh0lRYum6nMSy
X-Received: by 2002:aa7:8294:0:b0:44c:c0b:d94c with SMTP id s20-20020aa78294000000b0044c0c0bd94cmr34036402pfm.24.1634076612542;
        Tue, 12 Oct 2021 15:10:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwVcl7YM/k3v8LTKkEj6FzmcyKS70hDecSUEZ9AzemVvzccMcT6kL62psxDZo6c4AlO7y5zwg==
X-Received: by 2002:aa7:8294:0:b0:44c:c0b:d94c with SMTP id s20-20020aa78294000000b0044c0c0bd94cmr34036372pfm.24.1634076612191;
        Tue, 12 Oct 2021 15:10:12 -0700 (PDT)
Received: from t490s ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id z13sm11967179pfq.130.2021.10.12.15.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Oct 2021 15:10:11 -0700 (PDT)
Date:   Wed, 13 Oct 2021 06:10:02 +0800
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
Message-ID: <YWYHukJIo8Ol2sHN@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
 <YV4Dz3y4NXhtqd6V@t490s>
 <CAHbLzkp8oO9qvDN66_ALOqNrUDrzHH7RZc3G5GQ1pxz8qXJjqw@mail.gmail.com>
 <CAHbLzkqm_Os8TLXgbkL-oxQVsQqRbtmjdMdx0KxNke8mUF1mWA@mail.gmail.com>
 <YWTc/n4r6CJdvPpt@t490s>
 <YWTobPkBc3TDtMGd@t490s>
 <CAHbLzkrOsNygu5x8vbMHedv+P3dEqOxOC6=O6ACSm1qKzmoCng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkrOsNygu5x8vbMHedv+P3dEqOxOC6=O6ACSm1qKzmoCng@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 12, 2021 at 11:02:09AM -0700, Yang Shi wrote:
> On Mon, Oct 11, 2021 at 6:44 PM Peter Xu <peterx@redhat.com> wrote:
> >
> > On Mon, Oct 11, 2021 at 08:55:26PM -0400, Peter Xu wrote:
> > > Another thing is I noticed soft_offline_in_use_page() will still ignore file
> > > backed split.  I'm not sure whether it means we'd better also handle that case
> > > as well, so shmem thp can be split there too?
> >
> > Please ignore this paragraph - I somehow read "!PageHuge(page)" as
> > "PageAnon(page)"...  So I think patch 5 handles soft offline too.
> 
> Yes, exactly. And even though the split is failed (or file THP didn't
> get split before patch 5/5), soft offline would just return -EBUSY
> instead of calling __soft_offline_page->page_handle_poison(). So
> page_handle_poison() should not see THP at all.

I see, so I'm trying to summarize myself on what I see now with the new logic..

I think the offline code handles hwpoison differently as it sets PageHWPoison
at the end of the process, IOW if anything failed during the offline process
the hwpoison bit is not set.

That's different from how the memory failure path is handling this, as in that
case the hwpoison bit on the subpage is set firstly, e.g. before split thp.  I
believe that's also why memory failure requires the extra sub-page-hwpoison bit
while offline code shouldn't need to: because for soft offline split happens
before setting hwpoison so we just won't ever see a "poisoned file thp", while
for memory failure it could happen, and the sub-page-hwpoison will be a temp
bit anyway only exist for a very short period right after we set hwpoison on
the small page but before we split the thp.

Am I right above?

I feel like __soft_offline_page() still has some code that assumes "thp can be
there", e.g. iiuc after your change to allow file thp split, "hpage" will
always be the same as "page" then in that function, and isolate_page() does not
need to pass in a pagelist pointer too as it'll always be handling a small page
anyway.  But maybe they're fine to be there for now as they'll just work as
before, I think, so just raise it up.

-- 
Peter Xu

