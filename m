Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98B633CB7B0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 15:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239854AbhGPNHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 09:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239791AbhGPNHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 09:07:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD346C061762
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 06:04:14 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id dj21so12984265edb.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 06:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3EFuCzIh+SeYBpu5UbN36zCvdsMMMavFs1jTakKetLg=;
        b=ZBXdVovlUDWINuH3DenX3yyikHJDRDr2XC5in3PvcE/lwDz61zADYJvdyMUF81uMM6
         XXbcSnjd4cAuovnUKeTRhuLnTGBeV+3C1LcTnX7G2y5kQhmoAQxNnywDdbAL1NXKhVEV
         tcn92roRGng/i79mMnA5uSiT8iQ3UWR6q2CRSTj59A7OzhhwVdyrLXrFPuP2i+EzUap2
         vtsh+A9s1FWLrzYzpRAlaof+1YGrboe85JIclqPon69R9psy5WHKQ89b8FvEk2AR9t7a
         28OTWr6cxiUP23tLSHX9hSN/nEQnGoAkGRQWRp4uL2NyqmsNEEdEGC1Y/MQBFrt1Rb+l
         rRSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3EFuCzIh+SeYBpu5UbN36zCvdsMMMavFs1jTakKetLg=;
        b=B7jMBDQd7vthtV1IWsFTXGrorftz6CrOFFZowhqIZ6kZgl+iU0gtnpLLpCymq04ywx
         vH5S+2bV7+2F034h98jU7cCZeirYULCI/dPn/4aFtu1/sOW8LMcAtvqWwG27Qsjt7OC9
         IxdQF2z+FJAwE6eG8l5oZ2nN3EkzgN0SAsuf/Hvhn0EiRU890hKuQb0l+ByyIvNqyySl
         rql7pNbWrU/88ykiapebg/RgcKca1hPaD19O5jZNXHTIBX1jvSTI85XG9qlbYFYuU2jv
         lDduQ4IJ/0fNnEihp0+PwgxGtsJDvgdTGQHScxmVlTuanp+9klj7F58XLWuHBwYhV8gs
         Iw+A==
X-Gm-Message-State: AOAM5338IUEiwU7nXjuKPVKva8rszXLP6Q7MIaUEE1fNeKyrnDXHJbxa
        P95qrBNI+vii+ZzrN+X3GRlmfCrvOYc4OBc/LbEhOA==
X-Google-Smtp-Source: ABdhPJwF2Vd4OfydUmikO1TlQyiVvg2oS4gN+IeEt5NyFgOSmf6VbmP1pv5jgrwgpt/3hNuw0iZgnsBVM/vCmRXOk+w=
X-Received: by 2002:aa7:d2ca:: with SMTP id k10mr15018511edr.379.1626440653392;
 Fri, 16 Jul 2021 06:04:13 -0700 (PDT)
MIME-Version: 1.0
References: <YO3txvw87MjKfdpq@localhost.localdomain> <YO8ioz4sHwcUAkdt@localhost.localdomain>
 <CADYN=9+ZO1XHu2YZYy7s+6_qAh1obi2wk+d4A3vKmxtkoNvQLg@mail.gmail.com> <YPFa/tIF38eTJt1B@localhost.localdomain>
In-Reply-To: <YPFa/tIF38eTJt1B@localhost.localdomain>
From:   Anders Roxell <anders.roxell@linaro.org>
Date:   Fri, 16 Jul 2021 15:04:01 +0200
Message-ID: <CADYN=9LVpCYc48sY63372EyfA9sepKj=LmwfOwyLqo=V45Uq=Q@mail.gmail.com>
Subject: Re: [PATCH v2] Decouple build from userspace headers
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Masahiro Yamada <masahiroy@kernel.org>, hch@infradead.org,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Jul 2021 at 12:10, Alexey Dobriyan <adobriyan@gmail.com> wrote:
>
> On Fri, Jul 16, 2021 at 11:03:41AM +0200, Anders Roxell wrote:
> > On Wed, 14 Jul 2021 at 19:45, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > >
>
> > In file included from
> > /home/anders/src/kernel/testing/crypto/aegis128-neon-inner.c:7:
> > /home/anders/src/kernel/testing/arch/arm64/include/asm/neon-intrinsics.h:33:10:
> > fatal error: arm_neon.h: No such file or directory
> >    33 | #include <arm_neon.h>
> >       |          ^~~~~~~~~~~~
>
> > If I revert this patch I can build it.
>
> Please, see followup fixes or grab new -mm.
> https://lore.kernel.org/lkml/YO8ioz4sHwcUAkdt@localhost.localdomain/

I tried to apply that patch but I got the same build error.

Cheers,
Anders
