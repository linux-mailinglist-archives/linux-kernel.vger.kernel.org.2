Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8CD83EC4D1
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Aug 2021 21:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232617AbhHNTuc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Aug 2021 15:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbhHNTu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Aug 2021 15:50:26 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E37AC061764;
        Sat, 14 Aug 2021 12:49:57 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id a8so20345499pjk.4;
        Sat, 14 Aug 2021 12:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=H55D/hatpxv6wsHj/kV2cIDtO8yZ68G4AWzJyEwImqI=;
        b=vIwpytlXpOqYADP4f+RqCmpmRzgGJtLie3NhxzperJCgH6Bfh17xTDj5mG+xpvs5pX
         XWm11d2R0Y90jxAUO5Nno0ZRT7qtG+AOOVF8JuJZsxjhfDZXppx6W8i7NGbno0v1IMap
         l83zpPjqZxW/QU6mHx51RLXsRlOymfAwvdSPuxKNi13fjMaN/Yqs1QCxanl7cDT5gqTe
         Hu/AKa3wygl1xDlt2gu6dPgxSgaeCyN1EXLuxw3x9t2Gq33JcX7VD5qqDGrOIxr+VAg1
         LiK+RiTto13a6cY7IgG5AKR9OqI3Hu8RykdFvvt7x44FGVvyIj4iWUk8+pnxvPTVPu4n
         wkig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=H55D/hatpxv6wsHj/kV2cIDtO8yZ68G4AWzJyEwImqI=;
        b=Mdw514ryYDXlJ5UwK5796QU+kx0ZN7l0DLjO7y3VSw6WorRFewaH5WE4/lpT4zKGz5
         dwuO/akXUllKDFmBdeByVQ52bNQkE3t646itRdnykMySXC+nSCvBZV1W/8m86JGxVWOQ
         S5WKCO19rn2pfhcYPGz7FHkVcsYGrP3PV5PsTq7pY83+2DJTUJBBI722JUMeyc2lyLyZ
         8PMWCWkhbF54sMGeRf4X+pKwuBw7W+Ju/0RT71CF1PhN+ocluA6sffMlr6u0PBuQdnUX
         l8/HWVvl8d7oCCjroYECiO/WMnvqkXnS/gt2+K0RH1c43xeuhNLV7grNzjNa7GEeFtTY
         JpfQ==
X-Gm-Message-State: AOAM531uvRgUiK3M39vBL1t9eQ9kL4dik7qBy/+FSGQzDZtjU1pUpPZJ
        dvWCB/c4uAOhGDk+4+wf3zE5ppnZWlvtv4H2lrlH/G1y0Ctgxw==
X-Google-Smtp-Source: ABdhPJz5JIrjdib84kyhpEN0ITHSybOUFi+IHRxmLBBQjG6+xQJOflN3m3h/gdDrt5UWfd9mZW5qZScjG2stKZqP2eo=
X-Received: by 2002:a17:90a:cf18:: with SMTP id h24mr8693629pju.228.1628970597029;
 Sat, 14 Aug 2021 12:49:57 -0700 (PDT)
MIME-Version: 1.0
References: <20210814043103.2535842-1-luke@ljones.dev> <20210814043103.2535842-2-luke@ljones.dev>
 <CAHp75VcCzjb7TKZ84iVjJr27+nCcA10n38nwCAGATucfAAMkKA@mail.gmail.com> <UCVTXQ.8ME64G0S1BQ8@ljones.dev>
In-Reply-To: <UCVTXQ.8ME64G0S1BQ8@ljones.dev>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 14 Aug 2021 22:49:21 +0300
Message-ID: <CAHp75VdS5v_wGEs5vWcyc1Y2NZ7pXbamSHn7MgWj6ie8ahnoBQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] asus-wmi: Add support for platform_profile
To:     Luke Jones <luke@ljones.dev>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Bastien Nocera <hadess@hadess.net>,
        Platform Driver <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 14, 2021 at 2:46 PM Luke Jones <luke@ljones.dev> wrote:
> On Sat, Aug 14 2021 at 12:40:39 +0300, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Aug 14, 2021 at 7:33 AM Luke D. Jones <luke@ljones.dev> wrote:

...

> >>  +               pr_info("Using throttle_thermal_policy for
> >> platform_profile support\n");
> >
> > Why pr_*()?
>
> That seemed to be the convention? I see there is also dev_info(), so
> I've switched to that as it seems more appropriate.

The rule of thumb is if you have the device the message belongs to,
use dev_*(), if it's really stuff before we know anything about
devices, use pr_*(). In some cases if you have ACPI handle, you may
use acpi_handle_*().

-- 
With Best Regards,
Andy Shevchenko
