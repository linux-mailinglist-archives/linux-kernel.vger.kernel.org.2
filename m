Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A4D42F9B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Oct 2021 19:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242007AbhJORLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Oct 2021 13:11:31 -0400
Received: from mail-ua1-f48.google.com ([209.85.222.48]:45811 "EHLO
        mail-ua1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237971AbhJORLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Oct 2021 13:11:30 -0400
Received: by mail-ua1-f48.google.com with SMTP id a17so10334786uax.12;
        Fri, 15 Oct 2021 10:09:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AXjyyUEyNr3tFFEGe2AFpPE4BVE0IzJYsKN0OEXvERA=;
        b=1Ep/On6eoXBaI/wycMG/7l8fWhEt0u0hqoUrIPZrs/OVCdvwaLqbze1jXoTFnN5Czp
         wnhRxiPZ43EETsk7r2OK/iAeLLGqcKbi7UJdQbEnGSRj48gktL2Dhy91Ug0xxOBAOJTr
         hl2jHUCLkc1BTOWkY5Lm5OkVWWNsJmQNYEXDGnnRw8e0J++BkRDkdP1zbyE0wuWANZ3f
         bPN6gUPa9PYDOuQUfFsJmm9D0pKaB37v0GEj/lFBEhY2jNHG+aF5mE4ouPxxOYkmSMRX
         1u26t6wxcDRBlVnjqa7tzfXukEqza6wqbsWT//Ktf99f58+4mf5ksL7X/+u8xNduzZBd
         04AQ==
X-Gm-Message-State: AOAM533fvIPzW5Q0vtbC0Gr7sfO+cTq1/uJ1gecuEb9ttVz+cyRfZnUO
        5A1GWCcmxTiHJIe+eQpJOJydka5AhGYToQ==
X-Google-Smtp-Source: ABdhPJxTjkI/i0Cr+wX6s5fm+I0G4Mi+Aue9KSeIQT4UovxhiXPaW4JMBSfoFUXuFdZSPyVJWhju8A==
X-Received: by 2002:ab0:5b03:: with SMTP id u3mr13593844uae.41.1634317762584;
        Fri, 15 Oct 2021 10:09:22 -0700 (PDT)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com. [209.85.222.52])
        by smtp.gmail.com with ESMTPSA id d2sm3864937vsl.8.2021.10.15.10.09.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 10:09:22 -0700 (PDT)
Received: by mail-ua1-f52.google.com with SMTP id q13so19394787uaq.2;
        Fri, 15 Oct 2021 10:09:21 -0700 (PDT)
X-Received: by 2002:a67:d583:: with SMTP id m3mr15400411vsj.41.1634317761438;
 Fri, 15 Oct 2021 10:09:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-3-zhang.lyra@gmail.com>
 <YV1XpL7ibF1y4LbV@google.com> <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
 <YWVD0RXHVLxuXEIN@google.com> <CAMuHMdWqYVp1JyzZoidAJhPy9ypRnSOWHJLz5knDUMcFHPOzAw@mail.gmail.com>
 <YWfSz00Rj5AVhkgT@google.com> <CAL_Jsq+GHt+DqHa0GeLKWoni+Lghg5wg5ssREZBdSD-=K3XQ1A@mail.gmail.com>
 <163425256290.1688384.5646232860050218479@swboyd.mtv.corp.google.com> <CAL_JsqJV_CoPH7VrX-D5=u2WsoUpp-pTKbcR2y+gWxhv+WKcEg@mail.gmail.com>
In-Reply-To: <CAL_JsqJV_CoPH7VrX-D5=u2WsoUpp-pTKbcR2y+gWxhv+WKcEg@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 15 Oct 2021 19:09:10 +0200
X-Gmail-Original-Message-ID: <CAMuHMdU1TCOvDwx6pjg=0-hLkFywRGQsZUNM+0aJLb96fZGAQA@mail.gmail.com>
Message-ID: <CAMuHMdU1TCOvDwx6pjg=0-hLkFywRGQsZUNM+0aJLb96fZGAQA@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
To:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Lee Jones <lee.jones@linaro.org>,
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

Hi Rob, Stephen,

On Fri, Oct 15, 2021 at 3:59 PM Rob Herring <robh+dt@kernel.org> wrote:
> On Thu, Oct 14, 2021 at 6:02 PM Stephen Boyd <sboyd@kernel.org> wrote:
> > Quoting Rob Herring (2021-10-14 09:18:16)
> > > On Thu, Oct 14, 2021 at 1:48 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > I don't explicitly build DT documentation.
> > > >
> > > > Since I use the build bots to let me know if there are strange !(C,
> > > > ASM, arm, aarch64, mips, ppc, x86) build issues or ones with odd
> > > > configuration possibilities (randconfig) in the repos I maintain, you
> > > > might have to convince them that this is important too.
> > >
> > > It's really just a matter of turning on the build in
> > > allyesconfig/allmodconfig builds. I've not done that primarily because
> > > there's one person I don't want to yell at me, but I could probably
> > > make it arm and/or arm64 only. It's really arch and config
> > > independent, so doing it multiple times is kind of pointless.
> > >
> > > I assume for bots you mean kernel-ci mainly? Do you run that before
> > > stuff gets into linux-next? IMO, that's too late. But still a slight
> > > improvement if things go in via one tree. Otherwise, I see the
> > > breakage twice, 1st linux-next then the merge window.
> > >
> >
> > I run `make dt_binding_check DT_SCHEMA_FILES="<path to yaml file>"` but
> > nowadays this seems to check all the bindings and not just the one
> > binding I care to check. Did something break?
>
> It should apply all the schemas to the example in DT_SCHEMA_FILES.
> Originally, it only applied DT_SCHEMA_FILES schema to the example in
> DT_SCHEMA_FILES.

Probably Stephen means that yamllint is still run on all files, which
I tried to fix in [1]?

I've been running an improved version for months, but I haven't sent
it out yet.

[1] https://lore.kernel.org/linux-devicetree/20210309112148.2309116-1-geert+renesas@glider.be

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
