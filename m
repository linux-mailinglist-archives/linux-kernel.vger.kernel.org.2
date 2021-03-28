Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66D9A34BB7C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Mar 2021 09:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229757AbhC1HAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Mar 2021 03:00:48 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:23901 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbhC1HA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Mar 2021 03:00:27 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id 12S706d0018396
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 16:00:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com 12S706d0018396
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1616914807;
        bh=ruPkqENhiGJiQIaTJ02KjDVpC98q0O9CsXfhQWPaUhk=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WcjW6vbmiF09SgcfBBeC5OxHhGf+Nea58DmgSUhi/w273LwzHQfFXU1jTsA5G5WWz
         ASiUuYYBEPtQgUmzuSEfxrTvHX+JqUrrsDVGNKzaDrjkmcpym39llRKFud0v/OqNLe
         4S4TkjURVnw9jIy/fn0AyV1JgLJF1gCyOCdFzrw2P59jnFuTmBaSbJD1cmL15oMdRk
         waREfNOq6po3XiqJ3A0h2lLSsK9e7ZqIHKBPY5EwwT1RkBzqLkoM1k8DLVd977h7ve
         UR1F6PWwV0+y08Krzl66JbwoQNhvnS+1rqARkoE46nBA5+yZy/5q4+0iXhX/sf/qQX
         B1t5bdOiEnArw==
X-Nifty-SrcIP: [209.85.216.47]
Received: by mail-pj1-f47.google.com with SMTP id gb6so4531898pjb.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Mar 2021 00:00:06 -0700 (PDT)
X-Gm-Message-State: AOAM5328/LwpRo8EG1Ols2c48ZB977aLB239OVqH7sn/EJss4PnFy6WC
        5g41zrYCEXC/Wtoqj5aRhfxFj9kCcYl85DThiH0=
X-Google-Smtp-Source: ABdhPJz/R2+S+G5PzJK1f1S4Bsl8q0jQnTZHzwtcFfcJqLkE2U/8shbWgWP0JvhLAm3gTf6WNMcyA+43SqipT7ck2r8=
X-Received: by 2002:a17:90a:3b0e:: with SMTP id d14mr21602514pjc.198.1616914806173;
 Sun, 28 Mar 2021 00:00:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210324071128.1723273-1-masahiroy@kernel.org> <20210326143630.GD5126@arm.com>
In-Reply-To: <20210326143630.GD5126@arm.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sun, 28 Mar 2021 15:59:29 +0900
X-Gmail-Original-Message-ID: <CAK7LNATGo1NkcRF7qo1wF1w3jrOpTQPJf1XPryUz13L8OpaSxA@mail.gmail.com>
Message-ID: <CAK7LNATGo1NkcRF7qo1wF1w3jrOpTQPJf1XPryUz13L8OpaSxA@mail.gmail.com>
Subject: Re: [PATCH] arm64: move --fix-cortex-a53-843419 linker test to Kconfig
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 26, 2021 at 11:36 PM Catalin Marinas
<catalin.marinas@arm.com> wrote:
>
> Hi Masahiro,
>
> On Wed, Mar 24, 2021 at 04:11:28PM +0900, Masahiro Yamada wrote:
> > $(call ld-option, --fix-cortex-a53-843419) in arch/arm64/Makefile is
> > evaluated every time even for Make targets that do not need the linker,
> > such as "make ARCH=arm64 install".
> >
> > Recently, the Kbuild tree queued up a patch to avoid needless
> > compiler/linker flag evaluation. I beleive it is a good improvement
> > itself, but causing a false-positive warning for arm64 installation
> > in linux-next. (Thanks to Nathan for the report)
> >
> > Kconfig can test the linker capability just once, and store it in the
> > .config file. The build and installation steps that follow do not need
> > to test the liniker over again.
> >
> > Reported-by: Nathan Chancellor <nathan@kernel.org>
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> > I was not sure what the preferred CONFIG option name is.
> > Please suggest a one if you have a better idea.
> >
> >
> >  arch/arm64/Kconfig  | 3 +++
> >  arch/arm64/Makefile | 2 +-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
>
> Would you like this patch to go in via the arm64 tree or you will queue
> it via the kbuild tree?

I applied this to linux-kbuild with Will's Ack.
Thanks.




-- 
Best Regards
Masahiro Yamada
