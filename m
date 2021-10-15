Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1049742F9D9
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:11:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242096AbhJORNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:13:52 -0400
Received: from mail.kernel.org ([198.145.29.99]:42484 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242093AbhJORNs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:13:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9E1B0611CC;
        Fri, 15 Oct 2021 17:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634317901;
        bh=Z7iN6QNMAz4Odui/sm26suvSVR++7zdZapnB6gkK1qs=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YyaFfBXXjlk8Nfuif0Y9pZpNm2wOdMA4K08dAP+cKztjQ/E+hot81XVKrV47CflNi
         OhAdOaUwWNJs5pZTX0p5X6vuPLuGpmuueMlrmYeNPoZ7xJxk5BUDwIym4r6cy/87Cw
         I/55h17ZsSOSxZwu4HOKNHjnLDho+HHPsNlbCc5C6qBf2FAfwHkOoPUmH0eYd6syb8
         rQ8wpvd3PPG+2Em3ylT6HstqBpyZpxBWgikd0NqS/4HcZGIuFVPVRWUi1tv3ae7fHf
         Hafbn/nSLeZXMRD7qb3rYkHvelu7hZ+bCi55lc7xHvV+DDtZJ54QcbRr4rMykIN80h
         sSUCJlz1kWOkA==
Received: by mail-ed1-f51.google.com with SMTP id t16so40688876eds.9;
        Fri, 15 Oct 2021 10:11:41 -0700 (PDT)
X-Gm-Message-State: AOAM532FTVRMGsWDRArGRt9ndUTDMajzb6585f5hh9jQGdwzg+0FkkN4
        dRNr+HfOHZYhDoSMtpka0o4XP/6CA3p3o75ijA==
X-Google-Smtp-Source: ABdhPJyBcs7BF+aGoJdDOrbXiYgJuYNVZW5lSQW10UHF2HA/w7h9CV69vrBm3/UbTptmrdntR4Hcp6v9s0Sq0aW/aQY=
X-Received: by 2002:a17:906:9399:: with SMTP id l25mr8042333ejx.363.1634317899968;
 Fri, 15 Oct 2021 10:11:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-3-zhang.lyra@gmail.com>
 <YV1XpL7ibF1y4LbV@google.com> <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
 <YWVD0RXHVLxuXEIN@google.com> <CAMuHMdWqYVp1JyzZoidAJhPy9ypRnSOWHJLz5knDUMcFHPOzAw@mail.gmail.com>
 <YWfSz00Rj5AVhkgT@google.com> <CAL_Jsq+GHt+DqHa0GeLKWoni+Lghg5wg5ssREZBdSD-=K3XQ1A@mail.gmail.com>
 <YWl33gCy1ac29WSs@google.com>
In-Reply-To: <YWl33gCy1ac29WSs@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 15 Oct 2021 12:11:28 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJNzA4iX2V5FnSg+phNh72JeRxn+D4250aKmOhngZO9yA@mail.gmail.com>
Message-ID: <CAL_JsqJNzA4iX2V5FnSg+phNh72JeRxn+D4250aKmOhngZO9yA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2021 at 7:45 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Thu, 14 Oct 2021, Rob Herring wrote:
>
> > On Thu, Oct 14, 2021 at 1:48 AM Lee Jones <lee.jones@linaro.org> wrote:
> > >
> > > On Wed, 13 Oct 2021, Geert Uytterhoeven wrote:
> > >
> > > > Hi Lee,
> > > >
> > > > On Tue, Oct 12, 2021 at 10:15 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > On Mon, 11 Oct 2021, Rob Herring wrote:
> > > > > > On Wed, Oct 6, 2021 at 3:00 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > > On Thu, 23 Sep 2021, Chunyan Zhang wrote:
> > > > > > >
> > > > > > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > > > > >
> > > > > > > > Add bindings for Unisoc system global register which provide register map
> > > > > > > > for clocks.
> > > > > > > >
> > > > > > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > > > > ---
> > > > > > > >  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
> > > > > > > >  1 file changed, 68 insertions(+)
> > > > > > > >  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> > > > > > >
> > > > > > > Unapplied v3 and applied this (v4) instead, thanks.
> > > > > >
> > > > > > What about the clock binding this depends on:
> > > > > >
> > > > > > Unknown file referenced: [Errno 2] No such file or directory:
> > > > > > '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> > > > > > xargs: dt-doc-validate: exited with status 255; aborting
> > > > > > make[1]: *** Deleting file
> > > > > > 'Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml'
> > > > > > Unknown file referenced: [Errno 2] No such file or directory:
> > > > > > '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> > > > > > make[1]: *** [scripts/Makefile.lib:385:
> > > > > > Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml]
> > > > > > Error 255
> > > > > >
> > > > > >
> > > > > > Once again, all the components of MFD bindings need to be applied together.
> > > >
> > > > Just ran into this, too...
> > > >
> > > > > I can't apply what is not sent to me.
> > > > >
> > > > > This patch came in on its own.
> > > >
> > > > Then please reject/postpone patches that don't build (yet) ;-)
> > >
> > > I don't explicitly build DT documentation.
> > >
> > > Since I use the build bots to let me know if there are strange !(C,
> > > ASM, arm, aarch64, mips, ppc, x86) build issues or ones with odd
> > > configuration possibilities (randconfig) in the repos I maintain, you
> > > might have to convince them that this is important too.
> >
> > It's really just a matter of turning on the build in
> > allyesconfig/allmodconfig builds. I've not done that primarily because
> > there's one person I don't want to yell at me, but I could probably
> > make it arm and/or arm64 only. It's really arch and config
> > independent, so doing it multiple times is kind of pointless.
> >
> > I assume for bots you mean kernel-ci mainly? Do you run that before
> > stuff gets into linux-next? IMO, that's too late. But still a slight
> > improvement if things go in via one tree. Otherwise, I see the
> > breakage twice, 1st linux-next then the merge window.
>
> Kernel test robot <lkp@intel.com> is the one that springs to mind.

It already does sometimes. I haven't figured out when, but I randomly
see some reports and doesn't report a lot of the cases.

> Although, I'm sure there are other, less prolific implementations.

Rob's bot, but that checks patches (not branches) and applies series
so you won't get errors unless the series is in the wrong patch order.

Rob
