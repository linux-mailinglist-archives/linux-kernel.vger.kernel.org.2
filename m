Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F40D34E782
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 14:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231931AbhC3McU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 08:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbhC3Mb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 08:31:58 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9090C061574;
        Tue, 30 Mar 2021 05:31:57 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id n21so16223010ioa.7;
        Tue, 30 Mar 2021 05:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=z9mOZw8SqKLWog9ie4BJd3vxX52rVUoc2ACdWLVcbOs=;
        b=PegYgqpOFIr0VRpiNtmNwryckYfps61W6ZvFqZhXsfyJGDOUqH3Im0RQ68Jd8/YO9V
         5dajLVD4xQFjbB/kvKt96eyKH8PQNQsY1RBwvrnu4kQJEnHQNWJqQq46N3IpMPNyAas4
         5fWT/Gg5gJbmLw/0FDuzwQBKOMj4CXQ1QEyewXJ1n6i3zKa8KpXBxgYRBkOSROJcv6Rz
         NDm2IUTaJ3FQL8j5mmTPrFTBvwKGJJuw/S7vGr9bt1IwPuQbbosWqNhW/ECHZGAPGKvU
         frCsQvxbA4OOrWq9qAj5ZmdmFjFF4/9Sa4xScmN6df0KHzdCQYiwWHoMXYDPrYa67pNl
         gidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=z9mOZw8SqKLWog9ie4BJd3vxX52rVUoc2ACdWLVcbOs=;
        b=bXRW3HRmIZTEySn6yq2/bpfNWG/k+YYnM8S8SidC77wwuKDloDfz07/0H6zFgbwaqi
         pbi6/HyDlNjlK/wkbz+Yc2LEfuMoYHutavw7MPEBonsXi/gfznzAx65uqI2MZ1HhPBpv
         +MJ8CEkSzTeQ63LlzlGUT6VjvOdD8G/HQlrB47N0hgk2GS6MeBlGMorgFoA58yG9jLLq
         BWUsxwqXPT79/o2hgtypOccLRXP6w9fmt29ibS0+jDMkgnfEjGHa0lpY5+aHLweFCVIW
         NVXJYQsJjLyDOKuN6hsAT3fWFCxYPNha8MmdBJys/LzQ//0CldQU381daiZHzK2Uci4O
         i+ew==
X-Gm-Message-State: AOAM532E9M0HyUs3OzdJ2VmnzqoatHf6lVgYsr2DV2zJc12eZz9yplwk
        Mh1MeZv/5hwsZ7DSp32q1ytJli76EXNwB25l+Vc=
X-Google-Smtp-Source: ABdhPJyzAfqN9KH4XcP/n9EV4Pjo8x8XR3C28vjbEre/kQc1sEOTsXEZkaQQTTzxSwdlsGD8PPxr/5E3wjB4TAri36A=
X-Received: by 2002:a05:6638:35ab:: with SMTP id v43mr28883010jal.65.1617107517291;
 Tue, 30 Mar 2021 05:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUVEkA6+5d3NGy7_G8eiaPvJkO_JCAX=XQwT1qpiGkLMWw@mail.gmail.com>
 <20210313121541.GC16144@zn.tnic> <CA+icZUXrJHHDNOC+DAcr9iw4MXn5cBDj-JrDkxeumk978Gtdcg@mail.gmail.com>
 <20210313124919.GD16144@zn.tnic> <CA+icZUWXuknBMdxTQXjJH2JiOgZbWcbk1U=dk6Zp2FgygU5Nyg@mail.gmail.com>
 <20210313132927.GF16144@zn.tnic> <CA+icZUWTSo2vkQO_tRggDFvvF_Q6AdzhvhQvmAsNxKnpGXHi0Q@mail.gmail.com>
 <CA+icZUXLyFqq0y_GnKca8MS4wO2kcj4K-D1kBHLa8u_pnLZ7eQ@mail.gmail.com>
 <YE+i/VWITCCb37tD@hirez.programming.kicks-ass.net> <CA+icZUWQ1kH6muAQbNuVAPj4Cn=8ssDAJfYLKht8ezAgJKWApA@mail.gmail.com>
 <YE/cMeO+oC/5JEC6@hirez.programming.kicks-ass.net> <CA+icZUXko_Nxh-9_qgjMYyGsh8E1rj2cWmQh0OHjuZECMZxp6Q@mail.gmail.com>
 <CA+icZUXu7ZNdrv6gTFCRri1ReF2e_87mX5D3Sex7tN+0GBpJ1Q@mail.gmail.com> <CAHk-=whXAvCnjCBj=p4-xvEojQ1iy=dA9VjWtAhMwG4MLK_6jw@mail.gmail.com>
In-Reply-To: <CAHk-=whXAvCnjCBj=p4-xvEojQ1iy=dA9VjWtAhMwG4MLK_6jw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Tue, 30 Mar 2021 14:31:30 +0200
Message-ID: <CA+icZUVZtj8eBVMyoaR9GcqDZukcLTxGvGN71HoTWgf_jS=F-g@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Peter Anvin <hpa@zytor.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 27, 2021 at 9:02 PM Linus Torvalds
<torvalds@linuxfoundation.org> wrote:
>
> On Sat, Mar 27, 2021 at 5:08 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> >
> > debian-5.10.19 as host-kernel:
> > 11655.755564957 seconds time elapsed
> >
> > dileks-5.12-rc3 plus x86-nops as host-kernel:
> > 11941.439350080 seconds time elapsed
>
> That's 2.5% - a huge difference. Particularly since kernel build times
> shouldn't even be that kernel-intensive.
>
> I think there's something else going on than the nops. Same config?
> There are likely many other differences between 5.10.19 and 5.12-rc3.
>
> So can you check just plain 5.12-rc3 and then 5.12-rc3 plus x86-nops,
> with otherwise identical configuration?
>

Hi Linus,

I re-checked my linux-config and custom patchset.

I had "kbuild: add CONFIG_VMLINUX_MAP expert option" in my queue and
build with CONFIG_VMLINUX_MAP=y.
This option generated here an approx. 30MiB big vmlinux.map file.
Cannot say how long this is taking in seconds but that can explain the
the time-diff.

[ The above option is helpful to analyze a recent Linux-kernel build
with CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y.
Always, I was able to build but not boot on bare metal with
CONFIG_LD_DEAD_CODE_DATA_ELIMINATION=y.
With a LLVM toolchain, of course. ]

( In the meantime Debian has a 5.20.26 kernel released - so if you
want I can re-test with Linux v5.12-rc5. )

Regards,
- Sedat -

[1] https://git.kernel.org/pub/scm/linux/kernel/git/masahiroy/linux-kbuild.git/commit/?h=kbuild&id=babd8cd96d333cb83c9b8abf4f01ab1f161d6ec4
