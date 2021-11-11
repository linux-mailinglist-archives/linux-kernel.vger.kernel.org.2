Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902F944D616
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 12:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbhKKLxr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 06:53:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232778AbhKKLxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 06:53:44 -0500
Received: from mail-ua1-x92b.google.com (mail-ua1-x92b.google.com [IPv6:2607:f8b0:4864:20::92b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2E5C061767
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 03:50:55 -0800 (PST)
Received: by mail-ua1-x92b.google.com with SMTP id v3so11165867uam.10
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 03:50:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rsWZX79zxYaniJvm5v5ckZ5qJETbzJZYQnSDbyuzpRo=;
        b=L/dGrhUISgG27gmCRyaKGFNjWfUyJdqZps3CSjvE9j3ZMSkZgpmu9kuKVPKXweCDMV
         dL1hOdZor/e+luPdxB0ZS52O1FNPeJPJ5PG3XUt40a8ybMCzxsOY4JM/XmjSXu1YEhQg
         1wI8JRibUU7zJ91q22Ml7wtcZo8oJ7yaCKEEmxWzxwQfTHpxF6Est7BbBzVIGQR4Sq4E
         PYnJzB9CV4TVUgnuq7nxXAa1S5kNZj/vzVgsOIsX7jWsTPbeT2uWcUCBlp90n8jWhTK1
         yJWD9ZorMuKMGT5bY3/YbpxRQ/NFjJUll174kmLkvOMKVKbs9oq9NKkij4PGX8tTIwh+
         rb1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rsWZX79zxYaniJvm5v5ckZ5qJETbzJZYQnSDbyuzpRo=;
        b=owJxoA6RJfPaVIh6Cf7KJu0zcUdo6C1PYTXTWu2brmDtHJk6SNZuIVsyVk/2FDXDsw
         zhJ1Z+fyv3DTVZVWlXIYF85Yk3vxRLvVkAiOX/DkZnlA7miHD/ePZIZDgDI9wBHxSgJh
         9jLjSnCCUhk5txhJ7kC480BFiDhYf1KqMnF98bjD6dT4Jq2mWQBp5ggDg8jembt/MJ95
         AOzeZdvW4A60pTaSquiK0Z3hTSZO3yLN6tAX7bpXVLlLiRdrA+p1FWizQbC9QPvyVW4e
         O5njnpkprmlWhH/7jnAseJaGJzC+ngUrX6Koj2OoPUg2FRVCI4L7VpW6BzK0JITtAiiS
         JZ6g==
X-Gm-Message-State: AOAM5301hOB2ej0qxZHT4BY0KQuIfdzHn517ljaM21gAGT5GV+I0sUVr
        jY1imanH+FemRQ8ju+tATCtdT2qtLGucU574PIslyA==
X-Google-Smtp-Source: ABdhPJxorDTPpuaU4bo05ZshO90aOGQAXuhyUKKDiW7KPqWhaDmrc2uHSvawEQLIJp2ndV5e/QVEb0XM6qbLG+vhcoo=
X-Received: by 2002:a67:f805:: with SMTP id l5mr9893262vso.17.1636631455023;
 Thu, 11 Nov 2021 03:50:55 -0800 (PST)
MIME-Version: 1.0
References: <CAHifhD6K5hbpHS-X+2L=pfUe+7OpyTbB7uyh8WGbdaeBMwoYPg@mail.gmail.com>
 <CAHp75VfbYsyC=7Ncnex1f_jiwrZhExDF7iy4oSGZgS1cHmsN0Q@mail.gmail.com>
 <CAHifhD5V9vwJenRLcPRH5ZMeLa_JnjZKfdcFZw1CjceBtC6=Ew@mail.gmail.com>
 <CAHp75VeyQEaABFOnEUh2pdFx9ROJvRcud-BuEbKWmaEWpL9_Uw@mail.gmail.com>
 <CAHifhD7Qf7+dc7K-MjNguqmiCWUxOJZmQoCTRUZOR-RWMm_JPw@mail.gmail.com>
 <CAHp75Ve9BMNy3gP=-Dajm+Lgu+E4FCqc4phLgV1_cr2qUnTX_w@mail.gmail.com>
 <CAHifhD4n7O5eWFPOjRAmHYL52tW0K=uXXzVj7L5+enTFwFXW2A@mail.gmail.com>
 <CAArk9MP5cKJ+VhAZUseW4LnQNRvux=MZe2eSy3rQkbHKnUsGig@mail.gmail.com>
 <CAHp75VdRwvU5WjFP5E4gg8U+_e34A0Lwze+nz_wVHoB49jLeLg@mail.gmail.com>
 <CAArk9MNGSxR+92n-D2pe_+r+Z0Q9FoTMPqk11sAKA=4Vckj0HQ@mail.gmail.com> <YYy7QZGKeEEfI1mH@lahna>
In-Reply-To: <YYy7QZGKeEEfI1mH@lahna>
From:   Mauro Lima <mauro.lima@eclypsium.com>
Date:   Thu, 11 Nov 2021 08:50:43 -0300
Message-ID: <CAArk9MOyuX1zq5V3N_6gVOxdrqhsNTR1KF2FzSNUxk8fA5UPjQ@mail.gmail.com>
Subject: Re: [PATCH] firmware: export x86_64 platform flash bios region via sysfs
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Hans-Gert Dahmen <hans-gert.dahmen@immu.ne>,
        Greg KH <gregkh@linuxfoundation.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Philipp Deppenwiese <philipp.deppenwiese@immu.ne>,
        Richard Hughes <hughsient@gmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mika

On Thu, Nov 11, 2021 at 3:42 AM Mika Westerberg
<mika.westerberg@linux.intel.com> wrote:
>
> Hi,
>
> On Wed, Nov 10, 2021 at 02:37:56PM -0300, Mauro Lima wrote:
> > > Try again to collaborate with Intel SPI driver author(s) /
> > > maintainer(s) by sending the proposal that may work.
> >
> > The proposal I sent makes the driver work only with read ops, but that
> > was not the issue with this driver. The issue was something related to
> > a status register and this was fixed. So if there is no issue with
> > write/erase ops, the bug was fixed and there is no intention to remove
> > the tag. What kind of proposal are we talking about?
>
> I think we discussed this previously already but in any case, instead of
> removing the tag from the "main" driver, we can make certain "safe"
> parts of the driver available without that tag. That would allow you to
> read the things the controller exposes and allow distros safely include
> the driver too. By "safe" parts, I mean the information available
> through the SPI flash controller without actually sending commands to
> the flash chip. I think this is the information everybody (on this
> thread at least) is interested in. Unless I'm mistaken - I did not check
> the original patch. If that's not enough we can possibly expand it to
> cover the controllers that only use hardware sequencer since they
> operate on a certain limited set of ops that should not break anything
> accidentally.

We discussed this previously indeed, and you are right that we are
interested in the spi configuration, but we are also interested in
reading the bios. For that we needed to use the driver, if that
expansion you are talking about, gives me the possibility to use the
driver for reading the flash and having this functionality without any
dangerous tag, it would be awesome.
