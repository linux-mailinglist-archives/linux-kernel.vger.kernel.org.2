Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0356E31D32F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Feb 2021 01:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231310AbhBPXy0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 18:54:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230408AbhBPXyX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 18:54:23 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BABC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 15:53:42 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id f3so13047771oiw.13
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 15:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=7YZZZa0Z9sq8S0dHPnPa5oROFnkvvg200VC3qLVC1ME=;
        b=RnSmnHbst8FK/8ck/1v044L3LQP7/uSxvm23Lzbc2rn4IGOkaXLgNd87nRHGzjPger
         zlB8oYx9DP/gGdxrNeHurZy9bsGOofhri2hmjd0HjmRBd2VYc/IbWucJXVkZ4zzWIJ9d
         jIAymqZAgxSXBAPLR3DfKgguFeup49ObfZrx8SiikL9Uj9nAAWEb134DBhTgCmNnKVCk
         FJ+TLJrr1V6Wnq7c9nk7yO33Phel0tira/u/aAozMLqbKuF2Lvw45gf9QUZGL99zAjXj
         SBs/Z//UG9o6qnaxZC5F56btUqnBbjjL8Miipmt0Az2S9Ruwft8qF3L0H1MijJ4zeHYB
         B5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=7YZZZa0Z9sq8S0dHPnPa5oROFnkvvg200VC3qLVC1ME=;
        b=AnoyR0muc66hWlsCgLbOyjj59Dmbty48ZSvIhucM8i6/uVmm0ZGQ9sgM3HzgRQs5gh
         NZw5wNyuNqXFEmNkNlsbvLxCAHsxD0WSPBQ42zpNgTSq4wEAxOnI42l4VRb6CLYE9vDO
         +hTLoxGt1mCWvm4XO3dQSPfeSEBosJ1rczyJNlnQzfyPqwR1bMF9PZkHtWwG/DN9zjyZ
         jntOtVRqNBywE7m0bE1rj7wPbiqIz/pD/XHvE+lsY8BIRFRXJ93Dz7pVYoAeszpeu4y9
         uZrdZtVeU9cvI/VlcyGmYCA5A3l2snAjeBHRUKfb11954LmJBakWwz+J4KknPWH/KtFV
         v9Xw==
X-Gm-Message-State: AOAM531DMI/Aar9HBD2VVSGxvzuMiL8AVK6JXY0xu86YLWxiq7x2pgqP
        JsUDW944YKyR0D0wQp+ka3OP58BW2qwZzu1ezGS8zg==
X-Google-Smtp-Source: ABdhPJzkxDyN7ezhP2Gl14bsnM7Bo+Uhwem0JKrjZQtkq1K6lm6ThCe3vJwUHiH4aCthz8yzmwyqCdjjtHg5YgYMUkk=
X-Received: by 2002:aca:1a17:: with SMTP id a23mr4047592oia.172.1613519622217;
 Tue, 16 Feb 2021 15:53:42 -0800 (PST)
MIME-Version: 1.0
References: <20210209050047.1958473-1-daniel.diaz@linaro.org>
 <6065587.C4oOSP4HzL@mobilepool36.emlix.com> <3314666.Em9qtOGRgX@mobilepool36.emlix.com>
 <5043253.pljLzkpU8D@mobilepool36.emlix.com>
In-Reply-To: <5043253.pljLzkpU8D@mobilepool36.emlix.com>
From:   =?UTF-8?B?RGFuaWVsIETDrWF6?= <daniel.diaz@linaro.org>
Date:   Tue, 16 Feb 2021 17:53:31 -0600
Message-ID: <CAEUSe7-NA92bBDco_go6mwkdrtUsxk0H6OX0pUfpDZ0R7VKL=g@mail.gmail.com>
Subject: Re: [PATCH] scripts: Fix linking extract-cert against libcrypto
To:     Rolf Eike Beer <eb@emlix.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux- stable <stable@vger.kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!


On Fri, 12 Feb 2021 at 01:44, Rolf Eike Beer <eb@emlix.com> wrote:
>
> Am Donnerstag, 11. Februar 2021, 11:29:33 CET schrieb Rolf Eike Beer:
>
> > I'm just guessing, but your build error looks like you are also
> > cross-building the tools, which is wrong. You want them to be host-tool=
s.
> > So don't export PKG_CONFIG_SYSROOT_DIR, it would then try to link targe=
t
> > libraries into a host binary.
>
> I have looked again how I do it:
>
> # this is for additional _host_ .pc files
> export PKG_CONFIG_PATH=3D${prefix}/lib/pkgconfig
>
> Then have a target-pkg-config, so this code inside several kernel Makefil=
es
> will work:
>
> PKG_CONFIG ?=3D $(CROSS_COMPILE)pkg-config
>
> And then export your PKG_CONFIG_SYSROOT_DIR and the like inside that. I b=
et
> you have all of this already in place, so just remove the SYSROOT_DIR fro=
m
> your kernel build script and things should work.

Thank you for your comments! I will try this in our environment in the
upcoming days.

Greetings!

Daniel D=C3=ADaz
daniel.diaz@linaro.org
