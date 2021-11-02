Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2C34437F9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Nov 2021 22:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhKBVnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Nov 2021 17:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbhKBVnK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Nov 2021 17:43:10 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F7DBC061203
        for <linux-kernel@vger.kernel.org>; Tue,  2 Nov 2021 14:40:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id d27so586486wrb.6
        for <linux-kernel@vger.kernel.org>; Tue, 02 Nov 2021 14:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RRy2HKxizQGRbNFKYHU7Hj+PY9O55ysIFI9KaBWKaSA=;
        b=eqHIPKXJm1t0gcggH43OKyXXE4dxQf6kL354n9N4erFZ6vZfG/TIMx1Xtpa7kimEzJ
         IdnG5ZemJ84or97zTpkagOHIkCDa7oXYXwm713aJ14zdMt00g0u8dgyrsKOzCgEyGvm5
         VDOgO9njmkYW6dHoiCeefLSx2uQRrh5CpE7ETJkd86lb1omt/8NpwfK9LEU2sK2QX9bn
         RvI8YmFJGUGbIKmUWiAqNvlpR01C7zB2EOjPvJDZw0CnKKAqpFbL1mDSZ3o2PqSGs9xr
         bBbkXsELmFm7/8bhPV97vSjZaEDIcNfMsIkmvbcTq9Ly/KOJ4STkSH3SOwP/dqNMuqPV
         NhOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RRy2HKxizQGRbNFKYHU7Hj+PY9O55ysIFI9KaBWKaSA=;
        b=d21mLpBDUHWKau9/rODTRD0sFYrder8DOsrxhlK4uykgJkbM0xk57fxeM95sf01v7G
         NGBL/UCbf2+LHzTB/OKij+O0ykri9XpUq2Gj1PL5hZNIVlDrHbwoJhyn3MFGqVKol3kN
         jCHG14i+2PkkTIhrIKrJ6DoDKECir2K+D/m/PdzLQFny+sESsl1vjZAItNVqXjC0UZw4
         nU9fWX3zMq8+MCpgbLHBwOPuIHlRJEUbypGLrKYU2l97MO67ZGmP3trmzwd2OITSKwGy
         3gMCCXkBrY4RUbzQsccPE1v8tlcUk28oDiRB2Cfd7p9q1kECsQcrCacmf6zMHcJKTH1f
         n5zg==
X-Gm-Message-State: AOAM533ToypEjO892ao2Myq6Kw/pjGaQw7h9K7hXKNY45mq68M6rjj/2
        /BkK4ziQl1ZJMqJhH3ykPijG+A==
X-Google-Smtp-Source: ABdhPJynKNEWhOofitXQB1sS8+qf4ZeclaLzHS7NkDhbro0v/6poqmdF9U094egDD0VH8W8f4CU1Qw==
X-Received: by 2002:a5d:4890:: with SMTP id g16mr51914613wrq.10.1635889233579;
        Tue, 02 Nov 2021 14:40:33 -0700 (PDT)
Received: from Red ([2a01:cb1d:3d5:a100:264b:feff:fe03:2806])
        by smtp.googlemail.com with ESMTPSA id p13sm4218448wmi.0.2021.11.02.14.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 14:40:33 -0700 (PDT)
Date:   Tue, 2 Nov 2021 22:40:31 +0100
From:   LABBE Corentin <clabbe@baylibre.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>
Cc:     Alex Bee <knaerzche@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>, sboyd@kernel.org,
        heiko@sntech.de, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        "kernelci@groups.io" <kernelci@groups.io>,
        Collabora Kernel ML <kernel@collabora.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH] clk: composite: Also consider .determine_rate for rate +
 mux composites
Message-ID: <YYGwT0CKEd5Xu2jO@Red>
References: <163425193558.1688384.15520943968787313145@swboyd.mtv.corp.google.com>
 <20211015120559.3515645-1-martin.blumenstingl@googlemail.com>
 <04a58d50-634b-fa20-95b4-eb6831f77e85@collabora.com>
 <CAFBinCAEt9_EfLYWZEzTBK6iN97+Wacho7pNd2LYDPX3+goMzg@mail.gmail.com>
 <b6468523-a730-6a44-f4b9-3fd5b9ea2354@arm.com>
 <3e42ae24-8db4-fb11-edf2-a25bca47ecae@arm.com>
 <49a0dda1-8d0f-580c-d92d-de759b51edb3@gmail.com>
 <31d462cb-1158-dd13-0ca8-46d54d2502f5@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <31d462cb-1158-dd13-0ca8-46d54d2502f5@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le Tue, Nov 02, 2021 at 07:58:42AM +0000, Guillaume Tucker a écrit :
