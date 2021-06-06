Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3566139D05F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 20:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhFFSNL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 14:13:11 -0400
Received: from mail-ej1-f46.google.com ([209.85.218.46]:39880 "EHLO
        mail-ej1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhFFSNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 14:13:05 -0400
Received: by mail-ej1-f46.google.com with SMTP id l1so22725950ejb.6
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 11:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FKuybgAgyMzO4iU5BpZa8HSbFtwDUcG15B2kgwy+X7k=;
        b=Vwi8eTi4MMgQuYuMgETnEHOG+sdOEJb1xqe2bu3Mu/2iXPXjzsiiznTXkVldkwp79G
         E4f1aGtVZ43PmoTSSFQzhnamjffmb7R6KK5l4lg4HhcZpXbn9GwkZWegF+rYlLpFp50F
         J6wseJWJe+NJg8yIQ/He6C14rbg9zHt68fZOA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FKuybgAgyMzO4iU5BpZa8HSbFtwDUcG15B2kgwy+X7k=;
        b=CUZb2xukTDSIitexlVVLxGGDiAUIb+av4mqhuv6BuEvVqPdiedaGzFtk3GZGKw5aRw
         J4CdczeU+/m5QdbOxgwb7PaiZzFAVEPowft0BQol6g6npetU99ldoLk0D9cJPHjzmR/+
         tlTRXkn3NDGUNuhHPChY1yQam9NCAZrBcs3qaNiWwfFsp2BpAqrHOJYWH9wKwQ62JlEQ
         lv0NWB3zhhnQvaBFRem3pmlHTB8qhBtXjJPEvwCw3XPKxRE1cH045xdOTmjltPHgW9nq
         lhD6pe4OwqCy+HlfVYIFIBavJA05SSTlMZBaHxPybNQSHbR9hNQbormKBUB4s/sAbfnf
         Cyag==
X-Gm-Message-State: AOAM5317Swk6uapYtRsHDTu6uvDf2qW1MKiZW7gXfRNY9kSXSQOvbHjq
        rqvfUrzE7VTDSn1WiRH/cpdhJ9ajL6sbDSs49g4=
X-Google-Smtp-Source: ABdhPJxs280Vn1PaXfl2raD+Cl1o3edH2XnbpYqoDk0C8DPQqRASZw2B7Asu7NMYlaRpMaTdY8oqtw==
X-Received: by 2002:a17:906:2456:: with SMTP id a22mr14149206ejb.496.1623003014940;
        Sun, 06 Jun 2021 11:10:14 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id kb20sm5555654ejc.58.2021.06.06.11.10.14
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 11:10:14 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id t3so17378410edc.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 11:10:14 -0700 (PDT)
X-Received: by 2002:a05:6512:3f82:: with SMTP id x2mr9071498lfa.421.1623002705722;
 Sun, 06 Jun 2021 11:05:05 -0700 (PDT)
MIME-Version: 1.0
References: <20210604182708.GB1688170@rowland.harvard.edu> <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <20210606115336.GS18427@gate.crashing.org>
In-Reply-To: <20210606115336.GS18427@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 11:04:49 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
Message-ID: <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 6, 2021 at 4:56 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> And that is a simple fact, since the same assembler code (at the same
> spot in the program) will do the same thing no matter how that ended up
> there.

The thing is, that's exactl;y what gcc violates.

The example - you may not have been cc'd personally on that one - was
something like

    if (READ_ONCE(a)) {
        barrier();
        WRITE_ONCE(b,1);
   } else {
        barrier();
        WRITE_ONCE(b, 1);
    }

and currently because gcc thinks "same exact code", it will actually
optimize this to (pseudo-asm):

    LD A
    "empty asm"
    ST $1,B

which is very much NOT equivalent to

    LD A
    BEQ over
    "empty asm"
    ST $1,B
    JMP join

over:
    "empty asm"
    ST $1,B

join:

and that's the whole point of the barriers.

It's not equivalent exactly because of memory ordering. In the first
case, there is no ordering on weak architectures. In the second case,
there is always an ordering, because of CPU consistency guarantees.

And no, gcc doesn't understand about memory ordering. But that's
exactly why we use inline asms.

> And the compiler always is allowed to duplicate, join, delete, you name
> it, inline assembler code.  The only thing that it cares about is
> semantics of the code, just like for any other code.

See, but it VIOLATES the semantics of the code.

You can't join those two empty asm's (and then remove the branch),
because the semantics of the code really aren't the same any more if
you do. Truly.

              Linus
