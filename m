Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB4D3165BA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Feb 2021 12:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231649AbhBJLxY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Feb 2021 06:53:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231444AbhBJLsj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Feb 2021 06:48:39 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DB5C061788
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:47:56 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id z6so1114676pfq.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Feb 2021 03:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FwhQWQcXOYcRdwhUuOHm0u5zszXz7WPkm4PdHoVK8WA=;
        b=rXlyVjCrQGaXRg/2MVoSkt5wv3hssM0LAX+7UPuG3iMDCEBXXWTcGJ45kFm2LLFMyC
         +qOD99PZITQ8T1RyJmAd+cpgt72dlFiKxtchZoLaDYsNUbHvOtm7sfCeBlTa9OFzQ0ya
         LAUCJgeqIXReb1CHjrI56L8ArODTtGcdXRcLpEEKCBk2ms9zc9GXGoaU0ezH88fB+hqi
         VIM/whY7w97RD3XA/O+mbPqOJdZUx01R1QoOZSOdvKdeV3sHYzoKU2G9Tr6O+Jmk3/2z
         2tFv9kbK2rFuAdLbE+//BXSLq1VGMTNkYlRT6mK0dDFWFdNuAiTixFWtLZsNe0Mo7pGP
         MhAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FwhQWQcXOYcRdwhUuOHm0u5zszXz7WPkm4PdHoVK8WA=;
        b=S+39wNF/2tMRPHZjlnKerW0PK1TPQEm7V3s8RTh78/qXC3b9uG3cOXUubvlx8xa702
         Rb89ACUTsf1N+voSdXVClHcWO0y92gHukM5o4//HqVGLvBbFs60kUYweM/45bMypjZRN
         FPdLy9tQ/eY6iL9NHukZHvhzEELQ2BCdzpHaiL4sZs+ehTL/BwuNfXaZcqk5x4+6TRwf
         zEm0oNqHXb9fiouw6g7UTR2gfRKqM300q3+/lTJMFWrBNKpy4U5bjEv0o96q9DxBnXt+
         55iN2l+Pqt7YuhWxpg+kVY1X1dAYf8jw9ZDp3EsnSmxGNhVmYovFuz4TBx+PI7TJEMUb
         O9bQ==
X-Gm-Message-State: AOAM532AnKuNVi4h+J5KUPvhl4GOM9yxsxJYvpg+yYFaqggeb3MkDGtQ
        9JxFfOciG8CX+Wtg7TCcCmStlK49JH4skeqpBKk=
X-Google-Smtp-Source: ABdhPJyfVGi0uwy4EI40frHSBiF+i9wRYQo78rkrCkII3Yugzi/xQ6NQA8drVMpRv2Mww5VQufn8qYli9tYZcG1F4n0=
X-Received: by 2002:a63:3d0:: with SMTP id 199mr2782236pgd.4.1612957675693;
 Wed, 10 Feb 2021 03:47:55 -0800 (PST)
MIME-Version: 1.0
References: <20210210051814.845713-1-timur@kernel.org>
In-Reply-To: <20210210051814.845713-1-timur@kernel.org>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 10 Feb 2021 13:47:39 +0200
Message-ID: <CAHp75Vfai3cdBmxqE1mW27xj=+E2aWRoVfN-6mXw0miMAe-Exg@mail.gmail.com>
Subject: Re: [PATCH 0/3][RESEND] add support for never printing hashed addresses
To:     Timur Tabi <timur@kernel.org>
Cc:     Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        roman.fietze@magna.com, Kees Cook <keescook@chromium.org>,
        John Ogness <john.ogness@linutronix.de>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        Marco Elver <elver@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pavel Machek <pavel@ucw.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 10, 2021 at 10:33 AM Timur Tabi <timur@kernel.org> wrote:
>
> [accidentally sent from the wrong email address, so resending]
>
> [The list of email addresses on CC: is getting quite lengthy,
> so I hope I've included everyone.]
>
> Although hashing addresses printed via printk does make the
> kernel more secure, it interferes with debugging, especially
> with some functions like print_hex_dump() which always uses
> hashed addresses.
>
> To avoid having to choose between %p and %px, it's easier to
> add a kernel command line that treats all %p as %px.  This
> encourages developers to use %p more without making debugging
> more difficult.
>
> Patches #1 and #2 upgrade the kselftest framework so that
> it can report on tests that were skipped outright.  This
> is needed for the test_printf module which will now skip
> %p hashing tests if hashing is disabled.
>
> Patch #2 upgrades the printf library to check the command
> line.  It also updates test_printf().

It's a bit hard in some mailers (like Gmail) to see the different
versions of your patches.
Can you use in the future
 - either `git format-patch -v<N> ...`, where <N> is a version
 - or `git format-patch --subject-prefix="PATCH vX / RESEND / etc" ...`
?

-- 
With Best Regards,
Andy Shevchenko
