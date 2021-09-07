Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9B6402786
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Sep 2021 13:03:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343718AbhIGLEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Sep 2021 07:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343679AbhIGLED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Sep 2021 07:04:03 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2541C061575
        for <linux-kernel@vger.kernel.org>; Tue,  7 Sep 2021 04:02:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id k13so18761523lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Sep 2021 04:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=t+vH18ohIOKYTcoNO1Jt0h1AH7LB+uCBHd7oEI3ZxPY=;
        b=mBVf/t85Z2ldsDYn3aICb/edQEOvV3V+et+X1QEax4Wabn76+qSCwzOFPJudvgQs+A
         GI7YwZ0MHs8r+vw0E2TFNO5fkHFmXUyU/qTiVqQuP8yql4gQ3mhPpmXB9CX9S5sAoqTp
         NMdGvVnTG0YyRGoS8YJEL/0yAcFQtay31A9O9MVhjwXBYpFYbBW3H6n3c8pGwnNOvoql
         6kgDwwfl/joyCvU31/NfzeflEedx1j4t2aY8Zo9fH9mqUaokkTc+7EN1hge6C24Ep+Kb
         ZOOyIgqLbNAkfG7ax1IPs//RvVZ32hcZziC7rtpQ41Dkm7gQpwdPzgr488pjHYUUPBYT
         MxQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=t+vH18ohIOKYTcoNO1Jt0h1AH7LB+uCBHd7oEI3ZxPY=;
        b=DdPQg4xmk8Ue3+ANdiQnDJWhE6HqyRiCFlmn4vW84ljpD4AvaUjUxnvkOkbYKOXU3b
         UnzgrsCYzDJQ2vhlZWNy+wAg6uwdizV0alw514qr+Nxpgoyu8KSjLGiEEPDrc3aC+Zwe
         ljCdOSYdU56zIxAcHic4N4ALscQtjf713s/QtiHwfBpi8vnLkqmDECNs0QP30UBwR4HN
         QpxaDZzbdIMcKP3mJ1KdR+EhQVHy75O971xakUJypfMDI2b3CI25bcITAaJzgmo+L/EZ
         X/gJ+wolF+zCk9vgKX3xuh3XXvhBtoK2T79gsz5zkH50iJRmdxyOq127bplrvoCvFgfU
         oIuw==
X-Gm-Message-State: AOAM532pf8mmRgub02y//z6lBVTVAFenKBjqGmXAnaJR9wSc1P0yHDOq
        ZFdzlAJJ56IKfoMXs2//ySpf/zL99GXqQhAy3ayObw==
X-Google-Smtp-Source: ABdhPJyJmyq6W+Z+ldm536U+O4DTjXnMBCM1G1ZjrZTdB/meaqumEON7g0DFOi8eaLHpa8yfBnWNSx8wXd9sUrTnBY8=
X-Received: by 2002:a05:6512:3ca5:: with SMTP id h37mr12608166lfv.254.1631012571855;
 Tue, 07 Sep 2021 04:02:51 -0700 (PDT)
MIME-Version: 1.0
References: <20210902230442.1515531-1-saravanak@google.com>
 <20210902230442.1515531-2-saravanak@google.com> <CAPDyKFpP6pSRSw8_OAW8+ZJNH+CwXtfWBNDcD182gQmzqW=O5g@mail.gmail.com>
 <CAMuHMdVgjxJwd=PbUSR+9mgxexr3O_O6j-3T24GzE08CqzDjjA@mail.gmail.com>
 <CAPDyKFrGyOWSxe=0DGWNQ75YQgXVa62WF8=pOHNCWUh5PLcdqQ@mail.gmail.com> <CAMuHMdVawd1_twGnWE7GzbPKXeKr+gCCXfodiBdECLScHRTBag@mail.gmail.com>
In-Reply-To: <CAMuHMdVawd1_twGnWE7GzbPKXeKr+gCCXfodiBdECLScHRTBag@mail.gmail.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 7 Sep 2021 13:02:15 +0200
Message-ID: <CAPDyKFoz2Q=cxrK7fEWVEWUJX1P8Ezknj-juCW+GuZvg=mpA-w@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] of: platform: Make sure bus only devices get probed
To:     Geert Uytterhoeven <geert@linux-m68k.org>
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

On Tue, 7 Sept 2021 at 12:52, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Ulf,
>
> On Tue, Sep 7, 2021 at 12:36 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > On Fri, 3 Sept 2021 at 16:29, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > On Fri, Sep 3, 2021 at 11:19 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > On Fri, 3 Sept 2021 at 01:04, Saravana Kannan <saravanak@google.com> wrote:
> > > > > fw_devlink could end up creating device links for bus only devices.
> > > > > However, bus only devices don't get probed and can block probe() or
> > > > > sync_state() [1] call backs of other devices. To avoid this, set up
> > > > > these devices to get probed by the simple-pm-bus.
> > > > >
> > > > > [1] - https://lore.kernel.org/lkml/CAPDyKFo9Bxremkb1dDrr4OcXSpE0keVze94Cm=zrkOVxHHxBmQ@mail.gmail.com/
> > > > > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > > > > Tested-by: Saravana Kannan <saravanak@google.com>
> > > >
> > > > Again, this looks like a nice solution to the problem.
> > > >
> > > > One question though. The Kconfig SIMPLE_PM_BUS, should probably be
> > > > "default y" - or something along those lines to make sure fw_devlink
> > > > works as expected.
> > >
> > > I would love for SIMPLE_PM_BUS to go away, and all of its functionality
> > > to be usurped by the standard simple-bus handling.
> > >
> > > In the modern world, everything uses power management and Runtime
> > > PM, and the distinction between "simple-bus" and "simple-pm-bus"
> > > is purely artificial.
> >
> > I think it's not that easy, but maybe I am wrong.
> >
> > Today we have an opt-in way of supporting runtime PM (and power
> > management). In most cases it's up to drivers or subsystem level code
> > to decide if runtime PM should be enabled for the device.
> >
> > Would it really be okay to enable runtime PM for all of them?
>
> You're talking about the software policy side.
>
> From my PoV, the issue is that this decision is leaked into DT, through
> the different compatible values ("simple-pm-bus" vs. "simple-bus").

Yes, I do agree with you there.

On the other hand, it's probably not the only place where it's used as
"software configuration", so I don't have a big issue with it.

Kind regards
Uffe
