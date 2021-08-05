Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 279E53E1B78
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Aug 2021 20:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbhHESi1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Aug 2021 14:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237913AbhHESi0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Aug 2021 14:38:26 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C51D4C061765
        for <linux-kernel@vger.kernel.org>; Thu,  5 Aug 2021 11:38:11 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id k13so4574542qth.10
        for <linux-kernel@vger.kernel.org>; Thu, 05 Aug 2021 11:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ck5dWuwFo/uEgQ0O9vb5RC+dFl2DTseh0e2RyNx8YIs=;
        b=MZN5AJFgKfTro7Lh5+pBih2rFARR3iXo6Q0qkE/7SnqHk2WdAHSeYBmqu1DRPZcsJn
         A86r8/mVA+NH/1wZQxhhctUvMWHA5t2/xL/iHE43/E8NdSxtHJf3I7oVOoQ8T7xxGJTY
         63PJ2etGJJCkbrK/fPWgU5ixJHWtFN5RjAErrrRFgjC1FF+Ept0JGecAf1cPOBildU97
         GxkpbDc1pshUEZlMQ2oGhr+qERCFZ+EFk+6WbIDbyJ+QXmG4zRV8RfdmYJ6Y16hmOoTC
         wvkkhIACQjtp7FbQjmmCkmS5x/HoBEeSAZLWoIvmy9Bmyk2Dl1OivEjPMSW6W/WUbqdF
         tfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ck5dWuwFo/uEgQ0O9vb5RC+dFl2DTseh0e2RyNx8YIs=;
        b=T3+vqs2vZM7BuIxDt9sUBamgYwzl1GX44iXVYq++QNwtCoMYcOhKGdbwRTtSAagFWX
         lqj8lIX8IgTC2wI1Rk+wtelrt9Y4ah9C3cGuzDVnvnb2HKVx76frEhepxnifCgtRvKZG
         RjrkaEkd9gbHV0J+kquOMBgjOdmW2N/E8V6adkb+l8c+0D6J08ca0bKIV9LM9o+kLdqw
         gKltyjA8dUSKcHR3jQG+YkO5bb85T3aEYnOeVPmQIWvbksXhDpEThs/iVV8OOiqKc5A8
         inETU/X0xaJc0G8YJzVbtCxlDLrj96BEY47kuDdwxZ31X6k/IJ4pNBXz7AOAyeKHFr3t
         BfKg==
X-Gm-Message-State: AOAM530L84dpf23HHtOXyTDbB/6ySC47poI16gesgsAobqorsEerpt0O
        dzZzP5cUgHVSG0NeuDJeM6ah7tyr6UnGkhHYro5zlA==
X-Google-Smtp-Source: ABdhPJzuNqz9YMRe0mQsPKaIqNr0YnYNS1zH2Nf3XmowGNcNu7cslok7UZNmWsFS0mcyu9Cvhw0F+fGM3KsDlDau/N4=
X-Received: by 2002:aed:20c4:: with SMTP id 62mr5705291qtb.139.1628188690844;
 Thu, 05 Aug 2021 11:38:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210804214333.927985-1-saravanak@google.com> <87v94kb6xa.wl-maz@kernel.org>
 <7hfsvng2mj.fsf@baylibre.com>
In-Reply-To: <7hfsvng2mj.fsf@baylibre.com>
From:   Kevin Hilman <khilman@baylibre.com>
Date:   Thu, 5 Aug 2021 11:37:59 -0700
Message-ID: <CAOi56cW5=Yy_vtPM+i1M7YxQuKw75Zx2xgcgEsyfdm2E-qobmQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Clean up and fix error handling in mdio_mux_init()
To:     Marc Zyngier <maz@kernel.org>,
        Saravana Kannan <saravanak@google.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
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

On Thu, Aug 5, 2021 at 11:36 AM Kevin Hilman <khilman@baylibre.com> wrote:
>
> Marc Zyngier <maz@kernel.org> writes:
>
> > Hi Saravana,
> >
> > On Wed, 04 Aug 2021 22:43:29 +0100,
> > Saravana Kannan <saravanak@google.com> wrote:
> >>
> >> This patch series was started due to -EPROBE_DEFER not being handled
> >> correctly in mdio_mux_init() and causing issues [1]. While at it, I also
> >> did some more error handling fixes and clean ups. The -EPROBE_DEFER fix is
> >> the last patch.
> >>
> >> Ideally, in the last patch we'd treat any error similar to -EPROBE_DEFER
> >> but I'm not sure if it'll break any board/platforms where some child
> >> mdiobus never successfully registers. If we treated all errors similar to
> >> -EPROBE_DEFER, then none of the child mdiobus will work and that might be a
> >> regression. If people are sure this is not a real case, then I can fix up
> >> the last patch to always fail the entire mdio-mux init if any of the child
> >> mdiobus registration fails.
> >>
> >> Cc: Marc Zyngier <maz@kernel.org>
> >> Cc: Neil Armstrong <narmstrong@baylibre.com>
> >> Cc: Kevin Hilman <khilman@baylibre.com>
> >> [1] - https://lore.kernel.org/lkml/CAGETcx95kHrv8wA-O+-JtfH7H9biJEGJtijuPVN0V5dUKUAB3A@mail.gmail.com/#t
> >>
> >> Saravana Kannan (3):
> >>   net: mdio-mux: Delete unnecessary devm_kfree
> >>   net: mdio-mux: Don't ignore memory allocation errors
> >>   net: mdio-mux: Handle -EPROBE_DEFER correctly
> >>
> >>  drivers/net/mdio/mdio-mux.c | 37 ++++++++++++++++++++++++-------------
> >>  1 file changed, 24 insertions(+), 13 deletions(-)
> >
> > Thanks for this. I've just gave it a go on my test platform, and this
> > indeed addresses the issues I was seeing [1].
> >
> > Acked-by: Marc Zyngier <maz@kernel.org>
> > Tested-by: Marc Zyngier <maz@kernel.org>
>
> I wasn't seeing the same issues as Marc, but am heavily using everything
> as modules on a few platforms using this code, and I'm not seeing any
> regressions.
>
> Thanks Saravana for finding the root cause here.
>
> Acked-by: Kevin Hilman <khilman@baylibre.com>
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>

Oops, that should not be a SoB, but rather:

Tested-by: Kevin Hilman <khilman@baylibre.com>
