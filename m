Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED5737F100
	for <lists+linux-kernel@lfdr.de>; Thu, 13 May 2021 03:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbhEMBqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 May 2021 21:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbhEMBqX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 May 2021 21:46:23 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07CDC06174A
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 18:45:12 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id c21so19821351pgg.3
        for <linux-kernel@vger.kernel.org>; Wed, 12 May 2021 18:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9OSOdifwJ/U6Y7EVaNtB+dGpCcruOcZL8rYhMqEey4=;
        b=Fr4qTZMcIVQwesgH7iOol4OkmW1/52NmyRhF1zWTYJmRVZh7G00+iiQr0xSE7Jn55R
         bSoByr7woQr/XQI3sZVzZJlUo7RlWqaDd1xyh6mCTJRUF+W2hoSl7SN9RdZnIq1w+HmM
         A4DBdX0Nx7PnFWJoZO+OXIARomsPVvsJ04ANA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9OSOdifwJ/U6Y7EVaNtB+dGpCcruOcZL8rYhMqEey4=;
        b=GCP52AaGHYIDW+VJF4E6hLk8p+Sf2vsf1fGrKRnr6csV3fRWUWLGfJQTkzG7BnKIQQ
         J6DoYpxn97N8ySMh/OJqc8bfIaLCd7nldw43ELkJ3sdDEZyaW5Pm/Gfr648rZZUO/p5O
         osZNfPIugglpsOHD18vI2PD8kKpU3dNYx5+gZONOGD/SjwbMbIuMG6JmH7bNc+LJKWae
         3T+uSk9cV84jBUimXWygyrqFmjkiNdwF3RhYeuQ1BDWCOuUonNW+x3PuODk2M4/VlIqz
         O24WHvykngxeVZwfmkPwVzMCYM/ngnHKLytVtd9QLAImrKB+hjW45Rj4YR9/V4BP2RnF
         VLAA==
X-Gm-Message-State: AOAM53018jbpKhJyavR3/YrDQaIR9izeTdrL4HTO25qKI9UveGC0w+rs
        /H06+bdLeBCBuYaHzWOoXsUYlzqQB9Mz9cPCo0g4SQ==
X-Google-Smtp-Source: ABdhPJx9FdyNW+2z7f/xqG8Mk4Yok0erOgCRj+tZ6RPtmwF2b1M4b7JDdPpu10FSJnZjOXEFDHY2ToGEW5Y+7H7xlX8=
X-Received: by 2002:a17:90a:4298:: with SMTP id p24mr1758687pjg.144.1620870312282;
 Wed, 12 May 2021 18:45:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210510092631.3141204-1-ikjn@chromium.org> <c5a253ba-6451-c538-39ea-c339c176afbb@gmail.com>
In-Reply-To: <c5a253ba-6451-c538-39ea-c339c176afbb@gmail.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Thu, 13 May 2021 09:45:01 +0800
Message-ID: <CAATdQgDfQUVQQwL1KQZvRffUgE+ADcwjBReWhCnmNL3SSgoE-A@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8183: add cbas node under cros_ec
To:     Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Hsinyi Wang <hsinyi@chromium.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 13, 2021 at 12:38 AM Matthias Brugger
<matthias.bgg@gmail.com> wrote:
>
> Hi Ikjoon,
>
> On 10/05/2021 11:26, Ikjoon Jang wrote:
> > Add a 'cbas' device node for supporting table mode switch in

tablet

> > kukui devices.
> >
> > Kukui platforms with detacheable base have an additional input
> > device under cros-ec, which reports SW_TABLET_MODE regarding
> > its base state (e.g. base flipped or detached).
> >
> > Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> > ---
> >
> >  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
> >  1 file changed, 4 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > index ff56bcfa3370..40030ed48854 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> > @@ -816,6 +816,10 @@ usbc_extcon: extcon0 {
> >                       compatible = "google,extcon-usbc-cros-ec";
> >                       google,usb-port-id = <0>;
> >               };
> > +
> > +             base_detection: cbas {
> > +                     compatible = "google,cros-cbas";
>
> I'm not able to find any binding description for this. It seems linux-next has
> driver binding to this compatible, but the description is missing.
>
> Can you please clarify.

Yep, that's correct.
Let me resend this with v2 after the dt-binding patch is applied.

In this series, I requested queueing these to hid tree:

[v5, 1/2] mfd: google,cros-ec: add DT bindings for a baseboard's switch device
https://patchwork.kernel.org/project/linux-input/patch/20210415032958.740233-2-ikjn@chromium.org/

[v5, 2/2] HID: google: Add of_match table to Whiskers switch device.
https://patchwork.kernel.org/project/linux-input/patch/20210415032958.740233-3-ikjn@chromium.org/

Later I found that I missed a comment from [v5, 1/2]
But only [v5, 2/2] part is already applied to hid tree as I asked for it.

I sent a v6 dt-binding patch is here (not yet applied)
https://patchwork.kernel.org/project/linux-input/patch/20210512100832.3878138-1-ikjn@chromium.org/

>
> Thanks,
> Mathias
>
> > +             };
> >       };
> >  };
> >
> >
