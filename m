Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 091FF401E54
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Sep 2021 18:30:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244177AbhIFQb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 12:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244154AbhIFQb0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 12:31:26 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BBFC061575
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 09:30:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id c8so14382208lfi.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8IrmItaVABpTCCV1GTBCmSGs8mDxg06CHACTL5Qkb7w=;
        b=R2wRvIZ5fztexmU3w2tyRYRDA1Rg0puldwTR9y4HA3UlQ/qnMC08DRaXlPDdqtri+Q
         fAFEd+j22NAvQfMj3ireP0Bgf1gZNxEMJl31x2rd6p84iAF4Z4IsEEKwIkc2JxJLl4T5
         f6z/63UOWwOUtQoNqw8I23oboEBdueZySRELo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8IrmItaVABpTCCV1GTBCmSGs8mDxg06CHACTL5Qkb7w=;
        b=hjKT0NOt5d/0aUcWqvvZ9fUg3+NIn5WKJ+WUHjdA/IxfSgVsD/xz9CyHiARSHPXr8M
         lwGyjKN4DWJ9qSiz1OHAwxIQBQK1OX1wT/64wBd9UM8RCFLMmBWtvdifSUPrySsc5yzO
         P5Krqb26pC2p0v1MEmVHLNtELyX2vC2V6puTQs6eMsev7R+l85xTmnhLFvWkZwxrbtFb
         6uW3qGuMwy5XAYmxZZY05S4jYYmLslAc2/HEUWem7VbQTWPuVx8lAAz1kE6S4ggGDU3a
         POHOdUQmAQ1287rMKH8G/MZY5YQn0V7vhdvwn2UzdJabXge8QYyKLcHAmIkxrLCFI76I
         fqCQ==
X-Gm-Message-State: AOAM533fQrXbOVjJsk8puzyrRV2ETbZKUhUbZ/m6cHHuah3zJ7q/NRff
        +mAEVL80uvPVXHCkQWwYFG5Fn/7BhpmsSM12bjA=
X-Google-Smtp-Source: ABdhPJzyTvYNSNXEMAaYajDfjN/URX5cUs7BCmL0DfLzjNQh4gDFdwSL/FRnmSdk87eGItB4104d9w==
X-Received: by 2002:a05:6512:3404:: with SMTP id i4mr9700453lfr.149.1630945819594;
        Mon, 06 Sep 2021 09:30:19 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id k20sm1112451ljc.2.2021.09.06.09.30.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 09:30:18 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id h16so14336955lfk.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 09:30:18 -0700 (PDT)
X-Received: by 2002:a05:6512:2611:: with SMTP id bt17mr10258695lfb.141.1630945817827;
 Mon, 06 Sep 2021 09:30:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAK7LNAQ0Q6CdXaD-dVGj_e3O3JYs_crpejWKpXHYQJYxyk-1VQ@mail.gmail.com>
 <CAHk-=wgoX0pVqNMMOcrhq=nuOfoZB_3qihyHB3y1S8qo=MDs6w@mail.gmail.com>
 <3b461878-a4a0-2f84-e177-9daf8fe285e7@kernel.org> <878s0c4vng.fsf@oldenburg.str.redhat.com>
 <20210904131911.GP1583@gate.crashing.org> <871r644bd2.fsf@oldenburg.str.redhat.com>
 <CAHk-=wi+XKYN+3u=_fm=ExqpEaHdER0XuKxVauHYVCPKpKR97Q@mail.gmail.com>
 <20210904191531.GS1583@gate.crashing.org> <CAHk-=wjc1rxah3xt8mKN=aCxQigjy3-hEf4xh_Y-r=MXAKVrag@mail.gmail.com>
 <20210906154642.GV1583@gate.crashing.org>
In-Reply-To: <20210906154642.GV1583@gate.crashing.org>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Mon, 6 Sep 2021 09:30:01 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj=WpWO_V86cZH99LgZGBbvdDb4wR26ce5van0hJqjzLA@mail.gmail.com>
Message-ID: <CAHk-=wj=WpWO_V86cZH99LgZGBbvdDb4wR26ce5van0hJqjzLA@mail.gmail.com>
Subject: Re: [GIT PULL v2] Kbuild updates for v5.15-rc1
To:     Segher Boessenkool <segher@kernel.crashing.org>
Cc:     Florian Weimer <fweimer@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        llvm@lists.linux.dev, linux-toolchains@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 6, 2021 at 8:50 AM Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>
>
> Yes they are.  It is the single standard way to get the functionality
> you want.

Sorry, but 'standard' is the part that the kernel simply doesn't do.

Just face it. The kernel isn't written with all those standards that
are designed for entirely different things in mind.

> I don't know why you think you can separate that.  Take <stdarg.h> --
> there is no other (portable, standard) way to implement receiving
> variadic arguments.

You clearly haven't actually read the thread.

That was my whole argument.  For the _historical_ situation.

           Linus
