Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7C631A643
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Feb 2021 21:55:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbhBLUzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Feb 2021 15:55:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:56548 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229497AbhBLUzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:55:37 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4E1EF64DEC;
        Fri, 12 Feb 2021 20:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1613163296;
        bh=Ia9H3DANjBECP5ALIOgyaTEVqkmPXIUALarC94QCNpE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MXmSU8z6UjJKHj5Jy0OCYdQljNqK1FT9j5QRP8bMb4dzRIcGqgLyZfemibatf0t2z
         3Hr/WSBzaf3unKsuB8vamGctrNcGwM3Ycmryx9kCM2SJwAbbw0zPfmlhC8nfTOnTz3
         6Qq+4rNaxOYNTC1wjI8hPtaBMwp20NMi4gkBuRRM=
Date:   Fri, 12 Feb 2021 12:54:54 -0800
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
Message-Id: <20210212125454.b660a3bf3e9945515f530066@linux-foundation.org>
In-Reply-To: <CAAeHK+z5pkZkuNbqbAOSN_j34UhohRPhnu=EW-_PtZ88hdNjpA@mail.gmail.com>
References: <e7eeb252da408b08f0c81b950a55fb852f92000b.1613155970.git.andreyknvl@google.com>
        <20210212121610.ff05a7bb37f97caef97dc924@linux-foundation.org>
        <CAAeHK+z5pkZkuNbqbAOSN_j34UhohRPhnu=EW-_PtZ88hdNjpA@mail.gmail.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Feb 2021 21:21:39 +0100 Andrey Konovalov <andreyknvl@google.com> wrote:

> > > The wrappers aren't defined when tests aren't enabled to avoid misuse.
> > > The mte_() functions aren't exported directly to avoid having low-level
> > > KASAN ifdefs in the arch code.
> > >
> >
> > Please confirm that this is applicable to current Linus mainline?
> 
> It's not applicable. KUnit tests for HW_TAGS aren't supported there,
> the patches for that are in mm only. So no need to put it into 5.11.

So... which -mm patch does this patch fix?
