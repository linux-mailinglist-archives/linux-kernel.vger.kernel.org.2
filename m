Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5063CF5A9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jul 2021 10:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbhGTHU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jul 2021 03:20:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:45563 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229675AbhGTHUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jul 2021 03:20:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626768094;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LTrV5RbVeDNyG1pYgWpiiRkaajyN4AH34gq6Sc1Ja5U=;
        b=NnU2ZAi7Fgxdq1HPF8do9QLB25YnmCnNYvVftLS/Zw6RvH/lizgAfEvds++Jy7YiLXW1EL
        P4RtDsN9QAlyHWY26MJtDEsDGeR4eLE67jvgKr5hjqaV2IhxkuWzkKREEsNWZYZLG8eCti
        A9Yet7Zfi1+LfEfoQSCTY8nyxI53cdg=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-530-GTZjbMMZOZyqJa8T3g3FDw-1; Tue, 20 Jul 2021 04:01:32 -0400
X-MC-Unique: GTZjbMMZOZyqJa8T3g3FDw-1
Received: by mail-pj1-f70.google.com with SMTP id j11-20020a17090a840bb029017582e03c3bso1389401pjn.7
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jul 2021 01:01:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LTrV5RbVeDNyG1pYgWpiiRkaajyN4AH34gq6Sc1Ja5U=;
        b=TYF/Zs5u7IFM8cng7qjwpMFfjLbC/rMJ8CZDZI70mo6vVz0riI0jHfn11eNfLHCf0y
         opC7BfLuMUZm8c2GrAe3mjskkwuDTSixSTxN53Nk/FeE6J+ni2DKXRbUzwpb4hkITspA
         a/awRP6eEDD9O18ArqChxGh96He6lWWMRNd7BHTSZ/dzUFVBfeGl2Tr/81Inpj2MGJ4D
         toE6/Z75reTl+ssb0QjiNARFeR7Bdl23jI3CV3UYigOrzcuj1I7BE8hDGxq1DZ68895t
         CWB61PFSxN9qg4CT6Xm/m+vdSRJ60HHqRtTN++fxBOTAajHOnb53IR+3eRqWw+a5CgqJ
         2jWw==
X-Gm-Message-State: AOAM530ztbEJ7sBCZS5P8IRidbjjP+RwY8yYqHXHPREp35THzGfQoI5l
        IKXMm476JzZexgCxOSL0C6O3OWW6SAY1XABIuEC6DMrCQK5Pf828PklcgH/MKSoeiqMGquBzaQb
        xrV9gGuZuj34XMkbZ9ZDa6FPaa0wZKlEIlvc2iSeA
X-Received: by 2002:aa7:9687:0:b029:337:3b49:df24 with SMTP id f7-20020aa796870000b02903373b49df24mr21001798pfk.35.1626768091743;
        Tue, 20 Jul 2021 01:01:31 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/lz7xyoR5XNVuKo5OpMeCS8ZcA7bhLmy40KWtYzX4iPv/i5bUyo43tpWf+jLShuoE3NzooQDIy9RWJTynEGk=
X-Received: by 2002:aa7:9687:0:b029:337:3b49:df24 with SMTP id
 f7-20020aa796870000b02903373b49df24mr21001779pfk.35.1626768091519; Tue, 20
 Jul 2021 01:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210625081818.v2.1.I358cae5e33f742765fd38485d6ddf1a4a978644d@changeid>
 <nycvar.YFH.7.76.2107152150060.8253@cbobk.fhfr.pm>
In-Reply-To: <nycvar.YFH.7.76.2107152150060.8253@cbobk.fhfr.pm>
From:   Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date:   Tue, 20 Jul 2021 10:01:20 +0200
Message-ID: <CAO-hwJJp-qg0pRZNk1PKhha6S=Zd2_r1UDjZUgm9Yq0MFL69MQ@mail.gmail.com>
Subject: Re: [PATCH v2] HID: i2c-hid: goodix: Tie the reset line to true state
 of the regulator
To:     Jiri Kosina <jikos@kernel.org>
Cc:     Douglas Anderson <dianders@chromium.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 15, 2021 at 9:50 PM Jiri Kosina <jikos@kernel.org> wrote:
>
> On Fri, 25 Jun 2021, Douglas Anderson wrote:
>
> > The regulator for the touchscreen could be:
> > * A dedicated regulator just for the touchscreen.
> > * A regulator shared with something else in the system.
> > * An always-on regulator.
> >
> > How we want the "reset" line to behave depends a bit on which of those
> > three cases we're in. Currently the code is written with the
> > assumption that it has a dedicated regulator, but that's not really
> > guaranteed to be the case.
> >
> > The problem we run into is that if we leave the touchscreen powered on
> > (because someone else is requesting the regulator or it's an always-on
> > regulator) and we assert reset then we apparently burn an extra 67 mW
> > of power. That's not great.
> >
> > Let's instead tie the control of the reset line to the true state of
> > the regulator as reported by regulator notifiers. If we have an
> > always-on regulator our notifier will never be called. If we have a
> > shared regulator then our notifier will be called when the touchscreen
> > is truly turned on or truly turned off.
> >
> > Using notifiers like this nicely handles all the cases without
> > resorting to hacks like pretending that there is no "reset" GPIO if we
> > have an always-on regulator.
> >
> > NOTE: if the regulator is on a shared line it's still possible that
> > things could be a little off. Specifically, this case is not handled
> > even after this patch:
> > 1. Suspend goodix (send "sleep", goodix stops requesting regulator on)
> > 2. Other regulator user turns off (regulator fully turns off).
> > 3. Goodix driver gets notified and asserts reset.
> > 4. Other regulator user turns on.
> > 5. Goodix driver gets notified and deasserts reset.
> > 6. Nobody resumes goodix.
> >
> > With that set of steps we'll have reset deasserted but we will have
> > lost the results of the I2C_HID_PWR_SLEEP from the suspend path. That
> > means we might be in higher power than we could be even if the goodix
> > driver thinks things are suspended. Presumably, however, we're still
> > in better shape than if we were asserting "reset" the whole time. If
> > somehow the above situation is actually affecting someone and we want
> > to do better we can deal with it when we have a real use case.
> >
> > Signed-off-by: Douglas Anderson <dianders@chromium.org>
>
> Applied, thanks Doug.

Thanks Jiri for taking this one in.

FWIW, I am really glad Doug made the effort of splitting i2c-hid-core
and i2c-hid-goodix, because this is the kind of patch that would have
been a nightmare to make it generic :)

Cheers,
Benjamin

>
> --
> Jiri Kosina
> SUSE Labs
>

