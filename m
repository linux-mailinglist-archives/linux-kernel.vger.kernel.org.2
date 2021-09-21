Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE01A4137E2
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Sep 2021 18:53:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhIUQy1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Sep 2021 12:54:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbhIUQy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Sep 2021 12:54:26 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37FF3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:52:58 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id u22so56222oie.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Sep 2021 09:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sKyAaMyjba5UGAL+Ffx1m6B2HtqFlKzn3qa+s7JDR7A=;
        b=n97JREXFhF8uInD9jyglFF3bXcJ3A2tDq5l8e5eUvblCKJfUsPd++5B6ezoWO6/LFe
         4Y5/mxWmaiIXW9v1MHV1Kizx78BAQLZ0dTJstd/CJn+UfSIwv0svWqYAb2/YJ5tEwW+D
         eIP5m5JNaBB/Vjzq3/ByT2um9Eu4/bN0vFr8aBmqTFMHHxbVil6l8OD9LzrXa3D38VhC
         nKArVeO9Gh1n9PCM46b5FIIjZi35QgIR2rDfhIeU8LM8CcAW8OYcSyPsjEabryN9xnWR
         /vnsHiRHXn8zKZ2BZYHjIOW64R+ez8OYcplpyOxjakXp0nRZ+szI8x8uJN0K1STCZUUj
         YMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sKyAaMyjba5UGAL+Ffx1m6B2HtqFlKzn3qa+s7JDR7A=;
        b=Iy9ojVz2351RjCgDgO0zMm6QGmao46Bx4SxRPVq01lj4KpWLD4TDsdp5wEdpDh0oWe
         v5IeZFnLTb7utbsroB4tTsvd4O6xZcFKYrl52DqxgvVtx+YDc5qlzAyd/rM1d8tKg8TU
         39EJU2rdJZOAbjGrGooOVQSDYgy2LqoqVfJh98+aEleYSfe/E9JvaTDxVS0WWluOzVc5
         diZpa83VVy8kCRevqDgqzA1e0psdTqxpd/Py7WYaIQeXdGctBBo15HvSUdsWRoTJ7ABf
         iZMCUDEeEz9uJZRWYS4eFU0DqwyIUhU4lEUa575CqFqBgicSouGfcIpEN+vnOWInN+8I
         8qzA==
X-Gm-Message-State: AOAM533nuW24yiB9x0pe3p08ppUK0vzMatb6GZQxK7wr0s464JZEmuLl
        Amt3aBzh7bSBH0T3ojPajtIYSWXTz+WhWAiHHe1wUw==
X-Google-Smtp-Source: ABdhPJzUeS3r23NqEgDB/MiQoZUl05DsufRAMemqPlo77Pzz0H9z1H0SjpKWD8D1iZGN3L5glJj0AqUOiy6xau5v+9I=
X-Received: by 2002:aca:f189:: with SMTP id p131mr4542727oih.128.1632243177063;
 Tue, 21 Sep 2021 09:52:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210205151631.43511-1-kirill.shutemov@linux.intel.com>
 <CACT4Y+bh1yaGLs5H3YTM6YLLtyWELvjWR7HcEk0pd9Nod9u4ZQ@mail.gmail.com> <20210207141104.ikxbdxhoisgqaoio@box>
In-Reply-To: <20210207141104.ikxbdxhoisgqaoio@box>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 21 Sep 2021 18:52:44 +0200
Message-ID: <CACT4Y+YwUgksZBj4YpChqL8iac2us7mOkbVDLsib3Y+MVb31cw@mail.gmail.com>
Subject: Re: [RFC 0/9] Linear Address Masking enabling
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>, Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Carlos O'Donell" <carlos@redhat.com>,
        Marco Elver <elver@google.com>,
        Taras Madan <tarasmadan@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Feb 2021 at 15:11, Kirill A. Shutemov <kirill@shutemov.name> wrote:
>
> On Sun, Feb 07, 2021 at 09:24:23AM +0100, Dmitry Vyukov wrote:
> > On Fri, Feb 5, 2021 at 4:16 PM Kirill A. Shutemov
> > <kirill.shutemov@linux.intel.com> wrote:
> > >
> > > Linear Address Masking[1] (LAM) modifies the checking that is applied to
> > > 64-bit linear addresses, allowing software to use of the untranslated
> > > address bits for metadata.
> > >
> > > The patchset brings support for LAM for userspace addresses.
> > >
> > > The most sensitive part of enabling is change in tlb.c, where CR3 flags
> > > get set. Please take a look that what I'm doing makes sense.
> > >
> > > The patchset is RFC quality and the code requires more testing before it
> > > can be applied.
> > >
> > > The userspace API is not finalized yet. The patchset extends API used by
> > > ARM64: PR_GET/SET_TAGGED_ADDR_CTRL. The API is adjusted to not imply ARM
> > > TBI: it now allows to request a number of bits of metadata needed and
> > > report where these bits are located in the address.
> > >
> > > There's an alternative proposal[2] for the API based on Intel CET
> > > interface. Please let us know if you prefer one over another.
> > >
> > > The feature competes for bits with 5-level paging: LAM_U48 makes it
> > > impossible to map anything about 47-bits. The patchset made these
> > > capability mutually exclusive: whatever used first wins. LAM_U57 can be
> > > combined with mappings above 47-bits.
> > >
> > > I include QEMU patch in case if somebody wants to play with the feature.
> >
> > Exciting! Do you plan to send the QEMU patch to QEMU?
>
> Sure. After more testing, once I'm sure it's conforming to the hardware.

A follow up after H.J.'s LPC talk:
https://linuxplumbersconf.org/event/11/contributions/1010/
(also +Carlos)

As far as I understood, this kernel series depends on the Intel CET patches.

Where are these compiler-rt patches that block gcc support?
