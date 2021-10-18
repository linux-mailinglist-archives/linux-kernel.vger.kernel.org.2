Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4D3431832
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Oct 2021 13:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhJRLzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Oct 2021 07:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229870AbhJRLzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Oct 2021 07:55:16 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 920D7C06161C
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 04:53:05 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id v127so8488659wme.5
        for <linux-kernel@vger.kernel.org>; Mon, 18 Oct 2021 04:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=OjLEjB+66gVcYoeS09uTUDIcrNaPGWu2B8UnkmdnjH8=;
        b=TrNwmmZrgahcTims1xWqWBxeCqU683WDHAH56sTYfn6zV/+JBJBqAkYxq70Kp6jhAW
         z7Mixy3n1K/zgsRFYDzvaZ8625DAyCGnq8EO08kv2D75JFgexb69aSm4EsjjDnUUI5gr
         rcSguRag8AfHNcvcJKLmO14BTI+pOnwajLKEGTVW6JXbDMrt+HCsl6gPs7AHud8HuokL
         NPfai1qTH4gzcucVUgaAbI/ygD+WdYGMUUiW0OK0hX1RfYeQJlIJ/MDrhgwxUAYNTPfj
         Sz4UKZkkRWRetl9dWGMANObQyChq1e1bNzFV8jenVLEMCcCfgnUjMrPMSUBtcrQRlj7p
         DCUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=OjLEjB+66gVcYoeS09uTUDIcrNaPGWu2B8UnkmdnjH8=;
        b=wC5w1CVeRDLzjuO8psGN2XnABR2kDocBKcffQWxmHOAWSX+j6z6zQuF4VGzSLjbr7t
         W/Cv/9MbUdRmAsl6IsyXwNIxYv7Hp5gySL+f+pfranlDBboNVIef7aV8rRA+aybWsupN
         COUidF95MWcZGW73KFy/Ve+oxgqbg9DScvhXaYWwE2xe8jJLQZ7aNGz5WOu1fuAiWeqN
         E5Pt4edAmFfWSBpp83LcEKOonbaFYOJi/OmIKEgxfYQYsnYVf8EOPMsMpiBtjZ3uKGb6
         /J821n1FiwJAP6eQJwoUafAu1elYrI993BopzPutXferxgr3hTZjC4OI6LqYQUfZcH4Q
         c6yQ==
X-Gm-Message-State: AOAM533Kry4bmD+YgXg5rHtJ4xTA+ZamqlHa42ToyZZq5GqHon9oFFv4
        6a+bu8onbWyc7WTAjFAxgr6utQ==
X-Google-Smtp-Source: ABdhPJxItLyyofC2JRkGeF4ExPOPrkr01IZHTPDrzV2bHDZsePkNF5ptZ6iL8Bcj5Nl9CdILuFVcvw==
X-Received: by 2002:a1c:2309:: with SMTP id j9mr42794361wmj.189.1634557984169;
        Mon, 18 Oct 2021 04:53:04 -0700 (PDT)
Received: from google.com ([95.148.6.207])
        by smtp.gmail.com with ESMTPSA id a16sm12223529wrs.30.2021.10.18.04.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Oct 2021 04:53:03 -0700 (PDT)
Date:   Mon, 18 Oct 2021 12:53:01 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
Message-ID: <YW1gHXKLIe6nyVOd@google.com>
References: <20210923064137.60722-1-zhang.lyra@gmail.com>
 <20210923064137.60722-3-zhang.lyra@gmail.com>
 <YV1XpL7ibF1y4LbV@google.com>
 <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
 <YWVD0RXHVLxuXEIN@google.com>
 <CAMuHMdWqYVp1JyzZoidAJhPy9ypRnSOWHJLz5knDUMcFHPOzAw@mail.gmail.com>
 <YWfSz00Rj5AVhkgT@google.com>
 <CAL_Jsq+GHt+DqHa0GeLKWoni+Lghg5wg5ssREZBdSD-=K3XQ1A@mail.gmail.com>
 <YWl33gCy1ac29WSs@google.com>
 <CAL_JsqJNzA4iX2V5FnSg+phNh72JeRxn+D4250aKmOhngZO9yA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqJNzA4iX2V5FnSg+phNh72JeRxn+D4250aKmOhngZO9yA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Oct 2021, Rob Herring wrote:

> On Fri, Oct 15, 2021 at 7:45 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 14 Oct 2021, Rob Herring wrote:
> >
> > > On Thu, Oct 14, 2021 at 1:48 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > >
> > > > On Wed, 13 Oct 2021, Geert Uytterhoeven wrote:
> > > >
> > > > > Hi Lee,
> > > > >
> > > > > On Tue, Oct 12, 2021 at 10:15 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > On Mon, 11 Oct 2021, Rob Herring wrote:
> > > > > > > On Wed, Oct 6, 2021 at 3:00 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > > > > > > On Thu, 23 Sep 2021, Chunyan Zhang wrote:
> > > > > > > >
> > > > > > > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > > > > > >
> > > > > > > > > Add bindings for Unisoc system global register which provide register map
> > > > > > > > > for clocks.
> > > > > > > > >
> > > > > > > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > > > > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > > > > > > ---
> > > > > > > > >  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
> > > > > > > > >  1 file changed, 68 insertions(+)
> > > > > > > > >  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> > > > > > > >
> > > > > > > > Unapplied v3 and applied this (v4) instead, thanks.
> > > > > > >
> > > > > > > What about the clock binding this depends on:
> > > > > > >
> > > > > > > Unknown file referenced: [Errno 2] No such file or directory:
> > > > > > > '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> > > > > > > xargs: dt-doc-validate: exited with status 255; aborting
> > > > > > > make[1]: *** Deleting file
> > > > > > > 'Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml'
> > > > > > > Unknown file referenced: [Errno 2] No such file or directory:
> > > > > > > '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> > > > > > > make[1]: *** [scripts/Makefile.lib:385:
> > > > > > > Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml]
> > > > > > > Error 255
> > > > > > >
> > > > > > >
> > > > > > > Once again, all the components of MFD bindings need to be applied together.
> > > > >
> > > > > Just ran into this, too...
> > > > >
> > > > > > I can't apply what is not sent to me.
> > > > > >
> > > > > > This patch came in on its own.
> > > > >
> > > > > Then please reject/postpone patches that don't build (yet) ;-)
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
> >
> > Kernel test robot <lkp@intel.com> is the one that springs to mind.
> 
> It already does sometimes. I haven't figured out when, but I randomly
> see some reports and doesn't report a lot of the cases.

It would be great if it can be figured it out.

Apart from my W=1 work, I seldom build/test/run obscure/specialist
compiler flags/options.  If someone can convince the 0-day builder
bots that testing DT docs is a good idea when building for the
appropriate architectures, I'm all in.

> > Although, I'm sure there are other, less prolific implementations.
> 
> Rob's bot, but that checks patches (not branches) and applies series
> so you won't get errors unless the series is in the wrong patch order.

Right.  Good tool, but solves a different problem.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
