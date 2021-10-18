Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 315E243178F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:37:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231254AbhJRLj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:39:29 -0400
Received: from mail-ua1-f54.google.com ([209.85.222.54]:37382 "EHLO
        mail-ua1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231295AbhJRLj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:39:28 -0400
Received: by mail-ua1-f54.google.com with SMTP id f4so5124904uad.4;
        Mon, 18 Oct 2021 04:37:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yoiylfhsu7vOzWaVrb8Sfpqi1MCIs1ryTZwMWyEH6Ag=;
        b=Bcen5t89gEoZ6eoroXnsq1Mk7Q4yFwfaYv+3P41TrqBwwGwl67CaWO0xOtEeZeLb/m
         1RU/+Ca9flBr94WEBsskisVTGI59N8bKM+TU3zwPhKTUldAhvr0b8mZtIrDUUTFfGbfh
         7sMdpFc/dZuAInSct28pjRrbYD/epxA7ZPxEL+Pkl/wHHCnTMkUEiWtsUVMfqGSb0rqX
         jmFxUrMm6cuj7933Ys3K2fjvNCdqDHve4Yx7QfB7hMROTjiyN8XjC0l7yRAyr+0Dj5Nh
         1ru86qU2/tGnM+CGF80nQF4rqiWgTa0OhBM5HgwkayyOwHbCVKT33huM2QeABTStmvHG
         EJ7Q==
X-Gm-Message-State: AOAM531dn9lx344lXGlobSEuULUbTpE65CufM/q4Mdo1fTlfbfZ54aRh
        6B6GiNRV8Ai+kVTzwPFB6n4gAe0uRuQp9w==
X-Google-Smtp-Source: ABdhPJydUuu55vT6vkPDOdiZ7jMcFEzd+CMbA4JZz4mJY4f2LLn2V1q80p/42Pgpc5nGRORgyn47Zw==
X-Received: by 2002:ab0:3c48:: with SMTP id u8mr25896475uaw.124.1634557036521;
        Mon, 18 Oct 2021 04:37:16 -0700 (PDT)
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com. [209.85.221.179])
        by smtp.gmail.com with ESMTPSA id p26sm1646092uaa.18.2021.10.18.04.37.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Oct 2021 04:37:16 -0700 (PDT)
Received: by mail-vk1-f179.google.com with SMTP id x207so8421804vke.2;
        Mon, 18 Oct 2021 04:37:15 -0700 (PDT)
X-Received: by 2002:a1f:1841:: with SMTP id 62mr23885899vky.26.1634557035711;
 Mon, 18 Oct 2021 04:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <YV1XpL7ibF1y4LbV@google.com>
 <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
 <YWVD0RXHVLxuXEIN@google.com> <CAMuHMdWqYVp1JyzZoidAJhPy9ypRnSOWHJLz5knDUMcFHPOzAw@mail.gmail.com>
 <YWfSz00Rj5AVhkgT@google.com> <CAL_Jsq+GHt+DqHa0GeLKWoni+Lghg5wg5ssREZBdSD-=K3XQ1A@mail.gmail.com>
 <163425256290.1688384.5646232860050218479@swboyd.mtv.corp.google.com>
 <CAL_JsqJV_CoPH7VrX-D5=u2WsoUpp-pTKbcR2y+gWxhv+WKcEg@mail.gmail.com>
 <CAMuHMdU1TCOvDwx6pjg=0-hLkFywRGQsZUNM+0aJLb96fZGAQA@mail.gmail.com> <163433541408.1688384.16269113818432626325@swboyd.mtv.corp.google.com>
In-Reply-To: <163433541408.1688384.16269113818432626325@swboyd.mtv.corp.google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 18 Oct 2021 13:37:04 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUuB1JfDXJiC281xanzW1zoq-LeTRmWtRDzn3vn2Z6wFw@mail.gmail.com>
Message-ID: <CAMuHMdUuB1JfDXJiC281xanzW1zoq-LeTRmWtRDzn3vn2Z6wFw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
To:     Stephen Boyd <sboyd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS 
        <devicetree@vger.kernel.org>, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Sat, Oct 16, 2021 at 12:03 AM Stephen Boyd <sboyd@kernel.org> wrote:
> Quoting Geert Uytterhoeven (2021-10-15 10:09:10)
> > On Fri, Oct 15, 2021 at 3:59 PM Rob Herring <robh+dt@kernel.org> wrote:
> > > On Thu, Oct 14, 2021 at 6:02 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > > > Quoting Rob Herring (2021-10-14 09:18:16)
> > > > > On Thu, Oct 14, 2021 at 1:48 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > >
> > > > > > I don't explicitly build DT documentation.
> > > > > >
> > > > > > Since I use the build bots to let me know if there are strange !(C,
> > > > > > ASM, arm, aarch64, mips, ppc, x86) build issues or ones with odd
> > > > > > configuration possibilities (randconfig) in the repos I maintain, you
> > > > > > might have to convince them that this is important too.
> > > > >
> > > > > It's really just a matter of turning on the build in
> > > > > allyesconfig/allmodconfig builds. I've not done that primarily because
> > > > > there's one person I don't want to yell at me, but I could probably
> > > > > make it arm and/or arm64 only. It's really arch and config
> > > > > independent, so doing it multiple times is kind of pointless.
> > > > >
> > > > > I assume for bots you mean kernel-ci mainly? Do you run that before
> > > > > stuff gets into linux-next? IMO, that's too late. But still a slight
> > > > > improvement if things go in via one tree. Otherwise, I see the
> > > > > breakage twice, 1st linux-next then the merge window.
> > > > >
> > > >
> > > > I run `make dt_binding_check DT_SCHEMA_FILES="<path to yaml file>"` but
> > > > nowadays this seems to check all the bindings and not just the one
> > > > binding I care to check. Did something break?
> > >
> > > It should apply all the schemas to the example in DT_SCHEMA_FILES.
> > > Originally, it only applied DT_SCHEMA_FILES schema to the example in
> > > DT_SCHEMA_FILES.
> >
> > Probably Stephen means that yamllint is still run on all files, which
> > I tried to fix in [1]?
> >
> > I've been running an improved version for months, but I haven't sent
> > it out yet.
> >
>
> Oh yeah probably. Do I need to carry this patch locally until it is
> fixed?

Submitted the improved version:
https://lore.kernel.org/all/cover.1634551582.git.geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
