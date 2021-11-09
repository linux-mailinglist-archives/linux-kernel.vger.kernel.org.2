Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65DB444B42A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Nov 2021 21:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244610AbhKIUpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Nov 2021 15:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244597AbhKIUpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Nov 2021 15:45:22 -0500
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50456C061766
        for <linux-kernel@vger.kernel.org>; Tue,  9 Nov 2021 12:42:36 -0800 (PST)
Received: by mail-ot1-x334.google.com with SMTP id z2-20020a9d71c2000000b0055c6a7d08b8so561578otj.5
        for <linux-kernel@vger.kernel.org>; Tue, 09 Nov 2021 12:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kl+ING2vPVUw4dbwJiGjKtSToM+NyrnBy+El7nhO980=;
        b=zmf1V1KQjNkArcK6dsYU/c7ttlDWId9avUz5BsgLno0wJHjE+nzUw6OMH54Pj+TumU
         j01e23FYO8hn3Wk27ZB75YVIX5/gYGYkZqj1LIvqLDnGgADDGr6M7zzTqBjvsC0Lz9Mw
         h9EiMhbJXNs+4gpq3Ftu3Ad5M87ldeLiKXsyBOv8WdpxtbD1shQKhiitRoadIzxMJ8Ks
         Q1FpmIK1bwzRkO5AiXU14yXzdQG/wBdN3LtCIUDfnvMylDI03sqmIdM/HBZwkOqIBcb9
         2b/TWTng1GnNdtmH0DcniDEgHWD6TNZ54grLGfwl0qzqG93s+3qFgndgPjdFE+KlzjDO
         f7fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kl+ING2vPVUw4dbwJiGjKtSToM+NyrnBy+El7nhO980=;
        b=ZXZ/MVZ4sEfxBSgIDk1T9uhS9+7tlEnhXNbU3Cu3iysH8GbYZsfKs/irLS3jXJtZdv
         ++jtSo7BP4S3xScMc3SlqZVmRdrz5FfoCjNpaAxXMqSXZEmu0WLsVcesf2xEdSCokDst
         Vi16gTieqYUhI++F2w+GAKFawYLs9o21DUmBmAuA+iGC70WkoX0RT6dvo0VMCvBGXrfI
         5Ar0nx5e2whO2kNS2nAWwXC/bgkvBpSVOUoLkWGvZZjNMOGGAYYMU8dUE24Jz4bAKHtn
         kktIC1ji6engsaamWv0kyCbdvjHDsePB6nfvCntTk0Bd80uusgffGeZliiY351vEfPVq
         IG0g==
X-Gm-Message-State: AOAM5312b1j3/W4CE2o+uNyN3yx8/hZrpMgi9KlM6SRZUeD/hzRBuQ7n
        qo3C9J8KtSX6GkxM0SGeRrlqABGBoExCmIudKAg6hw==
X-Google-Smtp-Source: ABdhPJzxPoRxDUD8SGDUt5PcErFvzEPCMZS6UV9UQDtuc0AL6W7X/9yWO2k1DBIvqVQZUNdpVTlOYATJQ3FyB40EqYQ=
X-Received: by 2002:a9d:6348:: with SMTP id y8mr8564780otk.179.1636490555709;
 Tue, 09 Nov 2021 12:42:35 -0800 (PST)
MIME-Version: 1.0
References: <20211109100207.2474024-1-arnd@kernel.org> <20211109100207.2474024-7-arnd@kernel.org>
 <YYpN3LzXz638l6FG@smile.fi.intel.com> <CAK8P3a24wkBEAnWG8=LYoVR1oiTo0VKZ3iME+FYbDuHXJDjMOw@mail.gmail.com>
In-Reply-To: <CAK8P3a24wkBEAnWG8=LYoVR1oiTo0VKZ3iME+FYbDuHXJDjMOw@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 9 Nov 2021 21:42:24 +0100
Message-ID: <CACRpkdZaJQqwyosnXhaOc=mF5jJxaDKDKAQxJGJvQAWpU7MNQQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/8] gpiolib: remove legacy gpio_export
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 9, 2021 at 11:50 AM Arnd Bergmann <arnd@kernel.org> wrote:

> I think the TODO list is in Linus' head,

Oh no, drivers/gpio/TODO

> but it would include all the files
> that use one of the interfaces in linux/gpio.h. I found about 350 of them,
> so there is little point in listing them one at a time. IIRC Linus is going
> through those one subsystem at a time.

Yeah but if it's just me I doubt that I will manage to do it by the
time I retire in 2037 or so... So the TODO is there to inspire others
to step in and help out.

> I also found that we have a ton of users of linux/of_gpio.h, which is
> somewhere inbetween the linux/gpio.h interface and the
> linux/gpio/consumer.h version.

This is also mentioned in the TODO.

Yours,
Linus Walleij
