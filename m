Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E24042DF09
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 18:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233230AbhJNQUo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Oct 2021 12:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:53222 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231194AbhJNQUk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Oct 2021 12:20:40 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 87CB06101E;
        Thu, 14 Oct 2021 16:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634228314;
        bh=pRQ3JZfJtb5xsfp0oPcwUPPHLjaUmki8tcnhUCu7iwM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=C4pkMrjbMaqtqvVmV/hBpQ/Gk+2aUpRPSaCoBhG9Sz/NuJ9wDHC6LA0gtgkHqtMO4
         fdAfI+Jh2EP3M0NxOpFgb1hAjfcV1S/1mcImMQx+JMPShDRyjcIvO+v3jJTjj2b6Ca
         pXmjtgqkD9yfz42puOUj2OcE8pHhKe7KpdTysatwduJvFep1iE7shShIjZng/Hwpea
         ZrJC4EnBa91wHusgAV1iWWqgGnVUwXgQaOEU9rn/Rg1w88Jb66NO41PreGWRhVNMYb
         UXpqbuIFOuIw1QEx54YozGE+kWX+SyWdS4ODhyYLoVAKJCdfGeVocZN7hpYw1VfU5Z
         Ny0Z/m8kiXPSA==
Received: by mail-ed1-f52.google.com with SMTP id d9so26177901edh.5;
        Thu, 14 Oct 2021 09:18:34 -0700 (PDT)
X-Gm-Message-State: AOAM533YSvRy26dmBf2/2W4g7Dxg+acYQvbawx7Dtsm4Kps5e6b+s8M1
        wI+U+i0jijYx1pKdun/9H29+Ap3Tmk7ydijuNQ==
X-Google-Smtp-Source: ABdhPJzsUk/V37d7unFrB7QJ0575PStsMRgexykMDwTWWaEwyvjCjKzDfsjSHjCLV0d5RKuRpOizozD8OfiHo1993B0=
X-Received: by 2002:aa7:c357:: with SMTP id j23mr10140454edr.145.1634228311827;
 Thu, 14 Oct 2021 09:18:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-3-zhang.lyra@gmail.com>
 <YV1XpL7ibF1y4LbV@google.com> <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
 <YWVD0RXHVLxuXEIN@google.com> <CAMuHMdWqYVp1JyzZoidAJhPy9ypRnSOWHJLz5knDUMcFHPOzAw@mail.gmail.com>
 <YWfSz00Rj5AVhkgT@google.com>
In-Reply-To: <YWfSz00Rj5AVhkgT@google.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Thu, 14 Oct 2021 11:18:16 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+GHt+DqHa0GeLKWoni+Lghg5wg5ssREZBdSD-=K3XQ1A@mail.gmail.com>
Message-ID: <CAL_Jsq+GHt+DqHa0GeLKWoni+Lghg5wg5ssREZBdSD-=K3XQ1A@mail.gmail.com>
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

On Thu, Oct 14, 2021 at 1:48 AM Lee Jones <lee.jones@linaro.org> wrote:
>
> On Wed, 13 Oct 2021, Geert Uytterhoeven wrote:
>
> > Hi Lee,
> >
> > On Tue, Oct 12, 2021 at 10:15 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > On Mon, 11 Oct 2021, Rob Herring wrote:
> > > > On Wed, Oct 6, 2021 at 3:00 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > On Thu, 23 Sep 2021, Chunyan Zhang wrote:
> > > > >
> > > > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > > >
> > > > > > Add bindings for Unisoc system global register which provide register map
> > > > > > for clocks.
> > > > > >
> > > > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > > ---
> > > > > >  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
> > > > > >  1 file changed, 68 insertions(+)
> > > > > >  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> > > > >
> > > > > Unapplied v3 and applied this (v4) instead, thanks.
> > > >
> > > > What about the clock binding this depends on:
> > > >
> > > > Unknown file referenced: [Errno 2] No such file or directory:
> > > > '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> > > > xargs: dt-doc-validate: exited with status 255; aborting
> > > > make[1]: *** Deleting file
> > > > 'Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml'
> > > > Unknown file referenced: [Errno 2] No such file or directory:
> > > > '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> > > > make[1]: *** [scripts/Makefile.lib:385:
> > > > Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml]
> > > > Error 255
> > > >
> > > >
> > > > Once again, all the components of MFD bindings need to be applied together.
> >
> > Just ran into this, too...
> >
> > > I can't apply what is not sent to me.
> > >
> > > This patch came in on its own.
> >
> > Then please reject/postpone patches that don't build (yet) ;-)
>
> I don't explicitly build DT documentation.
>
> Since I use the build bots to let me know if there are strange !(C,
> ASM, arm, aarch64, mips, ppc, x86) build issues or ones with odd
> configuration possibilities (randconfig) in the repos I maintain, you
> might have to convince them that this is important too.

It's really just a matter of turning on the build in
allyesconfig/allmodconfig builds. I've not done that primarily because
there's one person I don't want to yell at me, but I could probably
make it arm and/or arm64 only. It's really arch and config
independent, so doing it multiple times is kind of pointless.

I assume for bots you mean kernel-ci mainly? Do you run that before
stuff gets into linux-next? IMO, that's too late. But still a slight
improvement if things go in via one tree. Otherwise, I see the
breakage twice, 1st linux-next then the merge window.

Rob
