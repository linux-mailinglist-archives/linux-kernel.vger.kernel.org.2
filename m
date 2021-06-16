Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD2673A998B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 13:49:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232199AbhFPLvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 07:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbhFPLvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 07:51:43 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38CEC06175F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:49:37 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id x10so990708plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 04:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=WP4w1GpdYFm/lzVMj2S/oiM+wNAIY76Q4Vr8j4h2Ac8=;
        b=wa92YBrXbG86A9Z+067cELwEal7p07gTA7A7wsgnCbaOV0P4ed2S2onKpAtAa6YpoW
         Alrj7n+HHFlLh4cL0E/+vh6HaHfSTX2bVhimwLq3N+4ctPqCAHpFkwMqX9MfKwPLepi2
         N85/18jVLEznBvvqb78bkfmWMBfICgKqImLdL9QPFz2rkpym27NQHevR/NjGk8zwEna6
         QM9/KL4jOmdrxnmcHNNmLlLuC93GgJoyoCcEMQZTcd7xxhGFEIQ0/UQm1Jzn9+Z5XLEp
         YLIXvWj6DrJqOe4QCzTZ4zkbl7G2jU0Ez/9tYf25xw7D14jAR7EywGWy4PSJHgPhaoYK
         To4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WP4w1GpdYFm/lzVMj2S/oiM+wNAIY76Q4Vr8j4h2Ac8=;
        b=dlXtaoizkWIH5yhknUHkPMssmP2YmSHP/kWGr/QjL+IvwpunX2bxdig239IwyO8hU/
         59YyH3uJZptuRrCLuuV04NewCIryPz1z1EJ9PqAbeyrHtMYfRJB5c4Xs2v+DktbDyt9e
         ymh9mKxe4fLmaZay+IovQFWrocGnPdWUZY3C6PMYhuYxoNHUnrWuTsnbdM/vT/Wq0B+R
         HDGc3lfmHj/MEgqydF/1DKV0MsGtsvZADu0+J4hovL+faAfwQhRdVj0t4noIyE5qvWtS
         0GQvXpvRFUYdDBB2K/HGosnoZIqBLrFY31m9avbfftKyRewxDEhORoMZBu+RRrAw3pAH
         CGTQ==
X-Gm-Message-State: AOAM533ROfaLW/sAPi4lyDUlC56qRNbt35Ca5rEmbexfG4McCKagRk8Z
        jcvGlNNCAdYiCmeVNM1+oA53GQ==
X-Google-Smtp-Source: ABdhPJw89fpFAisJqm9uKcXQ4Bv9sFpHwtsFqHMJR6kj3kZ7z5t5WDsu0PQ7GzVDY+EnmIFrNn1Yqw==
X-Received: by 2002:a17:90a:5401:: with SMTP id z1mr4452275pjh.7.1623844177210;
        Wed, 16 Jun 2021 04:49:37 -0700 (PDT)
Received: from localhost ([136.185.134.182])
        by smtp.gmail.com with ESMTPSA id t14sm2541701pgm.9.2021.06.16.04.49.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 04:49:36 -0700 (PDT)
Date:   Wed, 16 Jun 2021 17:19:34 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     "Enrico Weigelt, metux IT consult" <info@metux.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        virtualization@lists.linux-foundation.org,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Bill Mills <bill.mills@linaro.org>,
        Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] drivers: gpio: add virtio-gpio guest driver
Message-ID: <20210616114934.n3grzuh6c64wlaj6@vireshk-i7>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbwLOOT6nuhpkT5x-AZVipsD2qG8Qu4xoiRotHQNknwzw@mail.gmail.com>
User-Agent: NeoMutt/20180716-391-311a52
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16-06-21, 10:31, Linus Walleij wrote:
> Hi Enrico,
> 
> On Tue, Jun 15, 2021 at 7:49 PM Enrico Weigelt, metux IT consult
> <info@metux.net> wrote:
> 
> > Introduce new GPIO driver for virtual GPIO devices via virtio.
> >
> > The driver implements the virtio-gpio protocol (ID 41), which can be
> > used by either VM guests (e.g. bridging virtual gpios from the guest
> > to real gpios in the host or attaching simulators for automatic
> > application testing), as well as virtio-gpio hardware devices.
> >
> > Signed-off-by: Enrico Weigelt, metux IT consult <info@metux.net>
> 
> So now there are two contesting patches for this and that creates a
> social problem for us as maintainers. I am not too happy about that.
> 
> This situation activates the kernel management style document so
> I advise involved parties to familiarize themselves with it:
> https://www.kernel.org/doc/html/latest/process/management-style.html
> 
> Can we get the discussion down to actual technical points?

+1

I can not agree more to this.

> We really need a virtio GPIO driver, no doubt, so if everyone could
> just work toward that goal and compromise with their specific pet
> peeves that would be great.

Enrico,

I am not looking to get any credits for the code or spec here. I don't
really care about that. For the very same reason I kept you as the
author of the 1st patch in the kernel series, so git keeps showing you
as the original author.

All I wanted to work on was the backend (in rust). This is what
happened for I2C for example, Jie Deng (Intel) worked on the spec and
Linux driver and I helped review it, make him fix a thing or two and
that's all. I worked on the rust implementation for the backend then.

You only ever sent 1 real versions of the Linux driver, that too
"6-months-back", there were no real blockers anywhere and you never
attempted to upstream anything.

Similarly, you "never" sent the specification properly to the virtio
lists for review. You sent it once as an attachment to an email, which
no one ever received.

When I tried to move this forward, invested a lot of time into making
it better from specification to code, reviews started happening, you
decided to start blocking it again.

You should be rather happy that something that you worked on is making
progress, specially when you didn't get time to do the same.

You wrote this in your patch:

> > Status:
> >     * this driver is now field tested for about 6 month
> >       (against KVM+Qemu as well as some HW/FPGA implementation)

Linux upstream doesn't really care about this, you can ask any Linux
Maintainer about this. If your code and specification isn't doing the
right thing, and isn't good enough, you will be asked to update it
upon reviews.

YOU JUST CAN'T SAY I WON'T because I have products based on this
version.

This is not how any open source project works. The code and
specification here doesn't belong to a single person or company. It is
for everyone's use.

> >     * virtio device ID officially allocated

Correct.

> >     * virtio spec has been submitted to virtio TC

Which specification are you talking about here ? The only
specification I can see on virtio lists is the one I sent.

And the driver you tried to send isn't aligned to that for sure, and
it takes us back from all the improvements I tried to do.

I am not saying that my version of the specification is the best and
there is no flaw in it. There surely is, but that can't be fixed by
sending another version of it. You need to make a technical point
about it and convince people that what you are saying is correct and
it is required for your use-case (not existing downstream solution).

There is no point going backwards now after making so much of
progress. Even if you try to send your version, it will slowly and
slowly reach very close to my latest version of code and spec. Because
your version of the code and spec weren't good enough for everyone. It
doesn't matter if you have real products on your earlier version, you
can keep using that in your downstream solution, but Linux kernel and
specification are going to get an improved version (from yours or
mine, but that doesn't matter here). You need to accept that changes
to that are inevitable since there are many users of gpio-virtio, not
just you and me, but many more (Like Bjorn expressed his interest in
this today for Qcom stuff).

Again, it would be better if you can discuss further on technical
merits or demerits in the currently circulated specification and give
your invaluable suggestions on the same.

Else we will end up spending few more months with just this and it
won't get us anywhere.

Thanks.

-- 
viresh
