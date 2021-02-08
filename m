Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BC2331326C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 13:34:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233001AbhBHMd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 07:33:29 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:33550 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbhBHMXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 07:23:38 -0500
Received: by mail-oi1-f174.google.com with SMTP id g84so1581966oib.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 04:23:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dQEwbiMypKhbBuryhmpezZFoAPFM9BbLGoij2BA5Z4A=;
        b=P08Eh1b7G4IoBa52wZ9xBgrPDcISlUuYeadvVcX6vHyxNsqCPoDxvtqjGuXFHGidtX
         YG4CEUMG1+thJpSJVuqI3Us0v3pQEBcvjLLfNM5g9GTPd9aeauMxskmV9nwm1Teb6uSi
         gY1oHJUlxx43IULY6crPnTAVv4c5uAmErSNOnLf5ywV4jwOL+DkkQowY8+OXgKrsm6KK
         W3PZ2AuUEnZtBQbj9zvRqPwxiPUiOk58gcboDKTxspeSRdJVGe6NvjOHSJpQ1AMNLZbp
         xytJgsp0cvetAObIuru1nNQ/2Ypk1Rs3vjXJeJ+rbp3N3jbrwQGwDFEmDoWZtgujLkHJ
         vW8A==
X-Gm-Message-State: AOAM532tHL1e8GTz+51PCHNXkChe71KX4+z3hjdvcaBYLOTGa/xewtPi
        Fv085L65uocIDKl/2v7rBH3krcThT0jnBvwYW1E=
X-Google-Smtp-Source: ABdhPJywfzB9Kk6b5rXnkwWOB6X31LNV+BNE4AyEz3vkr6HWoXyU8AZXdcKA+Fx5WNegLAVroYMvIoWDF9ciwa238WI=
X-Received: by 2002:a54:4e88:: with SMTP id c8mr10766501oiy.148.1612786977234;
 Mon, 08 Feb 2021 04:22:57 -0800 (PST)
MIME-Version: 1.0
References: <20210129221643.GZ2002709@lianli.shorne-pla.net>
 <2a018afc-d797-3a91-ffab-e55ae3b0a795@rwth-aachen.de> <20210130230310.GC2002709@lianli.shorne-pla.net>
 <d9f4aafc-4d65-38b0-dde0-5e155836aee1@rwth-aachen.de> <20210131212752.GG2002709@lianli.shorne-pla.net>
 <6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de> <20210205144317.GK2002709@lianli.shorne-pla.net>
 <CAMuHMdXzr4c4=Cg1_Lmw41cmxmMrG4P=dV0yVjuXvuR5pqyh0Q@mail.gmail.com>
 <20210205223651.GL2002709@lianli.shorne-pla.net> <CAMuHMdV5M2X+zC9e2VidEt6vNdnP1j3yeB4tJTRgkCCDCwV8hQ@mail.gmail.com>
 <20210208121648.GN2002709@lianli.shorne-pla.net>
In-Reply-To: <20210208121648.GN2002709@lianli.shorne-pla.net>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 8 Feb 2021 13:22:46 +0100
Message-ID: <CAMuHMdXRs_aE7NxC-nUXzskjLQTMG4--mJ23GNFELMY+S9863g@mail.gmail.com>
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

On Mon, Feb 8, 2021 at 1:16 PM Stafford Horne <shorne@gmail.com> wrote:
> On Sat, Feb 06, 2021 at 10:33:24AM +0100, Geert Uytterhoeven wrote:
> > On Fri, Feb 5, 2021 at 11:36 PM Stafford Horne <shorne@gmail.com> wrote:
> > > On Fri, Feb 05, 2021 at 05:07:51PM +0100, Geert Uytterhoeven wrote:
> > > > On Fri, Feb 5, 2021 at 3:43 PM Stafford Horne <shorne@gmail.com> wrote:
> > > > > On Mon, Feb 01, 2021 at 12:49:31PM +0100, Jan Henrik Weinstock wrote:
> > > > > > Use the device tree to determine the present cpus instead of assuming all
> > > > > > CONFIG_NRCPUS are actually present in the system.
> > > > > >
> > > > > > Signed-off-by: Jan Henrik Weinstock <jan.weinstock@rwth-aachen.de>
> > > > >
> > > > > I cannot apply this patch, it seems you somehow sent it signed as a multipart
> > > > > message via Thunderbird.
> > > > >
> > > > > This causes errors when trying to apply, even after I tried to manually fix the
> > > > > patch mail:
> > > > >
> > > > >     Applying: openrisc: use device tree to determine present cpus
> > > > >     error: sha1 information is lacking or useless (arch/openrisc/kernel/smp.c).
> > > > >     error: could not build fake ancestor
> > > > >     Patch failed at 0001 openrisc: use device tree to determine present cpus
> > > > >
> > > > > Can you send this using 'git send-email?'
> > > > >
> > > > > If not I can get it applied with some work, otherwise you can point me to a git
> > > > > repo which I can pull it from.
> > > >
> > > > "b4 am 6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de" works
> > > > fine for me.
> > > >
> > > > git://git.kernel.org/pub/scm/utils/b4/b4.git
> > >
> > > Did it work?  For me I got, base not found.
> > >
> > >     Looking up
> > >     https://lore.kernel.org/r/6dbc27f8-5261-59c5-acba-70f6c6a74ba1%40rwth-aachen.de
> > >     Grabbing thread from lore.kernel.org/lkml
> > >     Analyzing 9 messages in the thread
> > >     Will use the latest revision: v2
> > >     You can pick other revisions using the -vN flag
> > >     ---
> > >     Writing
> > >     ./v2_20210201_jan_weinstock_openrisc_use_device_tree_to_determine_present_cpus.mbx
> > >       [PATCH v2] openrisc: use device tree to determine present cpus
> > >     ---
> > >     Total patches: 1
> > >     ---
> > >      Link:
> > >     https://lore.kernel.org/r/6dbc27f8-5261-59c5-acba-70f6c6a74ba1@rwth-aachen.de
> > >      Base: not found
> >
> > That just means the patch contains no information w.r.t. its base, i.e.
> > against which tree/commit it applies to.  To be ignored.
> >
> > >            git am
> > >     ./v2_20210201_jan_weinstock_openrisc_use_device_tree_to_determine_present_cpus.mbx
> >
> > Just run the above command ;-)
> >
> > In addition, you can run "formail -s scripts/checkpatch.pl < *mbx" first, to
> > run the mbox (which could contain multiple patches) through checkpatch.
>
> Thanks for your help, but this is still not working.  See that attached patch.
> If your patch doesn't have this corruption then please forward it.  If Jan could
> point to a git repo or reset with 'git send-email' that would be great too.
>
> It seems that the mailer has corrupted the patch by adding and removing
> whitespace to each line.
>
> I don't have a 'formail' command, but I did try 'git am' and 'checkpatch.pl' and
> it shows:
>
>     < shorne@lianli ~/work/linux > git am v2_20210201_jan_weinstock_openrisc_use_device_tree_to_determine_present_cpus.mbx
>     Applying: openrisc: use device tree to determine present cpus
>     error: corrupt patch at line 62

Indeed, the patch is corrupt.
Sorry for not verifying that before. I just thought you had an issue
saving multipart patches.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
