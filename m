Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A37B305CCF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 14:17:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbhA0NRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jan 2021 08:17:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238117AbhA0NQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jan 2021 08:16:45 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1E6C061574
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 05:16:05 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id j12so1156002pfj.12
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jan 2021 05:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=391pCHS4EGbiAr5AejYZ6osmDLj6EdhSwcDvRToN/qs=;
        b=GGCcaELTAwMNoE0IgGE2gzo1Gg4zeEZyZoJ4GN9kXHA81gH38mHWtk9s5yWz74Z3HH
         XukSycg2R7I6EBXChp197zD7vmN5rNGz7R221R3kM/cFvoyIimHj2VqlG2Z0+sHupdqY
         yW1Qz0uUMV/DG7VVy25Ks4N4n+l6wsqge/wHp1as+HvWpKSxHwO6qwDDK7wATtYLST9r
         G00Y8sXaAKxrynA7xYLLRnH9OIFKF3NrdFFY7H64/cVRM6gm3YnuC9+jHqtZ1ZJzVe+Y
         pgJmkQ3fbgCiWZP2weYvF/Ml5z+/iAZ3+qeUUzxc0PaEh4mkSSI74QcpGOw5h2mdKo30
         aU2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=391pCHS4EGbiAr5AejYZ6osmDLj6EdhSwcDvRToN/qs=;
        b=kQM0fTq2//Xi6r3J0XBV84GJ06XKiFI1x/DKngTSkXIIfcFj0dstiu9Bk5wyXYQxtM
         8VPZhfaHRCkRBJTV6gEaYu/Olzyfs4CaK0Mex0ixIMmT59SIuQpJizUi+0076iiSPSyt
         u+v7k3MU1v21DvQtvUuNco6SBkBA8QrOTAyjkeMF1a3qABYRzTGTjXpcHzGuoiYZmH9y
         OpyJ2dxKYH5KQv0nTmgWOjzkEjhtJ+A7u+63afqbBP7l+B64Fpw/HXAcmXcEgXT7r2Jt
         TDFTq8Bi/bMzTRintcdwBlc9yXEv7ocwUrUN59vJwEoEZVx4gmRnCTaBND4E+cCChtsy
         VmMw==
X-Gm-Message-State: AOAM530QqSTrkOjTakQGQy9DbDbtx96Vj5OmIjLKFqbgZKcExNPHJXKk
        QoB8QuZvKfD+rK1GdjHRXgO4mSBafZudRvtxb+lrww==
X-Google-Smtp-Source: ABdhPJzLgqy2yMNKTlIe79dYdP9ecnMteA4MDflLyeovzM4jbZpkmJFwt1g4uezdFbuSpxNAMHAIKXSsLxKu0DvXJ3I=
X-Received: by 2002:a65:418b:: with SMTP id a11mr11118378pgq.231.1611753364610;
 Wed, 27 Jan 2021 05:16:04 -0800 (PST)
MIME-Version: 1.0
References: <CAFJ_xbqT8h2Exix3S6AGgB7W1N0u-=WKffAyb7Hk9-8K8FBwKA@mail.gmail.com>
 <20210127100454.GK196782@linux.ibm.com> <CAFJ_xboaFNQ9NuZ1rhH8WdejoFRzvez9cp2AQ59rKY6T_xZ-_w@mail.gmail.com>
 <20210127111858.GA273567@linux.ibm.com> <CAFJ_xbo8Zv9VdJibC106sFOqoYsVhifm0eh=VWtMzeoUE4KVWA@mail.gmail.com>
In-Reply-To: <CAFJ_xbo8Zv9VdJibC106sFOqoYsVhifm0eh=VWtMzeoUE4KVWA@mail.gmail.com>
From:   =?UTF-8?Q?=C5=81ukasz_Majczak?= <lma@semihalf.com>
Date:   Wed, 27 Jan 2021 14:15:53 +0100
Message-ID: <CAFJ_xbrwLwgDfCyHA=PmJ8j_3dJXqVNxmv7e+ATQAAa9n3de2w@mail.gmail.com>
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

