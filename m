Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014BF37472B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 May 2021 19:53:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236183AbhEERr4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 May 2021 13:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237110AbhEERqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 May 2021 13:46:08 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F04B6C061343
        for <linux-kernel@vger.kernel.org>; Wed,  5 May 2021 10:21:14 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id y2so3630986ybq.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 May 2021 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=whIXjs7HREiiPRAWZX/G6jQFBwJD27ZgekNpzmde44g=;
        b=gZ+cK+xgmmvgVAC+FiI8e/Yklqk8O5I4cKNx1uA0JvEX1UEePUXJg2QQwml7Hu5LSi
         nb5jPM28TGfpkev+Mgltbw4Zn/iwzTuF0wzcoHIYQgdU8h2JstSeU4xvopfqcFbfPg2C
         QECsXpX8jDY1CjrYHwx5fkes+BcZjFR758IsXPSHf4w9pIHIEOALGfwqFT+loWV9dvJn
         mQa3bzCn5lZKnAj7ysuCa/oPalQTrpW6lmdr9wbA9Fts23sTnn32x7gd42lJLjn6k3Ar
         X/B/zfzMcOrvcLmtAy92xGCqivUU6porRmgk2nU6a+ij7HCCptGxlqdjBxCvxn9QTorV
         cFMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=whIXjs7HREiiPRAWZX/G6jQFBwJD27ZgekNpzmde44g=;
        b=MJfW4TjoRPCJ9bO63ld79i07Pv/e41l8GcPfZhvwi4+C+/gHDwgGOMS34jahGTgbJa
         hNaEO5KuTH7TpQOwCFP2rLAZOkHIbBQ+1QAAlRX3Zo4uJtlxsoJDtrKuLCqJna8Z9Lfh
         F5QgoprGvxabqF6hEq/dd7WulmPHKW57x/jwkMnTo6+GWDhLu9EXRFiuScq/JdKtgV35
         FF7wZBKnzSBpF1JOKNA3kdaCVX54afPruw6szYRM5m2nawQKy6DK5BmoS87+RtA7dRd9
         eTy13BDazV1DTCXtGFPxhBXjl6+3dL5yH4TUD5oMfc7W0WcdPBGz1AuOOfD0ZBARvebE
         AxRg==
X-Gm-Message-State: AOAM530zn3sHFm0fzWSJSCFixhmSuiV5ZRob0v4sL3kK+zeNBwRjea9O
        Zqsb/4EFR+mi5Ufbz3R3RIbYJurGuLZ5PeT894k=
X-Google-Smtp-Source: ABdhPJz5ytzetetFuJLhh30RpHuKd9QwIKM79Ee5Rfm1c9mUj4iz/ee+owygfw8kPcMcYFyBgovUPDikcuchHnIcU1Q=
X-Received: by 2002:a25:cccd:: with SMTP id l196mr46524836ybf.26.1620235274101;
 Wed, 05 May 2021 10:21:14 -0700 (PDT)
MIME-Version: 1.0
References: <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com>
 <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <20210502093123.GC12293@localhost> <CAHk-=wgdUMt_n84mq93LZKA6jOGqZpD+=KeVzA3YmvJ6=JPyhw@mail.gmail.com>
 <20210502164542.GA4522@localhost> <CAHk-=winSraiwc4gC5WFWSehFq+s7AqCJZoMqUuHLX0nYVG0nQ@mail.gmail.com>
 <20210502175510.GB4522@localhost> <CAHk-=whTjJwCt2E0_JM2dDq=+UybvJN7QK+6K6e80A9Zd8duYg@mail.gmail.com>
 <20210502214803.GA7951@localhost> <CANiq72=5766fGQjNoMoOxrywoJHQ+-i4U+Nb62MeEaRok4LCFg@mail.gmail.com>
 <YJHto1KaPFey5irj@mit.edu>
In-Reply-To: <YJHto1KaPFey5irj@mit.edu>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 5 May 2021 19:21:03 +0200
Message-ID: <CANiq72nJadi6X4BfFv5yiqNAZX9rwUT1zovhw6awGueLOyUYrg@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Adrian Bunk <bunk@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Wed, May 5, 2021 at 2:58 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> What does this mean for enterprise distributions, like RHEL, which
> need to maintain a stable kernel ABI as part of their business model.
> I assume it means that they will need to lock down on a specific Rust
> compiler and Rust libraries?  How painful will it be for them to get
> security updates (or have to do backports of security bug fixes) for
> 7-10 years?

That is a good question. If a security fix requires changes in some
generic that an out-of-tree module uses, customers will need to
rebuild their module if they want that fix. So companies providing
those modules will need to understand that disadvantage if they decide
to write an out-of-tree module in Rust. And to support out-of-tree
modules, distributions will need to provide the generics metadata like
they provide headers etc.

As for freezing the compiler, some distributions already support the
Rust compiler in LTS releases etc. But now that the Rust Foundation
exists and gets sponsor money from big corporations, companies and
distributions may be able to ask for "LTS" releases of the Rust
compiler, or ask for sharing some of the burden of backporting
security fixes etc.

Cheers,
Miguel
