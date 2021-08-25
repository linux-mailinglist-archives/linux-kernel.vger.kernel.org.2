Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B413F750D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Aug 2021 14:27:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240372AbhHYM2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Aug 2021 08:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238179AbhHYM2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Aug 2021 08:28:02 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C42C061757;
        Wed, 25 Aug 2021 05:27:17 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id mw10-20020a17090b4d0a00b0017b59213831so4087328pjb.0;
        Wed, 25 Aug 2021 05:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iNKX6kte1iNRhPEzpqLRtyhooTzsRJn7cqOtbK5zh1o=;
        b=RrHIJG9yv2DEEvyh5gfGeLkFD8bxdojR0zv4glu2F3MiBzpcIyPeeO1G5FLpHQCAod
         V0ELxjK+cQmjNz4oVzR1NUIjdWle+fR9z8z9vcJZbqbcQyaRB35vrpT3AJtqzbqbajOg
         UDXq/8OkUn9UD2Fbt7VRwdbXQJFDg083KQEOUvHJzAkjEoaiES7drHAzd/wh53SqK/0g
         9iJoDqukGQCOr3Bxx+4w3QatwzBqIT0jboklH0s/q76nTpxB66T58C/v/T4dLjB4ifmM
         gpY+0dJNgWKIZuw2syQ1GmLq/vo7LnhX2aAc36M9prHFYbjMsh4Q0xpqc5ZxjcyW43JI
         KQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iNKX6kte1iNRhPEzpqLRtyhooTzsRJn7cqOtbK5zh1o=;
        b=Mkb41DoiFFl5uKjAt+4N2Qdzc7yWSnv7iI1NxNIiRVmx8MLuhEykN7B8MfrtcZjY+5
         NC+H3QZ4gkQUGGnM1TXs5dGHc8Np3AEt7ICRpj9pw72CGwuKqmsF1KVFWGJ45HJqRunD
         bntoIr5u9tevtNQAX2azZABL2JMP8xaC9+z1TfQT6bXap76H3yylsfWZMGysVQz5GG/K
         A2gy49csWaC9LUdbif9s7SAQv/7kZMMrL31QKi6JXJHkwaVsqMfAz4qwqm+Q6p4E+VMs
         cDCn5/VH4K4AejLyxjoTL64gyecA9c/6M2Vhp6kdY01H9LNmy90gAi9W4I1bXfm9iDiy
         tlZg==
X-Gm-Message-State: AOAM531Q47+v0EvvGtmOp//I1VeI52eHjC8iC8ojkqGAqh+SAIEkj57W
        K4Y52d5Gbfp+zf7N4a0CKJ1KRXBP2Y43A8o0RR0=
X-Google-Smtp-Source: ABdhPJy+++7Qxj9HojT3j1mXVW91uKkfhtM0CxpsjyZwE6itRoElj7WqxGhQimB+XgdGNp1KvcGUJ1H3b2fk0E8Z5X4=
X-Received: by 2002:a17:902:ced0:b029:12d:4ce1:ce3a with SMTP id
 d16-20020a170902ced0b029012d4ce1ce3amr37854408plg.0.1629894436695; Wed, 25
 Aug 2021 05:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <20210824230620.1003828-1-djrscally@gmail.com> <20210824230620.1003828-2-djrscally@gmail.com>
 <20210825103301.GC5186@sirena.org.uk> <CAHp75VdHpjbjz4biTP11TKT6J+7WQi-a1Ru3VLuSxM5tSLCB3Q@mail.gmail.com>
 <20210825113013.GD5186@sirena.org.uk>
In-Reply-To: <20210825113013.GD5186@sirena.org.uk>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 25 Aug 2021 15:26:37 +0300
Message-ID: <CAHp75VfKJgux8k_mPauYB3MHcEOcnnzhSpoUDi4mVFDgtmNXeg@mail.gmail.com>
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

On Wed, Aug 25, 2021 at 2:30 PM Mark Brown <broonie@kernel.org> wrote:
> On Wed, Aug 25, 2021 at 02:10:05PM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 25, 2021 at 1:34 PM Mark Brown <broonie@kernel.org> wrote:
>
> > > DMI quirks throughout the drivers like we currently do then we should
> > > have a way for boards to just store generic platform data for a device
> > > and then have that platform data joined up with the device later.  This
>
> > What you are describing sounds similar to what we have, i.e. fwnode graph.
> > That's how v4l2 describes complex connections between devices in the
> > camera world.
>
> > But IIRC you don't like this idea to be present with regulators (as
> > per v1 of this series).
>
> No, what was proposed for regulator was to duplicate all the the DT
> binding code in the regulator framework so it parses fwnodes then have
> an API for encoding fwnodes from C data structures at runtime.  The bit
> where the data gets joined up with the devices isn't the problem, it's
> the duplication and fragility introduced by encoding everything into
> an intermediate representation that has no purpose and passing that
> around which is the problem.

The whole exercise with swnode is to minimize the driver intrusion and
evolving a unified way for (some) of the device properties. V4L2 won't
like what you are suggesting exactly because they don't like the idea
of spreading the board code over the drivers. In some cases it might
even be not so straightforward and easy.

Laurent, do I understand correctly the v4l2 expectations?

> > So, what do you propose then?
>
> I propose what I suggested above, providing a way to attach platform
> data to firmware provided devices.  Don't bother with an intermediate
> encoding, just use platform data.  Or just put quirks in the drivers
> like all the other systems using ACPI for platforms where it's not a
> good fit.

-- 
With Best Regards,
Andy Shevchenko
