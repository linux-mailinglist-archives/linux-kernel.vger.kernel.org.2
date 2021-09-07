Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F274402765
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 12:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245399AbhIGKxl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 06:53:41 -0400
Received: from mail-vs1-f49.google.com ([209.85.217.49]:45908 "EHLO
        mail-vs1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233669AbhIGKxk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 06:53:40 -0400
Received: by mail-vs1-f49.google.com with SMTP id a21so7869337vsp.12;
        Tue, 07 Sep 2021 03:52:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qCf3lFp7ZGPo81H5gKpqZfRLJ1Kl9E59yB1iRSg+398=;
        b=bH+J8+qsvxBOC7tU8boBHqEQDf6GW+GOiUsKyqs6mbquDv7ZOFQTW0vDrRywcMkL7y
         CsDfyPEpvvMSHibmZRSULQsqlwBnt+3Qqrs2dWMQM+8K4H3/ba6eycHrllB3GuhLONju
         lGPWT5PsL269r0bEd481aNytA+ZGX53MEtQrdhViAj3Vi74USzjusbE4lksJvRqi4bHS
         OMjuv06wedEap1M9pWHGuLsaht8aO8kCI9LMGO+lpn846e9PRBOJWn9Y/TWhRraUyQEP
         caJ1sSnf7Yn/NcPd0tq09wonblUK29dw44WESxBHjdazE7Z8eJhQknhiJn0DISFr7Rok
         /3iw==
X-Gm-Message-State: AOAM530l7Fu/u2kEKKMPruJOYDV8mU21srd6wiDyL35jj8vE88WVRqQ4
        yFd+5ZGxoFfYWZ4h6Owz8AICTm68QDjHqEKY8mI=
X-Google-Smtp-Source: ABdhPJwtlynwlS2RjnxuBuaVv2UUOMjVP3bB5VwN/mxwvip/epfm14g2QfISYnoL/c/9wy3QhvSCVhG2PAXLPRrC3l0=
X-Received: by 2002:a05:6102:2417:: with SMTP id j23mr8477213vsi.35.1631011952978;
 Tue, 07 Sep 2021 03:52:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210902230442.1515531-1-saravanak@google.com>
 <20210902230442.1515531-2-saravanak@google.com> <CAPDyKFpP6pSRSw8_OAW8+ZJNH+CwXtfWBNDcD182gQmzqW=O5g@mail.gmail.com>
 <CAMuHMdVgjxJwd=PbUSR+9mgxexr3O_O6j-3T24GzE08CqzDjjA@mail.gmail.com> <CAPDyKFrGyOWSxe=0DGWNQ75YQgXVa62WF8=pOHNCWUh5PLcdqQ@mail.gmail.com>
In-Reply-To: <CAPDyKFrGyOWSxe=0DGWNQ75YQgXVa62WF8=pOHNCWUh5PLcdqQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 7 Sep 2021 12:52:21 +0200
Message-ID: <CAMuHMdVawd1_twGnWE7GzbPKXeKr+gCCXfodiBdECLScHRTBag@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] of: platform: Make sure bus only devices get probed
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Saravana Kannan <saravanak@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Android Kernel Team <kernel-team@android.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

On Tue, Sep 7, 2021 at 12:36 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On Fri, 3 Sept 2021 at 16:29, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Fri, Sep 3, 2021 at 11:19 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > On Fri, 3 Sept 2021 at 01:04, Saravana Kannan <saravanak@google.com> wrote:
> > > > fw_devlink could end up creating device links for bus only devices.
> > > > However, bus only devices don't get probed and can block probe() or
> > > > sync_state() [1] call backs of other devices. To avoid this, set up
> > > > these devices to get probed by the simple-pm-bus.
> > > >
> > > > [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > Tested-by: Saravana Kannan <saravanak@google.com>
> > >
> > > Again, this looks like a nice solution to the problem.
> > >
> > > One question though. The Kconfig SIMPLE_PM_BUS, should probably be
> > > "default y" - or something along those lines to make sure fw_devlink
> > > works as expected.
> >
> > I would love for SIMPLE_PM_BUS to go away, and all of its functionality
> > to be usurped by the standard simple-bus handling.
> >
> > In the modern world, everything uses power management and Runtime
> > PM, and the distinction between "simple-bus" and "simple-pm-bus"
> > is purely artificial.
>
> I think it's not that easy, but maybe I am wrong.
>
> Today we have an opt-in way of supporting runtime PM (and power
> management). In most cases it's up to drivers or subsystem level code
> to decide if runtime PM should be enabled for the device.
>
> Would it really be okay to enable runtime PM for all of them?

You're talking about the software policy side.

From my PoV, the issue is that this decision is leaked into DT, through
the different compatible values ("simple-pm-bus" vs. "simple-bus").

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
