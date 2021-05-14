Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCD4D38083C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 May 2021 13:14:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232055AbhENLPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 May 2021 07:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbhENLPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 May 2021 07:15:50 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10EDC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:14:38 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d16so3673363pfn.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 May 2021 04:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AobE3rqWzAR5whOCqPuXrD/28KwqAfI01k8Xsr9LaIQ=;
        b=oYiFUcpoI5mc4qXcCTHNdjkzQyGcqlPV2dBqIpLLg1p1i6pV0e8esUCkHWl6GOs3+L
         HtrYY2xNR1Sob1F68xp3HluEr+snyZTiOYThD47YrOQv+cVfNsqWy/pMfe3aJIL5ZcQu
         R2X7KK4wFkgCHgxGRnnixEsSXJGGistXO3dc4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AobE3rqWzAR5whOCqPuXrD/28KwqAfI01k8Xsr9LaIQ=;
        b=ZrqroWVQKjkhrcvKY0lFf+M5TFiw0w5GCrH/RvxJHxuFixdMj7O9/T59STMvsiL9v4
         iaZQmfMHizk6FXeZhPno6AKJigXdF40oH4Ij1a1K8bbyL7YdCFqvWtPV/N/DwSTGbigg
         OlfD//DnE/PEoD2hVhD2XbAVRBjEojKM+Yv8XBxTfLEk9jTKKGvOAq2kgdUZ3IWDqo+Q
         P2/FzOcAxswqPrnDaDLRDolYRY36yIWzslHAUNSgveWTN8cuZTGhHUP1DtRLuvxn6sbq
         WaQfvs+kUHCp9FGC7kLkrcTa9LY6v5Q5q9YRMz3H0nzc5AAcJOW+LBmiTrHISkwIHLKJ
         4PiQ==
X-Gm-Message-State: AOAM533N45b+2SmiJVNDkDTUr9C9WvwVYhIkvbrvjaUv0NDLEbaEkMkb
        xJ/03TlPHcsdVwdPEmZSL/bGDvUVCbbGH0nusRZtpq+wY97ZmA==
X-Google-Smtp-Source: ABdhPJwjE+6SUc2igDiKD6aOkPfhQ+moPvTk2uBOhn2pCVuVe74ruIEn3ws/XYYPLnK6BryC/P/y8TZxqH/yf+1UFQc=
X-Received: by 2002:a63:8149:: with SMTP id t70mr46454849pgd.299.1620990878139;
 Fri, 14 May 2021 04:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <20210510092631.3141204-1-ikjn@chromium.org> <c5a253ba-6451-c538-39ea-c339c176afbb@gmail.com>
 <CAATdQgDfQUVQQwL1KQZvRffUgE+ADcwjBReWhCnmNL3SSgoE-A@mail.gmail.com> <daeb031a-1992-704b-49bf-c935078f15f8@collabora.com>
In-Reply-To: <daeb031a-1992-704b-49bf-c935078f15f8@collabora.com>
From:   Ikjoon Jang <ikjn@chromium.org>
Date:   Fri, 14 May 2021 19:14:27 +0800
Message-ID: <CAATdQgAK3VL69DuyWziYi=4ZTXTd1r7fuOXTHgw33Xu6HCvTXA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: mt8183: add cbas node under cros_ec
To:     Enric Balletbo i Serra <enric.balletbo@collabora.com>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Jiri Kosina <jikos@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Linux Input <linux-input@vger.kernel.org>,
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

On Fri, May 14, 2021 at 4:55 PM Enric Balletbo i Serra
<enric.balletbo@collabora.com> wrote:
>
> Hi Ikjoon,
>
> Thank you for the patch.
>
> On 13/5/21 3:45, Ikjoon Jang wrote:
> > On Thu, May 13, 2021 at 12:38 AM Matthias Brugger
> > <matthias.bgg@gmail.com> wrote:
> >>
> >> Hi Ikjoon,
> >>
> >> On 10/05/2021 11:26, Ikjoon Jang wrote:
> >>> Add a 'cbas' device node for supporting table mode switch in
> >
> > tablet
> >
> >>> kukui devices.
> >>>
> >>> Kukui platforms with detacheable base have an additional input
> >>> device under cros-ec, which reports SW_TABLET_MODE regarding
> >>> its base state (e.g. base flipped or detached).
> >>>
> >>> Signed-off-by: Ikjoon Jang <ikjn@chromium.org>
> >>> ---
> >>>
> >>>  arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi | 4 ++++
> >>>  1 file changed, 4 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> >>> index ff56bcfa3370..40030ed48854 100644
> >>> --- a/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> >>> +++ b/arch/arm64/boot/dts/mediatek/mt8183-kukui.dtsi
> >>> @@ -816,6 +816,10 @@ usbc_extcon: extcon0 {
> >>>                       compatible = "google,extcon-usbc-cros-ec";
> >>>                       google,usb-port-id = <0>;
> >>>               };
> >>> +
> >>> +             base_detection: cbas {
>
>
> This should be just cbas, remove base_detection. It was a bit confusing follow
> these series. If [v5, 2/2] is already applied in hid tree, I'd suggest send a v7
> version including:
>
> [v7, 1/2] mfd: google,cros-ec: add DT bindings for a baseboard's switch device
> [v7, 2/2] arm64: dts: mt8183: add cbas node under cros_ec

sure, let me upload v7 with dt-bindings + mt8183.dtsi together.

>
> Both patches can go through the Matthias tree, but the first one also needs an
> Ack from Lee Jones, MFD maintainer, which I think is not cc'ied, so unlikely to
> give you the needed ack.

Oops.. :-S
(Why did I think this should go through hid?)
Thanks a lot for pointing out the basic but critical mistake.

>
> Thanks,
>   Enric
>
>
> >>> +                     compatible = "google,cros-cbas";
> >>
> >> I'm not able to find any binding description for this. It seems linux-next has
> >> driver binding to this compatible, but the description is missing.
> >>
> >> Can you please clarify.
> >
> > Yep, that's correct.
> > Let me resend this with v2 after the dt-binding patch is applied.
> >
> > In this series, I requested queueing these to hid tree:
> >
> > [v5, 1/2] mfd: google,cros-ec: add DT bindings for a baseboard's switch device
> > https://patchwork.kernel.org/project/linux-input/patch/20210415032958.740233-2-ikjn@chromium.org/
> >
> > [v5, 2/2] HID: google: Add of_match table to Whiskers switch device.
> > https://patchwork.kernel.org/project/linux-input/patch/20210415032958.740233-3-ikjn@chromium.org/
> >
> > Later I found that I missed a comment from [v5, 1/2]
> > But only [v5, 2/2] part is already applied to hid tree as I asked for it.
> >
> > I sent a v6 dt-binding patch is here (not yet applied)
> > https://patchwork.kernel.org/project/linux-input/patch/20210512100832.3878138-1-ikjn@chromium.org/
> >
> >>
> >> Thanks,
> >> Mathias
> >>
> >>> +             };
> >>>       };
> >>>  };
> >>>
> >>>
