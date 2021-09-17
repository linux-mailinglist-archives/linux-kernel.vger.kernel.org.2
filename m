Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8236340FE92
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Sep 2021 19:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245153AbhIQRXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Sep 2021 13:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234934AbhIQRXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Sep 2021 13:23:10 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE298C061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 10:21:47 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id 73so14617649qki.4
        for <linux-kernel@vger.kernel.org>; Fri, 17 Sep 2021 10:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=FVJPvPT71p2qpDpVwYusHwhoAJjRhgpFZDRPcQYsm44=;
        b=Vg9PqjoLUWYyLSOVPIQePFeem7dxwhAckSnTYHvVZG+64Nw9R6Nou8lBZrFzFzlrlZ
         FL4arXzalgV9rTrA68JFbUTKXMzZUkxyRb3YplrxY67VM+CZNdsJPahgKUxlea5dyinn
         RmQ7tGL5hdt7U5lFTuvq3Cs680t8FSujEiqQ1bhUp8pRTpBShDjc7FgSoRSPw4fcoxjj
         b/S1iRvW9sleCR/X4Ho9UHep7l+ySBVKVMAWoE9Md3QBLogH0p3emp9INfX/TgKWJg8g
         Jr12ucqPUzA1MuqiNOXQGnme9ORfrR4MzkkWW0gAEnT0tjGqV/y+Ws5u4c02Mk9h3wc/
         t2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=FVJPvPT71p2qpDpVwYusHwhoAJjRhgpFZDRPcQYsm44=;
        b=3WhYBeEr2JGw3SfF6iq1kZkmY1VywlRAJ2JmxtLve0mp3P1HvTm6PSSK/i2A7q97Uh
         lr9baGL5L4/8Sx9xqS2HiWUCFfJkplTSxxupeK6haEpMxNxS4MVeDhie4vUw1V/yX93Y
         1vF+vv0tjl9SyB5KTFTm1cAvr8zjUzgQV5sG4DP+lVw/IR4xzMIt8jTaXFIQWROxGTVd
         q/a/L2LcAXnOP6RLGoj/zi1ODzwpllnKXDW4SxG6+HM6lbzJSJyyc+o4hHqlFz5671GJ
         YKQ4nRYjt9l65zPFArN+cjXRV0LiR0v+iCOYWVcIFHLM7jF3n/ySxyBl+V7KD8oKNKnG
         qiXg==
X-Gm-Message-State: AOAM532JNo55DTjnmZr/nxZPyKyHbWZ3EOja3iehwnsvON7h7YEl5MJd
        Cb3T44xgQ8b/hwwJMdZBrFW37YqFMAQVQfDGeb4PWQ==
X-Google-Smtp-Source: ABdhPJxHWypP5Nx1s1w3WIjq/yf9gfvKFlPPn8EGGqwu6o1F7k630NexbuzmSziZ+d0w0RiS2F3Tt2yDvrBNyZLK1Fk=
X-Received: by 2002:a5b:783:: with SMTP id b3mr13920071ybq.328.1631899306645;
 Fri, 17 Sep 2021 10:21:46 -0700 (PDT)
MIME-Version: 1.0
References: <20210915081933.485112-1-saravanak@google.com> <45576ceb-562c-9ca7-3ef4-31add52b2168@gmail.com>
 <CAGETcx9nbxH6hETP2LUENG8EV3v771qi9NpkFd-mix3G-NdZUA@mail.gmail.com> <6cc44234-ed1f-5fb3-671a-cf673ee08fb7@gmail.com>
In-Reply-To: <6cc44234-ed1f-5fb3-671a-cf673ee08fb7@gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 17 Sep 2021 10:21:10 -0700
Message-ID: <CAGETcx9YMsw1YnorpD7hYNiDxS_DKC4b30nk6vcUiBFKuJi-0w@mail.gmail.com>
Subject: Re: [PATCH] Revert "of: property: fw_devlink: Add support for
 "phy-handle" property"
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Russell King <linux@armlinux.org.uk>, kernel-team@android.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 17, 2021 at 9:59 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> On 9/16/21 7:27 PM, Saravana Kannan wrote:
> > On Thu, Sep 16, 2021 at 7:21 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>
> >>
> >>
> >> On 9/15/2021 1:19 AM, Saravana Kannan wrote:
> >>> This reverts commit cf4b94c8530d14017fbddae26aad064ddc42edd4.
> >>>
> >>> Some PHYs pointed to by "phy-handle" will never bind to a driver until a
> >>> consumer attaches to it. And when the consumer attaches to it, they get
> >>> forcefully bound to a generic PHY driver. In such cases, parsing the
> >>> phy-handle property and creating a device link will prevent the consumer
> >>> from ever probing. We don't want that. So revert support for
> >>> "phy-handle" property until we come up with a better mechanism for
> >>> binding PHYs to generic drivers before a consumer tries to attach to it.
> >>>
> >>> Signed-off-by: Saravana Kannan <saravanak@google.com>
> >>
> >> Thanks for getting this revert submitted, I just ran a bisection this
> >> afternoon that pointed to this offending commit. It would cause the dead
> >> lock
> >
> > Dead lock in the kernel? Or do you mean just a hang waiting forever for network?
>
> It locks up since we try to acquire __device_driver_lock() while we are
> in the main driver's probe function.

Off the top of my head that sounds weird, but I'll look into the
logs/code later. Bunch of other stuff and some LPC prep comes first :)

>
> >
> >> on boot with drivers/net/dsa/bcm_sf2.c pasted below.
> >
> > The log is too jumbled up to be readable (word wrap I suppose) and
> > maybe even multiple thread printing at the same time.
>
> Re-attached (thunderbird is not really helping me).

Thanks!

>
> >
> >> Saravana, can
> >> you CC on me on your fix or what you would want me to be testing?
> >
> > By fix, I assume you mean when I bring back phy-handle with a proper
> > fix to handle the case in the commit text? Yeah, that's going to take
> > a while. It's brewing in my head and there are some issues that's not
> > fully resolved. But I haven't had time to code it up or dig into the
> > net code to make sure it'll work. But yes, I'll CC you when I do so
> > you can test it with this case.
>
> Well by fix, I meant something that does not lock up on my system,

Hold on. Now I'm confused. Are you still hitting hangs/issues after
the phy-handle patch is reverted?

> it is
> a different problem from supporting 'phy-handle', but it should not
> regress an existing system, no matter how quirky that system behaves in
> its probe function. For history and reference, the "offending" change
> and background can be found here:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=771089c2a485958e423f305e974303760167b45c

So that is the change that's interacting with the phy-handle patch to
cause the deadlock?

I'm a bit confused on what needs debugging now.

-Saravana

>
> Thanks for your patience working on the quirky MDIO/PHY subsystem :)

No worries. Thanks for your patience with me accidentally breaking stuff :)

-Saravana
