Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E289F40B5ED
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 19:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbhINRd0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 13:33:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbhINRdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 13:33:24 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6681EC061764
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:32:07 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id c206so29992195ybb.12
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 10:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+3VBdlnD5tDSjFwQi8EY8+Mvb+JS3UIR+Tge1QvZxrw=;
        b=Ra72o6AUkEG7riwrCrXA86JurDy6W5ZQsxVDxbDXAH73P0Ra3IPts1JHfFlgqfOMAB
         htnkLp7mONdM3g2Xe7mo4qLSGJnShNBqVCtevUzNEyNlz+oh7CPIqP43OOSQNtGr2oOq
         xjhlELP4yM6UDuaRq8tvfOhG4MNpLR0b97Jxqa9/CSiLwg+w6ICckpfKa6FjNBA3q6lx
         ls5NwdczWKJHsYtAKuU8cuXn3Ih8RT4CwFO071cOFbYCEsYsEXp3uwo5NNylzFg+b7C3
         YfYnKNCb5FMzg+yDTar2GToQbg9F6PxsxMMNkbEYVqZnxLdOrRz4IRsB25765yweP7HP
         cKRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+3VBdlnD5tDSjFwQi8EY8+Mvb+JS3UIR+Tge1QvZxrw=;
        b=tQI17qDsB9T5V7wJQhc9TSUIopg1AF4KSK99dPjWl7YDGD9+/pOODpqVecy8afO3Hq
         Zj6Z7VWfYfuKwpBTizqkNvP7rTJgmDeZk3O+/BIqRJ4ORwfmfYcfAilrw8Avi8GiSude
         BP39bUOMjojGSdCOrFx3MsFzUhjLgqiooP7djoiOGraQNGnGT0e6mYMOXJ2F929wWSvs
         2FWOFOAj4JEmtU8/aM4d1Mg5ca0Z4AHp7jTEEex4JbrpPJ/Q6PMmEw7zeigoLgtIafGi
         fPdxxxQiJ8csiJeIZp7Sgtq/VGHVK31Xk7eYR1L+6k/+T5mnfdmoxGmtDZ6Zxv0u8HTa
         d9GA==
X-Gm-Message-State: AOAM5315BQ3p1ac6ZReJLWzdmsgm3A6Th/5f0g3oL/Ph+hvZT/qIpchM
        GgVaOpmiY3V7KBpKMLXYNTfHNoEeWpgGD3tLUV75vDrWxOg+RA==
X-Google-Smtp-Source: ABdhPJx90Za08zcRHVf7y+SxDDBaxyRY2wlLiV1YOOtINwYhwMsDEMGKh0JD49mJQNR+ddYHYO/CA4CpRRL1vbsTuR0=
X-Received: by 2002:a25:b94:: with SMTP id 142mr374666ybl.508.1631640726428;
 Tue, 14 Sep 2021 10:32:06 -0700 (PDT)
MIME-Version: 1.0
References: <20210914043928.4066136-1-saravanak@google.com>
 <20210914043928.4066136-6-saravanak@google.com> <YUC7c9BNuHPOEg4g@lunn.ch>
 <CAGETcx-B+yE8X2rn4GdzAikVO-swXb9a5-CxOG_HSuiQoHQZcw@mail.gmail.com>
 <YUDRSIR2g6Pt1umn@lunn.ch> <CAL_Jsq+D2nyzrvWE7vdbQFB680+cmx=FfFMqHL0s=tkTSduz2Q@mail.gmail.com>
In-Reply-To: <CAL_Jsq+D2nyzrvWE7vdbQFB680+cmx=FfFMqHL0s=tkTSduz2Q@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 14 Sep 2021 10:31:30 -0700
Message-ID: <CAGETcx9TN-sLdcir5kChNjx4i+C7gpyTSq4C+EARt42FmP_LzQ@mail.gmail.com>
Subject: Re: [PATCH v1 5/5] driver core: Add fw_devlink.debug command line
 boolean parameter
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Vladimir Oltean <olteanv@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2021 at 9:52 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Tue, Sep 14, 2021 at 11:44 AM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > I did think of this, but the problem is that dynamic debug logs can
> > > get compiled out (when DYNAMIC_DEBUG isn't set). I think debugging of
> > > fw_devlink needs to be possible without having to recompile the
> > > kernel. So in a sense similar to how initcall_debug works today.
> >
> > My off the shelf Debian kernel has it enabled. Maybe you can check
> > other mainline distributions and see if it is enabled by default.
>
> Right, I would expect users that can't rebuild their kernel easily
> would have it enabled.
>
> > You are also on a slippery path. You argue this is needed all the time
> > and add a custom knob. Somebody else adds a new feature which they
> > also argue always needs bug, and add there own custom knob. We soon
> > have lots of custom knobs, each doing it slightly differently, in
> > different places. Chaos. So you need a really good argument why your
> > code really is special.
> >
> > I would suggest you start with dynamic debug, and collect some
> > statistics of how often you need to ask people to recompile their
> > kernel.
>
> I agree.

Fair enough -- Andrew/Rob.

>
> What would be nice is documenting what needs to be set for devlink.
> What I used was just 'dyndbg="file drivers/base/core.c +p"'

Yeah, I was thinking if we went with dynamic debug I'd have something
I'll copy paste as a reply to any fw_devlink debug email thread.

Where would be a good place to document this?

I was actually thinking of making fw_devlink.debug=1 be an alias for
something like:
dyndbg="func device_link_add +p; func device_links_check_suppliers +p"....

So that people don't have to remember what to copy paste into their
command line as things change.

-Saravana
