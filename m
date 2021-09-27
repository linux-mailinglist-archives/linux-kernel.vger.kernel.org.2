Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F16F419EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 20:57:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236055AbhI0S6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 14:58:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:34098 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235865AbhI0S6l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 14:58:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DA51B60527;
        Mon, 27 Sep 2021 18:57:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632769022;
        bh=0IUh5DD7uaE9TA1cQVYxWpCGk4bOfaUc3i2Q4gWuwag=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qTScYm2AtCKCg5kSF1+n50tOdtygF3DhWbyWJ3DvM69Pfha2KC9TbjwrSyGH/3dD4
         lpCoGOgxBT4jR4RcITwrJobIIeXpDD2ZeY603g3syS+b5WfJYDF0VUUwdat9GByjmM
         xoRP86i4Yb1G2hVCRlwYphFkBzBtu9tS4WL2Pgq3jAIuzqFzQH6vM0r83RE7grNUGe
         gKjWMfvCdOe0NEMhY2PZwpA81iywKVCJBzbFqnCqrZ9uTn+PoTNoPoetzeWfn0emaC
         ptEclTdGtftvIav7xw3rDvKhrZvhTE+WMX0wP0bvlj6ip+loW/KDtdWnngPEYtkkUh
         sjEgQwbFKsRHw==
Received: by mail-ed1-f52.google.com with SMTP id g8so73176371edt.7;
        Mon, 27 Sep 2021 11:57:02 -0700 (PDT)
X-Gm-Message-State: AOAM533EeZscc8xTF3HfufMqeHd5s+pLJ+74Tntn+O2Zb0iNvHLlZqI+
        YPvXOaiHVM82hRjx9UvLS8RX5D2CGp7C1/dkeg==
X-Google-Smtp-Source: ABdhPJyp3lLByjYb5TyqzUQ1VEmLOlV7O6SJMgvgzDkLA441jZowf1Y/9WcphJORD+ZeLT9U6sbV+3PaMxBytbyZJvI=
X-Received: by 2002:a50:8285:: with SMTP id 5mr636042edg.318.1632769021432;
 Mon, 27 Sep 2021 11:57:01 -0700 (PDT)
MIME-Version: 1.0
References: <614ad319.1c69fb81.2a0c1.4782@mx.google.com> <8d6223d2-8ca7-0373-bb49-b62894e5fad7@collabora.com>
 <CAL_JsqJ9fDXkVgcXTiO+NM9T7OKO+p43NGmJPRvvLi3-_Bd4dQ@mail.gmail.com> <1e8409b3-0649-5d7c-da3f-911880b15c2e@collabora.com>
In-Reply-To: <1e8409b3-0649-5d7c-da3f-911880b15c2e@collabora.com>
From:   Rob Herring <robh@kernel.org>
Date:   Mon, 27 Sep 2021 13:56:49 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLc_O9sk4nTiofo4r+87wNeqCz_cNKHfiz=apCG-ziANQ@mail.gmail.com>
Message-ID: <CAL_JsqLc_O9sk4nTiofo4r+87wNeqCz_cNKHfiz=apCG-ziANQ@mail.gmail.com>
Subject: Re: next/master bisection: baseline.login on qemu_arm-vexpress-a9
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "kernelci-results@groups.io" <kernelci-results@groups.io>,
        devicetree@vger.kernel.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Liviu Dudau <liviu.dudau@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 27, 2021 at 11:15 AM Guillaume Tucker
<guillaume.tucker@collabora.com> wrote:
>
> On 24/09/2021 21:05, Rob Herring wrote:
> > On Thu, Sep 23, 2021 at 12:28 PM Guillaume Tucker
> > <guillaume.tucker@collabora.com> wrote:
> >>
> >> Hi Rob,
> >>
> >> Please see the bisection report below about a boot failure on ARM
> >> Versatile Express.
> >>
> >> Reports aren't automatically sent to the public while we're
> >> trialing new bisection features on kernelci.org but this one
> >> looks valid.
> >
> > Have you considered given you have the commit, if there's a Link tag,
> > sending this as a reply to the original patch? That would be a bit
> > easier to find IMO.
>
> Absolutely, in fact it's also possible to search in Lore for the
> original thread if there's no Link: trailer in the commit.  Then
> if subsequent bisections get run, the bot could reply to
> say "still failing" with new kernel revisions until it's fixed
> and then reply to confirm it is.  That's the plan, there's still
> a bit of work to do to have it all automated though.
>
> >> Some more details can be found here, for Cortex A9:
> >>
> >>   https://linux.kernelci.org/test/case/id/614c36cf0c427f123799a2db/
> >
> > I should have remembered there's a qemu model... Anyways, sending out
> > a fix in a moment.
> >
> > The log here was empty. Any reason 'earlycon' is not set here? I also
> > noticed stdout-path is not set on many of the Arm Ltd boards. I'll
> > send a patch for that, too. You really shouldn't have to set the
> > console on the cmdline nowadays unless you want the non-default.
>
> I believe earlycon is not set because it requires specific
> options on different platforms, so there's some configuration
> overhead involved here.  But it's a very good point that has been
> raised in the past, I guess someone needs to take the time to
> look into enabling it properly.  It shouldn't be that hard.

If the DT has stdout-path set, then all you need is just 'earlycon'
with no options.

Rob
