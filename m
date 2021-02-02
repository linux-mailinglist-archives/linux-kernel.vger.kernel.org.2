Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D22F30BA0A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Feb 2021 09:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbhBBIfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Feb 2021 03:35:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhBBIfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Feb 2021 03:35:02 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E090FC061756
        for <linux-kernel@vger.kernel.org>; Tue,  2 Feb 2021 00:34:21 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id c3so9233469ybi.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Feb 2021 00:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aXX69Gj3J99SZaz9tc9n6m6aBEO8i2YIr0G4uPkrYOw=;
        b=EQ8DUdkuKIh211rRAlFCeuXgLT6ku9aWm8/Oqr6XUqiO4O9K+hGUZj88g13H6jXzB5
         GLIKjp4TmXO4gSoEylo5gmyqYBNAPPQQtTrkER/w0a5vOdOlSvvKRjCA+UtCGFOTmOVr
         GlOOl2zf9tF54q+wl8OImx5GSzz4A934JbyjdmN1BouangxXkOBT/Lm32CdAGf5ZWsKi
         hs7m9yEVPzwsuqYdDKLALT4Fv6lr0cZJwdSL7OcjXx39J+J+XleFdlHarH8cQQvbTj/4
         sq0CND85OwXAfd0B8sXJtMLYJyWOd1afki+hH8vShJxmOdgyV9ftl7r64MGY+zCLd4lI
         wjIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aXX69Gj3J99SZaz9tc9n6m6aBEO8i2YIr0G4uPkrYOw=;
        b=Ib+L9iJ653ACd1YorGOdGdkCxx44jPi8v5suFp+HFnwvPaU1Jto5oU4LPixy/SUdDZ
         X6ATo39t2WhZGXhAhLArjQLsUkrolmWUsupriq29UDx2HT7r7gtJPCRKhCYNWpR4/fUh
         WZzfYxWUyktCbhw81rF5Nz0PoeQHcE7zdp7ZLI4h6mpaMr5rCENfZ+0wYtJvA4NxKD6i
         3zrMhSZtHEob7fC85KrhtD/N3JyYZk5Y2uvESHi5JIzg6fnA8aeGmemEVmknRa+S3OSi
         ZWyy+tofRVnw476a777qNU1VQBQzjI6kln/jDObeHm4GJ/RCCxljFLq9oMRcQL2SGTEn
         wnRw==
X-Gm-Message-State: AOAM530YsUa2UbgpBBGzScGEBtGc3q9EHXYfr31VYm5rSO0MRNuexbW7
        rrVR+s/fNsRQ2reHEBSu6s6pfScmbXcgHZ+w91U9NI7gngJExg==
X-Google-Smtp-Source: ABdhPJwluvw3i9HmRQm33RnnXZ2xMD8jd6NcbTxe5e0anDbv+wD3zNlarQce/3JYGeJmZCX/RXrD0fCnL3AXVTXb4oQ=
X-Received: by 2002:a25:718b:: with SMTP id m133mr31425023ybc.412.1612254860906;
 Tue, 02 Feb 2021 00:34:20 -0800 (PST)
MIME-Version: 1.0
References: <20210130040344.2807439-1-saravanak@google.com>
 <CGME20210130040932eucas1p21f614520b70e3aecf3bf384a5821e5e8@eucas1p2.samsung.com>
 <CAGETcx941J7Zhrf=ZjO6PW0fiax5VXcV3gbsLQfM_wU_U0EnYw@mail.gmail.com>
 <ca582e9f-bc4d-bb94-f700-1cf9dc897b57@samsung.com> <CAGETcx9FokhX+omo07Tgky_+NPH4uYSMiz2OctvK3L3AsGz8rg@mail.gmail.com>
 <71b1ee03-830e-750f-5ed6-ccf5e1cc7810@samsung.com>
