Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FA92410586
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 11:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbhIRJjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 05:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbhIRJjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 05:39:16 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD28DC061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:37:52 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 6so17569985oiy.8
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 02:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6h+x0dHkm1w/PqTQjkLPsLAB59NflCQjx0DuNDZvQsk=;
        b=f4ghaAsItLEUb1AS/a4OLXIqi8AseXSi0u7a0PR9no7+T2bQXPXaG4dkaJt9T8L9of
         cje6x0Fphulw+9yoKH+lgejR8PjQ9s1NNcgPaHRchV6obmcQV+RciD/rJljYraMlTc2r
         ZkG+869HX529E5drOaA0XT/QmtSuiE1Um86GIwhx3bsuhjHoXWkd4oqrLyVYihJ/lTLg
         p2KfU5cfgaXw3iPCK2TWnT3/DGHB1VFj6KTQHCKjwWszEHNJIUWjwvgJsmBSVEhirNst
         GBcrUZY9tOZwF6nBOwhuLLrRCM3BSxPEnZ2ENHYDHIRGJKLb9y+Z8Xc0W66jha8gqhKz
         fu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6h+x0dHkm1w/PqTQjkLPsLAB59NflCQjx0DuNDZvQsk=;
        b=JL88QrsdKGgVCT3Sol9PQolD8Bd/sIXExBU8SVzbItW+R02ZrIlFkqealG70V5XqLR
         bHWwG+0Hj7OdszdyKshLSew21ql0rfM51awnncjrbtL8w1OWsI3sCgMxIjMQlnBKX81/
         3KCFGz1j+qWE1pFnQAbG62wwA9bimUuwoID9z0AOMw5B5La2nATvBDnEBTiacYOP1iei
         kHoT3oX2Hb8tbq2CFkjjXegu9iVq5G48MftMa+tL5fH471J6hkqzNHUzjQjADY0QB0G1
         yPaaL7gUfXr+9xk7y8VcLGrcvdC337+sX4N7Nr6r5pbMBlsNsbDDSm9iC05lAmq4Md0J
         6fbA==
X-Gm-Message-State: AOAM531MlYrSpowXWn+U3ST/v7vsN18ch5W+yIYHIsHXLMX4zBIMMgX1
        MRFNUXg0CrIVE/CITkcVkzHHxY0NyS6JFwmiTSI8ng==
X-Google-Smtp-Source: ABdhPJxZBzBjnw1AL5dmoPJT18lyhiaEBxcnl/rOOKvNjxDsI2+wbaVg8uAfAIYlpqVdIXwanO3rA2LT0EV0xZGMz5A=
X-Received: by 2002:a05:6808:21a5:: with SMTP id be37mr6918034oib.172.1631957871829;
 Sat, 18 Sep 2021 02:37:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210421105132.3965998-1-elver@google.com> <20210421105132.3965998-3-elver@google.com>
 <6c0d5f40-5067-3a59-65fa-6977b6f70219@huawei.com> <abd74d5a-1236-4f0e-c123-a41e56e22391@huawei.com>
 <CANpmjNNXiuQbjMBP=5+uZRNAiduV7v067pPmAgsYzSPpR8Y2yg@mail.gmail.com> <da6629d3-2530-46b0-651b-904159a7a189@huawei.com>
In-Reply-To: <da6629d3-2530-46b0-651b-904159a7a189@huawei.com>
From:   Marco Elver <elver@google.com>
Date:   Sat, 18 Sep 2021 11:37:39 +0200
Message-ID: <CANpmjNPj5aMPu_7D=cwrDyAwz9i-rVcXYgGapYdB+vdHcR3RZg@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kfence: maximize allocation wait timeout duration
To:     Liu Shixin <liushixin2@huawei.com>
Cc:     Kefeng Wang <wangkefeng.wang@huawei.com>,
        akpm@linux-foundation.org, glider@google.com, dvyukov@google.com,
        jannh@google.com, mark.rutland@arm.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kasan-dev@googlegroups.com, hdanton@sina.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 18 Sept 2021 at 10:07, Liu Shixin <liushixin2@huawei.com> wrote:
>
> On 2021/9/16 16:49, Marco Elver wrote:
> > On Thu, 16 Sept 2021 at 03:20, Kefeng Wang <wangkefeng.wang@huawei.com> wrote:
> >> Hi Marco,
> >>
> >> We found kfence_test will fails  on ARM64 with this patch with/without
> >> CONFIG_DETECT_HUNG_TASK,
> >>
> >> Any thought ?
> > Please share log and instructions to reproduce if possible. Also, if
> > possible, please share bisection log that led you to this patch.
> >
> > I currently do not see how this patch would cause that, it only
> > increases the timeout duration.
> >
> > I know that under QEMU TCG mode, there are occasionally timeouts in
> > the test simply due to QEMU being extremely slow or other weirdness.
> >
> >
> Hi Marco,
>
> There are some of the results of the current test:
> 1. Using qemu-kvm on arm64 machine, all testcase can pass.
> 2. Using qemu-system-aarch64 on x86_64 machine, randomly some testcases fail.
> 3. Using qemu-system-aarch64 on x86_64, but removing the judgment of kfence_allocation_key in kfence_alloc(), all testcase can pass.
>
> I add some printing to the kernel and get very strange results.
> I add a new variable kfence_allocation_key_gate to track the
> state of kfence_allocation_key. As shown in the following code, theoretically,
> if kfence_allocation_key_gate is zero, then kfence_allocation_key must be
> enabled, so the value of variable error in kfence_alloc() should always be
> zero. In fact, all the passed testcases fit this point. But as shown in the
> following failed log, although kfence_allocation_key has been enabled, it's
> still check failed here.
>
> So I think static_key might be problematic in my qemu environment.
> The change of timeout is not a problem but caused us to observe this problem.
> I tried changing the wait_event to a loop. I set timeout to HZ and re-enable/disabled
> in each loop, then the failed testcase disappears.

Nice analysis, thanks! What I gather is that static_keys/jump_labels
are somehow broken in QEMU.

This does remind me that I found a bug in QEMU that might be relevant:
https://bugs.launchpad.net/qemu/+bug/1920934
Looks like it was never fixed. :-/

The failures I encountered caused the kernel to crash, but never saw
the kfence test to fail due to that (never managed to get that far).
Though the bug I saw was on x86 TCG mode, and I never tried arm64. If
you can, try to build a QEMU with ASan and see if you also get the
same use-after-free bug.

Unless we observe the problem on a real machine, I think for now we
can conclude with fairly high confidence that QEMU TCG still has
issues and cannot be fully trusted here (see bug above).

Thanks,
-- Marco
