Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B06E34E3E0
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Mar 2021 11:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbhC3JFf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Mar 2021 05:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230224AbhC3JFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Mar 2021 05:05:04 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3796C061764
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:05:03 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id d12so1595569lfv.11
        for <linux-kernel@vger.kernel.org>; Tue, 30 Mar 2021 02:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bhMwS+KZWoNSuCH0L/B/6kxRevZq3yjRIpEofoQe3h4=;
        b=s0rdgisKhyiiIQzZ2gTtOTAZR6nj/1KZy8XQdmRB0M2uDqRzLTDtpe3EJZAUnzknfT
         3yqi+zZddfkwUlPdrETqfL+D371di91JdWPTxT+xkW003tAr3DQthoaJGl9rNniY3m6o
         i4Pw4h1JPWaPkTclVI3MjnF2D+rf0ZK0VSzD4lPpNAg7SRCWPWrmToDZ1E/Eo/YGF/4T
         GAM+6gDQZRlWAbiM/cszUg6zLObsCEaI1zziCuv830RyQc1jsvXtzT4yNfyVx5QbwsN2
         1CbkAUM3AoHNEv+mnCgneiA/WuYAeBudhggpD32st0xhvCkES4FhYfb8+mIhdhdoSAmb
         aQ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bhMwS+KZWoNSuCH0L/B/6kxRevZq3yjRIpEofoQe3h4=;
        b=JCwbavXsiiE7/gF3A4x+iioUJCygcwLHlW0GsMuImphxRRg6hc0y+ojuJ5fKvqsrRf
         ihAdNpN6hQdGpMCvkEtSYr+Z1ojZPRDY78sIruLTHCbwWsv+nLB5Bkb/2zlZQXMz6WRE
         tLJTLebs/UmAm5zeuJHX0kqx6ClNxk3N7TsP7GAg124yBT+tUTFsQGGwRk0zgjiJwGho
         DBPbvuHXaKOorRGe28sm1Ba4Yv6nEBB9E3aeoZBq58TGrnDNnYNqlSR0DWo7m9z1hzNS
         bmlom+GOIL4VtVFTzfQsSKjX6fzW9UNabUiGXj46jXr0Zx+r4GNzI2hIUClp5G8XwZmg
         ECmQ==
X-Gm-Message-State: AOAM533Cv6vdJ6JrM6P0DrxOTv4eFCCmUuEFwIj4i8yucMTRHwA7KdmQ
        TERZEo9KAtd9lSCAUBJa+ifgd4RoU26/v4rkP87JUQ==
X-Google-Smtp-Source: ABdhPJzRbd1RN2J3WUlFr0OfVin8j7Josbjf5a0gQmr90oSSAfFmhl1buHeXzgZIQblIfHU1CVezrvqr2hTViQVqUbo=
X-Received: by 2002:a19:4c08:: with SMTP id z8mr18246243lfa.157.1617095102073;
 Tue, 30 Mar 2021 02:05:02 -0700 (PDT)
MIME-Version: 1.0
References: <20210323131002.2418896-1-arnd@kernel.org> <CACRpkdZjh+z66XAxg4-Cj_Mz7iVkgpyY65nNTvUdOXV6yTknEQ@mail.gmail.com>
 <87h7kv5h9b.fsf@microchip.com>
In-Reply-To: <87h7kv5h9b.fsf@microchip.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 30 Mar 2021 11:04:50 +0200
Message-ID: <CACRpkdbksmk=qzie3TES5TSSA34eMKjqSvQmgQN5_Ba-BEufCw@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: microchip: fix array overflow
To:     Lars Povlsen <lars.povlsen@microchip.com>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Arnd Bergmann <arnd@arndb.de>, Zou Wei <zou_wei@huawei.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 28, 2021 at 7:18 PM Lars Povlsen <lars.povlsen@microchip.com> wrote:
> Linus Walleij writes:
>
> > On Tue, Mar 23, 2021 at 2:10 PM Arnd Bergmann <arnd@kernel.org> wrote:
> >
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Building with 'make W=1' shows an array overflow:
> >>
> >> drivers/pinctrl/pinctrl-microchip-sgpio.c: In function 'microchip_sgpio_irq_settype':
> >> drivers/pinctrl/pinctrl-microchip-sgpio.c:154:39: error: array subscript 10 is above array bounds of 'const u8[10]' {aka 'const unsigned char[10]'} [-Werror=array-bounds]
> >>   154 |  u32 regoff = priv->properties->regoff[rno] + off;
> >>       |               ~~~~~~~~~~~~~~~~~~~~~~~~^~~~~
> >> drivers/pinctrl/pinctrl-microchip-sgpio.c:55:5: note: while referencing 'regoff'
> >>    55 |  u8 regoff[MAXREG];
> >>       |     ^~~~~~
> >>
> >> It's not clear to me what was meant here, my best guess is that the
> >> offset should have been applied to the third argument instead of the
> >> second.
> >>
> >> Fixes: be2dc859abd4 ("pinctrl: pinctrl-microchip-sgpio: Add irq support (for sparx5)")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Patch applied.
> >
> > Yours,
> > Linus Walleij
>
> I don't understand - I submitted a fix for this already in February
> (reported by Gustavo). It took some time for you to get it ack'ed - but
> you did (Feb 1st).
>
> Did it end up getting dropped?

No I ended up with your fix in fixes, then forgot about it and applied
Arnds fix to devel (for-next) and ended up getting a conflict in my
face.

Last night I rebased devel, dropped Arnds patch and thus solved
the conflict.

Yours,
Linus Walleij
