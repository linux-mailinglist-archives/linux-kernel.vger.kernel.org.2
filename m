Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32F543C18B3
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jul 2021 19:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230093AbhGHR47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jul 2021 13:56:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbhGHR47 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jul 2021 13:56:59 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30D3C061574
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jul 2021 10:54:15 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u25so3729786ljj.11
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jul 2021 10:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XLeTm8WzPVQ9Sr8q9zm+SAU9BBtPQLj8j1FfOLzDLnU=;
        b=RWOaueOJO5xvt4fqZzIPd4Vel/uolsuiKcXGz9lCbZXCGZdx75mRZ0KbrWjHv1wbvO
         Ee7a0KwDbarwAeTqGfaYMS+O1gmCILZ5WVudvXXm4HDhMDTyOvjWrP210JpM4MiBkldv
         6O/PGupcuvQ2VlXs6WJl8MLeFxAAWpVxEqIn+PAv/xNLVbAkaUqgfbGnwSzadMWiR6A3
         0vmxX+Xa3x617Bh9kGiGn/V7/JQDGzXcImELH9h6jlKfsXDPBLlG0Cc4kDOREqmMDWkm
         K0wQ+46ejU8BMlKFB/pIJ4U6eIXBj4yhXQoYMRCkiWMXZn/24EPbWGsTU9YJ8aqABiim
         peZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XLeTm8WzPVQ9Sr8q9zm+SAU9BBtPQLj8j1FfOLzDLnU=;
        b=eBTAztP4x3Ci5en1HLGdhRo6pOE1aE1lSZoI8qETsU/ENYQqRklN4B1fkYx+Tr1kIg
         1hfMkqTG+OtLr+rqr7SC/UwwwEFdQDCzEPvi7STakUClvoRBmvt/+A75KdW+mw4W4MZn
         eiKnVfFfXtw4pCKyiWU6QYEcrAuM+yPdRlVJl8VxBT5d2p2+YUKoHaOIolewB0Du4hTy
         bx+WvFyS/T9rxsCNR9gRVCUkP65i+ubSgRSO+vhycUf81PhLX7Qa6lHsSxDipazSQu5w
         pLibZjcgMcy+Kmsr62Sg4Mv9PeqDRmH/iR+m69hGtnCRVh0nRMYhqFR3/vFlTDEjfFTQ
         ysCQ==
X-Gm-Message-State: AOAM532ZQyI55e3wcaJeCvMd4s4n7RLs3xAC5YNK/lcouiP0PIBfLlmf
        DZrpV/EjwD+oN9jPb0NI5IEvt47vTFtNNM2yYa/X2g==
X-Google-Smtp-Source: ABdhPJz2JOrYrSVo4rsv90odW35rlCHUa8Twxs2mBeum/lwA3ehRSDUFBeGYRAAjkGEPJo8Fujsx5Ca8yTGdUYWsLhY=
X-Received: by 2002:a2e:9952:: with SMTP id r18mr3955699ljj.244.1625766853637;
 Thu, 08 Jul 2021 10:54:13 -0700 (PDT)
MIME-Version: 1.0
References: <20210623141854.GA32155@lst.de> <08df01d7683d$8f5b7b70$ae127250$@codeaurora.org>
 <CAK8P3a28_0KJpcLRQrDhFk8-ndxmfk7-Q2_qcRRiYkyh-NNZUQ@mail.gmail.com>
 <08e101d76842$94f78a60$bee69f20$@codeaurora.org> <20210623151746.GA4247@lst.de>
 <CAK8P3a2bG64ARjpwQ0ZhQ9P0g8B-=AwcHHAbYBXBS4B6Fy9pQw@mail.gmail.com>
 <YNQE0YJzC2xmWg+2@Ryzen-9-3900X.localdomain> <20210707141054.GA24828@lst.de>
 <1ee8fc44-3e8c-91c0-7909-a636757dbda4@kernel.org> <20210708052751.GA18789@lst.de>
In-Reply-To: <20210708052751.GA18789@lst.de>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Thu, 8 Jul 2021 10:54:03 -0700
Message-ID: <CAKwvOd=iRLQPum8-jaCG90TPyxDptNB31yRHMEWgSMxjv=KuHA@mail.gmail.com>
Subject: Re: how can we test the hexagon port in mainline
To:     Christoph Hellwig <hch@lst.de>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Brian Cain <bcain@codeaurora.org>,
        Sid Manning <sidneym@codeaurora.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 7, 2021 at 10:27 PM Christoph Hellwig <hch@lst.de> wrote:
>
> On Wed, Jul 07, 2021 at 10:42:27AM -0700, Nathan Chancellor wrote:
> >> hch@brick:~/work/linux$ make -j4 ARCH=hexagon
> >> CROSS_COMPILE=hexagon-unknown-linux-musl LLVM=1 LLVM_IAS=1 defconfig all
> >> HOSTCC  scripts/basic/fixdep
> >> clang: error while loading shared libraries: libtinfo.so.5: cannot open shared object file: No such file or directory
> >
> > Hmmm, is that with libtinfo5 installed (or whatever the ncurses-compat
> > equivalent is on your distribution installed)? I had that problem on Debian
> > until I insta
>
> I did install libtinfo5, which just gets me to the next error:
>
> hch@brick:~/work/linux$ export PATH=/opt/clang+llvm-12.0.0-cross-hexagon-unknown-linux-musl/x86_64-linux-gnu/bin/:$PATH
> hch@brick:~/work/linux$ make -j4 ARCH=hexagon CROSS_COMPILE=hexagon-unknown-linux-musl LLVM=1 LLVM_IAS=1 defconfig all
>   HOSTCC  scripts/basic/fixdep
> clang: error while loading shared libraries: libc++.so.1: cannot open shared object file: No such file or directory

^ Nathan did mention earlier in the thread that he "had to install
libtinfo5 and libc++1-7 on Debian Buster." Emphasis on the _and
libc++_ part.

I'm not sure if that binary distribution came with a libc++.so.1; if
so, that path needs to be specified via LD_LIBRARY_PATH so that the
runtime loader can find it.  Perhaps rpath wasn't set when the clang
binary was built.

We're looking into statically linked images of clang to prevent these
kinds of games.

> make[2]: *** [scripts/Makefile.host:95: scripts/basic/fixdep] Error 127
> make[1]: *** [Makefile:543: scripts_basic] Error 2
> make: *** [Makefile:346: __build_one_by_one] Error 2
>


-- 
Thanks,
~Nick Desaulniers
