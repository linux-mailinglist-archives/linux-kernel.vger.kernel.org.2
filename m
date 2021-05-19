Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7301F388DF7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 May 2021 14:24:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346403AbhESMZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 May 2021 08:25:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36609 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351910AbhESMZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 May 2021 08:25:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621427070;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B6+GMlwrRYCIhKlucQm0d4pBq6rNn427lZR0x1Dlm1U=;
        b=EbYoSluzMNhbEpOumzUwtHyuMIzBpVC//0qSDZmlKC8tYpvcrH6roPskLn/KRzJGCBaWY3
        K/Dv6yOpLAOFtwJI3xqxGOxK/4y8UCIUr1uqg+zZpPAmjdK8ZaJdr2QPqEFxtzIFVYnfBY
        IfTWUQIxVulS/Vqinxa6HFQ1CaFMg4A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-59-txb02T3zOZSyFBBSShzJKg-1; Wed, 19 May 2021 08:24:29 -0400
X-MC-Unique: txb02T3zOZSyFBBSShzJKg-1
Received: by mail-qk1-f200.google.com with SMTP id n2-20020a37a4020000b02902e9aef597f7so9609541qke.21
        for <linux-kernel@vger.kernel.org>; Wed, 19 May 2021 05:24:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B6+GMlwrRYCIhKlucQm0d4pBq6rNn427lZR0x1Dlm1U=;
        b=f+l+IoY0B3l66xp0OIvffyF0RgJ9S5z2BFxV2lj6JgL+0GXpNaG/9/oZg2ek3AabfH
         h96PO5uP0hgx6iAPtr1MIx0PgermZtMrB8y+TaGhOI4zcD18Kezfke6vM6OfTYeF1XAj
         /zhDJ4N4YWOdrrRCyYbx8mFNCiSx/wZgPdxfi68sBsiEbwebY7btfpux8lT6HryECjmj
         q013W/xjl9npWoaNrTg+U1Be+2h946a4gxxDxZY43VkYX5+LlXdIFP9MMegXIdHSmWnN
         ytddjgvFJeYPcr4QJtdbYhv2H70/VdMhi9ZrDtA7D9eqfentMuA63Bh0cMsbLi9Pq9ZW
         AZ3Q==
X-Gm-Message-State: AOAM533GB5Qe7lqstdzU8EDjj3+hGrX1pU3wDqWKKeK3gCwGcbZHevt2
        XJVgTmafxEQ8IP2s+yeVwCWex7TXY2FLhrvll0Lctdv7v1l6/YWLLmNG29bFe/FZ0Kz6CA5gVAB
        Zu68qDBsaGM1Y2n5vEv30PQ3H
X-Received: by 2002:ac8:4b74:: with SMTP id g20mr11134569qts.196.1621427068811;
        Wed, 19 May 2021 05:24:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwfYWS/dsuPCr9XZO07LTE6R21Hbq/UdkcASCcx2KQMguWwavSEob3mks8rwF1tmkFnKYSzdA==
X-Received: by 2002:ac8:4b74:: with SMTP id g20mr11134560qts.196.1621427068562;
        Wed, 19 May 2021 05:24:28 -0700 (PDT)
Received: from t490s (bras-base-toroon474qw-grc-72-184-145-4-219.dsl.bell.ca. [184.145.4.219])
        by smtp.gmail.com with ESMTPSA id m4sm15981169qtg.21.2021.05.19.05.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 05:24:28 -0700 (PDT)
Date:   Wed, 19 May 2021 08:24:27 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, nouveau@lists.freedesktop.org,
        bskeggs@redhat.com, akpm@linux-foundation.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, jhubbard@nvidia.com,
        rcampbell@nvidia.com, jglisse@redhat.com, jgg@nvidia.com,
        hch@infradead.org, daniel@ffwll.ch, willy@infradead.org,
        bsingharora@gmail.com, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v8 5/8] mm: Device exclusive memory access
Message-ID: <YKUDe8Oe4Y+q5Kxx@t490s>
References: <20210407084238.20443-1-apopple@nvidia.com>
 <20210407084238.20443-6-apopple@nvidia.com>
 <YKQutvAa3NlgGaMm@t490s>
 <3859486.fHISG1RMxY@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3859486.fHISG1RMxY@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2021 at 08:49:01PM +1000, Alistair Popple wrote:
> On Wednesday, 19 May 2021 7:16:38 AM AEST Peter Xu wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Wed, Apr 07, 2021 at 06:42:35PM +1000, Alistair Popple wrote:
> > 
> > [...]
> > 
> > > +static bool try_to_protect(struct page *page, struct mm_struct *mm,
> > > +                        unsigned long address, void *arg)
> > > +{
> > > +     struct ttp_args ttp = {
> > > +             .mm = mm,
> > > +             .address = address,
> > > +             .arg = arg,
> > > +             .valid = false,
> > > +     };
> > > +     struct rmap_walk_control rwc = {
> > > +             .rmap_one = try_to_protect_one,
> > > +             .done = page_not_mapped,
> > > +             .anon_lock = page_lock_anon_vma_read,
> > > +             .arg = &ttp,
> > > +     };
> > > +
> > > +     /*
> > > +      * Restrict to anonymous pages for now to avoid potential writeback
> > > +      * issues.
> > > +      */
> > > +     if (!PageAnon(page))
> > > +             return false;
> > > +
> > > +     /*
> > > +      * During exec, a temporary VMA is setup and later moved.
> > > +      * The VMA is moved under the anon_vma lock but not the
> > > +      * page tables leading to a race where migration cannot
> > > +      * find the migration ptes. Rather than increasing the
> > > +      * locking requirements of exec(), migration skips
> > > +      * temporary VMAs until after exec() completes.
> > > +      */
> > > +     if (!PageKsm(page) && PageAnon(page))
> > > +             rwc.invalid_vma = invalid_migration_vma;
> > > +
> > > +     rmap_walk(page, &rwc);
> > > +
> > > +     return ttp.valid && !page_mapcount(page);
> > > +}
> > 
> > I raised a question in the other thread regarding fork():
> > 
> > https://lore.kernel.org/lkml/YKQjmtMo+YQGx%2FwZ@t490s/
> > 
> > While I suddenly noticed that we may have similar issues even if we fork()
> > before creating the ptes.
> > 
> > In that case, we may see multiple read-only ptes pointing to the same page. 
> > We will convert all of them into device exclusive read ptes in rmap_walk()
> > above, however how do we guarantee after all COW done in the parent and all
> > the childs processes, the device owned page will be returned to the parent?
> 
> I assume you are talking about a fork() followed by a call to 
> make_device_exclusive()? I think this should be ok because 
> make_device_exclusive() always calls GUP with FOLL_WRITE both to break COW and 
> because a device performing atomic operations needs to write to the page. I 
> suppose a comment here highlighting the need to break COW to avoid this 
> scenario would be useful though.

Indeed, sorry for the false alarm!  Yes it would be great to mention that too.

-- 
Peter Xu

