Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD8C13F687C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 19:57:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239668AbhHXR6M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 13:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239633AbhHXR6C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 13:58:02 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3DB7C02B934
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:32:51 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c12so39021074ljr.5
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jmXJ+V7lZIXD6SyN6KE+2U5NQ7rogw+ZoqgEH0zDtHg=;
        b=MSmwOXkc+Kc3oeb1McdIefPnaSKK1tUjlY0nkZD7L/kbV2OR3rA5B4zvU62rrCFPTD
         imur3mL+r5KHuPzVbrBsO+//rzm6CwbgJK53azH5PJl+slbA8nwKICyykpOyQb1+8dCQ
         EqaMLkFB8MY1USjCUwTQvzsabgoyeTWFYfqg0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jmXJ+V7lZIXD6SyN6KE+2U5NQ7rogw+ZoqgEH0zDtHg=;
        b=KEJHLXgCEORcjsNDDFEk0bYW5GFLL3DYvIlW732sx3/dRrA56+e3YbNIU6grNwyoad
         oMIXREQ4TlbC717CjnQWDXUQILbzWnULcHW3QbCIw6lxUjZoR/zLRqBUFEVP1c29m+Qd
         mMDIVnvImOkf8wDbgHpLCPJGxu0apA6Q8UPTLRAQmoM2T9fQVJ9Y9lhwANgqwxuUAcMn
         YS/TO8tBmBzIVAL48gvpmIjTnMdNCMvcAWxBpHoHq8iKNNQMOhjgzlfQAePOc70cikCZ
         ysLlVNGn3WwRE57hNiIjCSSphkzklW6ScqhMqMlMg5MlbzZ8Ag+vqgcC29mrmfSOzj6h
         yElw==
X-Gm-Message-State: AOAM532O9Faf2M6XE6/SxSYglj6q3220GH14x97/6mFXjVT54MD0qgd3
        dAHFtMUMKCpOwo4rMlG+CJs9PjRwLqev3F4U
X-Google-Smtp-Source: ABdhPJzhq2Un7APdEa6LrTFrMrrWgP8dp+tSe7oo4boyc5+AZf3hCbu4ihaktf1iDSqCS7pB0x3awA==
X-Received: by 2002:a2e:9455:: with SMTP id o21mr33031569ljh.103.1629826370062;
        Tue, 24 Aug 2021 10:32:50 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id e19sm1847539ljj.28.2021.08.24.10.32.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:32:49 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id g13so47070457lfj.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 Aug 2021 10:32:48 -0700 (PDT)
X-Received: by 2002:a05:6512:2091:: with SMTP id t17mr29808872lfr.253.1629826368002;
 Tue, 24 Aug 2021 10:32:48 -0700 (PDT)
MIME-Version: 1.0
References: <20210824151337.GC27667@xsang-OptiPlex-9020> <CAHk-=wjEdeNW8bPNhwRCkMu6zLKjE2vQ=WL_6bQtc9YnaKt0bw@mail.gmail.com>
In-Reply-To: <CAHk-=wjEdeNW8bPNhwRCkMu6zLKjE2vQ=WL_6bQtc9YnaKt0bw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 24 Aug 2021 10:32:32 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKAg5QtrQOtvKNwkRUn0b2xufO54GPhUoTWxBgDzXWNA@mail.gmail.com>
Message-ID: <CAHk-=wiKAg5QtrQOtvKNwkRUn0b2xufO54GPhUoTWxBgDzXWNA@mail.gmail.com>
Subject: Re: [pipe] 3b844826b6: stress-ng.sigio.ops_per_sec -99.3% regression
To:     kernel test robot <oliver.sang@intel.com>,
        Colin Ian King <colin.king@canonical.com>
Cc:     Sandeep Patil <sspatil@android.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        kernel test robot <lkp@intel.com>,
        "Huang, Ying" <ying.huang@intel.com>,
        Feng Tang <feng.tang@intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Added Colin King, as this looks to be related to stress-sigio.c ]

On Tue, Aug 24, 2021 at 9:22 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Aug 24, 2021 at 7:56 AM kernel test robot <oliver.sang@intel.com> wrote:
> >
> > FYI, we noticed a -99.3% regression of stress-ng.sigio.ops_per_sec due to commit:
>
> Well, that's bad.
>
> > commit: 3b844826b6c6 ("pipe: avoid unnecessary EPOLLET wakeups under normal loads")
>
> You fix one benchmark, you break another..
>
> What's a bit odd is that this commit basically reverts commit
> 3a34b13a88ca ("pipe: make pipe writes always wake up readers") which
> did *not* result in any kernel test robot report.

Hmm. I have a possible clue.

I suspect this may be timing-related, and I wonder if the kernel test
robot just didn't happen to notice - or report - the other edge of
this performance regression because it ends up being random enough.

In particular, I think stress-sigio.c is subtly buggy, and the "send
SIGIO on every write" may have effectively hidden the bug.

Here's my theory on what's going on, and why it has tghat odd -99.3% regression:

 - the child in stress-sigio.c does multiple writes in quick
succession, while the parent is scheduled away

 - the pipe was empty at the beginning, but we send just *one* SIGIO
for all these writes

 - the parent gets the SIGIO, and goes to stress_sigio_handler(), and
reads the buffer

but the parent doesn't necessarily *empty* the buffer, so it won't get
any more SIGIO signals from subsequent writes.

The reason this is timing-dependent and about luck is because the
*read* size is BUFFER_SIZE (4kB), but the write sizes are BUFFER_SIZE
>> 4 (256 bytes), so 99% of the time if the parent is at all timely,
it will do that big read and empty the buffer.

But if the child ends up able to do more than 16 writes in a row
before the parent wakes up and reads data, the buffer will have more
than 4kB of data in it, and when the parent SIGIO handler happens it
won't empty the data, and so it will never see another SIGIO.

And again - I think this all happened before too (ie before commit
3a34b13a88ca) and so 3b844826b6c6 ("pipe: avoid unnecessary EPOLLET
wakeups under normal loads") isn't a _new_ regression, it just exposed
the bug in the test-case again, and this time the kernel test robot
caught it.

In other words, I think this is very similar to the EPOLLET problem:
user space expected (perhaps not _intentionally_) that SIGIO would
happen over and over again when you add new data, even if the pipe
already had data.

So then commit 1b6b26ae7053 ("pipe: fix and clarify pipe write wakeup
logic") came around back in 2019, and only sent SIGIO when the pipe
buffer status _changed_ (ie went from empty to having data, rather
than "there's new data") and at that point stress-sigio.c became very
fragile.

We could do the same ugly thing for FASYNC that we do for EPOLLET -
make it always fasync on new data, exactly because the previous SIGIO
might not have emptied the buffer completely.

I'm a _bit_ surprised that the kernel test robot didn't catch this
back in 2019, and also didn't report this when commit 3a34b13a88ca
("pipe: make pipe writes always wake up readers") should have sped
things up again, but I guess the "it's very timing-dependent" might
explain it.

Colin, comments?

Anyway, the above blathering is not based on any actual real data. I'm
just looking at stress-sigio.c to see what could be going wrong, and
what would explain the test robot report. It's the only thing I see,
but maybe somebody else sees anything else..

                      Linus
