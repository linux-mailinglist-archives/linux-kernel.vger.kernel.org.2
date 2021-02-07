Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD9C831249A
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Feb 2021 15:14:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbhBGOMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Feb 2021 09:12:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbhBGOMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Feb 2021 09:12:34 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19FDCC061756
        for <linux-kernel@vger.kernel.org>; Sun,  7 Feb 2021 06:11:52 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id es14so5813036qvb.3
        for <linux-kernel@vger.kernel.org>; Sun, 07 Feb 2021 06:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EbecQ8zqHgOTcO4kzpmsL2upyxqqOx54oC+JT9KeA/4=;
        b=VoaGYA4WUtUvha0+74kbVoXOepwpjsHkoeLZhXi/1xkY49sjDbmzJMPgZaOKXqU85R
         Nn1tpOcn3Tehi9gE6GlaBHPy2J3lKiC8DSbAEOm1TjA7bYWbZOKjl4ka1utX9OBum7So
         CuZHEohpYwaG3IHeDIV2ihJ/xKPXUQDQ2WsFrQERAta05ODwlmnff81/EMxnWcfIk2Ow
         cdDsf4mePz4TwYH0y87ivhaJ936z3Agn20xVa7zKK4VojDgcXaLrK0DoN/sjwJSj9jke
         +8Yk20voiRe5dBjoRh9DJN2Vm2NzOcuUK6G+X+gwZFSjfB/QNB0AGFnys+w+WQJaUY0u
         e34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EbecQ8zqHgOTcO4kzpmsL2upyxqqOx54oC+JT9KeA/4=;
        b=ZeMuF2Xd2XkEo/4MuDybFDvpbXqiZVxBHxDXmzxZ2ZoINREMRH5d7796ZgxMhsb5bM
         lB1QzPV6XjWzuSNQZGID1EtgwMoqTW4qxpFFzS42CmDwRvewTSSdcJW1e5SS2tRu6yku
         c7pAPSZ2y7TG14Lt2auUXR5sFOMGuna8d0BscvURjZbvXfOf4+fElnLXTwVdNCCVQbMp
         qXn5/I+nwiaBphcjCg8lZN2RktCh7PhVYOjHA09RLnTU5ZCBa6nng8kkgrmEncU0gk9a
         HZUMT2LaElUR48hDXG27tgeETUSV7C/NCHTJdMF7Cg6Eg+a+bxiQXpX1nN3n0OAOTgkB
         vMig==
X-Gm-Message-State: AOAM531G12ICCoDwKvH9EA2p0EdzRaR2Pb/l4LTnU0yGBVrZtLoQo9pn
        u0k34/xN0rYEuQL7aDH0DVVz9JdOuAp2ZfrHHIRkcA==
X-Google-Smtp-Source: ABdhPJxHoy804puWmwQbYddKwGPvAoW1wM8OFFEwbBktJ3yBnCKrgnoO4o2XSPcFHIU5IrVf8JtulLV2WKfC1uMV10Y=
X-Received: by 2002:a05:6214:522:: with SMTP id x2mr12631913qvw.13.1612707111041;
 Sun, 07 Feb 2021 06:11:51 -0800 (PST)
MIME-Version: 1.0
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <20210205151631.43511-11-kirill.shutemov@linux.intel.com> <CAMe9rOrhPNs7WZa7DquEQf_YN4XyeDZC5u3XC7MBDija3ic3+Q@mail.gmail.com>
 <CACT4Y+b3jpjnWeDeUmn8TZ6KvQCu3riip0R07JjNwiOjsRYy6w@mail.gmail.com> <20210207140906.hdfzorevpmiqtryd@box>
In-Reply-To: <20210207140906.hdfzorevpmiqtryd@box>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 7 Feb 2021 15:11:39 +0100
Message-ID: <CACT4Y+ZN_9QB1q9+TakyDz5O6M735S=1qWc+nXkgn30Hy7_9gw@mail.gmail.com>
Subject: Re: [RFC 9/9] x86/mm: Implement PR_SET/GET_TAGGED_ADDR_CTRL with LAM
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "H.J. Lu" <hjl.tools@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        GCC Development <gcc@gcc.gnu.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 7, 2021 at 3:09 PM Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Sun, Feb 07, 2021 at 09:07:02AM +0100, Dmitry Vyukov wrote:
> > On Fri, Feb 5, 2021 at 4:43 PM H.J. Lu <hjl.tools@gmail.com> wrote:
> > >
> > > On Fri, Feb 5, 2021 at 7:16 AM Kirill A. Shutemov
> > > <kirill.shutemov@linux.intel.com> wrote:
> > > >
> > > > Provide prctl() interface to enabled LAM for user addresses. Depending
> > > > how many tag bits requested it may result in enabling LAM_U57 or
> > > > LAM_U48.
> > >
> > > I prefer the alternate kernel interface based on CET arch_prctl interface which
> > > is implemented in glibc on users/intel/lam/master branch:
> > >
> > > https://gitlab.com/x86-glibc/glibc/-/tree/users/intel/lam/master
> > >
> > > and in GCC on users/intel/lam/master branch:
> > >
> > > https://gitlab.com/x86-gcc/gcc/-/tree/users/intel/lam/master
> >
> > Hi Kirill, H.J.,
> >
> > I don't have strong preference for PR_SET/GET_TAGGED_ADDR_CTRL vs
> > ARCH_X86_FEATURE_1_ENABLE itself, but tying LAM to ELF and
> > GNU_PROPERTY in the second option looks strange. LAM can be used
> > outside of ELF/GNU, right?
>
> Sure. In both cases it's still a syscall.

Oh, I meant just the naming scheme. The consts are declared in elf.h
and are prefixed with GNU_PROPERTY.
