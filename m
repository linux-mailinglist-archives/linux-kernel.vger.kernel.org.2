Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD7E3B469D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 17:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbhFYPa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 11:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbhFYPaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 11:30:25 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4B8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 08:28:04 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id m15-20020a17090a5a4fb029016f385ffad0so5770424pji.0
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 08:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sknCMKkRE/6+TRziL/nLaMcGUMQ1W7V3hpPpOph2UyI=;
        b=ljkuN8uKvvq0RlfQM/0l3qkDQ3HysP4yNNo32ZyOt93p6SxAVBmOM1kEkWcTCvsQMq
         fvvbYijD318W4X+Mb2CXZTVpfD2IuOVv0NaAEqSvmEqPda5fAi9yyHaeJwCUPZiJn+x5
         cmTsODugZUeYc11K9CE2Kh1eT3/VdRwfcPECdT4oVTc3fmG2TLRPa/EJ7LhFDBIOC27n
         SRDrXpBDx6+79A02CnltRUioBgr5FsAVDGXMw5/O/ICFI8ZgsOghLkEjPQRzMXli/XfB
         wdqwCMWvzZ6FrJRfBHaNhrPz5WK6HHJE0v3MovSSdwVFMEcPRm6F9PrkvuOCIEG0eiwa
         vGuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sknCMKkRE/6+TRziL/nLaMcGUMQ1W7V3hpPpOph2UyI=;
        b=frNrB5arZ0af7eYWscRW/m7hTrDpvS48VBzLDL43+WyQzljLBPJugvCNeBcgmbLyMK
         oDB3IlAyXtmJfZP/ECk22A7MOojZp6lHPeWGDULmyjWNmBiXQvNCVp3qE9BFJBfZp64m
         m/87z6nVZN0pvlk62hVeQJdfBRO9T9KrDMiDLYIbWO8R8f0Oe+ZCViRh1CFD9HZu39zk
         FanNjCgGD1Bn1p/FZSJzRR8jWlDzxFwA/ExlNdYHHlBxcKEGGqqutDrpZqynrRKWo2NF
         1Re9jIRv2QkPuHjTzR6pi/97c5rOVy0oQThzUrs6yRZ+wcagWW6/+M/HhwKZm6wJ8azh
         d7Sw==
X-Gm-Message-State: AOAM5311MaIkjzSoORNsW7KhRyCygbL5h0Op0GjcVt3VSJcq9Vs0bV3k
        VOYrY6l+RijGBhcpblaHyLEs60DIBAK5ydT1
X-Google-Smtp-Source: ABdhPJzMI9uX/oyM5J7Z7jIdmBDIkF+cCiVotP8YvqmDkbj47kmbcKBsg7UjhNLOCpWY9b0JJihSAg==
X-Received: by 2002:a17:90b:300c:: with SMTP id hg12mr21684174pjb.46.1624634883938;
        Fri, 25 Jun 2021 08:28:03 -0700 (PDT)
Received: from nuc10 (104.36.148.139.aurocloud.com. [104.36.148.139])
        by smtp.gmail.com with ESMTPSA id c2sm5685379pjv.10.2021.06.25.08.28.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Jun 2021 08:28:03 -0700 (PDT)
Date:   Fri, 25 Jun 2021 08:27:59 -0700
From:   Rustam Kovhaev <rkovhaev@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: kmemleak memory scanning
Message-ID: <YNX1/6FS4z0eVaLF@nuc10>
References: <YMe8ktUsdtwFKHuF@nuc10>
 <CACT4Y+ZjSbioNS8oPwUcyOrLhB6-Sf-WZmadAoAm0H-JYRLo1g@mail.gmail.com>
 <YMpCEu9yM5Ppj5jj@nuc10>
 <YNTCsqQUaYnlXGbO@nuc10>
 <20210625150132.GF20835@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210625150132.GF20835@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Catalin,

On Fri, Jun 25, 2021 at 04:01:33PM +0100, Catalin Marinas wrote:
> On Thu, Jun 24, 2021 at 10:36:50AM -0700, Rustam Kovhaev wrote:
> > On Wed, Jun 16, 2021 at 11:25:22AM -0700, Rustam Kovhaev wrote:
> > > On Tue, Jun 15, 2021 at 07:15:24AM +0200, Dmitry Vyukov wrote:
> > > > On Mon, Jun 14, 2021 at 10:31 PM Rustam Kovhaev <rkovhaev@gmail.com> wrote:
> > > > >
> > > > > hello Catalin, Andrew!
> > > > >
> > > > > while troubleshooting a false positive syzbot kmemleak report i have
> > > > > noticed an interesting behavior in kmemleak and i wonder whether it is
> > > > > behavior by design and should be documented, or maybe something to
> > > > > improve.
> > > > > apologies if some of the questions do not make sense, i am still going
> > > > > through kmemleak code..
> > > > >
> > > > > a) kmemleak scans struct page (kmemleak.c:1462), but it does not scan
> > > > > the actual contents (page_address(page)) of the page.
> > > > > if we allocate an object with kmalloc(), then allocate page with
> > > > > alloc_page(), and if we put kmalloc pointer somewhere inside that page,
> > > > > kmemleak will report kmalloc pointer as a false positive.
> > > > > should we improve kmemleak and make it scan page contents?
> > > > > or will this bring too many false negatives?
> > > > 
> > > > Hi Rustam,
> > > > 
> > > > Nice debugging!
> > > > I assume lots of pages are allocated for slab and we don't want to
> > > > scan the whole page if only a few slab objects are alive on the page.
> > > > However alloc_pages() can be called by end kernel code as well.
> > > > I grepped for any kmemleak annotations around existing calls to
> > > > alloc_pages, but did not find any...
> > > > Does it require an explicit kmemleak_alloc() after allocating the page
> > > > and kmemleak_free () before freeing the page?
> > > 
> > > hi Dmitry, thank you!
> > > yes, as Catalin has pointed out, there are a few places where we call
> > > kmemleak_alloc()/kmemleak_free() explicitly in order for the pages to be
> > > scanned, like in blk_mq_alloc_rqs()
> > > 
> > > > If there are more than one use case for this, I guess we could add
> > > > some GFP flag for this maybe.
> > > 
> > > and this way kernel users won't have to use kmemleak fuctions mentioned
> > > above including some or most kmemleak_not_leak() calls and basically
> > > kmemleak will be kind of "transparent" to them? and they will only need
> > > to use the GFP flag to instruct kmemleak to scan the page contents?
> > > it sounds like a good idea to me..
> > > 
> > 
> > i've been thinking about this and it seems like in the scenario where we
> > want kmemleak to scan only some part of the page, we will have to either
> > do separate alloc_page() calls with different flags or use 
> > kmemleak_scan_area() to limit the memory scan area. maybe this approach
> > won't simplify things and will produce more code instead of reducing it
> 
> Since page allocation is not tracked by kmemleak, you can always do an
> explicit kmemleak_alloc() call with a smaller size than a full page.
> 
right, but if i understood Dmitry's idea correctly, he was thinking
about using a new GFP flag, like GFP_KMEMLEAK, and burying
kmemleak_alloc() in page allocator

