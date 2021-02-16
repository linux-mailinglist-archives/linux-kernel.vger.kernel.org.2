Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4248C31CEAB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Feb 2021 18:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhBPRIq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Feb 2021 12:08:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229784AbhBPRIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Feb 2021 12:08:43 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51A7C061756
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 09:08:03 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id y128so11094496ybf.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Feb 2021 09:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EOoT/2ZRzWvEXcLxuZ6fIHpjifNSP30Dl3Nv/8J4jR4=;
        b=WdCXyIRke16cMJsDa3zli6lc0UjF1wpzWcCkHwpauoeANh/CWtv98wK+NlR53jpmEX
         fPUsPo82SM1O6aRxFbpsrJT1mwlDapMcy4Qaeqd7Mys422WEBikk+gmxH/XKf9inqEqi
         FZ0g+OW/dTEtg7kiq5XU6pPJjXsFWS196dc0wPOzE7MKFPuMZJy6dzzF7YtZJHmHZLaU
         go80z7YdKCWqvAK4Z+0DLZ40C/Oy1AFuRWSgcJadSe7GXBXTu3iXLx4MepBGcuunexFf
         NL1IghxDsoc71++IbB58tXt/KXrRsnLMW4NBtz4QTQ3eJPKAyPwzoWVj1kFdqZlCmMDP
         zVOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EOoT/2ZRzWvEXcLxuZ6fIHpjifNSP30Dl3Nv/8J4jR4=;
        b=akyCcUTZk/8CP2kc//TJ/KXS2YqbKLSAKQLyCndOUC9uTHeDxbJnMlYD7YceM3RKAz
         VzFe2RfiueM/uBJ43DmYy+8kbKaLCWCMtO0R4h5YA9Vtr3DFHPmsYzN2NcEmyGxsVuZb
         zdJJ5LKawdeuuDgJ/X8j0m9RVQYCwo4EyEtn6DNabGxWyjOghYqNlej5BgoXQyoE+Bmu
         Q+wY+znUIcKvOGhZPKLhul9CkndHpMOvTfYFgkUvvvKJDnsOAOu0NqHW8NjhjtrL8oWO
         3O+78N5SzO9uiVlfhsLPSysrTg/6a0hTOz8kSe1Rf3DPTolV4MlL2w3PrWmGFDV+uZ9m
         TI+A==
X-Gm-Message-State: AOAM5328aQQN/dpTabHwbmRJLkuQabGwxXobW9E9KpCx61QIhVzLmdhi
        82LmimvF1QILoSSC+yT4bcJ9K2maL89IPytPFtUwEg==
X-Google-Smtp-Source: ABdhPJzgGS0xYNP+T4mgwBunRSL3eutPscSYXSMk0VP22h8l7fgIH6PBMZ7zYvpr6r2RlDhmuXBtz2bgCfSYUff5nFI=
X-Received: by 2002:a25:3345:: with SMTP id z66mr31002234ybz.466.1613495282718;
 Tue, 16 Feb 2021 09:08:02 -0800 (PST)
MIME-Version: 1.0
References: <20210215111619.2385030-1-geert+renesas@glider.be>
 <CAJZ5v0ikVbMX0R9e_=wOxKfJX5X322AipmpWy-7wVnWE7Ogc9A@mail.gmail.com>
 <CAGETcx94nNjduOuYKVBZOC9Gm4yfyb9x92ddznyxK4BnDby4PA@mail.gmail.com>
 <CAMuHMdWm9FiJHWTzGqqNa-ggt9WTpS6Hg2WthNW86p_WpvPUtw@mail.gmail.com> <CAGETcx8N5QmR5V_mrv5tHmARsnWrLbH+N_Ay_pBqV9HJkpHJzQ@mail.gmail.com>
In-Reply-To: <CAGETcx8N5QmR5V_mrv5tHmARsnWrLbH+N_Ay_pBqV9HJkpHJzQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 16 Feb 2021 09:07:26 -0800
Message-ID: <CAGETcx8nD7Ak8z7JEM1jUVdRRpUt=8BwGMix0ghv1QeDBLaGwA@mail.gmail.com>
Subject: Re: [PATCH] driver core: Fix double failed probing with fw_devlink=on
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 15, 2021 at 12:59 PM Saravana Kannan <saravanak@google.com> wrote:
>
> On Mon, Feb 15, 2021 at 11:08 AM Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> >
> > Hi Saravana,
> >
> > On Mon, Feb 15, 2021 at 7:27 PM Saravana Kannan <saravanak@google.com> wrote:
> > > On Mon, Feb 15, 2021 at 6:59 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > > On Mon, Feb 15, 2021 at 12:16 PM Geert Uytterhoeven
> > > > <geert+renesas@glider.be> wrote:
> > > > > With fw_devlink=permissive, devices are added to the deferred probe
> > > > > pending list if their driver's .probe() method returns -EPROBE_DEFER.
> > > > >
> > > > > With fw_devlink=on, devices are added to the deferred probe pending list
> > > > > if they are determined to be a consumer,
> > >
> > > If they are determined to be a consumer or if they are determined to
> > > have a supplier that hasn't probed yet?
> >
> > When the supplier has probed:
> >
> >     bus: 'platform': driver_probe_device: matched device
> > e6150000.clock-controller with driver renesas-cpg-mssr
> >     bus: 'platform': really_probe: probing driver renesas-cpg-mssr
> > with device e6150000.clock-controller
> >     PM: Added domain provider from /soc/clock-controller@e6150000
> >     driver: 'renesas-cpg-mssr': driver_bound: bound to device
> > 'e6150000.clock-controller'
> >     platform e6055800.gpio: Added to deferred list
> >     [...]
> >     platform e6020000.watchdog: Added to deferred list
> >     [...]
> >     platform fe000000.pcie: Added to deferred list
> >
> > > > > which happens before their
> > > > > driver's .probe() method is called.  If the actual probe fails later
> > > > > (real failure, not -EPROBE_DEFER), the device will still be on the
> > > > > deferred probe pending list, and it will be probed again when deferred
> > > > > probing kicks in, which is futile.
> > > > >
> > > > > Fix this by explicitly removing the device from the deferred probe
> > > > > pending list in case of probe failures.
> > > > >
> > > > > Fixes: e590474768f1cc04 ("driver core: Set fw_devlink=on by default")
> > > > > Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > > >
> > > > Good catch:
> > > >
> > > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > >
> > > The issue is real and needs to be fixed. But I'm confused how this can
> > > happen. We won't even enter really_probe() if the driver isn't ready.
> > > We also won't get to run the driver's .probe() if the suppliers aren't
> > > ready. So how does the device get added to the deferred probe list
> > > before the driver is ready? Is this due to device_links_driver_bound()
> > > on the supplier?
> > >
> > > Can you give a more detailed step by step on the case you are hitting?
> >
> > The device is added to the list due to device_links_driver_bound()
> > calling driver_deferred_probe_add() on all consumer devices.
>
> Thanks for the explanation. Maybe add more details like this to the
> commit text or in the code?
>
> For the code:
> Reviewed-by: Saravana Kanna <saravanak@google.com>

Ugh... I just realized that I might have to give this a Nak because of
bad locking in deferred_probe_work_func(). The unlock/lock inside the
loop is a terrible hack. If we add this patch, we can end up modifying
a linked list while it's being traversed and cause a crash or busy
loop (you'll accidentally end up on an "empty list"). I ran into a
similar issue during one of my unrelated refactors.

-Saravana
