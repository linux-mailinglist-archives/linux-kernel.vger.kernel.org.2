Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE00039D087
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Jun 2021 20:54:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229894AbhFFS4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Jun 2021 14:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbhFFS4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Jun 2021 14:56:01 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79198C061766
        for <linux-kernel@vger.kernel.org>; Sun,  6 Jun 2021 11:54:10 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id r5so22392346lfr.5
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 11:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w5VchHZ9HNMBKb35UdCCE6Gr/vCI3h3rPMpf00kyqNs=;
        b=R2WObvngmVBGf8fkmSu/raDi70MtimjnPeoLsRpzIZ/QqlhRT9W729qtXgs0y+YRgE
         RccuCLSCbjRdauVYzc5HtTIUl0hU4XX6sAN+eohhsDMHfJe3SgfHLry/97Z55h4vRb9s
         IIm7AvmNxOb4EStL6EMtVKwNqWcgL8ls8QUQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w5VchHZ9HNMBKb35UdCCE6Gr/vCI3h3rPMpf00kyqNs=;
        b=fSyAtX7kuIGonIpHk6wlCKqz6KpF7oGV5ygSNp+4RVV0+pmQ12Q6l4cSEX22eHwHBN
         uT4GaCQqKtZuditFovmyR1GMi4LcMsE1R9tlNhtDcY7PCyNRQXo/HDg3VybA9SRUDFjJ
         mstzvwAh0bjRjdayDx4YlxkqEi4cFqnGLB9YnedrHI7j1Hyo8jKe0JJ+nRMQHxueOYd7
         grJptn3lRuybdOtMYpx3sA6JqW8bbZwLiToARSZw6qwjMjl7JIp7Gs+G01NWx19+NaDc
         Wqhf5EKST4lbqisvVtRX84DuA+cLmggpgAdshfOhsk3fh+ZSWgpULe3CXuA0TH1fbKiI
         kI2g==
X-Gm-Message-State: AOAM532s0Y5KjOyjwe/rv1YYo36z84bbmB1/mbJbn2DhY4S/XkzXdvM4
        Z1AC9Pl+T0IQgvtuh8yjt4fklKfQWU2MGEIpsR0=
X-Google-Smtp-Source: ABdhPJwVstRrKld/gONEKaIcZ6rqxdmaqRZPo5MdiDx4WT+YF0Ddvm/u4w8aQQd6V6PgcxUEjPQlZg==
X-Received: by 2002:a19:4083:: with SMTP id n125mr9357269lfa.585.1623005648367;
        Sun, 06 Jun 2021 11:54:08 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id h8sm1225249lfd.73.2021.06.06.11.54.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 06 Jun 2021 11:54:07 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id w15so18898885ljo.10
        for <linux-kernel@vger.kernel.org>; Sun, 06 Jun 2021 11:54:07 -0700 (PDT)
X-Received: by 2002:a05:651c:333:: with SMTP id b19mr11965516ljp.61.1623005647379;
 Sun, 06 Jun 2021 11:54:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wik7T+FoDAfqFPuMGVp6HxKYOf8UeKt3+EmovfivSgQ2Q@mail.gmail.com>
 <20210604205600.GB4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wgmUbU6XPHz=4NFoLMxH7j_SR-ky4sKzOBrckmvk5AJow@mail.gmail.com>
 <20210604214010.GD4397@paulmck-ThinkPad-P17-Gen-1> <CAHk-=wg0w5L7-iJU_kvEh9stXZoh2srRF4jKToKmSKyHv-njvA@mail.gmail.com>
 <20210605145739.GB1712909@rowland.harvard.edu> <20210606001418.GH4397@paulmck-ThinkPad-P17-Gen-1>
 <20210606012903.GA1723421@rowland.harvard.edu> <20210606115336.GS18427@gate.crashing.org>
 <CAHk-=wjgzAn9DfR9DpU-yKdg74v=fvyzTJMD8jNjzoX4kaUBHQ@mail.gmail.com>
 <20210606184021.GY18427@gate.crashing.org> <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
In-Reply-To: <CAHk-=wjEHbGifWgA+04Y4_m43s-o+3bXpL5qPQL3ECg+86XuLg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 6 Jun 2021 11:53:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiE14nATA-ejyeV0FmN9x1F+AiJvv88TZaj=DuxDP7sag@mail.gmail.com>
Message-ID: <CAHk-=wiE14nATA-ejyeV0FmN9x1F+AiJvv88TZaj=DuxDP7sag@mail.gmail.com>
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

On Sun, Jun 6, 2021 at 11:48 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> And to work well, it needs "asm goto", which is so recent that a lot
> of compilers don't support it (thank God for clang dragging gcc
> kicking and screaming to implement it at all - I'd asked for it over a
> decade ago).

Oh, actually, I'm wrong on this.

We don't need an output from the asm (the output ends up being in the
targets), so we can use the old-style asm goto that we've been relying
on for a long time.

So the main code generation problem is just (a) all the architectures
and (b) we'd have to use a fixed conditional against zero.

                Linus
