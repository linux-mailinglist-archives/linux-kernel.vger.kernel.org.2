Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 367833B46BB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 17:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhFYPjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Jun 2021 11:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbhFYPjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Jun 2021 11:39:19 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291A5C061574
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 08:36:58 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id t9so7755099qtw.7
        for <linux-kernel@vger.kernel.org>; Fri, 25 Jun 2021 08:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y6YthVsh8dQjzhz84cmChJODP2HFEjc+K0QQHEGVnrE=;
        b=T2BwYjUYm8dCG6g1wWe1slEjX7RbA8+gxd4uTXeIpz6MAqZBFjXxO0iI79vx0SE1SM
         XPYTNq+OMcqMEJMfp75JkHVzfwTSRKyvafXN3ce6757htf4jUVoMPll5xM7QLCuqwfq4
         MgN8O/SiibJV+/qfM7Q+odwqYOr9ZkXGs9CG4YpJ6YWIv6yqcNpUSyM2hQIGN9G/l3Sg
         TS4ePF+Sqj02U5zfYCZ+irvBvHX5G1HOwLm1AIQzBOpgLj1uCrez3v+3OgSEEU8SdV27
         RrUXMrvKGbMRnPKH7bjkGtQtvgIelcb7/U7g9ICmJl3B9i91kJD6oT3oc8NapNCVnEnd
         jSQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y6YthVsh8dQjzhz84cmChJODP2HFEjc+K0QQHEGVnrE=;
        b=gaNcJSRmW4g+YwmVARXA7KB/OfaTu6p8OIzECqRgReV12sZsTN8glEGIbnq0P/nx6b
         65XMDq5dkQ8nTM1mcvfi+2lloqGk0r8feo7GJmjW2y9J9u58mTusk8+DZ/6vpzcPEYvl
         bSaKnH3t1lGut+uvIROWebOXUV2CDa572wK22kesaVpkepE/bS19jjpust8yBr18i4x4
         BlKQVJrZMImEHo3M95wuzyS+Wp6ljzR1rtTPNubnyyA09civFMd0krVP6all+YEHEpXV
         IDNiBILHTSE7aD2VYgiA5nbM2DS+dtOadte9Mcmn/aK4+vW9DIsAqz0ckVE8/+CBLoxr
         wnPQ==
X-Gm-Message-State: AOAM533Q3XTzG18C1aNdE7yJ3fz18MYDvECNkDNhXJaluKR65cDUqbQk
        bylNi9HPVCCGm5lgMM/lbElLvl7sY/tP9V8Cyo6GlQ==
X-Google-Smtp-Source: ABdhPJxhinfjBO7oNGQJqZEc0znZWhLWJqW9EKmj2hb3Pyeuy92aA6j1jXFeEB/bMnV4Wzx3zh5QtfbmO4SnjZr1xU0=
X-Received: by 2002:ac8:7616:: with SMTP id t22mr9735295qtq.43.1624635417070;
 Fri, 25 Jun 2021 08:36:57 -0700 (PDT)
MIME-Version: 1.0
References: <YMe8ktUsdtwFKHuF@nuc10> <CACT4Y+ZjSbioNS8oPwUcyOrLhB6-Sf-WZmadAoAm0H-JYRLo1g@mail.gmail.com>
 <YMpCEu9yM5Ppj5jj@nuc10> <YNTCsqQUaYnlXGbO@nuc10> <20210625150132.GF20835@arm.com>
 <YNX1/6FS4z0eVaLF@nuc10>
In-Reply-To: <YNX1/6FS4z0eVaLF@nuc10>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Fri, 25 Jun 2021 17:36:44 +0200
Message-ID: <CACT4Y+bWQ69-QhQswvzuhm=CvjYovhdGpDQXAkMSj819fc+MTA@mail.gmail.com>
Subject: Re: kmemleak memory scanning
To:     Rustam Kovhaev <rkovhaev@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 25, 2021 at 5:28 PM Rustam Kovhaev <rkovhaev@gmail.com> wrote:
>
> Hi Catalin,
>
> On Fri, Jun 25, 2021 at 04:01:33PM +0100, Catalin Marinas wrote:
> > On Thu, Jun 24, 2021 at 10:36:50AM -0700, Rustam Kovhaev wrote:
> > > On Wed, Jun 16, 2021 at 11:25:22AM -0700, Rustam Kovhaev wrote:
> > > > On Tue, Jun 15, 2021 at 07:15:24AM +0200, Dmitry Vyukov wrote:
> > > > > On Mon, Jun 14, 2021 at 10:31 PM Rustam Kovhaev <rkovhaev@gmail.com> wrote:
> > > > > >
> > > > > > hello Catalin, Andrew!
> > > > > >
> > > > > > while troubleshooting a false positive syzbot kmemleak report i have
> > > > > > noticed an interesting behavior in kmemleak and i wonder whether it is
> > > > > > behavior by design and should be documented, or maybe something to
> > > > > > improve.
> > > > > > apologies if some of the questions do not make sense, i am still going
> > > > > > through kmemleak code..
> > > > > >
> > > > > > a) kmemleak scans struct page (kmemleak.c:1462), but it does not scan
> > > > > > the actual contents (page_address(page)) of the page.
> > > > > > if we allocate an object with kmalloc(), then allocate page with
> > > > > > alloc_page(), and if we put kmalloc pointer somewhere inside that page,
> > > > > > kmemleak will report kmalloc pointer as a false positive.
> > > > > > should we improve kmemleak and make it scan page contents?
> > > > > > or will this bring too many false negatives?
> > > > >
> > > > > Hi Rustam,
> > > > >
> > > > > Nice debugging!
> > > > > I assume lots of pages are allocated for slab and we don't want to
> > > > > scan the whole page if only a few slab objects are alive on the page.
> > > > > However alloc_pages() can be called by end kernel code as well.
> > > > > I grepped for any kmemleak annotations around existing calls to
> > > > > alloc_pages, but did not find any...
> > > > > Does it require an explicit kmemleak_alloc() after allocating the page
> > > > > and kmemleak_free () before freeing the page?
> > > >
> > > > hi Dmitry, thank you!
> > > > yes, as Catalin has pointed out, there are a few places where we call
> > > > kmemleak_alloc()/kmemleak_free() explicitly in order for the pages to be
> > > > scanned, like in blk_mq_alloc_rqs()
> > > >
> > > > > If there are more than one use case for this, I guess we could add
> > > > > some GFP flag for this maybe.
> > > >
> > > > and this way kernel users won't have to use kmemleak fuctions mentioned
> > > > above including some or most kmemleak_not_leak() calls and basically
> > > > kmemleak will be kind of "transparent" to them? and they will only need
> > > > to use the GFP flag to instruct kmemleak to scan the page contents?
> > > > it sounds like a good idea to me..
> > > >
> > >
> > > i've been thinking about this and it seems like in the scenario where we
> > > want kmemleak to scan only some part of the page, we will have to either
> > > do separate alloc_page() calls with different flags or use
> > > kmemleak_scan_area() to limit the memory scan area. maybe this approach
> > > won't simplify things and will produce more code instead of reducing it
> >
> > Since page allocation is not tracked by kmemleak, you can always do an
> > explicit kmemleak_alloc() call with a smaller size than a full page.
> >
> right, but if i understood Dmitry's idea correctly, he was thinking
> about using a new GFP flag, like GFP_KMEMLEAK, and burying
> kmemleak_alloc() in page allocator

I don't have a strong opinion either way. Especially since we have
only 1 use case so far.
