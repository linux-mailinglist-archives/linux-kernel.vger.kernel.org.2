Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3578739066C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 May 2021 18:17:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230511AbhEYQS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 May 2021 12:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbhEYQSx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 May 2021 12:18:53 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FF4C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:17:23 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id t193so23137899pgb.4
        for <linux-kernel@vger.kernel.org>; Tue, 25 May 2021 09:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=CdawJkwPb9uxGnIRp9sk4Ip1oxhSpAGWGCOpyXEqx3g=;
        b=rJa7zjMSgGyyG5fwmAUqCwPtrvv5JuaUKfxyI61BvANPK873nbdYjwwSjEBuK0gT25
         bibqdjWTQkuJfcvRwuHpDEvogNf1OE8pGaQVKnej1GuGJjOvQUqyVx2yWvHYvxfmmQZs
         z7CGPOEE7deJ9nzz04LL9+8FGtraj1iBOe8UGT/1mLQP/4FXxWY7mMbNVj2dlhXxjqvw
         86/X/rEH7ucKSTM9gDVLhRFBfeIw2flglowb78NSBj7Rs1EgHKdYX54u94csuW6HvU7e
         l6LW+wd2y4up625x5S8t7ek9oUDnUa46mFOYztJgNUXH3elg132tlr2EtjMeQPp+VuLo
         EXjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CdawJkwPb9uxGnIRp9sk4Ip1oxhSpAGWGCOpyXEqx3g=;
        b=IWHLirD+xytJoa3x7pTLQ+iDfx28yfgErfafyUjqkgUWbnbWrdwwdLwHahgsD55m/N
         jE6MNhWdyH51jOWug3PXbTAZwpZomCeMjFNWERTiVu5y4UnI7BlqfF5sczb1EnMGqeP5
         Mg3uJ56ZAY2kWlXoX9rWJaGKuwMB50F0d/ar0C9lMXXMKATu4KInXdGaDrwLN+s9YmgH
         jKZ6MZv8NGzELReI8zjawOZ0KqgCkn0m/AVGJxrNjeJycYu1OcgjWwL/adzkUIkWD+5Z
         o+E9k2/YD9I53vBGu4KTiHkNO6m6DjzKOr+7svSdkj/qQV7Tf7fkNqa93qcQUCLrQzpx
         d2Jg==
X-Gm-Message-State: AOAM530Fazp0JgPmZkllkD9iq74HaS9SCLTNQQ6DC6oVbtBHlnhoQWVy
        6dbYGelzCRNPt7tYazJw36Neyg==
X-Google-Smtp-Source: ABdhPJwQWoLkB15dMgqBWwSPOLHy1X9eow40SiKRJfG7tRn1R38sCBNzVxm0PiH9htEgLG2ov+FjZQ==
X-Received: by 2002:a62:55c4:0:b029:2e8:f854:d31c with SMTP id j187-20020a6255c40000b02902e8f854d31cmr7833707pfb.59.1621959442277;
        Tue, 25 May 2021 09:17:22 -0700 (PDT)
Received: from localhost ([2601:602:9200:1465:2dea:a51d:f517:6a56])
        by smtp.gmail.com with ESMTPSA id m14sm13861320pff.17.2021.05.25.09.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 May 2021 09:17:21 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Marc Zyngier <maz@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] irqchip: irq-meson-gpio: make it possible to build
 as a module
In-Reply-To: <87r1hwwier.wl-maz@kernel.org>
References: <20201020072532.949137-1-narmstrong@baylibre.com>
 <20201020072532.949137-2-narmstrong@baylibre.com>
 <7hsga8kb8z.fsf@baylibre.com>
 <CAF2Aj3g6c8FEZb3e1by6sd8LpKLaeN5hsKrrQkZUvh8hosiW9A@mail.gmail.com>
 <87r1hwwier.wl-maz@kernel.org>
Date:   Tue, 25 May 2021 09:17:20 -0700
Message-ID: <7hsg2au6sv.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Zyngier <maz@kernel.org> writes:

> On Fri, 21 May 2021 10:47:48 +0100,
> Lee Jones <lee.jones@linaro.org> wrote:
>> 
>> [1  <text/plain; UTF-8 (quoted-printable)>]
>> On Tue, 20 Oct 2020 at 19:23, Kevin Hilman <khilman@baylibre.com> wrote:
>> 
>> > Neil Armstrong <narmstrong@baylibre.com> writes:
>> >
>> > > In order to reduce the kernel Image size on multi-platform distributions,
>> > > make it possible to build the Amlogic GPIO IRQ controller as a module
>> > > by switching it to a platform driver.
>> > >
>> > > Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
>> >
>> > Reviewed-by: Kevin Hilman <khilman@baylibre.com>
>> > Tested-by: Kevin Hilman <khilman@baylibre.com>
>> >
>> > Tested as a module on meson-sm1-khadas-vim3l where the wired networking
>> > uses GPIO IRQs.
>> >
>> 
>> Good morning Neil, Kevin,
>> 
>> What happened to this set in the end?  I still don't see it in Mainline.
>
> Last time I tried this patch, it broke my test setup in non-obvious
> ways. Has someone checked that the issue I reported back then has been
> resolved now that fw_devlink is more usable?

Not yet, that's (still) on my TODO list... (well, TBH, I forgot about
it, but I'll have another look.)

Kevin


