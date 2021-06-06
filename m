Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34DED39D137
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 22:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbhFFUPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 16:15:03 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:44957 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbhFFUPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 16:15:02 -0400
Received: by mail-lj1-f177.google.com with SMTP id d2so14945498ljj.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 13:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g9Dgzkc6mzoKadrti0reRjEb/MNcsn0/HLVhWdAcN2E=;
        b=elCGeQWQ76a+XOXQPuapVBLMfPQKtXSartHcDBKR3BXRhLQUQ1oigbVKib9h/4m4qI
         uhVlgq6rpANSWCwav3vtsQ98Pq9CRLAd5IFkrs0e5UJuq047ZkqZ2jZTnt7Z6iLKI4dC
         yKLcJ7tRcQNXK+WF2+PHQlsrWV/8w+4ygZ/OU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g9Dgzkc6mzoKadrti0reRjEb/MNcsn0/HLVhWdAcN2E=;
        b=CyCv3bSADIL+IzQGKDCwQsJn2LvYC/EpDVMFptRcnSg9gYdj2MluuVGApSKlkTYz/n
         yMj220ZrP8e2hWw4I6uSsWDaLaWrlxOEMlehJn6LABMC/WPKa8wSaI/u47UWedhBAYMR
         V58JETZ9uwYPwCsN6MuYnpeJ821ZxCXp0ndRfMPXa7fyJo3VcGJOitRr65ckREeyG+I5
         +yE2wJyNAGNamT4R/8pvZ7HLvlr/moX4Xe3BoefT4UbeWZ+6oO8ARSEJcpsjuezEomDl
         UXRmYBsu/BkAERCvp+n94fU53J2wfc9uOxTfGmVSkkHRbzIhdHp6Que6ah7Md0U4LbcX
         Betw==
X-Gm-Message-State: AOAM531E77Ac4H0ouRJIENex8snQAtQRrsYcABMPat3OWli75ediSm4h
        5L3xynp8pDgTJA61myli4TGunRXwckrM8dCXIkI=
X-Google-Smtp-Source: ABdhPJxfI+DZjT6EO6PmDwry1ltmRTaLeOYy61O6o70e3wWPlxYgqTWbKdP7cIvpRsMd8gmLxtqtSQ==
X-Received: by 2002:a2e:a544:: with SMTP id e4mr12371493ljn.265.1623010331404;
        Sun, 06 Jun 2021 13:12:11 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id v20sm1241460lfa.49.2021.06.06.13.12.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 13:12:10 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id r198so19214027lff.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 13:12:09 -0700 (PDT)
X-Received: by 2002:a19:7d04:: with SMTP id y4mr9324319lfc.201.1623010329434;
 Sun, 06 Jun 2021 13:12:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
 <20210606184021.GY18427@gate.crashing.org> <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
 <20210606195242.GA18427@gate.crashing.org>
In-Reply-To: <20210606195242.GA18427@gate.crashing.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 13:11:53 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgd+Gx9bcmTwxhHbPq=RYb_A_gf=GcmUNOU3vYR1RBxbA@mail.gmail.com>
Message-ID: <CAHk-=wgd+Gx9bcmTwxhHbPq=RYb_A_gf=GcmUNOU3vYR1RBxbA@mail.gmail.com>
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

On Sun, Jun 6, 2021 at 12:56 PM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
> Yes, I know.  But it is literally the *only* way to *always* get a
> conditional branch: by writing one.

The thing is, I don't actually believe you.

The barrier() thing can work - all we need to do is to simply make it
impossible for gcc to validly create anything but a conditional
branch.

If either side of the thing have an asm that cannot be combined, gcc
simply doesn't have any choice in the matter. There's no other valid
model than a conditional branch around it (of some sort - doing an
indirect branch that has a data dependency isn't wrong either, it just
wouldn't be something that a sane compiler would generate because it's
obviously much slower and more complicated).

We are very used to just making the compiler generate the code we
need. That is, fundamentally, what any use of inline asm is all about.
We want the compiler to generate all the common cases and all the
regular instructions.

The conditional branch itself - and the instructions leading up to it
- are exactly those "common regular instructions" that we'd want the
compiler to generate. That is in fact more true here than for most
inline asm, exactly because there are so many different possible
combinations of conditional branches (equal, not equal, less than,..)
and so many ways to generate the code that generates the condition.

So we are much better off letting the compiler do all that for us -
it's very much what the compiler is good at.

               Linus
