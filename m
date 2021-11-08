Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49527449954
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 17:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbhKHQSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 11:18:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:58572 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236038AbhKHQSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 11:18:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4C24C61378
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1636388157;
        bh=asZ/sVwGHsWDCYa8XDrk7i8QcNTPDLCb4VrqLMt+z3o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oCywnaqbpSa/QwbX6TUoWP7MsDTbsz1jNn3oDGFdUHEOg75fDNBbSzz4zPMBcMJT6
         fBgCHY/42kNadeUfQmkNyjoMFKXAJoZ5kQ3BY+1RwJpqXSwfu1GSqNZvtfuQzMkpd1
         SiJ90XR2/Qfa8GP+Xv0Cx4tk0R+96xX4AOyZPjyfBdPZ2XABQDRshgB+pNtWYP6h8b
         KOXqahEPAcjmfppIAj0ZjxePmrUy5dwYeSojtQ6PJgJngqPxOrhrNIAd2O6IC/4CSV
         KHXujGQvH+kK4/K2H00krTeKF92mBFyaEkwnQQ4w24jkxW4uY0N+aK93UpUNOL8DoP
         BgQrW/4PXQl+A==
Received: by mail-wr1-f53.google.com with SMTP id n29so16107862wra.11
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 08:15:57 -0800 (PST)
X-Gm-Message-State: AOAM533H65rpXj8akrLRoxZ1wWHcZovKafiI/to+aCh/VmJGKq6Y0W07
        zmtsPjDQN5NZJrzJkJlEqBX6LY2OAyWDK6lT/ao=
X-Google-Smtp-Source: ABdhPJzp2bDGxymnbqVY/EXNx8KUdXs5WzV+5o1cDrcdwEzQur7dRTqrCI3OSwS01nYrbCGPYnqSjos3LsYgoxN+Q1c=
X-Received: by 2002:a05:6000:10cb:: with SMTP id b11mr368308wrx.71.1636388155592;
 Mon, 08 Nov 2021 08:15:55 -0800 (PST)
MIME-Version: 1.0
References: <20211108111132.3800548-1-arnd@kernel.org> <63c5b1fb-575e-f026-5a76-f08a366f7f38@linux.intel.com>
 <bae1a17c-af6e-d77a-19e7-f3f6408951fa@nxp.com>
In-Reply-To: <bae1a17c-af6e-d77a-19e7-f3f6408951fa@nxp.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 8 Nov 2021 17:15:39 +0100
X-Gmail-Original-Message-ID: <CAK8P3a2-=-JM+p2b4v4F8O9O2ZhB-3Uhd_F+gcGAinAztSDH9A@mail.gmail.com>
Message-ID: <CAK8P3a2-=-JM+p2b4v4F8O9O2ZhB-3Uhd_F+gcGAinAztSDH9A@mail.gmail.com>
Subject: Re: [PATCH] ASoC: SOF: build compression interface into snd_sof.ko
To:     Daniel Baluta <daniel.baluta@nxp.com>
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Colin Ian King <colin.king@canonical.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Bud Liviu-Alexandru <budliviu@gmail.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>,
        sound-open-firmware@alsa-project.org,
        ALSA Development Mailing List <alsa-devel@alsa-project.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 8, 2021 at 3:13 PM Daniel Baluta <daniel.baluta@nxp.com> wrote:
> On 11/8/21 3:39 PM, Pierre-Louis Bossart wrote:
> > On 11/8/21 5:11 AM, Arnd Bergmann wrote:
> >> From: Arnd Bergmann <arnd@arndb.de>
> >>
> >> Fixes: 858f7a5c45ca ("ASoC: SOF: Introduce fragment elapsed notificati=
on API")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > It's Monday morning and my memory is still foggy but I think we fixed
> > this problem with https://eur01.safelinks.protection.outlook.com/?url=
=3Dhttps%3A%2F%2Fgithub.com%2Fthesofproject%2Flinux%2Fpull%2F3180&amp;data=
=3D04%7C01%7Cdaniel.baluta%40nxp.com%7C25ac869cfd1040f1be1708d9a2bd3460%7C6=
86ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C637719755777370422%7CUnknown%7CTW=
FpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3=
D%7C1000&amp;sdata=3DE4K2DPkpLX2SgVJ1K99Qs3uz7l7mS96gIzYlJw9akbg%3D&amp;res=
erved=3D0,
> > where we changed the Kconfigs for i.MX. We haven't sent this update
> > upstream for some reason.
> >
> > Arnd, can you share the configuration that breaks with the existing
> > upstream code, I can check if the problem still exists.

https://pastebin.com/6JqM6Gkr

> Maybe someone forgot :) to send
> https://github.com/thesofproject/linux/pull/3180/commits/7122edc88d13db8b=
a835bdb20f7444ae535f9ffa
> upstream.
>
> I think that's me.
>
> Arnd can you run your scripts with
> https://github.com/thesofproject/linux/pull/3180/commits/7122edc88d13db8b=
a835bdb20f7444ae535f9ffa.
> I also attached the patch

I added that to my randconfig tree now. I did a cherry-pick of that
commit, I tried a 'git merge'
first, but that pulled in a lot of other stuff that conflicts with linux-ne=
xt.

Your patch does not fix the link error though, I'm fairly sure we need
my one-liner
on top still. In this case, SND_SOC_SOF=3Dy gets selected by
SND_SOC_SOF_INTEL_COMMON=3Dy, while SND_SOC_SOF_COMPRESS=3Dm gets
selected by SND_SOC_SOF_IMX_COMMON=3Dm, and then ignored because the Makefi=
le
only cares about =3Dy objects built into the common module.

       Arnd
