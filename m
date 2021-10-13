Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D4342C2FD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Oct 2021 16:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237568AbhJMO0E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 10:26:04 -0400
Received: from mail-ua1-f46.google.com ([209.85.222.46]:41633 "EHLO
        mail-ua1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237023AbhJMOZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 10:25:49 -0400
Received: by mail-ua1-f46.google.com with SMTP id r17so4811342uaf.8;
        Wed, 13 Oct 2021 07:23:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zNNwxJntPelVzthYYfS3wD/s42WAInQuB5G4Ec3wxno=;
        b=A4piRSdpFRFSsV2LwyaYTFZmHytfIHrqnOuo3vrhmsiHT1rI3DGs8w4r2X/z4ChBLA
         v5naeVC49Sm+ufHk7Ip158La6BmkcXVBB3BWL9oNv7+d1u7fTPzjnG/jPWexraYeUvNs
         vBeg/RE02a6RZfGVbApNj/k8HGgfYNAatj9MIkUJ/F9WuFnQvsY0SvDHRh0SsjKNJLOq
         Umn9Cn7f4dCSHkt160RSrF6nqqpm6/MzVcTLd6mbcegnBW1ckpM5Qgx8iUkyvVvrYi6/
         tdReIb3UPWfxz5eCmr1wgYcHi86DjuRFqR2NzwHfVcyaOKAVH52KXO2LoGpIUxSwOceE
         sNRA==
X-Gm-Message-State: AOAM531/bTw6Opv3DU4KN/CS/MD0yQ+ON6tNTr0opHcv/DZKO3pUvX1t
        lBghnee6W1QMTJ2NLXJAI4zd+Q/mzo08/xTL4DPh8IgUAxU=
X-Google-Smtp-Source: ABdhPJyVBz2qZhn6Yk8BFs3zwSU5zXbxoK7s+6JfEWHFLKXXJNvSK3MQArrzkyFAYgPN9iWjM7z9oHDAT4GQjuDmTus=
X-Received: by 2002:a67:d583:: with SMTP id m3mr38709938vsj.41.1634135025809;
 Wed, 13 Oct 2021 07:23:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-3-zhang.lyra@gmail.com>
 <YV1XpL7ibF1y4LbV@google.com> <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
 <YWVD0RXHVLxuXEIN@google.com>
In-Reply-To: <YWVD0RXHVLxuXEIN@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 13 Oct 2021 16:23:34 +0200
Message-ID: <CAMuHMdWqYVp1JyzZoidAJhPy9ypRnSOWHJLz5knDUMcFHPOzAw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
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

Hi Lee,

On Tue, Oct 12, 2021 at 10:15 AM Lee Jones <lee.jones@linaro.org> wrote:
> On Mon, 11 Oct 2021, Rob Herring wrote:
> > On Wed, Oct 6, 2021 at 3:00 AM Lee Jones <lee.jones@linaro.org> wrote:
> > > On Thu, 23 Sep 2021, Chunyan Zhang wrote:
> > >
> > > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > >
> > > > Add bindings for Unisoc system global register which provide register map
> > > > for clocks.
> > > >
> > > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
> > > >  1 file changed, 68 insertions(+)
> > > >  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> > >
> > > Unapplied v3 and applied this (v4) instead, thanks.
> >
> > What about the clock binding this depends on:
> >
> > Unknown file referenced: [Errno 2] No such file or directory:
> > '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> > xargs: dt-doc-validate: exited with status 255; aborting
> > make[1]: *** Deleting file
> > 'Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml'
> > Unknown file referenced: [Errno 2] No such file or directory:
> > '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> > make[1]: *** [scripts/Makefile.lib:385:
> > Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml]
> > Error 255
> >
> >
> > Once again, all the components of MFD bindings need to be applied together.

Just ran into this, too...

> I can't apply what is not sent to me.
>
> This patch came in on its own.

Then please reject/postpone patches that don't build (yet) ;-)

Gr{oetje,eeting}s,

                        Geert


--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