> +Kevin +Corentin
> 
> On 01/11/2021 22:41, Alex Bee wrote:
> > Hi Guillaume,
> > 
> > Am 01.11.21 um 23:11 schrieb Robin Murphy:
> >> On 2021-11-01 21:59, Robin Murphy wrote:
> >>> On 2021-11-01 20:58, Martin Blumenstingl wrote:
> >>>> Hi Guillaume,
> >>>>
> >>>> On Mon, Nov 1, 2021 at 9:19 PM Guillaume Tucker
> >>>> <guillaume.tucker@collabora.com> wrote:
> >>>>>
> >>>>> Hi Martin,
> >>>>>
> >>>>> Please see the bisection report below about a boot failure on
> >>>>> rk3328-rock64.
> >>>>>
> >>>>> Reports aren't automatically sent to the public while we're
> >>>>> trialing new bisection features on kernelci.org but this one
> >>>>> looks valid.
> >>>>>
> >>>>> Some more details can be found here:
> >>>>>
> >>>>>    https://linux.kernelci.org/test/case/id/617f11f5c157b666fb3358e6/
> >>>>>
> >>>>> Here's what appears to be the cause of the problem:
> >>>>>
> >>>>> [    0.033465] CPU: CPUs started in inconsistent modes
> >>>>> [    0.033557] Unexpected kernel BRK exception at EL1
> >>>>> [    0.034432] Internal error: BRK handler: f2000800 [#1] PREEMPT SMP
> >>>
> >>> What's weird is that that's really just the same WARN that's also
> >>> present in 'successful' logs, except for some reason it's behaving as
> >>> if the break handler hasn't been registered, despite that having
> >>> happened long before we got to smp_init(). At this point we're also
> >>> still some way off getting as far as initcalls, so I'm not sure that
> >>> the clock driver would be in the picture at all yet.
> >>>
> >>> Is the bisection repeatable, or is this just random flakiness
> >>> misleading things? I'd also note that you need pretty horrifically
> >>> broken firmware to hit that warning in the first place, which might
> >>> cast a bit of doubt over the trustworthiness of that board altogether.
> 
> The bisection has checks to avoid false positives, so tests that
> produce flaky results won't normally lead to a report like this.
> Then they're manually triaged, and there were 2 separate
> bisections that landed on this same commit.
> 
> >> Ah, on closer inspection it might be entirely repeatable for a given
> >> kernel build, but with the behaviour being very sensitive to code/data
> >> segment layout changes...
> >>
> >> ...
> >> 23:44:24.457917  Filename '1007060/tftp-deploy-dvdnydcw/kernel/Image'.
> >> 23:44:24.460178  Load address: 0x2000000
> >> ...
> >> 23:44:27.180962  Bytes transferred = 33681920 (201f200 hex)
> >> ...
> >> 23:44:27.288135  Filename
> >> '1007060/tftp-deploy-dvdnydcw/ramdisk/ramdisk.cpio.gz.uboot'.
> >> 23:44:27.288465  Load address: 0x4000000
> >> ...
> 
> That is indeed where the remaining false positives are still
> likely to be coming from, when the infrastructure consistently
> causes test failures following particular kernel revisions.  I
> don't think there's an easy way to rule those out, but we can try
> to address them one by one at least.
> 
> In the case of colliding address ranges in the bootloader, we
> could add a check with the "good" revision and extra data in the
> kernel image to make it at least as big as the "bad" revision...
> 
> > could you try updating u-boot to more recent version: the ramdisk
> > address has been moved [1] to 0x06000000 in v2020.01-rc5.
> 
> Thanks for investigating this.  The board is in BayLibre's lab.
> 
> Corentin, Kevin, could you please take a look?
> 

Hello

I tried to update uboot on it but failed for today.
I found only how to flash sdcard (doiing it remotly), but the board boots SPI first (and I saw no documentation on how to flash SPI).
I need to have physical access to change this.
So probably later this week.

Regards
