Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3D3B41F234
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Oct 2021 18:35:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355032AbhJAQhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Oct 2021 12:37:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232117AbhJAQhD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Oct 2021 12:37:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E2DDB61A38;
        Fri,  1 Oct 2021 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633106118;
        bh=nVW08TNUk03OPUkLLPVL11J+xOFZLhl1XXPfCDsxML0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V+Xg+U5ndcyUb/3WDyMptVjyiilObg0CqSnEjRj3Y+trirRNQZIO9x/aQHmpchsEY
         718nz+4TRWo/M+EQbtNjZCVIKXfH1d821eR+S4ZFwFGKPmEue+zScfbOzNMiTbrH06
         uHP3cxFqoem4g4Y+5Oy8Fee7/zleIAuPWBJIAuVjDH9XYXKWJGFjlPu9zUtA0tHm+X
         1jILH8/pWaVDFdo9mX4RYmOGk/E5ddHAVgLgQseZaoKtKBPHKYGmotGUrPxVXsWzks
         YaTEbTdz8iOuPMwBZ9WbCO6lUNv6rsIBU31J6NhFWVJGXOSDIwZc3EUxNGt/enGO9y
         P3E8JkoIivGBg==
Received: by mail-ed1-f41.google.com with SMTP id dn26so36755350edb.13;
        Fri, 01 Oct 2021 09:35:18 -0700 (PDT)
X-Gm-Message-State: AOAM5306vrdTJpAyoOsXcHYLbEJOB806DsLJPX3uTgAhwXhr1po3I8/P
        0Tl3YmJ26e4RZ2yY+RJLqQ4Ot/8XeLrQQIrV9w==
X-Google-Smtp-Source: ABdhPJzODcTe1gXJOefNR80freMbEX7WPVVHaY6R4BrgS/d3fO1+KRudSZl9TswU/WacJLi7Q/IWLZqZWEr+mcisi0Q=
X-Received: by 2002:a17:906:7217:: with SMTP id m23mr7160192ejk.466.1633106117370;
 Fri, 01 Oct 2021 09:35:17 -0700 (PDT)
MIME-Version: 1.0
References: <20211001000924.15421-1-leoyang.li@nxp.com> <20211001000924.15421-2-leoyang.li@nxp.com>
 <1633094217.843390.3666440.nullmailer@robh.at.kernel.org> <CADRPPNQBR63pS60nmfUQx02GbBoWEbgroU5Zw-iY62TodmB91Q@mail.gmail.com>
In-Reply-To: <CADRPPNQBR63pS60nmfUQx02GbBoWEbgroU5Zw-iY62TodmB91Q@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 1 Oct 2021 11:35:05 -0500
X-Gmail-Original-Message-ID: <CAL_JsqL_M2Y+CDfK95BmFJYxT2h4q8rd0BaHLk2Wth3u_U6YMQ@mail.gmail.com>
Message-ID: <CAL_JsqL_M2Y+CDfK95BmFJYxT2h4q8rd0BaHLk2Wth3u_U6YMQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] dt-bindings: memory: fsl: convert ifc binding to yaml schema
To:     Li Yang <leoyang.li@nxp.com>
Cc:     "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 1, 2021 at 11:29 AM Li Yang <leoyang.li@nxp.com> wrote:
>
> On Fri, Oct 1, 2021 at 8:18 AM Rob Herring <robh@kernel.org> wrote:
> >
> > On Thu, 30 Sep 2021 19:09:20 -0500, Li Yang wrote:
> > > Convert the txt binding to yaml format and add description.  Drop the
> > > "simple-bus" compatible string from the example and not allowed by the
> > > binding any more.  This will help to enforce the correct probe order
> > > between parent device and child devices, but will require the ifc driver
> > > to probe the child devices to work properly.
> > >
> > > Signed-off-by: Li Yang <leoyang.li@nxp.com>
> > > ---
> > > updates from previous submission:
> > > - Drop "simple-bus" from binding and only "fsl,ifc" as compatible
> > > - Fix one identiation problem of "reg"
> > > - Add type restriction to "little-endian" property
> > >
> > >  .../bindings/memory-controllers/fsl/ifc.txt   |  82 -----------
> > >  .../bindings/memory-controllers/fsl/ifc.yaml  | 137 ++++++++++++++++++
> > >  2 files changed, 137 insertions(+), 82 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.txt
> > >  create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/ifc.yaml
> > >
> >
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >
> > yamllint warnings/errors:
> >
> > dtschema/dtc warnings/errors:
> > Documentation/devicetree/bindings/memory-controllers/fsl/ifc.example.dt.yaml:0:0: /example-0/soc/ifc@ffe1e000/flash@1,0: failed to match any schema with compatible: ['fsl,ifc-nand']
> > Documentation/devicetree/bindings/memory-controllers/fsl/ifc.example.dt.yaml:0:0: /example-0/soc/ifc@ffe1e000/cpld@3,0: failed to match any schema with compatible: ['fsl,p1010rdb-cpld']
>
> These are defined in other bindings, but unfortunately they are not
> converted to yaml format yet.

Yes, I know. I'm trying to turn on this check by default and adding
more cases here doesn't help. And often, when those other bindings get
converted, it's the example here that has errors and has to get fixed.
So either convert those bindings too or drop them from the example.

Rob
