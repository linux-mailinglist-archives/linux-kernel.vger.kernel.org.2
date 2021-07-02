Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A77A43B9F04
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jul 2021 12:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhGBKVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jul 2021 06:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231912AbhGBKVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jul 2021 06:21:09 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8089C0613E2
        for <linux-kernel@vger.kernel.org>; Fri,  2 Jul 2021 03:18:25 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id f13so12598503ljp.10
        for <linux-kernel@vger.kernel.org>; Fri, 02 Jul 2021 03:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dyD/pAf7kMsskV0+zA8WGcmiKArOOY/L95px7mtP6FU=;
        b=AhBwhdH7CNdLp1cE+ZhUB0DHi6mDv6VbpKXfLf4JvzWmmfYm/TI+2bw7U+LgyXu1wc
         6awmzYWKIb3DjOoRxYQM8VcvYywiy0Q7RHU01UIqTMSY+ygRMPsoxgsOnJOtOXdShstX
         1zZBqkrB6qvf3qcm9nd7kYWhU0mArnuU/g/C/ZcM2tn4Oy6w4ikH50YCjHM9jegKoC8I
         mp2vL2Jb7fVnKo98AOjEuf/VLymjk1spwwIxn+wOCy8xCwooYzBHtOUh+GKs7fkMDMLx
         HhdtZl2yQo8xkywXWNG66ckluOxJfxItb3exIXQXgsnEWRqQUu/KhQXqPNui7nhKKt/g
         FDPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dyD/pAf7kMsskV0+zA8WGcmiKArOOY/L95px7mtP6FU=;
        b=pxImRUg2ZeysRjISI9Syj43fInMzrvPKcmwG1yfd81fJqXG/eV2wQ8Ls2CQer/Ndvy
         tVV3+2KprzZEfzVBjDcUqdqQbs2pgO/oBtJNdmgFWP0//rNa5bSz3ZRTA5vxXBVqpaqp
         0I0OcpCGDihYziXXYjOa4I/ZAKLMsKix5BASVGzFV2dgZYiK7qYH19sshcYklbnLFUW3
         nfEny7vIJtoTunfi/33asB7EAjQGEOE7nfLD8KDRHCLw3OCpmfbAO1iBQhJ/cAVq9g1x
         Us/UdLsg+JNVNhG4UUJxbBld+gWCYaSazuaSmGFVfQ1y+qMMEUJXnU7KrN+fGO+5/fRF
         op/Q==
X-Gm-Message-State: AOAM530fewKWt3HHMnFrJ5IZVH4qcYIBJvjTs7+5crQCrcVPACyn5SCs
        Pb2A2O9o84CpBn2PdYFPqGTalw4UdkRyYZjV5Oeqog==
X-Google-Smtp-Source: ABdhPJxJwAm3vVzfjzWiRoBftL1vkTAUPI5KsG9DWqGQsRitA3QyWIgy2zE6ZZFfiy0+Z04wuXVO7relnVrlbydSJHQ=
X-Received: by 2002:a2e:9d15:: with SMTP id t21mr3274629lji.200.1625221103869;
 Fri, 02 Jul 2021 03:18:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210626161819.30508-1-sergio.paracuellos@gmail.com>
 <CAHp75VfM-35tQMRh98mtg2XmDOJFnmjdYRKZZoi9ADm=AT2xUw@mail.gmail.com>
 <CAMhs-H_fcNDAOHm=tZB4ku9fzeea_7f4ZLg7w5KEmcNu+8wbQQ@mail.gmail.com>
 <CAHp75VeN+vww=Bj=g-nx9AT0FKSGAZ8CKQZn=ff2kfQWM+dxdw@mail.gmail.com>
 <CAMhs-H-WwCfPDspgxzN=W8QouZ7WPAeyJDYf_6=YezyCkTM=Vw@mail.gmail.com>
 <CAHp75VcF-HDZ6mKvXT=zYnBrcPaNJ+SYJ72LQ7s-62zQ5ZqoQg@mail.gmail.com>
 <CAMhs-H9gw63j98vVo3y0ymW4_6rFNL8u5cYNM2hzyrmkPB3h3w@mail.gmail.com>
 <CAHp75VccSCWa=EH8i01_b_HLZRumUZ48oRjeuaV5Dp1BQAoz2w@mail.gmail.com> <CAMhs-H_Ne4W79Awbmo6w_68X+h0-ybjvzNsbh=XuHMPJJ8-hDQ@mail.gmail.com>
In-Reply-To: <CAMhs-H_Ne4W79Awbmo6w_68X+h0-ybjvzNsbh=XuHMPJJ8-hDQ@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 2 Jul 2021 12:18:12 +0200
Message-ID: <CACRpkdaqSoyDUn3dVuVgzRK_7AabdY=1FzAnhHZzPs3qS+GfsA@mail.gmail.com>
Subject: Re: [PATCH v2] gpio: mt7621: support gpio-line-names property
To:     Sergio Paracuellos <sergio.paracuellos@gmail.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Thomson <git@johnthomson.fastmail.com.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NeilBrown <neil@brown.name>,
        =?UTF-8?Q?Ren=C3=A9_van_Dorst?= <opensource@vdorst.com>,
        Nicholas Mc Guire <hofrat@osadl.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 2, 2021 at 11:40 AM Sergio Paracuellos
<sergio.paracuellos@gmail.com> wrote:
> On Fri, Jul 2, 2021 at 11:27 AM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:

> > > There are no child nodes, all the stuff is in the same parent node
> > > and, as I said, belongs to the same device but internally uses three
> > > gpiochips.
> >
> > And it can't be split into three children in the overlay?
>
> Original code before this being mainlined was using three children and
> I was told in the review that three children were not allowed:
>
> See https://patchwork.ozlabs.org/project/linux-gpio/patch/1527924610-13135-3-git-send-email-sergio.paracuellos@gmail.com/#1932827

Yeah this is one of those unfortunate cases where the DT representation
(or ACPI for that matter) of the device and the Linux internal representation
differs.

> > Let's assume it can't, then the GPIO library function should be
> > refactored in a way that it takes parameters like base index for the
> > names and tries to satisfy the caller.
>
> Bartosz, Linus, any thoughts on this?

This would be ideal, is there a reasonably simple way to get to this helper?

In gpiolib.c devprop_gpiochip_set_names() need to be refactored to
take a base number, devprop_gpiochip_set_names_base() that
function exposed in <linux/gpio/driver.h> and then the old function
devprop_gpiochip_set_names() wrapped in the new
one so all old users continue to work without modification.
Sprinkle some kerneldoc on top so we do not make mistakes
in the future.

This should work I think.

Any similar drivers (several gpio_chip per FW node) that want to
set line names need to do the same thing.

Sorry that you ran into this, I hate it when I'm first at hairy stuff
like this.

Yours,
Linus Walleij
