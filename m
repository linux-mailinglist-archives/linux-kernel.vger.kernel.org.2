Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC628393FAE
	for <lists+linux-kernel@lfdr.de>; Fri, 28 May 2021 11:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbhE1JRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 May 2021 05:17:47 -0400
Received: from conssluserg-01.nifty.com ([210.131.2.80]:42880 "EHLO
        conssluserg-01.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235842AbhE1JRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 May 2021 05:17:44 -0400
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41]) (authenticated)
        by conssluserg-01.nifty.com with ESMTP id 14S9Fb3b005528
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 18:15:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-01.nifty.com 14S9Fb3b005528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1622193338;
        bh=39pO5BBOVAifJjDbCOX9efx90Asg6bB9LleYJ3FOvGg=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pyUjby031ZX4HJMzkOwIHs2C3oZNFl5YMCWN81bFPwmn9+dW/rnPyUMBCy/mCToGl
         J1d6K8/iouONtqtMRG6FivLoYb2g01NMKKmBeN5GP+Dhv9lbYryVV9PgZP30d86nxg
         4jVhQpCH8owU6baFNKB6sFb8e021xDBoZRSbaJWvAHRVOTwh3hySa9MfSex1tUFSRT
         piz9A7e8+bUAh/SRMAzJ1TyUOIO0LYjzu8bSzRUUUJOOGlEFHvwiQFl33Fr7Uyvxx3
         6qgerrZjL3jIUJKdzj7xedS2Wb3Hs4gGrwx2AhdfzpxxBjQtZH6RQQSSwx1LAFeoui
         Wyh0Mpy0wqSpw==
X-Nifty-SrcIP: [209.85.216.41]
Received: by mail-pj1-f41.google.com with SMTP id mp9-20020a17090b1909b029015fd1e3ad5aso4107633pjb.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 May 2021 02:15:37 -0700 (PDT)
X-Gm-Message-State: AOAM533WjrfJU1i9GWTQNW5j7xdb6TmWnx0bD5mt8NdU9bYh51Ikz5sV
        NHDVIfk35Gsnb8uOV9Ox6yl8Qk8tYwucpB/2hyo=
X-Google-Smtp-Source: ABdhPJx/Gs6ZJu3IBJC4ZL1qePsWol28jUvqkwVgk7KREdjpso85oPRTG0pjN6WSUguAjJf3YAFqGOTyjHBq0mX9ekU=
X-Received: by 2002:a17:902:bcc7:b029:ed:6f73:ffc4 with SMTP id
 o7-20020a170902bcc7b02900ed6f73ffc4mr7226469pls.1.1622193337038; Fri, 28 May
 2021 02:15:37 -0700 (PDT)
MIME-Version: 1.0
References: <20210528035209.2157823-1-masahiroy@kernel.org> <CACRpkdb-CsQtaiRjUWsimSmBw8tAgvr_ET1BS47rsVxd-eY0VA@mail.gmail.com>
In-Reply-To: <CACRpkdb-CsQtaiRjUWsimSmBw8tAgvr_ET1BS47rsVxd-eY0VA@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Fri, 28 May 2021 18:15:00 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmuJxp66VMhJdQ487uua0ynppXHoMA7ukbfsLpyGQV6g@mail.gmail.com>
Message-ID: <CAK7LNARmuJxp66VMhJdQ487uua0ynppXHoMA7ukbfsLpyGQV6g@mail.gmail.com>
Subject: Re: [PATCH] ARM: simplify the build rule of mach-types.h
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     patches@arm.linux.org.uk,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 28, 2021 at 5:24 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Fri, May 28, 2021 at 5:52 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> > The directory of mach-types.h is created a couple of lines above:
> >
> >   _dummy := $(shell [ -d '$(kapi)' ] || mkdir -p '$(kapi)') \
> >
> > The 'mkdir -p' command is redundant.
> >
> > scripts/Kbuild.include defines real-prereqs as a shorthand for
> > $(filter-out $(PHONY),$^). Let's use it to simplify the code.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Can you put this into Russell's patch tracker or shall I sign
> it off and put it there?


I sent this to patches@arm.linux.org.uk

It is already there.
https://www.arm.linux.org.uk/developer/patches/section.php?section=0



-- 
Best Regards
Masahiro Yamada
