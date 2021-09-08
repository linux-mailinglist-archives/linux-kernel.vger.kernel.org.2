Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF32E40410D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Sep 2021 00:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbhIHWgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Sep 2021 18:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbhIHWgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Sep 2021 18:36:38 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB59C061575
        for <linux-kernel@vger.kernel.org>; Wed,  8 Sep 2021 15:35:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id m4so6040780ljq.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 15:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HytL3xsN3IMbAtrWbKtS0/nCsgiMyvgWe9lZNEOySKA=;
        b=SJXzuSl05zhxWmOOxzrxPh7OyWUCJWmBdrtaUM4PikTlgdmjLPd/RVuMt8u2D9I6bT
         RMeoTQySffZUogvn6gYJOWzzTpsd+b3QH+x/GYCf4BNoTJcqc/2dIJ2d8ypfcYppmk5I
         6Ere6VJaPGXH1QOd5jA2MTtAJ9xImqzIFObv8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HytL3xsN3IMbAtrWbKtS0/nCsgiMyvgWe9lZNEOySKA=;
        b=Qs5aUEqcXLkjGhfQbNwMkV7qdg4LKd8u4Yw09ic46AVoNXZj5ofzXacKZZYaY5U0mP
         CptiYzW9Vxe/u7mzB+W+08V/rjAgdsdLl5HZa01X2u2wNa96jnnyErchBZ0rKOaNGR0x
         /xJwlsKakpRvQouqU9XdbTMCef2hXL/RpsH/eaehhE9luU4VqEY4puLkUaj2uGrBcPDr
         XR8iIOb3h8P875b0Ef7pGWRLN1tmSxuK0pk3hJRUefenoGoJlbojLjv1lihiTCia0ZQb
         g/VSZVKbNKk4jcYPDB2b6yTjn3hS16B9/6HQhaZxY+LX5vIsnJ5QFRsXQMovQpSjkVnE
         SWWQ==
X-Gm-Message-State: AOAM530CpLCBPrkwPjrH7RlMGIM0SoIv3rgnJV3COoWppp2oWjnuallU
        zEnWjalFcm7pzPBlLHyKbJs8zcpaWqFUGvtYuNM=
X-Google-Smtp-Source: ABdhPJz1PmZfSIFor+TN9Np2MT0xIMgNukcfR/W51r1HHRYsGHFWxHxI5uDtxLxtoUteZHal6x9s5w==
X-Received: by 2002:a2e:9205:: with SMTP id k5mr486058ljg.26.1631140528466;
        Wed, 08 Sep 2021 15:35:28 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id b17sm38966ljj.35.2021.09.08.15.35.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Sep 2021 15:35:28 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id s10so7435358lfr.11
        for <linux-kernel@vger.kernel.org>; Wed, 08 Sep 2021 15:35:28 -0700 (PDT)
X-Received: by 2002:a2e:a7d0:: with SMTP id x16mr441752ljp.494.1631140088653;
 Wed, 08 Sep 2021 15:28:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtFvJdtBknaDKR54HHMf4XsXKD4UD3qXkQ1KhgY19n3tw@mail.gmail.com>
 <CAHk-=wisUqoX5Njrnnpp0pDx+bxSAJdPxfgEUv82tZkvUqoN1w@mail.gmail.com>
 <CAHk-=whF9F89vsfH8E9TGc0tZA-yhzi2Di8wOtquNB5vRkFX5w@mail.gmail.com>
 <36aa5cb7-e3d6-33cb-9ac6-c9ff1169d711@linuxfoundation.org>
 <CAK8P3a1vNx1s-tcjtu6VDxak4NHyztF0XZGe3wOrNbigx1f4tw@mail.gmail.com>
 <120389b9-f90b-0fa3-21d5-1f789b4c984d@linuxfoundation.org> <CAFd5g47MgGCoenw08hehegstQSujT7AwksQkxA7mQgKhChimNw@mail.gmail.com>
In-Reply-To: <CAFd5g47MgGCoenw08hehegstQSujT7AwksQkxA7mQgKhChimNw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 Sep 2021 15:27:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiQoxwGkMF34k3twte0N2phNCjbxtsgoW9YNybVPXZtsA@mail.gmail.com>
Message-ID: <CAHk-=wiQoxwGkMF34k3twte0N2phNCjbxtsgoW9YNybVPXZtsA@mail.gmail.com>
Subject: Re: ipv4/tcp.c:4234:1: error: the frame size of 1152 bytes is larger
 than 1024 bytes [-Werror=frame-larger-than=]
To:     Brendan Higgins <brendanhiggins@google.com>
Cc:     Shuah Khan <skhan@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Ariel Elior <aelior@marvell.com>,
        GR-everest-linux-l2@marvell.com, Wei Liu <wei.liu@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, lkft-triage@lists.linaro.org,
        "David S. Miller" <davem@davemloft.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        KUnit Development <kunit-dev@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 8, 2021 at 2:25 PM Brendan Higgins
<brendanhiggins@google.com> wrote:
>
> I definitely agree that in the cases where KUnit is not actually
> contributing to blowing the stack - struct leak just thinks it is,
> this is fine; however, it sounds like Linus' concerns with KUnit's
> macros go deeper than this.

I don't mind Kunit tests when they don't cause problems, but one very
natural way to use the Kunit test infrastructure does seem to be to
just put a lot of them into one function.

And then the individually fairly small structures just add up.
Probably mainly in some special configurations (ie together with
CONFIG_KASAN_STACK as pointed out by Arnd, but there might be other
cases that cause that issue too) where the compiler then doesn't merge
stack slots.

I wonder if those 'kunit_assert' structures could be split into two:
one part that could be 'static const', and at least shrink the dynamic
stack use that way. Because at a minimun, things like
type/file/line/format-msg seem to be things that really are just
static and const.

Hmm?

          Linus
