Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1D8311BD1
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 08:03:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhBFHBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 02:01:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbhBFHBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 02:01:34 -0500
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA028C06174A
        for <linux-kernel@vger.kernel.org>; Fri,  5 Feb 2021 23:00:54 -0800 (PST)
Received: by mail-io1-xd2e.google.com with SMTP id u20so9573792iot.9
        for <linux-kernel@vger.kernel.org>; Fri, 05 Feb 2021 23:00:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=94W66yNfADcpCIz3XFhMS2SehD6LivjDGMv4rmfjvf0=;
        b=OKm+7jApXvDcs+CQ6merc+dUjefVg0rIkk8f8fXGkGm0QgDx21WRwk8lZHmQRLv0Bw
         HpEcy+hkFv+XepRBD1J6oUAQvWvcBxj5oBnzJbo7V6U/jASWpAR3ACKpbdpi4HjBmSTM
         jsnnei/nQJLTUPSxSfTKi9tO5TP0JuemTRUiSAdsIKlGfMdNe6lIF2tJ6HHrKgI9beFT
         bR16oiU54o00rGIwSw8kYa4fbHZQpteF8suGo85KbzAQ25yiIsZFObTHUZD4P+dLnnei
         tU7Ic3s6L8HLCvk/XTWBSCbt4Iejvs5j40Pc1E53weHfffFPuPiUOHA6IGjvmuL8M3QK
         fuJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=94W66yNfADcpCIz3XFhMS2SehD6LivjDGMv4rmfjvf0=;
        b=HTTLJUceQ/h5jSdqS3/QC21UUjyOfh1HH2Kl4ZMIqldHgDOzvPlRUZv/a2eat+SdxW
         XBeWuHv7NiIFhcZ1KaKBIepcEdrCxxEz/2J7o7N1GYjI0R65BdE93tO44tyaZanxHMsG
         179cZK9ZCUDCoWLB8IelF9ja4eJiytfuzIbH8caTq5+/rreAwd2p9MkSDWGCfwE/uZev
         Me7jEpk/Tfdh3cnrQHRGE59d8SpEnFJBvqQhqVcqGD5YPsaDYx4whBeod6M7+nKYYUN/
         fbR65v3AFycXsypws3j/YyItIiU1Fqi8ZRYC+XkH6BxAT1Z5q6nO6qsuz1gkw7EmwJyf
         TYpA==
X-Gm-Message-State: AOAM533gRlYtcVa5eGi6FLcz3rBvlrbUjtzIkcRfzblk7nbML96AluqO
        A239ls4tvfZjgnBWPVFZ5uOnfiJfmy+8IFeh6NQ=
X-Google-Smtp-Source: ABdhPJwxBV6egt168+rKCJkiy9zSQMZJ2EdY8HqTHq1Tbh+bLQaVuNIig7iTHVKhDD5aWFYokDvCgkjKX60JUaRkd+4=
X-Received: by 2002:a05:6602:1541:: with SMTP id h1mr7108026iow.171.1612594854157;
 Fri, 05 Feb 2021 23:00:54 -0800 (PST)
MIME-Version: 1.0
References: <20210126212730.2097108-1-nathan@kernel.org> <CAKXUXMwErhv-vt1LC6a79yJ2oukDkPa1BnijDXpdwYu1RK3z=A@mail.gmail.com>
 <CA+icZUXeVYFJx_McagTz433GjgnvuLKOdtx1Nkit9huWevP-Rw@mail.gmail.com>
In-Reply-To: <CA+icZUXeVYFJx_McagTz433GjgnvuLKOdtx1Nkit9huWevP-Rw@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Sat, 6 Feb 2021 08:00:43 +0100
Message-ID: <CA+icZUVVuB+YMSV6xyBUFBMJyLs5WALRJ14o5idFA1wtg1SwZQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS/.mailmap: Use my @kernel.org address
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 27, 2021 at 7:48 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>
> On Wed, Jan 27, 2021 at 6:07 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
> >
> > On Tue, Jan 26, 2021 at 10:27 PM Nathan Chancellor <nathan@kernel.org> wrote:
> > >
> > > Use my @kernel.org for all points of contact so that I am always
> > > accessible.
> > >
> > > Signed-off-by: Nathan Chancellor <nathan@kernel.org>
> >
> > Congrats, Nathan. You deserve it for all the warning fixes, reports,
> > maintenance, CI, reviews and much more stuff you are doing.
> >
>
> +1
>
> Congrats Nathan.
>

ministerial: https://git.kernel.org/linus/654eb3f2a009af1fc64b10442e559e0d1e50904a

- sed@ -
