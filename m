Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DD2402149
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 00:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242171AbhIFW0O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Sep 2021 18:26:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242215AbhIFW0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Sep 2021 18:26:10 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A4FC06179A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Sep 2021 15:25:01 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id j12so13364368ljg.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 15:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=djkX2LEeT3p1G5IHevNmOqztMBJt0/G4rH/Ybx5oPXc=;
        b=D5wOQF1JFIwGSDN/Sb0iapcFbHL+lhF3tzSy9ZFGW3bv6GMHaFvDgFX4JLNGAakjXo
         dqIBpyrSiDU7hHebER8AWhG3rNllOoPtrVW0l0dbSzHNmizT1X+Wdyt8jpV4p65GcbHK
         ldnvLQtZ4dlaDVszjo7P3N48zYpV1BMBHKhjc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=djkX2LEeT3p1G5IHevNmOqztMBJt0/G4rH/Ybx5oPXc=;
        b=XKrGSAPpvpsaj0iVuHZ9LixchfiIXfHvKmCWTaFzfIRXyccla2aWwKTznmu19occ4J
         jxp3Z1Fd30XkrMwqbDz4afqCc0JtlrdUePYyr99BLdJ21zBZM13J29X5Xi/EM4jXBPX7
         C5dJEcR3UPxa7QxYfQNzO7FHPGVzTo6LB6zzTG0Fvpym5G1yjE+3NZpwVBIE8XiyBWlM
         6HI20W/kuiX9AmftWHPfoIvCOAy1T48xuCyffkZIJrwkvakeYBhqbgvsbT0L6qOP64ks
         Yj7eP5zlBqwrkl02jL0OH89WTQvauvLjt8xu+BsZ4j6YrfNP/nR9nFlAHcD6IieAAF7W
         dWLA==
X-Gm-Message-State: AOAM531AnbMwaeLqfzSx/dnqoZtlAJ5TydG8ugCaV97Mgj7YGVLSBZCF
        rTqkcWgqCre10stX5V/wIyaUlSHr4mnkx39C
X-Google-Smtp-Source: ABdhPJyO5VHtxvqO3Uiwrd27A4BVCgvG/M++Dlb6BxX5m/Tgc56vr/XnzigamJ1dkItgz5Dq06Mzsw==
X-Received: by 2002:a2e:960c:: with SMTP id v12mr13096646ljh.300.1630967099470;
        Mon, 06 Sep 2021 15:24:59 -0700 (PDT)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id y9sm1222601ljm.5.2021.09.06.15.24.57
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Sep 2021 15:24:58 -0700 (PDT)
Received: by mail-lf1-f53.google.com with SMTP id bq28so15705435lfb.7
        for <linux-kernel@vger.kernel.org>; Mon, 06 Sep 2021 15:24:57 -0700 (PDT)
X-Received: by 2002:a05:6512:34c3:: with SMTP id w3mr10565547lfr.173.1630967096954;
 Mon, 06 Sep 2021 15:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210904191531.GS1583@gate.crashing.org> <CAHk-=wjc1rxah3xt8mKN=aCxQigjy3-hEf4xh_Y-r=MXAKVrag@mail.gmail.com>
 <20210906154642.GV1583@gate.crashing.org> <CAHk-=wj=WpWO_V86cZH99LgZGBbvdDb4wR26ce5van0hJqjzLA@mail.gmail.com>
 <20210906172701.GX1583@gate.crashing.org> <CAHk-=wh0MBVfA89WLWnCiSnJ2a=hSAoSxfG-jyf7JJeBDPK3ew@mail.gmail.com>
 <87lf49wodu.fsf@oldenburg.str.redhat.com> <20210906194808.GY1583@gate.crashing.org>
 <20210906201432.GZ920497@tucnak> <CAHk-=wi80NGPppGmBpc5zuGRAsv4_7qsDu7ehW515J2FJoezAQ@mail.gmail.com>
 <20210906215218.GA920497@tucnak>
In-Reply-To: <20210906215218.GA920497@tucnak>
From:   Linus Torvalds <torvalds@linuxfoundation.org>
Date:   Mon, 6 Sep 2021 15:24:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKy45R2vMHhjr16_Q+iYea-70byuj=mHLvp1GURqdYPA@mail.gmail.com>
Message-ID: <CAHk-=wiKy45R2vMHhjr16_Q+iYea-70byuj=mHLvp1GURqdYPA@mail.gmail.com>
Subject: Re: [GIT PULL v2] Kbuild updates for v5.15-rc1
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Segher Boessenkool <segher@kernel.crashing.org>,
        Florian Weimer <fweimer@redhat.com>,
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

On Mon, Sep 6, 2021 at 2:52 PM Jakub Jelinek <jakub@redhat.com> wrote:
>
> It is actually not that bad, stdlib.h is indeed included there because of 2
> intrinsics out of more than 5000 and when one doesn't need those, just
> #define _MM_MALLOC_H_INCLUDED

.. and on clang?

In other words, your suggestion is unworkable, and actively works
against the whole point of "use standard headers". It's a joke. And
not in a good way.

There, I think you have to undefine __STDC_HOSTED__. Maybe by using
-ffreestanding?

Except if you use -ffreestanding, you lose some very bvasic
functionality (*), so we don't do that except for very special code
(our 16-bit realmode code does it, for example, and some very
low-level library implementations).

Just face the facts. Those header files weren't designed for the
kernel, and we've done all the special x86 FPU stuff using inline
asms.

Which is fine. But it all just proves your arguments about "you guys
have to use our header files" to be just a pipe dream, and not true.

The compiler header files may in some very limited situations be
usable. But in the general case? No.

And they should very much *not*at*all* be considered some kind of
sacred "this is the only way to do things". Because that is clearly
not true, and has *never* been true.

The usable header files are the odd special case, not the general case.

Really.

Is it really so hard to just admit that the kernel shouldn't use those
headers? When we have 30 years of experience in doing exactly that?

                  Linus

(*) iirc, with -ffreestanding gcc doesn't do all the basic memcpy()
optimizations. But I forget the exact details.
