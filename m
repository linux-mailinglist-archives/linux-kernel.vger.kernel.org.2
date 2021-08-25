Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 460663F7425
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 13:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbhHYLLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 07:11:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240302AbhHYLLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 07:11:30 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4773AC061757;
        Wed, 25 Aug 2021 04:10:45 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id h1so10452784pjs.2;
        Wed, 25 Aug 2021 04:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xFOdY54x9tfLOrJtRDg5gjIYTWc+65nd7R3WkTlezj0=;
        b=B4bBmiBxo22NxX2ANJgtHy4UFOjAuQc6OnjiVL1myqZ6y+x76ZNoIU9fTmb9Vy3ZOL
         3XHMtKA5pEhd9m+0KjtTViPA2dtg9BJvaPBsV46uoOkMsrsyTEPKgerzG0Qxpv+8AvXf
         eh+o5yD9cHd7CN7GH/L/V49RjlXhf3b1RrNy8G6VcYzfq4oVK4f+FDI5t2XE5MMhb26b
         o9juwo1J0VA+AZp+KAqBaVl4BlOm0UgBt4YlXgw1aJC3ADluKZknH0UOrbz6/9EAariw
         EgaIaRmTWe6lu899d9/9L45jC+mx7T8bu55wNbJQGAD10s++MDJex7m4DcQDP5pgDaGC
         zlcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xFOdY54x9tfLOrJtRDg5gjIYTWc+65nd7R3WkTlezj0=;
        b=qZSDyyab7kykh6Vek8TZzg3hdo2LKMO+QHuZ+g0k5dYnSTBEONzUxIYyn3qRkRTaif
         YvR/yPjxhdO49bdu7EgBibJ5GcQJE5Mh5g5PaXuebvtFnZYJPESQfKgMPyq05E7P4gpR
         HKUxyHSSDNi9xXCDzZFTy/b4ryno0Sm5an01QfBbElW3eV0OoUxZ8squPT/WDfeElaV2
         HtfvujILOCMpNb0hqkAaTJhMCX5mOl6Uie0k1aJT93NmGPoZCkvW6+7oV8WwwsgJG7VR
         UJLJimkoeo3mnokqmcYeJyoqgtbKCsrLWBVZ+eQo86Yz/zFIBHgN6Y9plaiOckAoNrpl
         +rKw==
X-Gm-Message-State: AOAM530Y9UKkUjmp77rgLJPE/WZg21I7MtIDSk3z4Bz2og1DbAC/sD4s
        E6A+Vq2lADkNTiTQ+WbVJj81LoI5cLoWeNgdyr8=
X-Google-Smtp-Source: ABdhPJzD/6GI/xpfPndm8/qBnOFtNQbtysaJEiKOqJP2RlP583tz27xOO8AM/ZMbP/ejCGuyjO59crLQnccLjj22DFw=
X-Received: by 2002:a17:902:d709:b0:130:6b05:be3e with SMTP id
 w9-20020a170902d70900b001306b05be3emr25879872ply.21.1629889844760; Wed, 25
 Aug 2021 04:10:44 -0700 (PDT)
MIME-Version: 1.0
References: <20210824230620.1003828-1-djrscally@gmail.com> <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk>
In-Reply-To: <20210825103301.GC5186@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Aug 2021 14:10:05 +0300
Message-ID: <CAHp75VdHpjbjz4biTP11TKT6J+7WQi-a1Ru3VLuSxM5tSLCB3Q@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
To:     Mark Brown <broonie@kernel.org>
Cc:     Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 25, 2021 at 1:34 PM Mark Brown <broonie@kernel.org> wrote:
>
> On Wed, Aug 25, 2021 at 12:06:18AM +0100, Daniel Scally wrote:
> > In some situations regulator devices can be enumerated via either
> > devicetree or ACPI and bound to regulator drivers but without any
> > init data being provided in firmware. This leaves their consumers
> > unable to acquire them via regulator_get().
> >
> > To fix the issue, add the ability to register a lookup table to a
> > list within regulator core, which will allow board files to provide
> > init data via matching against the regulator name and device name in
> > the same fashion as the gpiod lookup table.
>
> This is the wrong level to do this I think, this is a generic problem
> that affects all kinds of platform data so if we're not going to scatter
> DMI quirks throughout the drivers like we currently do then we should
> have a way for boards to just store generic platform data for a device
> and then have that platform data joined up with the device later.  This
> could for example also be used by all the laptop audio subsystems which
> need DMI quirk tables in drivers for their components to figure out how
> they're wired up and avoids the need to go through subsystems adding new
> APIs.

What you are describing sounds similar to what we have, i.e. fwnode graph.
That's how v4l2 describes complex connections between devices in the
camera world.

But IIRC you don't like this idea to be present with regulators (as
per v1 of this series).

So, what do you propose then?


--
With Best Regards,
Andy Shevchenko
