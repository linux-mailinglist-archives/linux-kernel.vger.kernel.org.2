Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEB53D37FC
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhGWJEg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 05:04:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbhGWJEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 05:04:35 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 727DDC061575;
        Fri, 23 Jul 2021 02:45:08 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id t128so1260873oig.1;
        Fri, 23 Jul 2021 02:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4ITlUIkGJZ3EJcyJveAVPnUvECk1290YkodSeO4Z4UU=;
        b=uBpSfrknBJUVSdjmW6KG2R9vMs/JUY0uM6lYTVL+oe6b/A6Xnxo36O6xiETTPzs3ph
         u/cv+oUz4NuIjQiTPUnNay9YHsXK8X7Ahj3I/+QSZDrOE/K6X+otgwvyaoE03U6MxKOr
         PGaSfkzBzd+KRZNUVBbzIaFzY6fTxF9Qna+Kk5fTzKNIzcZpaXoN+ELfVKSO8kMC+c2Z
         RZsQ/hHfI8rLR4nBPDTxCab58snIi3/07i7IDwL5Lor55S2f5af/HGDCM/cNojd7iO/0
         854gA1qnHv3HrICTREICTlDzA1284z6IZANhu92LGv/I1WpY8n7hLNQvhd6OeY+MvpLn
         +uHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ITlUIkGJZ3EJcyJveAVPnUvECk1290YkodSeO4Z4UU=;
        b=r3UfwL++jR5iZFek76v3DaxEIqqVsTiYDipgFItny76FTuS4lumaE1AYnDotkDMb2R
         QlcqOj5Yah4ih9zga/ieSiLpuGyHdYOM8bsynIYjngfZ1fQFbcJrJ79AzkllSLXpi9o1
         Oh6IXEa5A2EU7ENhz2Sts92OIQnHN1E+Xex+7tCOav5DYgi1NEDqG6TGEIJmFjjeSthQ
         4tB7AuBcAmrvM2ORGEXkugqwNZ6KdP0YUqwdFwYfsId9VxRyrbrHUBp9pdjORBXCah2O
         hD64W3/nJ1qHI3J8ZStoKGWq9O8+77Te6GY+GAiUmeXxCVK8ImjNg/5FSAotSk0aGHiK
         hKNw==
X-Gm-Message-State: AOAM533Kdg/bw7ZibRyIYGKJz+rqC5+Bwb3PNlbUJM6Z3qsZs047xHTb
        A/IsP8QZGQrnlbiAu60oGAKdvNctq6LzS9Ztscc=
X-Google-Smtp-Source: ABdhPJwLFlNpJvmb+cvMuHIQOIUTXTVWE1efhwIfBt0eE69929SsJekntO5P1eJv7ZPFnY+dc1rsukjlpTjQA0VjmkQ=
X-Received: by 2002:aca:38c3:: with SMTP id f186mr8091241oia.39.1627033507873;
 Fri, 23 Jul 2021 02:45:07 -0700 (PDT)
MIME-Version: 1.0
References: <20210519161847.3747352-1-fparent@baylibre.com>
 <20210521014815.GA2476751@robh.at.kernel.org> <CAL_Jsq+HWxQwFuKM==g-PBROxGN_xoWCc060U0pDpsDdfWJWPg@mail.gmail.com>
In-Reply-To: <CAL_Jsq+HWxQwFuKM==g-PBROxGN_xoWCc060U0pDpsDdfWJWPg@mail.gmail.com>
From:   Enric Balletbo Serra <eballetbo@gmail.com>
Date:   Fri, 23 Jul 2021 11:44:56 +0200
Message-ID: <CAFqH_50rKvYZGeRMoaqtYZ6Hdbm6tjLTHB3N9JGsFai1ad0Dzg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: mediatek: mmsys: convert to YAML format
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Fabien Parent <fparent@baylibre.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

Missatge de Rob Herring <robh+dt@kernel.org> del dia dv., 21 de maig
2021 a les 3:51:
>
> On Thu, May 20, 2021 at 8:48 PM Rob Herring <robh@kernel.org> wrote:
> >
> > On Wed, 19 May 2021 18:18:44 +0200, Fabien Parent wrote:
> > > Convert the mmsys bindings to the YAML format.
> > >
> > > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > > ---
> > >  .../bindings/arm/mediatek/mediatek,mmsys.txt  | 31 ----------
> > >  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 57 +++++++++++++++++++
> > >  2 files changed, 57 insertions(+), 31 deletions(-)
> > >  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> > >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> > >
> >
> > Applied, thanks!
>
> Actually, should go with patch 3. So dropped and:
>

I think that this patch can be applied alone through your tree, patch
2 and 3 can be applied later for the maintainers when they are fine.
There are other patches in the ML that depend on having this meged, so
it would be really nice to have it. Although it has already your
ack/review if it help I also took a look and I know the hardware so:

Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Thanks,
  Enric

> Reviewed-by: Rob Herring <robh@kernel.org>
>
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
