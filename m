Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DAB9372E9D
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232053AbhEDRSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 13:18:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232043AbhEDRSj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 13:18:39 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27BFC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 10:17:44 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id u20so9298702qku.10
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 10:17:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4RwyehG38JsKD/EL1cHF9aUCKECHFf4iXyx7IfSeRco=;
        b=lV9pNu1ALFgRJuH/a8BPUcC7sm4Cr3vz7ftGYoqy4deMX7Y/v2pj4Dp4Lvsbg8aFlP
         sj/JAdjnrJ31J3yfRabtpEb1MLTmH6Aq16boUMdmZZByMy+13P3eQcUo8rUdK7ELXj25
         x9vmtxFSyoLE48wzUosIZpewe1kZJ+C20WwdD1wU6NzsId5rI1RFYIvkY1klKbiAicbC
         LrAdqAvJ0ybDqvPIxytGPyZqTI3yf+qXVjPNDAQOQcarZZOVriVWpi85U20k00g/z6eR
         +7QzKffzEExlgvNdjZlU1Bym0YWn6Cum833brbZi0EKren2GD3knxzJRyw25gvhOV9NV
         /zWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4RwyehG38JsKD/EL1cHF9aUCKECHFf4iXyx7IfSeRco=;
        b=XUP3xLmJwIirm2Ao11W4XFOFLuATRne6yZqvQ5Hz+zXdJx3RRBgiA31aTHbniTllJ+
         jgkcVxVx0cA6EnGd+LyJSnhwPrHz0YEjmF4PcRIqg6UsTsc6Ufg0TtubcQxlH5W5vAfo
         wQoLq7fmaPhf6t8+Ob2wzyiNcyj1eGXjo+POfOIwBuEc3ddNr8TqSwfdrogSFi1BNTWn
         c98B4kAqgbNuuYsDOPoxTrhtNau0HtfV0XCYOYJdJ1f/MlFccoV9+l0mCo+0+xKD+bYJ
         buk+roO88i3TE30VVSQv9rncuD9Iia/iuDelFvhPzPyyS6xnsWNqmozuiWeYS8KvEXK+
         EXgA==
X-Gm-Message-State: AOAM532eEUfjKb+FXxTgwKexYJoLlfZ/htbHxPvBlTNFgdfZ9HaaH/kf
        ZYcBxaB1LZ+tzrBrV+YGtzgmUjHgw+qaLp1Bc9/okw==
X-Google-Smtp-Source: ABdhPJz8WHrf5I6qtxHqMtb+rsFYczLKHuarGrf0WWbVAf58rsMGc3lhssIq/U/iXRflcV2jBag+UTMrVjW579yyBxs=
X-Received: by 2002:a05:620a:89d:: with SMTP id b29mr27216870qka.231.1620148663606;
 Tue, 04 May 2021 10:17:43 -0700 (PDT)
MIME-Version: 1.0
References: <20210504024358.894950-1-ak@linux.intel.com> <CACT4Y+a5g5JeLJFPJEUxPFbMLXGkYEAJkK3MBctnn7UA-iTkXA@mail.gmail.com>
 <77634a8e-74ab-4e95-530e-c2c46db8baa7@linux.intel.com>
In-Reply-To: <77634a8e-74ab-4e95-530e-c2c46db8baa7@linux.intel.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 4 May 2021 19:17:31 +0200
Message-ID: <CACT4Y+a1mjOfiud=WBVaP-96rovKQmW9_AaV+y=NFAKQJy_Kwg@mail.gmail.com>
Subject: Re: [PATCH] stackdepot: Use a raw spinlock in stack depot
To:     Andi Kleen <ak@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 4, 2021 at 5:34 PM Andi Kleen <ak@linux.intel.com> wrote:
> > So why is this a false positive that we just need to silence?
> > I see LOCKDEP is saying we are doing something wrong, and your
> > description just describes how we are doing something wrong :)
> > If this is a special false positive case, it would be good to have a
> > comment on DEFINE_RAW_SPINLOCK explaining why we are using it.
> >
> > I wonder why we never saw this on syzbot. Is it an RT kernel or some
> > other special config?
>
> This happened in a special configuration that triggered ACPI errors at
> boot time.
>
> It's probably not something that is normally executed, as well as syzbot is
>
> probably not exercising bootup anyways.
>
> > A similar issue was discussed recently for RT kernel:
> > https://groups.google.com/g/kasan-dev/c/MyHh8ov-ciU/m/nahiuqFLAQAJ
> > And I think it may be fixable in the same way -- make stackdepot not
> > allocate in contexts where it's not OK to allocate.
>
>
> Yes that's a good idea. I've seen also other errors about the allocator
> triggered
>
> by stack depot being in the wrong context. Probably doing that would be
> the right
>
> fix. But I actually tried to switch depot to GFP_ATOMIC allocations
> (from GFP_NOWAIT),
>
> but it didn't help, so I'm not fully sure what needs to be changed.

We may not allocate at all, see may_prealloc idea here:
https://groups.google.com/g/kasan-dev/c/MyHh8ov-ciU/m/k1LXBmonAQAJ
