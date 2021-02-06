Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAEB9311C66
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Feb 2021 10:35:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbhBFJew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Feb 2021 04:34:52 -0500
Received: from mail-oo1-f47.google.com ([209.85.161.47]:46259 "EHLO
        mail-oo1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbhBFJe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Feb 2021 04:34:28 -0500
Received: by mail-oo1-f47.google.com with SMTP id 123so2248940ooi.13
        for <linux-kernel@vger.kernel.org>; Sat, 06 Feb 2021 01:34:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XFFDEkopwcHNc74GjE/yhhK68CfD6gYZp1kAhc2ZkFo=;
        b=gTcZqUMj4y2g26u7pY/4ARextYqMgIVgvZ29khGwgouFIbkwBOwoh0PEZKqHWFoKD9
         W6W6wKcp2IE600bUJUk9YmY/aPgaAfoupYMemBf0l+YFblhF+O3x2GQCCuyRbdlTIwS8
         iy1TnmwmaZ6pANPzva3xMdzqxugkYsZlpN+BJxKjmM4kTSZauzs5Vjb4p03qFmM2h3b6
         KtbxhcvDnbUwoJurudyjHxLjnpWylwOaa3lAjb3NYJxDqfJFLfxFrsP9rWHVpNhrXPpU
         YkE2PKzmmvRW5Qc+QnwLzIPhnOEInh2u4d+6wyECV6cApyFOPck335gKMIDNsGDBzAcc
         qO5A==
X-Gm-Message-State: AOAM530/uF6yWFStnyvv3iNW/xlxUjpbLoVi5YQqNAwM9IQm0gcLp63u
        x13vdy9Qfjzzxk5qG6grF0jNydbuH3aH0FVs+NQ=
X-Google-Smtp-Source: ABdhPJyvktGIGV1kS455fRCji4bXochr9MKhRoJB+FzPrg7h++oQvydzh+fr9PnRq+BLts9gL3LxNMmV/MDiVD7Kvqs=
X-Received: by 2002:a4a:945:: with SMTP id 66mr971140ooa.1.1612604015882; Sat,
 06 Feb 2021 01:33:35 -0800 (PST)
MIME-Version: 1.0
References: <0b26eda7-229d-3dc9-f2ae-19b9212fb0ea@rwth-aachen.de>
 <20210129221643.GZ2002709@lianli.shorne-pla.net> <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de>
 <20210130230310.GC2002709@lianli.shorne-pla.net> <d9f4aafc-4d65-38b0-dde0-5e155836aee1@rwth-aachen.de>
 <20210131212752.GG2002709@lianli.shorne-pla.net> <6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de>
 <20210205144317.GK2002709@lianli.shorne-pla.net> <CAMuHMdXzr4c4=Cg1_Lmw41cmxmMrG4P=dV0yVjuXvuR5pqyh0Q@mail.gmail.com>
 <20210205223651.GL2002709@lianli.shorne-pla.net>
In-Reply-To: <20210205223651.GL2002709@lianli.shorne-pla.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Sat, 6 Feb 2021 10:33:24 +0100
Message-ID: <CAMuHMdV5M2X+zC9e2VidEt6vNdnP1j3yeB4tJTRgkCCDCwV8hQ@mail.gmail.com>
Subject: Re: [PATCH v2] openrisc: use device tree to determine present cpus
To:     Stafford Horne <shorne@gmail.com>
Cc:     Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Openrisc <openrisc@lists.librecores.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stafford,

On Fri, Feb 5, 2021 at 11:36 PM Stafford Horne <shorne@gmail.com> wrote:
> On Fri, Feb 05, 2021 at 05:07:51PM +0100, Geert Uytterhoeven wrote:
> > On Fri, Feb 5, 2021 at 3:43 PM Stafford Horne <shorne@gmail.com> wrote:
> > > On Mon, Feb 01, 2021 at 12:49:31PM +0100, Jan Henrik Weinstock wrote:
> > > > Use the device tree to determine the present cpus instead of assuming all
> > > > CONFIG_NRCPUS are actually present in the system.
> > > >
> > > > Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
> > >
> > > I cannot apply this patch, it seems you somehow sent it signed as a multipart
> > > message via Thunderbird.
> > >
> > > This causes errors when trying to apply, even after I tried to manually fix the
> > > patch mail:
> > >
> > >     Applying: openrisc: use device tree to determine present cpus
> > >     error: sha1 information is lacking or useless (arch/openrisc/kernel/smp.c).
> > >     error: could not build fake ancestor
> > >     Patch failed at 0001 openrisc: use device tree to determine present cpus
> > >
> > > Can you send this using 'git send-email?'
> > >
> > > If not I can get it applied with some work, otherwise you can point me to a git
> > > repo which I can pull it from.
> >
> > "b4 am 6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de" works
> > fine for me.
> >
> > git://git.kernel.org/pub/scm/utils/b4/b4.git
>
> Did it work?  For me I got, base not found.
>
>     Looking up
>     https://lore.kernel.org/r/6dbc27f8-5261-59c5-acba-70f6c6a74ba1%40rwth-aachen.de
>     Grabbing thread from lore.kernel.org/lkml
>     Analyzing 9 messages in the thread
>     Will use the latest revision: v2
>     You can pick other revisions using the -vN flag
>     ---
>     Writing
>     ./v2_20210201_jan_weinstock_openrisc_use_device_tree_to_determine_present_cpus.mbx
>       [PATCH v2] openrisc: use device tree to determine present cpus
>     ---
>     Total patches: 1
>     ---
>      Link:
>     https://lore.kernel.org/r/6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de
>      Base: not found

That just means the patch contains no information w.r.t. its base, i.e.
against which tree/commit it applies to.  To be ignored.

>            git am
>     ./v2_20210201_jan_weinstock_openrisc_use_device_tree_to_determine_present_cpus.mbx

Just run the above command ;-)

In addition, you can run "formail -s scripts/checkpatch.pl < *mbx" first, to
run the mbox (which could contain multiple patches) through checkpatch.


Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
