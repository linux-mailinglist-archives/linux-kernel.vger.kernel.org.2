Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60D0C3057E8
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 11:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbhA0KLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 05:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbhA0KJN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 05:09:13 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38191C061786
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:08:28 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id r38so1219997pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 02:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=0gBgHF3+KJRKugCZyhYXWiUq6+B+AWpiBixHa8F3yPQ=;
        b=stB1k6gAJxr1IbaoMiaN+TGAYi4qwpHcguGN4IjAXqEizfhTNnbLMuPCrDDNWW1xF8
         pFzIZm75LoA9xh/XLuqoYw9MeKiTQuxP5EXVkDQ3DG6tPRMQsobIAlsNoaZOReY8Inb1
         pMhWh/keDMAPY+QAWKxrR+QsfQ+m2FgtMEji+AyupOICAYikYB3YkICYH8vbBOtD5Xvg
         pk9kFfG8ku2+5KfNTw84A98vSzcBT3w2LZaTAkKHe+pdGvaNtHJXFNfEJ9gVm1f/Qhv1
         prHWvFQwijjrQtrciE0BD5BMRdXSm20I0L2r3OyZJ3VzbpZ3ugFfKXgcQlt2i+1M/Ggu
         GPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=0gBgHF3+KJRKugCZyhYXWiUq6+B+AWpiBixHa8F3yPQ=;
        b=dRgGbOd/5uXEiUUr0VjbeOiDQbN5CqgjU1tIWCk6x1owBodCW1isfb8L/ItWJ0tCtg
         2djxiX/7vgHp4pNuCiBbAl9qftIJqzxTBB+Cim8EnQfC6jGfaLq/B0I86hEM4QAJ3Nw5
         TeP0M0EjrNknV5LFXumyCiY9cma0mPN/5XPq/4f8eBS9gHcjDeI9CqewmbldtGylqqBS
         75PhqNoOsDF/MwcgaYLza3KpYBSLik++cfg0XYCRAmoGyAp+S66GwEyS/fuaytjqXD+h
         pfsH2IkUlkrOdQbf/3eircDU26Ln5Kn7YtW6KF2JoBxgFwFnY8/capgNlZyLN1yyPM6N
         eAfg==
X-Gm-Message-State: AOAM5332sRxDsB0Rl3iJLcMiZMNetfPL/h1imNwmIWLF8fFYMXVxB7v1
        NBWkjhpzdgCZuHBEuysbqqiTNyNqcw8Jqh5SpMQncw==
X-Google-Smtp-Source: ABdhPJylF1pvXvDM57Wggpr3dL+Hr7Xgvby6sdCPKFYpMWJBs1mnML2k2YXaJqLg5M3pM9dtqR3sZkWkLDddBZ+caIE=
X-Received: by 2002:a65:418b:: with SMTP id a11mr10393500pgq.231.1611742107694;
 Wed, 27 Jan 2021 02:08:27 -0800 (PST)
MIME-Version: 1.0
References: <CAFJ_xbqT8h2Exix3S6AGgB7W1N0u-=WKffAyb7Hk9-8K8FBwKA@mail.gmail.com>
 <20210127100454.GK196782@linux.ibm.com>
In-Reply-To: <20210127100454.GK196782@linux.ibm.com>
From:   =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>
Date:   Wed, 27 Jan 2021 11:08:17 +0100
Message-ID: <CAFJ_xboaFNQ9NuZ1rhH8WdejoFRzvez9cp2AQ59rKY6T_xZ-_w@mail.gmail.com>
Subject: Re: PROBLEM: Crash after mm: fix initialization of struct page for
 holes in memory layout
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?Q?Rados=C5=82aw_Biernacki?= <rad@semihalf.com>,
        Marcin Wojtas <mw@semihalf.com>,
        Alex Levin <levinale@google.com>,
        Guenter Roeck <groeck@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        "Sarvela, Tomi P" <tomi.p.sarvela@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Actually I have a serial console attached (via servo device), but
there is no output :( and also the reboot/crash is very fast/immediate
after power on.

Best regards
Lukasz

=C5=9Br., 27 sty 2021 o 11:05 Mike Rapoport <rppt@linux.ibm.com> napisa=C5=
=82(a):
>
> Hi Lukasz,
>
> On Wed, Jan 27, 2021 at 10:22:29AM +0100, =C5=81ukasz Majczak wrote:
> > Crash after mm: fix initialization of struct page for holes in memory l=
ayout
> >
> > Hi,
> > I was trying to run v5.11-rc5 on my Samsung Chromebook Pro (Caroline),
> > but I've noticed it has crashed - unfortunately it seems to happen at
> > a very early stage - No output to the console nor to the screen, so I
> > have started a bisect (between 5.11-rc4 - which works just find - and
> > 5.11-rc5),
> > bisect results points to:
> >
> > d3921cb8be29 mm: fix initialization of struct page for holes in memory =
layout
> >
> > Reproduction is just to build and load the kernel.
> >
> > If it will help any how I am attaching:
> > - /proc/cpuinfo (from healthy system):
> > https://gist.github.com/semihalf-majczak-lukasz/3517867bf39f07377c1a785=
b64a97066
> > - my .config file (for a broken system):
> > https://gist.github.com/semihalf-majczak-lukasz/584b329f1bf3e43b53efe8e=
18b5da33c
> >
> > If there is anything I could add/do/test to help fix this please let me=
 know.
>
> Chris Wilson also reported boot failures on several Chromebooks:
>
> https://lore.kernel.org/lkml/161160687463.28991.354987542182281928@build.=
alporthouse.com
>
> I presume serial console is not an option, so if you could boot with
> earlyprintk=3Dvga and see if there is anything useful printed on the scre=
en
> it would be really helpful.
>
> > Best regards
> > Lukasz
>
> --
> Sincerely yours,
> Mike.
