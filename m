Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9123A3F7775
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 16:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241748AbhHYOep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 10:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232168AbhHYOeo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 10:34:44 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82D16C061757;
        Wed, 25 Aug 2021 07:33:58 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id k24so23259287pgh.8;
        Wed, 25 Aug 2021 07:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=22jc+wSks6PLenKFmDrlQ6cu71CyMHkjgy+o3kEUzU8=;
        b=L0E5CsDRLc6H/bBSvVpDX+NpZUr8xCVqvvX2SIVW3jo3Si1JI6iEofV7mZivutCd8R
         Rl6kTba3hnUtOdIpypw34MqsHZ39L0qmSRTB8yVpvyPHnof4nTQIOLEPCAy7/gXW9qzA
         1BOsT9M6JcIptCgO30Rm/cFhLpjM8kZvwRfgeA0S1qmmcTCxwj2T1JTtYhxReXQUwND9
         AgWG1KnJrUcZ6FNHVtMxwfO4/QdZ16vN75XdrVS5wuqE6tisqjuPHBFIRk8F4v71poAw
         S5bwPsQGyAbd6T46i1SntcPxIMe71ELfIT1g2mcQYhZmYVQcEH3l7k/yaTQQwhic7qCV
         qxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=22jc+wSks6PLenKFmDrlQ6cu71CyMHkjgy+o3kEUzU8=;
        b=WmwsjXDGCBAslBoSaSFxHUO7OlNVrs2iwqSglh4yH7rvbbxe2R4KBXAJTQWXrvGBcc
         iPXWdK/8I00jgDX8OvT6PwEvgHtsBgwxacad6TMGRdrnmDFLh+Lnen+2HU0PtUg36HBa
         8dsKO14ZjosUThsUCnfRRWXc+Nump34UhW1OIvIXwMG9+/QODJlMk6VZDt7mG/m0nYzx
         /tK6R14MlnT2h6ZasyHG67nGjEWLnC2G1mQH8z9Wv9UFE0h6Vk9+85V5+yZwmP1tkmwh
         7SyLEly0gtXWsfUeiJxTcEoXk0+VN/aBwn2Na7ByaP+LoV1wN8I7L/BRc78DCwJIU+7k
         +tjw==
X-Gm-Message-State: AOAM532KAffOEiWpUtAE91BuPMqPC/EY47MprdsCrHS8fChaZ78N3JIT
        5ZCYhdczP68Mw4EPbC2Mm9+yFukXi2+shorb2hheeDlx1O2k2A==
X-Google-Smtp-Source: ABdhPJzWcJoYXvLPMopEBS+DU/6RzhxfRlvO5UahfCAPEuFI+5QDamnzK1kxV+0SknGO85Iz1FB5/O2BvRyvf2Ec9do=
X-Received: by 2002:a62:6384:0:b0:3eb:13e7:18c with SMTP id
 x126-20020a626384000000b003eb13e7018cmr22244023pfb.73.1629902037903; Wed, 25
 Aug 2021 07:33:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210824230620.1003828-1-djrscally@gmail.com> <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk> <CAHp75VdHpjbjz4biTP11TKT6J+7WQi-a1Ru3VLuSxM5tSLCB3Q@mail.gmail.com>
 <20210825113013.GD5186@sirena.org.uk> <CAHp75VfKJgux8k_mPauYB3MHcEOcnnzhSpoUDi4mVFDgtmNXeg@mail.gmail.com>
 <20210825131139.GG5186@sirena.org.uk> <YSZMxxJ76vF316Pi@pendragon.ideasonboard.com>
 <YSZNvSvE2TyGrP7E@pendragon.ideasonboard.com>
In-Reply-To: <YSZNvSvE2TyGrP7E@pendragon.ideasonboard.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Aug 2021 17:33:18 +0300
Message-ID: <CAHp75VcMSayhxTe4TECO0_yKR4DEDw1AjNJ=excNZMhic+egfg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 1/3] regulator: core: Add regulator_lookup_list
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        "Krogerus, Heikki" <heikki.krogerus@linux.intel.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Daniel Scally <djrscally@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Sakari Ailus <sakari.ailus@iki.fi>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: Heikki

On Wed, Aug 25, 2021 at 5:03 PM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Wed, Aug 25, 2021 at 04:59:36PM +0300, Laurent Pinchart wrote:
> > On Wed, Aug 25, 2021 at 02:11:39PM +0100, Mark Brown wrote:
> > > On Wed, Aug 25, 2021 at 03:26:37PM +0300, Andy Shevchenko wrote:
> > > > On Wed, Aug 25, 2021 at 2:30 PM Mark Brown <broonie@kernel.org> wrote:
> > >
> > > > > No, what was proposed for regulator was to duplicate all the the DT
> > > > > binding code in the regulator framework so it parses fwnodes then have
> > > > > an API for encoding fwnodes from C data structures at runtime.  The bit
> > > > > where the data gets joined up with the devices isn't the problem, it's
> > > > > the duplication and fragility introduced by encoding everything into
> > > > > an intermediate representation that has no purpose and passing that
> > > > > around which is the problem.
> > >
> > > > The whole exercise with swnode is to minimize the driver intrusion and
> > > > evolving a unified way for (some) of the device properties. V4L2 won't
> > >
> > > The practical implementation for regulators was to duplicate a
> > > substantial amount of code in the core in order to give us a less type
> > > safe and more indirect way of passing data from onen C file in the
> > > kernel to another.  This proposal is a lot better in that it uses the
> > > existing init_data and avoids the huge amounts of duplication, it's just
> > > not clear from the changelog why it's doing this in a regulator specific
> > > manner.
> > >
> > > *Please* stop trying to force swnodes in everywhere, take on board the
> > > feedback about why the swnode implementation is completely inappropriate
> > > for regulators.  I don't understand why you continue to push this so
> > > hard.  swnodes and fwnodes are a solution to a specific problem, they're
> > > not the answer to every problem out there and having to rehash this
> > > continually is getting in the way of actually discussing practical
> > > workarounds for these poorly implemented ACPI platforms.
> > >
> > > > like what you are suggesting exactly because they don't like the idea
> > > > of spreading the board code over the drivers. In some cases it might
> > > > even be not so straightforward and easy.
> > >
> > > > Laurent, do I understand correctly the v4l2 expectations?
> > >
> > > There will be some cases where swnodes make sense, for example where the
> > > data is going to be read through the fwnode API since the binding is
> > > firmware neutral which I think is the v4l case.  On the other hand
> > > having a direct C representation is a very common way of implementing
> > > DMI quirk tables, and we have things like the regulator API where
> > > there's off the shelf platform data support and we actively don't want
> > > to support fwnode.
> >
> > From a camera sensor point of view, we want to avoid code duplication.
> > Having to look for regulators using OF lookups *and* platform data in
> > every single sensor driver is not a good solution. This means that, from
> > a camera sensor driver point of view, we want to call regulator_get()
> > (or the devm_ version) with a name, without caring about who establishes
> > the mapping and how the lookup is performed. I don't care much
> > personally if this would be implemented through swnode or a different
> > mechanism, as long as the implementation can be centralized.

Heikki and I discussed another (possible) approach, He submitted at
some point a series [1] that adds PM domain to software nodes. In such
case the software node callbacks can handle regulator, clocks, etc
which are needed to have it work (of course in case of optional
resources, for mandatory ones we have to provide them anyway).

[1]: https://lore.kernel.org/linux-acpi/20201029105941.63410-1-heikki.krogerus@linux.intel.com/

-- 
With Best Regards,
Andy Shevchenko
