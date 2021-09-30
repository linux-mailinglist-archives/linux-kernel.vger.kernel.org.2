Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA0641E228
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Sep 2021 21:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346146AbhI3TX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Sep 2021 15:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344294AbhI3TX4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Sep 2021 15:23:56 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF96DC06176A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 12:22:12 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 194so6904555qkj.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 12:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A/tuWyi96ya0DlbzWNr34/HVx+HP3Iol741vjN64iIc=;
        b=AnkZHp5Jxa0Wk/NFWfm8jROZ4vvwpLiSaBjXqAL2Oj1rT8lPI5/T+3P56rGO8gKyxc
         kvInbIhXASrI/xTvh9/fbw4QmCGU0MaFulfd4JkXMuFWPqLvO4VCU+udtyP9m4y21FSZ
         Rw2TC2kmSA+ecaVyQDNVXPE9k049LXNX+T1MU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A/tuWyi96ya0DlbzWNr34/HVx+HP3Iol741vjN64iIc=;
        b=cyg/frbMnWY4mplX4IY7L9FVi1sqbV+2q0tOwtehhfBIq+edzUj0On3mxxGnZ+Ijq4
         BHDS+fXGl2PGKOw6euGmXGZaY0go4E00rTZpZAsxsDkFS/dSkSj6R9YvSOWsnmJ6qGAd
         abJWmDu8AKuyS81hCbb/M26EcMR/opsaaIpLhFhUmN5uz4KEY+xAMZoRe9TdoczR4PtC
         k0e9B+R/N4mOQWk6nHqdleD5VqXGWcFplMzaKXbXLzQQ6DFAF0SzOlZxHlnDN1b6vCPZ
         rdkLZYKXFSwrz2tejSwfj9my8R4LvfiyT8J7t7yyt+QtENq+H/Tslx5D+ulYEslkpBWJ
         xuMg==
X-Gm-Message-State: AOAM532Buopi19MedvF3GduiB3GEFsvmdc22pVbDKJZPq1yai0m/5+3Y
        lDFGOT3D+JlPeGhUdalvibx51mKYhRDh6ZKwgyf/ew==
X-Google-Smtp-Source: ABdhPJx8uofsbPhEi0jcgcPhI3StEBoRMOS0qCtVKSUDYyZEeIY35vq1lDvQV6QCztBjA6Q2kl585g==
X-Received: by 2002:a37:9881:: with SMTP id a123mr6266592qke.486.1633029731757;
        Thu, 30 Sep 2021 12:22:11 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id v23sm1812039qkj.76.2021.09.30.12.22.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Sep 2021 12:22:10 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id u32so15573774ybd.9
        for <linux-kernel@vger.kernel.org>; Thu, 30 Sep 2021 12:22:10 -0700 (PDT)
X-Received: by 2002:a25:6b11:: with SMTP id g17mr1212374ybc.251.1633029729737;
 Thu, 30 Sep 2021 12:22:09 -0700 (PDT)
MIME-Version: 1.0
References: <20210929225850.3889950-1-ndesaulniers@google.com>
 <CAHk-=wh0BNEDz+uOdJWG8iW=n0PeOEjZpHyuSN2g0pKSCj+6iQ@mail.gmail.com>
 <CAKwvOdn-Z1q99zZW4GQ2aNnVMQ_JYuczrResTG7tvcfv0WLJ-w@mail.gmail.com> <CAHk-=wip2uVAaRtPNFF4+C2ZmkUZ+rs2-676syUR_kJ9+8hFNA@mail.gmail.com>
In-Reply-To: <CAHk-=wip2uVAaRtPNFF4+C2ZmkUZ+rs2-676syUR_kJ9+8hFNA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 30 Sep 2021 12:21:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wix+P0EtxFSEhmubWNZ++Qg1fj46e32uEKo+mzPu0jPAA@mail.gmail.com>
Message-ID: <CAHk-=wix+P0EtxFSEhmubWNZ++Qg1fj46e32uEKo+mzPu0jPAA@mail.gmail.com>
Subject: Re: [PATCH] modpost: add allow list for llvm IPSCCP
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:54 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Hmm. That's just a "bitmap_weight()", and that function in turn is
> __always_inline.
>
> And the *reason* it is __always_inline is that it really wants to act
> as a macro, and look at the second argument and do special things if
> it is a small constant value.

Looking around, it's not the only one. A lot of the bitmap functions
do that, but it looks like we're missing a few __always_inline cases.

I wonder if we should have a macro to generate those "do X or Y
depending on small_const_nbits()" - and have it generate
__always_inline functions.

Of course, some of those functions have more complex "check at build
time" cases, like that bitmap_clear/set() thing that has a special
case for when it just turns into "memset()"

We have a lot of these kinds of situations where we have a "generic"
function that specializes itself based on arguments. And yes, they are
often recursive, so that you need more than one level of inlining to
actually determine what the arguments are.

I don't know if we might have some way to mark these (and detect the
cases where they don't get inlined and we lose the vasy basic
optimizations).

It's kind of similar to the _Generic() thing that does different
things based on static types, it's just that it does it based on
argument ranges.

          Linus
