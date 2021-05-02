Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13374370DD1
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 18:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232225AbhEBQNs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 12:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEBQNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 12:13:47 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C7F1C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 09:12:56 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id j10so4491159lfb.12
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 09:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Usk7p7YCU1vBMeOPVgazNjVtg7VUSQWrYhqaeUMFI/U=;
        b=Sg6Ao2UfrJlAg6hPnVATIxkfOlsNYq4zZfGmb1qdEzJHOFGh+hL1EqkB0kNDDA1PnW
         DZGFpZz4rZNIZaGP4eRpXrSY+/dDyJzTMH343BpjQX3JpTtphge+3M+5O+0FttPalZ6g
         0Q42EFjZ2aX2dtb41VLLrUzR5qzXSUmYaIe9Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Usk7p7YCU1vBMeOPVgazNjVtg7VUSQWrYhqaeUMFI/U=;
        b=AyzcBU8lGG2n66/kKeZokougjdOGfpnmDCNSm8BDD5L/rlnPxkKeWWXUHVvJsCcU+J
         OqJ+W5Y+r04cSPhMijAqpq11JRY2pU/0PdUYl5tBqpk3X+YNLnZpKuAKuLcnIjKmaus3
         SHa3PjlaEc+vioila+9rJE3cOOdW4+m/HkDsWN9xlry634g0kt6O5hXJXCi6nrfhla8t
         NqwwIToqP7odsfzmKmgDP5e78h9wPCuh+c1BLQQGT1vqNEJDCA7njtJIjJE8pbHZZkGu
         yAySke1SRzwumCpOb5EEA+XnTJW9Ucqj4qLylcmiiup9JPVUDmRVyT/KHQpBiirbnZRS
         3Kvw==
X-Gm-Message-State: AOAM530v8CfsSllJZaYQNVlEZyms7Kew/UBUiipfKcmT+tbD/g+PBQCS
        5QwGyDaBFz/JH7QZnJV+yxRU3J/D3SdBUv4+
X-Google-Smtp-Source: ABdhPJw3ZdiFiZjZQdjL+Bpb/ezlfp8MX0p5w79OCuDZgam15M05jKGa3YnnDEhtJAPonOnLJF/apA==
X-Received: by 2002:ac2:5979:: with SMTP id h25mr10382829lfp.297.1619971974426;
        Sun, 02 May 2021 09:12:54 -0700 (PDT)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id c13sm873061lfv.267.2021.05.02.09.12.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 May 2021 09:12:53 -0700 (PDT)
Received: by mail-lj1-f169.google.com with SMTP id u20so3962807lja.13
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 09:12:53 -0700 (PDT)
X-Received: by 2002:a2e:989a:: with SMTP id b26mr10420562ljj.465.1619971973167;
 Sun, 02 May 2021 09:12:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjmNOoX8iPtYsM8PVa+7DE1=5bv-XVe_egP0ZOiuT=7CQ@mail.gmail.com>
 <CAKwvOdmMF_v9TzBtFn2S1qSS_yCDO8D-u3WhBehUM7gzjcdjUQ@mail.gmail.com>
 <CAKwvOdk+V2dc31guafFM=N2ez4SrwCmah+mimUG3MzPMx_2efQ@mail.gmail.com>
 <CAKwvOdn3uXniVedgtpD8QFAd-hdVuVjGPa4-n0h64PTxT4XhWg@mail.gmail.com>
 <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com> <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <20210502093123.GC12293@localhost>
In-Reply-To: <20210502093123.GC12293@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 May 2021 09:12:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgdUMt_n84mq93LZKA6jOGqZpD+=KeVzA3YmvJ6=JPyhw@mail.gmail.com>
Message-ID: <CAHk-=wgdUMt_n84mq93LZKA6jOGqZpD+=KeVzA3YmvJ6=JPyhw@mail.gmail.com>
Subject: Re: Very slow clang kernel config ..
To:     Adrian Bunk <bunk@kernel.org>
Cc:     Tom Stellard <tstellar@redhat.com>,
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

On Sun, May 2, 2021 at 2:31 AM Adrian Bunk <bunk@kernel.org> wrote:
>
> The biggest advantage of shared libraries is that they enable
> distributions to provide security fixes.

Adrian - you're ignoring the real argument, to the point that the
above is basically a lie.

The argument was never that things like libc or the core GUI libraries
shouldn't be shared.

The argument was that the "one-off" libraries shouldn't be shared.

Things very much like libLLVM.so.

Or things like "libdivecomputer.so". You probably have never ever
heard of that library, have you? It's used by one single project, that
project isn't even in Fedora, but when we tried to make an rpm for it,
people complained because the Fedora rules said it needed to use
shared libraries.

So the whole notion that "shared libraries are good and required by
default" is pure and utter garbage. It's simply not true.

And no, it really didn't become any more true due to "security fixes".
Your argument is a red herring.

            Linus
