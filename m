Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5383D041F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 23:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229820AbhGTVO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 17:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbhGTVOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 17:14:18 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248BBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 14:54:56 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id d17so287999ljq.12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 14:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zMjMAmAMmxLkKR5KIrE39H+YkRtqEnHl/ne2WjpAkBU=;
        b=IAAqv6WWi0bCq9BdRpO54IgGQEqqW+iZuKmNQNeXPt7o3yRa20Xq4+PpqNjmyJqYP3
         a2wi9BHpUjnKnN6nxb+sSVMuSgnLHU5ILKHAkHZEFgBhW4lR0j7iV1+spwakKBGSnszc
         TiXcVTDpTSwrJ3G+KTaC9yqZBTVi4UgmOLAOE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zMjMAmAMmxLkKR5KIrE39H+YkRtqEnHl/ne2WjpAkBU=;
        b=mOqyJ7QRU0dMA4Fv0rKLKhcTcgF5GSIf7Nrr5jc7e3fJqePRINJ3y9X/odQjrogY+A
         W2iqIA/REHcdBFzT0d6dByAvxBMuMc+geqa+tWMOPrO/+zi17M1FbeGTo1yTUMD1jYcp
         YnJ16cU8aYBByNDcaNNPSuFCx7KknmRDhvLOsiJHtTZlVd6tlwihc8RT8GKZ/NE++AO9
         T0qvqttmgoZTgHfQxdBJtUdShmyFqMonyjtsE60x0hkonynVO9uLai/tthrqHEKOrYAs
         40GDoVv6os7QpDMey+4tzKkGWgALQASurSHV0aRGbC1q6rHx3p2VWGHXLJv2uW08AGsy
         JMGw==
X-Gm-Message-State: AOAM5311fdMN2g81A5/XApDzYjxQXnjAJgEVghV+Ao3r7Zew8Gm6XRuB
        /IG8peedRn0+ilBN0FyQJhFrBanMA5cPSOax
X-Google-Smtp-Source: ABdhPJwip2usIrBYCeQDTI6rofE+CeIldIGtxM+nctqOBUih5lL9oT+M2wk1BI6jfunz5MXndnsm4Q==
X-Received: by 2002:a2e:9c19:: with SMTP id s25mr29304967lji.478.1626818094004;
        Tue, 20 Jul 2021 14:54:54 -0700 (PDT)
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com. [209.85.167.47])
        by smtp.gmail.com with ESMTPSA id o7sm880815lfi.59.2021.07.20.14.54.52
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jul 2021 14:54:52 -0700 (PDT)
Received: by mail-lf1-f47.google.com with SMTP id y42so200660lfa.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 14:54:52 -0700 (PDT)
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr23066024lfl.41.1626818091856;
 Tue, 20 Jul 2021 14:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210708232522.3118208-1-ndesaulniers@google.com>
 <20210708232522.3118208-3-ndesaulniers@google.com> <CAK7LNARye5Opc0AdXpn+DHB7hTaphoRSCUWxJgXu+sjuNjWUCg@mail.gmail.com>
 <CAHk-=wgGxu4_hgzdYpFuKd95SfnkJbPTWAQ9-fMgmMN1Oxs2xQ@mail.gmail.com> <CAKwvOdkvju7heeNpk87brsjkhXHbdKFsUgf63KWhXox9rDkQsA@mail.gmail.com>
In-Reply-To: <CAKwvOdkvju7heeNpk87brsjkhXHbdKFsUgf63KWhXox9rDkQsA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 20 Jul 2021 14:54:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZe2FuiAOwhbKR_VMmFBKekz0NFREm4fvik25PEdcK_g@mail.gmail.com>
Message-ID: <CAHk-=wiZe2FuiAOwhbKR_VMmFBKekz0NFREm4fvik25PEdcK_g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] Makefile: infer CROSS_COMPILE from SRCARCH for
 LLVM=1 LLVM_IAS=1
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Fangrui Song <maskray@google.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Arnd Bergmann <arnd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@infradead.org>,
        Nathan Chancellor <nathan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 20, 2021 at 2:29 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> There's still some that we can eliminate for BOTH configure and actual
> build, like CROSS_COMPILE. :^)

I have this (perhaps odd) model where I use separate trees for
different things, which is something git obviously is partly designed
for.

So when I create a source tree, I usually create it for one particular
use - whether it be for one particular configuration (ie "build with
clang" or "set up a tree for a 32-bit cross compile" or whatever), or
whether it be for some particular development issue ("long-term branch
for testing asm goto with inputs").

Yeah, sometimes I use multiple git branches in the same tree for
things - but I tend to do that mainly for short-term things where I
don't expect to keep working on it over time.

End result: I find 'make' command line flags to be really really
annoying, because then I have to match them to whatever tree I'm in.

I'd much rather have a local per-tree configuration that just sticks
around. It's why ".config" works fairly well for me.

But there are other things that stick around. In particular, I have
considered simply using git config variables for that.

Something like this in the main Makefile:

    ARCH=$(shell git config build.arch)
    CC=$(shell git config --default=gcc build.cc)

would actually be optimal for what _I_ do. Then for my clang build tree, I'd do

    git config build.cc clang

and it would stick in that tree. If you don't set the option, it would use gcc.

Maybe that would be an acceptable model these days? We've used git
long enough that non-git worries aren't a big deal any more, and I
guess people could use the old-fashioned

    make CC=clang

if they don't use git.

We could get rid of all the CROSS_COMPILE etc garbage that way,
because you'd just set it in the .git/config file. Those are really
convenient and easy to edit.

Would people hate that kind of model?

                   Linus
