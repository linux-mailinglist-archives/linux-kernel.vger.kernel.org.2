Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C0D370E52
	for <lists+linux-kernel@lfdr.de>; Sun,  2 May 2021 19:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhEBSAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 May 2021 14:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230110AbhEBSAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 May 2021 14:00:20 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FE4C06174A
        for <linux-kernel@vger.kernel.org>; Sun,  2 May 2021 10:59:28 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id s9so4195499ljj.6
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 10:59:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0+2IqC1NfiFUmwmucN3Vw1P1FIIB9EUQ8fTZ/TGu//I=;
        b=bvEm7xjcECXTv0folw3a3V4PhIfgy6mgkIjsICl0XT1sUZP48ohOLCXcO+TTnq1tD0
         K58HZZ9EvvOkvX5VPiJMDdDVgl36ZTG+Y+UHuMDQjmtKiThKs8eiYOWVRCdfz1HEYQRq
         SPovD1KL2DHgGu0HEWgm/TcSHRgXY7+kHIWM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0+2IqC1NfiFUmwmucN3Vw1P1FIIB9EUQ8fTZ/TGu//I=;
        b=YeMQDp4/tMeIlwulhLwd4VAhIZgTVCz9jHJxAZ+iAyVtGRfWT8ro1BlOIJzreBvM09
         8P2tXvHPaf6WA38bEyy0T4tnxa3hgY4TN5ywNy38efPXJ7SIN0Pd4Ffit07hpS17Nwov
         S7hyhosHvc0dnaRefiWz1mZag76R3dzLYqv3ELUZoDNN932ofTaurgTyWTL/rvHbKEPj
         UWkQVz1e/1ZVCKZTa/aSbDfLiRFfA6N3xp/MieDC1b95oOW1nuHFgoJ8gilQoiNISUn/
         4NA9KuwpEjZ2xuA+mKI5BI55sFLVXdqUEP1LmrerNiK7UfzLtcbugiUpG4Ec8W/4mSTV
         5zUQ==
X-Gm-Message-State: AOAM532LEGgvG2zrqhHuqiri2AotoRJVSVHE+qkAiv1Z0fxDW8c8k2rU
        PUa9K2/ZXpkjwyU2OZraWAb2O/X5ZBjmOkb0
X-Google-Smtp-Source: ABdhPJwvTMLiPSEmM/GVw7j85x4QWeU/RHS6xMg4s+dA9fgf0GENpTfdJAS52q30WBGW/XBgENbr8Q==
X-Received: by 2002:a2e:6e03:: with SMTP id j3mr10623023ljc.218.1619978366959;
        Sun, 02 May 2021 10:59:26 -0700 (PDT)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com. [209.85.167.48])
        by smtp.gmail.com with ESMTPSA id i14sm897948lfe.195.2021.05.02.10.59.26
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 May 2021 10:59:26 -0700 (PDT)
Received: by mail-lf1-f48.google.com with SMTP id j4so4823733lfp.0
        for <linux-kernel@vger.kernel.org>; Sun, 02 May 2021 10:59:26 -0700 (PDT)
X-Received: by 2002:a05:6512:3763:: with SMTP id z3mr10113824lft.487.1619978365953;
 Sun, 02 May 2021 10:59:25 -0700 (PDT)
MIME-Version: 1.0
References: <CAKwvOdm3D=dqKw=kx46PLaiqfHOZJL3QFKGc8kxqJqpwdFFWqw@mail.gmail.com>
 <CAKwvOdkp_P8BCtFuKqDrtC_=A89ZfDf66Yr3FL2e=ojwv4KaMA@mail.gmail.com>
 <CAHk-=wi1yiBBr3b3RbCEte6-yzAApsZN5zRdr3xoW8Av9jOX=Q@mail.gmail.com>
 <CAKwvOdk0nxxUATg2jEKgx4HutXCMXcW92SX3DT+uCTgqBwQHBg@mail.gmail.com>
 <1c5e05fa-a246-9456-ff4e-287960acb18c@redhat.com> <CAHk-=whs8QZf3YnifdLv57+FhBi5_WeNTG1B-suOES=RcUSmQg@mail.gmail.com>
 <20210502093123.GC12293@localhost> <CAHk-=wgdUMt_n84mq93LZKA6jOGqZpD+=KeVzA3YmvJ6=JPyhw@mail.gmail.com>
 <20210502164542.GA4522@localhost> <CAHk-=winSraiwc4gC5WFWSehFq+s7AqCJZoMqUuHLX0nYVG0nQ@mail.gmail.com>
 <20210502175510.GB4522@localhost>
In-Reply-To: <20210502175510.GB4522@localhost>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 2 May 2021 10:59:10 -0700
X-Gmail-Original-Message-ID: <CAHk-=whTjJwCt2E0_JM2dDq=+UybvJN7QK+6K6e80A9Zd8duYg@mail.gmail.com>
Message-ID: <CAHk-=whTjJwCt2E0_JM2dDq=+UybvJN7QK+6K6e80A9Zd8duYg@mail.gmail.com>
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

On Sun, May 2, 2021 at 10:55 AM Adrian Bunk <bunk@kernel.org> wrote:
>
> Are you happy about libclang.so being a shared library?

Honestly, considering how I don't have any other package that I care
about than clang itself, and how this seems to be a *huge* performance
problem, then no.

But you are still entirely avoiding the real issue: the Fedora rule
that everything should be a shared library is simply bogus.

Even if the llvm/clang maintainers decide that that is what they want,
I know for a fact that that rule is completely the wrong thing in
other situations where people did *not* want that.

Can you please stop dancing around that issue, and just admit that the
whole "you should always use shared libraries" is simply WRONG.

Shared libraries really can have huge downsides, and the blind "shared
libraries are good" standpoint is just wrong.

          Linus
