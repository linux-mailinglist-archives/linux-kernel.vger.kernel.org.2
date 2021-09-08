Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C1E40325F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Sep 2021 03:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346987AbhIHBpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 21:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346864AbhIHBpM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 21:45:12 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25FFDC061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 18:44:05 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id p15so764365ljn.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 18:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LxLbN5oXo3pkASZMt7+BOQU43HJcJssxtcghQNdRrVo=;
        b=AvxEqZUbI6FOu7pL8djSL10B3yrzx6C1ITuJnwmqc68sRjbZt0UZcqj4OOhM/IN1fR
         mQG32bTk85V1KzAyt6/UfkczGxInrsiK0SxFntGyw21Fx6X9gUZPDg0Vkw6nUon4YkgN
         GbxPU6vAxh7JV7pXhTlUM8mduw1Pz4ptY22hI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LxLbN5oXo3pkASZMt7+BOQU43HJcJssxtcghQNdRrVo=;
        b=lCL4jlSZ0ZRTR034pCwPqKYtnMVmETHP0bAGaGCLKsswTsrqyi/QapMQYIHUQeiLUh
         1qscX+wM6ghsSz1pbV1UP563TcNoCAREs3dQrOwcvURpMjYUYMh1ggXrF1v4wNyYvE5N
         G5y1sz3Fy21bEzBq+bczMVXGXjzKYjbeHuW6A++DLebzSWp9YlSg+qGJStu+OUW0u99b
         8L4duqeFIoohB48/+C+UHcaVKSO0aK/TOp1KEu8XhvflJxnpaJa7bgWcmLs8b1RNGjW1
         TrjUcmsMkfI3u5S+oXNM9Nc7wmUGTRz6gbP7UD7PcYWVAF24MPUvrsG05O+4cxhIRPIc
         qqFQ==
X-Gm-Message-State: AOAM531UcXLaWpFM25BHoR568KGAG1NANi+5enqIOJg8MeQLsynUQ8Vb
        5uMlrCXNBIoDj99XMBP+zhvnl4qwDe4bYDaaXMA=
X-Google-Smtp-Source: ABdhPJxOUOkSg68LYmgyBMWDaueTKmRUr/u4anW6+b3z3QS2OTs3jKznYYdSGni9+Y4QPPjkKBpfDA==
X-Received: by 2002:a2e:9cd9:: with SMTP id g25mr847772ljj.346.1631065442912;
        Tue, 07 Sep 2021 18:44:02 -0700 (PDT)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id p3sm51285lfk.152.2021.09.07.18.44.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Sep 2021 18:44:02 -0700 (PDT)
Received: by mail-lf1-f41.google.com with SMTP id s10so1090500lfr.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 18:44:02 -0700 (PDT)
X-Received: by 2002:a05:6512:3987:: with SMTP id j7mr946864lfu.280.1631065441904;
 Tue, 07 Sep 2021 18:44:01 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYtFvJdtBknaDKR54HHMf4XsXKD4UD3qXkQ1KhgY19n3tw@mail.gmail.com>
 <CAHk-=wisUqoX5Njrnnpp0pDx+bxSAJdPxfgEUv82tZkvUqoN1w@mail.gmail.com>
 <CAHk-=whF9F89vsfH8E9TGc0tZA-yhzi2Di8wOtquNB5vRkFX5w@mail.gmail.com>
 <92c20b62-c4a7-8e63-4a94-76bdf6d9481e@kernel.org> <CAHk-=wiynwuneR4EbUNtd2_yNT_DR0VQhUF1QOZ352D-NOncjQ@mail.gmail.com>
 <a2c18c6b-ff13-a887-dd52-4f0aeeb25c27@kernel.org> <CAHk-=whcFKGyJOgmwJtWwDCP7VFPydnTtsvjPL6ZP6d6gTyPDQ@mail.gmail.com>
In-Reply-To: <CAHk-=whcFKGyJOgmwJtWwDCP7VFPydnTtsvjPL6ZP6d6gTyPDQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Sep 2021 18:43:46 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi+O66NwiiAYBeS6kiix6YGuDvPf-MPddtycE_D4fWV=g@mail.gmail.com>
Message-ID: <CAHk-=wi+O66NwiiAYBeS6kiix6YGuDvPf-MPddtycE_D4fWV=g@mail.gmail.com>
Subject: Re: ipv4/tcp.c:4234:1: error: the frame size of 1152 bytes is larger
 than 1024 bytes [-Werror=frame-larger-than=]
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Naresh Kamboju <naresh.kamboju@linaro.org>,
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
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 7, 2021 at 6:35 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I think a lot of them have just copied the x86 code (it was 4k long
> ago), without actually understanding all the details.

Just to put the x86 number in perspective: it was raised to 8192 back
in 2013, with the comment

    x86/cpu: Increase max CPU count to 8192

    The MAXSMP option is intended to enable silly large numbers of
    CPUs for testing purposes.  The current value of 4096 isn't very
    silly any longer as there are actual SGI machines that approach
    6096 CPUs when taking HT into account.

    Increase the value to a nice round 8192 to account for this and
    allow for short term future increases.

so on the x86 side, people have actually done these things.

Other architectures? I think some IBM power9 machines can hit 192
cores (with SMT4 - so NR_CPUS of 768), but I don't think there's been
an equivalent of an SGI for anything but x86.

But admittedly I haven't checked or followed those things. I could
easily imagine some boutique super-beefy setup.

               Linus
