Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E243C6584
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jul 2021 23:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhGLVkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jul 2021 17:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhGLVkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jul 2021 17:40:06 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4508CC0613DD
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 14:37:17 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id y16so1450858iol.12
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 14:37:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1pWHLTVi/seYJklLFaD8uR16Mpsf9bybDbOoEox28Wk=;
        b=betyJUHVcpTHSCBSeD07sN0K8C6tPSmZfCoDPfxQES5lDAfQVYaMfIA26BViacjgf2
         5X0L1rehs/mU2fK8En0euAyLpE7ibLO34iDwprIyh72moTtkvExMovhrF5ZLsG1El0Hx
         /fmZtmDd1tR5l9VwGr4CsUWbFoCLTz5D2Ijlc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1pWHLTVi/seYJklLFaD8uR16Mpsf9bybDbOoEox28Wk=;
        b=dngLsgHUiowCHoRV6VQP8jbSVdCD1s077jCL1rrJM25xQS0YHuoDGx0zbcnOEmn4Mu
         NZiHv/5NQ1DTw2LnXsbTOS9wl+wXbT9RNSzSXoUsTc6Op7wxvRXS18o0h4htsjXAVMNd
         a7JdzfO44qZ2qos4t2UTAY8QD58R7XSkFwDpxMJSYS2IRaDujbBBrdmw8gKvjORcearK
         mGAn6DtOFJIYGfC7ByYiulqceGZHlu0NbuiH0BokB8TFuFeL7YvNSV4Q6mMtHwVjXcBT
         UUHuugcAqHnj54LLqYPSo/InTdGlGhDhC04r9F6K9qOwyVXNzdn0uV3nZb04Yz2UiCv9
         xxOg==
X-Gm-Message-State: AOAM533oOgn9Kt0gu5q3gullUa45JI/AH6eq6xvB3V67xeR6wsFkmLKf
        tZ3W1sFfn/qme2Vw4uQqmQeWs9ipEPhzSw==
X-Google-Smtp-Source: ABdhPJwcx91dUE0KBGR34Zf8nz1GxPZ5BTvZAQVOHxnAsEy/Az3GfTzon0fEEDdQRMRLP9Pm7PmSug==
X-Received: by 2002:a5d:9cd9:: with SMTP id w25mr714212iow.36.1626125836431;
        Mon, 12 Jul 2021 14:37:16 -0700 (PDT)
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com. [209.85.166.42])
        by smtp.gmail.com with ESMTPSA id i5sm9048870ilc.16.2021.07.12.14.37.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 14:37:15 -0700 (PDT)
Received: by mail-io1-f42.google.com with SMTP id x10so5712936ion.9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jul 2021 14:37:15 -0700 (PDT)
X-Received: by 2002:a02:2a07:: with SMTP id w7mr911188jaw.96.1626125835291;
 Mon, 12 Jul 2021 14:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210709105012.v2.1.I09866d90c6de14f21223a03e9e6a31f8a02ecbaf@changeid>
 <20210709152024.36f650dfec4c66ef3a60a845@linux-foundation.org>
 <CAE=gft48qBiq_cbdf2AZa_Ap1eB3BBvrLLD3m2cBwkYPy3b8Nw@mail.gmail.com> <20210709163328.16fcdd3601d1ba0b93baad65@linux-foundation.org>
In-Reply-To: <20210709163328.16fcdd3601d1ba0b93baad65@linux-foundation.org>
From:   Evan Green <evgreen@chromium.org>
Date:   Mon, 12 Jul 2021 14:36:39 -0700
X-Gmail-Original-Message-ID: <CAE=gft5qdEvi=xtQEUwvCH=M_82daY-TRsosMMQ0SHVRCsr2JQ@mail.gmail.com>
Message-ID: <CAE=gft5qdEvi=xtQEUwvCH=M_82daY-TRsosMMQ0SHVRCsr2JQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Enable suspend-only swap spaces
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     David Hildenbrand <david@redhat.com>, Pavel Machek <pavel@ucw.cz>,
        Alex Shi <alexs@kernel.org>,
        Alistair Popple <apopple@nvidia.com>,
        Jens Axboe <axboe@kernel.dk>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Michal Hocko <mhocko@suse.com>,
        Minchan Kim <minchan@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        LKML <linux-kernel@vger.kernel.org>, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 9, 2021 at 4:33 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Fri, 9 Jul 2021 16:23:18 -0700 Evan Green <evgreen@chromium.org> wrote:
>
> > On Fri, Jul 9, 2021 at 3:20 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Fri,  9 Jul 2021 10:50:48 -0700 Evan Green <evgreen@chromium.org> wrote:
> > >
> > > > Currently it's not possible to enable hibernation without also enabling
> > > > generic swap for a given swap area. These two use cases are not the
> > > > same. For example there may be users who want to enable hibernation,
> > > > but whose drives don't have the write endurance for generic swap
> > > > activities.
> > > >
> > > > Add a new SWAP_FLAG_NOSWAP that adds a swap region but refuses to allow
> > > > generic swapping to it. This region can still be wired up for use in
> > > > suspend-to-disk activities, but will never have regular pages swapped to
> > > > it.
> > > >
> > > > Swap regions with SWAP_FLAG_NOSWAP set will not appear in /proc/meminfo
> > > > under SwapTotal and SwapFree, since they are not usable as general swap.
> > > >
> > >
> > > This patch doesn't appear to set SWAP_FLAG_NOSWAP anywhere.  Perhaps
> > > there's another patch somewhere which changes the hibernation code?  If
> > > so, can we please have both patches in a series?
> >
> > There's no other patch, in the kernel at least. SWAP_FLAG_* is exposed
> > to usermode, which would set it when calling swapon(2). Once this
> > patch is accepted, I'll have to add the option into util-linux [1], so
> > that I can use it in my init scripts.
> >
> > Said a different way, this patch isn't about altering how hibernate
> > behaves, but about giving usermode the freedom to set up hibernate and
> > swap independently.
>
> OK, can we please get this into the changelog?  And it would be helpful
> to describe how this will be invoked via swapon(8).

Sure, I can augment the commit text to include some of this, and what
it would likely look like from the commandline. I'll send a v3 for
that.

>
> And I expect an update to the swapon syscall's manpage will be in order.
>

Yes! I was originally planning to do that once this was accepted, but
can also spin it up in parallel if requested.
-Evan
