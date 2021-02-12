Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E871F31A68D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 22:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbhBLVJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 16:09:02 -0500
Received: from mail.kernel.org ([198.145.29.99]:58732 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231289AbhBLVI6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 16:08:58 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0CAEE601FF;
        Fri, 12 Feb 2021 21:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1613164097;
        bh=TshSgO+ebZMoA2lgK0wETLr/ZM7OS4W2rKQLUJLiZOU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=dU5l63E+JgxMA9hCk/3yD9QdirwmUXp/uYUF/gEWBBbbw6aFNgKIWCCg8n7d9iNNh
         xIokgctQ+x5kt8jukAVR82rLaJELRFGZ940HgrgWFfqL+372qV9zOpCQ3jCpX4vpsx
         0hLdVCahws96UqaUmfsgjYBkWnBv4Yf5GBg//51o=
Date:   Fri, 12 Feb 2021 13:08:16 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Christoph Hellwig <hch@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH mm] kasan: export HW_TAGS symbols for KUnit tests
Message-Id: <20210212130816.cde26643a6b9b24007be4e54@linux-foundation.org>
In-Reply-To: <CAAeHK+w6znh95iHY496B15Smtoaun73yLYLCBr+FBu3J57knzQ@mail.gmail.com>
References: <e7eeb252da408b08f0c81b950a55fb852f92000b.1613155970.git.andreyknvl@google.com>
        <20210212121610.ff05a7bb37f97caef97dc924@linux-foundation.org>
        <CAAeHK+z5pkZkuNbqbAOSN_j34UhohRPhnu=EW-_PtZ88hdNjpA@mail.gmail.com>
        <20210212125454.b660a3bf3e9945515f530066@linux-foundation.org>
        <CAAeHK+w6znh95iHY496B15Smtoaun73yLYLCBr+FBu3J57knzQ@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Feb 2021 22:01:38 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:

> On Fri, Feb 12, 2021 at 9:54 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Fri, 12 Feb 2021 21:21:39 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:
> >
> > > > > The wrappers aren't defined when tests aren't enabled to avoid misuse.
> > > > > The mte_() functions aren't exported directly to avoid having low-level
> > > > > KASAN ifdefs in the arch code.
> > > > >
> > > >
> > > > Please confirm that this is applicable to current Linus mainline?
> > >
> > > It's not applicable. KUnit tests for HW_TAGS aren't supported there,
> > > the patches for that are in mm only. So no need to put it into 5.11.
> >
> > So... which -mm patch does this patch fix?
> 
> "kasan, arm64: allow using KUnit tests with HW_TAGS mode".
> 
> There will be some minor adjacent-line-changed conflicts if you decide
> to squash it.
> 
> Alternatively, this can go as a separate patch after the tests series
> (after "kasan: don't run tests when KASAN is not enabled").

Thanks - it wasn't obvious.

I staged it as a fix against "kasan, arm64: allow using KUnit tests
with HW_TAGS mode".  To make the series as nice as we can, and to avoid
bisection holes.

