Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B52F3063EF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 20:20:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344380AbhA0TTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 14:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344300AbhA0TT0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 14:19:26 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 106FDC061573
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:18:46 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id u4so1985715pjn.4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 11:18:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=p2S96QDDNUIXc9tL2w1AIuzEgTZ6BCZqglNvFX/RFaU=;
        b=gM2JI1c2/TWVkOiXiJkIGsaz85QWwAw3h/aChgK4ruvRoUelL7VZehXx1bbyLnCswe
         HyCz4B1674Q28kmojxAx24SNWMZtYrHAcxjWKSRGmk8ICkyhSTJDu1skXnyyx/rO2ciU
         vjvkf8aJAfeM2SZV2MuGhtAfXDSItAopjphPMl5lvWNMIFZI/qOiLZ+9afzh7pjQvFxE
         67o+ylHuqfbi+xnBxnb1Q1zfKiEWYsgisdiu5L+w5ANJTvi6u3qUOTf6D8zpd1uwunwP
         HQh5AALW1P9ZCZAUZZ2jgWnVrrOR0SINhFWV4uF5Zoxb/sthJ1/h1q3mF7MpYCrU23Ad
         0Xwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=p2S96QDDNUIXc9tL2w1AIuzEgTZ6BCZqglNvFX/RFaU=;
        b=dZ+kgJMBcdzJDFhhEr522e4yzpten01G7bHzl58N3UZL5Fe5bNjkzEfMmnlpvrcgQ/
         if3ykwimkW6MvY+nTbxHScK6F0hvK6SV84rIxcvm9SLa+NEYFEId1KWPDsQAWYau4nNA
         aiQecbwhyKxnboi54Mb3KHD9h8aIsORbZOv2eAHDKTWY7ZqddG70+AG+QiAbtoxb+/YT
         /hi2OVCPmLUT3lsa9VXn3gf9kX0UIWPfBs/yDG6VxlJRsv/Ix1BXTqS9N/X1zU3xVsbp
         0C6MPx7jSsKvGDavXViMA91+sYF3TMmlUbAppK9f8szWN3sFdLsan/9md5dXubHwe52u
         FcDg==
X-Gm-Message-State: AOAM533ymOZuIGZOyO88y6aIw8ZnedSqEXIey1ePDR4Lhjp7dmaBLlsT
        5rzBSg35v9JGbX0qpG4QBeffPz8GaWVBAlr/iOn3/EvKDAysW64Q5+s=
X-Google-Smtp-Source: ABdhPJzTVgkTUC/dG3jlKvLsUKl6+RxPD+Bh4SS0V6yYGwubtqdGapS22lHSRyHJb6BJDwtJX2kMYoOFRf7Fbv2t+zM=
X-Received: by 2002:a17:90a:3b04:: with SMTP id d4mr7115398pjc.48.1611775125508;
 Wed, 27 Jan 2021 11:18:45 -0800 (PST)
MIME-Version: 1.0
References: <CAFJ_xbqT8h2Exix3S6AGgB7W1N0u-=WKffAyb7Hk9-8K8FBwKA@mail.gmail.com>
 <20210127100454.GK196782@linux.ibm.com> <CAFJ_xboaFNQ9NuZ1rhH8WdejoFRzvez9cp2AQ59rKY6T_xZ-_w@mail.gmail.com>
 <20210127111858.GA273567@linux.ibm.com> <CAFJ_xbo8Zv9VdJibC106sFOqoYsVhifm0eh=VWtMzeoUE4KVWA@mail.gmail.com>
 <CAFJ_xbrwLwgDfCyHA=PmJ8j_3dJXqVNxmv7e+ATQAAa9n3de2w@mail.gmail.com> <20210127182651.GA281042@linux.ibm.com>
