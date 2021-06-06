Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A184039D0FA
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 21:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhFFTZP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 15:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbhFFTZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 15:25:13 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4DBC061787
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 12:23:10 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id v8so22398851lft.8
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 12:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SxzQ9kXsLpYpGaBDNbZGNnlILKugyXAISeA2/rdzd6k=;
        b=HxIYzEoug2HZb7ZqR/KRiqAwIk7rncw5YLe1/7eduA90vqFUIDVWcI9D3JZejt77sN
         T69H48eefkSR15ldviHrWBCMVFE2lB5hCWH8whL1cEmmIu6Ujv/RNLwnp7jVoWdMGZ4i
         ZV3dofdUOCvm4jTYUiLHeIGrvq/KEAZeyZygs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SxzQ9kXsLpYpGaBDNbZGNnlILKugyXAISeA2/rdzd6k=;
        b=pFLGFehwszDM/55G2B686Y7SaIR80GCSskCkcGGydHKRY9AeJfhoSNYypthi4z9uIn
         WrTwRhNGN84ZXuz//yp1CFWwbDW7fj/G3Y/Evxx39pmtb4H5QaoLYWsSUiCW6Et2XLJj
         H6cb7+Ec8pbi1wOcIse5+rfSMk2s2t3xrJnCA/5PVWQqud42ML2XNXCIpmWkFshHfxAi
         G3zMDMyljm2TlX/YscPNmhfnKCSf5rAcZVJIEncS9QLLxPd/RhdXIKuZqldyBnK35VwW
         8jMxEx+nx88gJFdbgUlncNG74R9eX+SgKC9iTJOg1tS5Br9j4h5H3nnOXutxCfqWG8H1
         xprg==
X-Gm-Message-State: AOAM533reosBbNdc2JP/i5tQjiX1hlmFwoniCOC6Ubvqfg190+8rmV8I
        eNTCk8LSsW76jOW8zHM+vYJ0Ohm4h2kbGQ6HHNE=
X-Google-Smtp-Source: ABdhPJwAV6ssiyJdkAWbpXcEEGLRz7+UZ4qGSZ/idSlxeahM1oYjzTd3x4fYqa+tq6O14Qufs9yzOg==
X-Received: by 2002:a19:d601:: with SMTP id n1mr9433615lfg.481.1623007382074;
        Sun, 06 Jun 2021 12:23:02 -0700 (PDT)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com. [209.85.208.172])
        by smtp.gmail.com with ESMTPSA id r7sm1499790ljc.113.2021.06.06.12.23.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 12:23:01 -0700 (PDT)
Received: by mail-lj1-f172.google.com with SMTP id o8so19043523ljp.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 12:23:01 -0700 (PDT)
X-Received: by 2002:a2e:c52:: with SMTP id o18mr11849195ljd.411.1623007380966;
 Sun, 06 Jun 2021 12:23:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiuLpmOGJyB385UyQioWMVKT6wN9UtyVXzt48AZittCKg@mail.gmail.com>
 <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <CAHk-=wgUsReyz4uFymB8mmpphuP0vQ3DktoWU_x4u6impbzphg@mail.gmail.com>
 <20210606185922.GF7746@tucnak>
In-Reply-To: <20210606185922.GF7746@tucnak>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 12:22:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com>
Message-ID: <CAHk-=wis8zq3WrEupCY6wcBeW3bB0WMOzaUkXpb-CsKuxM=6-w@mail.gmail.com>
Subject: Re: [RFC] LKMM: Add volatile_if()
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Segher Boessenkool <segher@kernel.crashing.org>,
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

On Sun, Jun 6, 2021 at 11:59 AM Jakub Jelinek <jakub@redhat.com> wrote:
>
> I think just
> #define barrier() __asm__ __volatile__("" : : "i" (__COUNTER__) : "memory")
> should be enough

Oh, I like that. Much better.

It avoids all the issues with comments etc, and because it's not using
__COUNTER__ as a string, it doesn't need the preprocessor games with
double expansion either.

So yeah, that seems like a nice solution to the issue, and should make
the barriers all unique to the compiler.

             Linus
