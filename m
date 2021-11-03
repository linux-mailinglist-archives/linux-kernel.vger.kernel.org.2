Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FA34445D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Nov 2021 17:23:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhKCQ0J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 12:26:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231876AbhKCQZ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 12:25:56 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F95DC061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 09:23:19 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id d12so2733459lfv.6
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 09:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cacIkAFs+72Yhz0c8MHvVrEE2bJVJOQ7A5GEEKjRHzE=;
        b=JWCw98yoanqwDlL1uh0r5J0vyhG3dKr9z3OzkhdwhpsePnB67z7eMRNdBfRtxuQEek
         bvlvwzlk25fR30S5NwUTMhz0Ofzex4aSIiRCgOzj/fy4DLQU4w/PE87iQUqhRWcxrhND
         0CtZu32Xb0O1uHKkbmwPKlnwobyhw1KDDa7oo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cacIkAFs+72Yhz0c8MHvVrEE2bJVJOQ7A5GEEKjRHzE=;
        b=GXwfMM5ql3vlbtxtUPI+D9mrVz5Z/xvUriJeOLeusO5ooW9SC2gVtvW09tG0uVZWVg
         2/X5Bo8ZIm80tgKm94NGY7AuEdXFe/9t79Wz9Cspos4JAbf4jbPYjqTZ0clTIfs5VPne
         OAVubczEvy05bYiYrrfqyeUNfqRNNbPtvUgDRSkHfM9hoCMbFheg2x72lYxhBXnSFv/S
         DRo/4UggOqtrKfW5wDuzRf+d56+LToLKE73zK1lwJ7pdHgCRKmNeXHTO3D8Gq1Ow6AY3
         l+jXQS/ajckvl2YSGrvHm482++8KhFdIXZjgz2QJaB8IXxy76+snpfigN0Ia3yGVcAaJ
         MP6w==
X-Gm-Message-State: AOAM532fwPlN55jDXnI2FVEJ9nRveIRhAMEzUFu+X7qOCTCSubxdldhF
        hSLdPNzPp9c68EbkneqLnyNpJQt9J0X/sZcV
X-Google-Smtp-Source: ABdhPJyc4EZGENYV3tZYnDinO6dHP/QIb+4vqTX3RzoZ7UHhSyPolK0Aaxqxxynj637NVsYDrsI8Lw==
X-Received: by 2002:ac2:430d:: with SMTP id l13mr40449353lfh.656.1635956597331;
        Wed, 03 Nov 2021 09:23:17 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id u13sm240451ljg.121.2021.11.03.09.23.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 09:23:16 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id bq11so6238661lfb.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 09:23:16 -0700 (PDT)
X-Received: by 2002:ac2:4e15:: with SMTP id e21mr43505927lfr.655.1635956596237;
 Wed, 03 Nov 2021 09:23:16 -0700 (PDT)
MIME-Version: 1.0
References: <163572864256.3357115.931779940195622047.tglx@xen13>
 <163572864855.3357115.17938524897008353101.tglx@xen13> <CAHk-=whEbr+0ZSRMkQ1wqLCeBEiK7o2-Hm=55aTBpdeVxnFbVQ@mail.gmail.com>
 <CAHk-=whwxyA11LQ+0y73nJAS4ZB=s8CeYM6OGCEzKiy+8fyLiw@mail.gmail.com> <YYD5ti23DQUjdQdz@hirez.programming.kicks-ass.net>
In-Reply-To: <YYD5ti23DQUjdQdz@hirez.programming.kicks-ass.net>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 3 Nov 2021 09:23:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiB_utWx68aCGQKRC7aYMFSL+7Dr7hz_7yp4f3xM_EGbA@mail.gmail.com>
Message-ID: <CAHk-=wiB_utWx68aCGQKRC7aYMFSL+7Dr7hz_7yp4f3xM_EGbA@mail.gmail.com>
Subject: Re: [GIT pull] sched/core for v5.16-rc1
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 2, 2021 at 1:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> > It could be a user process doing bad things to the user stack frame
> > from another thread when profiling is enabled.
>
> Most of the unwinders seem to only care about the kernel stack. Not the
> user stack.

Note that it very much happens for a kernel stack too.

There the reason isn't some active attack, but simply stack
corruption, or - not uncommonly - missing or incomplete debug notes
that the unwinder crazily depends on.

If an unwinder isn't robust enough to deal with stack corruption, it
damn well should be deleted immediately - it will only cause even
*more* problems when some nasty bug happens, and suddenly the unwinder
means that you don';t get a proper oops report.

And yes, I feel strongly about this, because we very much used to have
that situation on x86 too a long time ago. I spent a year fighting
buggy unwinders, and then removed the unbelievable garbage in the end
because the maintainer of said thing refused to admit that there was a
problem.

So I really think that the solution to "unwinder is not robust" is
absolutely not to take more locks. Because that's literally just
hiding the much bigger and serious problem.

The fact that the lock in question is a fairly critical one (and needs
to use "raw_spin_lock()" and friends) is just another argument against
it.

I've obviously pulled this on Monday already, and I'm not going to
start reverting those commits unless they cause problems, but I do
think they were seriously misguided.

                  Linus
