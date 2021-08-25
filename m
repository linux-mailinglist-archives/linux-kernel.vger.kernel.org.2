Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4A8D3F7B83
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 19:25:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242320AbhHYR0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 13:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233612AbhHYR0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 13:26:14 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 653FBC061757
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:25:28 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id j4so475758lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MNIM3WW8Ze0x+S3sN3sIiBTuhvgRcNb/CPfWfCAvio0=;
        b=GmKeqIU2Gudp2kzLna3RtlddFJNw1mWlpvF91VBf+XJ07q1njknT5faN+RJUZN1dgX
         XnC/W25NfdVpfGc1TNVWNK6vz9gdO6XkyZh8GfdejwMBLBn4wEh7G25lzX50HyIl2bzx
         40QBc9QshjOo80HOfie6UE8OyWhZyv5UGWLJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MNIM3WW8Ze0x+S3sN3sIiBTuhvgRcNb/CPfWfCAvio0=;
        b=V019Dlcs6RoArTAtRJMUrpiqw4nn7oPB6JyLdtNTn9m2umKb3nxu9vUhCPAQ0Wf9Re
         tvjyI7UtHEAabdN7yIFFnkZFABx72y3ZTQIE1BEqDi6UfZyIEpqP+QeSX1nEmIPIXLOt
         jeW1EMMt6mG5SRUQUoa73PBe5x5vNRHaQkrobgXhGq49VG8pqnzREXAu4OiCSvsDZtmb
         q8dH8DeLgM0DWeYFuZ8By7ym3ist+q7esat7cIxkHOBcM1Kfqq57gAq9bhMM1BXiLHHE
         DjzenLNnRh4+jCVZkkPkBu8OsUuPbQ+uvjMGv75hWWaNk0sniiH6DmQQhIv7WUUQdoPM
         Cfwg==
X-Gm-Message-State: AOAM530UpFPr3jWw5K0XG+O7WpUB5ZNWaB+jG/X2XYJJDg/44eXEYu2M
        2Q+og7SrU5H3S53E4zk5hXzoYEo/wMh6/ozp
X-Google-Smtp-Source: ABdhPJwjI68/93XSVt7Dlc75Zqn80fOvjJbeyQaCI1/IAgt40F4OT8ikDI5/h7YBZLsPof9x31jmrg==
X-Received: by 2002:ac2:4c56:: with SMTP id o22mr9971118lfk.240.1629912326560;
        Wed, 25 Aug 2021 10:25:26 -0700 (PDT)
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com. [209.85.208.173])
        by smtp.gmail.com with ESMTPSA id d24sm66711lfs.80.2021.08.25.10.25.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Aug 2021 10:25:25 -0700 (PDT)
Received: by mail-lj1-f173.google.com with SMTP id m4so10107601ljq.8
        for <linux-kernel@vger.kernel.org>; Wed, 25 Aug 2021 10:25:25 -0700 (PDT)
X-Received: by 2002:a05:651c:908:: with SMTP id e8mr8505608ljq.507.1629912324881;
 Wed, 25 Aug 2021 10:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210824151337.GC27667@xsang-OptiPlex-9020> <CAHk-=wjEdeNW8bPNhwRCkMu6zLKjE2vQ=WL_6bQtc9YnaKt0bw@mail.gmail.com>
 <CAHk-=wiKAg5QtrQOtvKNwkRUn0b2xufO54GPhUoTWxBgDzXWNA@mail.gmail.com>
 <CAHk-=wgrSmiwUfSGt1RPy5KJ_TLBTP5DB0-vT=PCxQY4C7uANA@mail.gmail.com> <875yvtpqbc.fsf@disp2133>
In-Reply-To: <875yvtpqbc.fsf@disp2133>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 25 Aug 2021 10:25:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0yqX8ChE=6aBivtgm65CGb3vf6meQbZxDczn9BznqTA@mail.gmail.com>
Message-ID: <CAHk-=wi0yqX8ChE=6aBivtgm65CGb3vf6meQbZxDczn9BznqTA@mail.gmail.com>
Subject: Re: [pipe] 3b844826b6: stress-ng.sigio.ops_per_sec -99.3% regression
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     kernel test robot <oliver.sang@intel.com>,
        Colin Ian King <colin.king@canonical.com>,
        Sandeep Patil <sspatil@android.com>,
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

On Wed, Aug 25, 2021 at 7:11 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> We have two things going on, a pipe wake up and signal wake up.
>
> Does their order matter?  It feels weird that it is possible that
> the data can be read from the pipe and the reader woken up to write
> more when the signal that notifies the reader of that state has
> not even been queued for delivery.

I don't think the order matters.

The only thing that matters is that the signal (and the regular
wakeup, for that matter) is donme *after* the operation that triggers
them is complete. It would be problematic if we sent the signal for
"you can read more now" before we had actually done the write, so that
the recipient would then try to read and get a "nothing there".

But if you have both a pending reader, and something that asked for
SIGIO, they'll both get notified. Not in any particular orfder between
those two, but both will be notified after the write (or read) that
triggered it has been done.

Of course, the pending reader/writer that gets notified might be the
_same_ one that also gets the SIGIO, so you could then have the SIGIO
mean that the reader/writer gets EINTR and needs to read/write again.
If you asked for both, you'll get it.

The way our pipe code is organized, the _likely_ case is that you'll
do the read/write and take the signal handler without ever getting
-EAGAIN.  Because we'll test for "do we have more data" before we test
for "do we have signals pending" - but that's not really relevant for
correctness (it's more a greedy "let's try to read while possible" and
could be good for avoiding extra system calls).

And I think it was actually a historical mistake to tie the "send
SIGIO" together so tightly with "wake up other side". So my untested
patch (well, it's now tested by Oliver) is likely the right thing to
do regardless.

Basically, the "wake up readers/writers" thing is the one where we
*know* the other side - it's just the other end, and it's the kernel
code in the same fs/pipe.c file. So we can - and should - optimize
against doing unnecessary wakeups.

But as has now been shown several times, we shouldn't optimize the
case where the wakups are sent to code we don't control - ie user
space. Whether that be as a result of epoll, or as a signal delivery,
that "other side" is not under our control and clearly doesn't want
the optimal minimal wakeups for just state transition cases.

Of course, I could always wish that the receiving side always did the
right thing, and worked with the minimal state transition data, but
that clearly simply isn't the case. It wasn't the case for EPOLLET,
and it wasn't the case for SIGIO.

"If wishes were horses ..."

So I'll commit that SIGIO fix, even if Colin has already changed
stress-ng. No real harm in just doing both belt and suspenders, and I
was wrong last time when I thought the EPOLLET thing was purely a
test-suite issue.

Let nobody say that I can't learn from my mistakes..

                 Linus
