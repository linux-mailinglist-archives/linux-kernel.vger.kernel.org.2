Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A84B42478E
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Oct 2021 21:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239331AbhJFT4V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Oct 2021 15:56:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:53540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229761AbhJFT4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Oct 2021 15:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633550066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xnVRUaB8vdHCAs3GIdbbJkvM/qgvDDY4/1PeZEPVaUU=;
        b=BouuQH6VLug1AM2c+D4y+FAfR5JRzRhBJuwEVWuSIUMVb3msYyp1BM9FPWoqBQaK6aJT68
        JooQQ1w8Yfr//lKEL6mHm8ROCM0VhqdeC6WQXr7jx9XRDT1Uj6mqnEx0s3EeVn5/rExIQZ
        ol+DjXbhnOGEAJuLQn9dYBeguGGQ2qU=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-64-u87vCr2vMdedrsQp8rBXNQ-1; Wed, 06 Oct 2021 15:54:19 -0400
X-MC-Unique: u87vCr2vMdedrsQp8rBXNQ-1
Received: by mail-qk1-f199.google.com with SMTP id m6-20020a05620a24c600b004338e8a5a3cso3049770qkn.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Oct 2021 12:54:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xnVRUaB8vdHCAs3GIdbbJkvM/qgvDDY4/1PeZEPVaUU=;
        b=wloaGeRHR2n8S0uoQdk6a0C+gj62sjuLxW8FPfrfX72I1Oxqbfz5BMTAa0NiBLTq1E
         4DFEo0lFM2kLu1ITnVvIDruaY9K2abpKuEB/eDxyv2lO1PNc4Ux8mGExO3BmR+J0wHWM
         /+ytVtzcz9lyKX+q6PEXnbbnU0abb/NN1k8/7VxFMOXgWpAO4lRTsMqHaNX8IljhC8Ug
         VrKv6LuL9EM9lg/HW9URAHlMdX70UYGMMkw4RZlFfddZ5yTLz2uBfknRUnBn6tBmP3uN
         HbGDzF4LjLOZRSWuVhy0dbv5bswSzreGRgr/q2FQedfL+LiiAftoDFxFBeUcvzUmAwML
         wKqg==
X-Gm-Message-State: AOAM531HjDQr0thr4e0vLIm8etwVQPbka0+rYaFTCWqOuSkof7qad76v
        A2HuP3KUiqvSCZTMTUGsvLh2psAORxTxNi2p1cg3yA74Rv98U10rVMmOv5TT0VZTwEvZX9cNX+Q
        9mB2AJ0owmvmdOj8Am3MCWs2/
X-Received: by 2002:ac8:7e87:: with SMTP id w7mr136149qtj.166.1633550058702;
        Wed, 06 Oct 2021 12:54:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzxud61YtiV9SX04xSMvTTTcQStB2UjjRUVAnxjj7QxgycMhC+ivJ4xXmzGMmXrNEC//a6L0A==
X-Received: by 2002:ac8:7e87:: with SMTP id w7mr136117qtj.166.1633550058362;
        Wed, 06 Oct 2021 12:54:18 -0700 (PDT)
Received: from t490s ([2607:fea8:56a2:9100::bed8])
        by smtp.gmail.com with ESMTPSA id b13sm3355666qkh.134.2021.10.06.12.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 12:54:17 -0700 (PDT)
Date:   Wed, 6 Oct 2021 15:54:16 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Yang Shi <shy828301@gmail.com>
Cc:     "Kirill A. Shutemov" <kirill@shutemov.name>,
        HORIGUCHI =?utf-8?B?TkFPWUEo5aCA5Y+jIOebtOS5nyk=?= 
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
Message-ID: <YV3+6K3uupLit3aH@t490s>
References: <20210930215311.240774-1-shy828301@gmail.com>
 <20210930215311.240774-3-shy828301@gmail.com>
 <20211004140637.qejvenbkmrulqdno@box.shutemov.name>
 <CAHbLzkp5d_j97MizSFCgfnHQj_tUQuHJqxWtrvRo_0kZMKCgtA@mail.gmail.com>
 <20211004194130.6hdzanjl2e2np4we@box.shutemov.name>
 <CAHbLzkqcrGCksMXbW5p75ZK2ODv4bLcdQWs7Jz0NG4-=5N20zw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHbLzkqcrGCksMXbW5p75ZK2ODv4bLcdQWs7Jz0NG4-=5N20zw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 04, 2021 at 01:13:07PM -0700, Yang Shi wrote:
> On Mon, Oct 4, 2021 at 12:41 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> >
> > On Mon, Oct 04, 2021 at 11:17:29AM -0700, Yang Shi wrote:
> > > On Mon, Oct 4, 2021 at 7:06 AM Kirill A. Shutemov <kirill@shutemov.name> wrote:
> > > >
> > > > On Thu, Sep 30, 2021 at 02:53:08PM -0700, Yang Shi wrote:
> > > > > diff --git a/mm/filemap.c b/mm/filemap.c
> > > > > index dae481293b5d..2acc2b977f66 100644
> > > > > --- a/mm/filemap.c
> > > > > +++ b/mm/filemap.c
> > > > > @@ -3195,12 +3195,12 @@ static bool filemap_map_pmd(struct vm_fault *vmf, struct page *page)
> > > > >       }
> > > > >
> > > > >       if (pmd_none(*vmf->pmd) && PageTransHuge(page)) {
> > > > > -         vm_fault_t ret = do_set_pmd(vmf, page);
> > > > > -         if (!ret) {
> > > > > -                 /* The page is mapped successfully, reference consumed. */
> > > > > -                 unlock_page(page);
> > > > > -                 return true;
> > > > > -         }
> > > > > +             vm_fault_t ret = do_set_pmd(vmf, page);
> > > > > +             if (!ret) {
> > > > > +                     /* The page is mapped successfully, reference consumed. */
> > > > > +                     unlock_page(page);
> > > > > +                     return true;
> > > > > +             }
> > > > >       }
> > > > >
> > > > >       if (pmd_none(*vmf->pmd)) {
> > > >
> > > > Hm. Is it unrelated whitespace fix?
> > >
> > > It is a coding style clean up. I thought it may be overkilling to have
> > > a separate patch. Do you prefer separate one?
> >
> > Maybe. I tried to find what changed here. It's confusing.
> 
> Yeah, maybe. Anyway I will separate the real big fix and the cleanup
> into two patches. This may be helpful for backporting too.

Or maybe we just don't touch it until there's need for a functional change?  I
feel it a pity to lose the git blame info for reindent-only patches, but no
strong opinion, because I know many people don't think the same and I'm fine
with either ways.

Another side note: perhaps a comment above pageflags enum on PG_has_hwpoisoned
would be nice?  I saw that we've got a bunch of those already.

Thanks,

-- 
Peter Xu

