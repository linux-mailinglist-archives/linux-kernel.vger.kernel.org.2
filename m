Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83623BC6F1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jul 2021 09:02:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbhGFHE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jul 2021 03:04:58 -0400
Received: from mail-vs1-f44.google.com ([209.85.217.44]:36401 "EHLO
        mail-vs1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhGFHE5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jul 2021 03:04:57 -0400
Received: by mail-vs1-f44.google.com with SMTP id g25so2295026vss.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Jul 2021 00:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9xIwHt5PeAkDjNM0GumPVX7YcEcAvNDDYFz3rxhdD9Y=;
        b=B/Jt2iBduh+0lqoEiClMUYZMTU+5Yn0Ix1Qb7v5g03f2Gm0jOob7u/jXV9rMOBe1oB
         XaveknRNVOOF87Pb7TKc+DhgTmXlyjkW2qkcCu0Ag+LMHrEblhbqVGo9urPp6hE1z8aC
         FGcgaPaN/amDxhqWJLPCGHu36fvM9QihrM7kBqa8vh8F48+5ALIW/715CwQZiRMFQW8V
         trHksTdfPB+NY36KTqzK/0c6MvQS/GsnouBJshfEK4vCz1qkuLiXpC3oRx1q1LUASWxk
         OTeCy1+Ke16EhMp7PRCFmRCt8jQCx0Fxz8SWcu6xU7nhBfOMX4D7ekBKCEarzzOmIHmE
         kCaw==
X-Gm-Message-State: AOAM533RXa+CbHr49+he6ORD7ZbJuQcnFnMR9hvaUxi9/Fn+flfGUn/I
        IANjhcvFarkqvkqK3lXeKSqDCar7fFYuUiuEJbs=
X-Google-Smtp-Source: ABdhPJwnML5SWGn0qF4isgulOhytCA8swwd1O/FeaZOMpZYf4vXlJfE7PIkxUiW+3hjI+6B7ZBztsOp7S4Y5DihWY3A=
X-Received: by 2002:a67:db05:: with SMTP id z5mr13391517vsj.18.1625554939386;
 Tue, 06 Jul 2021 00:02:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210705204727.10743-1-paskripkin@gmail.com>
In-Reply-To: <20210705204727.10743-1-paskripkin@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Jul 2021 09:02:08 +0200
Message-ID: <CAMuHMdVKgW42GCwntSawRXNvRejm90zhuY9_X_u1OxfDj40aTA@mail.gmail.com>
Subject: Re: [PATCH] m68k: emu: fix invalid free in nfeth_cleanup()
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Petr Stehlik <pstehlik@sophics.cz>, milan.jurik@xylab.cz,
        Michael Schmitz <schmitz@debian.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 5, 2021 at 10:47 PM Pavel Skripkin <paskripkin@gmail.com> wrote:
> In for loop all nfeth_dev array members should be freed, not only
> the first one. Freeing only first array member can cause double-free bug.
>
> Fixes: 9cd7b148312f ("m68k/atari: ARAnyM - Add support for network
> access")
> Signed-off-by: Pavel Skripkin <paskripkin@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k for-v5.15 branch.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
