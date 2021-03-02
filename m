Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 843D732AD7F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 03:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1837788AbhCBV6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Mar 2021 16:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1581633AbhCBTBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Mar 2021 14:01:15 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E04C061356
        for <linux-kernel@vger.kernel.org>; Tue,  2 Mar 2021 10:56:49 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id q14so25346387ljp.4
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:56:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jPemdFCvcOw+M7rO60HZ8OEoGnA5eVH5NVd0v+mKulU=;
        b=YyCfRc7bqIIPy2pLts3gZ1AaH7tiza3GiTHxYs9f+v7VuDwSeWXWF0YlC6p9Rf0qDh
         9vUlz3m+dioWFfHbeNrOBT9vGHtggYOqXVZF8Tiu1IBGhTDUH7XnW4AZ6KaKEvQWbg7C
         ydGAufrimWtv1w0FUqZs/jsQcMO+ezP7fyRnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jPemdFCvcOw+M7rO60HZ8OEoGnA5eVH5NVd0v+mKulU=;
        b=KjA90LJJvF/rj3uTH1UgiTzjw39g2lpoOQatvdPx/upS2Rf+TB4RnySm3kiaALNUV6
         qgj3anRKrcJ+HxfInCCdb5Oydgrq19TsWgZSYiZrMjR8d/8Po8DvIXrOVPEdebV3VQ0A
         11ZQcnfh9eihDHYXmZ+XdrzW5HYW+LUJGznr2XKk4yMMxQmP9ix+zcwx0x2qdluJTmqa
         ZpSovsrfgubG2ZTb7+ZO5ZGoWB7yW+lPuDMn7PF9OYqhdgXFGB4a92R6PBKlFyoqOVSI
         f2lKSjd4cX+RWmBIx9W8yykJZm4JzRpOsIkX1KCwrABiJRgRSkKDIsw00NJkAMQFnjkA
         49SA==
X-Gm-Message-State: AOAM531GZAQec3zvhFn3ZruFnppuL5wpdkYRkiHi3P+InLnjzOJrwyCl
        rcdc3ZFph7ZXcUMXhVE8B8xqo7rvWLgHqg==
X-Google-Smtp-Source: ABdhPJyzQixE69JRmzIPXn811+y+KeQWSqdVAc90O8fc27t+8VIFjozJvaE0upJkoIVXzgWOX/TNXg==
X-Received: by 2002:a2e:700a:: with SMTP id l10mr12967208ljc.368.1614711407320;
        Tue, 02 Mar 2021 10:56:47 -0800 (PST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id k5sm2955738ljh.130.2021.03.02.10.56.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Mar 2021 10:56:46 -0800 (PST)
Received: by mail-lf1-f48.google.com with SMTP id f1so32983412lfu.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Mar 2021 10:56:46 -0800 (PST)
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr8117958lfo.201.1614711405966;
 Tue, 02 Mar 2021 10:56:45 -0800 (PST)
MIME-Version: 1.0
References: <CALCv0x1NauG_13DmmzwYaRDaq3qjmvEdyi7=XzF04KR06Q=WHA@mail.gmail.com>
 <m1wnuqhaew.fsf@fess.ebiederm.org> <CALCv0x1Wka10b-mgb1wRHW-W-qRaZOKvJ_-ptq85Hj849PFPSw@mail.gmail.com>
In-Reply-To: <CALCv0x1Wka10b-mgb1wRHW-W-qRaZOKvJ_-ptq85Hj849PFPSw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Mar 2021 10:56:30 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjVWMnH2LfFNnXcf6=WuU1RyLa_cgTEOqnViHiqDrqQjg@mail.gmail.com>
Message-ID: <CAHk-=wjVWMnH2LfFNnXcf6=WuU1RyLa_cgTEOqnViHiqDrqQjg@mail.gmail.com>
Subject: Re: exec error: BUG: Bad rss-counter
To:     Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 1, 2021 at 11:59 PM Ilya Lipnitskiy
<ilya.lipnitskiy@gmail.com> wrote:
>
> Good to know. Some more digging and I can say that we hit this error
> when trying to unmap PFN 0 (is_zero_pfn(pfn) returns TRUE,
> vm_normal_page returns NULL, zap_pte_range does not decrement
> MM_ANONPAGES RSS counter). Is my understanding correct that PFN 0 is
> usable, but special? Or am I totally off the mark here?

PFN 0 should be usable - depending on architecture, of course - and
shouldn't even be special in any way.

is_zero_pfn(pfn) is *not* meant to test for pfn being 0 - it's meant
to test for the pfn pointing to the special zero-filled page. The two
_could_ be the same thing, of course, but generally are not (h8300
seems to say "we use pfn 0 as the zero page" if I read things right).

In fact, there can be many zero-filled pages - architectures with
virtually mapped caches that want cache coloring have multiple
contiguous zero-filled pages and then map in the right one based on
virtual address. I'm not sure why it would matter (the zero-page is
always mapped read-only, so any physical aliases should be a
non-issue), but whatever..

> Here is the (optimized) stack trace when the counter does not get decremented:
> [<8015b078>] vm_normal_page+0x114/0x1a8

Yes, if "is_zero_pfn()" returns true, then it won't be considered a
normal page, and is not refcounted.

But that should only trigger for pfn == zero_pfn, and zero_pfn should
be initialized to

    zero_pfn = page_to_pfn(ZERO_PAGE(0));

so it _sounds_ like you possibly have something odd going on with ZERO_PAGE.

Yes, one architecture does actually make pfn 0 _be_ the zero page, but
you said MIPS, and that does do the page coloring games, and has

   #define ZERO_PAGE(vaddr) \
        (virt_to_page((void *)(empty_zero_page + (((unsigned
long)(vaddr)) & zero_page_mask))))

where zero_page_mask is the page colorign mask, and empty_zero_page is
allocated in setup_zero_pages() fairly early in mem_init() (again, it
allocates multiple pages depending on the page ordering - see that
horrible virtual cache thing with cpu_has_vce).

So PFN 0 shouldn't be an issue at all.

Of course, since you said this was an embedded MIPS platform, maybe
it's one of the broken ones with virtual caches and cpu_has_vce is
set. I'm not sure how much testing that has gotten lately. MOST of the
later MIPS architectures walked away from the pure virtual cache
setups.

              Linus