In-Reply-To: <20210127182651.GA281042@linux.ibm.com>
From:   =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>
Date:   Wed, 27 Jan 2021 20:18:34 +0100
Message-ID: <CAFJ_xbqHq-P8z-xpkVDAQsG1s4j5FMmXFnyXLzd=ja8y_=8LfA@mail.gmail.com>
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
        "Sarvela, Tomi P" <tomi.p.sarvela@intel.com>,
        =?UTF-8?Q?=C5=81ukasz_Bartosik?= <lb@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mike,

Great ! it seems to work well - I have built a valila kernel v5.11-rc5
with your patch and it boots properly.
Full log available here:
https://gist.github.com/semihalf-majczak-lukasz/ea89bf52f6fad7907a18d1870e7=
ce9bd

Best regards,
Lukasz

=C5=9Br., 27 sty 2021 o 19:27 Mike Rapoport <rppt@linux.ibm.com> napisa=C5=
=82(a):
>
> Hi Lukasz,
>
> On Wed, Jan 27, 2021 at 02:15:53PM +0100, =C5=81ukasz Majczak wrote:
> > Hi Mike,
> >
> > I have started bisecting your patch and I have figured out that there
> > might be something wrong with clamping - with comments out these lines
> > it started to work.
> > The full log (with logs from below patch) can be found here:
> > https://gist.github.com/semihalf-majczak-lukasz/3cecbab0ddc59a6c3ce11dd=
c29645725
> > it's fresh - I haven't analyze it yet, just sharing with hope it will h=
elp.
>
> Thanks, that helps!
>
> The first page is never considered by the kernel as memory and so
> arch_zone_lowest_possible_pfn[ZONE_DMA] is set to 0x1000. As the result,
> init_unavailable_mem() skips pfn 0 and then __SetPageReserved(page) in
> reserve_bootmem_region() panics because the struct page for pfn 0 remains
> poisoned.
>
> Can you please try the below patch on top of v5.11-rc5?
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 783913e41f65..3ce9ef238dfc 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -7083,10 +7083,11 @@ void __init free_area_init_memoryless_node(int ni=
d)
>  static u64 __init init_unavailable_range(unsigned long spfn, unsigned lo=
ng epfn,
>                                          int zone, int nid)
>  {
> -       unsigned long pfn, zone_spfn, zone_epfn;
> +       unsigned long pfn, zone_spfn =3D 0, zone_epfn;
>         u64 pgcnt =3D 0;
>
> -       zone_spfn =3D arch_zone_lowest_possible_pfn[zone];
> +       if (zone > 0)
> +               zone_spfn =3D arch_zone_highest_possible_pfn[zone - 1];
>         zone_epfn =3D arch_zone_highest_possible_pfn[zone];
>
>         spfn =3D clamp(spfn, zone_spfn, zone_epfn);
>
>
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index eed54ce26ad1..9f4468c413a1 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -7093,9 +7093,11 @@ static u64 __init
> > init_unavailable_range(unsigned long spfn, unsigned long epfn,
> >         zone_spfn =3D arch_zone_lowest_possible_pfn[zone];
> >         zone_epfn =3D arch_zone_highest_possible_pfn[zone];
> >
> > -       spfn =3D clamp(spfn, zone_spfn, zone_epfn);
> > -       epfn =3D clamp(epfn, zone_spfn, zone_epfn);
> > -
> > +       //spfn =3D clamp(spfn, zone_spfn, zone_epfn);
> > +       //epfn =3D clamp(epfn, zone_spfn, zone_epfn);
> > +       pr_info("LMA DBG: zone_spfn: %llx, zone_epfn %llx\n",
> > zone_spfn, zone_epfn);
> > +       pr_info("LMA DBG: spfn: %llx, epfn %llx\n", spfn, epfn);
> > +       pr_info("LMA DBG: clamp_spfn: %llx, clamp_epfn %llx\n",
> > clamp(spfn, zone_spfn, zone_epfn), clamp(epfn, zone_spfn, zone_epfn));
> >         for (pfn =3D spfn; pfn < epfn; pfn++) {
> >                 if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
> >                         pfn =3D ALIGN_DOWN(pfn, pageblock_nr_pages)
> >
> > Best regards,
> > Lukasz
> >
> >
> > =C5=9Br., 27 sty 2021 o 13:15 =C5=81ukasz Majczak <lma@semihalf.com> na=
pisa=C5=82(a):
> > >
> > > Unfortunately nothing :( my current kernel command line contains:
> > > console=3DttyS0,115200n8 debug earlyprintk=3Dserial loglevel=3D7
> > >
> > > I was thinking about using earlycon, but it seems to be blocked.
> > > (I think the lack of earlycon might be related to Chromebook HW
> > > security design. There is an EC controller which is a part of AP ->
> > > serial chain as kernel messages are considered sensitive from a
> > > security standpoint.)
> > >
> > > Best regards,
> > > Lukasz
> > >
> > > =C5=9Br., 27 sty 2021 o 12:19 Mike Rapoport <rppt@linux.ibm.com> napi=
sa=C5=82(a):
> > > >
> > > > On Wed, Jan 27, 2021 at 11:08:17AM +0100, =C5=81ukasz Majczak wrote=
:
> > > > > Hi Mike,
> > > > >
> > > > > Actually I have a serial console attached (via servo device), but
> > > > > there is no output :( and also the reboot/crash is very fast/imme=
diate
> > > > > after power on.
> > > >
> > > > If you boot with earlyprintk=3Dserial are there any messages?
> > > >
> > > > > Best regards
> > > > > Lukasz
> > > > >
> > > > > =C5=9Br., 27 sty 2021 o 11:05 Mike Rapoport <rppt@linux.ibm.com> =
napisa=C5=82(a):
> > > > > >
> > > > > > Hi Lukasz,
> > > > > >
> > > > > > On Wed, Jan 27, 2021 at 10:22:29AM +0100, =C5=81ukasz Majczak w=
rote:
> > > > > > > Crash after mm: fix initialization of struct page for holes i=
n memory layout
> > > > > > >
> > > > > > > Hi,
> > > > > > > I was trying to run v5.11-rc5 on my Samsung Chromebook Pro (C=
aroline),
> > > > > > > but I've noticed it has crashed - unfortunately it seems to h=
appen at
> > > > > > > a very early stage - No output to the console nor to the scre=
en, so I
> > > > > > > have started a bisect (between 5.11-rc4 - which works just fi=
nd - and
> > > > > > > 5.11-rc5),
> > > > > > > bisect results points to:
> > > > > > >
> > > > > > > d3921cb8be29 mm: fix initialization of struct page for holes =
in memory layout
> > > > > > >
> > > > > > > Reproduction is just to build and load the kernel.
> > > > > > >
> > > > > > > If it will help any how I am attaching:
> > > > > > > - /proc/cpuinfo (from healthy system):
> > > > > > > https://gist.github.com/semihalf-majczak-lukasz/3517867bf39f0=
7377c1a785b64a97066
> > > > > > > - my .config file (for a broken system):
> > > > > > > https://gist.github.com/semihalf-majczak-lukasz/584b329f1bf3e=
43b53efe8e18b5da33c
> > > > > > >
> > > > > > > If there is anything I could add/do/test to help fix this ple=
ase let me know.
> > > > > >
> > > > > > Chris Wilson also reported boot failures on several Chromebooks=
:
> > > > > >
> > > > > > https://lore.kernel.org/lkml/161160687463.28991.354987542182281=
928@build.alporthouse.com
> > > > > >
> > > > > > I presume serial console is not an option, so if you could boot=
 with
> > > > > > earlyprintk=3Dvga and see if there is anything useful printed o=
n the screen
> > > > > > it would be really helpful.
> > > > > >
> > > > > > > Best regards
> > > > > > > Lukasz
> > > > > >
> > > > > > --
> > > > > > Sincerely yours,
> > > > > > Mike.
> > > >
> > > > --
> > > > Sincerely yours,
> > > > Mike.
>
> --
> Sincerely yours,
> Mike.
