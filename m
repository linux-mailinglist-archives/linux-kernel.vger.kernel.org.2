Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3922C41C72F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Sep 2021 16:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344643AbhI2Ota (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Sep 2021 10:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344629AbhI2OtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Sep 2021 10:49:25 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F34C061762
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:47:44 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id x27so11769672lfa.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:47:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFg4AyxhOkrmj2m8GgLtBQsrwYL1m+vTuPDFyai2hnY=;
        b=TY3qm/59v0pVhETMeEmyrWKW7NYyHv2byd9LPTTDbwJuw+CRiLITgNlDDc497mHhda
         d61B42xvJ6U8Pd7AaGSizo8l0egJjeRfPlUcf2o9aMPSFuwM0Bjbu2N2fMTQl1dE4ofc
         G4kTQ1xx9fokfRymsuyrGUocPFZ4ADZ9Xay2w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFg4AyxhOkrmj2m8GgLtBQsrwYL1m+vTuPDFyai2hnY=;
        b=xSIBOkmCwOpFS/Ot2pxB6IwGjj/+t75gNeDV7YwlnflvsV5j3LVZ2FKhxjN7ut76SI
         oid1LS4ZwXncovw0/8zMKIpzMeQuARjrRf0lLbFaK1pGK/u2VitSOKzHDsCF1mYieDzA
         H783crP4gzDS6GskGa/rR1ZfGKSEdiXnvmM2qXOeU+jk224nuuM00jxoE3MtefT/TeNC
         JwTJGKb+3S23A5TXGr+h7EmIWYKwlBf+yJlume8AdQHOGEGVJfLVL9m8DOaa/mwgmmd6
         29UreXSJu3EVXipAlJWvyEf6PfU2/VaP5SHmb8WCgGl4QQu6UrjdbRIQoN7FDgYHtdIq
         0VPA==
X-Gm-Message-State: AOAM532A6Won6rfFE0epeLJvTlu7A4cUWSyvNxU9BdrmI60BL+s98LaJ
        4DmT2j3TsLg0ayecBUC2sjLbzTNrxqvDcx5z
X-Google-Smtp-Source: ABdhPJwgB9MVk8lFiBiKIO8oLj6Qde6mD0RdSUkuxuDvylx2mGA0t1Pslxt8kTz2Mc/vPDudaAbbow==
X-Received: by 2002:a2e:8150:: with SMTP id t16mr284153ljg.357.1632926861085;
        Wed, 29 Sep 2021 07:47:41 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id e25sm13244lfn.82.2021.09.29.07.47.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Sep 2021 07:47:39 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id z24so11693415lfu.13
        for <linux-kernel@vger.kernel.org>; Wed, 29 Sep 2021 07:47:38 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr309494ljp.494.1632926858377;
 Wed, 29 Sep 2021 07:47:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
In-Reply-To: <20210928211507.20335-1-mathieu.desnoyers@efficios.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Sep 2021 07:47:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg23CqjGWjjxDQ7yxrb+eF5at2KFU03GZa18Znx=+Xvow@mail.gmail.com>
Message-ID: <CAHk-=wg23CqjGWjjxDQ7yxrb+eF5at2KFU03GZa18Znx=+Xvow@mail.gmail.com>
Subject: Re: [RFC PATCH] LKMM: Add ctrl_dep() macro for control dependency
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrea Parri <parri.andrea@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nick Piggin <npiggin@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Jade Alglave <j.alglave@ucl.ac.uk>,
        Luc Maranget <luc.maranget@inria.fr>,
        Akira Yokosawa <akiyks@gmail.com>,
        linux-toolchains@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 2:15 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> Introduce the ctrl_dep macro in the generic headers, and use it
> everywhere it appears relevant.

The control dependency is so subtle - just see our discussions - that
I really think every single use of it needs to have a comment about
why it's needed.

Right now, that patch seems to just sprinkle them more or less
randomly. That's absolutely not what I want. It will just mean that
other people start sprinkling them randomly even more, and nobody will
dare remove them.

So I'd literally want a comment about "this needs a control
dependency, because otherwise the compiler could merge the two
identical stores X and Y".

When you have a READ_ONCE() in the conditional, and a WRITE_ONCE() in
the statement protected by the conditional, there is *no* need to
randomly sprinkle noise that doesn't matter.

And if there *is* need ("look, we have that same store in both the if-
and the else-statement" or whatever), then say so, and state that
thing.

               Linus
