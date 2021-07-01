Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD573B9713
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jul 2021 22:15:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbhGAUSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jul 2021 16:18:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbhGAUR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jul 2021 16:17:59 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF23EC061762
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jul 2021 13:15:27 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id t17so14103546lfq.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 13:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2iNcNOPlfT+qWPK+b3Uy11X2JBFYAgrqY9VVeV4ulS8=;
        b=H8D4sU0qi8I8AexpK1PssC7DU2czpDwmWVt+gaksX9V0+4qrhKVDeAU4WC8yrVExYC
         M4yjFLQXLHVEUWOJxmw4kTbvDus+9qR26Lidx/Zsz9UWn9KtkLtY1eQ68x/nntopJt5V
         MkXIhnFBYxdh8Ujqznp+zti9Rs1/SumlGyZC4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2iNcNOPlfT+qWPK+b3Uy11X2JBFYAgrqY9VVeV4ulS8=;
        b=RLRwu1xzLMGP3AINAWp4y+EYE6dAtTy8GsKNKaKRWRwSt8p177JNjXFQMrq4+s/Bdp
         uNirh0q4BkhlmUWE5MdMqVjsYx1rawnO6F6WOZ1olCbvi+kHsK8Ie66qoQ+GB834pJNq
         pzufba1DDguM4YfEMziD98GxNiL5C3VLlzfvC64KWlUWSpJQFxPtl99xjcUAGvpvd2Zq
         JXtOZErF0wFZYfrcaZiQ3iy35Usd0hWSdSCRv0gOTwozk03CDy4VYOWho0oyV0Y1nnSV
         gDvXxT/VRgc7zcGQU22Rje/AnjMRAH0nF0hxN/TKQKJwCYFLD/aBPWCRNL3ldEGV9dWR
         CNdw==
X-Gm-Message-State: AOAM533OZLaW+jc4nBUfSWKuYrxWiVbbtp+EESjz1xtBNqXpkHjbHbRL
        4QME8V8aLwUdWwBtkKpqJyNZHJkKmvK1fseOJVc=
X-Google-Smtp-Source: ABdhPJy/mBsp9CSgKVk7RwmPZ75DVCY0gpvkm61Th7q/HeRy2l6eL8l1Pm+5aPIriaAiHHAtcnSocA==
X-Received: by 2002:ac2:4906:: with SMTP id n6mr1077689lfi.592.1625170525486;
        Thu, 01 Jul 2021 13:15:25 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id n17sm63704lft.74.2021.07.01.13.15.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jul 2021 13:15:24 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id p24so10219914ljj.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jul 2021 13:15:23 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr965880ljp.251.1625170523672;
 Thu, 01 Jul 2021 13:15:23 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzR4BqTtamrTy4T_XV7E0fUNyduaVtH5zAi=sqwX_3udg@mail.gmail.com>
In-Reply-To: <CAPM=9tzR4BqTtamrTy4T_XV7E0fUNyduaVtH5zAi=sqwX_3udg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 1 Jul 2021 13:15:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=whgcN6MEyZBgK3UZRw=vwd1CAAK9+rafmZ2vsOiGpsMSA@mail.gmail.com>
Message-ID: <CAHk-=whgcN6MEyZBgK3UZRw=vwd1CAAK9+rafmZ2vsOiGpsMSA@mail.gmail.com>
Subject: Re: [git pull] drm for 5.14-rc1
To:     Dave Airlie <airlied@gmail.com>, Philip Yang <Philip.Yang@amd.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2021 at 9:34 PM Dave Airlie <airlied@gmail.com> wrote:
>
> Hi Linus,
>
> This is the main drm pull request for 5.14-rc1.
>
> I've done a test pull into your current tree, and hit two conflicts
> (one in vc4, one in amdgpu), both seem pretty trivial, the amdgpu one
> is recent and sfr sent out a resolution for it today.

Well, the resolutions may be trivial, but the conflict made me look at
the code, and it's buggy.

Commit 04d8d73dbcbe ("drm/amdgpu: add common HMM get pages function")
is broken. It made the code do

        mmap_read_lock(mm);
        vma = find_vma(mm, start);
        mmap_read_unlock(mm);

and then it *uses* that "vma" after it has dropped the lock.

That's a big no-no - once you've dropped the lock, the vma contents
simply aren't reliable any more. That mapping could now be unmapped
and removed at any time.

Now, the conflict actually made one of the uses go away (switching to
vma_lookup() means that the subsequent code no longer needs to look at
"vm_start" to verify we're actually _inside_ the vma), but it still
checks for vma->vm_file afterwards.

So those locking changes in commit 04d8d73dbcbe are completely bogus.

I tried to fix up that bug while handling the conflict, but who knows
what else similar is going on elsewhere.

So I would ask people to

 (a) verify that I didn't make things worse as I fixed things up (note
how I had to change the last argument to amdgpu_hmm_range_get_pages()
from false to true etc).

 (b) go and look at their vma lookup code: you can't just look up a
vma under the lock, and then drop the lock, and then think things stay
stable.

In particular for that (b) case: it is *NOT* enough to look up
vma->vm_file inside the lock and cache that. No - if the test is about
"no backing file before looking up pages", then you have to *keep*
holding the lock until after you've actually looked up the pages!

Because otherwise any test for "vma->vm_file" is entirely pointless,
for the same reason it's buggy to even look at it after dropping the
lock: because once you've dropped the lock, the thing you just tested
for might not be true any more.

So no, it's not valid to do

    bool has_file = vma && vma->vm_file;

and then drop the lock, because you don't use 'vma' any more as a
pointer, and then use 'has_file' outside the lock. Because after
you've dropped the lock, 'has_file' is now meaningless.

So it's not just about "you can't look at vma->vm_file after dropping
the lock". It's more fundamental than that. Any *decision* you make
based on the vma is entirely pointless and moot after the lock is
dropped!

Did I fix it up correctly? Who knows. The code makes more sense to me
now and seems valid. But I really *really* want to stress how locking
is important.

You also can't just unlock in the middle of an operation - even if you
then take the lock *again* later (as amdgpu_hmm_range_get_pages() then
did), the fact that you unlocked in the middle means that all the
earlier tests you did are simply no longer valid when you re-take the
lock.

                 Linus
