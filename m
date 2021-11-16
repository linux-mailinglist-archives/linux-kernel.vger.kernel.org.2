Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A649452C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 09:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbhKPIFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Nov 2021 03:05:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbhKPIFq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Nov 2021 03:05:46 -0500
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2802C061570
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:02:49 -0800 (PST)
Received: by mail-yb1-xb31.google.com with SMTP id d10so55026722ybe.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Nov 2021 00:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hQBMuNhWC/SXVmRTyZGfwkUJW5a5zHc1KZht6B7VygU=;
        b=mGjag/Vnno7VAQjIrRpLE8jUjT9qkJJDFyFJVHaXeI/0VhNK7E1VygQD10NTnkZjiL
         L7eVH0IeL5qfJ9J+SZVHyinp2Lx0QGVnfPLq9YmUfsSP00JQc0cvCES4wlPOo4hpPIbp
         09+CyBOxTMc3CJCIfphTu21XQmesl4gvCfdibZmD1nzIOFU34Rj/2GAIqLpLrTPCq9MP
         nLeFX4sH7JUQdtLXFvheLzhTEOEadN7Qh4a4rQnaE6jHybnL2UrY6+IrDXUe29yMVcb3
         jvJjqZE/O2NS8Ji3vHWZ+MAV+1+qIo15ARym/WMDx6S87cBJgoEPmCq5wapoPrsdkBVK
         OWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hQBMuNhWC/SXVmRTyZGfwkUJW5a5zHc1KZht6B7VygU=;
        b=6xWUy5YTcdEG0wFuYxrKVbcUivek2YLlSfSH4/yS6ZP7kGqI79GoD1u0uduYXnjpf5
         pNpBMWtTjxfMeMy4gZmNqDda4GE32gTbeHZtXPAbYvYeYHqFMqcllNseiyoS+ivoerOm
         B1iURtP2TsYPgM6b7bLFtw6Ul5lqxZxd5q8Lld3JjsUKMGPQ3OZB03pHhYVJPen8qbwc
         T4n2eWKeLeL7KBnOLIYKYC6rVfIsNrT3+wV6BWd+twaG2hiYH0051sZ00A1XfkNGhZJU
         05L96eoBND1H+dJuOjiD4biPDGXbSavTDH5UcET+vR/AxYEfMP0SPyBbILZk6g16KDVW
         ZIfw==
X-Gm-Message-State: AOAM5313F+W2Od2EGI2/eVmPEVJ308fKTW4Nc3/NXSmwZp8g82gsbegW
        4uqb3M8bMWnGaF/ZOMWqjUyPbHDifWf9shKpk9v3jg==
X-Google-Smtp-Source: ABdhPJxvj2hNJCrlJfvmL0ijReKS3wSsP5j/cpcemVPIHtGak8pqbEABrU2EH9eT1SeVEmqWj47yK8+27eI9oYLM+24=
X-Received: by 2002:a25:a427:: with SMTP id f36mr5789998ybi.245.1637049768957;
 Tue, 16 Nov 2021 00:02:48 -0800 (PST)
MIME-Version: 1.0
References: <20211104175120.857087-1-vincent.donnefort@arm.com>
 <20211115104601.lwcwxoc67ftbf6uh@shindev> <87h7cdqne7.mognet@arm.com>
In-Reply-To: <87h7cdqne7.mognet@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 16 Nov 2021 09:02:36 +0100
Message-ID: <CAKfTPtAPaMU343=uRuo-LvoP6HnGwnLhTcEMyFVBisdjnT-Spg@mail.gmail.com>
Subject: Re: [PATCH] sched/core: Mitigate race cpus_share_cache()/update_top_cache_domain()
To:     Valentin Schneider <Valentin.Schneider@arm.com>
Cc:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Vincent Donnefort <Vincent.Donnefort@arm.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "jing-ting.wu@mediatek.com" <jing-ting.wu@mediatek.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shinichiro

On Mon, 15 Nov 2021 at 19:34, Valentin Schneider
<valentin.schneider@arm.com> wrote:
>
> On 15/11/21 10:46, Shinichiro Kawasaki wrote:
> > Oh, this is the exactly same fix as I posted before [1]. It is a little bit sad
> > that my post did not get reviewed. Anyway, good to see the issue fixed. Thanks.
> >
> > [1] https://lore.kernel.org/all/20211029005618.773579-1-shinichiro.kawasaki@wdc.com/
> >
>
> Oh, that sucks, sorry about that. I do try to keep an eye out for sched
> stuff sent to LKML, but clearly there are some that fall through :(

I would advise you to use get_maintainer.pl to make sure to not miss
to cc someone.
Like valentin, this patch has been lost in the lkml flow and i haven't
noticed it

Regards,
Vincent
>
> > --
> > Best Regards,
> > Shin'ichiro Kawasaki
