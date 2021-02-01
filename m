Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 471D930A3EF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 10:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhBAJDj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 04:03:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbhBAJDg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 04:03:36 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A71C061573
        for <linux-kernel@vger.kernel.org>; Mon,  1 Feb 2021 01:02:36 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id j84so2949166ybg.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Feb 2021 01:02:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BThrR9f5rNT/Ht36RPlwrxxZyEfeCJHXViQOYJY/Cdc=;
        b=hIsZcEPzEFGQdAyHvCh3xtrTmgJBxSrvmVaHMURSQcWq3B0OA9ELbKQ+J95ycyoXoB
         yNs8unt1o/QhvdQmefeVqQmSPwy6oWf5m7ubPucxnNhQVQy1DpcAMMeO5sHvFigz5kfT
         OwvohcVI3YkwsXS7uP6TUhTptR6gyaWrsJDwB8HTS1euP6wmHeGwogFTd/c3QtOp3gYR
         NeugeYz/5HH5zhg2qCb2RinbE9G1vRkXKEcXYhUzbUPH4SR/vvQF6lcm1BlrLDh3QYbw
         m44LJX3d2fP3SJXAvePjn9QlY7JtJP0Fe5SIExVgkxM6mtTijy/RxqTcK/OJ8SLUMvGQ
         PhDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BThrR9f5rNT/Ht36RPlwrxxZyEfeCJHXViQOYJY/Cdc=;
        b=TRTeBTUjNsHkgAomBCkJRndWz0rElpFfyPgcmvyx34GRQ6wHpA5TKprQWUb19VXEnJ
         mnRa9EuiUTLeSfeUkT5C2YnXBuOmIFN2hRpd7giooyjrdUWGFHUWaFT7rzAWNvNLD0sK
         FOjwlOHIbTuagtkjP0MbcpS9Mk9pvQ/UzBgbzJ1QmQwdgqtwcZK/c3HD+EJjIdLWuxor
         bowHGZzmuEOdOhzBSLpGRX5gAtYpGHM3cs5nvTtb+PjUawEyhDjHyGLeeFYIlcn5iVE7
         myTageCrAIVfYefgmCda8Z/aAqHK3nn0a/Cph8PY8WmpdHZaWq6WrnelIGKnzA2hPknx
         WP/w==
X-Gm-Message-State: AOAM530amu046S85d1Zc83DayC4zk1rJ0QDmN7bBE5OuVuOR/wQjK5qM
        MrWQBhewAFPLBbfhHjPntNC/O6i//0RTzNnVvcLXbQ==
X-Google-Smtp-Source: ABdhPJyVy2CLDO9GmRm25/zj7aVuQPIXdL7jBlnywTGND+UVwuwudwmfm5yawSs4PJdVkcp71SELNf2fPv02r5vd0cs=
X-Received: by 2002:a25:718b:: with SMTP id m133mr23927132ybc.412.1612170156038;
 Mon, 01 Feb 2021 01:02:36 -0800 (PST)
MIME-Version: 1.0
References: <20210130040344.2807439-1-saravanak@google.com>
 <CGME20210130040932eucas1p21f614520b70e3aecf3bf384a5821e5e8@eucas1p2.samsung.com>
 <CAGETcx941J7Zhrf=ZjO6PW0fiax5VXcV3gbsLQfM_wU_U0EnYw@mail.gmail.com> <ca582e9f-bc4d-bb94-f700-1cf9dc897b57@samsung.com>
In-Reply-To: <ca582e9f-bc4d-bb94-f700-1cf9dc897b57@samsung.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Mon, 1 Feb 2021 01:02:00 -0800
Message-ID: <CAGETcx9FokhX+omo07Tgky_+NPH4uYSMiz2OctvK3L3AsGz8rg@mail.gmail.com>
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

On Mon, Feb 1, 2021 at 12:05 AM Marek Szyprowski
<m.szyprowski@samsung.com> wrote:
>
> Hi Saravana,
>
> On 30.01.2021 05:08, Saravana Kannan wrote:
> > On Fri, Jan 29, 2021 at 8:03 PM Saravana Kannan <saravanak@google.com> wrote:
> >> This patch series solves two general issues with fw_devlink=on
> >>
> >> Patch 1/2 addresses the issue of firmware nodes that look like they'll
> >> have struct devices created for them, but will never actually have
> >> struct devices added for them. For example, DT nodes with a compatible
> >> property that don't have devices added for them.
> >>
> >> Patch 2/2 address (for static kernels) the issue of optional suppliers
> >> that'll never have a driver registered for them. So, if the device could
> >> have probed with fw_devlink=permissive with a static kernel, this patch
> >> should allow those devices to probe with a fw_devlink=on. This doesn't
> >> solve it for the case where modules are enabled because there's no way
> >> to tell if a driver will never be registered or it's just about to be
> >> registered. I have some other ideas for that, but it'll have to come
> >> later thinking about it a bit.
> >>
> >> These two patches might remove the need for several other patches that
> >> went in as fixes for commit e590474768f1 ("driver core: Set
> >> fw_devlink=on by default"), but I think all those fixes are good
> >> changes. So I think we should leave those in.
> >>
> >> Marek, Geert,
> >>
> >> Can you try this series on a static kernel with your OF_POPULATED
> >> changes reverted? I just want to make sure these patches can identify
> >> and fix those cases.
> >>
> >> Tudor,
> >>
> >> You should still make the clock driver fix (because it's a bug), but I
> >> think this series will fix your issue too (even without the clock driver
> >> fix). Can you please give this a shot?
> > Marek, Geert, Tudor,
> >
> > Forgot to say that this will probably fix your issues only in a static
> > kernel. So please try this with a static kernel. If you can also try
> > and confirm that this does not fix the issue for a modular kernel,
> > that'd be good too.
>
> I've checked those patches on top of linux next-20210129 with
> c09a3e6c97f0 ("soc: samsung: pm_domains: Convert to regular platform
> driver") commit reverted.

Hi Marek,

Thanks for testing!

> Sadly it doesn't help.

That sucks. I even partly "tested" it out on my platform (that needs
CONFIG_MODULES) by commenting out the CONFIG_MODULES check. And I saw
some device links getting dropped.

> All devices that belong

By belong, I assume you meant "are consumers"?

> to the Exynos power domains are never probed and stay endlessly on the
> deferred devices list. I've used static kernel build - the one from
> exynos_defconfig.

Can you enable the dev_dbg in __device_link_del() (the SRCU variant)?
Hopefully at least some of the device links would be dropped?

If the PD device link is not dropped, I wonder why this condition is
not hitting for consumers of the PD.

                if (fw_devlink_def_probe_retry &&
                    link->flags & DL_FLAG_INFERRED &&
                    !device_links_probe_blocked_by(link->supplier)) {
                        device_link_drop_managed(link);
                        continue;
                }

Could you try logging dev, link->supplier and
device_links_probe_blocked_by() return value. That should tell when a
consumer is waiting on a PD, why the PD might appear as waiting on
something else. I can't imagine the DL_FLAG_INFERRED being cleared
(it'll only happen when a driver/framework explicitly creates a device
link). Remind me again where the DT for this board is? Does the PD
depend on something else?

One other possibility is that some of the consumers of the PD could be
using the *_platform_driver_probe() macro/function that never
reattempts a probe. So even though this patch might drop the device
links, the consumer never tries again.

-Saravana
