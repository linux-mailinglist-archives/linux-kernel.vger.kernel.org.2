Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9859432BCE6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Mar 2021 23:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447367AbhCCPCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Mar 2021 10:02:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1843070AbhCCKZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Mar 2021 05:25:13 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBCE4C08ECBA
        for <linux-kernel@vger.kernel.org>; Wed,  3 Mar 2021 02:03:08 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id a62so12237410vsa.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Mar 2021 02:03:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0P7a8icA4MGEc1ctz6tQzm2lAG+q8RttLehrVy6dqQk=;
        b=BfXVjjTnzAg6hl0OV+cHH7Zg0rG+EwIq2L8mFbj/pDSmy6tpBt8gAeob8lONaFwW3r
         fxAi37TFKZvjmHiLnOlggVFvOQVe3OV9iGWH8hLtyJnBNr1GUotGYD+jOVGuwXFmmHXL
         x8IxL1lcU/YQkEI50HXwjM6wkEyEdpviCrRP1vMvhiz+SSzR8MPmpoTVJ3CCrR3iuaTj
         la7tWiYDEGd5/8oiWBxOx51Zf8jXCKcMuj1ybGVnb9gkcv3OaV3eIylnV+eAV/6FVZuh
         Oa5IxE9EA6AHmUUqQBj+iiJSRGnIkCz3B2IlUJhEb9/DEBC7QM5LX/aLDDt2u0zYjUk5
         Xdqw==
X-Gm-Message-State: AOAM530zzhsiWp2JyUtHwQDaPLbVailg34UlWamwPQU+mAHZ29Ji+4J0
        zYF0hdCvrTxvo2SXN/cOhCN1zSbDKKVW28fm08k=
X-Google-Smtp-Source: ABdhPJyGxGH50NMFA1uCJ7/0BFG1/bHkNiJl9a/xic6JQ8JgjJ52DQf19Ycr3Bgm4Z9t2NJKd++39NFjQPyFiZGN42M=
X-Received: by 2002:a67:2245:: with SMTP id i66mr1349923vsi.18.1614765787001;
 Wed, 03 Mar 2021 02:03:07 -0800 (PST)
MIME-Version: 1.0
References: <20210302211133.2244281-1-saravanak@google.com>
 <CAMuHMdU4rJaMFUS8ukUgqYjTGY41Pa3iQQpKiK8qJA6YnDJDkw@mail.gmail.com> <CAGETcx8F+cC5wrSRb8qzLyHfxUNtyOoy6-m+YbxRgp09k9fp9Q@mail.gmail.com>
In-Reply-To: <CAGETcx8F+cC5wrSRb8qzLyHfxUNtyOoy6-m+YbxRgp09k9fp9Q@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 3 Mar 2021 11:02:55 +0100
Message-ID: <CAMuHMdUe07Zm833AZg1c0cQZ5ObEoGsNKzwb2eyGtW2Hn_aVnQ@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] driver core: Set fw_devlink=on take II
To:     Saravana Kannan <saravanak@google.com>
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

Hi Saravana,

On Wed, Mar 3, 2021 at 10:24 AM Saravana Kannan <saravanak@google.com> wrote:
> On Wed, Mar 3, 2021 at 1:22 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Tue, Mar 2, 2021 at 10:11 PM Saravana Kannan <saravanak@google.com> wrote:
> > > This series fixes the last few remaining issues reported when fw_devlink=on
> > > by default.
> >
> > [...]
> >
> > Thanks for your series!
> >
> > > Geert/Marek,
> > >
> > > As far as I know, there shouldn't have any more issues you reported that
> > > are still left unfixed after this series. Please correct me if I'm wrong or
> > > if you find new issues.
> >
> > While this fixes the core support, there may still be driver fixes left
> > that were not developed in time for the v5.12-rc1 merge window.
> > Personally, I'm aware of "soc: renesas: rmobile-sysc: Mark fwnode
> > when PM domain is added", which I have queued for v5.13[1].
> > There may be other fixes for other platforms.
>
> Right, I intended this series for 5.13. Is that what you are trying to say too?

OK, v5.13 is fine for me.
It wasn't clear to me if you intended (the last patch of) this series to
be merged for v5.12-rcX or v5.13.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
