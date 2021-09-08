Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2791403CD0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 17:49:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349682AbhIHPuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 11:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349633AbhIHPuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 11:50:11 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACCE6C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 08:49:03 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id j12so4273662ljg.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 08:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PcF296h2+jiTZRH7itaWnGkrpPXNXdTwX29k3fuQ+jc=;
        b=ZwCRqKII+z7vKEvFb10WpEzrknavJ+xY91cakvNMvB12ilS1ZXGEroVoZGRbTsMeHX
         r2zn5SfzXpbQBiUmBwz5flemzUgkqkyaVzmRA0zAl11PDMt+Eapr9rFmLWA3oZAESpPQ
         tpmQ6lADbmqWjIXc3iG+eXb+QhwWpsNLgETq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PcF296h2+jiTZRH7itaWnGkrpPXNXdTwX29k3fuQ+jc=;
        b=nKpTwGTOiDYqB71dfBIGXOpCPI5xuNu23joVvJJtmU8yCjc5VI6GmI2AEWGnfL6PjH
         HvMTFueC8dXSJ4DJQDZJvDyphR388kRj9RZNhRtRBttst2nqTBsCkIpgkD63jDNLQH7w
         7Um7QMe3C3U+Xv4s9UJSBobtmeI1MDp6fcdbOqK7x7V7hpFHhUjZMQVb0z9sv60eFAl8
         qfVW9z/sFxHfFbA1Q2xH1qemLgJOSh/fFhJgn0TjQ/IhAbfkPNV2FEpxRJJmKvyUfsnM
         puNDU+wKSzIiASy3pnfj+lz1jQBjk6uo6JU1jXRt5NEqebotiHqFOYf5U8SxVM+3gZ/a
         RoTA==
X-Gm-Message-State: AOAM533eVbren3F8EDT5BK66IFauEnXNvZGDMMMxSmBFik2RUqJ428V0
        tx5UZlwV3Bcaq89Dbwhxb0KEJVWJr5EL6Xk5l8I=
X-Google-Smtp-Source: ABdhPJxvtoibMycYb48izPkqkHcRCb0XnCE9Cnn6ifEabW0xp48JXwDyfqBs0jEjHeFMY9WrAM4fGg==
X-Received: by 2002:a2e:8795:: with SMTP id n21mr3536176lji.474.1631116141586;
        Wed, 08 Sep 2021 08:49:01 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id a16sm277306ljq.22.2021.09.08.08.48.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 08:48:58 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id k4so5785118lfj.7
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 08:48:58 -0700 (PDT)
X-Received: by 2002:a05:6512:114c:: with SMTP id m12mr3186957lfg.150.1631116138014;
 Wed, 08 Sep 2021 08:48:58 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtFvJdtBknaDKR54HHMf4XsXKD4UD3qXkQ1KhgY19n3tw@mail.gmail.com>
 <CAHk-=wisUqoX5Njrnnpp0pDx+bxSAJdPxfgEUv82tZkvUqoN1w@mail.gmail.com>
 <CAHk-=whF9F89vsfH8E9TGc0tZA-yhzi2Di8wOtquNB5vRkFX5w@mail.gmail.com>
 <53ce8db-3372-b5e2-cee7-c0ebe9c45a9@tarent.de> <CANn89iJzyPbR-fS8S_oAMSJzUGTHAfx49CXVc6ZSckUk91Opvg@mail.gmail.com>
In-Reply-To: <CANn89iJzyPbR-fS8S_oAMSJzUGTHAfx49CXVc6ZSckUk91Opvg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Sep 2021 08:48:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whkOK2DTHMt1rQ7wCBCqW=itkihpQBcZ=T6vrciEE4ycA@mail.gmail.com>
Message-ID: <CAHk-=whkOK2DTHMt1rQ7wCBCqW=itkihpQBcZ=T6vrciEE4ycA@mail.gmail.com>
Subject: Re: ipv4/tcp.c:4234:1: error: the frame size of 1152 bytes is larger
 than 1024 bytes [-Werror=frame-larger-than=]
To:     Eric Dumazet <edumazet@google.com>
Cc:     Thorsten Glaser <t.glaser@tarent.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        Ariel Elior <aelior@marvell.com>,
        GR-everest-linux-l2@marvell.com, Wei Liu <wei.liu@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 7:50 AM Eric Dumazet <edumazet@google.com> wrote:
>
> At least on my builds,  do_tcp_getsockopt() uses less than 512 bytes of stack.
>
> Probably because tcp_zerocopy_receive() is _not_ inlined, by pure luck
> I suppose.
>
> Perhaps we should use noinline_for_stack here.

I agree that that is likely a good idea, but I also suspect that the
stack growth may be related to other issues. So it being less than 512
bytes for you may be related to other random noise than inlining.

In the past I've seen at least two patterns

 (a) not merging stack slots at all

 (b) some odd "pattern allocator" problems, where I think gcc ended up
re-using previous stack slots if they were the right size, but failing
when previous allocations were fragmented

that (a) thing is what -fconserve-stack is all about, and we also used
to have (iirc) -fno-defer-pop to avoid having function call argument
stacks stick around.

And (b) is one of those "random allocation pattern" things, which
depends on the phase of the moon, where gcc ends up treating the stack
frame as a series of fixed-size allocations, but isn't very smart
about it. Even if some allocations got free'd, they might be
surrounded by oithers that didn't, and then gcc wouldn't re-use them
if there's a bigger allocation afterwards. And similarly, I don't
think gcc ever even joins together two free'd stack frame allocations.

I also wouldn't be surprised at all if some of our hardening flags
ended up causing the stack frame reuse to entirely fail. IOW, I could
easily see things like INIT_STACK_ALL_ZERO might cause the compiler to
initialize all the stack frame allocations "early", so that their
lifetimes all overlap.

So it could easily be about very subtle and random code generation
choices that just change the order of allocation. A spill in the wrong
place, things like that.

Or it could be about not-so-subtle big config option things.

          Linus
