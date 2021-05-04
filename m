Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0F23731F2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 May 2021 23:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbhEDVdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 May 2021 17:33:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232684AbhEDVdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 May 2021 17:33:50 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7322CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  4 May 2021 14:32:55 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id g38so14127000ybi.12
        for <linux-kernel@vger.kernel.org>; Tue, 04 May 2021 14:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQ92J3zGhDndMNfx+X1VxssfAKQc44gkgZYOFajMJdE=;
        b=Cf24OFEDjG1xG7O2CHYyjbgmcJ8PlFIkTXu0cANmNBRnW9ZhHu3zzjZn62nbXL7beF
         S1PX7EgOz2MvQDovSgRxnRBFYhCTSmAWk8Y2ojzzFdktLkKgK0uJMveGrRoxG7T9hPcb
         HNVyZHnZIjBN7m3zqiM4xPbjxUcxGlqX4G6ZkDHBoLDjCmhqs5Ow9EW0abCxqvbQEY1V
         EuC2iZXRjL2TyWZQLVJ6AU0x2yGWhkHNs5qVY+wdbBQ5f4cnA66BVchdNZjl0OigNg6T
         DHxJDz0fWNq7ntZd4/17kSThIKAMkRiZS0cpXZYIT/ymJJIGKXAbIbJVspoQ6Em3uk0l
         QtUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQ92J3zGhDndMNfx+X1VxssfAKQc44gkgZYOFajMJdE=;
        b=madSo1UGTjqJ7Me7DVF5nvMWrySWbHHn21IqG5iQHEu6CrnJSjoQCBptVUCkNPrQE7
         83k5EK6uTuEfl4Ty3OqQ4hlbGXbZoHhukt27qWgfaK9+CkkLVl0oJqQhrp+l/w4FYQjC
         JVgwb8k1RT3aAb107pX0oREqebljLlDy5XkKHfTVf44RU+By78as7irFwPIwnOavSH6R
         mo0emZ34s+VSQj0e4cJTQ0gBmDmtJzuqtiX/EC1phvJA8PW097UtKSCPR24rjkDSS8lP
         okJ/VpiG3gHEFM9K1bQfrpH4ALabx9BCsRqC+D9DmXaWHUFndjYugkOfFjeUZ4JY/8nq
         74fQ==
X-Gm-Message-State: AOAM532InI+TIn8mEKuFdvO2uCJEWKU7nICsqT4XcNe4cXCK9b8MIC8x
        /O9QBjNc1uu5U8s+eBJ8bwFsP9wPvTF2+i1FYvEckAGxxKqjUz7j
X-Google-Smtp-Source: ABdhPJz6/UFxS8ArkGHPjqj0qixbiVc+irOv5IaEcFciy2IO9EMns0H1joe8jGqP1H7BIdiSx3xhmm3QuE5k6nMiw3o=
X-Received: by 2002:a25:9942:: with SMTP id n2mr38988639ybo.230.1620163974661;
 Tue, 04 May 2021 14:32:54 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com> <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <20210502093123.GC12293@localhost>
In-Reply-To: <20210502093123.GC12293@localhost>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 4 May 2021 23:32:42 +0200
Message-ID: <CANiq72=aK-JJhpnZdeeGBtADrnXhyEp1Whw5+5rK6a4u85PhxA@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     Adrian Bunk <bunk@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Tom Stellard <tstellar@redhat.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Fangrui Song <maskray@google.com>,
        Serge Guelton <sguelton@redhat.com>,
        Sylvestre Ledru <sylvestre@mozilla.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 2, 2021 at 11:31 AM Adrian Bunk <bunk@kernel.org> wrote:
>
> Some of the new language ecosystems like Go or Rust do not offer
> shared libraries.

This is a bit misleading. Rust offers shared libraries, including the
option to offer a C ABI.

The problem are generics which, like C++ templates, cannot be swapped
at runtime. Distributions have had to deal with the STL, Boost, etc.
all these years too.

In fact, Rust improves things a bit: there are no headers that need to
be parsed from scratch every time.

> What happens if you use a program provided by your distribution that is
> written in Rust and handles untrusted input in a way that it might be
> vulnerable to exploits based on one of these CVEs?
>
> The program has a known vulnerability that will likely stay unfixed.

Why? I fail to see what is the issue rebuilding (or relinking) all
packages except distributions lacking enough compute resources.

Cheers,
Miguel