In-Reply-To: <71b1ee03-830e-750f-5ed6-ccf5e1cc7810@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 2 Feb 2021 00:33:44 -0800
Message-ID: <CAGETcx91EJeRn9usMHyDHyu18N15MrZCnka3vGMeHLSAVEPWQw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] Make fw_devlink=on more forgiving
To:     Marek Szyprowski <m.szyprowski@samsung.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Marc Zyngier <maz@kernel.org>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 2, 2021 at 12:12 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Saravana,
>
> On 01.02.2021 10:02, Saravana Kannan wrote:
> > On Mon, Feb 1, 2021 at 12:05 AM Marek Szyprowski
> > <m.szyprowski@samsung.com> wrote:
> >> On 30.01.2021 05:08, Saravana Kannan wrote:
> >>> On Fri, Jan 29, 2021 at 8:03 PM Saravana Kannan <saravanak@google.com> wrote:
> >>>> This patch series solves two general issues with fw_devlink=on
> >>>>
> >>>> Patch 1/2 addresses the issue of firmware nodes that look like they'll
> >>>> have struct devices created for them, but will never actually have
> >>>> struct devices added for them. For example, DT nodes with a compatible
> >>>> property that don't have devices added for them.
> >>>>
> >>>> Patch 2/2 address (for static kernels) the issue of optional suppliers
> >>>> that'll never have a driver registered for them. So, if the device could
> >>>> have probed with fw_devlink=permissive with a static kernel, this patch
> >>>> should allow those devices to probe with a fw_devlink=on. This doesn't
> >>>> solve it for the case where modules are enabled because there's no way
> >>>> to tell if a driver will never be registered or it's just about to be
> >>>> registered. I have some other ideas for that, but it'll have to come
> >>>> later thinking about it a bit.
> >>>>
> >>>> These two patches might remove the need for several other patches that
> >>>> went in as fixes for commit e590474768f1 ("driver core: Set
> >>>> fw_devlink=on by default"), but I think all those fixes are good
> >>>> changes. So I think we should leave those in.
> >>>>
> >>>> Marek, Geert,
> >>>>
> >>>> Can you try this series on a static kernel with your OF_POPULATED
> >>>> changes reverted? I just want to make sure these patches can identify
> >>>> and fix those cases.
> >>>>
> >>>> Tudor,
> >>>>
> >>>> You should still make the clock driver fix (because it's a bug), but I
> >>>> think this series will fix your issue too (even without the clock driver
> >>>> fix). Can you please give this a shot?
> >>> Marek, Geert, Tudor,
> >>>
> >>> Forgot to say that this will probably fix your issues only in a static
> >>> kernel. So please try this with a static kernel. If you can also try
> >>> and confirm that this does not fix the issue for a modular kernel,
> >>> that'd be good too.
> >> I've checked those patches on top of linux next-20210129 with
> >> c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platform
> >> driver") commit reverted.
> > Hi Marek,
> >
> > Thanks for testing!
> >
> >> Sadly it doesn't help.
> > That sucks. I even partly "tested" it out on my platform (that needs
> > CONFIG_MODULES) by commenting out the CONFIG_MODULES check. And I saw
> > some device links getting dropped.
>
> Well, my fault. I've missed the fact that I have to disable
> CONFIG_MODULES to let it work. This is not really a fix for my case,
> because the exynos_defconfig has modules enabled (mainly for WiFi and
> media drivers). However disabling the CONFIG_MODULES indeed helped a
> bit. Most of the devices got finally probed. There are only 4 left in
> the deferred_devices list:
>
> sound
> 12e20000.sysmmu
> 12d00000.hdmi
> 12c10000.mixer
>
> The last two (12c10000.mixer and 12d00000.hdmi) are consumers of the
> 12e20000.sysmmu, which is a consumer of the 10023c20.power-domain. That
> power domain in turn is a consumer (child) of another power domain
> (10023c80.power-domain):
>
> # dmesg | grep 10023c20.power-domain
> [    0.354435] platform 10023c20.power-domain: Linked as a consumer to
> 10023c80.power-domain
> [    0.489573] platform 12d00000.hdmi: Linked as a consumer to
> 10023c20.power-domain
> [    0.497143] platform 12c10000.mixer: Linked as a consumer to
> 10023c20.power-domain
> [    0.580874] platform 12e20000.sysmmu: Linked as a consumer to
> 10023c20.power-domain
> [    0.601655] platform 12e20000.sysmmu: probe deferral - supplier
> 10023c20.power-domain not ready
> [    2.744884] platform 12c10000.mixer: probe deferral - supplier
> 10023c20.power-domain not ready
> [    2.766726] platform 12d00000.hdmi: probe deferral - supplier
> 10023c20.power-domain not ready
>
> ...
>
> So a dependency chain of 2 power domains is still not resolved properly.
>
> I didn't have time to check what's wrong with the sound node. Simple
> grepping of the messages for the 'sound' string don't give any results.
> The above tests has been done on the Odroid U3 board
> (arch/arm/boot/dts/exynos4412-odroidu3.dts).

Thanks for testing again! This actually gave me valuable info. The
problem is that 10023c20.power-domain (let's call it PD-B) never gets
added to the deferred probe list (because that only happens once a
driver is registered). So, it never gets to drop it's dependency on
10023c20.power-domain (let's call it PD-A). So, once all drivers are
registered and the SMMU checks if it needs to drop the device link to
PD-B, it sees that PD-B is still waiting on suppliers. So it could be
that the PD-B would probe in the future. But PD-B never probes in the
future.

Anyway, I was trying to avoid climbing the tree/graph with Patch 2/3.
But I might not be able to avoid it. Maybe all I need to check is
whether it's in the deferred probe list. Let me think about it. And
maybe it will solve Geert's issue too.

-Saravana