I have started bisecting your patch and I have figured out that there
might be something wrong with clamping - with comments out these lines
it started to work.
The full log (with logs from below patch) can be found here:
https://gist.github.com/semihalf-majczak-lukasz/3cecbab0ddc59a6c3ce11ddc296=
45725
it's fresh - I haven't analyze it yet, just sharing with hope it will help.

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index eed54ce26ad1..9f4468c413a1 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -7093,9 +7093,11 @@ static u64 __init
init_unavailable_range(unsigned long spfn, unsigned long epfn,
        zone_spfn =3D arch_zone_lowest_possible_pfn[zone];
        zone_epfn =3D arch_zone_highest_possible_pfn[zone];

-       spfn =3D clamp(spfn, zone_spfn, zone_epfn);
-       epfn =3D clamp(epfn, zone_spfn, zone_epfn);
-
+       //spfn =3D clamp(spfn, zone_spfn, zone_epfn);
+       //epfn =3D clamp(epfn, zone_spfn, zone_epfn);
+       pr_info("LMA DBG: zone_spfn: %llx, zone_epfn %llx\n",
zone_spfn, zone_epfn);
+       pr_info("LMA DBG: spfn: %llx, epfn %llx\n", spfn, epfn);
+       pr_info("LMA DBG: clamp_spfn: %llx, clamp_epfn %llx\n",
clamp(spfn, zone_spfn, zone_epfn), clamp(epfn, zone_spfn, zone_epfn));
        for (pfn =3D spfn; pfn < epfn; pfn++) {
                if (!pfn_valid(ALIGN_DOWN(pfn, pageblock_nr_pages))) {
                        pfn =3D ALIGN_DOWN(pfn, pageblock_nr_pages)

Best regards,
Lukasz


=C5=9Br., 27 sty 2021 o 13:15 =C5=81ukasz Majczak <lma@semihalf.com> napisa=
=C5=82(a):
>
> Unfortunately nothing :( my current kernel command line contains:
> console=3DttyS0,115200n8 debug earlyprintk=3Dserial loglevel=3D7
>
> I was thinking about using earlycon, but it seems to be blocked.
> (I think the lack of earlycon might be related to Chromebook HW
> security design. There is an EC controller which is a part of AP ->
> serial chain as kernel messages are considered sensitive from a
> security standpoint.)
>
> Best regards,
> Lukasz
>
> =C5=9Br., 27 sty 2021 o 12:19 Mike Rapoport <rppt@linux.ibm.com> napisa=
=C5=82(a):
> >
> > On Wed, Jan 27, 2021 at 11:08:17AM +0100, =C5=81ukasz Majczak wrote:
> > > Hi Mike,
> > >
> > > Actually I have a serial console attached (via servo device), but
> > > there is no output :( and also the reboot/crash is very fast/immediat=
e
> > > after power on.
> >
> > If you boot with earlyprintk=3Dserial are there any messages?
> >
> > > Best regards
> > > Lukasz
> > >
> > > =C5=9Br., 27 sty 2021 o 11:05 Mike Rapoport <rppt@linux.ibm.com> napi=
sa=C5=82(a):
> > > >
> > > > Hi Lukasz,
> > > >
> > > > On Wed, Jan 27, 2021 at 10:22:29AM +0100, =C5=81ukasz Majczak wrote=
:
> > > > > Crash after mm: fix initialization of struct page for holes in me=
mory layout
> > > > >
> > > > > Hi,
> > > > > I was trying to run v5.11-rc5 on my Samsung Chromebook Pro (Carol=
ine),
> > > > > but I've noticed it has crashed - unfortunately it seems to happe=
n at
> > > > > a very early stage - No output to the console nor to the screen, =
so I
> > > > > have started a bisect (between 5.11-rc4 - which works just find -=
 and
> > > > > 5.11-rc5),
> > > > > bisect results points to:
> > > > >
> > > > > d3921cb8be29 mm: fix initialization of struct page for holes in m=
emory layout
> > > > >
> > > > > Reproduction is just to build and load the kernel.
> > > > >
> > > > > If it will help any how I am attaching:
> > > > > - /proc/cpuinfo (from healthy system):
> > > > > https://gist.github.com/semihalf-majczak-lukasz/3517867bf39f07377=
c1a785b64a97066
> > > > > - my .config file (for a broken system):
> > > > > https://gist.github.com/semihalf-majczak-lukasz/584b329f1bf3e43b5=
3efe8e18b5da33c
> > > > >
> > > > > If there is anything I could add/do/test to help fix this please =
let me know.
> > > >
> > > > Chris Wilson also reported boot failures on several Chromebooks:
> > > >
> > > > https://lore.kernel.org/lkml/161160687463.28991.354987542182281928@=
build.alporthouse.com
> > > >
> > > > I presume serial console is not an option, so if you could boot wit=
h
> > > > earlyprintk=3Dvga and see if there is anything useful printed on th=
e screen
> > > > it would be really helpful.
> > > >
> > > > > Best regards
> > > > > Lukasz
> > > >
> > > > --
> > > > Sincerely yours,
> > > > Mike.
> >
> > --
> > Sincerely yours,
> > Mike.
