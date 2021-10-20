Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 777F4434EAB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Oct 2021 17:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbhJTPLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Oct 2021 11:11:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:46298 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229570AbhJTPLj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Oct 2021 11:11:39 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 56E0E6137C;
        Wed, 20 Oct 2021 15:09:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634742565;
        bh=V8dOGDI+8Esrzokm8M0yenicCab84JXeYlub3sJhK+o=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YxGYAXE9zbZQX/iXvbXcaARd+gX5myi8BFCBo9z/IiVSOZUcyLzIpDHWIoeEEw9lq
         ur5yChHfowLYRejboVz5EyCZ9gKtIvtnM7g7YWavWTNTYtXA5sfaLC1j/WDHSZpepT
         bdIE+03FXIavtRSKAHs+zXVWjdWFhmWtvVthl1ydVZBHOXvScUy3e77JVpJWprHfw2
         4kVUankFrG8DtmyFnMlk9L+iSCtwB5OyyZ0Q4EZmnSOB2/iIbKMpoNjduBbUYsX7Fo
         n6vTaFDy0zNehwqGcpU57HId2M6dJ7GHOrD7YKuLypZxmXKyDPgk81sSSamZ7yMIGz
         t5X4yYQ0pExvQ==
Received: by mail-qk1-f176.google.com with SMTP id bp7so3350217qkb.12;
        Wed, 20 Oct 2021 08:09:25 -0700 (PDT)
X-Gm-Message-State: AOAM531bJ/YkFmuNL99g+4ux9jpOTVHrzmgY2kl1vcLsmt3i2r/ak/BZ
        I05PyQiH0knl66xvuPn5wHVZLCUPPxlOm5Q+OA==
X-Google-Smtp-Source: ABdhPJyGoWzG5JvS8XT67rDl5KsAoE+oAvmANea6yGKMy2Cxc0+sI6RuMRf9B7gkVo8hK4KsjNLCXx6U2Pzicu3/xZU=
X-Received: by 2002:ae9:df01:: with SMTP id t1mr117844qkf.202.1634742564401;
 Wed, 20 Oct 2021 08:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210923064137.60722-1-zhang.lyra@gmail.com> <20210923064137.60722-3-zhang.lyra@gmail.com>
 <YV1XpL7ibF1y4LbV@google.com> <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
In-Reply-To: <CAL_Jsq+eqqv=qtKOiNdEpYGi2amek_m+Q-Z9A769pXXqJ4R88A@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Wed, 20 Oct 2021 10:09:13 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLUkxKOMSWLzTK14h3EyBCsO2dfq3=MxOSvv1ZK0_H=ow@mail.gmail.com>
Message-ID: <CAL_JsqLUkxKOMSWLzTK14h3EyBCsO2dfq3=MxOSvv1ZK0_H=ow@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] dt-bindings: mfd: sprd: Add bindings for ums512
 global registers
To:     Lee Jones <lee.jones@linaro.org>, Stephen Boyd <sboyd@kernel.org>
Cc:     Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        devicetree@vger.kernel.org, Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 11, 2021 at 9:11 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> On Wed, Oct 6, 2021 at 3:00 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
> > On Thu, 23 Sep 2021, Chunyan Zhang wrote:
> >
> > > From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > >
> > > Add bindings for Unisoc system global register which provide register map
> > > for clocks.
> > >
> > > Signed-off-by: Chunyan Zhang <chunyan.zhang@unisoc.com>
> > > Reviewed-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  .../bindings/mfd/sprd,ums512-glbreg.yaml      | 68 +++++++++++++++++++
> > >  1 file changed, 68 insertions(+)
> > >  create mode 100644 Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.yaml
> >
> > Unapplied v3 and applied this (v4) instead, thanks.
>
> What about the clock binding this depends on:
>
> Unknown file referenced: [Errno 2] No such file or directory:
> '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> xargs: dt-doc-validate: exited with status 255; aborting
> make[1]: *** Deleting file
> 'Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml'
> Unknown file referenced: [Errno 2] No such file or directory:
> '/usr/local/lib/python3.8/dist-packages/dtschema/schemas/clock/sprd,ums512-clk.yaml'
> make[1]: *** [scripts/Makefile.lib:385:
> Documentation/devicetree/bindings/mfd/sprd,ums512-glbreg.example.dt.yaml]
> Error 255
>
>
> Once again, all the components of MFD bindings need to be applied together.

It seems that Stephen still has comments and there's a new check that
causes the clock schema to fail, so this should be dropped or
reverted.

Rob
