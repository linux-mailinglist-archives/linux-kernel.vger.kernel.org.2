Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE4E3E1BA8
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241721AbhHESsL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:48:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241630AbhHESsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:48:10 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63FE0C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 11:47:56 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id z18so10640844ybg.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 11:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=onuCFbbIQy648bmW/hwLBepA/MfcS58ir6/e+6DRbBo=;
        b=VIIVDNyqYua7BtaGpFeK3EMvAjJmWnuFMWzmaiDFsgthEfL232m9fNny/y9FigkwJD
         EGRJdFj6BRhWrfgJaTRUCIOo/KbLllEwQIfToTLRMxLcQ9NAG+9Vdxqk+rlrlPvNSIWN
         Y/EVrsrOAdeT/oASTIO/ZZM7aSgISZVK4o74p/90qR6Hj+2/5dMsEhv2V1zkxHck6nS3
         jYab+9E5wuV2TiStooLzOcjZBbqpWeVU75ZK0oc89LfFnwSWQVRRAGoZBvj7QgoRAxqr
         ejkGR4qqUujrruKTfgBJqSI9yrygLzA78mWj9M2vZrvLYggQ0jG/8oxvWOSyR1uP/s6p
         3KuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=onuCFbbIQy648bmW/hwLBepA/MfcS58ir6/e+6DRbBo=;
        b=AoQp+w6vvcc8zmnmx33BgqmmvLd5UKARBrqQkP97+4z0qmj13OEScDJc01PMX3XWIq
         BUO/NjAgHOZ08cjy0J7AhbPxABVzJzdN4BymJMwI1L3gdptReGhettj1zamMVUoGJt0t
         9P1OypmTw8eRt1eJEmuyOszJjVcnGYBmbtyrGX+WpLBFwPXc1OUbzEmCF2JYti6Zocfr
         hK3EaHCjMpxWIVsjF2w0ZnQPgQt+MVnVlcw/Zh3Qjf8wH1AaY9FCNByYjV0/YGs1v4g1
         QYUJ+fL+xGm0hOO9vLYyXbyZc0ez+GRTwZFoUZJU39upJ7TXn6z7lSyCRRTyakp63QMC
         yaiw==
X-Gm-Message-State: AOAM530lFjqeMz9wR/8omQ7YIRl5ae+c2W+GK+0/TC3NIBbRCaowkgVa
        lLgwSELVWOMCTP/2YA2erIIMZP2zM16OZTYE3vH8+w==
X-Google-Smtp-Source: ABdhPJyw4t3SQ1CiV/jHTLCnD3Vw+lQF8TgvS9wXsKkqPWx2SlrxG6H7AKe85SYI05V6/I7bDkTh8Ae1k4bkd9alWHg=
X-Received: by 2002:a25:d1c2:: with SMTP id i185mr7676130ybg.466.1628189275466;
 Thu, 05 Aug 2021 11:47:55 -0700 (PDT)
MIME-Version: 1.0
References: <20210804214333.927985-1-saravanak@google.com> <87v94kb6xa.wl-maz@kernel.org>
 <7hfsvng2mj.fsf@baylibre.com> <CAOi56cW5=Yy_vtPM+i1M7YxQuKw75Zx2xgcgEsyfdm2E-qobmQ@mail.gmail.com>
In-Reply-To: <CAOi56cW5=Yy_vtPM+i1M7YxQuKw75Zx2xgcgEsyfdm2E-qobmQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Thu, 5 Aug 2021 11:47:19 -0700
Message-ID: <CAGETcx_QUz9AUONgtYqNOqZqNkkfg2wOP48Q8=-W1zPc-mfoFg@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Clean up and fix error handling in mdio_mux_init()
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Marc Zyngier <maz@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        kernel-team@android.com, netdev@vger.kernel.org,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 5, 2021 at 11:38 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> On Thu, Aug 5, 2021 at 11:36 AM Kevin Hilman <khilman@baylibre.com> wrote:
> >
> > Marc Zyngier <maz@kernel.org> writes:
> >
> > > Hi Saravana,
> > >
> > > On Wed, 04 Aug 2021 22:43:29 +0100,
> > > Saravana Kannan <saravanak@google.com> wrote:
> > >>
> > >> This patch series was started due to -EPROBE_DEFER not being handled
> > >> correctly in mdio_mux_init() and causing issues [1]. While at it, I also
> > >> did some more error handling fixes and clean ups. The -EPROBE_DEFER fix is
> > >> the last patch.
> > >>
> > >> Ideally, in the last patch we'd treat any error similar to -EPROBE_DEFER
> > >> but I'm not sure if it'll break any board/platforms where some child
> > >> mdiobus never successfully registers. If we treated all errors similar to
> > >> -EPROBE_DEFER, then none of the child mdiobus will work and that might be a
> > >> regression. If people are sure this is not a real case, then I can fix up
> > >> the last patch to always fail the entire mdio-mux init if any of the child
> > >> mdiobus registration fails.
> > >>
> > >> Cc: Marc Zyngier <maz@kernel.org>
> > >> Cc: Neil Armstrong <narmstrong@baylibre.com>
> > >> Cc: Kevin Hilman <khilman@baylibre.com>
> > >> [1] - https://lore.kernel.org/lkml/CAGETcx95kHrv8wA-O+-JtfH7H9biJEGJtijuPVN0V5dUKUAB3A@mail.gmail.com/#t
> > >>
> > >> Saravana Kannan (3):
> > >>   net: mdio-mux: Delete unnecessary devm_kfree
> > >>   net: mdio-mux: Don't ignore memory allocation errors
> > >>   net: mdio-mux: Handle -EPROBE_DEFER correctly
> > >>
> > >>  drivers/net/mdio/mdio-mux.c | 37 ++++++++++++++++++++++++-------------
> > >>  1 file changed, 24 insertions(+), 13 deletions(-)
> > >
> > > Thanks for this. I've just gave it a go on my test platform, and this
> > > indeed addresses the issues I was seeing [1].
> > >
> > > Acked-by: Marc Zyngier <maz@kernel.org>
> > > Tested-by: Marc Zyngier <maz@kernel.org>
> >
> > I wasn't seeing the same issues as Marc, but am heavily using everything
> > as modules on a few platforms using this code, and I'm not seeing any
> > regressions.

The only guess I have for this difference in results is I'm guessing
in your case the IRQ module is somehow getting loaded before the
mux/PHY driver?

> >
> > Thanks Saravana for finding the root cause here.
> >
> > Acked-by: Kevin Hilman <khilman@baylibre.com>
> > Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>
> Oops, that should not be a SoB, but rather:
>
> Tested-by: Kevin Hilman <khilman@baylibre.com>

Thanks for the Acks/tests.

-Saravana
