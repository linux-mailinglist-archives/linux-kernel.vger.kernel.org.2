Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C4E632BFA3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 01:00:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1579952AbhCCSct (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 13:32:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbhCCQ4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 11:56:44 -0500
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B26C06175F
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 08:56:03 -0800 (PST)
Received: by mail-yb1-xb2c.google.com with SMTP id f4so25243213ybk.11
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 08:56:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f6hRodqlypzDTU/FWJHNKjGc5kzBJYYfZMRX7NCfZYA=;
        b=sc2roBejCsQFy/zRpBsVsbEXdtW3DO19gqmh5SAViA8lzGIBsjeuWEb6BCySU8ebe1
         qDXv/LNcRV7M3Q1scLuF3/9ERDQwFq7ImefjqEXefjHvE63NSrPcRyXfVV/yEcAHvCzQ
         NKJ0lMRkCeO6ChsGXhRTi097PZggGZV2Msq22+o04VkqALwMg8QedbLP3gKlTCV1sAS/
         NurdjO7HiOQz2BenmzysRTsOsIyzF74XSV4o6SLMD+t7AnH2acG1wo6VkpMtswO/Cuaa
         xBRuyKl1Vdm/hlCVsqyvsvQrU38xdCGhgR6TkR/s1orAt7KJT1WE9a/lOuD0oPZWQGDC
         KCEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f6hRodqlypzDTU/FWJHNKjGc5kzBJYYfZMRX7NCfZYA=;
        b=a9BbptuSX+S248Dce7JakIHvTklGxPzx4fFmmLfqc0WMJI823fyvKtNEx4G+YrV6O2
         WgdDSwagPHP2D5lWrqaMUT1XcbgEumzix/GY3G0bKLyAxdg/e1xj4eofyiw6hIwAayHV
         sAo5F/+YjoF7BcgJqF0A4vBnApnaLjTPELTzTQX0TRzY5xksnS33WL17dXUliqBMQtf3
         IwsB1FQMCQEndAior4WhhHPzyCBI9Qbt85Vovhx+aiQYPMtbguqjBuUpT+9LQSVWvBvc
         sgoypw7dGQJ+6Q+u7CvCtFq866vHwKqxxXLKfg1c8OaV2RFsSsWvtZOtHYWY+d8H5d6a
         AoDA==
X-Gm-Message-State: AOAM530aQMKqrI3HoOysL5Nn2r4sxIfTK74O6hPVnuAkncgIUGB7u5yg
        Nr4+dugpKlWQfuWxaur87klrS/4JxngOLhhn6coocQ==
X-Google-Smtp-Source: ABdhPJw6Fus9Eo62yqZ+8MzV7BUptx8VxonkRYuEC1/62eweE46H34CO16ZeHa4s88JqcLE269cZ2W93PBx4Rj3clOY=
X-Received: by 2002:a25:c283:: with SMTP id s125mr268374ybf.310.1614790562309;
 Wed, 03 Mar 2021 08:56:02 -0800 (PST)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
 <CAMuHMdU4rJaMFUS8ukUgqYjTGY41Pa3iQQpKiK8qJA6YnDJDkw@mail.gmail.com>
 <CAGETcx8F+cC5wrSRb8qzLyHfxUNtyOoy6-m+YbxRgp09k9fp9Q@mail.gmail.com> <CAMuHMdUe07Zm833AZg1c0cQZ5ObEoGsNKzwb2eyGtW2Hn_aVnQ@mail.gmail.com>
In-Reply-To: <CAMuHMdUe07Zm833AZg1c0cQZ5ObEoGsNKzwb2eyGtW2Hn_aVnQ@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 3 Mar 2021 08:55:26 -0800
Message-ID: <CAGETcx-srp_e2o+9jtFMZRKn5H_w3WwQbedzVoj-S1DKSTr1HA@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] driver core: Set fw_devlink=on take II
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Jon Hunter <jonathanh@nvidia.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 3, 2021 at 2:03 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Saravana,
>
> On Wed, Mar 3, 2021 at 10:24 AM Saravana Kannan <saravanak@google.com> wrote:
> > On Wed, Mar 3, 2021 at 1:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Tue, Mar 2, 2021 at 10:11 PM Saravana Kannan <saravanak@google.com> wrote:
> > > > This series fixes the last few remaining issues reported when fw_devlink=on
> > > > by default.
> > >
> > > [...]
> > >
> > > Thanks for your series!
> > >
> > > > Geert/Marek,
> > > >
> > > > As far as I know, there shouldn't have any more issues you reported that
> > > > are still left unfixed after this series. Please correct me if I'm wrong or
> > > > if you find new issues.
> > >
> > > While this fixes the core support, there may still be driver fixes left
> > > that were not developed in time for the v5.12-rc1 merge window.
> > > Personally, I'm aware of "soc: renesas: rmobile-sysc: Mark fwnode
> > > when PM domain is added", which I have queued for v5.13[1].
> > > There may be other fixes for other platforms.
> >
> > Right, I intended this series for 5.13. Is that what you are trying to say too?
>
> OK, v5.13 is fine for me.
> It wasn't clear to me if you intended (the last patch of) this series to
> be merged for v5.12-rcX or v5.13.

The entire series is meant for 5.13.

I don't want to land the Patch 1/3 in 5.12 in case it causes some
regression. And 2/3 isn't urgent.

-Saravana

>
> Gr{oetje,eeting}s,
>
>                         Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
