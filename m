Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525C13339D0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Mar 2021 11:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbhCJKT1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Mar 2021 05:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhCJKTG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Mar 2021 05:19:06 -0500
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643F0C06174A
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 02:19:04 -0800 (PST)
Received: by mail-qv1-xf36.google.com with SMTP id h13so469402qvu.6
        for <linux-kernel@vger.kernel.org>; Wed, 10 Mar 2021 02:19:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=edRCQjcETTP/TwhrCwOF/p03cqo8+OKWF6FKVjUQ7d4=;
        b=c3crVqzdqxMSrxomGmHwHFysts3ulWh8YjOvMWfaUXzm7Gydu3akwB2gOVltT7ubTS
         KxQsZrGwUaWV6Tn3Khh73cDc9/3JEReNpQ9I9e4qgpJhg97s1eOef5pkWzC+ez/Y68vk
         lMpUNacccaIXGt+4AIXQwLCOF3rqWFcaiFOiE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=edRCQjcETTP/TwhrCwOF/p03cqo8+OKWF6FKVjUQ7d4=;
        b=gwsXA2P3liRTPSEGZN2dRtj5ftL9uCwFjfYcwk1mjhslFr7IiS+SUydSDmDQpeAxmu
         LJkxRYmVwXZ5++VOpn0rrHgBxcL2KGhGf26XctjakXU3vXRnLTnXT70AvVesiVKHQqOu
         RJq5YEV5RkgVpFWC12ET0rhbsrXBt48iKCD5RTfCC9Ft8gKg8tdxueXgeERFOnRgmbT2
         75XeIlwEuQVTaAS4O/oPx/unkXnRAI8z0aE3bk/+5+nISlF+6wUTgcgDNtRNdWtIsT+L
         ubWMJVUauah3rc8zlpD5SoaozSxLTt7B2Hg3YTEvMbi8/S4gCC+r6wPack/9yHXdomew
         R+rQ==
X-Gm-Message-State: AOAM531TpNLMcDUCRNB0cZm/7lMB1W0hAuZ/l0qp+wR3wD1rl+ILgcVd
        Jv1IGECeB1NGIR94nZ6xA2WmFpX15ok2/Og21Mi27w==
X-Google-Smtp-Source: ABdhPJzdKOttsDe74X8zHeSQeexRf8gAvLRVRhYolkg8sTzVUlsHbPT/T4hahLzPkZIjg1z8jyCTdPc+JCADyDnyJSQ=
X-Received: by 2002:a0c:9ac9:: with SMTP id k9mr2044505qvf.29.1615371543518;
 Wed, 10 Mar 2021 02:19:03 -0800 (PST)
MIME-Version: 1.0
References: <CAFr9PXmiR9Wo9HxhRLj-k6+O5qu-uLSTCvQRqW-Yqgkk8YK-Tw@mail.gmail.com>
 <20210308143011.24538-1-mark-pk.tsai@mediatek.com>
In-Reply-To: <20210308143011.24538-1-mark-pk.tsai@mediatek.com>
From:   Daniel Palmer <daniel@0x0f.com>
Date:   Wed, 10 Mar 2021 19:20:27 +0900
Message-ID: <CAFr9PX=dz1kt_BphpWr250asLiHFQNeBgNPhuPje==hzkcHWhg@mail.gmail.com>
Subject: Re: [PATCH v2] irqchip/irq-mst: Support polarity configuration
To:     Mark-PK Tsai <mark-pk.tsai@mediatek.com>
Cc:     Daniel Palmer <daniel@thingy.jp>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        =?UTF-8?B?WUogQ2hpYW5nICjmsZ/oi7HmnbAp?= <yj.chiang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark-PK,

On Mon, 8 Mar 2021 at 23:30, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> From: Daniel Palmer <daniel@0x0f.com>
> >On Mon, 8 Mar 2021 at 15:05, Mark-PK Tsai <mark-pk.tsai@mediatek.com> wrote:
> >> +static int mst_irq_chip_set_type(struct irq_data *data, unsigned int type)
> >       > +{
> >> +       if (type != IRQ_TYPE_LEVEL_LOW && type != IRQ_TYPE_LEVEL_HIGH)
> >> +               return -EINVAL;
> >> +
> >
> >Does this mean we can't do rising or falling edge interrupts?
>
> Yes, the interrupt of mst-intc is either level high or level low.
> Actually the input signal can be pulse, but it will be converted to level
> by the latch in mst-intc.

Are the GPIO connected interrupts meant to be configured as level
interrupts then?
For the MStar MSC313(e) there are 4 (that I know of) GPIO lines that
are wired into the mst-intc that requires EOI.
Until this patch with those lines configured as a rising edge a single
interrupt came each time the GPIO was pulled up as far as I remember.

I'm probably misunderstanding but a level interrupt doesn't seem to
make sense for a GPIO as it can't be serviced to clear the interrupt.

Thanks,

Daniel
