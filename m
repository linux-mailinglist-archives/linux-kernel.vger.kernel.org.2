Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EBC4305B1F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 13:21:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237653AbhA0MV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 07:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbhA0MQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 07:16:16 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87B78C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 04:15:25 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id o7so1476056pgl.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 04:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9gta6x0QNM0KEQiYKbjvUoee3fwpqJfT+h2l/JxVVIc=;
        b=W7XHOat00nAOlB1D2IMZTvVe4bBPx9EWxubVPPCIhmQyM30LnZTZwHXXEvxX14JwkP
         DOPwbZjA3seoE+CTfkZxXvHBDwShISVh298GDewbHa/Y47f57B3zb7bnRL4CDP9eBcQZ
         NxuTkdfYqHksyDZEqzooCHT8I68+BIVvdoKHYlAUB2mDCUvYNH84ZyjHnkpWeOkIDvjc
         krH0O2/drfQYs67iRqBB33Pk2bbyh5pnseyXcXooK/bUe/aibLOAunKkX1g40rZIDESQ
         D91R9F/JqierJbnDWBgdfT7w+UtXdXz8uQwODV/uijmljurCAVZj4m+v7QBhGYb0bsFA
         xbNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9gta6x0QNM0KEQiYKbjvUoee3fwpqJfT+h2l/JxVVIc=;
        b=FpEaOYgFskwOlnMtdNuS3FuZctQES5RMa1VDresAKx7bYe1Txl9Ds8TUZ6wpzeDDFf
         FCnQlil1zpwHwEDA1ph8NW16d6SmPGIDuxIFaRwmpWd50eUPwenaCrQe17ZBizNi/EVe
         +g5WRzlPGDaTZgoWNAXCX6qcHn2z4jJcX8c8aGfhUmEGAoE8S69AjXsr0Vc5oUjFn2tV
         AfP5/VaB7qrqofRihw1aXP+ZtL+lqcfDWHfYSeYC6i8Jt3YGgQ/7En2dRVvxSDkP4iiI
         J5c8NfRDX4HTSEhO4cRLYhwN+rNQSADMOV12/V1+N0ub2oEmrkzAlRKZoT8/4oKsRDQm
         LxDA==
X-Gm-Message-State: AOAM530e3DYgccsmZIUdwt02JwOaMUEDabnwOTtMqFPfyDne371ZrEX+
        Whfw7TXdUY5cp92/tTmmHKriI6Bw7seBZyGbzbvmiA==
X-Google-Smtp-Source: ABdhPJzlp0xIxfYkX/lfLr9s78qS0ay/2zCRG/chpauCrQMMafTYf2sgGg6FT2+dLGTdzuTUoshNBhncCIh2TOA2jL0=
X-Received: by 2002:a65:64da:: with SMTP id t26mr10814245pgv.145.1611749725065;
 Wed, 27 Jan 2021 04:15:25 -0800 (PST)
MIME-Version: 1.0
References: <CAFJ_xbqT8h2Exix3S6AGgB7W1N0u-=WKffAyb7Hk9-8K8FBwKA@mail.gmail.com>
 <20210127100454.GK196782@linux.ibm.com> <CAFJ_xboaFNQ9NuZ1rhH8WdejoFRzvez9cp2AQ59rKY6T_xZ-_w@mail.gmail.com>
 <20210127111858.GA273567@linux.ibm.com>
In-Reply-To: <20210127111858.GA273567@linux.ibm.com>
From:   =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>
Date:   Wed, 27 Jan 2021 13:15:14 +0100
Message-ID: <CAFJ_xbo8Zv9VdJibC106sFOqoYsVhifm0eh=VWtMzeoUE4KVWA@mail.gmail.com>
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

Unfortunately nothing :( my current kernel command line contains:
console=3DttyS0,115200n8 debug earlyprintk=3Dserial loglevel=3D7

I was thinking about using earlycon, but it seems to be blocked.
(I think the lack of earlycon might be related to Chromebook HW
security design. There is an EC controller which is a part of AP ->
serial chain as kernel messages are considered sensitive from a
security standpoint.)

Best regards,
Lukasz

=C5=9Br., 27 sty 2021 o 12:19 Mike Rapoport <rppt@linux.ibm.com> napisa=C5=
=82(a):
>
> On Wed, Jan 27, 2021 at 11:08:17AM +0100, =C5=81ukasz Majczak wrote:
> > Hi Mike,
> >
> > Actually I have a serial console attached (via servo device), but
> > there is no output :( and also the reboot/crash is very fast/immediate
> > after power on.
>
> If you boot with earlyprintk=3Dserial are there any messages?
>
> > Best regards
> > Lukasz
> >
> > =C5=9Br., 27 sty 2021 o 11:05 Mike Rapoport <rppt@linux.ibm.com> napisa=
=C5=82(a):
> > >
> > > Hi Lukasz,
> > >
> > > On Wed, Jan 27, 2021 at 10:22:29AM +0100, =C5=81ukasz Majczak wrote:
> > > > Crash after mm: fix initialization of struct page for holes in memo=
ry layout
> > > >
> > > > Hi,
> > > > I was trying to run v5.11-rc5 on my Samsung Chromebook Pro (Carolin=
e),
> > > > but I've noticed it has crashed - unfortunately it seems to happen =
at
> > > > a very early stage - No output to the console nor to the screen, so=
 I
> > > > have started a bisect (between 5.11-rc4 - which works just find - a=
nd
> > > > 5.11-rc5),
> > > > bisect results points to:
> > > >
> > > > d3921cb8be29 mm: fix initialization of struct page for holes in mem=
ory layout
> > > >
> > > > Reproduction is just to build and load the kernel.
> > > >
> > > > If it will help any how I am attaching:
> > > > - /proc/cpuinfo (from healthy system):
> > > > https://gist.github.com/semihalf-majczak-lukasz/3517867bf39f07377c1=
a785b64a97066
> > > > - my .config file (for a broken system):
> > > > https://gist.github.com/semihalf-majczak-lukasz/584b329f1bf3e43b53e=
fe8e18b5da33c
> > > >
> > > > If there is anything I could add/do/test to help fix this please le=
t me know.
> > >
> > > Chris Wilson also reported boot failures on several Chromebooks:
> > >
> > > https://lore.kernel.org/lkml/161160687463.28991.354987542182281928@bu=
ild.alporthouse.com
> > >
> > > I presume serial console is not an option, so if you could boot with
> > > earlyprintk=3Dvga and see if there is anything useful printed on the =
screen
> > > it would be really helpful.
> > >
> > > > Best regards
> > > > Lukasz
> > >
> > > --
> > > Sincerely yours,
> > > Mike.
>
> --
> Sincerely yours,
> Mike.
