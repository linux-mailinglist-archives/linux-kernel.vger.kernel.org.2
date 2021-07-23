Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5853D436A
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jul 2021 01:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233145AbhGWWzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 18:55:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:37352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232550AbhGWWzt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 18:55:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2440060F35;
        Fri, 23 Jul 2021 23:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627083382;
        bh=OgmN047jAuLjM5BKQ46Fip2OTLJSsCLtOO5/JwB+VY4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=V4B/bP/wttZGa5Bpb/JMdmDYR5VzCb55h2j420M50J8Q6G6hPHSDONKZuj6yUBk03
         1ZV+N+YappLmblGOhO0bPuh1iVbWNj2iEVKFcKb5uq+JOCIDOrup2ZqpRqlPOrX6bY
         iQFQ7zgXOV3dIsKmA9SsckWbH5ws7YidrLQ0FeucDjUUCcG/7xnIqrQJ7a7icGatoz
         OvZxoXxoBHIPSNOYqBRrifCl2lwCVoBtOt82bKmVOBoPCiKI2wZGjs75FbGkUDGNDQ
         hKrSQqnoKch/3to6VNf/GIipqXUWg3G/NXQE/aRg20fJlY2cwwv88ieQsjYOW8Ox6V
         AvpZoLx2cLiWA==
Received: by mail-ed1-f52.google.com with SMTP id df26so3644136edb.9;
        Fri, 23 Jul 2021 16:36:22 -0700 (PDT)
X-Gm-Message-State: AOAM530o7nPfwxG7x5aMIgSUE8ZL5ABOh0k0EiyklYAt8nZcg4m99PZl
        D7z9kVYRwoS8USPoNdZjLWtW6hpBXwCxzv/Rag==
X-Google-Smtp-Source: ABdhPJyZST6mg5GShwdylESiCi8iKzOx7W2m4QuplhuIQas0YRkQ2/nGFg4qa+gkYWbLK8bEZZVxgJWR002O9d1/BlQ=
X-Received: by 2002:aa7:df12:: with SMTP id c18mr8438913edy.62.1627083380778;
 Fri, 23 Jul 2021 16:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20210519161847.3747352-1-fparent@baylibre.com>
 <20210521014815.GA2476751@robh.at.kernel.org> <CAL_Jsq+HWxQwFuKM==g-PBROxGN_xoWCc060U0pDpsDdfWJWPg@mail.gmail.com>
 <CAFqH_50rKvYZGeRMoaqtYZ6Hdbm6tjLTHB3N9JGsFai1ad0Dzg@mail.gmail.com>
In-Reply-To: <CAFqH_50rKvYZGeRMoaqtYZ6Hdbm6tjLTHB3N9JGsFai1ad0Dzg@mail.gmail.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Fri, 23 Jul 2021 17:36:08 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKyA+Br=44gvK66VX_Ardx7QOgkqCZ5Xv=5+enn4vZtsQ@mail.gmail.com>
Message-ID: <CAL_JsqKyA+Br=44gvK66VX_Ardx7QOgkqCZ5Xv=5+enn4vZtsQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: mediatek: mmsys: convert to YAML format
To:     Enric Balletbo Serra <eballetbo@gmail.com>
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

On Fri, Jul 23, 2021 at 3:45 AM Enric Balletbo Serra
<eballetbo@gmail.com> wrote:
>
> Hi Rob,
>
> Missatge de Rob Herring <robh+dt@kernel.org> del dia dv., 21 de maig
> 2021 a les 3:51:
> >
> > On Thu, May 20, 2021 at 8:48 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > On Wed, 19 May 2021 18:18:44 +0200, Fabien Parent wrote:
> > > > Convert the mmsys bindings to the YAML format.
> > > >
> > > > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > > > ---
> > > >  .../bindings/arm/mediatek/mediatek,mmsys.txt  | 31 ----------
> > > >  .../bindings/arm/mediatek/mediatek,mmsys.yaml | 57 +++++++++++++++++++
> > > >  2 files changed, 57 insertions(+), 31 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,mmsys.yaml
> > > >
> > >
> > > Applied, thanks!
> >
> > Actually, should go with patch 3. So dropped and:
> >
>
> I think that this patch can be applied alone through your tree, patch
> 2 and 3 can be applied later for the maintainers when they are fine.
> There are other patches in the ML that depend on having this meged, so
> it would be really nice to have it. Although it has already your
> ack/review if it help I also took a look and I know the hardware so:
>
> Reviewed-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>

Okay, patch 1 and 2 applied.

Rob
