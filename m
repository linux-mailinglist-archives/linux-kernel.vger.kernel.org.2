Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 081F533951C
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Mar 2021 18:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbhCLRgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Mar 2021 12:36:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbhCLRgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Mar 2021 12:36:22 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCCBC061574;
        Fri, 12 Mar 2021 09:36:22 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id e7so3280144ile.7;
        Fri, 12 Mar 2021 09:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=dN5wWCL4386GqSoA/EHOirCNKD6L6wdiesXxnENmxI4=;
        b=uwmdaRLNlcTGrBoHcZg9vpO17c4wP0MIYDnS+c6SUFnK19aH1uc8zwC13NkqAhVN9J
         lr4JIaMa/r9t8/EnXQ01FAm91BrrxU55AyshFsirtI42pCVGPFf+NPbCWbS1oVHyQPav
         88P0GeJGfKWqgbEgNJtETZHBBvQrQfdb5sxGvkUdsWBd5vmGXblcEgI60IxeXBxBSy29
         9Dy0GZsOYeZvUEV1Jk72JFljzqE9aPzKYrc/ApY7AxWFyHNt3ZBIuKTNnkaWNPmoRQWO
         TEA5KJC1nMatvl++btw4dkfb45vH4fGzaGBy8PqlDP1LdgHrDekHCjLyQ+62s01h1xr9
         E1rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=dN5wWCL4386GqSoA/EHOirCNKD6L6wdiesXxnENmxI4=;
        b=IWaf0TbNbKsQGrWeNgt1iIlkfIoxmI75y+UwIEDiBfRqkuKKV60MYHDHGrwYKvI2zd
         tT3Omh6L2rRzVD8vFymkmcLLGZ/kJ/U0fHSs2j3jg+UryknF1rAOYElsId40bWl+Nlai
         jNTFK5lmRIZF8jxAKaKfywo/yqAQu1UDIe0rlHNTHZniRAgAAoE4xfODMfKKZJFVVtNl
         YbvGcYo/B+36Z2HoRCG4X0zVgGuressZ/YXoSxP/gm6VsOizcbtfcEa5avYP29VCmBTk
         pQ4+AGITFyJHI0PNKJ8zgdetpvV9JqebFIHWoe5WpfB5dz9wey6sAdnLTAnGkmNLKnwH
         WjCw==
X-Gm-Message-State: AOAM533OYoeOSMKnvWGQxiYMDaHbQnzqmibkHdpv4zEfg2JsnX5BjkqT
        ShdRuNPKyDv43rnWIK8fsEWnRIsmEqUxtEPJ+9M=
X-Google-Smtp-Source: ABdhPJwS/i2cdWbmHCySXYUOm3H63v3joSX1rd/sI2Q5oPC4Rhia8d49/en/fQwRV7y/dZ2La6gGcG1FBfZVsE0dH7U=
X-Received: by 2002:a92:c7c2:: with SMTP id g2mr3638312ilk.209.1615570581648;
 Fri, 12 Mar 2021 09:36:21 -0800 (PST)
MIME-Version: 1.0
References: <20210312113253.305040674@infradead.org> <CA+icZUVa7c4aZ=Tq-Axfqu9hT2QR-iNbAMGHE6u1ps-6Vw35=A@mail.gmail.com>
 <20210312144726.GA22098@zn.tnic> <20210312122622.603bd82c@gandalf.local.home>
In-Reply-To: <20210312122622.603bd82c@gandalf.local.home>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Fri, 12 Mar 2021 18:35:45 +0100
Message-ID: <CA+icZUUpQWtLcqjK+07ktO5PCoJ+2HEHzyp4tRRqHZpAOatq5g@mail.gmail.com>
Subject: Re: [PATCH 0/2] x86: Remove ideal_nops[]
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        hpa@zytor.com, torvalds@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-toolchains@vger.kernel.org,
        jpoimboe@redhat.com, alexei.starovoitov@gmail.com,
        mhiramat@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 12, 2021 at 6:26 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 12 Mar 2021 15:47:26 +0100
> Borislav Petkov <bp@alien8.de> wrote:
>
> > On Fri, Mar 12, 2021 at 03:29:48PM +0100, Sedat Dilek wrote:
> > > What does this change exactly mean to/for me?
> >
> > Probably nothing.
> >
> > I would be very surprised if it would be at all noticeable for you -
> > it's not like the kernel is executing long streams of NOPs in fast
> > paths.
> >
>
> With ftrace enabled, every function starts with a NOP. But that said, the
> simple answer is for Sedat to apply the patches on his box and do some
> performance testing. It doesn't matter if you are white, black, male,
> female, or anything in between. As my daughter's swim coach said; it's the
> numbers that matter here. Run a bunch of benchmarks on your box on the
> latest kernel, apply Peter's patches, and then run the benchmarks again on
> the latest kernel with Peter's patches and then report the difference. If
> it's negligible then there's nothing to worry about.
>

Hey Steve, you degraded me to a number :-).

I dunno which Git tree this patchset applies to, but I check if I can
apply the patchset to my current local Git.
Then build a kernel in the same build-environment.
Lemme see.

To say with Linus's words:
"Numbers talk - bullshit walks."

- Sedat -
