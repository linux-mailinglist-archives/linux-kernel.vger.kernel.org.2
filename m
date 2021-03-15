Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2843733C57E
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Mar 2021 19:25:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231997AbhCOSY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Mar 2021 14:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbhCOSYG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Mar 2021 14:24:06 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F40C06174A;
        Mon, 15 Mar 2021 11:24:06 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id m7so15389420iow.7;
        Mon, 15 Mar 2021 11:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=2NfTgo/n4iFp2Ay18SODmBMI1NAFsimcTVTCJTYL8F4=;
        b=eGXMk4/Oo5giwVYy/oKwWnyTCAtBcuQLBZG7qDyNF0yEFz5p897qUmS/2xbu9UZw8j
         CwYhPAyw010jSshN2tIO6UHGEiv5vbhhieL17XtGE8jBvpymh2SCuqyH5b/N1bWuXP6O
         rYIlvucyMhR0wOQGQeb7XYgK6+m/5av3+7EXgwagkAVyvV+osBIpPtiSn4PFT5RYCsg/
         lEetIflo3jt2Y+zZ3C7w1+SY/A++YKyr+u1MRSsLp741lQoHkvE30gePiainiqAg1cTw
         WNlizd5MzH/42kX+jFPR3u4/84O2FsWNKQCPYVC3lF3Z90fmX1DbDvpmQUX0VyVJHfhh
         FnPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=2NfTgo/n4iFp2Ay18SODmBMI1NAFsimcTVTCJTYL8F4=;
        b=qUBRvw+yuacxc8joQ6oIbnRXF71kxut/zMD8FFqk0kBVkNMukJIremv5a6+xo0J4Qz
         jMReRwgqjNx4ztfiRVoIn+aAdLK7i+5ZbsC8N9KKp+c+ujclNmQGoNhofBuqwUHVB0Eu
         Nqlx0G3tXcYLW1D8rMKINGLUnI71u79+6LnTycGwhCvscHbHRNqzgrS6Pr7cgU8CTB9U
         chp3fyrHyER8Rib2W9VmH6grkt8AFxbsoGZNJGlW37VCQbnmXrHWU60VJn/S3znmGaOE
         MJ+WQcP6Vss1jmhOas4Yw4/iww7jG1+fyKY+oij5vzVsCuPHWy0DBW3e2+NQqwuzVFlL
         YA0Q==
X-Gm-Message-State: AOAM532kZAl5E4Ltrb0L33eO3AaBCJLuGr9uglHRWd7+DjfX+tWTdnR9
        ZVmdYdWzPaXxdGq7WXbCpgpSBCWa8GS3aO5SllHFW4d/u7LiEw==
X-Google-Smtp-Source: ABdhPJyZJrBlM2uLkgdbEd7K0EQK05CfpdASUwykn6wwuBxtVX5k7bpUjrw3SWBk5FocKV90hdr63aGE98nleJpKMy4=
X-Received: by 2002:a02:74a:: with SMTP id f71mr10560582jaf.30.1615832646083;
 Mon, 15 Mar 2021 11:24:06 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUWSCS6vAQOXoG6nsW+Dbnogivzf+rmegCTMjz5hjE5cKQ@mail.gmail.com>
 <20210313084923.GA16144@zn.tnic> <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic> <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
 <20210313124919.GD16144@zn.tnic> <CA+icZUWXuknBMdxTQXjJH2JiOgZbWcbk1U=dk6Zp2FgygU5Nyg@mail.gmail.com>
 <20210313132927.GF16144@zn.tnic> <CA+icZUWTSo2vkQO_tRggDFvvF_Q6AdzhvhQvmAsNxKnpGXHi0Q@mail.gmail.com>
 <CA+icZUXLyFqq0y_GnKca8MS4wO2kcj4K-D1kBHLa8u_pnLZ7eQ@mail.gmail.com> <YE+i/VWITCCb37tD@hirez.programming.kicks-ass.net>
In-Reply-To: <YE+i/VWITCCb37tD@hirez.programming.kicks-ass.net>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Mon, 15 Mar 2021 19:23:29 +0100
Message-ID: <CA+icZUWQ1kH6muAQbNuVAPj4Cn=8ssDAJfYLKht8ezAgJKWApA@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        rostedt@goodmis.org, hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 15, 2021 at 7:10 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Mar 15, 2021 at 06:04:41PM +0100, Sedat Dilek wrote:
>
> > make V=1 -j4 LLVM=1 LLVM_IAS=1
>
> So for giggles I checked, neither GCC nor LLVM seem to emit prefix NOPs
> when building with -march=sandybridge, they always use MOPL.
>
> Furthermore, the kernel explicitly sets: -falign-jumps=1
> -falign-loops=1, which, when not specified, default to 16 or so.
>
> This means that your userspace is *littered* with NOPL, even when you
> build your entire distro from source with -march=sandybridge.
> (arch/gentoo FTW I suppose).
>

That reminds me of the Git repo of the wireguard maintainer.

"x86: enable additional cpu optimizations for gcc v9.1+"

You mean something like that ^^?

- Sedat -

[1] https://git.zx2c4.com/laptop-kernel/commit/?id=116badbe0a18bc36ba90acb8b80cff41f9ab0686

> (The only good new is that recent LLVM has a pass to use alternative
> instruction encoding in order to grow a basic block in size in order to
> minimize the amount of NOP it needs to emit at the end in order to
> satisfy the jump/loop alignment.)
>
> So if you *really* deeply care about NOP performance on your SNB, start
> by teaching LLVM about prefix NOPs and rebuild your complete userspace.
> At that point, you can do some trivial patches to the kernel to make it
> use -march=sandybridge and prefix NOPs too.
>
> Until that time, the vast majority of NOPs your CPU will execute will be
> NOPL.
