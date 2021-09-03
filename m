Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36EF94003EC
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Sep 2021 19:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350244AbhICRKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Sep 2021 13:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350232AbhICRKl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Sep 2021 13:10:41 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2101C061760
        for <linux-kernel@vger.kernel.org>; Fri,  3 Sep 2021 10:09:41 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id c206so11242366ybb.12
        for <linux-kernel@vger.kernel.org>; Fri, 03 Sep 2021 10:09:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HaDVUCfDbUysF1N7KhfteSFXd3S1ciSndfL6zXNrW9s=;
        b=WIeC25UguFm445Yh65nz7RAmj09BG6SDqBlPdnwz/RQjRBEwX24gqVsQVr08TDpbfm
         NtSF2hCL7rJMYGF6oE7ghB9CEW53EGM+ITRILSCeZautrvg3vPiox2/iQE+ZKHIrQ26N
         W9/iz6u4V8pbk+6LcvUgb76JcUABc0Gmo43fpPx+IGWdKwkUrjA9AXD2aFef04PVl0F6
         Wr4PM+4qoZ/u65a1QwY0yO3q1EBdm3elwjYEbQxsERBxoHJHaQ9QVUGshyr6VzV/PNrl
         h7TViiUu9cxdAD9lzN9m76U42skGhY8172AVo+DM4AOWXgwJfBimW+acolwxM/IOYOlB
         3t5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HaDVUCfDbUysF1N7KhfteSFXd3S1ciSndfL6zXNrW9s=;
        b=VjRJD+5cBSrwrIEuBkU4qYX7GEpS16fhfbVGvR3O21uW23MxU+IZuo4kP7WOQEYJ4e
         vyYQjxyOtnKkIAE73F/DhE+8Co6EDVlLQuf1WjABsTUPUyah5+/8zHFPTMhd6hHjujzF
         k/RvR8rQHn6/ysFadJd0jyPY05XJ3DOFFXgFbqQf/R3o0GkZgSFuPO3sa0SNVFUS6E8U
         befZIyzRHU56nFXAS4O5LWpGIGhDjpHRRaTdZ7y0HJ53+OeM4G6wGNVeBGQRIgGStqkg
         3Z4Xxs/B/1C3t17seP7dy/7nzXCbt+gxkE+UEkfJ8pYo7AinjLr4O+sZaiHZlWdP3EnF
         bolg==
X-Gm-Message-State: AOAM530NkCpIfeq3nQMANgWAo6Bs6AhpX4PYJ7xJekVi+P+56eKX5zah
        FOvWRaVqIRvrXlTSNck4wCBjV61wcgI2YZUTn4Np1ari4+AqQg==
X-Google-Smtp-Source: ABdhPJyJcXLghVfBEHfzy+3NU5FgOHAasQItJxw3SoimpnzwIgR0i+b8wcsczwTcwKrAd8L5fbzlKH8xAOJDzQTcU2o=
X-Received: by 2002:a25:e0d4:: with SMTP id x203mr55309ybg.391.1630688980893;
 Fri, 03 Sep 2021 10:09:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210902230442.1515531-1-saravanak@google.com>
 <20210902230442.1515531-2-saravanak@google.com> <CAPDyKFpP6pSRSw8_OAW8+ZJNH+CwXtfWBNDcD182gQmzqW=O5g@mail.gmail.com>
 <CAMuHMdVgjxJwd=PbUSR+9mgxexr3O_O6j-3T24GzE08CqzDjjA@mail.gmail.com>
In-Reply-To: <CAMuHMdVgjxJwd=PbUSR+9mgxexr3O_O6j-3T24GzE08CqzDjjA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 3 Sep 2021 10:09:05 -0700
Message-ID: <CAGETcx9W6FYCD62+QytwK5FThpz0EyKn0G6Ay2B5jKgiqkZT1g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] of: platform: Make sure bus only devices get probed
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 3, 2021 at 7:29 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Fri, Sep 3, 2021 at 11:19 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Fri, 3 Sept 2021 at 01:04, Saravana Kannan <saravanak@google.com> wrote:
> > > fw_devlink could end up creating device links for bus only devices.
> > > However, bus only devices don't get probed and can block probe() or
> > > sync_state() [1] call backs of other devices. To avoid this, set up
> > > these devices to get probed by the simple-pm-bus.
> > >
> > > [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > Tested-by: Saravana Kannan <saravanak@google.com>
> >
> > Again, this looks like a nice solution to the problem.
> >
> > One question though. The Kconfig SIMPLE_PM_BUS, should probably be
> > "default y" - or something along those lines to make sure fw_devlink
> > works as expected.
>
> I would love for SIMPLE_PM_BUS to go away, and all of its functionality
> to be usurped by the standard simple-bus handling.

What if SIMPLE_PM_BUS *is* the standard simple-bus handling?
Insert "I'm the captain now" meme.

I think SIMPLE_PM_BUS config should just go away and we should compile
the driver in if CONFIG_OF is selected.

-Saravana
